from libc.stdio cimport FILE
from libc.stdint cimport *

from ldns.errors cimport ldns_status
from ldns.resourcerecord cimport ldns_rr_list, ldns_rr_class, ldns_rr
from ldns.rdata cimport ldns_rdf

cdef extern from "ldns/zone.h":
    struct ldns_struct_zone:
        pass
    ctypedef ldns_struct_zone ldns_zone

    ldns_zone * ldns_zone_new()
    ldns_status ldns_zone_new_frm_fp(ldns_zone **z, FILE *fp, ldns_rdf *origin, uint32_t ttl, ldns_rr_class c)
    void ldns_zone_free(ldns_zone *zone)
    void ldns_zone_deep_free(ldns_zone *zone)

    ldns_rr * ldns_zone_soa(const ldns_zone *z)
    size_t ldns_zone_rr_count(const ldns_zone *z)
    void ldns_zone_set_soa(ldns_zone *z, ldns_rr *soa)

    ldns_rr_list * ldns_zone_rrs(const ldns_zone *z)
    void ldns_zone_set_rrs(ldns_zone *z, ldns_rr_list *rrlist)

    bint ldns_zone_push_rr_list(ldns_zone *z, ldns_rr_list *list)
    bint ldns_zone_push_rr(ldns_zone *z, ldns_rr *rr)
    ldns_rr_list * ldns_zone_glue_rr_list(const ldns_zone *z)

    void ldns_zone_sort(ldns_zone *zone)

cdef class Zone:
    cdef ldns_zone* _zone

    cdef _setup(self, ldns_zone* zone)

cdef Zone_create(ldns_zone* zone)
