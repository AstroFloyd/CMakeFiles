# FFLAGS depend on the compiler

if (Fortran_COMPILER_NAME STREQUAL "gfortran")
  
  
  #set (CMAKE_Fortran_FLAGS_ALL "-fwhole-file -std=f2008 -fall-intrinsics -pedantic" )
  set (CMAKE_Fortran_FLAGS_ALL "-fwhole-file -std=f2008 -fall-intrinsics -pedantic -I${LibSUFR_INCLUDES} -I${PGPLOT_INCLUDES}" )
  set (CMAKE_Fortran_FLAGS "-pipe -funroll-all-loops" )
  set (CMAKE_Fortran_FLAGS_RELEASE "-pipe -funroll-all-loops")
  set (CMAKE_Fortran_FLAGS_DEBUG "-g -ffpe-trap=zero,invalid -fsignaling-nans -fbacktrace")
  set (CMAKE_Fortran_FLAGS_PROFILE "-g -gp")
  
  
  
  if(WANT_SSE42)
    set (SSE_FLAGS "-msse4.2")
  endif(WANT_SSE42)
  
  if (WANT_OPENMP)
    set (OPENMP_FLAGS "-fopenmp")
  endif (WANT_OPENMP)
  
  if (WANT_STATIC)
    set (STATIC_FLAGS "-static")
  endif (WANT_STATIC)
  
  if (WANT_CHECKS)
    #set (CHECK_FLAGS "-fbounds-check -ffpe-trap=zero,invalid -fsignaling-nans -fbacktrace")
    #set (CHECK_FLAGS "-O0 -fbounds-check -ffpe-trap=zero,invalid -fsignaling-nans -fbacktrace") # v.4.4
    set (CHECK_FLAGS "-O0 -fcheck=all -ffpe-trap=zero,invalid -fsignaling-nans -fbacktrace")  # From v.4.5
  else (WANT_CHECKS)
    set (CHECK_FLAGS "-O2")
  endif (WANT_CHECKS)
  
  if (WANT_WARNINGS)
    set (WARN_FLAGS "-Wall -Wextra")
  endif (WANT_WARNINGS)
  
  #if (WANT_LIBRARY)
  #set (LIB_FLAGS "-fPIC")
  #endif (WANT_LIBRARY)
  
elseif (Fortran_COMPILER_NAME STREQUAL "ifort")
  
  #set (CMAKE_Fortran_FLAGS_ALL "-stand f03 -diag-disable 6894 -nogen-interfaces" )
  set (CMAKE_Fortran_FLAGS_ALL "-stand f03 -diag-disable 6894 -nogen-interfaces -I${LibSUFR_INCLUDES} -I${PGPLOT_INCLUDES}" )
  #set (CMAKE_Fortran_FLAGS "-vec-guard-write -fpconstant -funroll-loops -align all -ip")
  set (CMAKE_Fortran_FLAGS_RELEASE "-vec-guard-write -fpconstant -extend_source -funroll-loops -align all -ip")
  set (CMAKE_Fortran_FLAGS_DEBUG "-g -traceback")
  set (CMAKE_Fortran_FLAGS_PROFILE "-g -gp")
  
  if(WANT_SSE42)
    set (SSE_FLAGS "-axSSE4.2,SSSE3")
  endif(WANT_SSE42)
  
  if(WANT_IPO)
    set (IPO_FLAGS "-ipo")
  endif(WANT_IPO)
  
  if (WANT_STRICT_FLOATS)
    set (FP_FLAGS "-fp-model strict")
  endif (WANT_STRICT_FLOATS)

  if (WANT_OPENMP)
    set (OPENMP_FLAGS "-openmp -openmp-report2")
  endif (WANT_OPENMP)
  
  if (WANT_STATIC)
    set (STATIC_FLAGS "-static")
  endif (WANT_STATIC)
  
  if (WANT_CHECKS)
    #set (CHECK_FLAGS "-ftrapuv -check all -traceback")
    set (CHECK_FLAGS "-O0 -ftrapuv -check all -check noarg_temp_created -traceback")
  else (WANT_CHECKS)
    set (CHECK_FLAGS "-O2")
  endif (WANT_CHECKS)
  
  if (WANT_WARNINGS)
    set (WARN_FLAGS "-warn all")
  endif (WANT_WARNINGS)
  
  #if (WANT_LIBRARY)
  #set (LIB_FLAGS "-fPIC")
  #endif (WANT_LIBRARY)
  
else (Fortran_COMPILER_NAME STREQUAL "gfortran")
  
  message ("CMAKE_Fortran_COMPILER full path: " ${CMAKE_Fortran_COMPILER})
  message ("Fortran compiler: " ${Fortran_COMPILER_NAME})
  message ("No optimized Fortran compiler flags are known, we just try -O2...")
  set (CMAKE_Fortran_FLAGS "-O2")
  set (CMAKE_Fortran_FLAGS_RELEASE "-O2")
  set (CMAKE_Fortran_FLAGS_DEBUG "-O0 -g")
  
endif (Fortran_COMPILER_NAME STREQUAL "gfortran")



set (USER_FLAGS "${LIB_FLAGS} ${CHECK_FLAGS} ${WARN_FLAGS} ${SSE_FLAGS} ${IPO_FLAGS} ${FP_FLAGS} ${OPENMP_FLAGS} ${STATIC_FLAGS}")

set (CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS_ALL} ${CMAKE_Fortran_FLAGS} ${USER_FLAGS}")
set (CMAKE_Fortran_FLAGS_RELEASE "${CMAKE_Fortran_FLAGS_ALL} ${CMAKE_Fortran_FLAGS_RELEASE} ${USER_FLAGS}")

set (CMAKE_Fortran_FLAGS_RELWITHDEBINFO "${CMAKE_Fortran_FLAGS_RELEASE} -g")

#message (${CMAKE_Fortran_FLAGS})