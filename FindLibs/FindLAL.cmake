## FindLAL.cmake:
## Check for the presence of the LAL headers and libraries
## AF, 26/10/2011

# This CMake module defines the following variables:
#  LAL_FOUND        =  Libraries and headers found; TRUE/FALSE
#  LAL_INCLUDES     =  Path to the LAL header files
#  LAL_LIBRARIES    =  Path to all parts of the LAL libraries
#  LAL_LIBRARY_DIR  =  Path to the directory containing the LAL libraries



# Standard locations where to look for required components:
include( CMakeLocations )



# Check for the header files:
find_path( LAL_INCLUDES 
  NAMES LALVersion.h
  PATHS ${include_locations} ${lib_locations}
  PATH_SUFFIXES lal
  )



# Check for the libraries:
set( LAL_LIBRARIES "" )

find_library( LAL_LIBRARY
  NAMES lal
  PATHS ${lib_locations}
  #PATH_SUFFIXES 
  NO_DEFAULT_PATH
  )

# Libraries found?
if( LAL_LIBRARY )
  
  list( APPEND LAL_LIBRARIES ${LAL_LIBRARY} )
  get_filename_component( LAL_LIBRARY_DIR ${LAL_LIBRARY} PATH )
  
endif( LAL_LIBRARY )




# Headers AND libraries found?
if( LAL_INCLUDES AND LAL_LIBRARIES )
  
  # yes!
  set( LAL_FOUND TRUE )
  
else( LAL_INCLUDES AND LAL_LIBRARIES )
  
  # no!
  set( LAL_FOUND FALSE )
  
  if( NOT LAL_FIND_QUIETLY )
    if( NOT LAL_INCLUDES )
      message( WARNING "Unable to find LAL header files!" )
    endif( NOT LAL_INCLUDES )
    if( NOT LAL_LIBRARIES )
      message( WARNING "Unable to find LAL library files!" )
    endif( NOT LAL_LIBRARIES )
  endif( NOT LAL_FIND_QUIETLY )
  
endif( LAL_INCLUDES AND LAL_LIBRARIES )




# Headers AND libraries found!
if( LAL_FOUND )
  
  if( NOT LAL_FIND_QUIETLY )
    message( STATUS "" )
    message( STATUS "Found components for LAL:" )
    message( STATUS "* LAL_INCLUDES  = ${LAL_INCLUDES}" )
    message( STATUS "* LAL_LIBRARIES = ${LAL_LIBRARIES}" )
  endif( NOT LAL_FIND_QUIETLY )
  
else( LAL_FOUND )
  
  if( LAL_FIND_REQUIRED )
    message( FATAL_ERROR "Could not find LAL headers or libraries!" )
  endif( LAL_FIND_REQUIRED )
  
endif( LAL_FOUND )



# Mark as advanced options in ccmake:
mark_as_advanced( 
  LAL_INCLUDES
  LAL_LIBRARIES
  LAL_LIBRARY
  LAL_LIBRARY_DIR
  )

