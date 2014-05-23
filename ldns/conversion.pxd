from libc.stdint cimport *

from ldns.resourcerecord cimport ldns_rr, ldns_rr_list
from ldns.rdata cimport ldns_rdf
from ldns.packet cimport ldns_pkt, ldns_pkt_section
from ldns.errors cimport ldns_status
from ldns.buffer cimport ldns_buffer

# They seem to have fucked up their #includes in host2str.h
cdef extern from "ldns/rbtree.h":
    pass

cdef extern from "ldns/keys.h":
    pass

cdef extern from "ldns/host2str.h":
    cdef struct ldns_struct_output_format:
        pass
    ctypedef ldns_struct_output_format ldns_output_format

    char* ldns_rr2str(const ldns_rr *rr)
    char* ldns_rdf2str(const ldns_rdf *rdf)
    char* ldns_pkt2str(const ldns_pkt *pkt)

cdef extern from "ldns/wire2host.h":
    ldns_status ldns_wire2pkt(ldns_pkt **packet, const uint8_t *data, size_t len)
    ldns_status ldns_buffer2pkt_wire(ldns_pkt **packet, ldns_buffer *buffer)
    ldns_status ldns_wire2dname(ldns_rdf **dname, const uint8_t *wire, size_t max, size_t *pos)
    ldns_status ldns_wire2rdf(ldns_rr *rr, const uint8_t *wire, size_t max, size_t *pos)
    ldns_status ldns_wire2rr(ldns_rr **rr, const uint8_t *wire, size_t max, size_t *pos, ldns_pkt_section section)

cdef extern from "ldns/host2wire.h":
    ldns_status ldns_dname2buffer_wire(ldns_buffer *buffer, const ldns_rdf *name)
    ldns_status ldns_rdf2buffer_wire(ldns_buffer *output, const ldns_rdf *rdf)
    ldns_status ldns_rdf2buffer_wire_canonical(ldns_buffer *output, const ldns_rdf *rdf)
    ldns_status ldns_rr2buffer_wire(ldns_buffer *output, const ldns_rr *rr, int section)
    ldns_status ldns_rr2buffer_wire_canonical(ldns_buffer *output, const ldns_rr *rr, int section)
    ldns_status ldns_rrsig2buffer_wire(ldns_buffer *output, const ldns_rr *sigrr)
    ldns_status ldns_rr_rdata2buffer_wire(ldns_buffer *output, const ldns_rr *rr)
    ldns_status ldns_pkt2buffer_wire(ldns_buffer *output, const ldns_pkt *pkt)
    ldns_status ldns_rr_list2buffer_wire(ldns_buffer *output, const ldns_rr_list *rrlist)
    ldns_status ldns_rdf2wire(uint8_t **dest, const ldns_rdf *rdf, size_t *size)
    ldns_status ldns_rr2wire(uint8_t **dest, const ldns_rr *rr, int, size_t *size)
    ldns_status ldns_pkt2wire(uint8_t **dest, const ldns_pkt *p, size_t *size)
