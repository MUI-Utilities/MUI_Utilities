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

!> \Filename      cs_MUI_CU_FR.f90
!> \Created       29 May 2019
!> \Module        cs_mui_cu_fr
!> \Description   Fortran wrapper of Fixed Relaxation Coupling Method
!>                FSI Coupling utility for the MUI library
!> \Author        Wendi Liu
!______________________________________________________________________________

module cs_mui_cu_fr

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

    ! function create_muiCouplingFixedRelaxation_c(Narg, initUndRelxCpl) &
        ! bind(C, name="create_muiCouplingFixedRelaxation")
        ! use iso_c_binding
        ! type(c_ptr) :: create_muiCouplingFixedRelaxation_c
        ! integer(c_int), value :: Narg
        ! real(c_double), value :: initUndRelxCpl
    ! end function create_muiCouplingFixedRelaxation_c

    ! function create_muiCouplingFixedRelaxation_c(Narg, pointSize, initUndRelxCpl) &
        ! bind(C, name="create_muiCouplingFixedRelaxation")
        ! use iso_c_binding
        ! type(c_ptr) :: create_muiCouplingFixedRelaxation_c
        ! integer(c_int), value :: Narg
        ! real(c_double), value :: initUndRelxCpl
        ! integer(c_int), value :: pointSize
    ! end function create_muiCouplingFixedRelaxation_c

    function create_muiCouplingFixedRelaxation_c(Narg, pointSize, initUndRelxCpl, Fworld) &
        bind(C, name="create_muiCouplingFixedRelaxation")
        use iso_c_binding
        type(c_ptr) :: create_muiCouplingFixedRelaxation_c
        integer(c_int), value :: Narg
        real(c_double), value :: initUndRelxCpl
        integer(c_int), value :: pointSize
        type(c_ptr), value :: Fworld
    end function create_muiCouplingFixedRelaxation_c

    subroutine delete_muiCouplingFixedRelaxation_c(muiCouplingFixedRelaxation) &
        bind(C, name="delete_muiCouplingFixedRelaxation")
        use iso_c_binding
        type(c_ptr), value :: muiCouplingFixedRelaxation
    end subroutine delete_muiCouplingFixedRelaxation_c

    function muiCouplingFixedRelaxation_undRelxCpl_c(muiCouplingFixedRelaxation)  &
        bind(C, name="muiCouplingFixedRelaxation_undRelxCpl")
        use iso_c_binding
        real(c_double) :: muiCouplingFixedRelaxation_undRelxCpl_c
        ! The const qualification is translated into an intent(in)
        type(c_ptr), intent(in), value :: muiCouplingFixedRelaxation
    end function muiCouplingFixedRelaxation_undRelxCpl_c

    function muiCouplingFixedRelaxation_getXDeltaDisp_c(muiCouplingFixedRelaxation, pointN) &
        bind(C, name="muiCouplingFixedRelaxation_getXDeltaDisp")
        use iso_c_binding
        real(c_double) :: muiCouplingFixedRelaxation_getXDeltaDisp_c
        type(c_ptr), intent(in), value :: muiCouplingFixedRelaxation
        integer(c_int), value :: pointN
    end function muiCouplingFixedRelaxation_getXDeltaDisp_c
    
    function muiCouplingFixedRelaxation_getYDeltaDisp_c(muiCouplingFixedRelaxation, pointN) &
        bind(C, name="muiCouplingFixedRelaxation_getYDeltaDisp")
        use iso_c_binding
        real(c_double) :: muiCouplingFixedRelaxation_getYDeltaDisp_c
        type(c_ptr), intent(in), value :: muiCouplingFixedRelaxation
        integer(c_int), value :: pointN
    end function muiCouplingFixedRelaxation_getYDeltaDisp_c
    
    function muiCouplingFixedRelaxation_getZDeltaDisp_c(muiCouplingFixedRelaxation, pointN) &
        bind(C, name="muiCouplingFixedRelaxation_getZDeltaDisp")
        use iso_c_binding
        real(c_double) :: muiCouplingFixedRelaxation_getZDeltaDisp_c
        type(c_ptr), intent(in), value :: muiCouplingFixedRelaxation
        integer(c_int), value :: pointN
    end function muiCouplingFixedRelaxation_getZDeltaDisp_c
    
    function muiCouplingFixedRelaxation_pointSize_c(muiCouplingFixedRelaxation) &
        bind(C, name="muiCouplingFixedRelaxation_pointSize")
        use iso_c_binding
        integer(c_int) :: muiCouplingFixedRelaxation_pointSize_c
        type(c_ptr), intent(in), value :: muiCouplingFixedRelaxation
    end function muiCouplingFixedRelaxation_pointSize_c

    function muiCouplingFixedRelaxation_residualMagSqSum_c(muiCouplingFixedRelaxation) &
        bind(C, name="muiCouplingFixedRelaxation_residualMagSqSum")
        use iso_c_binding
        real(c_double) :: muiCouplingFixedRelaxation_residualMagSqSum_c
        type(c_ptr), intent(in), value :: muiCouplingFixedRelaxation
    end function muiCouplingFixedRelaxation_residualMagSqSum_c
    
    function muiCouplingFixedRelaxation_residualL2NormMax_c(muiCouplingFixedRelaxation) &
        bind(C, name="muiCouplingFixedRelaxation_residualL2NormMax")
        use iso_c_binding
        real(c_double) :: muiCouplingFixedRelaxation_residualL2NormMax_c
        type(c_ptr), intent(in), value :: muiCouplingFixedRelaxation
    end function muiCouplingFixedRelaxation_residualL2NormMax_c
    
    function muiCouplingFixedRelaxation_residualL2Norm_c(muiCouplingFixedRelaxation) &
        bind(C, name="muiCouplingFixedRelaxation_residualL2Norm")
        use iso_c_binding
        real(c_double) :: muiCouplingFixedRelaxation_residualL2Norm_c
        type(c_ptr), intent(in), value :: muiCouplingFixedRelaxation
    end function muiCouplingFixedRelaxation_residualL2Norm_c

    ! void functions maps to subroutines
    ! subroutine muiCouplingFixedRelaxation_initialize_c(muiCouplingFixedRelaxation, Narg, pointSize) &
        ! bind(C, name="muiCouplingFixedRelaxation_initialize")
        ! use iso_c_binding
        ! type(c_ptr), intent(in), value :: muiCouplingFixedRelaxation
        ! integer(c_int), value :: pointSize
        ! integer(c_int), value :: Narg
    ! end subroutine muiCouplingFixedRelaxation_initialize_c

    ! subroutine muiCouplingFixedRelaxation_initialize_c(muiCouplingFixedRelaxation, Narg, pointSize, Fworld) &
        ! bind(C, name="muiCouplingFixedRelaxation_initialize")
        ! use iso_c_binding
        ! type(c_ptr), intent(in), value :: muiCouplingFixedRelaxation
        ! integer(c_int), value :: pointSize
        ! type(c_ptr), value :: Fworld
        ! integer(c_int), value :: Narg
    ! end subroutine muiCouplingFixedRelaxation_initialize_c
    
    subroutine muiCouplingFixedRelaxation_initialize_c(muiCouplingFixedRelaxation, Narg) &
        bind(C, name="muiCouplingFixedRelaxation_initialize")
        use iso_c_binding
        type(c_ptr), intent(in), value :: muiCouplingFixedRelaxation
        integer(c_int), value :: Narg
    end subroutine muiCouplingFixedRelaxation_initialize_c
    
    subroutine muiCouplingFixedRelaxation_collectResidual_c(muiCouplingFixedRelaxation, &
                                                            fetchMUIx,                  &
                                                            fetchMUIy,                  &
                                                            fetchMUIz,                  &
                                                            disPreX,                    &
                                                            disPreY,                    &
                                                            disPreZ,                    &
                                                            pointN)                     &
        bind(C, name="muiCouplingFixedRelaxation_collectResidual")
        use iso_c_binding
        type(c_ptr), intent(in), value :: muiCouplingFixedRelaxation
        real(c_double), intent(in), value :: fetchMUIx
        real(c_double), intent(in), value :: fetchMUIy
        real(c_double), intent(in), value :: fetchMUIz
        real(c_double), intent(in), value :: disPreX
        real(c_double), intent(in), value :: disPreY
        real(c_double), intent(in), value :: disPreZ
        integer(c_int), value :: pointN
    end subroutine muiCouplingFixedRelaxation_collectResidual_c
    
    ! void functions maps to subroutines
    subroutine muiCouplingFixedRelaxation_process_c(muiCouplingFixedRelaxation) &
        bind(C, name="muiCouplingFixedRelaxation_process")
        use iso_c_binding
        type(c_ptr), intent(in), value :: muiCouplingFixedRelaxation
    end subroutine muiCouplingFixedRelaxation_process_c    
    

end interface


!===============================================================================
		
    private

    public :: muiCouplingFixedRelaxation


!===============================================================================

    ! We'll use a Fortan type to represent a C++ class here, in an opaque maner
    type muiCouplingFixedRelaxation
        private
        type(c_ptr) :: ptr ! pointer to the muiCouplingFixedRelaxation class
    contains
        ! We can bind some functions to this type, allowing for a cleaner syntax.
! #ifdef __GNUC__
        procedure :: delete => delete_muiCouplingFixedRelaxation_polymorph ! Destructor for gfortran
! #else
        ! final :: delete_muiCouplingFixedRelaxation ! Destructor
! #endif
        ! Function member
        !procedure :: initialize => muiCouplingFixedRelaxation_initialize
        procedure :: pointSize => muiCouplingFixedRelaxation_pointSize
        procedure :: collectResidual => muiCouplingFixedRelaxation_collectResidual
        procedure :: getXDeltaDisp => muiCouplingFixedRelaxation_getXDeltaDisp
        procedure :: getYDeltaDisp => muiCouplingFixedRelaxation_getYDeltaDisp
        procedure :: getZDeltaDisp => muiCouplingFixedRelaxation_getZDeltaDisp
        procedure :: process => muiCouplingFixedRelaxation_process
    end type muiCouplingFixedRelaxation


!===============================================================================

    ! This function will act as the constructor for muiCouplingFixedRelaxation type
    interface muiCouplingFixedRelaxation

        procedure create_muiCouplingFixedRelaxation

    end interface muiCouplingFixedRelaxation


!===============================================================================

contains ! Implementation of the functions. We just wrap the C function here.


    ! function create_muiCouplingFixedRelaxation(initUndRelxCpl)
        ! type(muiCouplingFixedRelaxation) :: create_muiCouplingFixedRelaxation
        ! real(c_double), value :: initUndRelxCpl
        ! create_muiCouplingFixedRelaxation%ptr = &
        ! create_muiCouplingFixedRelaxation_c(1, initUndRelxCpl)
    ! end function create_muiCouplingFixedRelaxation

    ! function create_muiCouplingFixedRelaxation(pointSize, initUndRelxCpl)
        ! type(muiCouplingFixedRelaxation) :: create_muiCouplingFixedRelaxation
        ! real(c_double), value :: initUndRelxCpl
        ! integer(c_int), value :: pointSize
        ! create_muiCouplingFixedRelaxation%ptr = &
        ! create_muiCouplingFixedRelaxation_c(2, pointSize, initUndRelxCpl)
    ! end function create_muiCouplingFixedRelaxation

    function create_muiCouplingFixedRelaxation(pointSize, initUndRelxCpl, Fworld)
        type(muiCouplingFixedRelaxation) :: create_muiCouplingFixedRelaxation
        real(c_double), value :: initUndRelxCpl
        type(c_ptr), value :: Fworld
        integer(c_int), value :: pointSize
        create_muiCouplingFixedRelaxation%ptr = &
        create_muiCouplingFixedRelaxation_c(3, pointSize, initUndRelxCpl, Fworld)
    end function create_muiCouplingFixedRelaxation

    subroutine delete_muiCouplingFixedRelaxation(this)
        type(muiCouplingFixedRelaxation) :: this
        call delete_muiCouplingFixedRelaxation_c(this%ptr)
    end subroutine delete_muiCouplingFixedRelaxation

    ! Bounds procedure needs to take a polymorphic (class) argument
    subroutine delete_muiCouplingFixedRelaxation_polymorph(this)
         
        class(muiCouplingFixedRelaxation) :: this
        call delete_muiCouplingFixedRelaxation_c(this%ptr)
    end subroutine delete_muiCouplingFixedRelaxation_polymorph

    real function muiCouplingFixedRelaxation_undRelxCpl(this)
        class(muiCouplingFixedRelaxation), intent(in) :: this
        muiCouplingFixedRelaxation_undRelxCpl = muiCouplingFixedRelaxation_undRelxCpl_c(this%ptr)
    end function muiCouplingFixedRelaxation_undRelxCpl
    
    real function muiCouplingFixedRelaxation_getXDeltaDisp(this, pointN)
        class(muiCouplingFixedRelaxation), intent(in) :: this
        integer, value :: pointN
        muiCouplingFixedRelaxation_getXDeltaDisp = muiCouplingFixedRelaxation_getXDeltaDisp_c(this%ptr, pointN)
    end function muiCouplingFixedRelaxation_getXDeltaDisp

    real function muiCouplingFixedRelaxation_getYDeltaDisp(this, pointN)
        class(muiCouplingFixedRelaxation), intent(in) :: this
        integer, value :: pointN
        muiCouplingFixedRelaxation_getYDeltaDisp = muiCouplingFixedRelaxation_getYDeltaDisp_c(this%ptr, pointN)
    end function muiCouplingFixedRelaxation_getYDeltaDisp

    real function muiCouplingFixedRelaxation_getZDeltaDisp(this, pointN)
        class(muiCouplingFixedRelaxation), intent(in) :: this
        integer, value :: pointN
        muiCouplingFixedRelaxation_getZDeltaDisp = muiCouplingFixedRelaxation_getZDeltaDisp_c(this%ptr, pointN)
    end function muiCouplingFixedRelaxation_getZDeltaDisp

    integer function muiCouplingFixedRelaxation_pointSize(this)
        class(muiCouplingFixedRelaxation), intent(in) :: this
        muiCouplingFixedRelaxation_pointSize = muiCouplingFixedRelaxation_pointSize_c(this%ptr)
    end function muiCouplingFixedRelaxation_pointSize

    integer function muiCouplingFixedRelaxation_residualMagSqSum(this)
        class(muiCouplingFixedRelaxation), intent(in) :: this
        muiCouplingFixedRelaxation_residualMagSqSum = muiCouplingFixedRelaxation_residualMagSqSum_c(this%ptr)
    end function muiCouplingFixedRelaxation_residualMagSqSum

    integer function muiCouplingFixedRelaxation_residualL2NormMax(this)
        class(muiCouplingFixedRelaxation), intent(in) :: this
        muiCouplingFixedRelaxation_residualL2NormMax = muiCouplingFixedRelaxation_residualL2NormMax_c(this%ptr)
    end function muiCouplingFixedRelaxation_residualL2NormMax

    integer function muiCouplingFixedRelaxation_residualL2Norm(this)
        class(muiCouplingFixedRelaxation), intent(in) :: this
        muiCouplingFixedRelaxation_residualL2Norm = muiCouplingFixedRelaxation_residualL2Norm_c(this%ptr)
    end function muiCouplingFixedRelaxation_residualL2Norm

    ! subroutine muiCouplingFixedRelaxation_initialize(this, pointSize)
        ! class(muiCouplingFixedRelaxation), intent(in) :: this
        ! integer(c_int), value :: pointSize
        ! call muiCouplingFixedRelaxation_initialize_c(this%ptr, 1, pointSize)
    ! end subroutine muiCouplingFixedRelaxation_initialize

    ! subroutine muiCouplingFixedRelaxation_initialize(this, pointSize, Fworld)
        ! class(muiCouplingFixedRelaxation), intent(in) :: this
        ! integer(c_int), value :: pointSize
        ! type(c_ptr), value :: Fworld
        ! call muiCouplingFixedRelaxation_initialize_c(this%ptr, 2, pointSize, Fworld)
    ! end subroutine muiCouplingFixedRelaxation_initialize

    subroutine muiCouplingFixedRelaxation_initialize(this)
        class(muiCouplingFixedRelaxation), intent(in) :: this
        call muiCouplingFixedRelaxation_initialize_c(this%ptr, 0)
    end subroutine muiCouplingFixedRelaxation_initialize

    subroutine muiCouplingFixedRelaxation_collectResidual(  this,       &
                                                            fetchMUIx,  &
                                                            fetchMUIy,  &
                                                            fetchMUIz,  &
                                                            disPreX,    &
                                                            disPreY,    &
                                                            disPreZ,    &
                                                            pointN)

        class(muiCouplingFixedRelaxation), intent(in) :: this
        real(c_double), intent(in), value :: fetchMUIx
        real(c_double), intent(in), value :: fetchMUIy
        real(c_double), intent(in), value :: fetchMUIz
        integer(c_int), value :: pointN
        real(c_double), intent(in), value :: disPreX
        real(c_double), intent(in), value :: disPreY
        real(c_double), intent(in), value :: disPreZ

        
        call muiCouplingFixedRelaxation_collectResidual_c(  this%ptr,  &
                                                            fetchMUIx, &
                                                            fetchMUIy, &
                                                            fetchMUIz, &
                                                            disPreX,   &
                                                            disPreY,   &
                                                            disPreZ,   &
                                                            pointN)
    end subroutine muiCouplingFixedRelaxation_collectResidual

    subroutine muiCouplingFixedRelaxation_process(this)
        class(muiCouplingFixedRelaxation), intent(in) :: this
        call muiCouplingFixedRelaxation_process_c(this%ptr)
    end subroutine muiCouplingFixedRelaxation_process

end module cs_mui_cu_fr
