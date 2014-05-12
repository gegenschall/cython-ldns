cdef extern from "ldns/buffer.h":
    cdef struct ldns_struct_buffer:
        pass
    ctypedef ldns_struct_buffer ldns_buffer
