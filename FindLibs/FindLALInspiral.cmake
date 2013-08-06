##  FindLALInspiral.cmake:
##  Check for the presence of the LALInspiral headers and libraries
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
##    LALInspiral_FOUND        =  Libraries and headers found; TRUE/FALSE
##    LALInspiral_INCLUDES     =  Path to the LALInspiral header files
##    LALInspiral_LIBRARIES    =  Path to all parts of the LALInspiral libraries
##    LALInspiral_LIBRARY_DIR  =  Path to the directory containing the LALInspiral libraries



# Standard locations where to look for required components:
include( CMakeLocations )



# Check for the header files:
find_path( LALInspiral_INCLUDES 
  NAMES LALInspiral.h
  PATHS ${include_locations} ${lib_locations}
  PATH_SUFFIXES lal
  )



# Check for the libraries:
set( LALInspiral_LIBRARIES "" )

find_library( LALInspiral_LIBRARY
  NAMES lalinspiral
  PATHS ${lib_locations}
  #PATH_SUFFIXES 
  NO_DEFAULT_PATH
  )

# Libraries found?
if( LALInspiral_LIBRARY )
  
  list( APPEND LALInspiral_LIBRARIES ${LALInspiral_LIBRARY} )
  get_filename_component( LALInspiral_LIBRARY_DIR ${LALInspiral_LIBRARY} PATH )
  
endif( LALInspiral_LIBRARY )




# Headers AND libraries found?
if( LALInspiral_INCLUDES AND LALInspiral_LIBRARIES )
  
  # yes!
  set( LALInspiral_FOUND TRUE )
  
else( LALInspiral_INCLUDES AND LALInspiral_LIBRARIES )
  
  # no!
  set( LALInspiral_FOUND FALSE )
  
  if( NOT LALInspiral_FIND_QUIETLY )
    if( NOT LALInspiral_INCLUDES )
      message( STATUS "!! Unable to find LALInspiral header files!" )
    endif( NOT LALInspiral_INCLUDES )
    if( NOT LALInspiral_LIBRARIES )
      message( STATUS "!! Unable to find LALInspiral library files!" )
    endif( NOT LALInspiral_LIBRARIES )
  endif( NOT LALInspiral_FIND_QUIETLY )
  
endif( LALInspiral_INCLUDES AND LALInspiral_LIBRARIES )




# Headers AND libraries found!
if( LALInspiral_FOUND )
  
  if( NOT LALInspiral_FIND_QUIETLY )
    message( STATUS "" )
    message( STATUS "Found components for LALInspiral:" )
    message( STATUS "* LALInspiral_INCLUDES  = ${LALInspiral_INCLUDES}" )
    message( STATUS "* LALInspiral_LIBRARIES = ${LALInspiral_LIBRARIES}" )
  endif( NOT LALInspiral_FIND_QUIETLY )
  
else( LALInspiral_FOUND )
  
  if( LALInspiral_FIND_REQUIRED )
    message( FATAL_ERROR "!! Could not find LALInspiral headers or libraries!" )
  endif( LALInspiral_FIND_REQUIRED )
  
endif( LALInspiral_FOUND )



# Mark as advanced options in ccmake:
mark_as_advanced( 
  LALInspiral_INCLUDES
  LALInspiral_LIBRARIES
  LALInspiral_LIBRARY
  LALInspiral_LIBRARY_DIR
  )

