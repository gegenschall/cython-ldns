from ldns.errors cimport LDNS_STATUS_OK
from ldns.rdata cimport *

from ldns.ldns_host2str cimport ldns_rdf2str
from libc.stdio cimport fopen, fclose, FILE

from ldns.dname import DomainName, DomainName_create
from ldns.errors import LDNSStatusError

from ipaddr import IPAddress

# Let's assume there will never be a negative rdf type
cdef LDNS_RDF_TYPE_DEFAULT = -1

def rdf_from_str(int type, str data):
    cdef ldns_rdf* rdf = ldns_rdf_new_frm_str(<ldns_rdf_type>type, <bytes>data)
    return ResourceData_create(rdf)

def rdf_from_data(int type, int size, bytes data):
    cdef ldns_rdf* rdf = ldns_rdf_new_frm_data(<ldns_rdf_type>type, <size_t>size, <const void*> data)
    return ResourceData_create(rdf)

def rdf_from_file(int type, str filename):
    cdef ResourceData rdf = ResourceData()
    cdef ldns_status status
    cdef FILE* fp

    fp = fopen(filename, 'r')
    status = ldns_rdf_new_frm_fp(&rdf._rdf, <ldns_rdf_type>type, fp)
    fclose(fp)

    if status != LDNS_STATUS_OK:
        raise LDNSStatusError(status)

    return rdf

# cdef functions for converting resource data
cdef C_TYPE_TO_PYTHON_TYPE = {
#   LDNS type name              : (python type, type caster/constructor)
    LDNS_RDF_TYPE_DNAME         : (DomainName,  DomainName_create),
    LDNS_RDF_TYPE_INT8          : (int,         int),
    LDNS_RDF_TYPE_INT16         : (int,         int),
    LDNS_RDF_TYPE_INT32         : (int,         int),
    LDNS_RDF_TYPE_A             : (IPAddress,   IPAddress),
    LDNS_RDF_TYPE_AAAA          : (IPAddress,   IPAddress),

    # Default to str as the value returned. This should be okay in most cases.
    LDNS_RDF_TYPE_DEFAULT       : (str,         str)
}

cdef tuple rdf_type_to_pytype(int rdf_type):
    if rdf_type not in C_TYPE_TO_PYTHON_TYPE.keys():
        rdf_type = LDNS_RDF_TYPE_DEFAULT

    return C_TYPE_TO_PYTHON_TYPE[rdf_type]


cdef class ResourceData:
    def __cinit__(self, *args, **kwargs):
        self._rdf = ldns_rdf_new(<ldns_rdf_type>0, <size_t>0, NULL)

    def __init__(self, int rdf_type, int size, object data):
        self.type = rdf_type

        # The size of the data (in octets)
        self.size = size

        # The data is a network ordered array of bytes, which size is specified by
        # the (16-bit) size field. To correctly parse it, use the type
        # specified in the (16-bit) type field with a value from ldns_rdf_type.
        self.data = data

    def __dealloc__(self):
        if not self._rdf:
            # ldns_rdf_deep_free won't work here. We can't really decide
            # whether data can be deep freed or not.
            ldns_rdf_free(self._rdf)

    cdef ResourceData _setup(self, ldns_rdf* rdf):
        self._rdf = rdf
        return self


    def __str__(self):
        return <bytes>ldns_rdf2str(self._rdf)

    property size:
        def __get__(self):
            return <int?>ldns_rdf_size(self._rdf)

        def __set__(self, int value):
            ldns_rdf_set_size(self._rdf, <size_t?>value)

    property type:
        def __get__(self):
            cdef ldns_type = <int?>ldns_rdf_get_type(self._rdf)
            cdef pytype = rdf_type_to_pytype(ldns_type)[0]

            return (ldns_type, pytype)

        def __set__(self, int value):
            ldns_rdf_set_type(self._rdf, <ldns_rdf_type?>value)

    property data:
        def __get__(self):
            cdef ldns_type = <int?>ldns_rdf_get_type(self._rdf)
            data = <bytes>ldns_rdf2str(self._rdf)
            _, initfunc = rdf_type_to_pytype(ldns_type)

            return initfunc(data)

        def __set__(self, object value):
            # Dragons ahead. This will most likely not work...
            ldns_rdf_set_data(self._rdf, <void*>value)

    def reverse(self):
        cdef ldns_rdf* ret = ldns_rdf_address_reverse(self._rdf)
        self._rdf = ret

        ldns_rdf_deep_free(ret)

    def clone(self):
        cdef ldns_rdf* rdf = ldns_rdf_clone(self._rdf)
        return ResourceData_create(rdf)


cdef ResourceData_create(ldns_rdf *rdf):
    return ResourceData(0, 0, None)._setup(rdf)
