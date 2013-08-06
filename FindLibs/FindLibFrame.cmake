##  FindLibFrame.cmake:
##  Check for the presence of the LibFrame headers and libraries
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
##    LibFrame_FOUND        =  Libraries and headers found; TRUE/FALSE
##    LibFrame_INCLUDES     =  Path to the LibFrame header files
##    LibFrame_LIBRARIES    =  Path to all parts of the LibFrame libraries
##    LibFrame_LIBRARY_DIR  =  Path to the directory containing the LibFrame libraries



# Standard locations where to look for required components:
include( CMakeLocations )



# Check for the header files:
find_path( LibFrame_INCLUDES 
  NAMES FrameL.h
  PATHS ${include_locations} ${lib_locations}
  PATH_SUFFIXES lal
  )



# Check for the libraries:
set( LibFrame_LIBRARIES "" )

find_library( LibFrame_LIBRARY
  NAMES Frame
  PATHS ${lib_locations}
  #PATH_SUFFIXES 
  NO_DEFAULT_PATH
  )

# Libraries found?
if( LibFrame_LIBRARY )
  
  list( APPEND LibFrame_LIBRARIES ${LibFrame_LIBRARY} )
  get_filename_component( LibFrame_LIBRARY_DIR ${LibFrame_LIBRARY} PATH )
  
endif( LibFrame_LIBRARY )




# Headers AND libraries found?
if( LibFrame_INCLUDES AND LibFrame_LIBRARIES )
  
  # yes!
  set( LibFrame_FOUND TRUE )
  
else( LibFrame_INCLUDES AND LibFrame_LIBRARIES )
  
  # no!
  set( LibFrame_FOUND FALSE )
  
  if( NOT LibFrame_FIND_QUIETLY )
    if( NOT LibFrame_INCLUDES )
      message( STATUS "!! Unable to find LibFrame header files!" )
    endif( NOT LibFrame_INCLUDES )
    if( NOT LibFrame_LIBRARIES )
      message( STATUS "!! Unable to find LibFrame library files!" )
    endif( NOT LibFrame_LIBRARIES )
  endif( NOT LibFrame_FIND_QUIETLY )
  
endif( LibFrame_INCLUDES AND LibFrame_LIBRARIES )




# Headers AND libraries found!
if( LibFrame_FOUND )
  
  if( NOT LibFrame_FIND_QUIETLY )
    message( STATUS "" )
    message( STATUS "Found components for LibFrame:" )
    message( STATUS "* LibFrame_INCLUDES  = ${LibFrame_INCLUDES}" )
    message( STATUS "* LibFrame_LIBRARIES = ${LibFrame_LIBRARIES}" )
  endif( NOT LibFrame_FIND_QUIETLY )
  
else( LibFrame_FOUND )
  
  if( LibFrame_FIND_REQUIRED )
    message( FATAL_ERROR "!! Could not find LibFrame headers or libraries!" )
  endif( LibFrame_FIND_REQUIRED )
  
endif( LibFrame_FOUND )



# Mark as advanced options in ccmake:
mark_as_advanced( 
  LibFrame_INCLUDES
  LibFrame_LIBRARIES
  LibFrame_LIBRARY
  LibFrame_LIBRARY_DIR
  )

