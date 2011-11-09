## CompilerFlags_C.cmake
## Compiler flags for C compilers
## Currently, specific flags for gcc, clang and icc are provided


# Get compiler name:
get_filename_component( C_COMPILER_NAME ${CMAKE_C_COMPILER} NAME )


######################################################################################################################################################
#  Specific options per compiler:
######################################################################################################################################################
if( C_COMPILER_NAME MATCHES "gcc" OR C_COMPILER_NAME MATCHES "clang" )
  
  set( CMAKE_C_FLAGS_ALL "-std=c99 -pedantic" )
  #set( CMAKE_C_FLAGS_ALL " ${CMAKE_C_FLAGS_ALL} -fwhole-program" )
  set( CMAKE_C_FLAGS "-pipe -funroll-all-loops" )
  set( CMAKE_C_FLAGS_RELEASE "-pipe -funroll-all-loops" )
  set( CMAKE_C_FLAGS_DEBUG "-g -ffpe-trap=zero,invalid -fsignaling-nans -fbacktrace" )
  set( CMAKE_C_FLAGS_PROFILE "-g -gp" )
  
  
  if(WANT_SSE42 )
    set( SSE_FLAGS "-msse4.2" )
  endif(WANT_SSE42 )
  
  if( WANT_OPENMP )
    set( OPENMP_FLAGS "-fopenmp" )
  endif( WANT_OPENMP )
  
  if( WANT_STATIC )
    set( STATIC_FLAGS "-static" )
  endif( WANT_STATIC )
  
  if( WANT_CHECKS )
    set( CHECK_FLAGS "-fbounds-check -ffpe-trap=zero,invalid -fsignaling-nans -fbacktrace" ) # v.4.4
    #set( CHECK_FLAGS "-fcheck=all -ffpe-trap=zero,invalid -fsignaling-nans -fbacktrace" )  # v.4.5
    set( OPT_FLAGS "-O0" )
  else( WANT_CHECKS )
    set( OPT_FLAGS "-O2" )
  endif( WANT_CHECKS )
  
  if( WANT_WARNINGS )
    set( WARN_FLAGS "-Wall -Wextra" )
  endif( WANT_WARNINGS )
  if( STOP_ON_WARNING )
    set( WARN_FLAGS "${WARN_FLAGS} -Werror" )
  endif( STOP_ON_WARNING )
  
  if( WANT_LIBRARY )
    set( LIB_FLAGS "-fPIC -g" )
  endif( WANT_LIBRARY )
  
  
  # Package-specific flags:
  set( PACKAGE_FLAGS "" )
  
  
  ####################################################################################################################################################
elseif( C_COMPILER_NAME MATCHES "icc" )
  
  
  set( CMAKE_C_FLAGS_ALL "-std=c99 -mcmodel=medium" )
  set( CMAKE_C_FLAGS "-vec-guard-write -funroll-loops -align -ip" )
  set( CMAKE_C_FLAGS_RELEASE "-vec-guard-write -funroll-loops -align -ip" )
  set( CMAKE_C_FLAGS_DEBUG "-g -traceback" )
  set( CMAKE_C_FLAGS_PROFILE "-g -gp" )
  
  # !!! HOST_OPT overrules SSE42, as icc would !!!
  if(WANT_SSE42 )
    set( SSE_FLAGS "-axSSE4.2,SSSE3" )
  endif(WANT_SSE42 )
  if(WANT_HOST_OPT)
    set (SSE_FLAGS "-xHost")
  endif(WANT_HOST_OPT)
  
  if(WANT_IPO )
    set( IPO_FLAGS "-ipo" )
  endif(WANT_IPO )
  
  if( WANT_OPENMP )
    set( OPENMP_FLAGS "-openmp -openmp-report0" )
    message( STATUS "Linking with OpenMP support" )
  endif( WANT_OPENMP )
  
  if( WANT_STATIC )
    set( STATIC_FLAGS "-static" )
  endif( WANT_STATIC )
  
  if( WANT_CHECKS )
    set( CHECK_FLAGS "-ftrapuv -check-uninit -traceback" )
    set( OPT_FLAGS "-O0" )
  else( WANT_CHECKS )
    set( OPT_FLAGS "-O2" )
  endif( WANT_CHECKS )
  
  if( WANT_WARNINGS )
    set( WARN_FLAGS "-Wall -diag-disable 6894,8290" )
    #set( WARN_FLAGS "${WARN_FLAGS} -Wcheck" )
    #set( WARN_FLAGS "${WARN_FLAGS} -Wremarks" )
  endif( WANT_WARNINGS )
  if( STOP_ON_WARNING )
    set( WARN_FLAGS "${WARN_FLAGS} -Werror" )
  endif( STOP_ON_WARNING )
  
  if( WANT_LIBRARY )
    set( LIB_FLAGS "-fPIC -g" )
  endif( WANT_LIBRARY )
  
  
  # Package-specific flags:
  set( PACKAGE_FLAGS "" )
  
  
  ####################################################################################################################################################
else( C_COMPILER_NAME MATCHES "gcc" OR C_COMPILER_NAME MATCHES "clang" )
  
  
  message( STATUS "" )
  message( STATUS "WARNING: C compiler not recognised, no specific options known for this compiler" )
  message( STATUS "C compiler: " ${C_COMPILER_NAME} )
  message( STATUS "CMAKE_C_COMPILER full path: " ${CMAKE_C_COMPILER} )
  message( STATUS "No optimized C compiler flags are known, we just try -O2..." )
  #set( CMAKE_C_FLAGS_ALL " -std=c99" )
  set( CMAKE_C_FLAGS_RELEASE "" )
  set( CMAKE_C_FLAGS_DEBUG "-g" )
  set( OPT_FLAGS "-O2" )
  
  
  # Package-specific flags:
  set( PACKAGE_FLAGS "" )
  
  
endif( C_COMPILER_NAME MATCHES "gcc" OR C_COMPILER_NAME MATCHES "clang" )
######################################################################################################################################################





######################################################################################################################################################
#  Put everything together:
######################################################################################################################################################

set( USER_FLAGS "${OPT_FLAGS} ${LIB_FLAGS} ${CHECK_FLAGS} ${WARN_FLAGS} ${SSE_FLAGS} ${IPO_FLAGS} ${OPENMP_FLAGS} ${STATIC_FLAGS} ${INCLUDE_FLAGS} ${PACKAGE_FLAGS}" )

set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS_ALL} ${CMAKE_C_FLAGS} ${USER_FLAGS}" )
set( CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_ALL} ${CMAKE_C_FLAGS_RELEASE} ${USER_FLAGS}" )

set( CMAKE_C_FLAGS_RELWITHDEBINFO "${CMAKE_C_FLAGS_RELEASE} -g" )




######################################################################################################################################################
#  Report what's going on:
######################################################################################################################################################

message( STATUS "" )
message( STATUS "Using C compiler: " ${C_COMPILER_NAME} " (" ${CMAKE_C_COMPILER}")" )

if( WANT_CHECKS )
  message( STATUS "* Compiling with run-time checks:  ${CHECK_FLAGS}" )
endif( WANT_CHECKS )
if( WANT_WARNINGS )
  message( STATUS "* Compiling with warnings:  ${WARN_FLAGS}" )
endif( WANT_WARNINGS )
if( WANT_LIBRARY )
  message( STATUS "* Compiling with library options:  ${LIB_FLAGS}" )
endif( WANT_LIBRARY )
if( WANT_STATIC )
  message( STATUS "* Linking statically:  ${STATIC_FLAGS}" )
endif( WANT_STATIC )


message( STATUS "* Compiler flags used:  ${CMAKE_C_FLAGS}" )
message( STATUS "" )



