##  FindPG2PLplot.cmake:
##  Check for the presence of the PG2PLplot library (pg2plplot.sf.net)
##  Adapted by AF on 2013-12-19, from FindPGPLOT.cmake.
##    Copyright (c) 2007 Lars B"ahren (bahren@astron.nl)
##    Copyright 2010-2013 AstroFloyd - astrofloyd.org
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
##  Defines the following variables:
##    PG2PLplot_FOUND       = 
##    PG2PLplot_INCLUDES    = Path to the PG2PLplot header files
##    PG2PLplot_LIBRARIES   = Path to all parts of the PG2PLplot library
##    PG2PLplot_LIBRARY_DIR = Path to the directory containing the PG2PLplot libraries


# Standard locations where to look for required components:
include( CMakeLocations )


if( NOT PG2PLplot_FIND_QUIETLY )
  message( STATUS "" )
  message( STATUS "Looking for PG2PLplot...  " )
endif( NOT PG2PLplot_FIND_QUIETLY )


# Check for the header/module files:
find_path( 
  PG2PLplot_INCLUDES 
  NAMES pg2plplot.mod
  PATHS ${include_locations} ${lib_locations}
  PATH_SUFFIXES pg2plplot
  )


# Check for the library:
set( PG2PLplot_LIBRARIES "" )

find_library( PG2PLplot_LIBRARY
  NAMES pg2plplot
  PATHS ${lib_locations}
  PATH_SUFFIXES pg2plplot
  NO_DEFAULT_PATH
  )

if( PG2PLplot_LIBRARY )
  list( APPEND PG2PLplot_LIBRARIES ${PG2PLplot_LIBRARY} )
  get_filename_component( PG2PLplot_LIBRARY_DIR ${PG2PLplot_LIBRARY} PATH )
else( PG2PLplot_LIBRARY )
  message ( STATUS "!! Warning: Unable to locate libpg2plplot!" )
endif( PG2PLplot_LIBRARY )


# Actions taken when all components have been found:
if( PG2PLplot_INCLUDES AND PG2PLplot_LIBRARIES )
  
  set( PG2PLplot_FOUND TRUE )
  
else( PG2PLplot_INCLUDES AND PG2PLplot_LIBRARIES )
  
  set( PG2PLplot_FOUND FALSE )
  if( NOT PG2PLplot_FIND_QUIETLY )
    if( NOT PG2PLplot_INCLUDES )
      message( STATUS "!! Unable to find PG2PLplot header files!" )
    endif( NOT PG2PLplot_INCLUDES )
    if( NOT PG2PLplot_LIBRARIES )
      message( STATUS "!! Unable to find PG2PLplot library files!" )
    endif( NOT PG2PLplot_LIBRARIES )
  endif( NOT PG2PLplot_FIND_QUIETLY )
  
endif( PG2PLplot_INCLUDES AND PG2PLplot_LIBRARIES )



# Final status/error:
if( PG2PLplot_FOUND )
  
  if( NOT PG2PLplot_FIND_QUIETLY )
    message( STATUS "Found components for PG2PLplot:" )
    message( STATUS "* PG2PLplot_INCLUDES  = ${PG2PLplot_INCLUDES}" )
    message( STATUS "* PG2PLplot_LIBRARIES = ${PG2PLplot_LIBRARIES}" )
  endif( NOT PG2PLplot_FIND_QUIETLY )
  
else( PG2PLplot_FOUND )
  
  if( PG2PLplot_FIND_REQUIRED )
    message( FATAL_ERROR "!! Could not find PG2PLplot!" )
  else( PG2PLplot_FIND_REQUIRED )
    message( STATUS "!! Could not find PG2PLplot" )
  endif( PG2PLplot_FIND_REQUIRED )
  
endif( PG2PLplot_FOUND )



# Mark as advanced options in ccmake/cmake-gui menu:
mark_as_advanced(
  PG2PLplot_INCLUDES
  PG2PLplot_LIBRARIES
  PG2PLplot_LIBRARY
  PG2PLplot_LIBRARY_DIR
  )

