from libc.stdlib cimport malloc

from ldns.errors import LDNSStatusError
from ldns.dname cimport DomainName, DomainName_create
from ldns.rdata cimport ResourceData_create
from ldns.ldns_host2str cimport ldns_rdf2str

def domain_name_from_str(str value):
    cdef ldns_rdf* rdf = ldns_dname_new_frm_str(value)

    return DomainName_create(rdf)

def domain_name_from_data(object data):
    pass


cdef class DomainName(ResourceData):
    def __add__(DomainName self, DomainName other not None):
        cdef ldns_rdf* rdf = ldns_dname_cat_clone(self._rdf, other._rdf)

        if rdf is NULL:
            raise LDNSStatusError(35)

        return DomainName_create(rdf)

    property label_count:
        def __get__(self):
            return ldns_dname_label_count(self._rdf)

    def reverse(self):
        self._rdf = ldns_dname_reverse(self._rdf)

    def left_chop(self):
        self._rdf = ldns_dname_left_chop(self._rdf)

    def canonicalize(self):
        ldns_dname2canonical(self._rdf)

    def is_subdomain(self, DomainName parent):
        return <bint>ldns_dname_is_subdomain(self._rdf, parent._rdf)

    def is_wildcard(self):
        return <bint>ldns_dname_is_wildcard(self._rdf)

    def is_absolute(self):
        return <bint>ldns_dname_absolute(self._rdf)

    def get_label_at(self, int position):
        cdef ldns_rdf* rdf = ldns_dname_label(self._rdf, position)

        return ResourceData_create(rdf)

cdef DomainName DomainName_create(ldns_rdf* rdf):
    return DomainName()._setup(rdf)
