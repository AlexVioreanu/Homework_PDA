#include <malloc.h>
#include <stdlib.h>
#include <stdio.h>
#include <io.h>
#include <cuda_runtime.h>
#include <cuda.h>

__global__ void bubbleeven(gpuarray){
    int i = threadIdx.x;
    int swap;
    if(gpuarray[2*i] > gpuarray[2*i+1]){
        swap = gpuarray[2*i];
        gpuarray[2*i] = gpuarray[2*i+1];
        gpuarray[2*i+1] = swap;
    }
}

__global__ void bubbleodd(gpuarray){
    int i = threadIdx.x;
    int swap;
    if(gpuarray[2*i+1] > gpuarray[2*i+2]){
        swap = gpuarray[2*i+1];
        gpuarray[2*i+1] = gpuarray[2*i+2];
        gpuarray[2*i+2] = swap;
    }

}

int main(){
  int i,k;
  int n = 20;
  int size;
  size = n * sizeof(int);
  
  int* cpuarray = (int*)malloc(size); 	
  int* gpuarray;
  cudaMalloc(gpuarray, size); 
  
  for(i = 0; i < n; i++)
    scanf("%d", &cpuarray[i]);
    
  cudaMemcpy(gpuarray, cpuarray, size, cudaMemcpyHostToDevice);
  
  
  for(k = 0; k <= n-2; k++)
    if(k % 2 == 0){
        bubbleeven <<< 1, (n/2 - 1) >>>(gpuarray);
    }
    else
    {
        bubleodd <<< 1, (n/2 - 2) >>>(gpuarray);
    }
    
  
  
  cudaMemcpy(cpuarray, gpuarray, size, cudaMemcpyDeviceToHost);
  cudaFree(gpuarray);
  
  for(i = 0; i < n; i++)
    printf("%d ", cpuarray[i]);

}