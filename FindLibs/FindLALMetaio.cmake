##  FindLALMetaio.cmake:
##  Check for the presence of the LALMetaio headers and libraries
##  AF, 2011-10-26
##  
##  Copyright 2010-2013 AstroFloyd - astrofloyd.org
##   
##  This file is part of the CMakeFiles package, 
##  see: http://cmakefiles.sf.net/
##   
##  This is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published
##  by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
##  
##  This software is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
##  
##  You should have received a copy of the GNU General Public License along with this code.  If not, see 
##  <http://www.gnu.org/licenses/>.
##
##
##  This CMake module defines the following variables:
##    LALMetaio_FOUND        =  Libraries and headers found; TRUE/FALSE
##    LALMetaio_INCLUDES     =  Path to the LALMetaio header files
##    LALMetaio_LIBRARIES    =  Path to all parts of the LALMetaio libraries
##    LALMetaio_LIBRARY_DIR  =  Path to the directory containing the LALMetaio libraries



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

