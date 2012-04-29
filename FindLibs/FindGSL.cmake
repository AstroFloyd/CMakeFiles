## FindGSL.cmake:
## Check for the presence of the GSL headers and libraries
## AF, 26/10/2011

# This CMake module defines the following variables:
#  GSL_FOUND        =  Libraries and headers found; TRUE/FALSE
#  GSL_INCLUDES     =  Path to the GSL header files
#  GSL_LIBRARIES    =  Path to all parts of the GSL libraries
#  GSL_LIBRARY_DIR  =  Path to the directory containing the GSL libraries



# Standard locations where to look for required components:
include( CMakeLocations )



# Check for the header files:
find_path( GSL_INCLUDES 
  NAMES gsl_version.h
  PATHS ${include_locations} ${lib_locations}
  PATH_SUFFIXES gsl
  )



# Check for the libraries:
set( GSL_LIBRARIES "" )

find_library( GSL_LIBRARY
  NAMES gsl
  PATHS ${lib_locations}
  #PATH_SUFFIXES 
  NO_DEFAULT_PATH
  )

# Libraries found?
if( GSL_LIBRARY )
  
  list( APPEND GSL_LIBRARIES ${GSL_LIBRARY} )
  get_filename_component( GSL_LIBRARY_DIR ${GSL_LIBRARY} PATH )
  
endif( GSL_LIBRARY )




# Headers AND libraries found?
if( GSL_INCLUDES AND GSL_LIBRARIES )
  
  # yes!
  set( GSL_FOUND TRUE )
  
else( GSL_INCLUDES AND GSL_LIBRARIES )
  
  # no!
  set( GSL_FOUND FALSE )
  
  if( NOT GSL_FIND_QUIETLY )
    if( NOT GSL_INCLUDES )
      message( STATUS "!! Unable to find GSL header files!" )
    endif( NOT GSL_INCLUDES )
    if( NOT GSL_LIBRARIES )
      message( STATUS "!! Unable to find GSL library files!" )
    endif( NOT GSL_LIBRARIES )
  endif( NOT GSL_FIND_QUIETLY )
  
endif( GSL_INCLUDES AND GSL_LIBRARIES )




# Headers AND libraries found!
if( GSL_FOUND )
  
  if( NOT GSL_FIND_QUIETLY )
    message( STATUS "" )
    message( STATUS "Found components for GSL:" )
    message( STATUS "* GSL_INCLUDES  = ${GSL_INCLUDES}" )
    message( STATUS "* GSL_LIBRARIES = ${GSL_LIBRARIES}" )
  endif( NOT GSL_FIND_QUIETLY )
  
else( GSL_FOUND )
  
  if( GSL_FIND_REQUIRED )
    message( FATAL_ERROR "!! Could not find GSL headers or libraries!" )
  endif( GSL_FIND_REQUIRED )
  
endif( GSL_FOUND )



# Mark as advanced options in ccmake:
mark_as_advanced( 
  GSL_INCLUDES
  GSL_LIBRARIES
  GSL_LIBRARY
  GSL_LIBRARY_DIR
  )

