import fileinput

for line in fileinput.input():
    _line = line.strip()
    # super dumb...
    if _line.startswith('//') or _line.startswith('/*') or _line.startswith('*') or _line.startswith('*/'):
        continue

    print line.rstrip()
