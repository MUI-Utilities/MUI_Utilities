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

!> \Filename      cs_MUI_CU_IQNILS.f90
!> \Created       10 July 2019
!> \Module        cs_mui_cu_iqnils
!> \Description   Fortran wrapper of Interface Quasi-Newton
!>                with Inverse Jacobian 
!>                from Least Squares model (IQN-ILS) Coupling Method
!>                FSI Coupling utility for the MUI library
!> \Author        Wendi Liu
!______________________________________________________________________________

module cs_mui_cu_iqnils

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

    ! function create_muiCouplingIQNILS_c(Narg, initUndRelxCpl) &
        ! bind(C, name="create_muiCouplingIQNILS")
        ! use iso_c_binding
        ! type(c_ptr) :: create_muiCouplingIQNILS_c
        ! integer(c_int), value :: Narg
        ! real(c_double), value :: initUndRelxCpl
    ! end function create_muiCouplingIQNILS_c

    ! function create_muiCouplingIQNILS_c(Narg, pointSize, initUndRelxCpl, &
    ! undRelxCplMax, aitkenIterationN, globalAlphaInput) &
        ! bind(C, name="create_muiCouplingIQNILS")
        ! use iso_c_binding
        ! type(c_ptr) :: create_muiCouplingIQNILS_c
        ! integer(c_int), value :: Narg
        ! integer(c_int), value :: pointSize
        ! real(c_double), value :: initUndRelxCpl
        ! real(c_double), value :: undRelxCplMax
        ! integer(c_int), value :: aitkenIterationN
        ! integer(c_bool), value :: globalAlphaInput
    ! end function create_muiCouplingIQNILS_c

    ! function create_muiCouplingIQNILS_c(Narg, pointSize, initUndRelxCpl, Fworld, &
    ! undRelxCplMax, aitkenIterationN, globalAlphaInput) &
        ! bind(C, name="create_muiCouplingIQNILS")
        ! use iso_c_binding
        ! type(c_ptr) :: create_muiCouplingIQNILS_c
        ! integer(c_int), value :: Narg
        ! integer(c_int), value :: pointSize
        ! real(c_double), value :: initUndRelxCpl
        ! type(c_ptr), value :: Fworld
        ! real(c_double), value :: undRelxCplMax
        ! integer(c_int), value :: aitkenIterationN
        ! integer(c_bool), value :: globalAlphaInput
    ! end function create_muiCouplingIQNILS_c

    function create_muiCouplingIQNILS_c(Narg, pointSize, initUndRelxCpl, Fworld) &
        bind(C, name="create_muiCouplingIQNILS")
        use iso_c_binding
        type(c_ptr) :: create_muiCouplingIQNILS_c
        integer(c_int), value :: Narg
        integer(c_int), value :: pointSize
        real(c_double), value :: initUndRelxCpl
        type(c_ptr), value :: Fworld
    end function create_muiCouplingIQNILS_c

    subroutine delete_muiCouplingIQNILS_c(muiCouplingIQNILS) &
        bind(C, name="delete_muiCouplingIQNILS")
        use iso_c_binding
        type(c_ptr), value :: muiCouplingIQNILS
    end subroutine delete_muiCouplingIQNILS_c

    function muiCouplingIQNILS_undRelxCpl_c(muiCouplingIQNILS)  &
        bind(C, name="muiCouplingIQNILS_undRelxCpl")
        use iso_c_binding
        real(c_double) :: muiCouplingIQNILS_undRelxCpl_c
        ! The const qualification is translated into an intent(in)
        type(c_ptr), intent(in), value :: muiCouplingIQNILS
    end function muiCouplingIQNILS_undRelxCpl_c

    function muiCouplingIQNILS_getXDeltaDisp_c(muiCouplingIQNILS, pointv) &
        bind(C, name="muiCouplingIQNILS_getXDeltaDisp")
        use iso_c_binding
        real(c_double) :: muiCouplingIQNILS_getXDeltaDisp_c
        type(c_ptr), intent(in), value :: muiCouplingIQNILS
        integer(c_int), value :: pointv
    end function muiCouplingIQNILS_getXDeltaDisp_c
    
    function muiCouplingIQNILS_getYDeltaDisp_c(muiCouplingIQNILS, pointv) &
        bind(C, name="muiCouplingIQNILS_getYDeltaDisp")
        use iso_c_binding
        real(c_double) :: muiCouplingIQNILS_getYDeltaDisp_c
        type(c_ptr), intent(in), value :: muiCouplingIQNILS
        integer(c_int), value :: pointv
    end function muiCouplingIQNILS_getYDeltaDisp_c
    
    function muiCouplingIQNILS_getZDeltaDisp_c(muiCouplingIQNILS, pointv) &
        bind(C, name="muiCouplingIQNILS_getZDeltaDisp")
        use iso_c_binding
        real(c_double) :: muiCouplingIQNILS_getZDeltaDisp_c
        type(c_ptr), intent(in), value :: muiCouplingIQNILS
        integer(c_int), value :: pointv
    end function muiCouplingIQNILS_getZDeltaDisp_c
    
    function muiCouplingIQNILS_pointSize_c(muiCouplingIQNILS) &
        bind(C, name="muiCouplingIQNILS_pointSize")
        use iso_c_binding
        integer(c_int) :: muiCouplingIQNILS_pointSize_c
        type(c_ptr), intent(in), value :: muiCouplingIQNILS
    end function muiCouplingIQNILS_pointSize_c
    
    function muiCouplingIQNILS_residualMagSqSum_c(muiCouplingIQNILS) &
        bind(C, name="muiCouplingIQNILS_residualMagSqSum")
        use iso_c_binding
        real(c_double) :: muiCouplingIQNILS_residualMagSqSum_c
        type(c_ptr), intent(in), value :: muiCouplingIQNILS
    end function muiCouplingIQNILS_residualMagSqSum_c

    function muiCouplingIQNILS_residualL2NormMax_c(muiCouplingIQNILS) &
        bind(C, name="muiCouplingIQNILS_residualL2NormMax")
        use iso_c_binding
        real(c_double) :: muiCouplingIQNILS_residualL2NormMax_c
        type(c_ptr), intent(in), value :: muiCouplingIQNILS
    end function muiCouplingIQNILS_residualL2NormMax_c

    function muiCouplingIQNILS_residualL2Norm_c(muiCouplingIQNILS) &
        bind(C, name="muiCouplingIQNILS_residualL2Norm")
        use iso_c_binding
        real(c_double) :: muiCouplingIQNILS_residualL2Norm_c
        type(c_ptr), intent(in), value :: muiCouplingIQNILS
    end function muiCouplingIQNILS_residualL2Norm_c

    ! void functions maps to subroutines
    ! subroutine muiCouplingIQNILS_initialize_c(muiCouplingIQNILS, Narg, &
    ! pointSize, undRelxCplMax, aitkenIterationN, globalAlphaInput) &
        ! bind(C, name="muiCouplingIQNILS_initialize")
        ! use iso_c_binding
        ! type(c_ptr), intent(in), value :: muiCouplingIQNILS
        ! integer(c_int), value :: Narg
        ! integer(c_int), value :: pointSize
        ! real(c_double), value :: undRelxCplMax
        ! integer(c_int), value :: aitkenIterationN
        ! integer(c_bool), value :: globalAlphaInput
    ! end subroutine muiCouplingIQNILS_initialize_c

    ! ! void functions maps to subroutines
    ! subroutine muiCouplingIQNILS_initialize_c(muiCouplingIQNILS, Narg, &
    ! pointSize, Fworld, undRelxCplMax, aitkenIterationN, globalAlphaInput) &
        ! bind(C, name="muiCouplingIQNILS_initialize")
        ! use iso_c_binding
        ! type(c_ptr), intent(in), value :: muiCouplingIQNILS
        ! integer(c_int), value :: Narg
        ! integer(c_int), value :: pointSize
        ! type(c_ptr), value :: Fworld
        ! real(c_double), value :: undRelxCplMax
        ! integer(c_int), value :: aitkenIterationN
        ! integer(c_bool), value :: globalAlphaInput
    ! end subroutine muiCouplingIQNILS_initialize_c

    ! void functions maps to subroutines
    subroutine muiCouplingIQNILS_initialize_c(muiCouplingIQNILS, Narg) &
        bind(C, name="muiCouplingIQNILS_initialize")
        use iso_c_binding
        type(c_ptr), intent(in), value :: muiCouplingIQNILS
        integer(c_int), value :: Narg
    end subroutine muiCouplingIQNILS_initialize_c
    
    subroutine muiCouplingIQNILS_collectResidual_c( muiCouplingIQNILS,  &
                                                    fetchMUIx,          &
                                                    fetchMUIy,          &
                                                    fetchMUIz,          &
                                                    disPreX,            &
                                                    disPreY,            &
                                                    disPreZ,            &
                                                    pointv)             &
        bind(C, name="muiCouplingIQNILS_collectResidual")
        use iso_c_binding
        type(c_ptr), intent(in), value :: muiCouplingIQNILS
        real(c_double), intent(in), value :: fetchMUIx
        real(c_double), intent(in), value :: fetchMUIy
        real(c_double), intent(in), value :: fetchMUIz
        real(c_double), intent(in), value :: disPreX
        real(c_double), intent(in), value :: disPreY
        real(c_double), intent(in), value :: disPreZ
        integer(c_int), value :: pointv
    end subroutine muiCouplingIQNILS_collectResidual_c
    
    ! void functions maps to subroutines
    subroutine muiCouplingIQNILS_process_c( muiCouplingIQNILS,  &
                                            iterN)             &
        bind(C, name="muiCouplingIQNILS_process")
        use iso_c_binding
        type(c_ptr), intent(in), value :: muiCouplingIQNILS
        integer(c_int), value :: iterN
    end subroutine muiCouplingIQNILS_process_c    
    

end interface


!===============================================================================
		
    private

    public :: muiCouplingIQNILS


!===============================================================================

    ! We'll use a Fortan type to represent a C++ class here, in an opaque maner
    type muiCouplingIQNILS
        private
        type(c_ptr) :: ptr ! pointer to the muiCouplingIQNILS class
    contains
        ! We can bind some functions to this type, allowing for a cleaner syntax.
! #ifdef __GNUC__
        procedure :: delete => delete_muiCouplingIQNILS_polymorph ! Destructor for gfortran
! #else
        ! final :: delete_muiCouplingIQNILS ! Destructor
! #endif
        ! Function member
        procedure :: initialize => muiCouplingIQNILS_initialize
        procedure :: pointSize => muiCouplingIQNILS_pointSize
        procedure :: collectResidual => muiCouplingIQNILS_collectResidual
        procedure :: getXDeltaDisp => muiCouplingIQNILS_getXDeltaDisp
        procedure :: getYDeltaDisp => muiCouplingIQNILS_getYDeltaDisp
        procedure :: getZDeltaDisp => muiCouplingIQNILS_getZDeltaDisp
        procedure :: process => muiCouplingIQNILS_process
    end type muiCouplingIQNILS


!===============================================================================

    ! This function will act as the constructor for muiCouplingIQNILS type
    interface muiCouplingIQNILS

        procedure create_muiCouplingIQNILS

    end interface muiCouplingIQNILS


!===============================================================================

contains ! Implementation of the functions. We just wrap the C function here.


    ! function create_muiCouplingIQNILS(initUndRelxCpl)
        ! type(muiCouplingIQNILS) :: create_muiCouplingIQNILS
        ! real(c_double), value :: initUndRelxCpl
        ! create_muiCouplingIQNILS%ptr = &
        ! create_muiCouplingIQNILS_c(1, initUndRelxCpl)
    ! end function create_muiCouplingIQNILS

    ! function create_muiCouplingIQNILS(pointSize, initUndRelxCpl, &
    ! undRelxCplMax, aitkenIterationN, globalAlphaInput)
        ! type(muiCouplingIQNILS) :: create_muiCouplingIQNILS
        ! integer(c_int), value :: pointSize
        ! real(c_double), value :: initUndRelxCpl
        ! real(c_double), value :: undRelxCplMax
        ! integer(c_int), value :: aitkenIterationN
        ! integer(c_bool), value :: globalAlphaInput
        ! create_muiCouplingIQNILS%ptr = &
        ! create_muiCouplingIQNILS_c(5, pointSize, initUndRelxCpl, &
        ! undRelxCplMax, aitkenIterationN, globalAlphaInput)
    ! end function create_muiCouplingIQNILS

    ! function create_muiCouplingIQNILS(pointSize, initUndRelxCpl, &
    ! Fworld, undRelxCplMax, aitkenIterationN, globalAlphaInput)
        ! type(muiCouplingIQNILS) :: create_muiCouplingIQNILS
        ! integer(c_int), value :: pointSize
        ! real(c_double), value :: initUndRelxCpl
        ! type(c_ptr), value :: Fworld
        ! real(c_double), value :: undRelxCplMax
        ! integer(c_int), value :: aitkenIterationN
        ! integer(c_bool), value :: globalAlphaInput
        ! create_muiCouplingIQNILS%ptr = &
        ! create_muiCouplingIQNILS_c(6, pointSize, initUndRelxCpl, &
        ! Fworld, undRelxCplMax, aitkenIterationN, globalAlphaInput)
    ! end function create_muiCouplingIQNILS

    function create_muiCouplingIQNILS(pointSize, initUndRelxCpl, Fworld)
        type(muiCouplingIQNILS) :: create_muiCouplingIQNILS
        integer(c_int), value :: pointSize
        real(c_double), value :: initUndRelxCpl
        type(c_ptr), value :: Fworld
        create_muiCouplingIQNILS%ptr = &
        create_muiCouplingIQNILS_c(3, pointSize, initUndRelxCpl, Fworld)
    end function create_muiCouplingIQNILS

    subroutine delete_muiCouplingIQNILS(this)
        type(muiCouplingIQNILS) :: this
        call delete_muiCouplingIQNILS_c(this%ptr)
    end subroutine delete_muiCouplingIQNILS

    ! Bounds procedure needs to take a polymorphic (class) argument
    subroutine delete_muiCouplingIQNILS_polymorph(this)
         
        class(muiCouplingIQNILS) :: this
        call delete_muiCouplingIQNILS_c(this%ptr)
    end subroutine delete_muiCouplingIQNILS_polymorph

    real function muiCouplingIQNILS_undRelxCpl(this)
        class(muiCouplingIQNILS), intent(in) :: this
        muiCouplingIQNILS_undRelxCpl = muiCouplingIQNILS_undRelxCpl_c(this%ptr)
    end function muiCouplingIQNILS_undRelxCpl
    
    real function muiCouplingIQNILS_getXDeltaDisp(this, pointv)
        class(muiCouplingIQNILS), intent(in) :: this
        integer, value :: pointv
        muiCouplingIQNILS_getXDeltaDisp = muiCouplingIQNILS_getXDeltaDisp_c(this%ptr, pointv)
    end function muiCouplingIQNILS_getXDeltaDisp

    real function muiCouplingIQNILS_getYDeltaDisp(this, pointv)
        class(muiCouplingIQNILS), intent(in) :: this
        integer, value :: pointv
        muiCouplingIQNILS_getYDeltaDisp = muiCouplingIQNILS_getYDeltaDisp_c(this%ptr, pointv)
    end function muiCouplingIQNILS_getYDeltaDisp

    real function muiCouplingIQNILS_getZDeltaDisp(this, pointv)
        class(muiCouplingIQNILS), intent(in) :: this
        integer, value :: pointv
        muiCouplingIQNILS_getZDeltaDisp = muiCouplingIQNILS_getZDeltaDisp_c(this%ptr, pointv)
    end function muiCouplingIQNILS_getZDeltaDisp

    integer function muiCouplingIQNILS_pointSize(this)
        class(muiCouplingIQNILS), intent(in) :: this
        muiCouplingIQNILS_pointSize = muiCouplingIQNILS_pointSize_c(this%ptr)
    end function muiCouplingIQNILS_pointSize

    integer function muiCouplingIQNILS_residualMagSqSum(this)
        class(muiCouplingIQNILS), intent(in) :: this
        muiCouplingIQNILS_residualMagSqSum = muiCouplingIQNILS_residualMagSqSum_c(this%ptr)
    end function muiCouplingIQNILS_residualMagSqSum

    integer function muiCouplingIQNILS_residualL2NormMax(this)
        class(muiCouplingIQNILS), intent(in) :: this
        muiCouplingIQNILS_residualL2NormMax = muiCouplingIQNILS_residualL2NormMax_c(this%ptr)
    end function muiCouplingIQNILS_residualL2NormMax

    integer function muiCouplingIQNILS_residualL2Norm(this)
        class(muiCouplingIQNILS), intent(in) :: this
        muiCouplingIQNILS_residualL2Norm = muiCouplingIQNILS_residualL2Norm_c(this%ptr)
    end function muiCouplingIQNILS_residualL2Norm

    ! subroutine muiCouplingIQNILS_initialize(this, &
    ! pointSize, undRelxCplMax, aitkenIterationN, globalAlphaInput)
        ! class(muiCouplingIQNILS), intent(in) :: this
        ! integer(c_int), value :: pointSize
        ! real(c_double), value :: undRelxCplMax
        ! integer(c_int), value :: aitkenIterationN
        ! integer(c_bool), value :: globalAlphaInput
        ! call muiCouplingIQNILS_initialize_c(this%ptr, 4, &
    ! pointSize, undRelxCplMax, aitkenIterationN, globalAlphaInput)
    ! end subroutine muiCouplingIQNILS_initialize

    ! subroutine muiCouplingIQNILS_initialize(this, &
    ! pointSize, Fworld, undRelxCplMax, aitkenIterationN, globalAlphaInput)
        ! class(muiCouplingIQNILS), intent(in) :: this
        ! integer(c_int), value :: pointSize
        ! type(c_ptr), value :: Fworld
        ! real(c_double), value :: undRelxCplMax
        ! integer(c_int), value :: aitkenIterationN
        ! integer(c_bool), value :: globalAlphaInput
        ! call muiCouplingIQNILS_initialize_c(this%ptr, 5, &
    ! pointSize, Fworld, undRelxCplMax, aitkenIterationN, globalAlphaInput)
    ! end subroutine muiCouplingIQNILS_initialize

    subroutine muiCouplingIQNILS_initialize(this)
        class(muiCouplingIQNILS), intent(in) :: this
        call muiCouplingIQNILS_initialize_c(this%ptr, 0)
    end subroutine muiCouplingIQNILS_initialize

    subroutine muiCouplingIQNILS_collectResidual(   this,       &
                                                    fetchMUIx,  &
                                                    fetchMUIy,  &
                                                    fetchMUIz,  &
                                                    disPreX,    &
                                                    disPreY,    &
                                                    disPreZ,    &
                                                    pointv)

        class(muiCouplingIQNILS), intent(in) :: this
        real(c_double), intent(in), value :: fetchMUIx
        real(c_double), intent(in), value :: fetchMUIy
        real(c_double), intent(in), value :: fetchMUIz
        integer(c_int), value :: pointv
        real(c_double), intent(in), value :: disPreX
        real(c_double), intent(in), value :: disPreY
        real(c_double), intent(in), value :: disPreZ

        
        call muiCouplingIQNILS_collectResidual_c(   this%ptr,  &
                                                    fetchMUIx, &
                                                    fetchMUIy, &
                                                    fetchMUIz, &
                                                    disPreX,   &
                                                    disPreY,   &
                                                    disPreZ,   &
                                                    pointv)
    end subroutine muiCouplingIQNILS_collectResidual

    subroutine muiCouplingIQNILS_process(   this,   &
                                            iterN)
        class(muiCouplingIQNILS), intent(in) :: this
        integer(c_int), value :: iterN
        call muiCouplingIQNILS_process_c(   this%ptr, &
                                            iterN)
    end subroutine muiCouplingIQNILS_process

end module cs_mui_cu_iqnils
