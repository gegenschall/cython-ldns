import re
import fileinput

SPLITOFF_LEN = 9

TPL = """property {propname}:
    def __get__(self):
        return <{ptype}?>{funcname}(self._{part})

    def __set__(self, {ptype} value not None):
        ldns_{part}_set_{propname}(self._{part}, <{ctype}?>value)"""

for line in fileinput.input():
    # funcname type
    ptype, ctype, funcname = line.strip().split(' ')

    propname = funcname[SPLITOFF_LEN:]

    print TPL.format(propname= propname,
        part='pkt',
        funcname=funcname,
        ptype=ptype,
        ctype=ctype)
    print ""
