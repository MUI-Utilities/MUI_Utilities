!-------------------------------------------------------------------------------
!    MUI Utility - FSI Coupling Lab
!    Copyright (C) 2021 Engineering and Environment Group, Scientific 
!    Computing Department, Science and Technology Facilities Council, 
!    UK Research and Innovation. All rights reserved.
!    This code is licensed under the GNU General Public License version 3
!    ** GNU General Public License, version 3 **
!    This program is free software: you can redistribute it and/or modify
!    it under the terms of the GNU General Public License as published by
!    the Free Software Foundation, either version 3 of the License, or
!    (at your option) any later version.
!    This program is distributed in the hope that it will be useful,
!    but WITHOUT ANY WARRANTY; without even the implied warranty of
!    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!    GNU General Public License for more details.
!    You should have received a copy of the GNU General Public License
!    along with this program.  If not, see <http://www.gnu.org/licenses/>.
!
!-------------------------------------------------------------------------------

!> \Filename      cs_MUI_CU_AK.f90
!> \Created       05 July 2019
!> \Module        cs_mui_cu_ak
!> \Description   Fortran wrapper of Aitken Coupling Method
!>                FSI Coupling utility for the MUI library
!> \Author        Wendi Liu
!______________________________________________________________________________

module cs_mui_cu_ak

!===============================================================================
! Module files
!===============================================================================

use, intrinsic :: iso_c_binding, only: c_ptr, c_null_ptr, c_int, c_bool, &
                                       c_double, c_char, c_null_char

!===============================================================================

implicit none

!===============================================================================
! Interfaces
!===============================================================================

interface

    ! function create_muiCouplingAitken_c(Narg, initUndRelxCpl) &
        ! bind(C, name="create_muiCouplingAitken")
        ! use iso_c_binding
        ! type(c_ptr) :: create_muiCouplingAitken_c
        ! integer(c_int), value :: Narg
        ! real(c_double), value :: initUndRelxCpl
    ! end function create_muiCouplingAitken_c

    ! function create_muiCouplingAitken_c(Narg, pointSize, initUndRelxCpl) &
        ! bind(C, name="create_muiCouplingAitken")
        ! use iso_c_binding
        ! type(c_ptr) :: create_muiCouplingAitken_c
        ! integer(c_int), value :: Narg
        ! integer(c_int), value :: pointSize
        ! real(c_double), value :: initUndRelxCpl
    ! end function create_muiCouplingAitken_c

    function create_muiCouplingAitken_c(Narg, pointSize, initUndRelxCpl, Fworld) &
        bind(C, name="create_muiCouplingAitken")
        use iso_c_binding
        type(c_ptr) :: create_muiCouplingAitken_c
        integer(c_int), value :: Narg
        integer(c_int), value :: pointSize
        real(c_double), value :: initUndRelxCpl
        type(c_ptr), value :: Fworld
    end function create_muiCouplingAitken_c

    subroutine delete_muiCouplingAitken_c(muiCouplingAitken) &
        bind(C, name="delete_muiCouplingAitken")
        use iso_c_binding
        type(c_ptr), value :: muiCouplingAitken
    end subroutine delete_muiCouplingAitken_c

    function muiCouplingAitken_undRelxCpl_c(muiCouplingAitken)  &
        bind(C, name="muiCouplingAitken_undRelxCpl")
        use iso_c_binding
        real(c_double) :: muiCouplingAitken_undRelxCpl_c
        ! The const qualification is translated into an intent(in)
        type(c_ptr), intent(in), value :: muiCouplingAitken
    end function muiCouplingAitken_undRelxCpl_c

    function muiCouplingAitken_getXDeltaDisp_c(muiCouplingAitken, pointv) &
        bind(C, name="muiCouplingAitken_getXDeltaDisp")
        use iso_c_binding
        real(c_double) :: muiCouplingAitken_getXDeltaDisp_c
        type(c_ptr), intent(in), value :: muiCouplingAitken
        integer(c_int), value :: pointv
    end function muiCouplingAitken_getXDeltaDisp_c
    
    function muiCouplingAitken_getYDeltaDisp_c(muiCouplingAitken, pointv) &
        bind(C, name="muiCouplingAitken_getYDeltaDisp")
        use iso_c_binding
        real(c_double) :: muiCouplingAitken_getYDeltaDisp_c
        type(c_ptr), intent(in), value :: muiCouplingAitken
        integer(c_int), value :: pointv
    end function muiCouplingAitken_getYDeltaDisp_c
    
    function muiCouplingAitken_getZDeltaDisp_c(muiCouplingAitken, pointv) &
        bind(C, name="muiCouplingAitken_getZDeltaDisp")
        use iso_c_binding
        real(c_double) :: muiCouplingAitken_getZDeltaDisp_c
        type(c_ptr), intent(in), value :: muiCouplingAitken
        integer(c_int), value :: pointv
    end function muiCouplingAitken_getZDeltaDisp_c
    
    function muiCouplingAitken_pointSize_c(muiCouplingAitken) &
        bind(C, name="muiCouplingAitken_pointSize")
        use iso_c_binding
        integer(c_int) :: muiCouplingAitken_pointSize_c
        type(c_ptr), intent(in), value :: muiCouplingAitken
    end function muiCouplingAitken_pointSize_c 

    function muiCouplingAitken_residualMagSqSum_c(muiCouplingAitken) &
        bind(C, name="muiCouplingAitken_residualMagSqSum")
        use iso_c_binding
        real(c_double) :: muiCouplingAitken_residualMagSqSum_c
        type(c_ptr), intent(in), value :: muiCouplingAitken
    end function muiCouplingAitken_residualMagSqSum_c    

    function muiCouplingAitken_residualL2NormMax_c(muiCouplingAitken) &
        bind(C, name="muiCouplingAitken_residualL2NormMax")
        use iso_c_binding
        real(c_double) :: muiCouplingAitken_residualL2NormMax_c
        type(c_ptr), intent(in), value :: muiCouplingAitken
    end function muiCouplingAitken_residualL2NormMax_c    

    function muiCouplingAitken_residualL2Norm_c(muiCouplingAitken) &
        bind(C, name="muiCouplingAitken_residualL2Norm")
        use iso_c_binding
        real(c_double) :: muiCouplingAitken_residualL2Norm_c
        type(c_ptr), intent(in), value :: muiCouplingAitken
    end function muiCouplingAitken_residualL2Norm_c

    ! void functions maps to subroutines
    ! subroutine muiCouplingAitken_initialize_c(muiCouplingAitken, Narg, pointSize) &
        ! bind(C, name="muiCouplingAitken_initialize")
        ! use iso_c_binding
        ! type(c_ptr), intent(in), value :: muiCouplingAitken
        ! integer(c_int), value :: Narg
        ! integer(c_int), value :: pointSize
    ! end subroutine muiCouplingAitken_initialize_c

    ! ! void functions maps to subroutines
    ! subroutine muiCouplingAitken_initialize_c(muiCouplingAitken, Narg, pointSize, Fworld) &
        ! bind(C, name="muiCouplingAitken_initialize")
        ! use iso_c_binding
        ! type(c_ptr), intent(in), value :: muiCouplingAitken
        ! integer(c_int), value :: Narg
        ! integer(c_int), value :: pointSize
        ! type(c_ptr), value :: Fworld
    ! end subroutine muiCouplingAitken_initialize_c

    ! void functions maps to subroutines
    subroutine muiCouplingAitken_initialize_c(muiCouplingAitken, Narg) &
        bind(C, name="muiCouplingAitken_initialize")
        use iso_c_binding
        type(c_ptr), intent(in), value :: muiCouplingAitken
        integer(c_int), value :: Narg
    end subroutine muiCouplingAitken_initialize_c
    
    subroutine muiCouplingAitken_collectResidual_c( muiCouplingAitken,  &
                                                    fetchMUIx,          &
                                                    fetchMUIy,          &
                                                    fetchMUIz,          &
                                                    disPreX,            &
                                                    disPreY,            &
                                                    disPreZ,            &
                                                    pointv)             &
        bind(C, name="muiCouplingAitken_collectResidual")
        use iso_c_binding
        type(c_ptr), intent(in), value :: muiCouplingAitken
        real(c_double), intent(in), value :: fetchMUIx
        real(c_double), intent(in), value :: fetchMUIy
        real(c_double), intent(in), value :: fetchMUIz
        real(c_double), intent(in), value :: disPreX
        real(c_double), intent(in), value :: disPreY
        real(c_double), intent(in), value :: disPreZ
        integer(c_int), value :: pointv
    end subroutine muiCouplingAitken_collectResidual_c
    
    ! void functions maps to subroutines
    subroutine muiCouplingAitken_process_c( muiCouplingAitken,  &
                                            iterN)             &
        bind(C, name="muiCouplingAitken_process")
        use iso_c_binding
        type(c_ptr), intent(in), value :: muiCouplingAitken
        integer(c_int), value :: iterN
    end subroutine muiCouplingAitken_process_c    
    

end interface


!===============================================================================
		
    private

    public :: muiCouplingAitken


!===============================================================================

    ! We'll use a Fortan type to represent a C++ class here, in an opaque maner
    type muiCouplingAitken
        private
        type(c_ptr) :: ptr ! pointer to the muiCouplingAitken class
    contains
        ! We can bind some functions to this type, allowing for a cleaner syntax.
! #ifdef __GNUC__
        procedure :: delete => delete_muiCouplingAitken_polymorph ! Destructor for gfortran
! #else
        ! final :: delete_muiCouplingAitken ! Destructor
! #endif
        ! Function member
        procedure :: initialize => muiCouplingAitken_initialize
        procedure :: pointSize => muiCouplingAitken_pointSize
        procedure :: collectResidual => muiCouplingAitken_collectResidual
        procedure :: getXDeltaDisp => muiCouplingAitken_getXDeltaDisp
        procedure :: getYDeltaDisp => muiCouplingAitken_getYDeltaDisp
        procedure :: getZDeltaDisp => muiCouplingAitken_getZDeltaDisp
        procedure :: process => muiCouplingAitken_process
    end type muiCouplingAitken


!===============================================================================

    ! This function will act as the constructor for muiCouplingAitken type
    interface muiCouplingAitken

        procedure create_muiCouplingAitken

    end interface muiCouplingAitken


!===============================================================================

contains ! Implementation of the functions. We just wrap the C function here.


    ! function create_muiCouplingAitken(initUndRelxCpl)
        ! type(muiCouplingAitken) :: create_muiCouplingAitken
        ! real(c_double), value :: initUndRelxCpl
        ! create_muiCouplingAitken%ptr = &
        ! create_muiCouplingAitken_c(1, initUndRelxCpl)
    ! end function create_muiCouplingAitken

    ! function create_muiCouplingAitken(pointSize, initUndRelxCpl)
        ! type(muiCouplingAitken) :: create_muiCouplingAitken
        ! integer(c_int), value :: pointSize
        ! real(c_double), value :: initUndRelxCpl
        ! create_muiCouplingAitken%ptr = &
        ! create_muiCouplingAitken_c(2, pointSize, initUndRelxCpl)
    ! end function create_muiCouplingAitken

    function create_muiCouplingAitken(pointSize, initUndRelxCpl, Fworld)
        type(muiCouplingAitken) :: create_muiCouplingAitken
        integer(c_int), value :: pointSize
        real(c_double), value :: initUndRelxCpl
        type(c_ptr), value :: Fworld
        create_muiCouplingAitken%ptr = &
        create_muiCouplingAitken_c(3, pointSize, initUndRelxCpl, Fworld)
    end function create_muiCouplingAitken

    subroutine delete_muiCouplingAitken(this)
        type(muiCouplingAitken) :: this
        call delete_muiCouplingAitken_c(this%ptr)
    end subroutine delete_muiCouplingAitken

    ! Bounds procedure needs to take a polymorphic (class) argument
    subroutine delete_muiCouplingAitken_polymorph(this)
         
        class(muiCouplingAitken) :: this
        call delete_muiCouplingAitken_c(this%ptr)
    end subroutine delete_muiCouplingAitken_polymorph

    real function muiCouplingAitken_undRelxCpl(this)
        class(muiCouplingAitken), intent(in) :: this
        muiCouplingAitken_undRelxCpl = muiCouplingAitken_undRelxCpl_c(this%ptr)
    end function muiCouplingAitken_undRelxCpl
    
    real function muiCouplingAitken_getXDeltaDisp(this, pointv)
        class(muiCouplingAitken), intent(in) :: this
        integer, value :: pointv
        muiCouplingAitken_getXDeltaDisp = muiCouplingAitken_getXDeltaDisp_c(this%ptr, pointv)
    end function muiCouplingAitken_getXDeltaDisp

    real function muiCouplingAitken_getYDeltaDisp(this, pointv)
        class(muiCouplingAitken), intent(in) :: this
        integer, value :: pointv
        muiCouplingAitken_getYDeltaDisp = muiCouplingAitken_getYDeltaDisp_c(this%ptr, pointv)
    end function muiCouplingAitken_getYDeltaDisp

    real function muiCouplingAitken_getZDeltaDisp(this, pointv)
        class(muiCouplingAitken), intent(in) :: this
        integer, value :: pointv
        muiCouplingAitken_getZDeltaDisp = muiCouplingAitken_getZDeltaDisp_c(this%ptr, pointv)
    end function muiCouplingAitken_getZDeltaDisp

    integer function muiCouplingAitken_pointSize(this)
        class(muiCouplingAitken), intent(in) :: this
        muiCouplingAitken_pointSize = muiCouplingAitken_pointSize_c(this%ptr)
    end function muiCouplingAitken_pointSize

    integer function muiCouplingAitken_residualMagSqSum(this)
        class(muiCouplingAitken), intent(in) :: this
        muiCouplingAitken_residualMagSqSum = muiCouplingAitken_residualMagSqSum_c(this%ptr)
    end function muiCouplingAitken_residualMagSqSum

    integer function muiCouplingAitken_residualL2NormMax(this)
        class(muiCouplingAitken), intent(in) :: this
        muiCouplingAitken_residualL2NormMax = muiCouplingAitken_residualL2NormMax_c(this%ptr)
    end function muiCouplingAitken_residualL2NormMax

    integer function muiCouplingAitken_residualL2Norm(this)
        class(muiCouplingAitken), intent(in) :: this
        muiCouplingAitken_residualL2Norm = muiCouplingAitken_residualL2Norm_c(this%ptr)
    end function muiCouplingAitken_residualL2Norm

    ! subroutine muiCouplingAitken_initialize(this, pointSize)
        ! class(muiCouplingAitken), intent(in) :: this
        ! integer(c_int), value :: pointSize
        ! call muiCouplingAitken_initialize_c(this%ptr, 1, pointSize)
    ! end subroutine muiCouplingAitken_initialize

    ! subroutine muiCouplingAitken_initialize(this, pointSize, Fworld)
        ! class(muiCouplingAitken), intent(in) :: this
        ! integer(c_int), value :: pointSize
        ! type(c_ptr), value :: Fworld
        ! call muiCouplingAitken_initialize_c(this%ptr, 2, pointSize, Fworld)
    ! end subroutine muiCouplingAitken_initialize

    subroutine muiCouplingAitken_initialize(this)
        class(muiCouplingAitken), intent(in) :: this
        call muiCouplingAitken_initialize_c(this%ptr, 0)
    end subroutine muiCouplingAitken_initialize

    subroutine muiCouplingAitken_collectResidual(   this,       &
                                                    fetchMUIx,  &
                                                    fetchMUIy,  &
                                                    fetchMUIz,  &
                                                    disPreX,    &
                                                    disPreY,    &
                                                    disPreZ,    &
                                                    pointv)

        class(muiCouplingAitken), intent(in) :: this
        real(c_double), intent(in), value :: fetchMUIx
        real(c_double), intent(in), value :: fetchMUIy
        real(c_double), intent(in), value :: fetchMUIz
        integer(c_int), value :: pointv
        real(c_double), intent(in), value :: disPreX
        real(c_double), intent(in), value :: disPreY
        real(c_double), intent(in), value :: disPreZ

        
        call muiCouplingAitken_collectResidual_c(   this%ptr,  &
                                                    fetchMUIx, &
                                                    fetchMUIy, &
                                                    fetchMUIz, &
                                                    disPreX,   &
                                                    disPreY,   &
                                                    disPreZ,   &
                                                    pointv)
    end subroutine muiCouplingAitken_collectResidual

    subroutine muiCouplingAitken_process(   this,   &
                                            iterN)
        class(muiCouplingAitken), intent(in) :: this
        integer(c_int), value :: iterN
        call muiCouplingAitken_process_c(   this%ptr, &
                                            iterN)
    end subroutine muiCouplingAitken_process

end module cs_mui_cu_ak
