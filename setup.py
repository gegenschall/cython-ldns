import sys
from setuptools import setup
from distutils.extension import Extension
try:
    from Cython.Distutils import build_ext
    from Cython.Build import cythonize
    HAS_CYTHON = True
except ImportError:
    HAS_CYTHON = False

# Is debug set?
runtime_library_dirs = []
if '--debug' in sys.argv:
    runtime_library_dirs = ['/usr/local/debug/libldns/lib']

ext = ".pyx" if HAS_CYTHON else ".c"
extensions = [
    Extension(
        "*",
        ["ldns/*" + ext],
        runtime_library_dirs=runtime_library_dirs,
        libraries=["ldns"]
    ),
    # Extension(
    #     "*",
    #     ["ldns/dnssec/*" + ext],
    #     runtime_library_dirs=runtime_library_dirs,
    #     libraries=["ldns"]
    # ),
]

if HAS_CYTHON:
    extensions = cythonize(extensions)

setup(
    name='ldns',
    version='0.1.0',
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
    install_requires=(
        'ipaddr>=2.1.11',
    ),
    keywords='ldns network dns dnssec nameserver',
    author='Zdenek Vasicek, Karel Slany',
    author_email='vasicek AT fit.vutbr.cz, slany AT fit.vutbr.cz',
    url='http://www.nlnetlabs.nl/projects/ldns/',
    license='BSD',
    ext_modules=extensions,
    zip_safe=False,
    cmdclass={'build_ext': build_ext},
)

