MUI Utility - Code_Saturne_MUI_Coupling

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

This folder contains the Code_Saturne MUI coupling method.

## Compile Code_Saturne (v6.0.6) with MUI (v1.1.2)
To compile Code_Saturne with MUI, the equivalent of the enclosed files (cs_config.py and cs_compile.py) need to be modified after the installation of Code_Saturne.

Please note that these files are written to the machine at installation time and will depend on how the machine is set up. The files found on the machine have to be modified and ** do not copy ** the files directly into the site-packages/code_saturne directory, otherwise Code_Saturne will not compile.

Both cs_config.py and cs_compile.py files can be found in the lib/python3.x/site-packages/code_saturne directory of the Code_Saturne installation on the machine.

In cs_compile.py replace the following commented lines with the uncommented lines.

```bash
#                cmd += ['-DLOCALEDIR=\\"' + pkg.get_dir('localedir') + '\\"', \
#                        '-DPKGDATADIR=\\"' + pkg.get_dir('pkgdatadir') + '\\"']
                cmd += ['-DLOCALEDIR=\"' + pkg.get_dir('localedir') + '\"', \
                        '-DPKGDATADIR=\"' + pkg.get_dir('pkgdatadir') + '\"', \
                        '-DPKGLIBDIR=\"\"']
```
In the cs_config.py, define the dependency add the 'MUI' and "MUICoupling" item after 'system'.

```bash
self.deplibs = [ .... 'system', 'mui', ''muicoupling'' ]
```

Add the flags and the links to the 'MUI' and "MUICoupling"  self libs for the correct flags for your installation of MUI and MUI_Utility.

```bash
        # Setup MUI

        self.libs['mui'] = \
            prerequisite("MUI",
                         have = "yes",
                         flags = {'cppflags': "-I/path/to/MUI -DHAVE_MUI",
                                  'ldflags': "-L/path/to/MUI/wrappers/C",
                                  'libs': "-lwrapperC -lstdc++"})

        # Setup muicoupling

        self.libs['muicoupling'] = \
            prerequisite("muicoupling",
                         have = "yes",
                         flags = {'cppflags': "-I/path/to/MUI_Utility/couplingFSILab/wrappers/C -I/path/to/MUI/couplingFSILab -I/path/to/MUI -DHAVE_MUI",
                                  'ldflags': "-L/path/to/MUI_Utility/couplingFSILab/wrappers/C -L/path/to/MUI/couplingFSILab -L/path/to/MUI/wrappers/C",
                                  'libs': "-lwrapperC -lmuiCouplingMethodsCAPI -lstdc++"})

```

This folder contains the demo cs_config.py and cs_compile.py files as an example.