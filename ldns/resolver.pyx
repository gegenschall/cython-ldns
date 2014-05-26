from libc.stdio cimport FILE, fdopen
from libc.stdlib cimport malloc, free

from ldns.resolver cimport *
from ldns.packet cimport Packet
from ldns.errors cimport LDNS_STATUS_OK, ldns_status
from ldns.resourcerecord cimport LDNS_RR_TYPE_A, LDNS_RR_CLASS_IN, ResourceRecord_create
from ldns.resourcerecord cimport _rr_list_to_plist, _plist_to_rr_list, ldns_rr_list_free, ldns_rr_list_new
from ldns.rdata cimport ldns_rdf, ldns_rdf_free, ldns_rdf_new_frm_str, LDNS_RDF_TYPE_A
from ldns.dname cimport ldns_dname_new_frm_str
from ldns.conversion cimport ldns_rdf2str

from ldns.errors import LDNSStatusError

PROTO_NO_PREF = 0
PROTO_USE_IPV4 = 1
PROTO_USE_IPV6 = 2

def resolver_from_file(str filename):
    cdef ldns_status status
    cdef FILE* fp

    cdef Resolver r = Resolver()

    with open(filename, 'rb') as f:
        fp = fdopen(f.fileno(), 'rb')
        status = ldns_resolver_new_frm_fp(&r._resolver, fp)

    if status != LDNS_STATUS_OK:
        raise LDNSStatusError(status)

    return r

cdef class Resolver:
    def __cinit__(self, *args, **kwargs):
        self._resolver = ldns_resolver_new()

    def __dealloc__(self):
        ldns_resolver_free(self._resolver)

        self._resolver = NULL

    def __init__(self, *args, **kwargs):
        pass

    cdef Resolver _setup(self, ldns_resolver* resolver):
        self._resolver = resolver
        return self

    property port:
        def __get__(self):
            return <int?>ldns_resolver_port(self._resolver)

        def __set__(self, int value):
            ldns_resolver_set_port(self._resolver, <uint16_t?>value)

    property source:
        def __get__(self):
            cdef ldns_rdf* rdf = ldns_resolver_source(self._resolver)
            address = <bytes?>ldns_rdf2str(rdf)

            ldns_rdf_free(rdf)

            return address

        def __set__(self, str value):
            cdef ldns_rdf* rdf = ldns_rdf_new_frm_str(LDNS_RDF_TYPE_A, <bytes?>value)
            ldns_resolver_set_source(self._resolver, rdf)

    property recursive:
        def __get__(self):
            return <bint?>ldns_resolver_recursive(self._resolver)

        def __set__(self, bint value):
            ldns_resolver_set_recursive(self._resolver, <bint?>value)

    property debug:
        def __get__(self):
            return <bint?>ldns_resolver_debug(self._resolver)

        def __set__(self, bint value):
            ldns_resolver_set_debug(self._resolver, <bint?>value)

    property retry:
        def __get__(self):
            return <int?>ldns_resolver_retry(self._resolver)

        def __set__(self, int value):
            ldns_resolver_set_retry(self._resolver, <uint8_t?>value)

    property retrans:
        def __get__(self):
            return <int?>ldns_resolver_retrans(self._resolver)

        def __set__(self, int value):
            ldns_resolver_set_retrans(self._resolver, <uint8_t?>value)

    property fallback:
        def __get__(self):
            return <bint?>ldns_resolver_fallback(self._resolver)

        def __set__(self, bint value):
            ldns_resolver_set_fallback(self._resolver, <bint?>value)

    property ip6:
        def __get__(self):
            return <int?>ldns_resolver_ip6(self._resolver)

        def __set__(self, int value):
            ldns_resolver_set_ip6(self._resolver, <uint8_t?>value)

    property edns_udp_size:
        def __get__(self):
            return <int?>ldns_resolver_edns_udp_size(self._resolver)

        def __set__(self, int value):
            ldns_resolver_set_edns_udp_size(self._resolver, <uint16_t?>value)

    property usevc:
        def __get__(self):
            return <bint?>ldns_resolver_usevc(self._resolver)

        def __set__(self, bint value):
            ldns_resolver_set_usevc(self._resolver, <bint?>value)

    property fail:
        def __get__(self):
            return <bint?>ldns_resolver_fail(self._resolver)

        def __set__(self, bint value):
            ldns_resolver_set_fail(self._resolver, <bint?>value)

    property defnames:
        def __get__(self):
            return <bint?>ldns_resolver_defnames(self._resolver)

        def __set__(self, bint value):
            ldns_resolver_set_defnames(self._resolver, <bint?>value)

    property dnsrch:
        def __get__(self):
            return <bint?>ldns_resolver_dnsrch(self._resolver)

        def __set__(self, bint value):
            ldns_resolver_set_dnsrch(self._resolver, <bint?>value)

    property dnssec:
        def __get__(self):
            return <bint?>ldns_resolver_dnssec(self._resolver)

        def __set__(self, bint value):
            ldns_resolver_set_dnssec(self._resolver, <bint?>value)

    property dnssec_cd:
        def __get__(self):
            return <bint?>ldns_resolver_dnssec_cd(self._resolver)

        def __set__(self, bint value):
            ldns_resolver_set_dnssec_cd(self._resolver, <bint?>value)

    property dnssec_anchors:
        def __get__(self):
            cdef ldns_rr_list *rr_list = ldns_resolver_dnssec_anchors(self._resolver)
            ret = _rr_list_to_plist(rr_list)

            # Do not deep free, the items in it are bound to the resolver
            ldns_rr_list_free(rr_list)

            return ret

        def __set__(self, list value):
            cdef ldns_rr_list* rr_list = _plist_to_rr_list(value)
            ldns_resolver_set_dnssec_anchors(self._resolver, rr_list)

    property igntc:
        def __get__(self):
            return <bint?>ldns_resolver_igntc(self._resolver)

        def __set__(self, bint value):
            ldns_resolver_set_igntc(self._resolver, <bint?>value)

    property random:
        def __get__(self):
            return <bint?>ldns_resolver_random(self._resolver)

        def __set__(self, bint value):
            ldns_resolver_set_random(self._resolver, <bint?>value)

    property nameserver_count:
        def __get__(self):
            return <int?>ldns_resolver_nameserver_count(self._resolver)

        def __set__(self, int value):
            ldns_resolver_set_nameserver_count(self._resolver, <size_t?>value)

    property domain:
        def __get__(self):
            cdef char* domain = ldns_rdf2str(ldns_resolver_domain(self._resolver))
            return <bytes?>domain

        def __set__(self, str value):
            cdef ldns_rdf* domain = ldns_dname_new_frm_str(<bytes?>value)
            ldns_resolver_set_domain(self._resolver, domain)

    property timeout:
        def __get__(self):
            cdef timeval tv = ldns_resolver_timeout(self._resolver)
            return <int?>tv.tv_sec

        def __set__(self, int value):
            cdef timeval tv
            tv.tv_sec = <time_t?>value
            tv.tv_usec = 0
            ldns_resolver_set_timeout(self._resolver, tv)

    property rtt:
        def __get__(self):
            return <int?>ldns_resolver_rtt(self._resolver)

        def __set__(self, int value):
            ldns_resolver_set_rtt(self._resolver, <size_t*>value)

    property tsig_keyname:
        def __get__(self):
            return <bytes?>ldns_resolver_tsig_keyname(self._resolver)

        def __set__(self, str value):
            ldns_resolver_set_tsig_keyname(self._resolver, <bytes?>value)

    property tsig_algorithm:
        def __get__(self):
            return <bytes?>ldns_resolver_tsig_algorithm(self._resolver)

        def __set__(self, str value):
            ldns_resolver_set_tsig_algorithm(self._resolver, <bytes?>value)

    property tsig_keydata:
        def __get__(self):
            return <bytes?>ldns_resolver_tsig_keydata(self._resolver)

        def __set__(self, str value):
            ldns_resolver_set_tsig_keydata(self._resolver, <bytes?>value)

    property nameservers:
        def __get__(self):
            cdef int count = ldns_resolver_nameserver_count(self._resolver)
            cdef ldns_rdf** nameservers = ldns_resolver_nameservers(self._resolver)

            ret = []

            for i in range(count):
                ret.append(ldns_rdf2str(nameservers[i]))

            return ret

        def __set__(self, object nameservers):
            if not isinstance(nameservers, list):
                raise TypeError("Nameservers need to be a list.")

            # Pop all nameservers, so they get freed.
            cdef int count = ldns_resolver_nameserver_count(self._resolver)
            for i in range(count):
                ldns_resolver_pop_nameserver(self._resolver)

            cdef ldns_rdf* nameserver
            count = len(nameservers)
            for i in range(count):
                nameserver = ldns_rdf_new_frm_str(LDNS_RDF_TYPE_A, nameservers[i])
                ldns_resolver_push_nameserver(self._resolver, nameserver)

    property searchlist:
        def __get__(self):
            raise NotImplementedError()

        def __set__(self, object value):
            raise NotImplementedError()

    def get_nameserver_rtt(self, int position):
        return <int?>ldns_resolver_nameserver_rtt(self._resolver, <size_t?>position)

    def set_nameserver_rtt(self, int position, int value):
        ldns_resolver_set_nameserver_rtt(self._resolver, <size_t?>position, <size_t?>value)

    def search(self, str query, int qtype=LDNS_RR_TYPE_A, int qclass=LDNS_RR_CLASS_IN, int flags=0):
        cdef Packet pkt = Packet()
        cdef ldns_status status
        cdef ldns_rdf* rdf = ldns_dname_new_frm_str(<bytes?>query)

        status = ldns_resolver_search_status(&pkt._pkt, self._resolver, rdf,
            <ldns_rr_type?>qtype, <ldns_rr_class?>qclass, <uint16_t?>flags)

        ldns_rdf_free(rdf)

        if status != LDNS_STATUS_OK:
            raise LDNSStatusError(status)

        return pkt

    def prepare_query_packet(self, str name, int qtype=LDNS_RR_TYPE_A, int qclass=LDNS_RR_CLASS_IN, int flags=0):
        cdef Packet pkt = Packet()
        cdef ldns_status status
        cdef ldns_rdf* rdf = ldns_dname_new_frm_str(<bytes?>name)

        status = ldns_resolver_prepare_query_pkt(&pkt._pkt, self._resolver, rdf,
            <ldns_rr_type?>qtype, <ldns_rr_class?>qclass, <uint16_t?>flags)

        ldns_rdf_free(rdf)

        if status != LDNS_STATUS_OK:
            raise LDNSStatusError(status)

        return pkt

    def send(self, str name, int qtype=LDNS_RR_TYPE_A, int qclass=LDNS_RR_CLASS_IN, int flags=0):
        cdef Packet pkt = Packet()
        cdef ldns_status status
        cdef ldns_rdf* rdf = ldns_dname_new_frm_str(<bytes?>name)

        status = ldns_resolver_send(&pkt._pkt, self._resolver, rdf,
            <ldns_rr_type?>qtype, <ldns_rr_class?>qclass, <uint16_t?>flags)

        ldns_rdf_free(rdf)

        if status != LDNS_STATUS_OK:
            raise LDNSStatusError(status)

        return pkt

    def send_packet(self, Packet packet):
        cdef Packet pkt = Packet()
        cdef ldns_status status

        status = ldns_resolver_send_pkt(&pkt._pkt, self._resolver, packet._pkt)

        if status != LDNS_STATUS_OK:
            raise LDNSStatusError(status)

        return pkt

    def query(self, str name, int qtype=LDNS_RR_TYPE_A, int qclass=LDNS_RR_CLASS_IN, int flags=0):
        cdef Packet pkt = Packet()
        cdef ldns_status status
        cdef ldns_rdf* rdf = ldns_dname_new_frm_str(<bytes?>name)

        status = ldns_resolver_query_status(&pkt._pkt, self._resolver, rdf,
            <ldns_rr_type?>qtype, <ldns_rr_class?>qclass, <uint16_t?>flags)

        ldns_rdf_free(rdf)

        if status != LDNS_STATUS_OK:
            raise LDNSStatusError(status)

        return pkt

    def randomize_nameservers(self):
        ldns_resolver_nameservers_randomize(self._resolver)

    def get_trusted_key(self, list keys):
        cdef ldns_rr_list* _keys = _plist_to_rr_list(keys)
        cdef ldns_rr_list* trusted_keys = ldns_rr_list_new()

        ret = None
        if ldns_resolver_trusted_key(self._resolver, _keys, trusted_keys):
            ret = _rr_list_to_plist(trusted_keys)

        ldns_rr_list_free(trusted_keys)

        return ret

    def axfr(self, str domain, int qclass=LDNS_RR_CLASS_IN):
        cdef ldns_rr* rr = NULL
        cdef ldns_rdf* rdf = ldns_dname_new_frm_str(<bytes?>domain)
        cdef ldns_status status = ldns_axfr_start(self._resolver, rdf, <ldns_rr_class?>qclass)

        if status != LDNS_STATUS_OK:
            ldns_rdf_free(rdf)
            raise LDNSStatusError(status)

        while not ldns_axfr_complete(self._resolver):
            rr = ldns_axfr_next(self._resolver)

            yield ResourceRecord_create(rr)

cdef Resolver_create(ldns_resolver *resolver):
    return Resolver(0, 0, None)._setup(resolver)
