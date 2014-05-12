import sys, re

filename = sys.argv[1]
enum_name = sys.argv[2]
if len(sys.argv) == 4:
    module_name = sys.argv[3]

with open(filename, 'r') as f:
    enum_start = False
    typedef = None
    consts = []

    for line in f:
        line = line.strip()

        if enum_start and line == '};':
            enum_start = False

        if enum_start and not line.startswith('/*') and not line.startswith('{') and not line == '':
            const = line.split('=')
            const = const[0].strip()
            consts.append(const)

        if line.startswith('enum ' + enum_name):
            enum_start = True

        if line.startswith('typedef enum ' + enum_name):
            typedef = line.split(" ")[3][:-1]

print "The cdef for your .pxd file:"
print
print "cdef enum %s:" % enum_name
for const in consts:
    print "\t%s" % const
print "ctypedef %s %s" % (enum_name, typedef)

print

print "The mapping for your .pyx file:"
print "# %s enum, typedef'ed to %s" % (enum_name, typedef)
for const in consts:
    print "setattr(sys.modules[__name__], '%s', %s)" % (const, const)
