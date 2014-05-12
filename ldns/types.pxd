from libc.stdint cimport *

# ldns uses 32-bit timestamps. In this case this typedef should be sufficient.
cdef extern from "time.h":
    ctypedef uint32_t __time_t
    ctypedef __time_t time_t

cdef extern from "sys/time.h":
    # no idea...
    ctypedef uint32_t __suseconds_t
    ctypedef __suseconds_t suseconds_t

    cdef struct timeval:
        __time_t tv_sec
        __suseconds_t tv_usec
