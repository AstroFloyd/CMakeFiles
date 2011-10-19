##
##  CMakeFile for evTools
##  AF, 07/01/2011
##
##  To compile, from the directory that contains this file, do:
##    $ mkdir build; cd build
##    $ cmake ..
##    $ make
##


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


# Use CPack for packaging:
#include( CPack )
#set( CPACK_INSTALL_PREFIX_PATH ${CMAKE_INSTALL_PREFIX_PATH} )

# Search in the CMake/ directory for CMake modules:
list( APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/CMake )

# Various compile/optimisation options that we may want to enable:
include( SetCompileOptions )


# Place the products in their directories:
get_filename_component( Fortran_COMPILER_NAME ${CMAKE_Fortran_COMPILER} NAME )
set( MODULE_DIRECTORY "${CMAKE_SOURCE_DIR}/usr/mod" )
set( LIBRARY_OUTPUT_PATH "${CMAKE_SOURCE_DIR}/usr/lib" )
set( CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/usr/bin" )



# Find dependencies:
find_package( PGPLOT REQUIRED )
find_package( LibSUFR REQUIRED )

set( INCLUDE_FLAGS "-I${LibSUFR_INCLUDES}" )  # will be transferred to CompilerFlags



# Set source files:
include( FileList )

# Set FORTRAN compiler flags:
include( CompilerFlags )


# Create the file code_version.f90, which contains the svn version number and date:
if( CREATE_VERSION )
  
  # SVN version generator:
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
add_executable( findplt  src/findplt.f90 ${evTools_std_files} )
add_executable( getgrid  src/getgrid.f90 ${evTools_std_files} )
add_executable( grid  src/grid.f90 ${evTools_std_files} )
add_executable( listmdl  src/listmdl.f90 ${evTools_std_files} ${evTools_mdl_files} )
add_executable( listmod  src/listmod.f90 ${evTools_std_files} )
add_executable( listplt  src/listplt.f90 ${evTools_std_files} )
add_executable( makerun  src/makerun.f90 ${evTools_std_files} )
add_executable( mergeplt  src/mergeplt.f90 ${evTools_std_files} )
add_executable( plt2ce  src/plt2ce.f90 ${evTools_std_files} )
add_executable( plt2dat  src/plt2dat.f90 ${evTools_std_files} )
add_executable( plt2obs  src/plt2obs.f90 ${evTools_std_files} )
add_executable( selplt  src/selplt.f90 ${evTools_std_files} ${evTools_plt_files} )

# Set module directory:
set_target_properties( dat2plt findplt getgrid grid listmdl listmod listplt makerun mergeplt plt2ce plt2dat plt2obs selplt 
  PROPERTIES Fortran_MODULE_DIRECTORY ${MODULE_DIRECTORY} )



# Create executable targets that need PGPlot:
add_executable( plotmdl  src/plotmdl.f90 ${evTools_std_files} ${evTools_mdl_files} ${evTools_plot_files} )
add_executable( plotmdln  src/plotmdln.f90 ${evTools_std_files} )
add_executable( plotmod  src/plotmod.f90 ${evTools_std_files} )
add_executable( plotplt  src/plotplt.f90 ${evTools_std_files} ${evTools_plt_files} ${evTools_plot_files} )


# Set module directory:
set_target_properties( plotmdl plotmdln plotmod plotplt 
  PROPERTIES Fortran_MODULE_DIRECTORY ${MODULE_DIRECTORY} )

# Link against PGPlot:
target_link_libraries( plotmdl ${PGPLOT_LIBRARIES} )
target_link_libraries( plotmdln ${PGPLOT_LIBRARIES} )
target_link_libraries( plotmod ${PGPLOT_LIBRARIES} )
target_link_libraries( plotplt ${PGPLOT_LIBRARIES} )



# Install to destination:
# - use DIRECTORY rather than TARGETS so that I don't need to specify them all again...
install( DIRECTORY usr/bin/ 
    FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE 
    DESTINATION ${CMAKE_INSTALL_PREFIX}/bin )


