from nose import *

import ldns
from ldns.rdata import ResourceData, rdf_from_str

RDATA = "2a00:1450:4016:803::1018"


class TestResourceData(object):
    def setup(self):
        self.rdf = rdf_from_str(ldns.LDNS_RDF_TYPE_AAAA, RDATA)

    def teardown(self):
        self.rdf = None
        del self.rdf

    @with_setup(None, None)
    def test_instanciation(self):
        rdf = ResourceData(0,0,0)

        del rdf

    def test_clone(self):
        clone = self.rdf.clone()

    def test_type_attribute(self):
        assert(self.rdf.type[0] == ldns.LDNS_RDF_TYPE_AAAA)

    def test_data_attribute(self):
        ip = self.rdf.data
        assert(str(ip) == RDATA)
