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
    cfsil4py.cpp

Created
    11 May 2021

Description
    This is a part of the MUI Utility FSI Coupling Lab, python bind on iqnils 
	FSI coupling utility on MUI coupling library.

Author
    Wendi Liu

\*---------------------------------------------------------------------------*/

#include <pybind11/pybind11.h>
#include <mpi.h>
#include <mpi4py/mpi4py.h>
#include "../../../iqnils_inl.H"

namespace py = pybind11;

PYBIND11_MODULE(cfsil4py_mod, m) {
    // optional module docstring
    m.doc() = "python bind on iqnils FSI coupling utility on MUI coupling library";

    // define Global Functions

    // bindings to class
    py::class_<muiCoupling::muiCouplingIQNILS>(m, "muiCouplingIQNILS")
        .def(py::init<double>())
         .def(py::init(
			[](int pointSize, double initUndRelxCpl, double undRelxCplMax, int aitkenIterationN, bool globalAlphaInput)
			{return new muiCoupling::muiCouplingIQNILS(pointSize, initUndRelxCpl, undRelxCplMax, aitkenIterationN, globalAlphaInput);}))
         .def(py::init(
			[](int pointSize, double initUndRelxCpl, pybind11::handle const& pyHdl, double undRelxCplMax, int aitkenIterationN, bool globalAlphaInput){
			PyObject *py_src = pyHdl.ptr();
			MPI_Comm *comm_p = PyMPIComm_Get(py_src);
			auto ric_mpiComm = reinterpret_cast<MPI_Comm>(comm_p);			
			return new muiCoupling::muiCouplingIQNILS(pointSize, initUndRelxCpl, &ric_mpiComm, undRelxCplMax, aitkenIterationN, globalAlphaInput);}))
         .def(py::init(
			[](int pointSize, double initUndRelxCpl, std::vector<int> &localRankVec, int sizeAfterSplit, double undRelxCplMax, int aitkenIterationN, bool globalAlphaInput)
			{return new muiCoupling::muiCouplingIQNILS(pointSize, initUndRelxCpl, localRankVec, sizeAfterSplit, undRelxCplMax, aitkenIterationN, globalAlphaInput);}))
        .def("undRelxCpl", &muiCoupling::muiCouplingIQNILS::undRelxCpl)
        .def("pointSize", &muiCoupling::muiCouplingIQNILS::pointSize)
        .def("residualMagSqSum", &muiCoupling::muiCouplingIQNILS::residualMagSqSum)
        .def("residualL2NormMax", &muiCoupling::muiCouplingIQNILS::residualL2NormMax)
        .def("residualL2Norm", &muiCoupling::muiCouplingIQNILS::residualL2Norm)
        .def("getXDeltaDisp", &muiCoupling::muiCouplingIQNILS::getXDeltaDisp)
        .def("getYDeltaDisp", &muiCoupling::muiCouplingIQNILS::getYDeltaDisp)
        .def("getZDeltaDisp", &muiCoupling::muiCouplingIQNILS::getZDeltaDisp)
        .def("initialize", [](muiCoupling::muiCouplingIQNILS &initialize_obj){return initialize_obj.initialize();})
        .def("initialize",
			[](muiCoupling::muiCouplingIQNILS &initialize_obj, int pointSize, double undRelxCplMax, int aitkenIterationN, bool globalAlphaInput)
			{ return initialize_obj.initialize(pointSize, undRelxCplMax, aitkenIterationN, globalAlphaInput);})
        .def("initialize",
			[](muiCoupling::muiCouplingIQNILS &initialize_obj, int pointSize, py::handle pyHdl, double undRelxCplMax, int aitkenIterationN, bool globalAlphaInput){
			PyObject *py_src = pyHdl.ptr();
			MPI_Comm *comm_p = PyMPIComm_Get(py_src);
			auto ric_mpiComm = reinterpret_cast<MPI_Comm>(comm_p);		
			return initialize_obj.initialize(pointSize, &ric_mpiComm, undRelxCplMax, aitkenIterationN, globalAlphaInput);})
		.def("collectResidual", &muiCoupling::muiCouplingIQNILS::collectResidual)
		.def("process", &muiCoupling::muiCouplingIQNILS::process);
}