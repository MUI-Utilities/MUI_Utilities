/*---------------------------------------------------------------------------*\
    MUI Utility - FSI Coupling Lab
    Copyright (C) 2021 Engineering and Environment Group, Scientific 
    Computing Department, Science and Technology Facilities Council, 
    UK Research and Innovation. All rights reserved.
    This code is licensed under the GNU General Public License version 3
    ** GNU General Public License, version 3 **
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

-------------------------------------------------------------------------------

Filename 
    iqnils.h

Created
    10 July 2019

Class
    muiCouplingIQNILS

Description
    C wrapper of Interface Quasi-Newton
    with Inverse Jacobian from Least Squares model (IQN-ILS) Coupling Method
    FSI Coupling utility for the MUI library

Author
    Wendi Liu

SourceFiles
    iqnils_CAPI.cpp

\*---------------------------------------------------------------------------*/
#ifndef MUICOUPLINGIQNILSCAPI_H
#define MUICOUPLINGIQNILSCAPI_H

#include "mui_3d.h"
#include <stdarg.h>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

/* namespace muiCoupling
{ */


/*---------------------------------------------------------------------------*\
                 Class muiCouplingIQNILS Declaration
\*---------------------------------------------------------------------------*/

//- Compiler judgment: C++ / C
#ifdef __cplusplus

extern "C" 
{

    //- With the C++ Compiler   
    class muiCouplingIQNILS;

    typedef muiCouplingIQNILS CAPI_muiCouplingIQNILS;

#else

    //- With the C Compiler, an opaque pointer is used
    typedef struct CAPI_muiCouplingIQNILS CAPI_muiCouplingIQNILS;

#endif // __cplusplus


// * * * * * * * * * * * * * Private Member Functions  * * * * * * * * * * * //

//                                   [ NONE ]                               //

// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

//- Constructor - default
CAPI_muiCouplingIQNILS* create_muiCouplingIQNILS(int Narg, ...);

// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

void delete_muiCouplingIQNILS
(
    CAPI_muiCouplingIQNILS* muiCouplingIQNILS
);


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

//- The const qualificators maps from the member function to pointers to the class instances.

    //- Return under relaxation factor of the coupling
    double muiCouplingIQNILS_undRelxCpl(CAPI_muiCouplingIQNILS* muiCouplingIQNILS);

    //- Return x axis component of the delta displacement
    double muiCouplingIQNILS_getXDeltaDisp(    CAPI_muiCouplingIQNILS* muiCouplingIQNILS,
                                                        int pointv);

    //- Return y axis component of the delta displacement
    double muiCouplingIQNILS_getYDeltaDisp(    CAPI_muiCouplingIQNILS* muiCouplingIQNILS,
                                                        int pointv);

    //- Return z axis component of the delta displacement
    double muiCouplingIQNILS_getZDeltaDisp(    CAPI_muiCouplingIQNILS* muiCouplingIQNILS,
                                                        int pointv);

    //- Return No. of points
    int muiCouplingIQNILS_pointSize(CAPI_muiCouplingIQNILS* muiCouplingIQNILS);

    //- Return square sum of the residual
    double muiCouplingIQNILS_residualMagSqSum(CAPI_muiCouplingIQNILS* muiCouplingIQNILS);

    //- Return maximum value of the residual L-2 Norm
    double muiCouplingIQNILS_residualL2NormMax(CAPI_muiCouplingIQNILS* muiCouplingIQNILS);

    //- Return the value of the residual L-2 Norm
    double muiCouplingIQNILS_residualL2Norm(CAPI_muiCouplingIQNILS* muiCouplingIQNILS);

    // Edit

    //- Initialize coupling method
    void muiCouplingIQNILS_initialize(CAPI_muiCouplingIQNILS* muiCouplingIQNILS,
                                      int Narg,
                                      ...);

    //- Collection of coupling process at this iteration
    void muiCouplingIQNILS_collectResidual( CAPI_muiCouplingIQNILS* muiCouplingIQNILS, 
                                            double fetchMUIx,
                                            double fetchMUIy,
                                            double fetchMUIz,
                                            double disPreX,
                                            double disPreY,
                                            double disPreZ,
                                            int pointv);
                            
    //- Collection of residual calculation at this iteration
    void muiCouplingIQNILS_process( CAPI_muiCouplingIQNILS* muiCouplingIQNILS,
                                    int iterN);


// * * * * * * * * * * * * * * * Global Functions  * * * * * * * * * * * * * //


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

//- Compiler judgment: C++ / C
#ifdef __cplusplus

} // extern "C"

#endif // __cplusplus

/* } */ // End namespace muiCoupling

#endif // End MUICOUPLINGIQNILSCAPI_H

// ************************************************************************* //