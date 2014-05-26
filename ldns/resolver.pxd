from libc.stdint cimport *
from libc.stdio cimport FILE

from ldns.rdata cimport ldns_rdf
from ldns.packet cimport ldns_pkt
from ldns.types cimport timeval, time_t
from ldns.errors cimport ldns_status
from ldns.resourcerecord cimport ldns_rr, ldns_rr_list, ldns_rr_class, ldns_rr_type

cdef extern from "ldns/resolver.h":
    cdef struct ldns_struct_resolver:
        pass
    ctypedef ldns_struct_resolver ldns_resolver

    # malloc&free
    ldns_resolver* ldns_resolver_new()
    ldns_status ldns_resolver_new_frm_fp(ldns_resolver **r, FILE *fp)
    void ldns_resolver_free(ldns_resolver *res)
    void ldns_resolver_deep_free(ldns_resolver *res)

    # getters and setters pairs
    uint16_t ldns_resolver_port(const ldns_resolver *r)
    ldns_rdf *ldns_resolver_source(const ldns_resolver *r)
    bint ldns_resolver_recursive(const ldns_resolver *r)
    bint ldns_resolver_debug(const ldns_resolver *r)
    uint8_t ldns_resolver_retry(const ldns_resolver *r)
    uint8_t ldns_resolver_retrans(const ldns_resolver *r)
    bint ldns_resolver_fallback(const ldns_resolver *r)
    uint8_t ldns_resolver_ip6(const ldns_resolver *r)
    uint16_t ldns_resolver_edns_udp_size(const ldns_resolver *r)
    bint ldns_resolver_usevc(const ldns_resolver *r)
    bint ldns_resolver_fail(const ldns_resolver *r)
    bint ldns_resolver_defnames(const ldns_resolver *r)
    bint ldns_resolver_dnsrch(const ldns_resolver *r)
    bint ldns_resolver_dnssec(const ldns_resolver *r)
    bint ldns_resolver_dnssec_cd(const ldns_resolver *r)
    ldns_rr_list * ldns_resolver_dnssec_anchors(const ldns_resolver *r)
    bint ldns_resolver_igntc(const ldns_resolver *r)
    bint ldns_resolver_random(const ldns_resolver *r)
    size_t ldns_resolver_nameserver_count(const ldns_resolver *r)
    ldns_rdf *ldns_resolver_domain(const ldns_resolver *r)
    timeval ldns_resolver_timeout(const ldns_resolver *r)
    size_t * ldns_resolver_rtt(const ldns_resolver *r)
    size_t ldns_resolver_nameserver_rtt(const ldns_resolver *r, size_t pos)
    char *ldns_resolver_tsig_keyname(const ldns_resolver *r)
    char *ldns_resolver_tsig_algorithm(const ldns_resolver *r)
    char *ldns_resolver_tsig_keydata(const ldns_resolver *r)
    ldns_rdf** ldns_resolver_nameservers(const ldns_resolver *r)

    void ldns_resolver_set_port(ldns_resolver *r, uint16_t p)
    void ldns_resolver_set_source(ldns_resolver *r, ldns_rdf *s)
    void ldns_resolver_set_recursive(ldns_resolver *r, bint b)
    void ldns_resolver_set_debug(ldns_resolver *r, bint b)
    void ldns_resolver_set_retry(ldns_resolver *r, uint8_t re)
    void ldns_resolver_set_retrans(ldns_resolver *r, uint8_t re)
    void ldns_resolver_set_fallback(ldns_resolver *r, bint fallback)
    void ldns_resolver_set_ip6(ldns_resolver *r, uint8_t i)
    void ldns_resolver_set_edns_udp_size(ldns_resolver *r, uint16_t s)
    void ldns_resolver_set_usevc(ldns_resolver *r, bint b)
    void ldns_resolver_set_fail(ldns_resolver *r, bint b)
    void ldns_resolver_set_defnames(ldns_resolver *r, bint b)
    void ldns_resolver_set_dnsrch(ldns_resolver *r, bint b)
    void ldns_resolver_set_dnssec(ldns_resolver *r, bint b)
    void ldns_resolver_set_dnssec_cd(ldns_resolver *r, bint b)
    void ldns_resolver_set_dnssec_anchors(ldns_resolver *r, ldns_rr_list * l)
    void ldns_resolver_set_igntc(ldns_resolver *r, bint b)
    void ldns_resolver_set_random(ldns_resolver *r, bint b)
    void ldns_resolver_set_nameserver_count(ldns_resolver *r, size_t c)
    void ldns_resolver_set_domain(ldns_resolver *r, ldns_rdf *rd)
    void ldns_resolver_set_timeout(ldns_resolver *r, timeval timeout)
    void ldns_resolver_set_rtt(ldns_resolver *r, size_t *rtt)
    void ldns_resolver_set_nameserver_rtt(ldns_resolver *r, size_t pos, size_t value)
    void ldns_resolver_set_tsig_keyname(ldns_resolver *r, char *tsig_keyname)
    void ldns_resolver_set_tsig_algorithm(ldns_resolver *r, char *tsig_algorithm)
    void ldns_resolver_set_tsig_keydata(ldns_resolver *r, char *tsig_keydata)
    void ldns_resolver_set_nameservers(ldns_resolver *r, ldns_rdf **rd)

    ldns_rdf** ldns_resolver_searchlist(const ldns_resolver *r)
    void ldns_resolver_push_searchlist(ldns_resolver *r, ldns_rdf *rd)

    ldns_status ldns_resolver_push_dnssec_anchor(ldns_resolver *r, ldns_rr *rr)

    ldns_rdf* ldns_resolver_pop_nameserver(ldns_resolver *r)
    ldns_status ldns_resolver_push_nameserver(ldns_resolver *r, ldns_rdf *n)

    # search & query functions
    ldns_status ldns_resolver_search_status(ldns_pkt** pkt, ldns_resolver *r, const ldns_rdf *rdf, ldns_rr_type t, ldns_rr_class c, uint16_t flags)
    ldns_status ldns_resolver_prepare_query_pkt(ldns_pkt **q, ldns_resolver *r, const  ldns_rdf *name, ldns_rr_type t, ldns_rr_class c, uint16_t f)
    ldns_status ldns_resolver_send(ldns_pkt **answer, ldns_resolver *r, const ldns_rdf *name, ldns_rr_type t, ldns_rr_class c, uint16_t flags)
    ldns_status ldns_resolver_send_pkt(ldns_pkt **answer, ldns_resolver *r, ldns_pkt *query_pkt)
    ldns_status ldns_resolver_query_status(ldns_pkt** pkt, ldns_resolver *r, const ldns_rdf *name, ldns_rr_type t, ldns_rr_class c, uint16_t flags)
    void ldns_resolver_nameservers_randomize(ldns_resolver *r)
    bint ldns_resolver_trusted_key(const ldns_resolver *r, ldns_rr_list * keys, ldns_rr_list * trusted_keys)

    # axfr stuff. make this a generator
    ldns_rr* ldns_axfr_next(ldns_resolver *resolver)
    bint ldns_axfr_complete(const ldns_resolver *resolver)

cdef extern from "ldns/net.h":
    ldns_status ldns_axfr_start(ldns_resolver *resolver, ldns_rdf *domain, ldns_rr_class klass)

cdef class Resolver:
    cdef ldns_resolver* _resolver

    cdef Resolver _setup(self, ldns_resolver* resolver)

cdef Resolver_create(ldns_resolver* resolver)
