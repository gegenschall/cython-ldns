from nose.tools import *

import ldns
from ldns.resolver import Resolver, resolver_from_file

class TestResolver(object):
    def setup(self):
        self.resolver = Resolver()

    def teardown(self):
        del self.resolver

    def test_attributes(self):
        INT_VALED = ['port', 'retry', 'retrans', 'edns_udp_size',
            'nameserver_count', 'rtt', 'timeout']

        BOOL_VALED = ['recursive', 'debug', 'fallback', 'usevc', 'fail',
            'defnames', 'dnsrch', 'dnssec', 'dnssec_cd', 'igntc', 'random']

        for attr in INT_VALED:
            setattr(self.resolver, attr, 42)
            val = getattr(self.resolver, attr)
            assert_equals(val, 42, "Attribute in test: %s. Got %d, should be %d" % (attr, val, 42))

        for attr in BOOL_VALED:
            setattr(self.resolver, attr, True)
            val = getattr(self.resolver, attr)
            assert_equals(val, True, "Attribute in test: %s. Got %s, should be %s" % (attr, val, True))

        self.resolver.ip6 = 1
        assert_equals(self.resolver.ip6, 1)

        self.resolver.source = '127.0.0.1'
        assert_equals(self.resolver.source, '127.0.0.1')

        self.resolver.domain = "localhost"
        # it's a dname, if it has a . at the end its cool.
        assert_equals(self.resolver.domain, 'localhost.')

    def test_nameserver_list(self):
        self.resolver.nameservers = ['8.8.4.4', '8.8.8.8']

        assert_equals(self.resolver.nameservers, ['8.8.4.4', '8.8.8.8'])
        assert_equals(self.resolver.nameserver_count, 2)

    def test_resolver_from_file(self):
        self.resolver = resolver_from_file('/etc/resolv.conf')

        assert(self.resolver.nameserver_count > 0)

    def test_search(self):
        self.resolver = resolver_from_file('/etc/resolv.conf')

        pkt = self.resolver.search('www.google.de')
        assert(not pkt.is_empty())

        for rr in pkt.answer:
            assert_equals(rr.rr_type, ldns.LDNS_RR_TYPE_A)

