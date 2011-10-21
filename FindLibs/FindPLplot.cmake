# Find PLplot header and library.

# This module defines the following uncached variables:
#  PLplot_FOUND, if false, do not try to use PLplot.
#  PLplot_INCLUDE_DIRS, where to find plplot.h.
#  PLplot_LIBRARIES, the libraries to link against to use PLplot
#  PLplot_LIBRARY_DIRS, the directory where the PLplot library is found.


# Standard locations where to look for required components:
include( CMakeLocations )


find_path(
  PLplot_INCLUDE_DIR
  #NAMES plplot.h
  NAMES plplot.mod
  PATHS ${include_locations} ${lib_locations}
  PATH_SUFFIXES plplot fortran/modules/plplot
)

if( PLplot_INCLUDE_DIR )
  find_library( PLplot_LIBRARY
    NAMES plplotd
    PATHS ${lib_locations}
  )
  if( PLplot_LIBRARY )
    set( PLplot_LIBRARY_DIR "" )
    get_filename_component( PLplot_LIBRARY_DIRS ${PLplot_LIBRARY} PATH )
    # Set uncached variables as per standard.
    set( PLplot_FOUND TRUE )
    set( PLplot_INCLUDE_DIRS ${PLplot_INCLUDE_DIR} )
    set( PLplot_LIBRARIES ${PLplot_LIBRARY} )
  else( PLplot_LIBRARY )
    set( PLplot_FOUND FALSE )
  endif( PLplot_LIBRARY )
  
  
  # find cxx bindings
  find_library( PLplot_cxx_LIBRARY
    NAMES plplotcxxd
    PATHS ${lib_locations}
  )
  if( PLplot_cxx_LIBRARY )
    set( PLplot_LIBRARIES ${PLplot_LIBRARIES} ${PLplot_cxx_LIBRARY} )
  endif( PLplot_cxx_LIBRARY )
  
  
  # find f77 bindings
  find_library( PLplot_f77_LIBRARY
    NAMES plplotf77d
    PATHS ${lib_locations}
  )
  if( PLplot_f77_LIBRARY )
    set( PLplot_LIBRARIES ${PLplot_LIBRARIES} ${PLplot_f77_LIBRARY} )
  endif( PLplot_f77_LIBRARY )
  
  
  # find f90 bindings
  find_library( PLplot_f90_LIBRARY
    NAMES plplotf90d
    PATHS ${lib_locations}
  )
  if( PLplot_f90_LIBRARY )
    set( PLplot_LIBRARIES ${PLplot_LIBRARIES} ${PLplot_f90_LIBRARY} )
  endif( PLplot_f90_LIBRARY )
  
  
  # find f95 bindings
  find_library( PLplot_f95_LIBRARY
    NAMES plplotf95d
    PATHS ${lib_locations}
  )
  if( PLplot_f95_LIBRARY )
    set( PLplot_LIBRARIES ${PLplot_LIBRARIES} ${PLplot_f95_LIBRARY} )
  endif( PLplot_f95_LIBRARY )
  
  # find f95c bindings
  find_library( PLplot_f95c_LIBRARY
    NAMES plplotf95cd
    PATHS ${lib_locations}
  )
  if( PLplot_f95c_LIBRARY )
    set( PLplot_LIBRARIES ${PLplot_LIBRARIES} ${PLplot_f95c_LIBRARY} )
  endif( PLplot_f95c_LIBRARY )
  
  
  # find wxwidgets bindings
  find_library( PLplot_wxwidgets_LIBRARY
    NAMES plplotwxwidgetsd
    PATHS ${lib_locations}
  )
  if( PLplot_wxwidgets_LIBRARY )
    set( PLplot_LIBRARIES ${PLplot_LIBRARIES} ${PLplot_wxwidgets_LIBRARY} )
  endif( PLplot_wxwidgets_LIBRARY )
  
  
else( PLplot_INCLUDE_DIR )
  
  set( PLplot_FOUND FALSE )

endif( PLplot_INCLUDE_DIR )


	    
if( PLplot_FOUND )
  if( NOT PLplot_FIND_QUIETLY )
    message( STATUS "FindPLplot: Found both PLplot headers and library" )
    message( STATUS "PLplot_INCLUDE_DIRS  = ${PLplot_INCLUDE_DIRS}" )
    message( STATUS "PLplot_LIBRARIES = ${PLplot_LIBRARIES}" )
  endif( NOT PLplot_FIND_QUIETLY )
else( PLplot_FOUND )
  if( PLplot_FIND_REQUIRED )
    message( FATAL_ERROR "FindPLplot: Could not find PLplot headers or library" )
  endif( PLplot_FIND_REQUIRED )
endif( PLplot_FOUND )

