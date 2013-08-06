#!/bin/sh

##  code_version.sh:
##  Write the git hash or release-version number of the code and the compiler name to a Fortran source file
##  Copyright (c) 2010-2013 AstroFloyd - astrofloyd.org
##  
##  24/07/2010, AF: initial version for AnalyseMCMC, svn
##  06/10/2011, AF: svn -> bzr
##  09/11/2011, AF: generate 2 files: PG/PLplot; use bzr rev.no or release version
##  26/04/2012, AF: ported to libSUFR
##  25/11/2012, AF: bzr -> git


if [[ ${#} -ne 2 && ${#} -ne 4 ]]; then
    
    echo -e "\n  Syntax:"
    echo -e "    code_version.sh  <CMake base dir>  <f90 output file>  <Fortran compiler name>  <Compiler flags>"
    echo -e "    code_version.sh  <CMake base dir>  <f90 output file>  # For release versions\n"

else
    
    BASEDIR=${1}                        # CMake base dir
    F90FILE=${1}/${2}                   # Fortran-90 output file
    
    RELEASE='no'
    if [[ ${#} -eq 2 ]]; then
	RELEASE='yes'                   # RELEASE (true if "yes")
    fi
    
    if [[ ${#} -eq 4 ]]; then
	COMPILER=${3}                   # Compiler name
	COMPILER_FLAGS=${4}             # Compiler flags
    fi
    
    
    
    
    
    cd ${BASEDIR}
    
    if [[ ! -e .git/  && -e ${F90FILE} ]]
    then
	echo "${F90FILE} already exists, no need to create it"
	exit 0
    else
	if [ ${RELEASE} == 'yes' ]; then
	    echo "Generating release-version of ${F90FILE}"
	else
	    echo "Generating ${F90FILE}"
	fi
    fi
    
    
    echo "!> \file libSUFR_version.f90  Source file generated by CMake to report the libSUFR version used" > ${F90FILE}
    echo "" >> ${F90FILE}
    
    echo "!***********************************************************************************************************************************" >> ${F90FILE}
    echo "!> \brief  Report libSUFR version number" >> ${F90FILE}
    echo "" >> ${F90FILE}
    echo "module SUFR_version" >> ${F90FILE}
    echo "  implicit none" >> ${F90FILE}
    echo "  save" >> ${F90FILE}
    echo "  " >> ${F90FILE}
    echo "contains" >> ${F90FILE}
    echo "  " >> ${F90FILE}
    echo "  " >> ${F90FILE}
    
    
    echo "  !*********************************************************************************************************************************" >> ${F90FILE}
    echo "  !> \brief  Subroutine generated by CMake to report the code version used" >> ${F90FILE}
    echo "  " >> ${F90FILE}
    echo "  subroutine print_libSUFR_version(unit)" >> ${F90FILE}
    echo "    implicit none" >> ${F90FILE}
    echo "    integer, intent(in) :: unit" >> ${F90FILE}
    if [ ${RELEASE} == 'yes' ]; then
	echo "    character :: libSUFR_version*(99) = 'v"`cat .version`"'" >> ${F90FILE}
	echo "    character :: release_date*(99) = '"`date +"%F"`"'" >> ${F90FILE}
	
	echo "    " >> ${F90FILE}
	echo "    write(unit,'(A)', advance='no') 'libSUFR '//trim(libSUFR_version)//' ('//trim(release_date)//') - libsufr.sf.net'" >> ${F90FILE}
    else
	if [ -e .git/ ]; then  # Prefer revision number over release number
	    echo "    character :: libSUFR_version*(99) = 'rev."`git rev-list --abbrev-commit HEAD | wc -l`", hash "`git log --pretty="%h (%ad)" --date=short -n1`"'" >> ${F90FILE}
	#echo "  character :: code_version*(99) = 'rev."`git rev-list --abbrev-commit HEAD | wc -l`", "`git describe --tags`" "`git log --pretty="(%ad)" --date=short -n1`"'" >> ${F90FILE}  # Doesn't work on Mac OS(?)
	elif [ -e .bzr/ ]; then  # Prefer bzr revision number over release number
	    echo "    character :: libSUFR_version*(99) = 'revision "`bzr revno`"'" >> ${F90FILE}
	elif [ -e VERSION ]; then
	    echo "    character :: libSUFR_version*(99) = 'v"`grep 'Release version' VERSION | awk '{print $3}'`"'" >> ${F90FILE}
	elif [ -e doc/VERSION ]; then
	    echo "    character :: libSUFR_version*(99) = 'v"`grep 'Release version' doc/VERSION | awk '{print $3}'`"'" >> ${F90FILE}
	else
	    echo "    character :: libSUFR_version*(99) = '(unknown version)'" >> ${F90FILE}
	fi
	
	echo "    character :: compile_date*(99) = '"`date`"'" >> ${F90FILE}
	echo "    character :: compiler*(99) = '"${COMPILER}"'" >> ${F90FILE}
	echo "    character :: compiler_flags*(99) = '"${COMPILER_FLAGS}"'" >> ${F90FILE}
	
	echo "    " >> ${F90FILE}
	echo "    write(unit,'(A)', advance='no') 'libSUFR '//trim(libSUFR_version)//', compiled on '//trim(compile_date)//' with '// &" >> ${F90FILE}
	echo "         trim(compiler)//' '//trim(compiler_flags)" >> ${F90FILE}
    fi
    echo "    " >> ${F90FILE}
    echo "  end subroutine print_libSUFR_version" >> ${F90FILE}
    echo "  !*********************************************************************************************************************************" >> ${F90FILE}
    
  
    echo "  " >> ${F90FILE}
    echo "end module SUFR_version" >> ${F90FILE}
    echo "!***********************************************************************************************************************************" >> ${F90FILE}
    echo "" >> ${F90FILE}
    
    
    # touch -d doesn't work on FreeBSD
    #touch -d "1 Jan 2001" ${F90FILE}            # Make the file look old
    
fi


