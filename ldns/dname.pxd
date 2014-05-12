from libc.stdint cimport *
from ldns.rdata cimport ResourceData, ldns_rdf, ldns_status

cdef extern from "ldns/dname.h":
    ldns_rdf *ldns_dname_cat_clone(const ldns_rdf *rd1, const ldns_rdf *rd2)
    #ldns_status ldns_dname_cat(ldns_rdf *rd1, ldns_rdf *rd2)

    uint8_t  ldns_dname_label_count(const ldns_rdf *r)

    ldns_rdf *ldns_dname_new_frm_str(const char *str)
    ldns_rdf *ldns_dname_new(uint16_t s, void *data)
    ldns_rdf *ldns_dname_new_frm_data(uint16_t size, const void *data)

    ldns_rdf *ldns_dname_reverse(const ldns_rdf *d)
    ldns_rdf *ldns_dname_clone_from(const ldns_rdf *d, uint16_t n)
    ldns_rdf *ldns_dname_left_chop(const ldns_rdf *d)
    void ldns_dname2canonical(const ldns_rdf *rdf)
    bint ldns_dname_is_subdomain(const ldns_rdf *sub, const ldns_rdf *parent)
    int ldns_dname_is_wildcard(const ldns_rdf* dname)

    int ldns_dname_compare(const ldns_rdf *dname1, const ldns_rdf *dname2)
    int ldns_dname_match_wildcard(const ldns_rdf *dname, const ldns_rdf *wildcard)
    int ldns_dname_interval(const ldns_rdf *prev, const ldns_rdf *middle, const ldns_rdf *next)

    #bint ldns_dname_str_absolute(const char *dname_str)
    bint ldns_dname_absolute(const ldns_rdf *dname)
    ldns_rdf *ldns_dname_label(const ldns_rdf *rdf, uint8_t labelpos)

cdef class DomainName(ResourceData):
    pass

cdef DomainName DomainName_create(ldns_rdf* rdf)
