# Adapted from FindPGPLOT.cmake
# AF, 27/12/2010


# Check for the presence of the LibSUFR headers and libraries
#
# This CMake module defines the following variables:
#  LibSUFR_FOUND        =  Libraries and headers found; TRUE/FALSE
#  LibSUFR_INCLUDES     =  Path to the LibSUFR header files
#  LibSUFR_LIBRARIES    =  Path to all parts of the LibSUFR libraries
#  LibSUFR_LIBRARY_DIR  =  Path to the directory containing the LibSUFR libraries



# Standard locations where to look for required components:
include( CMakeLocations )



# Check for the header files:
find_path( LibSUFR_INCLUDES 
  NAMES sufr_constants.mod
  PATHS ${include_locations} ${lib_locations}
  PATH_SUFFIXES libSUFR libSUFR/${Fortran_COMPILER_NAME}
  )



# Check for the libraries:
set( LibSUFR_LIBRARIES "" )

find_library( LibSUFR_LIBRARY
  NAMES SUFR SUFR_${Fortran_COMPILER_NAME}
  PATHS ${lib_locations}
  PATH_SUFFIXES libSUFR libSUFR_${Fortran_COMPILER_NAME}
  NO_DEFAULT_PATH
  )

# Libraries found?
if( LibSUFR_LIBRARY )
  
  list( APPEND LibSUFR_LIBRARIES ${LibSUFR_LIBRARY} )
  get_filename_component( LibSUFR_LIBRARY_DIR ${LibSUFR_LIBRARY} PATH )
  
endif( LibSUFR_LIBRARY )




# Headers AND libraries found?
if( LibSUFR_INCLUDES AND LibSUFR_LIBRARIES )
  
  # yes!
  set( LibSUFR_FOUND TRUE )
  
else( LibSUFR_INCLUDES AND LibSUFR_LIBRARIES )
  
  # no!
  set( LibSUFR_FOUND FALSE )
  
  if( NOT LibSUFR_FIND_QUIETLY )
    if( NOT LibSUFR_INCLUDES )
      message( WARNING "Unable to find LibSUFR header files!" )
    endif( NOT LibSUFR_INCLUDES )
    if( NOT LibSUFR_LIBRARIES )
      message( WARNING "Unable to find LibSUFR library files!" )
    endif( NOT LibSUFR_LIBRARIES )
  endif( NOT LibSUFR_FIND_QUIETLY )
  
endif( LibSUFR_INCLUDES AND LibSUFR_LIBRARIES )




# Headers AND libraries found!
if( LibSUFR_FOUND )
  
  if( NOT LibSUFR_FIND_QUIETLY )
    message( STATUS "Found components for LibSUFR:" )
    message( STATUS "LibSUFR_INCLUDES  = ${LibSUFR_INCLUDES}" )
    message( STATUS "LibSUFR_LIBRARIES = ${LibSUFR_LIBRARIES}" )
  endif( NOT LibSUFR_FIND_QUIETLY )
  
else( LibSUFR_FOUND )
  
  if( LibSUFR_FIND_REQUIRED )
    message( FATAL_ERROR "Could not find LibSUFR headers or libraries!" )
  endif( LibSUFR_FIND_REQUIRED )
  
endif( LibSUFR_FOUND )



# Mark as advanced options in ccmake:
mark_as_advanced( 
  LibSUFR_INCLUDES
  LibSUFR_LIBRARIES
  LibSUFR_LIBRARY
  LibSUFR_LIBRARY_DIR
  )

