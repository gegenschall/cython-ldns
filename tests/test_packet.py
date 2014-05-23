from nose import *

from ldns import LDNS_SECTION_QUESTION
from ldns.packet import Packet
from ldns.resourcerecord import resource_record_from_str

RR1 = "www.google.de. 299 IN AAAA 2a00:1450:4016:803::1018"
RR2 = "www.google.de. 299 IN A 173.194.44.55"


class TestPacket(object):
    def setup(self):
        self.pkt = Packet()

    def teardown(self):
        self.pkt = None

    @with_setup(None, None)
    def test_new_packet(self):
        pkt = Packet()
        del pkt

    def test_push_rr(self):
        rr1 = resource_record_from_str(RR1)

        self.pkt.push_rr(rr1, LDNS_SECTION_QUESTION)
        assert(not self.pkt.is_empty())
