import os
import tempfile

from nose.tools import *

from ldns import LDNS_RR_TYPE_AAAA
from ldns.resourcerecord import ResourceRecord, resource_record_from_str, resource_record_from_file

RR1 = "www.google.de. 299 IN AAAA 2a00:1450:4016:803::1018"


class TestResourceRecord(object):
    def setup(self):
        self.rr = ResourceRecord()

    def teardown(self):
        del self.rr

    def test_resource_record_from_file(self):
        handle, filename = tempfile.mkstemp()

        with os.fdopen(handle, 'w') as f:
            f.write(RR1)
            f.write('\n')

        rr = resource_record_from_file(filename)

        assert_equal(rr.ttl, 299)
        assert_equal(rr.rr_type, LDNS_RR_TYPE_AAAA)

        os.remove(filename)

    def test_resource_record_from_str(self):
        rr = resource_record_from_str(RR1)

        assert_equal(rr.ttl, 299)
        assert_equal(rr.rr_type, LDNS_RR_TYPE_AAAA)
