from ldns.rdata cimport *
from ldns.ldns_host2str cimport ldns_rdf2str
from libc.stdlib cimport malloc

cdef class ResourceData:
    def __cinit__(self, *args, **kwargs):
        self._rdf = <ldns_rdf*>malloc(sizeof(ldns_rdf))

        if self._rdf == NULL:
            raise MemoryError()

    def __init__(self, int rdf_type, int size, object data):
        self.rdf_type = rdf_type
        self.size = size
        self.data = data

    cdef ResourceData _setup(self, ldns_rdf* rdf):
        self._rdf = rdf
        return self

    def __dealloc__(self):
        # Always deep free. Get your usage right. (?)
        if self._rdf is not NULL:
            #ldns_rdf_deep_free(self._rdf)
            pass

    def __str__(self):
        return <bytes>ldns_rdf2str(self._rdf)

    # reverse
    property size:
        def __get__(self):
            return <int?>ldns_rdf_size(self._rdf)

        def __set__(self, int value):
            ldns_rdf_set_size(self._rdf, <size_t?>value)

    property rdf_type:
        def __get__(self):
            return <int?>ldns_rdf_get_type(self._rdf)

        def __set__(self, int value):
            ldns_rdf_set_type(self._rdf, <ldns_rdf_type?>value)

    property data:
        def __get__(self):
            return <object>ldns_rdf_data(self._rdf)

        def __set__(self, object value):
            ldns_rdf_set_data(self._rdf, <void*>value)

    def reverse(self):
        cdef ldns_rdf* ret = ldns_rdf_address_reverse(self._rdf)
        self._rdf = ret

        ldns_rdf_deep_free(ret)

    def clone(self):
        return ResourceData_create(self._rdf)

cdef ResourceData_create(ldns_rdf *rdf):
    return ResourceData.__new__(ResourceData)._setup(rdf)
