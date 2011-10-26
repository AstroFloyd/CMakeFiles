## -----------------------------------------------------------------------------
## $Id:: CMakeLocations.cmake, from CMakeSettings.cmake 2818 2009-07-15 19:02:31Z baehren                 $
## -----------------------------------------------------------------------------

## Variables used through the configuration environment:
##
##  search_locations    --   ?
##  bin_locations       --   executables
##  include_locations   --   header and module files
##  lib_locations       --   libraries


# User's home directory:
set( HOME $ENV{HOME} )
  

set( search_locations
  /usr
  /usr/local
  /opt
  /opt/local
  /sw
  ${HOME}/usr
  CACHE
  PATH
  "Directories to look for include files"
  FORCE
  )


## ---------------------------------------------------------------------------
## locations in which to look for applications/binaries

set( bin_locations
  /usr/bin
  /usr/local/bin
  /sw/bin
  ${HOME}/usr/bin
  ${HOME}/bin
  CACHE
  PATH
  "Extra directories to look for executable files"
  FORCE
  )


## ----------------------------------------------------------------------------
## locations in which to look for header and module files

set( include_locations
  /usr/include
  /usr/local/include
  /opt/include
  /opt/local/include
  /sw/include
  ${HOME}/usr/include
  ${HOME}/include
  CACHE
  PATH
  "Directories to look for include files"
  FORCE
  )


## ----------------------------------------------------------------------------
## locations in which to look for libraries

set( lib_locations
  /usr/local/lib64
  /usr/local/lib
  /usr/lib64
  /usr/lib
  /opt/lib
  /opt/local/lib
  /sw/lib
  ${HOME}/usr/lib
  ${HOME}/lib
  CACHE
  PATH
  "Directories to look for libraries"
  FORCE
  )


#message( "${search_locations}" )
#message( "${bin_locations}" )
#message( "${include_locations}" )
#message( "${lib_locations}" )

