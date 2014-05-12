def _bind_constant_to_module(modulename, constantname, value):
    from sys import modules as __m
    setattr(__m[modulename], constantname, value)
