from libc.stdio cimport FILE, fdopen

from ldns.rdata import ResourceData
from ldns.errors import InvalidLDNSTypeError, LDNSStatusError

from ldns.errors cimport LDNS_STATUS_OK
from ldns.resourcerecord cimport *
from ldns.rdata cimport ResourceData, ResourceData_create
from ldns.conversion cimport ldns_rr2str

cdef class ResourceRecord
cdef class ResourceRecordDescriptor

cdef list _rr_list_to_plist(ldns_rr_list* rr_list):
    ret = []
    cdef int rr_size = ldns_rr_list_rr_count(rr_list)
    cdef int i = 0

    for i in range(rr_size):
        _rr = ldns_rr_list_rr(rr_list, i)
        rr = ResourceRecord_create(<ldns_rr*>_rr)
        ret.append(<ResourceRecord>rr)

    return ret

cdef ldns_rr_list* _plist_to_rr_list(list rr_list):
    cdef ldns_rr_list* ret = ldns_rr_list_new()

    for rr in rr_list:
        ldns_rr_list_push_rr(ret, <ldns_rr*>rr._rr)

    return ret

def resource_record_from_file(str filename, int default_ttl=0, ResourceData origin=None, ResourceData prev=None):
    cdef ldns_status status
    cdef FILE* fp

    cdef ResourceRecord rr = ResourceRecord()

    cdef uint32_t _default_ttl = <uint32_t>default_ttl
    cdef ldns_rdf* _origin = NULL if origin is None else origin._rdf
    cdef ldns_rdf* _prev = NULL if prev is None else prev._rdf

    with open(filename, 'rb') as f:
        fp = fdopen(f.fileno(), 'rb')
        status = ldns_rr_new_frm_fp(&rr._rr, fp, &_default_ttl, &_origin, &_prev)
        #fclose(fp)

    if status != LDNS_STATUS_OK:
        raise LDNSStatusError(status)

    return rr

def resource_record_from_str(str input not None, int default_ttl=0, *args):
    cdef ldns_rr* rr = ldns_rr_new()
    status = ldns_rr_new_frm_str(&rr, input, default_ttl, NULL, NULL)

    if status != LDNS_STATUS_OK:
        raise LDNSStatusError(status)

    ret = ResourceRecord()
    ret._rr = rr
    return ret

def resource_record_question_from_str(str input not None, int default_ttl=0, *args):
    cdef ldns_rr* rr = ldns_rr_new()
    status = ldns_rr_new_question_frm_str(&rr, input, NULL, NULL)

    if status != LDNS_STATUS_OK:
        raise LDNSStatusError(status)

    ret = ResourceRecord()
    ret._rr = rr
    return ret

def type_by_name(str name not None):
    r = ldns_get_rr_type_by_name(name)
    if r <= 0:
        raise Exception('%s is not a valid resource record type' % name)

    return r

def class_by_name(str name not None):
    r = ldns_get_rr_class_by_name(name)
    if r <= 0:
        raise Exception('%s is not a valid resource record class' % name)

    return r

cdef class ResourceRecordDescriptor:
    def __cinit__(self, int descriptor_type):
        self._rrd = ldns_rr_descript(descriptor_type)

    def min_num_fields(self):
        return ldns_rr_descriptor_minimum(self._rrd)

    def max_num_fields(self):
        return ldns_rr_descriptor_maximum(self._rrd)

    def rdf_type_for_field(self, field):
        return ldns_rr_descriptor_field_type(self._rrd, field)


cdef class ResourceRecord:
    def __cinit__(self, int rr_type=-1):
        if rr_type is not None and rr_type >= 0:
            self._rr = ldns_rr_new_frm_type(<ldns_rr_type?>rr_type)
        else:
            self._rr = ldns_rr_new()

    cdef ResourceRecord _setup(self, ldns_rr* rr):
        self._rr = rr
        return self

    def __dealloc__(self):
        if self._rr is not NULL:
            ldns_rr_free(self._rr)

    def __richcmp__(ResourceRecord self, ResourceRecord y, int op):
        cdef ldns_rr* rr1 = self._rr
        cdef ldns_rr* rr2 = y._rr

        cdef int r = ldns_rr_compare(rr1, rr2)
        # <
        if op == 0:
            return r == -1
        # >
        elif op == 4:
            return r == 1
        # <=, >=, ==
        elif op == 1 or op == 2 or op == 5:
            return r == 0
        # !=
        elif op == 3:
            return (r not in (-1, 0, 1))

    def __str__(self):
        return <bytes>ldns_rr2str(self._rr)

    def clone(self):
        r = ResourceRecord()
        r._rr = ldns_rr_clone(self._rr)

        return r

    # Private functions
    cdef list _rdf_as_list(self):
        cdef ret = []
        cdef unsigned int n = self._rr._rd_count
        cdef unsigned int i = 0

        for i in range(n):
            rd = ResourceData.__new__()
            #rd._rdf = ldns_rr_rdf(self._rr, i)
            ret.append(rd)

        return ret

    # All properties
    property owner:
        # TODO: Use ResourceData
        def __get__(self):
            return <str>ldns_rr_owner(self._rr)

        def __set__(self, str value):
            ldns_rr_set_owner(self._rr, <ldns_rdf*?>value)

    property ttl:
        def __get__(self):
            return <int>ldns_rr_ttl(self._rr)

        def __set__(self, int value):
            ldns_rr_set_ttl(self._rr, <uint32_t?>value)

    property question:
        def __get__(self):
            return <bint?>ldns_rr_is_question(self._rr)

        def __set__(self, bint value):
            ldns_rr_set_question(self._rr, <bint?>value)

    property rd_count:
        def __get__(self):
            return <int?>ldns_rr_rd_count(self._rr)

        def __set__(self, int value):
            ldns_rr_set_rd_count(self._rr, <uint16_t?>value)

    property rr_type:
        def __get__(self):
            return <int?>ldns_rr_get_type(self._rr)

        def __set__(self, int value):
            ldns_rr_set_type(self._rr, <ldns_rr_type?>value)

    property rr_class:
        def __get__(self):
            return <int?>ldns_rr_get_class(self._rr)

        def __set__(self, int value):
            ldns_rr_set_class(self._rr, <ldns_rr_class?>value)

    # functions
    def uncompressed_size(self):
        return <int?>ldns_rr_uncompressed_size(self._rr)

    def rr2canonical(self):
        ldns_rr2canonical(self._rr)

    def label_count(self):
        return <int?>ldns_rr_label_count(self._rr)

    def get_rdf(self, int at):
        cdef ldns_rdf* _rdf = ldns_rr_rdf(self._rr, at)

        return ResourceData_create(_rdf)

    def set_rdf(self, ResourceData rdf, int at):
        cdef ldns_rdf* _rdf = rdf._rdf
        ldns_rr_set_rdf(self._rr, _rdf, <size_t>at)

    def push_rdf(self, ResourceData rdf):
        cdef ldns_rdf* _rdf = rdf._rdf
        ldns_rr_push_rdf(self._rr, _rdf)

    def pop_rdf(self):
        cdef ldns_rdf* _rdf = ldns_rr_pop_rdf(self._rr)

        return ResourceData_create(_rdf)

    # functions from rr_functions.h
    def get_a_address(self):
        if not self.rr_type == LDNS_RR_TYPE_A:
            raise InvalidLDNSTypeError(self.rr_type, LDNS_RR_TYPE_A)

        cdef ldns_rdf* _rdf = ldns_rr_a_address(self._rr)

        return ResourceData_create(_rdf)

    def set_a_address(self, ResourceData addr):
        if not self.rr_type == LDNS_RR_TYPE_A:
            raise InvalidLDNSTypeError(self.rr_type, LDNS_RR_TYPE_A)

        ldns_rr_a_set_address(self._rr, addr._rdf)

    def get_ns_nsdname(self):
        if not self.rr_type == LDNS_RR_TYPE_NS:
            raise InvalidLDNSTypeError(self.rr_type, LDNS_RR_TYPE_NS)

        cdef ldns_rdf* _rdf = ldns_rr_ns_nsdname(self._rr)
        return ResourceData_create(_rdf)

    def get_mx_preference(self):
        if not self.rr_type == LDNS_RR_TYPE_MX:
            raise InvalidLDNSTypeError(self.rr_type, LDNS_RR_TYPE_MX)

        cdef ldns_rdf* _rdf = ldns_rr_mx_preference(self._rr)
        return ResourceData_create(_rdf)

    def get_mx_exchange(self):
        if not self.rr_type == LDNS_RR_TYPE_MX:
            raise InvalidLDNSTypeError(self.rr_type, LDNS_RR_TYPE_MX)

        cdef ldns_rdf* _rdf = ldns_rr_mx_exchange(self._rr)
        return ResourceData_create(_rdf)

    # def rrsig_typecovered(const ldns_rr *r)
    # bint rrsig_set_typecovered(ldns_rr *r, ldns_rdf *f)
    # def ldns_rr_rrsig_algorithm(const ldns_rr *r)
    # bint rrsig_set_algorithm(ldns_rr *r, ldns_rdf *f)
    # ldns_rdf *rrsig_labels(const ldns_rr *r)
    # bint rrsig_set_labels(ldns_rr *r, ldns_rdf *f)
    # def rrsig_origttl(const ldns_rr *r)
    # bint rrsig_set_origttl(ldns_rr *r, ldns_rdf *f)
    # def rrsig_expiration(const ldns_rr *r)
    # bint rrsig_set_expiration(ldns_rr *r, ldns_rdf *f)
    # def rrsig_inception(const ldns_rr *r)
    # bint rrsig_set_inception(ldns_rr *r, ldns_rdf *f)
    # def rrsig_keytag(const ldns_rr *r)
    # bint rrsig_set_keytag(ldns_rr *r, ldns_rdf *f)
    # def rrsig_signame(const ldns_rr *r)
    # bint rrsig_set_signame(ldns_rr *r, ldns_rdf *f)
    # def rrsig_sig(const ldns_rr *r)
    # bint rrsig_set_sig(ldns_rr *r, ldns_rdf *f)

cdef ResourceRecord ResourceRecord_create(ldns_rr *rr):
    return ResourceRecord()._setup(rr)


