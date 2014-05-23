from libc.stdint cimport *
from libc.stdio cimport FILE

from ldns.rdata cimport ldns_rdf, ldns_rdf_type
from ldns.errors cimport ldns_status
from ldns.buffer cimport ldns_buffer

cdef extern from "ldns/rr.h":
    cdef enum ldns_enum_rr_type:
        LDNS_RR_TYPE_A
        LDNS_RR_TYPE_NS
        LDNS_RR_TYPE_MD
        LDNS_RR_TYPE_MF
        LDNS_RR_TYPE_CNAME
        LDNS_RR_TYPE_SOA
        LDNS_RR_TYPE_MB
        LDNS_RR_TYPE_MG
        LDNS_RR_TYPE_MR
        LDNS_RR_TYPE_NULL
        LDNS_RR_TYPE_WKS
        LDNS_RR_TYPE_PTR
        LDNS_RR_TYPE_HINFO
        LDNS_RR_TYPE_MINFO
        LDNS_RR_TYPE_MX
        LDNS_RR_TYPE_TXT
        LDNS_RR_TYPE_RP
        LDNS_RR_TYPE_AFSDB
        LDNS_RR_TYPE_X25
        LDNS_RR_TYPE_ISDN
        LDNS_RR_TYPE_RT
        LDNS_RR_TYPE_NSAP
        LDNS_RR_TYPE_NSAP_PTR
        LDNS_RR_TYPE_SIG
        LDNS_RR_TYPE_KEY
        LDNS_RR_TYPE_PX
        LDNS_RR_TYPE_GPOS
        LDNS_RR_TYPE_AAAA
        LDNS_RR_TYPE_LOC
        LDNS_RR_TYPE_NXT
        LDNS_RR_TYPE_EID
        LDNS_RR_TYPE_NIMLOC
        LDNS_RR_TYPE_SRV
        LDNS_RR_TYPE_ATMA
        LDNS_RR_TYPE_NAPTR
        LDNS_RR_TYPE_KX
        LDNS_RR_TYPE_CERT
        LDNS_RR_TYPE_A6
        LDNS_RR_TYPE_DNAME
        LDNS_RR_TYPE_SINK
        LDNS_RR_TYPE_OPT
        LDNS_RR_TYPE_APL
        LDNS_RR_TYPE_DS
        LDNS_RR_TYPE_SSHFP
        LDNS_RR_TYPE_IPSECKEY
        LDNS_RR_TYPE_RRSIG
        LDNS_RR_TYPE_NSEC
        LDNS_RR_TYPE_DNSKEY
        LDNS_RR_TYPE_DHCID
        LDNS_RR_TYPE_NSEC3
        LDNS_RR_TYPE_NSEC3PARAM
        LDNS_RR_TYPE_NSEC3PARAMS
        LDNS_RR_TYPE_TLSA
        LDNS_RR_TYPE_HIP
        LDNS_RR_TYPE_NINFO
        LDNS_RR_TYPE_RKEY
        LDNS_RR_TYPE_TALINK
        LDNS_RR_TYPE_CDS
        LDNS_RR_TYPE_SPF
        LDNS_RR_TYPE_UINFO
        LDNS_RR_TYPE_UID
        LDNS_RR_TYPE_GID
        LDNS_RR_TYPE_UNSPEC
        LDNS_RR_TYPE_NID
        LDNS_RR_TYPE_L32
        LDNS_RR_TYPE_L64
        LDNS_RR_TYPE_LP
        LDNS_RR_TYPE_EUI48
        LDNS_RR_TYPE_EUI64
        LDNS_RR_TYPE_TKEY
        LDNS_RR_TYPE_TSIG
        LDNS_RR_TYPE_IXFR
        LDNS_RR_TYPE_AXFR
        LDNS_RR_TYPE_MAILB
        LDNS_RR_TYPE_MAILA
        LDNS_RR_TYPE_ANY
        LDNS_RR_TYPE_URI
        LDNS_RR_TYPE_CAA
        LDNS_RR_TYPE_TA
        LDNS_RR_TYPE_DLV
        LDNS_RR_TYPE_NSEC3
        LDNS_RR_TYPE_NSEC3PARAMS
        LDNS_RR_TYPE_FIRST
        LDNS_RR_TYPE_LAST
        LDNS_RR_TYPE_COUNT
    ctypedef ldns_enum_rr_type ldns_rr_type

    cdef enum ldns_enum_rr_class:
        LDNS_RR_CLASS_IN
        LDNS_RR_CLASS_CH
        LDNS_RR_CLASS_HS
        LDNS_RR_CLASS_NONE
        LDNS_RR_CLASS_ANY
        LDNS_RR_CLASS_FIRST
        LDNS_RR_CLASS_LAST
        LDNS_RR_CLASS_COUNT
    ctypedef ldns_enum_rr_class ldns_rr_class

    cdef struct ldns_struct_rr:
        ldns_rdf *_owner
        uint32_t _ttl
        size_t _rd_count
        ldns_rr_type _rr_type
        ldns_rr_class _rr_class
        ldns_rdf **_rdata_fields
        bint _rr_question
    ctypedef ldns_struct_rr ldns_rr

    cdef struct ldns_struct_rr_list:
        pass
    ctypedef ldns_struct_rr_list ldns_rr_list

    cdef struct ldns_struct_rr_descriptor:
        pass
    ctypedef ldns_struct_rr_descriptor ldns_rr_descriptor


    ldns_rr* ldns_rr_new()
    void ldns_rr_free(ldns_rr *rr)
    ldns_rr* ldns_rr_new_frm_type(ldns_rr_type t)
    ldns_rr* ldns_rr_clone(const ldns_rr *rr)

    ldns_status ldns_rr_new_frm_str(ldns_rr **n, const char *str, uint32_t default_ttl, ldns_rdf *origin, ldns_rdf **prev)
    ldns_status ldns_rr_new_question_frm_str(ldns_rr **n, const char *str, ldns_rdf *origin, ldns_rdf **prev)
    ldns_status ldns_rr_new_frm_fp(ldns_rr **rr, FILE *fp, uint32_t *default_ttl, ldns_rdf **origin, ldns_rdf **prev)
    ldns_status ldns_rr_new_frm_fp_l(ldns_rr **rr, FILE *fp, uint32_t *default_ttl, ldns_rdf **origin, ldns_rdf **prev, int *line_nr)

    void ldns_rr_set_owner(ldns_rr *rr, ldns_rdf *owner)
    void ldns_rr_set_question(ldns_rr *rr, bint question)
    void ldns_rr_set_ttl(ldns_rr *rr, uint32_t ttl)
    void ldns_rr_set_rd_count(ldns_rr *rr, size_t count)
    void ldns_rr_set_type(ldns_rr *rr, ldns_rr_type rr_type)
    void ldns_rr_set_class(ldns_rr *rr, ldns_rr_class rr_class)

    ldns_rdf* ldns_rr_owner(const ldns_rr *rr)
    bint ldns_rr_is_question(const ldns_rr *rr)
    uint32_t ldns_rr_ttl(const ldns_rr *rr)
    size_t ldns_rr_rd_count(const ldns_rr *rr)
    ldns_rr_type ldns_rr_get_type(const ldns_rr *rr)
    ldns_rr_class ldns_rr_get_class(const ldns_rr *rr)

    ldns_rdf* ldns_rr_rdf(const ldns_rr *rr, size_t nr)
    ldns_rdf* ldns_rr_set_rdf(ldns_rr *rr, const ldns_rdf *f, size_t position)
    bint ldns_rr_push_rdf(ldns_rr *rr, const ldns_rdf *f)
    ldns_rdf* ldns_rr_pop_rdf(ldns_rr *rr)

    # List functions. Not needed. Only used internally
    size_t ldns_rr_list_rr_count(const ldns_rr_list *rr_list)
    void ldns_rr_list_set_rr_count(ldns_rr_list *rr_list, size_t count)
    ldns_rr * ldns_rr_list_set_rr(ldns_rr_list *rr_list, const ldns_rr *r, size_t count)
    ldns_rr* ldns_rr_list_rr(const ldns_rr_list *rr_list, size_t nr)
    ldns_rr_list* ldns_rr_list_new()
    void ldns_rr_list_free(ldns_rr_list *rr_list)
    void ldns_rr_list_deep_free(ldns_rr_list *rr_list)
    bint ldns_rr_list_cat(ldns_rr_list *left, ldns_rr_list *right)
    ldns_rr_list* ldns_rr_list_cat_clone(ldns_rr_list *left, ldns_rr_list *right)
    bint ldns_rr_list_push_rr(ldns_rr_list *rr_list, const ldns_rr *rr)
    bint ldns_rr_list_push_rr_list(ldns_rr_list *rr_list, const ldns_rr_list *push_list)
    ldns_rr* ldns_rr_list_pop_rr(ldns_rr_list *rr_list)
    ldns_rr_list* ldns_rr_list_pop_rr_list(ldns_rr_list *rr_list, size_t size)
    bint ldns_rr_list_contains_rr(const ldns_rr_list *rr_list, ldns_rr *rr)
    bint ldns_rr_set_push_rr(ldns_rr_list *rr_list, ldns_rr *rr)
    ldns_rr* ldns_rr_set_pop_rr(ldns_rr_list *rr_list)
    ldns_rr_list *ldns_rr_list_pop_rrset(ldns_rr_list *rr_list)
    ldns_rr_list* ldns_rr_list_clone(const ldns_rr_list *rrlist)
    void ldns_rr_list_sort(ldns_rr_list *unsorted)
    int ldns_rr_list_compare(const ldns_rr_list *rrl1, const ldns_rr_list *rrl2)
    ldns_rr_type ldns_rr_list_type(const ldns_rr_list *rr_list)
    ldns_rdf *ldns_rr_list_owner(const ldns_rr_list *rr_list)
    void ldns_rr_list2canonical(ldns_rr_list *rr_list)
    bint ldns_is_rrset(ldns_rr_list *rr_list)
    ldns_rr_list *ldns_rr_list_subtype_by_rdf(ldns_rr_list *l, ldns_rdf *r, size_t pos)
    # End list functions

    ldns_rr_type ldns_get_rr_type_by_name(const char *name)
    ldns_rr_class ldns_get_rr_class_by_name(const char *name)

    int ldns_rr_compare(const ldns_rr *rr1, const ldns_rr *rr2)
    int ldns_rr_compare_no_rdata(const ldns_rr *rr1, const ldns_rr *rr2)
    # unneeded, in buffer.
    int ldns_rr_compare_wire(ldns_buffer *rr1_buf, ldns_buffer *rr2_buf)
    bint ldns_rr_compare_ds(const ldns_rr *rr1, const ldns_rr *rr2)

    size_t ldns_rr_uncompressed_size(const ldns_rr *r)
    void ldns_rr2canonical(ldns_rr *rr)
    uint8_t ldns_rr_label_count(ldns_rr *rr)

    # TODO: Put this into rdata!
    ldns_rr_type ldns_rdf2rr_type(const ldns_rdf *rd)
    ldns_status ldns_rdf_bitmap_known_rr_types_space(ldns_rdf** rdf)
    ldns_status ldns_rdf_bitmap_known_rr_types(ldns_rdf** rdf)

    const ldns_rr_descriptor *ldns_rr_descript(uint16_t type)
    size_t ldns_rr_descriptor_minimum(const ldns_rr_descriptor *descriptor)
    size_t ldns_rr_descriptor_maximum(const ldns_rr_descriptor *descriptor)
    ldns_rdf_type ldns_rr_descriptor_field_type(const ldns_rr_descriptor *descriptor, size_t field)

cdef extern from "ldns/keys.h":
    pass

cdef extern from "ldns/rr_functions.h":
    ldns_rdf* ldns_rr_a_address(const ldns_rr *r)
    bint ldns_rr_a_set_address(ldns_rr *r, ldns_rdf *f)
    ldns_rdf* ldns_rr_ns_nsdname(const ldns_rr *r)

    ldns_rdf* ldns_rr_mx_preference(const ldns_rr *r)
    ldns_rdf* ldns_rr_mx_exchange(const ldns_rr *r)

    ldns_rdf* ldns_rr_rrsig_typecovered(const ldns_rr *r)
    bint ldns_rr_rrsig_set_typecovered(ldns_rr *r, ldns_rdf *f)
    ldns_rdf* ldns_rr_rrsig_algorithm(const ldns_rr *r)
    bint ldns_rr_rrsig_set_algorithm(ldns_rr *r, ldns_rdf *f)
    ldns_rdf *ldns_rr_rrsig_labels(const ldns_rr *r)
    bint ldns_rr_rrsig_set_labels(ldns_rr *r, ldns_rdf *f)
    ldns_rdf* ldns_rr_rrsig_origttl(const ldns_rr *r)
    bint ldns_rr_rrsig_set_origttl(ldns_rr *r, ldns_rdf *f)
    ldns_rdf* ldns_rr_rrsig_expiration(const ldns_rr *r)
    bint ldns_rr_rrsig_set_expiration(ldns_rr *r, ldns_rdf *f)
    ldns_rdf* ldns_rr_rrsig_inception(const ldns_rr *r)
    bint ldns_rr_rrsig_set_inception(ldns_rr *r, ldns_rdf *f)
    ldns_rdf* ldns_rr_rrsig_keytag(const ldns_rr *r)
    bint ldns_rr_rrsig_set_keytag(ldns_rr *r, ldns_rdf *f)
    ldns_rdf* ldns_rr_rrsig_signame(const ldns_rr *r)
    bint ldns_rr_rrsig_set_signame(ldns_rr *r, ldns_rdf *f)
    ldns_rdf* ldns_rr_rrsig_sig(const ldns_rr *r)
    bint ldns_rr_rrsig_set_sig(ldns_rr *r, ldns_rdf *f)

    ldns_rdf* ldns_rr_dnskey_flags(const ldns_rr *r)
    bint ldns_rr_dnskey_set_flags(ldns_rr *r, ldns_rdf *f)
    ldns_rdf* ldns_rr_dnskey_protocol(const ldns_rr *r)
    bint ldns_rr_dnskey_set_protocol(ldns_rr *r, ldns_rdf *f)
    ldns_rdf* ldns_rr_dnskey_algorithm(const ldns_rr *r)
    bint ldns_rr_dnskey_set_algorithm(ldns_rr *r, ldns_rdf *f)
    ldns_rdf* ldns_rr_dnskey_key(const ldns_rr *r)
    bint ldns_rr_dnskey_set_key(ldns_rr *r, ldns_rdf *f)
    # size_t ldns_rr_dnskey_key_size_raw(const unsigned char *keydata, const size_t len, const ldns_algorithm alg)
    size_t ldns_rr_dnskey_key_size(const ldns_rr *key)

    uint32_t ldns_soa_serial_identity(uint32_t unused, void *data)
    uint32_t ldns_soa_serial_increment(uint32_t s, void *unused)
    uint32_t ldns_soa_serial_increment_by(uint32_t s, void *data)
    uint32_t ldns_soa_serial_unixtime(uint32_t s, void *data)
    uint32_t ldns_soa_serial_datecounter(uint32_t s, void *data)

    # void ldns_rr_soa_increment(ldns_rr *soa)
    # void ldns_rr_soa_increment_func(ldns_rr *soa, ldns_soa_serial_increment_func_t f)
    # void ldns_rr_soa_increment_func_data(ldns_rr *soa, ldns_soa_serial_increment_func_t f, void *data)
    # void ldns_rr_soa_increment_func_int(ldns_rr *soa, ldns_soa_serial_increment_func_t f, int data)


cdef class ResourceRecordDescriptor:
    cdef const ldns_rr_descriptor* _rrd

cdef class ResourceRecord:
    cdef ldns_rr* _rr

    cdef ResourceRecord _setup(self, ldns_rr* rr)
    cdef list _rdf_as_list(self)

cdef ResourceRecord ResourceRecord_create(ldns_rr *rr)

cdef list _rr_list_to_plist(ldns_rr_list* rr_list)
cdef ldns_rr_list* _plist_to_rr_list(list rr_list)
