##  CMakeFile for evTools
##  AF, 2011-01-07
##  
##  Copyright 2002-2013 AstroFloyd - astrofloyd.org
##   
##  This file is part of the evTools package, 
##  see: http://evtools.sf.net/
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
##    $ make install


cmake_minimum_required( VERSION 2.6 FATAL_ERROR )

# Set build type. Do this *before* we set the project name:
if( NOT CMAKE_BUILD_TYPE )
  set( CMAKE_BUILD_TYPE Release CACHE STRING
    "Choose the type of build, options are: None Debug Release RelWithDebInfo Profile."
    FORCE )
endif( NOT CMAKE_BUILD_TYPE )
set( CMAKE_CONFIGURATION_TYPES "${CMAKE_BUILD_TYPE}" CACHE INTERNAL "internal" )


# Project name and language:
project( evTools Fortran )


# Search in the CMake/ directory for CMake modules:
list( APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/CMake )


# Various compile/optimisation options that we may want to enable:
include( SetCompileOptions )


# Place the products in their directories:
get_filename_component( Fortran_COMPILER_NAME ${CMAKE_Fortran_COMPILER} NAME )
set( MODULE_DIRECTORY "${CMAKE_SOURCE_DIR}/usr/mod" )
set( LIBRARY_OUTPUT_PATH "${CMAKE_SOURCE_DIR}/usr/lib${LIB_SUFFIX}" )
set( CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/usr/bin" )



# Find dependencies:
find_package( PGPLOT REQUIRED )
find_package( LibSUFR REQUIRED )

set( INCLUDE_FLAGS "-I${LibSUFR_INCLUDES}" )  # will be transferred to CompilerFlags



# Set source files:
include( FileList )

# Set FORTRAN compiler flags:
include( CompilerFlags_Fortran )




# Create the file code_version.f90, which contains the code revision number and date:
if( CREATE_VERSION )
  
  # SVN/BZR version generator:
  ADD_CUSTOM_COMMAND(
    OUTPUT ${CMAKE_SOURCE_DIR}/src/code_version.f90
    COMMAND cd $(CMAKE_SOURCE_DIR)
    COMMAND . ${CMAKE_SOURCE_DIR}/code_version.sh $(CMAKE_SOURCE_DIR) ${Fortran_COMPILER_NAME}
    )
  
  # Tell CMake the source won't be available until build time:
  SET_SOURCE_FILES_PROPERTIES( ${CMAKE_SOURCE_DIR}/src/code_version.f90 PROPERTIES GENERATED 1 )

endif( CREATE_VERSION )




# Create executable targets that don't need PGPlot:
add_executable( dat2plt  src/dat2plt.f90 ${evTools_std_files} )
target_link_libraries( dat2plt  ${LibSUFR_LIBRARIES} )

add_executable( findplt  src/findplt.f90 ${evTools_std_files} )
target_link_libraries( findplt  ${LibSUFR_LIBRARIES} )

add_executable( getgrid  src/getgrid.f90 ${evTools_std_files} )
target_link_libraries( getgrid  ${LibSUFR_LIBRARIES} )

add_executable( grid  src/grid.f90 ${evTools_std_files} )
target_link_libraries( grid  ${LibSUFR_LIBRARIES} )

add_executable( listmdl  src/listmdl.f90 ${evTools_std_files} ${evTools_mdl_files} )
target_link_libraries( listmdl  ${LibSUFR_LIBRARIES} )

add_executable( listmod  src/listmod.f90 ${evTools_std_files} )
target_link_libraries( listmod  ${LibSUFR_LIBRARIES} )

add_executable( listplt  src/listplt.f90 ${evTools_std_files} )
target_link_libraries( listplt  ${LibSUFR_LIBRARIES} )

add_executable( makerun  src/makerun.f90 ${evTools_std_files} )
target_link_libraries( makerun  ${LibSUFR_LIBRARIES} )

add_executable( mergeplt  src/mergeplt.f90 ${evTools_std_files} )
target_link_libraries( mergeplt  ${LibSUFR_LIBRARIES} )

add_executable( plt2ce  src/plt2ce.f90 ${evTools_std_files} )
target_link_libraries( plt2ce  ${LibSUFR_LIBRARIES} )

add_executable( plt2dat  src/plt2dat.f90 ${evTools_std_files} ${evTools_plt_files} )
target_link_libraries( plt2dat  ${LibSUFR_LIBRARIES} )

add_executable( plt2obs  src/plt2obs.f90 ${evTools_std_files} )
target_link_libraries( plt2obs  ${LibSUFR_LIBRARIES} )

add_executable( selplt  src/selplt.f90 ${evTools_std_files} ${evTools_plt_files} )
target_link_libraries( selplt  ${LibSUFR_LIBRARIES} )


# Set module directory:
set_target_properties( dat2plt findplt getgrid grid listmdl listmod listplt makerun mergeplt plt2ce plt2dat plt2obs selplt 
  PROPERTIES Fortran_MODULE_DIRECTORY ${MODULE_DIRECTORY} )



# Create executable targets that need PGPlot:
add_executable( plotmdl  src/plotmdl.f90 ${evTools_std_files} ${evTools_mdl_files} ${evTools_plot_files} )
target_link_libraries( plotmdl ${PGPLOT_LIBRARIES} ${LibSUFR_LIBRARIES} )

add_executable( plotmdln  src/plotmdln.f90 ${evTools_std_files} )
target_link_libraries( plotmdln ${PGPLOT_LIBRARIES} ${LibSUFR_LIBRARIES} )

add_executable( plotmod  src/plotmod.f90 ${evTools_std_files} )
target_link_libraries( plotmod ${PGPLOT_LIBRARIES} ${LibSUFR_LIBRARIES} )

add_executable( plotplt  src/plotplt.f90 ${evTools_std_files} ${evTools_plt_files} ${evTools_plot_files} )
target_link_libraries( plotplt ${PGPLOT_LIBRARIES} ${LibSUFR_LIBRARIES} )


# Set module directory:
set_target_properties( plotmdl plotmdln plotmod plotplt 
  PROPERTIES Fortran_MODULE_DIRECTORY ${MODULE_DIRECTORY} )



# Install to destination:
# - use DIRECTORY rather than TARGETS so that I don't need to specify them all again...
install( DIRECTORY usr/bin/ 
    FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE 
    DESTINATION ${CMAKE_INSTALL_PREFIX}/bin )


