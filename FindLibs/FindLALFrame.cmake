## FindLALFrame.cmake:
## Check for the presence of the LALFrame headers and libraries
## AF, 26/10/2011

# This CMake module defines the following variables:
#  LALFrame_FOUND        =  Libraries and headers found; TRUE/FALSE
#  LALFrame_INCLUDES     =  Path to the LALFrame header files
#  LALFrame_LIBRARIES    =  Path to all parts of the LALFrame libraries
#  LALFrame_LIBRARY_DIR  =  Path to the directory containing the LALFrame libraries



# Standard locations where to look for required components:
include( CMakeLocations )



# Check for the header files:
find_path( LALFrame_INCLUDES 
  NAMES LALFrameL.h
  PATHS ${include_locations} ${lib_locations}
  PATH_SUFFIXES lal
  )



# Check for the libraries:
set( LALFrame_LIBRARIES "" )

find_library( LALFrame_LIBRARY
  NAMES lalframe
  PATHS ${lib_locations}
  #PATH_SUFFIXES 
  NO_DEFAULT_PATH
  )

# Libraries found?
if( LALFrame_LIBRARY )
  
  list( APPEND LALFrame_LIBRARIES ${LALFrame_LIBRARY} )
  get_filename_component( LALFrame_LIBRARY_DIR ${LALFrame_LIBRARY} PATH )
  
endif( LALFrame_LIBRARY )




# Headers AND libraries found?
if( LALFrame_INCLUDES AND LALFrame_LIBRARIES )
  
  # yes!
  set( LALFrame_FOUND TRUE )
  
else( LALFrame_INCLUDES AND LALFrame_LIBRARIES )
  
  # no!
  set( LALFrame_FOUND FALSE )
  
  if( NOT LALFrame_FIND_QUIETLY )
    if( NOT LALFrame_INCLUDES )
      message( WARNING "Unable to find LALFrame header files!" )
    endif( NOT LALFrame_INCLUDES )
    if( NOT LALFrame_LIBRARIES )
      message( WARNING "Unable to find LALFrame library files!" )
    endif( NOT LALFrame_LIBRARIES )
  endif( NOT LALFrame_FIND_QUIETLY )
  
endif( LALFrame_INCLUDES AND LALFrame_LIBRARIES )




# Headers AND libraries found!
if( LALFrame_FOUND )
  
  if( NOT LALFrame_FIND_QUIETLY )
    message( STATUS "" )
    message( STATUS "Found components for LALFrame:" )
    message( STATUS "* LALFrame_INCLUDES  = ${LALFrame_INCLUDES}" )
    message( STATUS "* LALFrame_LIBRARIES = ${LALFrame_LIBRARIES}" )
  endif( NOT LALFrame_FIND_QUIETLY )
  
else( LALFrame_FOUND )
  
  if( LALFrame_FIND_REQUIRED )
    message( FATAL_ERROR "Could not find LALFrame headers or libraries!" )
  endif( LALFrame_FIND_REQUIRED )
  
endif( LALFrame_FOUND )



# Mark as advanced options in ccmake:
mark_as_advanced( 
  LALFrame_INCLUDES
  LALFrame_LIBRARIES
  LALFrame_LIBRARY
  LALFrame_LIBRARY_DIR
  )

