##  FindPGPLOT.cmake:
##  Check for the presence of the PGPLOT library
##  Adapted by AF on 2010-12-27, from:
##    http://usg.lofar.org/websvn/filedetails.php?repname=repos+1&path=%2Fcode%2Ftrunk%2Fdevel_common%2Fcmake%2FFindPGPLOT.cmake&sc=1
##    $Id:: FindPGPLOT.cmake 3830 2009-12-09 14:35:58Z alexov
##  
##  Copyright (C) 2007 Lars B"ahren (bahren@astron.nl)
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
##  Defines the following variables:
##    PGPLOT_FOUND       = 
##    PGPLOT_INCLUDES    = Path to the PGPLOT header files
##    PGPLOT_LIBRARIES   = Path to all parts of the PGPLOT library
##    PGPLOT_LIBRARY_DIR = Path to the directory containing the PGPLOT libraries


# Standard locations where to look for required components:
include( CMakeLocations )


if( NOT PGPLOT_FIND_QUIETLY )
  message( STATUS "" )
  message( STATUS "Looking for PGPLOT...  " )
endif( NOT PGPLOT_FIND_QUIETLY )


# Check for the header files:
find_path( 
  PGPLOT_INCLUDES 
  NAMES cpgplot.h
  PATHS ${include_locations} ${lib_locations}
  PATH_SUFFIXES pgplot
  )


# Check for the library:
set( PGPLOT_LIBRARIES "" )

find_library( PGPLOT_LIBRARY
  NAMES pgplot
  PATHS ${lib_locations}
  PATH_SUFFIXES pgplot
  NO_DEFAULT_PATH
  )

if( PGPLOT_LIBRARY )
  list( APPEND PGPLOT_LIBRARIES ${PGPLOT_LIBRARY} )
  get_filename_component( PGPLOT_LIBRARY_DIR ${PGPLOT_LIBRARY} PATH )
else( PGPLOT_LIBRARY )
  message ( STATUS "!! Warning: Unable to locate libpgplot!" )
endif( PGPLOT_LIBRARY )


# Actions taken when all components have been found:
if( PGPLOT_INCLUDES AND PGPLOT_LIBRARIES )
  
  set( PGPLOT_FOUND TRUE )
  
else( PGPLOT_INCLUDES AND PGPLOT_LIBRARIES )
  
  set( PGPLOT_FOUND FALSE )
  if( NOT PGPLOT_FIND_QUIETLY )
    if( NOT PGPLOT_INCLUDES )
      message( STATUS "!! Unable to find PGPLOT header files!" )
    endif( NOT PGPLOT_INCLUDES )
    if( NOT PGPLOT_LIBRARIES )
      message( STATUS "!! Unable to find PGPLOT library files!" )
    endif( NOT PGPLOT_LIBRARIES )
  endif( NOT PGPLOT_FIND_QUIETLY )
  
endif( PGPLOT_INCLUDES AND PGPLOT_LIBRARIES )



# Final status/error:
if( PGPLOT_FOUND )
  
  if( NOT PGPLOT_FIND_QUIETLY )
    message( STATUS "Found components for PGPLOT:" )
    message( STATUS "* PGPLOT_INCLUDES  = ${PGPLOT_INCLUDES}" )
    message( STATUS "* PGPLOT_LIBRARIES = ${PGPLOT_LIBRARIES}" )
  endif( NOT PGPLOT_FIND_QUIETLY )
  
else( PGPLOT_FOUND )
  
  if( PGPLOT_FIND_REQUIRED )
    message( FATAL_ERROR "!! Could not find PGPLOT!" )
  else( PGPLOT_FIND_REQUIRED )
    message( STATUS "!! Could not find PGPLOT" )
  endif( PGPLOT_FIND_REQUIRED )
  
endif( PGPLOT_FOUND )



# Mark as advanced options in ccmake/cmake-gui menu:
mark_as_advanced(
  PGPLOT_INCLUDES
  PGPLOT_LIBRARIES
  PGPLOT_LIBRARY
  PGPLOT_LIBRARY_DIR
  )

