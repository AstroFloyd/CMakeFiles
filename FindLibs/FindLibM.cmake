# Check for the presence of the LibM headers and libraries
# AF, 26/10/2011
#
# This CMake module defines the following variables:
#  LibM_FOUND        =  Libraries and headers found; TRUE/FALSE
#  LibM_INCLUDES     =  Path to the LibM header files
#  LibM_LIBRARIES    =  Path to all parts of the LibM libraries
#  LibM_LIBRARY_DIR  =  Path to the directory containing the LibM libraries



# Standard locations where to look for required components:
include( CMakeLocations )



# Check for the header files:
find_path( LibM_INCLUDES 
  NAMES math.h
  PATHS ${include_locations} ${lib_locations}
  PATH_SUFFIXES
  )
#set( LibM_INCLUDES TRUE )



# Check for the libraries:
set( LibM_LIBRARIES "" )

find_library( LibM_LIBRARY
  NAMES m
  PATHS ${lib_locations}
  #PATH_SUFFIXES 
  NO_DEFAULT_PATH
  )

# Libraries found?
if( LibM_LIBRARY )
  
  list( APPEND LibM_LIBRARIES ${LibM_LIBRARY} )
  get_filename_component( LibM_LIBRARY_DIR ${LibM_LIBRARY} PATH )
  
endif( LibM_LIBRARY )




# Headers AND libraries found?
if( LibM_INCLUDES AND LibM_LIBRARIES )
  
  # yes!
  set( LibM_FOUND TRUE )
  
else( LibM_INCLUDES AND LibM_LIBRARIES )
  
  # no!
  set( LibM_FOUND FALSE )
  
  if( NOT LibM_FIND_QUIETLY )
    if( NOT LibM_INCLUDES )
      message( WARNING "Unable to find LibM header files!" )
    endif( NOT LibM_INCLUDES )
    if( NOT LibM_LIBRARIES )
      message( WARNING "Unable to find LibM library files!" )
    endif( NOT LibM_LIBRARIES )
  endif( NOT LibM_FIND_QUIETLY )
  
endif( LibM_INCLUDES AND LibM_LIBRARIES )




# Headers AND libraries found!
if( LibM_FOUND )
  
  if( NOT LibM_FIND_QUIETLY )
    message( STATUS "" )
    message( STATUS "Found components for LibM:" )
    message( STATUS "* LibM_INCLUDES  = ${LibM_INCLUDES}" )
    message( STATUS "* LibM_LIBRARIES = ${LibM_LIBRARIES}" )
  endif( NOT LibM_FIND_QUIETLY )
  
else( LibM_FOUND )
  
  if( LibM_FIND_REQUIRED )
    message( FATAL_ERROR "Could not find LibM headers or libraries!" )
  endif( LibM_FIND_REQUIRED )
  
endif( LibM_FOUND )



# Mark as advanced options in ccmake:
mark_as_advanced( 
  LibM_INCLUDES
  LibM_LIBRARIES
  LibM_LIBRARY
  LibM_LIBRARY_DIR
  )

