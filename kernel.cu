struct node
{
    int items[10];
    int parent[10];
};

__global__ void generate_fp_tree(unsigned int* input, node *output)
{
    int tx = threadIdx.x;
    int gtx = blockIdx.x * blockDim.x + threadIdx.x;
    if(input[gtx]!=0)
        atomicAdd(&output[tx].items[input[gtx]-65],1);
        //output[tx].items[input[gtx]-65]+=1;
    //output[tx].items[0]+=input[gtx];
}
