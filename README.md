Coupling non-conforming discretizations of PDEs by spectral approximation of the Lagrange multiplier space
-------------------------
<<<<<<< HEAD
The MATLAB code in this repository is complementary to the paper *Coupling non-conforming discretizations of PDEs by spectral approximation of the Lagrange multiplier space* (Deparis, S., Iubatti, A. and Pegolotti, L., 2018). It was used to generate the figures in the *Numerical results* section. Most of the functionalities we use are implemented in *feamat* (https://github.com/lucapegolotti/feamat), which is a set of MATLAB routines for the solution of Finite Element problems on structured meshes, and in GeoPDEs (http://rafavzqz.github.io/geopdes/), which is a package for the solution of PDEs using isogeometric analysis. The *feamat* repository is hereby included as submodule; for the installation of GeoPDEs, we refer to the section *Installation of GeoPDEs*
=======
The MATLAB code in this repository is complementary to the paper *Coupling non-conforming discretizations of PDEs by spectral approximation of the Lagrange multiplier space* (Deparis, S. and Pegolotti, L., 2018). It was used to generate the figures in the *Numerical results* section. Most of the functionalities we use are implemented in *feamat* (https://github.com/lucapegolotti/feamat), which is a set of MATLAB routines for the solution of Finite Element problems on structured meshes. Note that the code is not particularly optimized, and therefore *feamat* should be used only for prototyping purposes. The *feamat* repository is hereby included as submodule.
>>>>>>> 9a7c186a025f77aba575e3b8f67225f40cffb173

Tested version of MATLAB: 2017b. Previous versions might not work properly.

How to clone
-------------------------
Run
```
 git clone --recurse-submodules https://github.com/lucapegolotti/coupling_scripts.git
```
to recursively clone the directory and *feamat*.

<<<<<<< HEAD
Installation of GeoPDEs
-------------------------
GeoPDEs can be downloaded from the following link: http://rafavzqz.github.io/geopdes/download/. After downloading, decompress the compressed package to a location of your choice and edit the 'geopdes_location' string in the run_addpaths.m script.

How to use
-------------------------
The functions of *feamat* must be beforehand included by running the run_addpaths.m script in the root of the project; notice that the directories for *GeoPDEs* must be set as well by the user (see *Installation of GeoPDEs* section). The repository is structured in multiple folders, each containing the scripts for generating every figure in the paper. In each figure* folder, a run_all.m scrips executes all the scripts that are necessary to generate the data to be plotted.

License
-------------------------
For the licensing, we refer to the LICENSE FILE

Note about the version
-------------------------
This repository stores the code for multiple versions of the paper. To refer to a particular version, please switch to the corresponding branch. The master corresponding to the latest version of the code.

Previous versions:
- version referred to on arXiv (https://arxiv.org/abs/1802.07601): version_arXiv branch
=======
How to use
-------------------------
The functions of *feamat* must be beforehand included by running the run_addpaths.m script in the root of the project. The repository is structured in multiple folders, each containing the scripts for generating every figure in the paper. In each figure* folder, a run_all.m scrips executes all the scripts that are necessary to generate the data to be plotted.
>>>>>>> 9a7c186a025f77aba575e3b8f67225f40cffb173
