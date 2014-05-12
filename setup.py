from setuptools import setup
from distutils.extension import Extension
try:
    from Cython.Distutils import build_ext
    from Cython.Build import cythonize
    has_cython = True
except ImportError:
    has_cython = False

version = '1.6.17'


ldns_module = Extension(
    "ldns.__init__",
    ["ldns/__init__.pyx"],
    libraries=["ldns"]
)
ldns_packet_module = Extension(
    "ldns.packet",
    ["ldns/packet.pyx"],
    libraries=["ldns"]
)
ldns_rr_module = Extension(
    "ldns.resourcerecord",
    ["ldns/resourcerecord.pyx"],
    libraries=["ldns"],
)
ldns_error_module = Extension(
    "ldns.errors",
    ["ldns/errors.pyx"],
    libraries=["ldns"]
)

ldns_rdata_module = Extension(
    "ldns.rdata",
    ["ldns/rdata.pyx"],
    libraries=["ldns"]
)
ldns_dname_module = Extension(
    "ldns.dname",
    ["ldns/dname.pyx"],
    libraries=["ldns"]
)

setup(name='ldns',
    version=version,
    description="",
    long_description="""The goal of ldns is to simplify DNS programming, it supports recent RFCs like the
    DNSSEC documents, and allows developers to easily create software conforming to current RFCs, and
    experimental software for current Internet Drafts. A secondary benefit of using ldns is speed;
    ldns is written in C it should be a lot faster than Perl.
    The first major tool to use ldns is Drill, from which part of the library was derived. From version
    1.0.0 on, drill is be included in the ldns release and will not be distributed separately anymore.
    Its version number will follow that of ldns. The library also includes some other examples and tools
    to show how it can be used.
    ldns depends on OpenSSL for its crypto functions. It can be compiled without OpenSSL, but of course
    you'll lose the ability to perform any cryptographic functions.
    """,
    classifiers=[
        'Development Status :: 6 - Mature',
        'License :: OSI Approved :: BSD License',
        'Programming Language :: Python :: 2',
        'Programming Language :: Python :: 3',
        'Topic :: Internet :: Name Service (DNS)'
    ],
    keywords='ldns network dns dnssec nameserver',
    author='Zdenek Vasicek, Karel Slany',
    author_email='vasicek AT fit.vutbr.cz, slany AT fit.vutbr.cz',
    url='http://www.nlnetlabs.nl/projects/ldns/',
    license='BSD',
    #py_modules=['ldns'],
    ext_modules=cythonize([
        ldns_module,
        ldns_packet_module,
        ldns_dname_module,
        ldns_rr_module,
        ldns_error_module,
        ldns_rdata_module
    ]),
    zip_safe=False,
    cmdclass = {'build_ext' : build_ext},
)

