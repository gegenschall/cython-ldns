from ldns.utils import _bind_constant_to_module as __bind
from ldns cimport packet, resourcerecord, errors

# ldns_enum_pkt_rcode enum, typedef'ed to ldns_pkt_rcode
__bind(__name__, 'LDNS_RCODE_NOERROR', packet.LDNS_RCODE_NOERROR)
__bind(__name__, 'LDNS_RCODE_FORMERR', packet.LDNS_RCODE_FORMERR)
__bind(__name__, 'LDNS_RCODE_SERVFAIL', packet.LDNS_RCODE_SERVFAIL)
__bind(__name__, 'LDNS_RCODE_NXDOMAIN', packet.LDNS_RCODE_NXDOMAIN)
__bind(__name__, 'LDNS_RCODE_NOTIMPL', packet.LDNS_RCODE_NOTIMPL)
__bind(__name__, 'LDNS_RCODE_REFUSED', packet.LDNS_RCODE_REFUSED)
__bind(__name__, 'LDNS_RCODE_YXDOMAIN', packet.LDNS_RCODE_YXDOMAIN)
__bind(__name__, 'LDNS_RCODE_YXRRSET', packet.LDNS_RCODE_YXRRSET)
__bind(__name__, 'LDNS_RCODE_NXRRSET', packet.LDNS_RCODE_NXRRSET)
__bind(__name__, 'LDNS_RCODE_NOTAUTH', packet.LDNS_RCODE_NOTAUTH)
__bind(__name__, 'LDNS_RCODE_NOTZONE', packet.LDNS_RCODE_NOTZONE)

# ldns_enum_pkt_section enum, typedef'ed to ldns_pkt_section
__bind(__name__, 'LDNS_SECTION_QUESTION', packet.LDNS_SECTION_QUESTION)
__bind(__name__, 'LDNS_SECTION_ANSWER', packet.LDNS_SECTION_ANSWER)
__bind(__name__, 'LDNS_SECTION_AUTHORITY', packet.LDNS_SECTION_AUTHORITY)
__bind(__name__, 'LDNS_SECTION_ADDITIONAL', packet.LDNS_SECTION_ADDITIONAL)
__bind(__name__, 'LDNS_SECTION_ANY', packet.LDNS_SECTION_ANY)
__bind(__name__, 'LDNS_SECTION_ANY_NOQUESTION', packet.LDNS_SECTION_ANY_NOQUESTION)

# ldns_enum_pkt_opcode enum, typedef'ed to ldns_pkt_opcode
__bind(__name__, 'LDNS_PACKET_QUERY', packet.LDNS_PACKET_QUERY)
__bind(__name__, 'LDNS_PACKET_IQUERY', packet.LDNS_PACKET_IQUERY)
__bind(__name__, 'LDNS_PACKET_STATUS', packet.LDNS_PACKET_STATUS)
__bind(__name__, 'LDNS_PACKET_NOTIFY', packet.LDNS_PACKET_NOTIFY)
__bind(__name__, 'LDNS_PACKET_UPDATE', packet.LDNS_PACKET_UPDATE)

# ldns_enum_pkt_type enum, typedef'ed to ldns_pkt_type
__bind(__name__, 'LDNS_PACKET_QUESTION', packet.LDNS_PACKET_QUESTION)
__bind(__name__, 'LDNS_PACKET_REFERRAL', packet.LDNS_PACKET_REFERRAL)
__bind(__name__, 'LDNS_PACKET_ANSWER', packet.LDNS_PACKET_ANSWER)
__bind(__name__, 'LDNS_PACKET_NXDOMAIN', packet.LDNS_PACKET_NXDOMAIN)
__bind(__name__, 'LDNS_PACKET_NODATA', packet.LDNS_PACKET_NODATA)
__bind(__name__, 'LDNS_PACKET_UNKNOWN', packet.LDNS_PACKET_UNKNOWN)

# ldns_enum_rr_class enum, typedef'ed to ldns_rr_class
__bind(__name__, 'LDNS_RR_CLASS_IN', resourcerecord.LDNS_RR_CLASS_IN)
__bind(__name__, 'LDNS_RR_CLASS_CH', resourcerecord.LDNS_RR_CLASS_CH)
__bind(__name__, 'LDNS_RR_CLASS_HS', resourcerecord.LDNS_RR_CLASS_HS)
__bind(__name__, 'LDNS_RR_CLASS_NONE', resourcerecord.LDNS_RR_CLASS_NONE)
__bind(__name__, 'LDNS_RR_CLASS_ANY', resourcerecord.LDNS_RR_CLASS_ANY)
__bind(__name__, 'LDNS_RR_CLASS_FIRST', resourcerecord.LDNS_RR_CLASS_FIRST)
__bind(__name__, 'LDNS_RR_CLASS_LAST', resourcerecord.LDNS_RR_CLASS_LAST)
__bind(__name__, 'LDNS_RR_CLASS_COUNT', resourcerecord.LDNS_RR_CLASS_COUNT)

# ldns_enum_rr_type enum, typedef'ed to ldns_rr_type
__bind(__name__, 'LDNS_RR_TYPE_A', resourcerecord.LDNS_RR_TYPE_A)
__bind(__name__, 'LDNS_RR_TYPE_NS', resourcerecord.LDNS_RR_TYPE_NS)
__bind(__name__, 'LDNS_RR_TYPE_MD', resourcerecord.LDNS_RR_TYPE_MD)
__bind(__name__, 'LDNS_RR_TYPE_MF', resourcerecord.LDNS_RR_TYPE_MF)
__bind(__name__, 'LDNS_RR_TYPE_CNAME', resourcerecord.LDNS_RR_TYPE_CNAME)
__bind(__name__, 'LDNS_RR_TYPE_SOA', resourcerecord.LDNS_RR_TYPE_SOA)
__bind(__name__, 'LDNS_RR_TYPE_MB', resourcerecord.LDNS_RR_TYPE_MB)
__bind(__name__, 'LDNS_RR_TYPE_MG', resourcerecord.LDNS_RR_TYPE_MG)
__bind(__name__, 'LDNS_RR_TYPE_MR', resourcerecord.LDNS_RR_TYPE_MR)
__bind(__name__, 'LDNS_RR_TYPE_NULL', resourcerecord.LDNS_RR_TYPE_NULL)
__bind(__name__, 'LDNS_RR_TYPE_WKS', resourcerecord.LDNS_RR_TYPE_WKS)
__bind(__name__, 'LDNS_RR_TYPE_PTR', resourcerecord.LDNS_RR_TYPE_PTR)
__bind(__name__, 'LDNS_RR_TYPE_HINFO', resourcerecord.LDNS_RR_TYPE_HINFO)
__bind(__name__, 'LDNS_RR_TYPE_MINFO', resourcerecord.LDNS_RR_TYPE_MINFO)
__bind(__name__, 'LDNS_RR_TYPE_MX', resourcerecord.LDNS_RR_TYPE_MX)
__bind(__name__, 'LDNS_RR_TYPE_TXT', resourcerecord.LDNS_RR_TYPE_TXT)
__bind(__name__, 'LDNS_RR_TYPE_RP', resourcerecord.LDNS_RR_TYPE_RP)
__bind(__name__, 'LDNS_RR_TYPE_AFSDB', resourcerecord.LDNS_RR_TYPE_AFSDB)
__bind(__name__, 'LDNS_RR_TYPE_X25', resourcerecord.LDNS_RR_TYPE_X25)
__bind(__name__, 'LDNS_RR_TYPE_ISDN', resourcerecord.LDNS_RR_TYPE_ISDN)
__bind(__name__, 'LDNS_RR_TYPE_RT', resourcerecord.LDNS_RR_TYPE_RT)
__bind(__name__, 'LDNS_RR_TYPE_NSAP', resourcerecord.LDNS_RR_TYPE_NSAP)
__bind(__name__, 'LDNS_RR_TYPE_NSAP_PTR', resourcerecord.LDNS_RR_TYPE_NSAP_PTR)
__bind(__name__, 'LDNS_RR_TYPE_SIG', resourcerecord.LDNS_RR_TYPE_SIG)
__bind(__name__, 'LDNS_RR_TYPE_KEY', resourcerecord.LDNS_RR_TYPE_KEY)
__bind(__name__, 'LDNS_RR_TYPE_PX', resourcerecord.LDNS_RR_TYPE_PX)
__bind(__name__, 'LDNS_RR_TYPE_GPOS', resourcerecord.LDNS_RR_TYPE_GPOS)
__bind(__name__, 'LDNS_RR_TYPE_AAAA', resourcerecord.LDNS_RR_TYPE_AAAA)
__bind(__name__, 'LDNS_RR_TYPE_LOC', resourcerecord.LDNS_RR_TYPE_LOC)
__bind(__name__, 'LDNS_RR_TYPE_NXT', resourcerecord.LDNS_RR_TYPE_NXT)
__bind(__name__, 'LDNS_RR_TYPE_EID', resourcerecord.LDNS_RR_TYPE_EID)
__bind(__name__, 'LDNS_RR_TYPE_NIMLOC', resourcerecord.LDNS_RR_TYPE_NIMLOC)
__bind(__name__, 'LDNS_RR_TYPE_SRV', resourcerecord.LDNS_RR_TYPE_SRV)
__bind(__name__, 'LDNS_RR_TYPE_ATMA', resourcerecord.LDNS_RR_TYPE_ATMA)
__bind(__name__, 'LDNS_RR_TYPE_NAPTR', resourcerecord.LDNS_RR_TYPE_NAPTR)
__bind(__name__, 'LDNS_RR_TYPE_KX', resourcerecord.LDNS_RR_TYPE_KX)
__bind(__name__, 'LDNS_RR_TYPE_CERT', resourcerecord.LDNS_RR_TYPE_CERT)
__bind(__name__, 'LDNS_RR_TYPE_A6', resourcerecord.LDNS_RR_TYPE_A6)
__bind(__name__, 'LDNS_RR_TYPE_DNAME', resourcerecord.LDNS_RR_TYPE_DNAME)
__bind(__name__, 'LDNS_RR_TYPE_SINK', resourcerecord.LDNS_RR_TYPE_SINK)
__bind(__name__, 'LDNS_RR_TYPE_OPT', resourcerecord.LDNS_RR_TYPE_OPT)
__bind(__name__, 'LDNS_RR_TYPE_APL', resourcerecord.LDNS_RR_TYPE_APL)
__bind(__name__, 'LDNS_RR_TYPE_DS', resourcerecord.LDNS_RR_TYPE_DS)
__bind(__name__, 'LDNS_RR_TYPE_SSHFP', resourcerecord.LDNS_RR_TYPE_SSHFP)
__bind(__name__, 'LDNS_RR_TYPE_IPSECKEY', resourcerecord.LDNS_RR_TYPE_IPSECKEY)
__bind(__name__, 'LDNS_RR_TYPE_RRSIG', resourcerecord.LDNS_RR_TYPE_RRSIG)
__bind(__name__, 'LDNS_RR_TYPE_NSEC', resourcerecord.LDNS_RR_TYPE_NSEC)
__bind(__name__, 'LDNS_RR_TYPE_DNSKEY', resourcerecord.LDNS_RR_TYPE_DNSKEY)
__bind(__name__, 'LDNS_RR_TYPE_DHCID', resourcerecord.LDNS_RR_TYPE_DHCID)
__bind(__name__, 'LDNS_RR_TYPE_NSEC3', resourcerecord.LDNS_RR_TYPE_NSEC3)
__bind(__name__, 'LDNS_RR_TYPE_NSEC3PARAM', resourcerecord.LDNS_RR_TYPE_NSEC3PARAM)
__bind(__name__, 'LDNS_RR_TYPE_NSEC3PARAMS', resourcerecord.LDNS_RR_TYPE_NSEC3PARAMS)
__bind(__name__, 'LDNS_RR_TYPE_TLSA', resourcerecord.LDNS_RR_TYPE_TLSA)
__bind(__name__, 'LDNS_RR_TYPE_HIP', resourcerecord.LDNS_RR_TYPE_HIP)
__bind(__name__, 'LDNS_RR_TYPE_NINFO', resourcerecord.LDNS_RR_TYPE_NINFO)
__bind(__name__, 'LDNS_RR_TYPE_RKEY', resourcerecord.LDNS_RR_TYPE_RKEY)
__bind(__name__, 'LDNS_RR_TYPE_TALINK', resourcerecord.LDNS_RR_TYPE_TALINK)
__bind(__name__, 'LDNS_RR_TYPE_CDS', resourcerecord.LDNS_RR_TYPE_CDS)
__bind(__name__, 'LDNS_RR_TYPE_SPF', resourcerecord.LDNS_RR_TYPE_SPF)
__bind(__name__, 'LDNS_RR_TYPE_UINFO', resourcerecord.LDNS_RR_TYPE_UINFO)
__bind(__name__, 'LDNS_RR_TYPE_UID', resourcerecord.LDNS_RR_TYPE_UID)
__bind(__name__, 'LDNS_RR_TYPE_GID', resourcerecord.LDNS_RR_TYPE_GID)
__bind(__name__, 'LDNS_RR_TYPE_UNSPEC', resourcerecord.LDNS_RR_TYPE_UNSPEC)
__bind(__name__, 'LDNS_RR_TYPE_NID', resourcerecord.LDNS_RR_TYPE_NID)
__bind(__name__, 'LDNS_RR_TYPE_L32', resourcerecord.LDNS_RR_TYPE_L32)
__bind(__name__, 'LDNS_RR_TYPE_L64', resourcerecord.LDNS_RR_TYPE_L64)
__bind(__name__, 'LDNS_RR_TYPE_LP', resourcerecord.LDNS_RR_TYPE_LP)
__bind(__name__, 'LDNS_RR_TYPE_EUI48', resourcerecord.LDNS_RR_TYPE_EUI48)
__bind(__name__, 'LDNS_RR_TYPE_EUI64', resourcerecord.LDNS_RR_TYPE_EUI64)
__bind(__name__, 'LDNS_RR_TYPE_TKEY', resourcerecord.LDNS_RR_TYPE_TKEY)
__bind(__name__, 'LDNS_RR_TYPE_TSIG', resourcerecord.LDNS_RR_TYPE_TSIG)
__bind(__name__, 'LDNS_RR_TYPE_IXFR', resourcerecord.LDNS_RR_TYPE_IXFR)
__bind(__name__, 'LDNS_RR_TYPE_AXFR', resourcerecord.LDNS_RR_TYPE_AXFR)
__bind(__name__, 'LDNS_RR_TYPE_MAILB', resourcerecord.LDNS_RR_TYPE_MAILB)
__bind(__name__, 'LDNS_RR_TYPE_MAILA', resourcerecord.LDNS_RR_TYPE_MAILA)
__bind(__name__, 'LDNS_RR_TYPE_ANY', resourcerecord.LDNS_RR_TYPE_ANY)
__bind(__name__, 'LDNS_RR_TYPE_URI', resourcerecord.LDNS_RR_TYPE_URI)
__bind(__name__, 'LDNS_RR_TYPE_CAA', resourcerecord.LDNS_RR_TYPE_CAA)
__bind(__name__, 'LDNS_RR_TYPE_TA', resourcerecord.LDNS_RR_TYPE_TA)
__bind(__name__, 'LDNS_RR_TYPE_DLV', resourcerecord.LDNS_RR_TYPE_DLV)
__bind(__name__, 'LDNS_RR_TYPE_NSEC3', resourcerecord.LDNS_RR_TYPE_NSEC3)
__bind(__name__, 'LDNS_RR_TYPE_NSEC3PARAMS', resourcerecord.LDNS_RR_TYPE_NSEC3PARAMS)
__bind(__name__, 'LDNS_RR_TYPE_FIRST', resourcerecord.LDNS_RR_TYPE_FIRST)
__bind(__name__, 'LDNS_RR_TYPE_LAST', resourcerecord.LDNS_RR_TYPE_LAST)
__bind(__name__, 'LDNS_RR_TYPE_COUNT', resourcerecord.LDNS_RR_TYPE_COUNT)

# ldns_enum_status enum, typedef'ed to ldns_status
__bind(__name__, 'LDNS_STATUS_OK', errors.LDNS_STATUS_OK)
__bind(__name__, 'LDNS_STATUS_EMPTY_LABEL', errors.LDNS_STATUS_EMPTY_LABEL)
__bind(__name__, 'LDNS_STATUS_LABEL_OVERFLOW', errors.LDNS_STATUS_LABEL_OVERFLOW)
__bind(__name__, 'LDNS_STATUS_DOMAINNAME_OVERFLOW', errors.LDNS_STATUS_DOMAINNAME_OVERFLOW)
__bind(__name__, 'LDNS_STATUS_DOMAINNAME_UNDERFLOW', errors.LDNS_STATUS_DOMAINNAME_UNDERFLOW)
__bind(__name__, 'LDNS_STATUS_DDD_OVERFLOW', errors.LDNS_STATUS_DDD_OVERFLOW)
__bind(__name__, 'LDNS_STATUS_PACKET_OVERFLOW', errors.LDNS_STATUS_PACKET_OVERFLOW)
__bind(__name__, 'LDNS_STATUS_INVALID_POINTER', errors.LDNS_STATUS_INVALID_POINTER)
__bind(__name__, 'LDNS_STATUS_MEM_ERR', errors.LDNS_STATUS_MEM_ERR)
__bind(__name__, 'LDNS_STATUS_INTERNAL_ERR', errors.LDNS_STATUS_INTERNAL_ERR)
__bind(__name__, 'LDNS_STATUS_SSL_ERR', errors.LDNS_STATUS_SSL_ERR)
__bind(__name__, 'LDNS_STATUS_ERR', errors.LDNS_STATUS_ERR)
__bind(__name__, 'LDNS_STATUS_INVALID_INT', errors.LDNS_STATUS_INVALID_INT)
__bind(__name__, 'LDNS_STATUS_INVALID_IP4', errors.LDNS_STATUS_INVALID_IP4)
__bind(__name__, 'LDNS_STATUS_INVALID_IP6', errors.LDNS_STATUS_INVALID_IP6)
__bind(__name__, 'LDNS_STATUS_INVALID_STR', errors.LDNS_STATUS_INVALID_STR)
__bind(__name__, 'LDNS_STATUS_INVALID_B32_EXT', errors.LDNS_STATUS_INVALID_B32_EXT)
__bind(__name__, 'LDNS_STATUS_INVALID_B64', errors.LDNS_STATUS_INVALID_B64)
__bind(__name__, 'LDNS_STATUS_INVALID_HEX', errors.LDNS_STATUS_INVALID_HEX)
__bind(__name__, 'LDNS_STATUS_INVALID_TIME', errors.LDNS_STATUS_INVALID_TIME)
__bind(__name__, 'LDNS_STATUS_NETWORK_ERR', errors.LDNS_STATUS_NETWORK_ERR)
__bind(__name__, 'LDNS_STATUS_ADDRESS_ERR', errors.LDNS_STATUS_ADDRESS_ERR)
__bind(__name__, 'LDNS_STATUS_FILE_ERR', errors.LDNS_STATUS_FILE_ERR)
__bind(__name__, 'LDNS_STATUS_UNKNOWN_INET', errors.LDNS_STATUS_UNKNOWN_INET)
__bind(__name__, 'LDNS_STATUS_NOT_IMPL', errors.LDNS_STATUS_NOT_IMPL)
__bind(__name__, 'LDNS_STATUS_NULL', errors.LDNS_STATUS_NULL)
__bind(__name__, 'LDNS_STATUS_CRYPTO_UNKNOWN_ALGO', errors.LDNS_STATUS_CRYPTO_UNKNOWN_ALGO)
__bind(__name__, 'LDNS_STATUS_CRYPTO_ALGO_NOT_IMPL', errors.LDNS_STATUS_CRYPTO_ALGO_NOT_IMPL)
__bind(__name__, 'LDNS_STATUS_CRYPTO_NO_RRSIG', errors.LDNS_STATUS_CRYPTO_NO_RRSIG)
__bind(__name__, 'LDNS_STATUS_CRYPTO_NO_DNSKEY', errors.LDNS_STATUS_CRYPTO_NO_DNSKEY)
__bind(__name__, 'LDNS_STATUS_CRYPTO_NO_TRUSTED_DNSKEY', errors.LDNS_STATUS_CRYPTO_NO_TRUSTED_DNSKEY)
__bind(__name__, 'LDNS_STATUS_CRYPTO_NO_DS', errors.LDNS_STATUS_CRYPTO_NO_DS)
__bind(__name__, 'LDNS_STATUS_CRYPTO_NO_TRUSTED_DS', errors.LDNS_STATUS_CRYPTO_NO_TRUSTED_DS)
__bind(__name__, 'LDNS_STATUS_CRYPTO_NO_MATCHING_KEYTAG_DNSKEY', errors.LDNS_STATUS_CRYPTO_NO_MATCHING_KEYTAG_DNSKEY)
__bind(__name__, 'LDNS_STATUS_CRYPTO_VALIDATED', errors.LDNS_STATUS_CRYPTO_VALIDATED)
__bind(__name__, 'LDNS_STATUS_CRYPTO_BOGUS', errors.LDNS_STATUS_CRYPTO_BOGUS)
__bind(__name__, 'LDNS_STATUS_CRYPTO_SIG_EXPIRED', errors.LDNS_STATUS_CRYPTO_SIG_EXPIRED)
__bind(__name__, 'LDNS_STATUS_CRYPTO_SIG_NOT_INCEPTED', errors.LDNS_STATUS_CRYPTO_SIG_NOT_INCEPTED)
__bind(__name__, 'LDNS_STATUS_CRYPTO_TSIG_BOGUS', errors.LDNS_STATUS_CRYPTO_TSIG_BOGUS)
__bind(__name__, 'LDNS_STATUS_CRYPTO_TSIG_ERR', errors.LDNS_STATUS_CRYPTO_TSIG_ERR)
__bind(__name__, 'LDNS_STATUS_CRYPTO_EXPIRATION_BEFORE_INCEPTION', errors.LDNS_STATUS_CRYPTO_EXPIRATION_BEFORE_INCEPTION)
__bind(__name__, 'LDNS_STATUS_CRYPTO_TYPE_COVERED_ERR', errors.LDNS_STATUS_CRYPTO_TYPE_COVERED_ERR)
__bind(__name__, 'LDNS_STATUS_ENGINE_KEY_NOT_LOADED', errors.LDNS_STATUS_ENGINE_KEY_NOT_LOADED)
__bind(__name__, 'LDNS_STATUS_NSEC3_ERR', errors.LDNS_STATUS_NSEC3_ERR)
__bind(__name__, 'LDNS_STATUS_RES_NO_NS', errors.LDNS_STATUS_RES_NO_NS)
__bind(__name__, 'LDNS_STATUS_RES_QUERY', errors.LDNS_STATUS_RES_QUERY)
__bind(__name__, 'LDNS_STATUS_WIRE_INCOMPLETE_HEADER', errors.LDNS_STATUS_WIRE_INCOMPLETE_HEADER)
__bind(__name__, 'LDNS_STATUS_WIRE_INCOMPLETE_QUESTION', errors.LDNS_STATUS_WIRE_INCOMPLETE_QUESTION)
__bind(__name__, 'LDNS_STATUS_WIRE_INCOMPLETE_ANSWER', errors.LDNS_STATUS_WIRE_INCOMPLETE_ANSWER)
__bind(__name__, 'LDNS_STATUS_WIRE_INCOMPLETE_AUTHORITY', errors.LDNS_STATUS_WIRE_INCOMPLETE_AUTHORITY)
__bind(__name__, 'LDNS_STATUS_WIRE_INCOMPLETE_ADDITIONAL', errors.LDNS_STATUS_WIRE_INCOMPLETE_ADDITIONAL)
__bind(__name__, 'LDNS_STATUS_NO_DATA', errors.LDNS_STATUS_NO_DATA)
__bind(__name__, 'LDNS_STATUS_CERT_BAD_ALGORITHM', errors.LDNS_STATUS_CERT_BAD_ALGORITHM)
__bind(__name__, 'LDNS_STATUS_SYNTAX_TYPE_ERR', errors.LDNS_STATUS_SYNTAX_TYPE_ERR)
__bind(__name__, 'LDNS_STATUS_SYNTAX_CLASS_ERR', errors.LDNS_STATUS_SYNTAX_CLASS_ERR)
__bind(__name__, 'LDNS_STATUS_SYNTAX_TTL_ERR', errors.LDNS_STATUS_SYNTAX_TTL_ERR)
__bind(__name__, 'LDNS_STATUS_SYNTAX_INCLUDE_ERR_NOTIMPL', errors.LDNS_STATUS_SYNTAX_INCLUDE_ERR_NOTIMPL)
__bind(__name__, 'LDNS_STATUS_SYNTAX_RDATA_ERR', errors.LDNS_STATUS_SYNTAX_RDATA_ERR)
__bind(__name__, 'LDNS_STATUS_SYNTAX_DNAME_ERR', errors.LDNS_STATUS_SYNTAX_DNAME_ERR)
__bind(__name__, 'LDNS_STATUS_SYNTAX_VERSION_ERR', errors.LDNS_STATUS_SYNTAX_VERSION_ERR)
__bind(__name__, 'LDNS_STATUS_SYNTAX_ALG_ERR', errors.LDNS_STATUS_SYNTAX_ALG_ERR)
__bind(__name__, 'LDNS_STATUS_SYNTAX_KEYWORD_ERR', errors.LDNS_STATUS_SYNTAX_KEYWORD_ERR)
__bind(__name__, 'LDNS_STATUS_SYNTAX_TTL', errors.LDNS_STATUS_SYNTAX_TTL)
__bind(__name__, 'LDNS_STATUS_SYNTAX_ORIGIN', errors.LDNS_STATUS_SYNTAX_ORIGIN)
__bind(__name__, 'LDNS_STATUS_SYNTAX_INCLUDE', errors.LDNS_STATUS_SYNTAX_INCLUDE)
__bind(__name__, 'LDNS_STATUS_SYNTAX_EMPTY', errors.LDNS_STATUS_SYNTAX_EMPTY)
__bind(__name__, 'LDNS_STATUS_SYNTAX_ITERATIONS_OVERFLOW', errors.LDNS_STATUS_SYNTAX_ITERATIONS_OVERFLOW)
__bind(__name__, 'LDNS_STATUS_SYNTAX_MISSING_VALUE_ERR', errors.LDNS_STATUS_SYNTAX_MISSING_VALUE_ERR)
__bind(__name__, 'LDNS_STATUS_SYNTAX_INTEGER_OVERFLOW', errors.LDNS_STATUS_SYNTAX_INTEGER_OVERFLOW)
__bind(__name__, 'LDNS_STATUS_SYNTAX_BAD_ESCAPE', errors.LDNS_STATUS_SYNTAX_BAD_ESCAPE)
__bind(__name__, 'LDNS_STATUS_SOCKET_ERROR', errors.LDNS_STATUS_SOCKET_ERROR)
__bind(__name__, 'LDNS_STATUS_SYNTAX_ERR', errors.LDNS_STATUS_SYNTAX_ERR)
__bind(__name__, 'LDNS_STATUS_DNSSEC_EXISTENCE_DENIED', errors.LDNS_STATUS_DNSSEC_EXISTENCE_DENIED)
__bind(__name__, 'LDNS_STATUS_DNSSEC_NSEC_RR_NOT_COVERED', errors.LDNS_STATUS_DNSSEC_NSEC_RR_NOT_COVERED)
__bind(__name__, 'LDNS_STATUS_DNSSEC_NSEC_WILDCARD_NOT_COVERED', errors.LDNS_STATUS_DNSSEC_NSEC_WILDCARD_NOT_COVERED)
__bind(__name__, 'LDNS_STATUS_DNSSEC_NSEC3_ORIGINAL_NOT_FOUND', errors.LDNS_STATUS_DNSSEC_NSEC3_ORIGINAL_NOT_FOUND)
__bind(__name__, 'LDNS_STATUS_MISSING_RDATA_FIELDS_RRSIG', errors.LDNS_STATUS_MISSING_RDATA_FIELDS_RRSIG)
__bind(__name__, 'LDNS_STATUS_MISSING_RDATA_FIELDS_KEY', errors.LDNS_STATUS_MISSING_RDATA_FIELDS_KEY)
__bind(__name__, 'LDNS_STATUS_CRYPTO_SIG_EXPIRED_WITHIN_MARGIN', errors.LDNS_STATUS_CRYPTO_SIG_EXPIRED_WITHIN_MARGIN)
__bind(__name__, 'LDNS_STATUS_CRYPTO_SIG_NOT_INCEPTED_WITHIN_MARGIN', errors.LDNS_STATUS_CRYPTO_SIG_NOT_INCEPTED_WITHIN_MARGIN)
__bind(__name__, 'LDNS_STATUS_DANE_STATUS_MESSAGES', errors.LDNS_STATUS_DANE_STATUS_MESSAGES)
__bind(__name__, 'LDNS_STATUS_DANE_UNKNOWN_CERTIFICATE_USAGE', errors.LDNS_STATUS_DANE_UNKNOWN_CERTIFICATE_USAGE)
__bind(__name__, 'LDNS_STATUS_DANE_UNKNOWN_SELECTOR', errors.LDNS_STATUS_DANE_UNKNOWN_SELECTOR)
__bind(__name__, 'LDNS_STATUS_DANE_UNKNOWN_MATCHING_TYPE', errors.LDNS_STATUS_DANE_UNKNOWN_MATCHING_TYPE)
__bind(__name__, 'LDNS_STATUS_DANE_UNKNOWN_PROTOCOL', errors.LDNS_STATUS_DANE_UNKNOWN_PROTOCOL)
__bind(__name__, 'LDNS_STATUS_DANE_UNKNOWN_TRANSPORT', errors.LDNS_STATUS_DANE_UNKNOWN_TRANSPORT)
__bind(__name__, 'LDNS_STATUS_DANE_MISSING_EXTRA_CERTS', errors.LDNS_STATUS_DANE_MISSING_EXTRA_CERTS)
__bind(__name__, 'LDNS_STATUS_DANE_EXTRA_CERTS_NOT_USED', errors.LDNS_STATUS_DANE_EXTRA_CERTS_NOT_USED)
__bind(__name__, 'LDNS_STATUS_DANE_OFFSET_OUT_OF_RANGE', errors.LDNS_STATUS_DANE_OFFSET_OUT_OF_RANGE)
__bind(__name__, 'LDNS_STATUS_DANE_INSECURE', errors.LDNS_STATUS_DANE_INSECURE)
__bind(__name__, 'LDNS_STATUS_DANE_BOGUS', errors.LDNS_STATUS_DANE_BOGUS)
__bind(__name__, 'LDNS_STATUS_DANE_TLSA_DID_NOT_MATCH', errors.LDNS_STATUS_DANE_TLSA_DID_NOT_MATCH)
__bind(__name__, 'LDNS_STATUS_DANE_NON_CA_CERTIFICATE', errors.LDNS_STATUS_DANE_NON_CA_CERTIFICATE)
__bind(__name__, 'LDNS_STATUS_DANE_PKIX_DID_NOT_VALIDATE', errors.LDNS_STATUS_DANE_PKIX_DID_NOT_VALIDATE)
__bind(__name__, 'LDNS_STATUS_DANE_PKIX_NO_SELF_SIGNED_TRUST_ANCHOR', errors.LDNS_STATUS_DANE_PKIX_NO_SELF_SIGNED_TRUST_ANCHOR)
__bind(__name__, 'LDNS_STATUS_EXISTS_ERR', errors.LDNS_STATUS_EXISTS_ERR)
__bind(__name__, 'LDNS_STATUS_INVALID_ILNP64', errors.LDNS_STATUS_INVALID_ILNP64)
__bind(__name__, 'LDNS_STATUS_INVALID_EUI48', errors.LDNS_STATUS_INVALID_EUI48)
__bind(__name__, 'LDNS_STATUS_INVALID_EUI64', errors.LDNS_STATUS_INVALID_EUI64)
__bind(__name__, 'LDNS_STATUS_WIRE_RDATA_ERR', errors.LDNS_STATUS_WIRE_RDATA_ERR)
__bind(__name__, 'LDNS_STATUS_INVALID_TAG', errors.LDNS_STATUS_INVALID_TAG)
__bind(__name__, 'LDNS_STATUS_TYPE_NOT_IN_BITMAP', errors.LDNS_STATUS_TYPE_NOT_IN_BITMAP)
__bind(__name__, 'LDNS_STATUS_INVALID_RDF_TYPE', errors.LDNS_STATUS_INVALID_RDF_TYPE)
__bind(__name__, 'LDNS_STATUS_RDATA_OVERFLOW', errors.LDNS_STATUS_RDATA_OVERFLOW)
