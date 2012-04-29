## FindLALMetaio.cmake:
## Check for the presence of the LALMetaio headers and libraries
## AF, 26/10/2011

# This CMake module defines the following variables:
#  LALMetaio_FOUND        =  Libraries and headers found; TRUE/FALSE
#  LALMetaio_INCLUDES     =  Path to the LALMetaio header files
#  LALMetaio_LIBRARIES    =  Path to all parts of the LALMetaio libraries
#  LALMetaio_LIBRARY_DIR  =  Path to the directory containing the LALMetaio libraries



# Standard locations where to look for required components:
include( CMakeLocations )



# Check for the header files:
find_path( LALMetaio_INCLUDES 
  NAMES LALMetaIOConfig.h
  PATHS ${include_locations} ${lib_locations}
  PATH_SUFFIXES lal
  )



# Check for the libraries:
set( LALMetaio_LIBRARIES "" )

find_library( LALMetaio_LIBRARY
  NAMES lalmetaio
  PATHS ${lib_locations}
  #PATH_SUFFIXES 
  NO_DEFAULT_PATH
  )

# Libraries found?
if( LALMetaio_LIBRARY )
  
  list( APPEND LALMetaio_LIBRARIES ${LALMetaio_LIBRARY} )
  get_filename_component( LALMetaio_LIBRARY_DIR ${LALMetaio_LIBRARY} PATH )
  
endif( LALMetaio_LIBRARY )




# Headers AND libraries found?
if( LALMetaio_INCLUDES AND LALMetaio_LIBRARIES )
  
  # yes!
  set( LALMetaio_FOUND TRUE )
  
else( LALMetaio_INCLUDES AND LALMetaio_LIBRARIES )
  
  # no!
  set( LALMetaio_FOUND FALSE )
  
  if( NOT LALMetaio_FIND_QUIETLY )
    if( NOT LALMetaio_INCLUDES )
      message( STATUS "!! Unable to find LALMetaio header files!" )
    endif( NOT LALMetaio_INCLUDES )
    if( NOT LALMetaio_LIBRARIES )
      message( STATUS "!! Unable to find LALMetaio library files!" )
    endif( NOT LALMetaio_LIBRARIES )
  endif( NOT LALMetaio_FIND_QUIETLY )
  
endif( LALMetaio_INCLUDES AND LALMetaio_LIBRARIES )




# Headers AND libraries found!
if( LALMetaio_FOUND )
  
  if( NOT LALMetaio_FIND_QUIETLY )
    message( STATUS "" )
    message( STATUS "Found components for LALMetaio:" )
    message( STATUS "* LALMetaio_INCLUDES  = ${LALMetaio_INCLUDES}" )
    message( STATUS "* LALMetaio_LIBRARIES = ${LALMetaio_LIBRARIES}" )
  endif( NOT LALMetaio_FIND_QUIETLY )
  
else( LALMetaio_FOUND )
  
  if( LALMetaio_FIND_REQUIRED )
    message( FATAL_ERROR "!! Could not find LALMetaio headers or libraries!" )
  endif( LALMetaio_FIND_REQUIRED )
  
endif( LALMetaio_FOUND )



# Mark as advanced options in ccmake:
mark_as_advanced( 
  LALMetaio_INCLUDES
  LALMetaio_LIBRARIES
  LALMetaio_LIBRARY
  LALMetaio_LIBRARY_DIR
  )

