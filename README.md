# faraday-nek
# Building Nek5000
Ideally you should try running on Delta. I can help if you are on Linux or WSL2 in Windows. For Mac,
depending on the CPU architecture, it could be pretty difficult, but you can try following along.
Refer to [doc](https://nek5000.github.io/NekDoc/quickstart.html) for more details.

We are using a fork by Nadish Saini at Argonne, which contains the plugins for two-phase flow.
```bash
git clone -b nekLS https://github.com/nandu90/Nek5000.git
```
To build Nek5000, you need `gcc`, `gfortran`, `openmpi`. How to get them depends on your platform.
For Ubuntu, you can do 
```bash
 sudo apt-get update
 sudo apt install build-essential  #provides gcc
 sudo apt install gfortran         #provides gfortran
 sudo apt install libopenmpi-dev   #provides openmpi
```
Specify the path to your Nek5000 directory
```bash
export NEK_SOURCE_ROOT="/home/nekoconn/code/seal/Nek5000" # Change to your path
export PATH=$NEK_SOURCE_ROOT/bin:$PATH
```
Build `genbox` and `genmap`, which are needed to generate the mesh
```bash
cd Nek5000/tools
./maketools genbox
./maketools genmap
```

# Generate the mesh
In `fara.box` file, you can modify the domain size (dimensional, i.e. in meters)
and the number of elements in each direction.
```bash
genbox                #enter fara.box
mv box.re2 fara.re2
genmap                #enter fara
```
`genbox` generate the mesh from the input file `fara.box`, and the mesh
is written to `box.re2`

`genmap` partition the mesh, read from `.re2` file and generate a `.ma2` file.

# Changing the case
In `fara.usr` you will find comments on important sections where you can change 
all the fluid properties, forcing functions, etc.

In `fara.par`, you can change dt, how often to write checkpoints, etc.

Everything is ran nondimensionally. This means the mesh is scaled so that the height of 
the bottom layer is 1. This scaling is done in `usrdat2`. The excitation amplitude and frequency 
is specified in `usrdat3`. All the nondimensionalization is done in `uservp`. In `userf` you can find
the excitation function feed into the acceleration term. In `useric`, we specified an initial condition
of very small initial `cos` wave plus a linear perturbation to eliminate the symmetry. You can 
increase the initial amplitude of the wave to avoid having to wait long just for the wave to build up.


# Building the case
`SIZE` file specify how the case is built. `lx1` is the polynomial order, 
`lelg` is the total element in the case, `lpmin` is the minimum number of rank
that the case will be ran with.

```bash
PPLIST="HYPRE" makenek   #build the case
```

# Run
Change `8` to the number of ranks you have. This should be less than the total number of cores that your CPU has.
```bash
nekbmpi fara 8
```
Running will generate `logfile`, `fara.nek5000`, and a bunch of `fara0.f*****` which contain
the checkpoints.

# Visualization
You can open the `fara.nek5000` file with visit or paraview. If use paraview, use `VisIt Nek5000 Reader` as the reader.
Note the `fara.nek5000` file doesn't actually contains any data, it only points to the `fara0.f*****` checkpoint files.
