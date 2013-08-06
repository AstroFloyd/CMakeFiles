##  CMakeFile for SPINspiral
##  MvdS, 2011-10-26
##  
##  Copyright 2011-2013 MvdS
##   
##  This file is part of the SPINspiral package, 
##  see: http://spinspiral.sf.net/
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
##  To compile, from the directory that contains this file, do:
##    $ mkdir build; cd build
##    $ cmake ..
##    $ make


cmake_minimum_required( VERSION 2.6 FATAL_ERROR )

# Set build type. Do this *before* we set the project name:
if( NOT CMAKE_BUILD_TYPE )
  set( CMAKE_BUILD_TYPE Release CACHE STRING
    "Choose the type of build, options are: None Debug Release RelWithDebInfo Profile."
    FORCE )
endif( NOT CMAKE_BUILD_TYPE )
set( CMAKE_CONFIGURATION_TYPES "${CMAKE_BUILD_TYPE}" CACHE INTERNAL "internal" )


# Project name and language:
project( SPINspiral C )


# Use CPack for packaging:
#include( CPack )
#set( CPACK_INSTALL_PREFIX_PATH ${CMAKE_INSTALL_PREFIX_PATH} )

# Search in the CMake/ directory for CMake modules:
list( APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/CMake )


# Various compile/optimisation options that we may want to enable:
include( SetCompileOptions )


# Place the products in their directories:
get_filename_component( C_COMPILER_NAME ${CMAKE_C_COMPILER} NAME )
set( MODULE_DIRECTORY "${CMAKE_SOURCE_DIR}/usr/include" )
set( LIBRARY_OUTPUT_PATH "${CMAKE_SOURCE_DIR}/usr/lib${LIB_SUFFIX}" )
set( CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/usr/bin" )



# Find dependencies:
find_package( GSL REQUIRED )
find_package( LibM REQUIRED )
find_package( FFTW3 REQUIRED )
set( INCLUDE_FLAGS "-I${CMAKE_SOURCE_DIR}/include -I${LibM_INCLUDES} -I${GSL_INCLUDES} -I${FFTW3_INCLUDES}" )  # will be transferred to CompilerFlags

find_package( LAL REQUIRED )
find_package( LibFrame REQUIRED )
find_package( LALFrame REQUIRED )
find_package( LALMetaio REQUIRED )
find_package( LALInspiral REQUIRED )
set( INCLUDE_FLAGS "${INCLUDE_FLAGS} -I${LAL_INCLUDES} -I${LibFrame_INCLUDES} -I${LALFrame_INCLUDES} -I${LALMetaio_INCLUDES} -I${LALInspiral_INCLUDES}" )  # will be transferred to CompilerFlags



# Set source files:
include( FileList )

# Set C compiler flags:
include( CompilerFlags_C )


# Create the file code_version.f90, which contains the svn version number and date:
if( CREATE_VERSION )
  
  # Code version generator:
  ADD_CUSTOM_COMMAND(
    OUTPUT ${CMAKE_SOURCE_DIR}/src/code_version.f90
    COMMAND cd $(CMAKE_SOURCE_DIR)
    COMMAND . ${CMAKE_SOURCE_DIR}/code_version.sh $(CMAKE_SOURCE_DIR) ${C_COMPILER_NAME}
    )
  
  # Tell CMake the source won't be available until build time:
  SET_SOURCE_FILES_PROPERTIES( ${CMAKE_SOURCE_DIR}/src/code_version.f90 PROPERTIES GENERATED 1 )

endif( CREATE_VERSION )




# Create executable targets:
add_executable( SPINspiral ${SPINspiral_src_files} )
target_link_libraries( SPINspiral ${LibM_LIBRARIES} ${GSL_LIBRARIES} ${FFTW3_LIBRARIES} ${LAL_LIBRARIES} ${LibFrame_LIBRARIES} ${LALFrame_LIBRARIES} ${LALMetaio_LIBRARIES} ${LALInspiral_LIBRARIES} )

# Set module directory:
set_target_properties( SPINspiral PROPERTIES C_MODULE_DIRECTORY ${MODULE_DIRECTORY} )



# Install to destination:
# - use DIRECTORY rather than TARGETS so that I don't need to specify them all again...
install( DIRECTORY usr/bin/ 
    FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE 
    DESTINATION ${CMAKE_INSTALL_PREFIX}/bin )


