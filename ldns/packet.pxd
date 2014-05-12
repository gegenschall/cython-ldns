from libc.stdint cimport *

from ldns.resourcerecord cimport ldns_rr, ldns_rr_list, ldns_rr_type, ldns_rr_class
from ldns.rdata cimport ldns_rdf
from ldns.errors cimport ldns_status
from ldns.types cimport timeval

cdef extern from "ldns/packet.h":
    cdef struct ldns_struct_pkt:
        pass
    ctypedef ldns_struct_pkt ldns_pkt

    cdef struct ldns_struct_hdr:
        pass
    ctypedef ldns_struct_hdr ldns_hdr

    cdef enum ldns_enum_pkt_opcode:
        LDNS_PACKET_QUERY
        LDNS_PACKET_IQUERY
        LDNS_PACKET_STATUS
        LDNS_PACKET_NOTIFY
        LDNS_PACKET_UPDATE
    ctypedef ldns_enum_pkt_opcode ldns_pkt_opcode

    cdef enum ldns_enum_pkt_rcode:
        LDNS_RCODE_NOERROR
        LDNS_RCODE_FORMERR
        LDNS_RCODE_SERVFAIL
        LDNS_RCODE_NXDOMAIN
        LDNS_RCODE_NOTIMPL
        LDNS_RCODE_REFUSED
        LDNS_RCODE_YXDOMAIN
        LDNS_RCODE_YXRRSET
        LDNS_RCODE_NXRRSET
        LDNS_RCODE_NOTAUTH
        LDNS_RCODE_NOTZONE
    ctypedef ldns_enum_pkt_rcode ldns_pkt_rcode

    cdef enum ldns_enum_pkt_section:
        LDNS_SECTION_QUESTION
        LDNS_SECTION_ANSWER
        LDNS_SECTION_AUTHORITY
        LDNS_SECTION_ADDITIONAL
        LDNS_SECTION_ANY
        LDNS_SECTION_ANY_NOQUESTION
    ctypedef ldns_enum_pkt_section ldns_pkt_section

    cdef enum ldns_enum_pkt_type:
        LDNS_PACKET_QUESTION,
        LDNS_PACKET_REFERRAL,
        LDNS_PACKET_ANSWER,
        LDNS_PACKET_NXDOMAIN,
        LDNS_PACKET_NODATA,
        LDNS_PACKET_UNKNOWN
    ctypedef ldns_enum_pkt_type ldns_pkt_type

    # Instanciation
    ldns_pkt* ldns_pkt_new()
    void ldns_pkt_free(ldns_pkt *packet)
    ldns_pkt *ldns_pkt_clone(ldns_pkt *pkt)
    bint ldns_pkt_empty(ldns_pkt *p)

    # properties
    uint16_t ldns_pkt_id(const ldns_pkt *p)
    void ldns_pkt_set_id(ldns_pkt *p, uint16_t id)

    bint ldns_pkt_qr(const ldns_pkt *p)
    void ldns_pkt_set_qr(ldns_pkt *p, bint b)

    bint ldns_pkt_aa(const ldns_pkt *p)
    void ldns_pkt_set_aa(ldns_pkt *p, bint b)

    bint ldns_pkt_tc(const ldns_pkt *p)
    void ldns_pkt_set_tc(ldns_pkt *p, bint b)

    bint ldns_pkt_rd(const ldns_pkt *p)
    void ldns_pkt_set_rd(ldns_pkt *p, bint b)

    bint ldns_pkt_cd(const ldns_pkt *p)
    void ldns_pkt_set_cd(ldns_pkt *p, bint b)

    bint ldns_pkt_ra(const ldns_pkt *p)
    void ldns_pkt_set_ra(ldns_pkt *p, bint b)

    bint ldns_pkt_ad(const ldns_pkt *p)
    void ldns_pkt_set_ad(ldns_pkt *p, bint b)

    ldns_pkt_opcode ldns_pkt_get_opcode(const ldns_pkt *p)
    void ldns_pkt_set_opcode(ldns_pkt *p, ldns_pkt_opcode c)

    ldns_pkt_rcode ldns_pkt_get_rcode(const ldns_pkt *p)
    void ldns_pkt_set_rcode(ldns_pkt *p, uint8_t c)

    uint16_t ldns_pkt_qdcount(const ldns_pkt *p)
    void ldns_pkt_set_qdcount(ldns_pkt *p, uint16_t c)

    uint16_t ldns_pkt_ancount(const ldns_pkt *p)
    void ldns_pkt_set_ancount(ldns_pkt *p, uint16_t c)

    uint16_t ldns_pkt_nscount(const ldns_pkt *p)
    void ldns_pkt_set_nscount(ldns_pkt *p, uint16_t c)

    uint16_t ldns_pkt_arcount(const ldns_pkt *p)
    void ldns_pkt_set_arcount(ldns_pkt *p, uint16_t c)

    ldns_rdf *ldns_pkt_answerfrom(const ldns_pkt *p)
    void ldns_pkt_set_answerfrom(ldns_pkt *p, ldns_rdf *r)

    timeval ldns_pkt_timestamp(const ldns_pkt *p)
    void ldns_pkt_set_timestamp(ldns_pkt *p, timeval timeval)

    uint32_t ldns_pkt_querytime(const ldns_pkt *p)
    void ldns_pkt_set_querytime(ldns_pkt *p, uint32_t t)

    size_t ldns_pkt_size(const ldns_pkt *p)
    void ldns_pkt_set_size(ldns_pkt *p, size_t s)

    ldns_rr *ldns_pkt_tsig(const ldns_pkt *p)
    void ldns_pkt_set_tsig(ldns_pkt *p, ldns_rr *t)

    ldns_rr_list *ldns_pkt_question(const ldns_pkt *p)
    void ldns_pkt_set_question(ldns_pkt *p, ldns_rr_list *rr)

    ldns_rr_list *ldns_pkt_answer(const ldns_pkt *p)
    void ldns_pkt_set_answer(ldns_pkt *p, ldns_rr_list *rr)

    ldns_rr_list *ldns_pkt_authority(const ldns_pkt *p)
    void ldns_pkt_set_authority(ldns_pkt *p, ldns_rr_list *rr)

    ldns_rr_list *ldns_pkt_additional(const ldns_pkt *p)
    void ldns_pkt_set_additional(ldns_pkt *p, ldns_rr_list *rr)

    uint16_t ldns_pkt_edns_udp_size(const ldns_pkt *packet)
    void ldns_pkt_set_edns_udp_size(ldns_pkt *packet, uint16_t s)

    uint8_t ldns_pkt_edns_extended_rcode(const ldns_pkt *packet)
    void ldns_pkt_set_edns_extended_rcode(ldns_pkt *packet, uint8_t c)

    uint8_t ldns_pkt_edns_version(const ldns_pkt *packet)
    void ldns_pkt_set_edns_version(ldns_pkt *packet, uint8_t v)

    uint16_t ldns_pkt_edns_z(const ldns_pkt *packet)
    void ldns_pkt_set_edns_z(ldns_pkt *packet, uint16_t z)

    ldns_rdf *ldns_pkt_edns_data(const ldns_pkt *packet)
    void ldns_pkt_set_edns_data(ldns_pkt *packet, ldns_rdf *data)

    bint ldns_pkt_edns_do(const ldns_pkt *packet)
    void ldns_pkt_set_edns_do(ldns_pkt *packet, bint value)

    ldns_pkt_type ldns_pkt_reply_type(ldns_pkt *p)

    # special getters
    ldns_rr_list *ldns_pkt_all(const ldns_pkt *p)
    ldns_rr_list *ldns_pkt_all_noquestion(const ldns_pkt *p)
    ldns_rr_list *ldns_pkt_get_section_clone(const ldns_pkt *p, ldns_pkt_section s)
    ldns_rr_list *ldns_pkt_rr_list_by_name(ldns_pkt *p, ldns_rdf *r, ldns_pkt_section s)
    ldns_rr_list *ldns_pkt_rr_list_by_type(const ldns_pkt *p, ldns_rr_type t, ldns_pkt_section s)
    ldns_rr_list *ldns_pkt_rr_list_by_name_and_type(const ldns_pkt *packet, const ldns_rdf *ownername, ldns_rr_type type, ldns_pkt_section sec)

    bint ldns_pkt_rr(ldns_pkt *pkt, ldns_pkt_section sec, ldns_rr *rr)
    bint ldns_pkt_edns(const ldns_pkt *packet)

    void ldns_pkt_set_random_id(ldns_pkt *p)
    bint ldns_pkt_set_flags(ldns_pkt *pkt, uint16_t flags)

    uint16_t ldns_pkt_section_count(const ldns_pkt *p, ldns_pkt_section s)
    void ldns_pkt_set_section_count(ldns_pkt *p, ldns_pkt_section s, uint16_t x)

    # query new
    ldns_status ldns_pkt_query_new_frm_str(ldns_pkt **p, const char *rr_name, ldns_rr_type rr_type, ldns_rr_class rr_class , uint16_t flags)
    ldns_status ldns_pkt_ixfr_request_new_frm_str(ldns_pkt **p, const char *rr_name, ldns_rr_class rr_class, uint16_t flags, ldns_rr* soa)
    ldns_pkt *ldns_pkt_query_new(ldns_rdf *rr_name, ldns_rr_type rr_type, ldns_rr_class rr_class, uint16_t flags)
    ldns_pkt *ldns_pkt_ixfr_request_new(ldns_rdf *rr_name, ldns_rr_class rr_class, uint16_t flags, ldns_rr* soa)

    # pushing stuff
    bint ldns_pkt_push_rr(ldns_pkt *packet, ldns_pkt_section section, ldns_rr *rr)
    bint ldns_pkt_safe_push_rr(ldns_pkt *pkt, ldns_pkt_section sec, ldns_rr *rr)
    bint ldns_pkt_push_rr_list(ldns_pkt *packet, ldns_pkt_section section, ldns_rr_list *list)
    bint ldns_pkt_safe_push_rr_list(ldns_pkt *pkt, ldns_pkt_section sec, ldns_rr_list *list)

cdef class Packet:
    cdef ldns_pkt* _pkt

    cdef Packet _setup(self, ldns_pkt* pkt)

cdef Packet Packet_create(ldns_pkt* pkt)
