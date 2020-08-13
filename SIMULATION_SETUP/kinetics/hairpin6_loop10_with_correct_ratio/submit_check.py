import glob
import os

folder_list = []
for folder_name in glob.glob("crowder_f*"):
    for i in range(1,6):
        foler_list_name = folder_name+'/'+'RUN%d'%i +'/FLUX'
        folder_list.append(foler_list_name)

running_list = folder_list[0:3]
waiting_list = folder_list[4:-1]
print(running_list)

success_num = 0

for foler_path in running_list:
    os.chdir(foler_path)
    #os.system('sbatch submit.slurm')
    os.chdir('../../..')

def get_success_num(folder_path):
    success_path = folder_path+'/success*'
    success_num = len(glob.glob("success_path"))
    return(success_num)

def get_job_id(foler_path):
    success_path = folder_path+'/success*'
    slurm_file = len(glob.glob("slurm.*.out"))
    job_id = int(filter(str.isdigit,slurm_file))


    return(success_num)

success_num = 0
waiting_list_num = len(waiting_list)

while waiting_list_num != 0:

    # check the results every 2 mins
    os.system('sleep 3') 
    for index,folder_path in enumerate(running_list):

        success_num = get_success_num(folder_path)
        job_id = get_job_id(folder_path)
        print('## check job %s ...\n'%folder_path)

        if success_num > 499:
            running_list[index] = waiting_list[0]
            print("%d jobs left......\n"%waiting_list_num)
            print("Runing new simulation %s ......\n"%running_list[index])
            os.chdir(waiting_list[0])
            os.system('qdel %d'%job_id)
            os.system('sbatch submit.slurm')
            os.chdir('../../..')
            waiting_list.pop(0)
            waiting_list_num = len(waiting_list)