#ifndef __PYX_HAVE__ldns__ldns
#define __PYX_HAVE__ldns__ldns


/* "ldns/ldns.pyx":4
 * 
 * 
 * cdef public enum ldns_rr_class:             # <<<<<<<<<<<<<<
 *     LDNS_RR_CLASS_IN
 */
enum ldns_rr_class {
  LDNS_RR_CLASS_IN
};

#ifndef __PYX_HAVE_API__ldns__ldns

#ifndef __PYX_EXTERN_C
  #ifdef __cplusplus
    #define __PYX_EXTERN_C extern "C"
  #else
    #define __PYX_EXTERN_C extern
  #endif
#endif

#endif /* !__PYX_HAVE_API__ldns__ldns */

#if PY_MAJOR_VERSION < 3
PyMODINIT_FUNC initldns(void);
#else
PyMODINIT_FUNC PyInit_ldns(void);
#endif

#endif /* !__PYX_HAVE__ldns__ldns */
