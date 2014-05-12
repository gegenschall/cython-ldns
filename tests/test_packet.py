import unittest

from ldns.packet import Packet
from ldns.resourcerecord import resource_record_from_str

RR1 = "www.google.de. 299 IN AAAA 2a00:1450:4016:803::1018"
RR2 = "www.google.de. 299 IN A 173.194.44.55"

class TestPacket(unittest.TestCase):
    @classmethod
    def setUp(self):
        self.pkt = Packet()

    @classmethod
    def tearDown(self):
        #self.pkt = None
        pass

    def test_push_rr(self):
        rr1 = resource_record_from_str(RR1)
        rr2 = resource_record_from_str(RR2)

        self.pkt.push_rr(rr1, 1)
        self.pkt.push_rr(rr2, 1)

if __name__ == '__main__':
    unittest.main()
