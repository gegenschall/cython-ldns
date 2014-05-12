from ldns.resourcerecord cimport ldns_rr
from ldns.rdata cimport ldns_rdf

# They seem to have fucked up their #includes in host2str.h
cdef extern from "ldns/rbtree.h":
    pass

cdef extern from "ldns/keys.h":
    pass

cdef extern from "ldns/host2str.h":
    char* ldns_rr2str(const ldns_rr *rr)
    char* ldns_rdf2str(const ldns_rdf *rdf)
