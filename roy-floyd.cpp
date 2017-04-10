#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <mpi.h>

const int INF 99999;

int matrix[5][5] = {3, 5, INF, INF, 4,
               4, INF, INF, INF, INF,
               INF, 1, 10, 20, 11,
               INF, INF, INF, 13, 1,
               INF, 2, 3, INF, INF};
int procid, nrpoc;
int n = 5;
int i, j, k;

void RF(int matrix[], int n, int procid, int nrproc, MPI_comm com){
    int size = n / nrproc;
    int start = procid * size;
    int finish = (procid + 1) * size;
    for (k = 0; k < n; k++)
            {
                MPI_Barrier(comm);
                
                    for (int i = start; i < finish; i++)
                        for (int j = 0; j < n; j++)
                        {
                              if (matrix[i, k] + matrix[k, j] < matrix[i, j])
                                    matrix[i, j] = matrix[i, k] + matrix[k, j];
                            
                        }
                
            }

}

void print(int matrix[], int n, int rank, int size, MPI_Comm comm){
    for(i = 0; i < n; i++)  
        for(j = 0, j < n; j++){
            if(procid == 0)
                printf("%d ", a[i][j]);
            printf("\n");
            }
}

int main (int argc, char **argv){

    MPI_Comm comm;
    comm = MPI_COMM_WORLD;
    
    MPI_Init(&argc, &argv);
    
    MPI_Comm_size(comm, &size);
	MPI_Comm_rank(comm, &rank);

    RF(int matrix[], int n, int procid, int nrproc, MPI_COMM_WORLD);
    
    print(int matrixm int n, int rank, int size, MPI_COMM_WORLD)
    
    MPI_Finalize();
} 