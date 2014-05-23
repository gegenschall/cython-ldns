from ldns.errors cimport *

def errorstr_for_id(int err):
    return ldns_get_errorstr_by_id(<ldns_status>err)


class InvalidLDNSTypeError(Exception):
    def __init__(self, type, type2):
        self.type = type
        self.type2 = type2

    def __str__(self):
        return "got invalid ldns RR type: %d. Should be: %d" % (self.type, self.type2)

class InvalidLDNSClassError(Exception):
    def __init__(self, klass):
        self.klass = klass

    def __str__(self):
        return "got invalid ldns RR class: %d" % self.klass

class LDNSStatusError(Exception):
    def __init__(self, status):
        self.status = status
        self.err = errorstr_for_id(status)

    def __str__(self):
        return "ldns error %d: %s" % (self.status, self.err)
