## Adapted from: FindLibSUFR.cmake
## by AF on 27/12/2010


# - Check for the presence of the LibSUFR library
#
# Defines the following variables:
#  HAVE_LibSUFR        = 
#  LibSUFR_INCLUDES    = Path to the LibSUFR header files
#  LibSUFR_LIBRARIES   = Path to all parts of the LibSUFR library
#  LibSUFR_LIBRARY_DIR = Path to the directory containing the LibSUFR libraries

## -----------------------------------------------------------------------------
## Standard locations where to look for required components

include( CMakeLocations )

## -----------------------------------------------------------------------------
## Check for the header files

find_path( LibSUFR_INCLUDES sufr_constants.mod
  PATHS ${include_locations} ${include_locations}/libSUFR ${include_locations}/libSUFR/${Fortran_COMPILER_NAME} ${lib_locations}
  PATH_SUFFIXES libSUFR
  )

## -----------------------------------------------------------------------------
## Check for the library

set( LibSUFR_LIBRARIES "" )


find_library( LibSUFR_LIBRARY
  NAMES SUFR SUFR_${Fortran_COMPILER_NAME}
  PATHS ${lib_locations} ${lib_locations}/libSUFR ${lib_locations}/libSUFR_${Fortran_COMPILER_NAME}
  PATH_SUFFIXES libSUFR
  NO_DEFAULT_PATH
  )

if( LibSUFR_LIBRARY )
  list( APPEND LibSUFR_LIBRARIES ${LibSUFR_LIBRARY} )
  get_filename_component( LibSUFR_LIBRARY_DIR ${LibSUFR_LIBRARY} PATH )
else( LibSUFR_LIBRARY )
  message( STATUS "Warning: Unable to locate LibSUFR!" )
endif( LibSUFR_LIBRARY )


if( LibSUFR_INCLUDES AND LibSUFR_LIBRARIES )
  set( HAVE_LibSUFR TRUE )
else( LibSUFR_INCLUDES AND LibSUFR_LIBRARIES )
  set( HAVE_LibSUFR FALSE )
  if( NOT LibSUFR_FIND_QUIETLY )
    if( NOT LibSUFR_INCLUDES )
      message( STATUS "Unable to find LibSUFR header files!" )
    endif( NOT LibSUFR_INCLUDES )
    if( NOT LibSUFR_LIBRARIES )
      message( STATUS "Unable to find LibSUFR library files!" )
    endif( NOT LibSUFR_LIBRARIES )
  endif( NOT LibSUFR_FIND_QUIETLY )
endif( LibSUFR_INCLUDES AND LibSUFR_LIBRARIES )

if( HAVE_LibSUFR )
  if( NOT LibSUFR_FIND_QUIETLY )
    message( STATUS "Found components for LibSUFR:" )
    message( STATUS "LibSUFR_INCLUDES  = ${LibSUFR_INCLUDES}" )
    message( STATUS "LibSUFR_LIBRARIES = ${LibSUFR_LIBRARIES}" )
  endif( NOT LibSUFR_FIND_QUIETLY )
else( HAVE_LibSUFR )
  if( LibSUFR_FIND_REQUIRED )
    message( FATAL_ERROR "Could not find LibSUFR!" )
  endif( LibSUFR_FIND_REQUIRED )
endif( HAVE_LibSUFR )

## -----------------------------------------------------------------------------
## Mark as advanced ...

mark_as_advanced( 
  LibSUFR_INCLUDES
  LibSUFR_LIBRARIES
  LibSUFR_LIBRARY
  LibSUFR_LIBRARY_DIR
  )
