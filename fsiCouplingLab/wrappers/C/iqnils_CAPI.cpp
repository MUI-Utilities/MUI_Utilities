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
    iqnils_CAPI.cpp

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

\*---------------------------------------------------------------------------*/

#include "iqnils.h"
#include "iqnils_inl.H"
#include "mui_c_wrapper_3d.h"
#include <iostream>
#include <stdarg.h>

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
extern "C" {
    
namespace muiCoupling
{

using namespace std;


// * * * * * * * * * * * * * Private Member Functions  * * * * * * * * * * * //
typedef muiCouplingIQNILS CAPI_muiCouplingIQNILS;

// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

CAPI_muiCouplingIQNILS* create_muiCouplingIQNILS(int Narg, ...)
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
            
            std::cout << "C API, create_muiCouplingIQNILS" << std::endl;
            return new CAPI_muiCouplingIQNILS(initUndRelxCpl);
            
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
                } else if (counter == 2)
                {
                    Cworld = va_arg(ap, MPI_Comm*);
                } 
            }

            std::cout << "C API, create_muiCouplingIQNILS" << std::endl;
            return new CAPI_muiCouplingIQNILS(pointSize, initUndRelxCpl,Cworld);

            break;
        }

        case 5:
        {
            va_list ap;
            va_start(ap, Narg);

            int pointSize;
            double initUndRelxCpl;
            double undRelxCplMax;
            int aitkenIterationN;
            bool globalAlphaInput;

            for(int counter = 0; counter < Narg; ++counter)
            {
                if(counter == 0)
                {
                    pointSize = va_arg(ap, int);
                } else if (counter == 1)
                {
                    initUndRelxCpl = va_arg(ap, double);
                } else if (counter == 2)
                {
                    undRelxCplMax = va_arg(ap, double);
                } else if (counter == 3)
                {
                    aitkenIterationN = va_arg(ap, int);
                } else if (counter == 4)
                {
                    globalAlphaInput = va_arg(ap, bool);
                }
            }

            std::cout << "C API, create_muiCouplingIQNILS" << std::endl;
            return new CAPI_muiCouplingIQNILS(pointSize, initUndRelxCpl, 
                undRelxCplMax, aitkenIterationN, globalAlphaInput);

            break;
        }

        case 6:
        {
            va_list ap;
            va_start(ap, Narg);

            int pointSize;
            double initUndRelxCpl;
            MPI_Comm *Cworld;
            double undRelxCplMax;
            int aitkenIterationN;
            bool globalAlphaInput;

            for(int counter = 0; counter < Narg; ++counter)
            {
                if(counter == 0)
                {
                    pointSize = va_arg(ap, int);
                } else if (counter == 1)
                {
                    initUndRelxCpl = va_arg(ap, double);
                } else if (counter == 2)
                {
                    Cworld = va_arg(ap, MPI_Comm*);
                } else if (counter == 3)
                {
                    undRelxCplMax = va_arg(ap, double);
                } else if (counter == 4)
                {
                    aitkenIterationN = va_arg(ap, int);
                } else if (counter == 5)
                {
                    globalAlphaInput = va_arg(ap, bool);
                }
            }

            std::cout << "C API, create_muiCouplingIQNILS" << std::endl;
            return new CAPI_muiCouplingIQNILS(pointSize, initUndRelxCpl, 
                Cworld, undRelxCplMax, aitkenIterationN, globalAlphaInput);

            break;
        }

        default:
        {
            printf("Invalid number of arguments for 'create_muiCouplingIQNILS()' function'\n");
            printf("Please provide 1, 3, 5 or 6 argument numbers'\n");
            exit(1);
        }
    }
}

// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

void delete_muiCouplingIQNILS(CAPI_muiCouplingIQNILS* muiCouplingIQNILS){
    std::cout << "C API, delete_muiCouplingIQNILS" << std::endl;
    delete muiCouplingIQNILS;
}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

double muiCouplingIQNILS_undRelxCpl(CAPI_muiCouplingIQNILS* muiCouplingIQNILS)
{

    return muiCouplingIQNILS->undRelxCpl();
 
}

double muiCouplingIQNILS_getXDeltaDisp( CAPI_muiCouplingIQNILS* muiCouplingIQNILS,
                                        int pointv)
{

    return muiCouplingIQNILS->getXDeltaDisp(pointv);
                                                  
}

double muiCouplingIQNILS_getYDeltaDisp( CAPI_muiCouplingIQNILS* muiCouplingIQNILS,
                                        int pointv)
{

    return muiCouplingIQNILS->getYDeltaDisp(pointv);
                                                  
}

double muiCouplingIQNILS_getZDeltaDisp( CAPI_muiCouplingIQNILS* muiCouplingIQNILS,
                                        int pointv)
{

    return muiCouplingIQNILS->getZDeltaDisp(pointv);
                                                  
}

int muiCouplingIQNILS_pointSize(CAPI_muiCouplingIQNILS* muiCouplingIQNILS)
{
 
    return muiCouplingIQNILS->pointSize();
 
}

//- Return square sum of the residual
double muiCouplingIQNILS_residualMagSqSum(CAPI_muiCouplingIQNILS* muiCouplingIQNILS)
{

    return muiCouplingIQNILS->residualMagSqSum();

}
//- Return maximum value of the residual L-2 Norm
double muiCouplingIQNILS_residualL2NormMax(CAPI_muiCouplingIQNILS* muiCouplingIQNILS)
{

    return muiCouplingIQNILS->residualL2NormMax();

}

//- Return the value of the residual L-2 Norm
double muiCouplingIQNILS_residualL2Norm(CAPI_muiCouplingIQNILS* muiCouplingIQNILS)
{

    return muiCouplingIQNILS->residualL2Norm();

}

void muiCouplingIQNILS_initialize(CAPI_muiCouplingIQNILS* muiCouplingIQNILS,
                                  int Narg,
                                  ...)
{
    switch(Narg)
    {
        case 0:
        {

            muiCouplingIQNILS->initialize();

            break;
        }

        case 3:
        {
            va_list ap;
            va_start(ap, Narg);

            int pointSize;
            double undRelxCplMax;
            int aitkenIterationN;

            for(int counter = 0; counter < Narg; ++counter)
            {
                if(counter == 0)
                {
                    pointSize = va_arg(ap, int);
                } else if (counter == 1)
                {
                    undRelxCplMax = va_arg(ap, double);
                } else if (counter == 2)
                {
                    aitkenIterationN = va_arg(ap, int);
                }          
            }
            bool globalAlphaInput=false;
            muiCouplingIQNILS->initialize(pointSize, 
                                          undRelxCplMax, 
                                          aitkenIterationN, 
                                          globalAlphaInput);

            break;
        }

        case 4:
        {
            va_list ap;
            va_start(ap, Narg);

            int pointSize;
            double undRelxCplMax;
            int aitkenIterationN;
            bool globalAlphaInput;

            for(int counter = 0; counter < Narg; ++counter)
            {
                if(counter == 0)
                {
                    pointSize = va_arg(ap, int);
                } else if (counter == 1)
                {
                    undRelxCplMax = va_arg(ap, double);
                } else if (counter == 2)
                {
                    aitkenIterationN = va_arg(ap, int);
                } else if (counter == 3)
                {
                    globalAlphaInput = va_arg(ap, bool);
                }           
            }

            muiCouplingIQNILS->initialize(pointSize, 
                                          undRelxCplMax, 
                                          aitkenIterationN, 
                                          globalAlphaInput);

            break;
        }

        case 5:
        {
            va_list ap;
            va_start(ap, Narg);

            int pointSize;
            MPI_Comm *Cworld;
            double undRelxCplMax;
            int aitkenIterationN;
            bool globalAlphaInput;

            for(int counter = 0; counter < Narg; ++counter)
            {
                if(counter == 0)
                {
                    pointSize = va_arg(ap, int);
                } else if (counter == 1)
                {
                    Cworld = va_arg(ap, MPI_Comm*);
                } else if (counter == 2)
                {
                    undRelxCplMax = va_arg(ap, double);
                }  else if (counter == 3)
                {
                    aitkenIterationN = va_arg(ap, int);
                } else if (counter == 4)
                {
                    globalAlphaInput = va_arg(ap, bool);
                }
            }

            muiCouplingIQNILS->initialize(pointSize, 
                                          Cworld, 
                                          undRelxCplMax, 
                                          aitkenIterationN, 
                                          globalAlphaInput);

            break;
        }

        default:
        {
            printf("Invalid number of arguments for 'muiCouplingIQNILS_initialize()' function'\n");
            printf("Please provide 0, 4 or 5 argument numbers'\n");
            exit(1);
        }
    }
}

void muiCouplingIQNILS_collectResidual( CAPI_muiCouplingIQNILS* muiCouplingIQNILS,
                                        double fetchMUIx,
                                        double fetchMUIy,
                                        double fetchMUIz,
                                        double disPreX,
                                        double disPreY,
                                        double disPreZ,
                                        int pointv)
{

     muiCouplingIQNILS->collectResidual(        fetchMUIx,
                                                fetchMUIy,
                                                fetchMUIz,
                                                disPreX,
                                                disPreY,
                                                disPreZ,
                                                pointv);
 
}

void muiCouplingIQNILS_process( CAPI_muiCouplingIQNILS* muiCouplingIQNILS,
                                int pointv)
{

    muiCouplingIQNILS->process(pointv);

}

// * * * * * * * * * * * * * * * Global Functions  * * * * * * * * * * * * * //


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace muiCoupling

}
// ************************************************************************* //
