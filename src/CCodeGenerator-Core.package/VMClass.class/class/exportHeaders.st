as yet unclassified
exportHeaders

FileStream forceNewFileNamed: 'sq.h' do: [ :f |
	f nextPutAll: 
'#ifndef __sq_h
#define __sq_h

#include <stdlib.h>
#include <math.h>
 
#define SQ_VI_BYTES_PER_WORD 4
#define SIZEOF_VOID_P 4

#if (SQ_VI_BYTES_PER_WORD == 4)
# define SQ_IMAGE32 1
#else
# define SQ_IMAGE64 1
#endif

#if (SIZEOF_VOID_P == 4)
# define SQ_HOST32 1
#elif (SIZEOF_VOID_P == 8)
# define SQ_HOST64 1
#else
# error host is neither 32- nor 64-bit?
#endif

#if defined(SQ_IMAGE32)
typedef int   sqInt;
typedef unsigned int  usqInt;
#elif defined(SQ_HOST64)
typedef long    sqInt;
typedef unsigned long usqInt;
#else
# if (SIZEOF_LONG_LONG != 8)
#   error long long integers are not 64-bits wide?
# endif 
typedef long long   sqInt;
typedef unsigned long long  usqInt;
#endif

#if defined(SQ_IMAGE32)
  typedef int		sqInt;
  typedef unsigned int	usqInt;
# define SQABS abs
#elif defined(SQ_HOST64)
  typedef long		sqInt;
  typedef unsigned long	usqInt;
# define SQABS labs
#elif (SIZEOF_LONG_LONG != 8)
#   error long long integers are not 64-bits wide?
#else
  typedef long long		sqInt;
  typedef unsigned long long	usqInt;
# define SQABS llabs
#endif

# define __stringify(foo) #foo
# define __stringifyNum(n) __stringify(n)

extern void warning(char *);
extern void warningat(char *,int);

# define assert(expr)  ((expr)||(warning(#expr " " __stringifyNum(__LINE__)),0))
# define asserta(expr) ((expr)||(warning(#expr " " __stringifyNum(__LINE__)),0))
/*# define assertf(msg)  (warning(#msg " " __stringifyNum(__LINE__)),0)*/
# define assertl(expr,line)  ((expr)||(warningat(#expr,line),0))
# define assertal(expr,line) ((expr)||(warningat(#expr,line),0))
# define assertfl(msg,line)  (warningat(#msg,line),0)

# define eassert(expr)  (!expensiveAsserts||(expr) \
						 ||(warning(#expr " " __stringifyNum(__LINE__)),0))


#define EXPORT(returnType) returnType

#define null 0

#endif /* __sq_h */
' ]