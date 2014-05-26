from libc.stdio cimport FILE, fdopen

from ldns.zone cimport *
from ldns.errors cimport LDNS_STATUS_OK
from ldns.errors import LDNSStatusError
from ldns.resourcerecord cimport ResourceRecord_create, ResourceRecord, _rr_list_to_plist, _plist_to_rr_list
from ldns.resourcerecord cimport LDNS_RR_CLASS_IN
from ldns.rdata cimport ldns_rdf_free
from ldns.dname cimport ldns_dname_new_frm_str

def zone_from_file(str filename, str origin=None, int ttl=None, int klass=LDNS_RR_CLASS_IN):
    cdef ldns_status status
    cdef FILE* fp

    cdef Zone zone = Zone()

    cdef uint32_t _ttl = <uint32_t>ttl
    cdef ldns_rdf* _origin = NULL
    if origin is not None:
        _origin = ldns_dname_new_frm_str(origin)

    with open(filename, 'rb') as f:
        fp = fdopen(f.fileno(), 'rb')
        status = ldns_zone_new_frm_fp(&zone._zone, fp, _origin, ttl, <ldns_rr_class?>klass)

    if status != LDNS_STATUS_OK:
        raise LDNSStatusError(status)

    ldns_rdf_free(_origin)

    return zone


cdef class Zone:
    def __cinit__(self, *args, **kwargs):
        self._zone = ldns_zone_new()

    def __dealloc__(self):
        ldns_zone_free(self._zone)

    def __init__(self, *args, **kwargs):
        pass

    cdef _setup(self, ldns_zone* zone):
        self._zone = zone

    property soa:
        def __get__(self):
            cdef ldns_rr* rr = ldns_zone_soa(self._zone)
            return ResourceRecord_create(rr)

        def __set__(self, ResourceRecord rr):
            ldns_zone_set_soa(self._zone, rr._rr)

    property rr_count:
        def __get__(self):
            return <int?>ldns_zone_rr_count(self._zone)

    property rr_set:
        def __get__(self):
            cdef ldns_rr_list* rr_list = ldns_zone_rrs(self._zone)
            return _rr_list_to_plist(rr_list)

        def __set__(self, list rr_set):
            cdef ldns_rr_list* rr_list = _plist_to_rr_list(rr_set)
            ldns_zone_set_rrs(self._zone, rr_list)

    def get_glue_list(self):
        cdef ldns_rr_list* rr_list = ldns_zone_glue_rr_list(self._zone)
        return _rr_list_to_plist(rr_list)

    def sort(self):
        ldns_zone_sort(self._zone)

cdef Zone_create(ldns_zone* zone):
    return Zone()._setup(zone)
