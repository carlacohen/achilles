### Test parallel loops ###

library('doMC')

# set up the parallel bit

# import the number of available CPUs
# this is the number we supplied at the line
#SBATCH --cpus-per-task=4
# in our .sh file
n.cpus <- Sys.getenv("SLURM_CPUS_PER_TASK")
n.cpus <- as.numeric(n.cpus)
n.cpus

# register a parallel backend specifying the number of CPUs as the number we imported via Sys.getenv()
registerDoMC(cores = n.cpus) 


# a simple function to execute first in serial then again in parallel

f1 <- function(x){
    Sys.sleep(2)
    return(x)
}

# import the number of available CPUs
# this is the number we supplied at the line
#SBATCH --cpus-per-task=4
# in our .sh file

n.cpus <- Sys.getenv("SLURM_CPUS_PER_TASK")

n.cpus

class(n.cpus)

# we need this to be numeric below so:

n.cpus <- as.numeric(n.cpus)

n.cpus

class(n.cpus)

# register a parallel backend specifying the number of CPUs as the number we imported via Sys.getenv()

registerDoMC(cores = n.cpus) 

# run a serial foreach loop

system.time(
    s1 <- foreach(i = 1:4, .combine = c) %do%
        f1(i)
)  

# run a parallel foreach loop

system.time(
    s2 <- foreach(i = 1:4, .combine = c) %dopar%
        f1(i)
)  

# the parallel foreach loop should be faster