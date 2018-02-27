# declare a name for this job to be sample_job
#PBS -N crowder_job  
# request the queue (enter the possible names, if omitted, serial is the default)
#PBS -q batch 
# request 1 node
#PBS -l nodes=1
# mail is sent to you when the job starts and when it terminates or aborts
# specify your email address
# By default, PBS scripts execute in your home directory, not the 
# directory from which they were submitted. The following line 
# places you in the directory from which the job was submitted.  
cd $PBS_O_WORKDIR
# run the program

/home/petr/workspace/oxdna-code/crowderoxdna/bin/oxDNA input
exit 0
