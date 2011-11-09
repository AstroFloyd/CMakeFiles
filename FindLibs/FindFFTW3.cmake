## FindFFTW3.cmake:
## Check for the presence of the FFTW3 headers and libraries
## AF, 26/10/2011

# This CMake module defines the following variables:
#  FFTW3_FOUND        =  Libraries and headers found; TRUE/FALSE
#  FFTW3_INCLUDES     =  Path to the FFTW3 header files
#  FFTW3_LIBRARIES    =  Path to all parts of the FFTW3 libraries
#  FFTW3_LIBRARY_DIR  =  Path to the directory containing the FFTW3 libraries



# Standard locations where to look for required components:
include( CMakeLocations )



# Check for the header files:
find_path( FFTW3_INCLUDES 
  NAMES fftw3.h
  PATHS ${include_locations} ${lib_locations}
  PATH_SUFFIXES gsl
  )



# Check for the libraries:
set( FFTW3_LIBRARIES "" )

find_library( FFTW3_LIBRARY
  NAMES fftw3
  PATHS ${lib_locations}
  #PATH_SUFFIXES 
  NO_DEFAULT_PATH
  )

# Libraries found?
if( FFTW3_LIBRARY )
  
  list( APPEND FFTW3_LIBRARIES ${FFTW3_LIBRARY} )
  get_filename_component( FFTW3_LIBRARY_DIR ${FFTW3_LIBRARY} PATH )
  
endif( FFTW3_LIBRARY )




# Headers AND libraries found?
if( FFTW3_INCLUDES AND FFTW3_LIBRARIES )
  
  # yes!
  set( FFTW3_FOUND TRUE )
  
else( FFTW3_INCLUDES AND FFTW3_LIBRARIES )
  
  # no!
  set( FFTW3_FOUND FALSE )
  
  if( NOT FFTW3_FIND_QUIETLY )
    if( NOT FFTW3_INCLUDES )
      message( WARNING "Unable to find FFTW3 header files!" )
    endif( NOT FFTW3_INCLUDES )
    if( NOT FFTW3_LIBRARIES )
      message( WARNING "Unable to find FFTW3 library files!" )
    endif( NOT FFTW3_LIBRARIES )
  endif( NOT FFTW3_FIND_QUIETLY )
  
endif( FFTW3_INCLUDES AND FFTW3_LIBRARIES )




# Headers AND libraries found!
if( FFTW3_FOUND )
  
  if( NOT FFTW3_FIND_QUIETLY )
    message( STATUS "" )
    message( STATUS "Found components for FFTW3:" )
    message( STATUS "* FFTW3_INCLUDES  = ${FFTW3_INCLUDES}" )
    message( STATUS "* FFTW3_LIBRARIES = ${FFTW3_LIBRARIES}" )
  endif( NOT FFTW3_FIND_QUIETLY )
  
else( FFTW3_FOUND )
  
  if( FFTW3_FIND_REQUIRED )
    message( FATAL_ERROR "Could not find FFTW3 headers or libraries!" )
  endif( FFTW3_FIND_REQUIRED )
  
endif( FFTW3_FOUND )



# Mark as advanced options in ccmake:
mark_as_advanced( 
  FFTW3_INCLUDES
  FFTW3_LIBRARIES
  FFTW3_LIBRARY
  FFTW3_LIBRARY_DIR
  )

