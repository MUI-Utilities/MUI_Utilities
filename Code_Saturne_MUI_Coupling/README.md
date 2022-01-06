MUI Utility - Code_Saturne_MUI_Coupling

Copyright (C) 2021 Computational Engineering and Environment Group, Scientific 
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
This folder contains the instructions to adapt Code_Saturne to handle the MUI Coupling.

## Compile Code_Saturne (V6.0.6) with MUI (V1.1.3)

To get Code_Saturne working with MUI, it is **CRUCIAL** to install Code_Saturne first, and modify files in the installed version.

The 2 files are to be found under **your_own_path/lib/python3.x/site-packages/code_saturne/** directory, where 3.x is the
version of Python you have used to install Code_Saturne.

The 2 files are *cs_compile.py* and *cs_config.py*.

In *cs_compile.py*, the following commented lines are replaced by the uncommented lines to account for -DPKGLIBDIR. It happens
at **Line 375 (L375)** for this version of Code_Saturne.


```bash
#                cmd += ['-DLOCALEDIR=\\"' + pkg.get_dir('localedir') + '\\"', \
#                        '-DPKGDATADIR=\\"' + pkg.get_dir('pkgdatadir') + '\\"']
                cmd += ['-DLOCALEDIR=\"' + pkg.get_dir('localedir') + '\"', \
                        '-DPKGDATADIR=\"' + pkg.get_dir('pkgdatadir') + '\"', \
                        '-DPKGLIBDIR=\"\"']
```
In *cs_config.py*, 2 operations are required. First, 'mui' and 'muicoupling are added to the list of dependencies after 'system',
after **Line 98 (L98)**.

```bash
self.deplibs = [ ....,
                 ....,
                 'mui',                          # MUI
                 'muicoupling',                  # MUICoupling
                 'system']                       # User & system libraries
```

Some information has to be added to *cs_config.py*. It is done by adding some *self.libs* for 'MUI' and "MUICoupling", after the settings for scotch, and reads as follows, starting from **Line 318 (L318)** (this is accounting for the 2 extra lines added in *self.deplibs*. **path_to_MUI** and **path_to_MUI_Utility** depend on your own installation and need to be adapted

```bash
        self.libs['mui'] = \
            prerequisite("MUI",
                         have = "yes",
                         flags = {'cppflags': "-I/path_to_MUI -DHAVE_MUI",
                                  'ldflags': "-L/path_to_MUI/wrappers/C",
                                  'libs': "-lwrapperC -lstdc++"})

        self.libs['muicoupling'] = \
            prerequisite("muicoupling",
                         have = "yes",
                         flags = {'cppflags': "-I/path_to_MUI_Utility/couplingFSILab/wrappers/C -I/path_to_MUI/couplingFSILab -I/path_to_MUI -DHAVE_MUI",
                                  'ldflags': "-L/path_to_MUI_Utility/couplingFSILab/wrappers/C -L/path_to_MUI/couplingFSILab -L/path_to_MUI/wrappers/C",
                                  'libs': "-lwrapperC -lmuiCouplingMethodsCAPI -lstdc++"})
```

An example of how this 2 files are changed is to be found in [https://github.com/MUI-Utilities/MUI_Utilities/blob/main/Code_Saturne_MUI_Coupling/cs_compile_py_example](cs_compile_py_example) and [https://github.com/MUI-Utilities/MUI_Utilities/blob/main/Code_Saturne_MUI_Coupling/cs_config_py_example](cs_config_py_example). Note that these files are shown as examples and need to be tailored for your own installation of Code_Saturne.
