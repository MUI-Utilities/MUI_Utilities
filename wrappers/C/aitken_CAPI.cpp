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
    aitken_CAPI.cpp

Created
    05 July 2019

Class
    muiCouplingAitken

Description
    C wrapper of Aitken Coupling Method
    FSI Coupling utility for the MUI library

Author
    Wendi Liu

\*---------------------------------------------------------------------------*/

#include "aitken.h"
#include "aitken_inl.H"
#include "mui_3d.h"
#include <iostream>
#include <stdarg.h>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
extern "C" {
    
namespace muiCoupling
{

using namespace std;


// * * * * * * * * * * * * * Private Member Functions  * * * * * * * * * * * //
typedef muiCouplingAitken CAPI_muiCouplingAitken;

// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

//- Constructor - default
CAPI_muiCouplingAitken* create_muiCouplingAitken(int Narg, ...)
{
    switch(Narg)
    {
        case 1:
        {
            va_list ap;
            va_start(ap, Narg);
            
            double initUndRelxCpl;
            
            for(int counter = 0; counter < Narg; ++counter)
            {
                initUndRelxCpl = va_arg(ap, double); 
            }
            
            std::cout << "C API, create_muiCouplingAitken" << std::endl;
            return new CAPI_muiCouplingAitken(initUndRelxCpl); 
            
            break;
        }
        
        case 2:
        {
            va_list ap;
            va_start(ap, Narg);

            int pointSize;
            double initUndRelxCpl;

            for(int counter = 0; counter < Narg; ++counter)
            {
                if(counter == 0)
                {
                    pointSize = va_arg(ap, int);
                } else if (counter == 1)
                {
                    initUndRelxCpl = va_arg(ap, double);
                }
            }
            
            std::cout << "C API, create_muiCouplingAitken" << std::endl;
            return new CAPI_muiCouplingAitken(pointSize, initUndRelxCpl);
            
            break;
        }

        case 3:
        {
            va_list ap;
            va_start(ap, Narg);

            int pointSize;
            double initUndRelxCpl;
            MPI_Comm *Cworld;

            for(int counter = 0; counter < Narg; ++counter)
            {
                if(counter == 0)
                {
                    pointSize = va_arg(ap, int);
                } else if (counter == 1)
                {
                    initUndRelxCpl = va_arg(ap, double);
                    if (initUndRelxCpl <= 1e-5)
                    {
                        initUndRelxCpl=0.8;
                    }
                } else if (counter == 2)
                {
                    Cworld = va_arg(ap, MPI_Comm*);
                }
            }

            std::cout << "C API, create_muiCouplingAitken" << std::endl;
            return new CAPI_muiCouplingAitken(pointSize, initUndRelxCpl, Cworld);
            
            break;
        }

        default:
        {
            printf("Invalid number of arguments for 'create_muiCouplingAitken()' function'\n");
            printf("Please provide 1, 2 or 3 argument numbers'\n");
            exit(1);
        }
    }

}

// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

void delete_muiCouplingAitken(CAPI_muiCouplingAitken* muiCouplingAitken){
    std::cout << "C API, delete_muiCouplingAitken" << std::endl;
    delete muiCouplingAitken;
}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

double muiCouplingAitken_undRelxCpl(CAPI_muiCouplingAitken* muiCouplingAitken)
{

    return muiCouplingAitken->undRelxCpl();
 
}

double muiCouplingAitken_getXDeltaDisp( CAPI_muiCouplingAitken* muiCouplingAitken,
                                        int pointv)
{

    return muiCouplingAitken->getXDeltaDisp(pointv);
                                                  
}

double muiCouplingAitken_getYDeltaDisp( CAPI_muiCouplingAitken* muiCouplingAitken,
                                        int pointv)
{

    return muiCouplingAitken->getYDeltaDisp(pointv);
                                                  
}

double muiCouplingAitken_getZDeltaDisp( CAPI_muiCouplingAitken* muiCouplingAitken,
                                        int pointv)
{

    return muiCouplingAitken->getZDeltaDisp(pointv);
                                                  
}

int muiCouplingAitken_pointSize(CAPI_muiCouplingAitken* muiCouplingAitken)
{
 
    return muiCouplingAitken->pointSize();
 
}

//- Return square sum of the residual
double muiCouplingAitken_residualMagSqSum(CAPI_muiCouplingAitken* muiCouplingAitken)
{

    return muiCouplingAitken->residualMagSqSum();

}

//- Return maximum value of the residual L-2 Norm
double muiCouplingAitken_residualL2NormMax(CAPI_muiCouplingAitken* muiCouplingAitken)
{

    return muiCouplingAitken->residualL2NormMax();

}

//- Return the value of the residual L-2 Norm
double muiCouplingAitken_residualL2Norm(CAPI_muiCouplingAitken* muiCouplingAitken)
{

    return muiCouplingAitken->residualL2Norm();    

}

//- Initialize coupling method
void muiCouplingAitken_initialize(CAPI_muiCouplingAitken* muiCouplingAitken,
                                  int Narg,
                                  ...)
{
    switch(Narg)
    {
        case 0:
        {

            muiCouplingAitken->initialize();

            break;
        }

        case 1:
        {
            va_list ap;
            va_start(ap, Narg);

            int pointSize;

            for(int counter = 0; counter < Narg; ++counter)
            {
                pointSize = va_arg(ap, int);
            }

            muiCouplingAitken->initialize(pointSize);
            
            break;
        }

        case 2:
        {
            va_list ap;
            va_start(ap, Narg);

            int pointSize;
            MPI_Comm *Cworld;

            for(int counter = 0; counter < Narg; ++counter)
            {
                if(counter == 0)
                {
                    pointSize = va_arg(ap, int);
                }else if (counter == 1)
                {
                    Cworld = va_arg(ap, MPI_Comm*);
                }
            }

            muiCouplingAitken->initialize(pointSize, Cworld);

            break;
        }

        default:
        {
            printf("Invalid number of arguments for 'muiCouplingAitken_initialize()' function'\n");
            printf("Please provide 0, 1 or 2 argument numbers'\n");
            exit(1);
        }
    }
}

void muiCouplingAitken_collectResidual( CAPI_muiCouplingAitken* muiCouplingAitken,
                                        double fetchMUIx,
                                        double fetchMUIy,
                                        double fetchMUIz,
                                        double disPreX,
                                        double disPreY,
                                        double disPreZ,
                                        int pointv)
{

     muiCouplingAitken->collectResidual(        fetchMUIx,
                                                fetchMUIy,
                                                fetchMUIz,
                                                disPreX,
                                                disPreY,
                                                disPreZ,
                                                pointv);
 
}

void muiCouplingAitken_process( CAPI_muiCouplingAitken* muiCouplingAitken,
                                int iterN,
                                int curIterN)
{

    muiCouplingAitken->process(iterN,curIterN);

}

// * * * * * * * * * * * * * * * Global Functions  * * * * * * * * * * * * * //


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace muiCoupling

}
// ************************************************************************* //