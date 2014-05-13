# Cython-ldns
This is a rather simple wrapper for the [NLnetLabs ldns](http://www.nlnetlabs.nl/projects/ldns/) C library. ldns ships with a SWiG wrapper for the main C library, which is just a one-to-one mapping of the C API and thus not very pythonic. It is also missing several type-conversions/coercions (using a uint32_t* in Python does not really make sense) and suffers from memory leaks. 
This project aims to solve the shortcomings of the old wrapper by using Cython and a more pythonic approach.

## Warning
__This is a big fat Warning__: This wrapper is currently a Work-In-Progress. Some methods have been implemented but not tested, some have been tested any many are missing. Some have been autoconverted and are thus missing correct type conversions and may/will segfault. __Use on your own risk!__

Things that are currently there:
- __packet__: Methods from packet.c are mostly implemented
- __rdata__ and __dname__: Mostly implemented. Dealloc doesn't work
- __rr__: Most methods making sense for Python usage are implemented, there might be incorrect type mappings
- __errors__: Mostly mapped to Exceptions.

Things that aren't there:
- __buffer__: This will most likely not be exposed to Python.
- __host2xx__ and __wire2xx__: Only specific methods will be exposed. Currently only string transformation and printing methods.
- __zone__: Not started.
- __resolver__: Not started.
- __radix__ and __rbtree__: No priority
- __dnssec_xxx__ and __keys__: Not started

## Installation
At the moment you need Cython, ldns and Python headers installed to be able to run `python setup.py install`. 

For the moment:

1. On Debian based: Install python-dev, ldns-dev, build-essential, cython
2. Clone this repository
3. `python setup.py install` or `python setup.py develop`
4. Send patches :-)

## Usage
To be written.
