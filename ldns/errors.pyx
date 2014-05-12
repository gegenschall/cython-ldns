from ldns.errors cimport *

def errorstr_for_id(int err):
    return ldns_get_errorstr_by_id(<ldns_status>err)


class InvalidTypeOrClassError(Exception):
    pass

class LDNSStatusError(Exception):
    def __init__(self, status):
        self.status = status
        self.err = errorstr_for_id(status)

    def __str__(self):
        return "ldns error %d: %s" % (self.status, self.err)
