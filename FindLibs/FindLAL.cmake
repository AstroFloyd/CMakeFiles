##  FindLAL.cmake:
##  Check for the presence of the LAL headers and libraries
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
##    LAL_FOUND        =  Libraries and headers found; TRUE/FALSE
##    LAL_INCLUDES     =  Path to the LAL header files
##    LAL_LIBRARIES    =  Path to all parts of the LAL libraries
##    LAL_LIBRARY_DIR  =  Path to the directory containing the LAL libraries



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
      message( STATUS "!! Unable to find LAL header files!" )
    endif( NOT LAL_INCLUDES )
    if( NOT LAL_LIBRARIES )
      message( STATUS "!! Unable to find LAL library files!" )
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
    message( FATAL_ERROR "!! Could not find LAL headers or libraries!" )
  endif( LAL_FIND_REQUIRED )
  
endif( LAL_FOUND )



# Mark as advanced options in ccmake:
mark_as_advanced( 
  LAL_INCLUDES
  LAL_LIBRARIES
  LAL_LIBRARY
  LAL_LIBRARY_DIR
  )

