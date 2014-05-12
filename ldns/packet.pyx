from ldns.packet cimport *
from ldns.errors import LDNSStatusError
from ldns.errors cimport LDNS_STATUS_OK
from ldns.resourcerecord cimport ldns_rr, ldns_rr_list, _rr_list_to_plist, _plist_to_rr_list
from ldns.resourcerecord cimport ResourceRecord, ResourceRecord_create
from ldns.rdata cimport ResourceData, ResourceData_create


def query_packet_from_str(str name, int rr_type, int rr_class, int flags):
    cdef ldns_pkt* _pkt = ldns_pkt_new()
    status = ldns_pkt_query_new_frm_str(&_pkt,
        <bytes?>name, <ldns_rr_type?>rr_type, <ldns_rr_class?>rr_class, <uint16_t?>flags)

    if status != LDNS_STATUS_OK:
        raise LDNSStatusError(status)

    return Packet_create(_pkt)

cdef class Packet:
    def __cinit__(self):
        self._pkt = ldns_pkt_new()

    def __dealloc__(self):
        if self._pkt is not NULL:
            ldns_pkt_free(self._pkt)

    # New from...
    def __init__(self, *args, **kwargs):
        pass

    def __contains__(self, object other):
        cdef ldns_rr* _rr = NULL

        if isinstance(other, ResourceRecord):
            ret = ldns_pkt_rr(self._pkt, LDNS_SECTION_ANY, <ldns_rr*>other._rr)
            return ret

    cdef Packet _setup(self, ldns_pkt* pkt):
        self._pkt = pkt
        return self

    def clone(self):
        return Packet_create(self._pkt)

    # Property definitions
    property id:
        def __get__(self):
            return <int?>ldns_pkt_id(self._pkt)

        def __set__(self, int value):
            ldns_pkt_set_id(self._pkt, <uint16_t?>value)

    property qr:
        def __get__(self):
            return <bint?>ldns_pkt_qr(self._pkt)

        def __set__(self, bint value):
            ldns_pkt_set_qr(self._pkt, <bint?>value)

    property aa:
        def __get__(self):
            return <bint?>ldns_pkt_aa(self._pkt)

        def __set__(self, bint value):
            ldns_pkt_set_aa(self._pkt, <bint?>value)

    property tc:
        def __get__(self):
            return <bint?>ldns_pkt_tc(self._pkt)

        def __set__(self, bint value):
            ldns_pkt_set_tc(self._pkt, <bint?>value)

    property rd:
        def __get__(self):
            return <bint?>ldns_pkt_rd(self._pkt)

        def __set__(self, bint value):
            ldns_pkt_set_rd(self._pkt, <bint?>value)

    property cd:
        def __get__(self):
            return <bint?>ldns_pkt_cd(self._pkt)

        def __set__(self, bint value):
            ldns_pkt_set_cd(self._pkt, <bint?>value)

    property ra:
        def __get__(self):
            return <bint?>ldns_pkt_ra(self._pkt)

        def __set__(self, bint value):
            ldns_pkt_set_ra(self._pkt, <bint?>value)

    property ad:
        def __get__(self):
            return <bint?>ldns_pkt_ad(self._pkt)

        def __set__(self, bint value):
            ldns_pkt_set_ad(self._pkt, <bint?>value)

    property opcode:
        def __get__(self):
            return <int?>ldns_pkt_get_opcode(self._pkt)

        def __set__(self, int value):
            ldns_pkt_set_opcode(self._pkt, <ldns_pkt_opcode?>value)

    property rcode:
        def __get__(self):
            return <int?>ldns_pkt_get_rcode(self._pkt)

        def __set__(self, int value):
            ldns_pkt_set_rcode(self._pkt, <ldns_pkt_rcode?>value)

    property qd_count:
        def __get__(self):
            return <int?>ldns_pkt_qdcount(self._pkt)

        def __set__(self, int value):
            ldns_pkt_set_qdcount(self._pkt, <uint16_t?>value)

    property an_count:
        def __get__(self):
            return <int?>ldns_pkt_ancount(self._pkt)

        def __set__(self, int value):
            ldns_pkt_set_ancount(self._pkt, <uint16_t?>value)

    property ns_count:
        def __get__(self):
            return <int?>ldns_pkt_nscount(self._pkt)

        def __set__(self, int value):
            ldns_pkt_set_nscount(self._pkt, <uint16_t?>value)

    property ar_count:
        def __get__(self):
            return <int?>ldns_pkt_arcount(self._pkt)

        def __set__(self, int value):
            ldns_pkt_set_arcount(self._pkt, <uint16_t?>value)

    property answerfrom:
        def __get__(self):
            cdef ResourceData rdf = ResourceData_create(ldns_pkt_answerfrom(self._pkt))
            return rdf

        def __set__(self, ResourceData value):
            ldns_pkt_set_answerfrom(self._pkt, value._rdf)

    # property timestamp:
    #     def __get__(self):
    #         return <object?>ldns_pkt_timestamp(self._pkt)

    #     def __set__(self, object value):
    #         ldns_pkt_set_timestamp(self._pkt, <timeval?>value)

    property querytime:
        def __get__(self):
            return <int?>ldns_pkt_querytime(self._pkt)

        def __set__(self, int value):
            ldns_pkt_set_querytime(self._pkt, <uint32_t?>value)

    property size:
        def __get__(self):
            return <int?>ldns_pkt_size(self._pkt)

        def __set__(self, int value):
            ldns_pkt_set_size(self._pkt, <size_t?>value)

    property tsig:
        def __get__(self):
            cdef ResourceRecord rdf = ResourceRecord_create(ldns_pkt_tsig(self._pkt))
            return rdf

        def __set__(self, ResourceRecord value):
            ldns_pkt_set_tsig(self._pkt, value._rr)

    property question:
        def __get__(self):
            cdef ldns_rr_list* ret = ldns_pkt_question(self._pkt)
            return _rr_list_to_plist(ret)

        def __set__(self, list value):
            cdef ldns_rr_list* rr_list = _plist_to_rr_list(value)
            ldns_pkt_set_question(self._pkt, rr_list)

    property answer:
        def __get__(self):
            cdef ldns_rr_list* ret = ldns_pkt_answer(self._pkt)
            return _rr_list_to_plist(ret)

        def __set__(self, list value):
            cdef ldns_rr_list* rr_list = _plist_to_rr_list(value)
            ldns_pkt_set_answer(self._pkt, rr_list)

    property authority:
        def __get__(self):
            cdef ldns_rr_list* ret = ldns_pkt_authority(self._pkt)
            return _rr_list_to_plist(ret)

        def __set__(self, list value):
            cdef ldns_rr_list* rr_list = _plist_to_rr_list(value)
            ldns_pkt_set_authority(self._pkt, rr_list)

    property additional:
        def __get__(self):
            cdef ldns_rr_list* ret = ldns_pkt_additional(self._pkt)
            return _rr_list_to_plist(ret)

        def __set__(self, list value):
            cdef ldns_rr_list* rr_list = _plist_to_rr_list(value)
            ldns_pkt_set_additional(self._pkt, rr_list)

    property edns_udp_size:
        def __get__(self):
            return <int?>ldns_pkt_edns_udp_size(self._pkt)

        def __set__(self, int value):
            ldns_pkt_set_edns_udp_size(self._pkt, <uint16_t?>value)

    property edns_extended_rcode:
        def __get__(self):
            return <int?>ldns_pkt_edns_extended_rcode(self._pkt)

        def __set__(self, int value):
            ldns_pkt_set_edns_extended_rcode(self._pkt, <uint8_t?>value)

    property edns_version:
        def __get__(self):
            return <int?>ldns_pkt_edns_version(self._pkt)

        def __set__(self, int value):
            ldns_pkt_set_edns_version(self._pkt, <uint8_t?>value)

    property edns_z:
        def __get__(self):
            return <int?>ldns_pkt_edns_z(self._pkt)

        def __set__(self, int value):
            ldns_pkt_set_edns_z(self._pkt, <uint16_t?>value)

    property edns_data:
        def __get__(self):
            cdef ResourceData rdf = ResourceData_create(ldns_pkt_edns_data(self._pkt))
            return rdf

        def __set__(self, ResourceData value):
            ldns_pkt_set_edns_data(self._pkt, value._rdf)

    property edns_do:
        def __get__(self):
            return <bint?>ldns_pkt_edns_do(self._pkt)

        def __set__(self, bint value):
            ldns_pkt_set_edns_do(self._pkt, <bint?>value)

    property reply_type:
        def __get__(self):
            return <int?>ldns_pkt_reply_type(self._pkt)

    property edns:
        def __get__(self):
            return <bint?>ldns_pkt_edns(self._pkt)

    # Functions
    def is_empty(self):
        return ldns_pkt_empty(self._pkt)

    def set_random_id(self):
        ldns_pkt_set_random_id(self._pkt)

    def set_flags(self, int flags):
        if not ldns_pkt_set_flags(self._pkt, flags):
            raise Exception()

    def get_section_count(self, int section):
        return <int?>ldns_pkt_section_count(self._pkt, <ldns_pkt_section?>section)

    def set_section_count(self, int section, int value):
        ldns_pkt_set_section_count(self._pkt, <ldns_pkt_section?>section, <uint16_t?>value)

    def all(self, include_question=True):
        cdef ldns_rr_list* rr_list = NULL

        if include_question:
            rr_list = ldns_pkt_all(self._pkt)
        else:
            rr_list = ldns_pkt_all_noquestion(self._pkt)
        return _rr_list_to_plist(rr_list)

    def get_rr_by_name(self, str name, int section):
        raise NotImplementedError()

    def get_rr_by_type(self, int type, int section):
        cdef ldns_rr_list* rr_list = ldns_pkt_rr_list_by_type(self._pkt, <ldns_rr_type>type, <ldns_pkt_section>section)

        return _rr_list_to_plist(rr_list)

    def get_rr_by_type_and_name(self, str name, int type, int section):
        raise NotImplementedError()

    def push_rr(self, ResourceRecord rr, int section, safe=False):
        cdef ldns_rr* _rr = rr._rr

        if safe:
            ldns_pkt_safe_push_rr(self._pkt, <ldns_pkt_section>section, _rr)
        else:
            ldns_pkt_push_rr(self._pkt, <ldns_pkt_section>section, _rr)

    def push_rr_list(self, section, rr_list, safe=False):
        if safe:
            ldns_pkt_safe_push_rr_list(self._pkt, section, <ldns_rr_list*>rr_list)
        else:
            ldns_pkt_push_rr_list(self._pkt, section, <ldns_rr_list*>rr_list)

cdef Packet Packet_create(ldns_pkt* pkt):
    return Packet()._setup(pkt)
