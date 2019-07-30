#!/bin/bash
#----------------------------------------------------------------
#
# platforms.sh: This file contains functions required for initializing
# variables that are architecture (platform) dependent. 
# It is sourced by asgs_main.sh and any other shell script that 
# is platform dependent. 
#
#----------------------------------------------------------------
# Copyright(C) 2012--2018 Jason Fleming
#
# This file is part of the ADCIRC Surge Guidance System (ASGS).
#
# The ASGS is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# ASGS is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with the ASGS.  If not, see <http://www.gnu.org/licenses/>.
#----------------------------------------------------------------
#
# initialization subroutines for the various machines/architectures
#
# Suggested aliases to support the Operator's tasks. Add these
# to .bashrc, .bash_profile or similar
#
# alias lsta='ls -lth *.state | head'
#
init_supermike()
{ #<- can replace the following with a custom script
  HPCENV=mike.hpc.lsu.edu
  QUEUESYS=PBS
  QCHECKCMD=qstat
  QUEUENAME=workq
  SERQUEUE=single
  #ACCOUNT=pleaseSetAccountParamToLONIAllocationInASGSConfig
  SUBMITSTRING=qsub
  JOBLAUNCHER='mpirun -np %ncpu% -machinefile \$PBS_NODEFILE'
  SCRATCHDIR=/work/$USER
  #SCRATCHDIR=/work/cera
  SSHKEY=~/.ssh/id_rsa.pub
  QSCRIPT=supermike.template.pbs
  PREPCONTROLSCRIPT=supermike.adcprep.template.pbs
  QSCRIPTGEN=tezpur.pbs.pl
  PPN=16
}
init_queenbee()
{ #<- can replace the following with a custom script
  HPCENV=queenbee.loni.org
  QUEUESYS=PBS
  QCHECKCMD=qstat
  QSUMMARYCMD=showq
  QUOTACHECKCMD=showquota
  ALLOCCHECKCMD=showquota
  QUEUENAME=workq
  SERQUEUE=single
  ACCOUNT=pleaseSetAccountParamToLONIAllocationInASGSConfig
  SUBMITSTRING=qsub
  JOBLAUNCHER='mpirun -np %ncpu% -machinefile \$PBS_NODEFILE'
  if [[ -d /work/$USER ]]; then
     SCRATCHDIR=/work/$USER
  else
     SCRATCHDIR=/ssdwork/$USER
  fi
  #SCRATCHDIR=/work/cera
  SSHKEY=~/.ssh/id_rsa.pub
  QSCRIPT=queenbee.template.pbs
  PREPCONTROLSCRIPT=queenbee.adcprep.template.pbs
  QSCRIPTGEN=tezpur.pbs.pl
  PPN=20
  REMOVALCMD="rmpurge"
  PLATFORMMODULES='module load intel netcdf netcdf_fortran gcc'
  $PLATFORMMODULES
  # modules for CPRA post processing
  module load matlab/r2015b
  module load python/2.7.12-anaconda-tensorflow
  # needed for asgs perl
  source ~/perl5/perlbrew/etc/bashrc
}

init_rostam()
{ #<- can replace the following with a custom script
  HPCENV=rostam.cct.lsu.edu
  QUEUESYS=SLURM
  QCHECKCMD=squeue
  QSUMMARYCMD=squeue
  QUOTACHECKCMD=null
  ALLOCCHECKCMD=null
  QUEUENAME=rostam
  SERQUEUE=rostam
  ACCOUNT=null
  SUBMITSTRING=sbatch
  #JOBLAUNCHER='srun -N %nnodes%'
  JOBLAUNCHER='salloc -p marvin -N %nnodes% -n %ncpu%' 
  SCRATCHDIR=~/asgs
  SSHKEY=~/.ssh/id_rsa.pub
  QSCRIPT=rostam.template.slurm
  PREPCONTROLSCRIPT=rostam.adcprep.template.slurm
  QSCRIPTGEN=hatteras.slurm.pl
  PPN=16
  PARTITION=marvin
  CONSTRAINT=null
  RESERVATION=null
  REMOVALCMD="rm"
  PLATFORMMODULES='module load mpi/mpich-3.0-x86_64'
  $PLATFORMMODULES
  # modules for CPRA post processing
  #module load mpi/mpich-3.0-x86_64
  module purge 
  module load impi/2017.3.196 
}
init_supermic()
{ #<- can replace the following with a custom script
  HPCENV=supermic.hpc.lsu.edu
  QUEUESYS=PBS
  QCHECKCMD=qstat
  QSUMMARYCMD=showq
  QUOTACHECKCMD=showquota
  ALLOCCHECKCMD=showquota
  QUEUENAME=workq
  SERQUEUE=single
  ACCOUNT=pleaseSetAccountParamToLONIAllocationInASGSConfig
  SUBMITSTRING=qsub
  JOBLAUNCHER='mpirun -np %ncpu% -machinefile \$PBS_NODEFILE'
  if [[ -d /work/$USER ]]; then
     SCRATCHDIR=/work/$USER
  else
     SCRATCHDIR=/ssdwork/$USER
  fi
  SSHKEY=~/.ssh/id_rsa.pub
  QSCRIPT=supermic.template.pbs
  PREPCONTROLSCRIPT=supermic.adcprep.template.pbs
  QSCRIPTGEN=tezpur.pbs.pl
  PPN=20
  REMOVALCMD="rmpurge"
  PLATFORMMODULES='module load intel/14.0.2 netcdf/4.2.1.1/INTEL-140-MVAPICH2-2.0 netcdf_fortran/4.2/INTEL-140-MVAPICH2-2.0 perl/5.16.3/INTEL-14.0.2'
  $PLATFORMMODULES
  # modules for CPRA post processing
  #module load matlab/r2015b
  module load python/2.7.13-anaconda-tensorflow
}
init_arete()
{ #<- can replace the following with a custom script
  HPCENV=arete.cct.lsu.edu
  QUEUESYS=SLURM
  QCHECKCMD=sacct
  ACCOUNT=null
  SUBMITSTRING=sbatch
  JOBLAUNCHER=
  SCRATCHDIR=/scratch/$USER
  SSHKEY=~/.ssh/id_rsa.pub
  QSCRIPT=arete.template.slurm
  PREPCONTROLSCRIPT=arete.adcprep.template.slurm
  QSCRIPTGEN=hatteras.slurm.pl
  PPN=8
}
init_camellia()
{ #<- can replace the following with a custom script
  HPCENV=camellia.worldwindsinc.com
  QUEUESYS=PBS
  QCHECKCMD=qstat
  ACCOUNT=bpj
  SUBMITSTRING=qsub
  SCRATCHDIR=$HOME/tmp
  SSHKEY=~/.ssh/id_rsa.pub
  QSCRIPT=ww.template.pbs
  PREPCONTROLSCRIPT=ww.adcprep.template.pbs
  QSCRIPTGEN=tezpur.pbs.pl
  PPN=12
}
init_blueridge()
{ #<- can replace the following with a custom script
  HPCENV=blueridge.renci.org
  QUEUESYS=PBS
  QCHECKCMD=qstat
  ACCOUNT=noaccount
  SUBMITSTRING=submitstring
  SCRATCHDIR=/projects/ncfs/data
  SSHKEY=~/.ssh/id_rsa.pub
  QSCRIPT=renci.template.pbs
  PREPCONTROLSCRIPT=renci.adcprep.template.pbs
  QSCRIPTGEN=tezpur.pbs.pl
  PPN=8
}
init_croatan()
{ #<- can replace the following with a custom script
  HPCENV=croatan.renci.org
  QUEUESYS=PBS
  QCHECKCMD=qstat
  ACCOUNT=noaccount
  SUBMITSTRING=submitstring
  SCRATCHDIR=/projects/ncfs/data
  SSHKEY=~/.ssh/id_rsa.pub
  QSCRIPT=croatan.template.pbs
  PREPCONTROLSCRIPT=croatan.adcprep.template.pbs
  QSCRIPTGEN=tezpur.pbs.pl
  PPN=16
}
init_pod()
{ #<- can replace the following with a custom script
  HPCENV=pod.penguincomputing.com
  QUEUESYS=PBS
  QCHECKCMD=qstat
  ACCOUNT=noaccount
  SUBMITSTRING=submitstring
  SCRATCHDIR=/home/bblanton/asgs_scratch
  SSHKEY=~/.ssh/id_rsa.pub
  QSCRIPT=penguin.template.pbs
  PREPCONTROLSCRIPT=penguin.adcprep.template.pbs
  RESERVATION=null
  QSCRIPTGEN=tezpur.pbs.pl
  SERQUEUE=B30     # aka the partition in SLURM parlance 
  QUEUE=B30     # aka the partition in SLURM parlance 
  PPN=28
#  QUEUE=S30     # aka the partition in SLURM parlance 
#  PPN=40
}
init_hatteras()
{ #<- can replace the following with a custom script
  HPCENV=hatteras.renci.org
  QUEUESYS=SLURM
  QCHECKCMD=sacct
  #ACCOUNT=bblanton # Brian you can override these values in your asgs config file for each instance (or even make these values different for different ensemble members)
  #SCRATCHDIR=/scratch/bblanton/data
  #PARTITION=batch       # ncfs or batch
  #CONSTRAINT=hatteras # ivybridge or sandybridge
  #
  QSUMMARYCMD=null
  QUOTACHECKCMD="df -h /projects/ncfs"
  ALLOCCHECKCMD=null
  ACCOUNT=ncfs
  SUBMITSTRING=sbatch
  JOBLAUNCHER=srun
  SCRATCHDIR=/projects/ncfs/data
  SSHKEY=~/.ssh/id_rsa.pub
  QSCRIPT=hatteras.template.slurm
  PREPCONTROLSCRIPT=hatteras.adcprep.template.slurm
  RESERVATION=null     # ncfs or null, causes job to run on dedicated cores
  PARTITION=ncfs       # ncfs or batch, gives priority
  CONSTRAINT=null      # ivybridge or sandybridge
  QSCRIPTGEN=hatteras.slurm.pl
  PPN=16
  if [[ $RESERVATION = ncfs ]]; then
     PPN=20
  fi
  # to create python environment for the ncfs user, @jasonfleming did this:
  #   pip install --user --upgrade pip
  #   pip install --user --upgrade setuptools
  # for rabbitmq and the asgs status monitor:
  #   pip install --user pika
  #   pip install --user netCDF4
  # for the automated slide deck generator
  #   pip install --user pptx
  #
  export MODULEPATH=$MODULEPATH:/projects/acis/modules/modulefiles
  PLATFORMMODULES='module load intelc/18.0.0 intelfort/18.0.0 hdf5/1.8.12-acis netcdf/4.2.1.1-acis netcdf-Fortran/4.2-acis  mvapich2/2.0-acis'
  if [[ $USER = ncfs ]]; then
     PLATFORMMODULES=$PLATFORMMODULES' python_modules/2.7'
  fi
  module purge
  $PLATFORMMODULES
}
init_stampede()
{ #<- can replace the following with a custom script
  HPCENV=stampede.tacc.utexas.edu
  QUEUESYS=SLURM
  QCHECKCMD=sacct
  ACCOUNT=PleaseSpecifyACCOUNTInYourAsgsConfigFile
  SUBMITSTRING=sbatch
  JOBLAUNCHER=ibrun
  SCRATCHDIR=$SCRATCH
  SSHKEY=~/.ssh/id_rsa_stampede
  QSCRIPT=stampede.template.slurm
  PREPCONTROLSCRIPT=stampede.adcprep.template.slurm
  QSCRIPTGEN=hatteras.slurm.pl
  PPN=16
  PLATFORMMODULES='module load netcdf/4.3.2'
  $PLATFORMMODULES
  #jgf20150610: Most likely QUEUENAME=normal SERQUEUENAME=serial
}
init_stampede2()
{ #<- can replace the following with a custom script
  HPCENV=stampede2.tacc.utexas.edu
  QUEUESYS=SLURM
  QCHECKCMD=sacct
  ACCOUNT=PleaseSpecifyACCOUNTInYourAsgsConfigFile
  SUBMITSTRING=sbatch
  SCRATCHDIR=$SCRATCH
  SSHKEY=~/.ssh/id_rsa_stampede
  QSCRIPT=stampede2.template.slurm
  PREPCONTROLSCRIPT=stampede2.adcprep.template.slurm
  QSCRIPTGEN=stampede2.slurm.pl
  PPN=48
  GROUP="G-803086"
  module load intel/18.0.2 python2/2.7.15 xalt/2.6.5 TACC
  if [[ $USER = "jgflemin" ]]; then
     export PATH=$WORK/local/bin:$PATH
     export LD_LIBRARY_PATH=$WORK/local/lib:$LD_LIBRARY_PATH
  fi
}
init_kittyhawk()
{ #<- can replace the following with a custom script
  HPCENV=kittyhawk.renci.org
  QUEUESYS=PBS
  QCHECKCMD=qstat
  ACCOUNT=noaccount
  SUBMITSTRING=submitstring
  SCRATCHDIR=/work/$USER
  SSHKEY=~/.ssh/id_rsa_kittyhawk
  QSCRIPT=kittyhawk.template.pbs
  PREPCONTROLSCRIPT=kittyhawk.adcprep.template.pbs
  QSCRIPTGEN=tezpur.pbs.pl
  PPN=4
}
init_sapphire()
{ #<- can replace the following with a custom script
  HPCENV=sapphire.erdc.hpc.mil
  QUEUESYS=PBS
  QCHECKCMD=qstat
  ACCOUNT=erdcvhsp
  SUBMITSTRING=qsub
  JOBLAUNCHER="aprun"
  SCRATCHDIR=/work2/$USER
  SSHKEY=~/.ssh/id_rsa_sapphire
  QSCRIPT=erdc.template.pbs
  PREPCONTROLSCRIPT=erdc.adcprep.template.pbs
  PREPHOTSTARTSCRIPT=erdc.adcprep.hotstart.template.pbs
  QSCRIPTGEN=erdc.pbs.pl
  ulimit -s unlimited
  ulimit -v 2097152   # needed for NAMtoOWI.pl to avoid Out of memory error
}

init_jade()
{ #<- can replace the following with a custom script
  HPCENV=jade.erdc.hpc.mil
  QUEUESYS=PBS
  QCHECKCMD=qstat
  ACCOUNT=erdcvhsp
  SUBMITSTRING=qsub
  JOBLAUNCHER="aprun"
# INTERSTRING="qsub -l size=1,walltime=00:10:00 -A $ACCOUNT -q $QUEUENAME -I"
  INTERSTRING=
  SCRATCHDIR=/work/$USER
  SSHKEY=~/.ssh/id_rsa_jade
  QSCRIPT=erdc.template.pbs
  PREPCONTROLSCRIPT=erdc.adcprep.template.pbs
  PREPHOTSTARTSCRIPT=erdc.adcprep.hotstart.template.pbs
  QSCRIPTGEN=erdc.pbs.pl
  ulimit -s unlimited
  ulimit -v 2097152   # needed for NAMtoOWI.pl to avoid Out of memory error
}

init_diamond()
{ #<- can replace the following with a custom script
  HPCENV=diamond.erdc.hpc.mil
  QUEUESYS=PBS
  QCHECKCMD=qstat
  ACCOUNT=erdcvhsp
  SUBMITSTRING="mpiexec_mpt"
  SCRATCHDIR=/work/$USER
  SSHKEY=~/.ssh/id_rsa_diamond
  QSCRIPT=erdc.diamond.template.pbs
  PREPCONTROLSCRIPT=erdc.diamond.adcprep.template.pbs
  PREPHOTSTARTSCRIPT=erdc.diamond.adcprep.hotstart.template.pbs
  QSCRIPTGEN=erdc.pbs.pl
  PPN=8
}

init_garnet()
{ #<- can replace the following with a custom script
  HPCENV=garnet.erdc.hpc.mil
  QUEUESYS=PBS
  QCHECKCMD=qstat
  ACCOUNT=erdcvhsp
  SUBMITSTRING="aprun"
  SCRATCHDIR=$WORKDIR 
  SSHKEY=~/.ssh/id_rsa_garnet
  QSCRIPT=garnet.template.pbs
  PREPCONTROLSCRIPT=garnet.adcprep.template.pbs
  PREPHOTSTARTSCRIPT=garnet.adcprep.template.pbs
  QSCRIPTGEN=erdc.pbs.pl
  PPN=32
  IMAGEMAGICKBINPATH=/usr/local/usp/ImageMagick/default/bin 
}
init_spirit()
{ #<- can replace the following with a custom script
  # This requires the user to have a .personal.bashrc file in the $HOME 
  # directory with the following contents:
  # echo "Loading modules in .personal.bashrc ..."
  # module load intel-compilers/12.1.0
  # module load netcdf-fortran/intel/4.4.2
  # module load hdf5/intel/1.8.12
  # module load hdf5-mpi/intel/sgimpt/1.8.12
  # module load mpt/2.12
  # echo "... modules loaded."
  HPCENV=spirit.afrl.hpc.mil
  QUEUESYS=PBS
  QCHECKCMD=qstat
  ACCOUNT=erdcvhsp
  SUBMITSTRING="mpiexec_mpt"
  SCRATCHDIR=$WORKDIR 
  SSHKEY=~/.ssh/id_rsa_spirit
  QSCRIPT=spirit.template.pbs
  PREPCONTROLSCRIPT=spirit.adcprep.template.pbs
  PREPHOTSTARTSCRIPT=spirit.adcprep.template.pbs
  QSCRIPTGEN=erdc.pbs.pl
  PPN=16
  IMAGEMAGICKBINPATH=/usr/local/usp/ImageMagick/default/bin 
}
init_topaz()
{ #<- can replace the following with a custom script
  # This requires the Operator to have a ~/.bash_profile file in the $HOME 
  # directory with the following contents:
  echo "Loading modules in .bash_profile ..."
  module unload compiler/intel/16.0.0
  module load compiler/intel/15.0.3
  module load usp-netcdf/intel-15.0.3/4.3.3.1
  module load imagemagick/6.9.2-5
  echo "... modules loaded."
  HPCENV=topaz.erdc.hpc.mil
  QUEUESYS=PBS
  QCHECKCMD=qstat
  #ACCOUNT=ERDCV00898N10
  ACCOUNT=ERDCV00898HSP
  SUBMITSTRING="qstat"
  SCRATCHDIR=$WORKDIR 
  SSHKEY=~/.ssh/id_rsa_topaz
  QSCRIPT=topaz.template.pbs
  PREPCONTROLSCRIPT=topaz.adcprep.template.pbs
  PREPHOTSTARTSCRIPT=topaz.adcprep.template.pbs
  QSCRIPTGEN=erdc.pbs.pl
  PPN=36
  IMAGEMAGICKBINPATH=/app/unsupported/ImageMagick/6.9.2-5/bin/convert
  # fyi topaz has a 4hr time limit for the background queue
}
init_thunder()
{ #<- can replace the following with a custom script
  # This requires the Operator to have a ~/.personal.bashrc file in the $HOME 
  # directory with the following contents:
  echo "Loading modules in .bash_profile ..."
  module load costinit
  module load git
  module load netcdf-fortran/intel/4.4.2
  echo "... modules loaded."
  HPCENV=thunder.afrl.hpc.mil
  QUEUESYS=PBS
  QCHECKCMD=qstat
  ACCOUNT=ERDCV00898N10
  #ACCOUNT=ERDCV00898HSP
  SUBMITSTRING="qstat"
  SCRATCHDIR=$WORKDIR 
  SSHKEY=~/.ssh/id_rsa_thunder
  QSCRIPT=thunder.template.pbs
  PREPCONTROLSCRIPT=thunder.adcprep.template.pbs
  PREPHOTSTARTSCRIPT=thunder.adcprep.template.pbs
  QSCRIPTGEN=erdc.pbs.pl
  PPN=36
  IMAGEMAGICKBINPATH=/app/unsupported/ImageMagick/6.9.2-5/bin/convert
}
init_tezpur()
{ #<- can replace the following with a custom script
  HPCENV=tezpur.hpc.lsu.edu
  QUEUESYS=PBS
  QCHECKCMD=qstat
  ACCOUNT=loni_asgs2009
  SUBMITSTRING="mpirun"
  SCRATCHDIR=/work/cera
  SSHKEY=id_rsa_tezpur
  QSCRIPT=tezpur.template.pbs
  PREPCONTROLSCRIPT=tezpur.adcprep.template.pbs
  PREPHOTSTARTSCRIPT=tezpur.adcprep.template.pbs
  QSCRIPTGEN=tezpur.pbs.pl
  PPN=4
}
init_mike()
{ #<- can replace the following with a custom script
  HPCENV=mike.hpc.lsu.edu
  QUEUESYS=PBS
  QCHECKCMD=qstat
  ACCOUNT=pleaseSetAccountParamToHPCAllocationInASGSConfig
  SUBMITSTRING="mpirun"
  SCRATCHDIR=/work/$USER
  SSHKEY=id_rsa_mike
  QSCRIPT=mike.template.pbs
  PREPCONTROLSCRIPT=mike.adcprep.template.pbs
  QSCRIPTGEN=tezpur.pbs.pl
  PPN=16
  soft add +netcdf-4.1.3-Intel-13.0.0 
  #/usr/local/packages/netcdf/4.1.3/Intel-13.0.0
}
init_ranger()
{ #<- can replace the following with a custom script
  HPCENV=ranger.tacc.utexas.edu
  QUEUESYS=SGE
  QCHECKCMD=qstat
  NCPUDIVISOR=16
  ACCOUNT=TG-DMS100024
  SUBMITSTRING="ibrun tacc_affinity"
  SCRATCHDIR=$SCRATCH
  SSHKEY=id_rsa_ranger
  QSCRIPT=ranger.template.sge
  QSCRIPTGEN=ranger.sge.pl
  SERQSCRIPT=ranger.template.serial
  SERQSCRIPTGEN=ranger.serial.pl
  UMASK=006
  GROUP="G-81535"
}
init_lonestar()
{ #<- can replace the following with a custom script
  HPCENV=lonestar.tacc.utexas.edu
  QUEUESYS=SLURM
  QUEUENAME=normal
  SERQUEUE=normal
  QCHECKCMD=squeue
  PPN=24
  RESERVATION=null     # ncfs or null, causes job to run on dedicated cores
  PARTITION=null       # ncfs or batch, gives priority
  CONSTRAINT=null      # ivybridge or sandybridge
  ACCOUNT=ADCIRC
  SUBMITSTRING=sbatch
  JOBLAUNCHER=ibrun
  SCRATCHDIR=$SCRATCH
  SSHKEY=id_rsa_lonestar
  QSCRIPT=lonestar.template.slurm
  QSCRIPTGEN=hatteras.slurm.pl
  PREPCONTROLSCRIPT=lonestar.template.serial.slurm
  SERQSCRIPTGEN=hatteras.slurm.pl
  UMASK=006
  GROUP="G-803086"
  #ml reset
  if [[ $USER = "jgflemin" ]]; then
     export PATH=$WORK/local/bin:$PATH
     export LD_LIBRARY_PATH=$WORK/local/lib:$LD_LIBRARY_PATH
  fi
  #PLATFORMMODULES='module load netcdf nco'
  #$PLATFORMMODULES
  #
  # @jasonfleming 20190218 : don't upgrade pip! 
  # for rabbitmq and the asgs status monitor:
  #   pip install --user pika
  #   pip install --user netCDF4
  # for the automated slide deck generator
  #   (installing pptx did not work -- it was not found) 
  #   pip install --user python-pptx
  #
  # btw git on lonestar5 is messed up when it outputs things like diffs,
  # found the solution:
  # git config --global core.pager "less -r"
}
init_desktop()
{
  HPCENV=jason-desktop
  QUEUESYS=mpiexec
  QCHECKCMD="ps -aux | grep mpiexec "
  SUBMITSTRING="mpiexec -n "
  SCRATCHDIR=/srv/asgs
  SSHKEY=id_rsa_jason-desktop
  ADCOPTIONS='compiler=gfortran MACHINENAME=jason-desktop'
  SWANMACROSINC=macros.inc.gfortran
}
init_Poseidon()
{
  HPCENV=poseidon.vsnet.gmu.edu
  QUEUESYS=mpiexec
  QCHECKCMD="ps -aux | grep mpiexec "
  SUBMITSTRING="mpiexec -n"
  SCRATCHDIR=/home/fhrl/Documents/asgs_processing
  SSHKEY=id_rsa_jason-desktop
  ADCOPTIONS='compiler=gfortran MACHINENAME=jason-desktop'
  SWANMACROSINC=macros.inc.gfortran
}

init_topsail()
{ #<- can replace the following with a custom script
  HPCENV=topsail.unc.edu
  QUEUESYS=LSF
  INTERSTRING="bsub -q int -Ip"
  SCRATCHDIR=/ifs1/scr/$USER
  SSHKEY=id_rsa_topsail
}
# THREDDS Data Server (TDS, i.e., OPeNDAP server) at RENCI
init_renci_tds()
{
# http://tds.renci.org:8080/thredds/fileServer/DataLayers/asgs/tc/nam/2018070806/ec_95d/pod.penguin.com/podtest/namforecast/maxele.63.nc
# http://tds.renci.org:8080/thredds/dodsC/     DataLayers/asgs/tc/nam/2018070806/ec_95d/pod.penguin.com/podtest/namforecast/maxele.63.nc
# http://tds.renci.org:8080/thredds/catalog/                   tc/nam/2018070806/ec_95d/pod.penguin.com/podtest/namforecast/catalog.html
   OPENDAPHOST=ht4.renci.org
   DOWNLOADPREFIX="http://tds.renci.org:8080/thredds/fileServer"
   CATALOGPREFIX="http://tds.renci.org:8080/thredds/catalog"
   OPENDAPBASEDIR="/projects/ncfs/opendap/data/"
   #DOWNLOADPREFIX="http://tds.renci.org:8080/thredds/fileServer/DataLayers/asgs/"
   #CATALOGPREFIX="http://tds.renci.org:8080/thredds/DataLayers/asgs/"
   #OPENDAPBASEDIR=/projects/ees/DataLayers/asgs/
   SSHPORT=22
   LINKABLEHOSTS=(null) # list of hosts where we can copy for thredds service, rather than having to scp the files to an external machine
   COPYABLEHOSTS=(hatteras hatteras.renci.org) # list of hosts where we can just create symbolic links for thredds service, rather than having to scp the files to an external machine
   if [[ $USER = jgflemin || $USER = ncfs ]]; then
      OPENDAPUSER=ncfs
   fi
}
# THREDDS Data Server (TDS, i.e., OPeNDAP server) at LSU
init_lsu_tds()
{
   OPENDAPHOST=fortytwo.cct.lsu.edu
   DOWNLOADPREFIX="http://${OPENDAPHOST}:8080/thredds/fileServer"
   CATALOGPREFIX="http://${OPENDAPHOST}:8080/thredds/catalog"
   OPENDAPBASEDIR=/data/opendap
   SSHPORT=2525
   LINKABLEHOSTS=(null) # list of hosts where we can just create symbolic links
   COPYABLEHOSTS=(null) # list of hosts where we can copy for thredds service, rather than having to scp the files to an external machine
   if [[ $USER = jgflemin ]]; then
      OPENDAPUSER=$USER
   fi
}
# THREDDS Data Server (TDS, i.e., OPeNDAP server) at LSU Center for Coastal Resiliency
init_lsu_ccr_tds()
{
   OPENDAPHOST=chenier.cct.lsu.edu
   DOWNLOADPREFIX="http://${OPENDAPHOST}:8080/thredds/fileServer/asgs/ASGS-2019"
   CATALOGPREFIX="http://${OPENDAPHOST}:8080/thredds/catalog/asgs/ASGS-2019"
   OPENDAPBASEDIR=/data/thredds/ASGS/ASGS-2019
   SSHPORT=2525
   LINKABLEHOSTS=(null) # list of hosts where we can just create symbolic links
   COPYABLEHOSTS=(null) # list of hosts where we can copy for thredds service, rather than having to scp the files to an external machine
}
# THREDDS Data Server (TDS, i.e., OPeNDAP server) at Texas
# Advanced Computing Center (TACC)
init_tacc_tds()
{
   OPENDAPHOST=adcircvis.tacc.utexas.edu
   DOWNLOADPREFIX="http://${OPENDAPHOST}:8080/thredds/fileServer/asgs"
   CATALOGPREFIX="http://${OPENDAPHOST}:8080/thredds/catalog/asgs"
   OPENDAPBASEDIR=/corral-tacc/utexas/hurricane/ASGS
   SSHPORT=null
   LINKABLEHOSTS=(null) # list of hosts where we can just create symbolic links for thredds service, rather than having to scp the files to an external machine
   #COPYABLEHOSTS=(lonestar lonestar.tacc.utexas.edu) # list of hosts where we can copy for thredds service, rather than having to scp the files to an external machine
   COPYABLEHOSTS=(lonestar lonestar5 lonestar.tacc.utexas.edu lonestar5.tacc.utexas.edu ls5.tacc.utexas.edu stampede stampede.tacc.utexas.edu stampede2 stampede2.tacc.utexas.edu) # list of hosts where we can copy for thredds service, rather than having to scp the files to an external machine
   if [[ $USER = jgflemin ]]; then
      OPENDAPUSER=$USER
   fi
}
init_penguin()
{ #<- can replace the following with a custom script
  HPCENV=pod.penguincomputing.com
  #HOSTNAME=login-29-45.pod.penguincomputing.com
  QUEUESYS=PBS
  QCHECKCMD=qstat
  SCRATCHDIR=/home/$USER
  SUBMITSTRING="mpirun"
  QSCRIPT=penguin.template.pbs
  PREPCONTROLSCRIPT=penguin.adcprep.template.pbs
  QSCRIPTGEN=penguin.pbs.pl
  PPN=40
}
init_test()
{ #<- can replace the following with a custom script
  QUEUESYS=Test
  NCPU=-1
}
# used to dispatch environmentally sensitive actions
# such as queue interactions
env_dispatch(){
 HPCENVSHORT=$1
 case $HPCENVSHORT in
  "camellia") allMessage "platforms.sh: Camellia(WorldWinds) configuration found."
          init_camellia
          ;;
  "lsu_tds") allMessage "platforms.sh: LSU THREDDS Data Server configuration found."
          init_lsu_tds
          ;;
  "lsu_ccr_tds") consoleMessage "platforms.sh: LSU THREDDS Data Server configuration found."
          init_lsu_ccr_tds
          ;;
  "renci_tds") consoleMessage "platforms.sh: RENCI THREDDS Data Server configuration found."
          init_renci_tds
          ;;
  "tacc_tds") allMessage "platforms.sh: TACC THREDDS Data Server configuration found."
          init_tacc_tds
          ;;
  "kittyhawk") allMessage "platforms.sh: Kittyhawk (RENCI) configuration found."
          init_kittyhawk
          ;;
  "blueridge") allMessage "platforms.sh: Blueridge (RENCI) configuration found."
          init_blueridge
          ;;
  "croatan") allMessage "platforms.sh: Croatan (RENCI) configuration found."
          init_croatan
          ;;
  "pod") allMessage "platforms.sh: POD (Penguin) configuration found."
          init_pod
          ;;
  "hatteras") allMessage "platforms.sh: Hatteras (RENCI) configuration found."
          init_hatteras
          ;;
  "hatteras14") allMessage "platforms.sh: Hatteras (RENCI) configuration found."
          init_hatteras14
          ;;
  "sapphire") allMessage "platforms.sh: Sapphire (ERDC) configuration found."
          init_sapphire
          ;;
  "jade") allMessage "platforms.sh: Jade (ERDC) configuration found."
          init_jade
          ;;
  "diamond") allMessage "platforms.sh: Diamond (ERDC) configuration found."
          init_diamond
          ;;
  "garnet") allMessage "platforms.sh: Garnet (ERDC) configuration found."
          init_garnet
          ;;
  "spirit") allMessage "platforms.sh: Spirit (AFRL) configuration found."
          init_spirit
          ;;
  "topaz") allMessage "platforms.sh: Topaz (ERDC) configuration found."
          init_topaz
          ;;
  "thunder") allMessage "platforms.sh: Thunder (AFRL) configuration found."
          init_thunder
          ;;
  "supermike") allMessage "platforms.sh: Supermike (LSU) configuration found."
          init_supermike
          ;;
  "queenbee") allMessage "platforms.sh: Queenbee (LONI) configuration found."
          init_queenbee
          ;;
  "supermic") allMessage "platforms.sh: Queenbee (LONI) configuration found."
          init_supermic
          ;;
  "tezpur") allMessage "platforms.sh: Tezpur (LSU) configuration found."
          init_tezpur
          ;;
  "mike") allMessage "platforms.sh: SuperMike-II (LSU) configuration found."
          init_mike
          ;;
  "topsail") allMessage "platforms.sh: Topsail (UNC) configuration found."
          init_topsail
          ;;
  "ranger") allMessage "platforms.sh: Ranger (TACC) configuration found."
          init_ranger
          ;;
  "lonestar") allMessage "platforms.sh: Lonestar (TACC) configuration found."
          init_lonestar
          ;;
  "stampede") allMessage "platforms.sh: Stampede (TACC) configuration found."
          init_stampede
          ;;
  "stampede2") allMessage "platforms.sh: Stampede2 (TACC) configuration found."
          init_stampede2
          ;;
  "arete") allMessage "platforms.sh: Arete (CCT) configuration found."
          init_arete
          ;;
  "desktop") allMessage "platforms.sh: desktop configuration found."
          init_desktop
           ;;
  "poseidon") allMessage "platforms.sh: desktop configuration found."
          init_Poseidon
           ;;
  "penguin") allMessage "platforms.sh: desktop configuration found."
          init_penguin
           ;;
  "rostam") allMessage "platforms.sh: rostam configuration found."
          init_rostam
           ;;
  "test") allMessage "platforms.sh: test environment (default) configuration found."
          init_test
          ;;
  *) fatal "platforms.sh: '$HPCENVSHORT' is not a supported environment; currently supported options: kittyhawk, blueridge, sapphire, jade, diamond, ranger, lonestar, stampede, supermike, queenbee, supermic, topsail, desktop, arete, spirit, topaz, thunder, lsu_tds, lsu_ccr_tds, renci_tds, tacc_tds"
     ;;
  esac
}
