#include "defs.h"
#include "kernel.cu"
#include <iostream>
#include <cstdio>

using namespace std;

int main()
{
    FILE *fp = fopen("sample.txt","r");
    if(fp == NULL)
        cout<<"File does not exist\n";

    unsigned int *transactions = NULL;
    char *line = NULL;
    size_t len = 0;
    char *ln;
    unsigned int lines = 0;
    transactions = (unsigned int *) malloc(max_num_of_transaction * max_items_in_transaction * sizeof(unsigned int));

    int offset = 0;
    while (getline(&line, &len, fp) != -1 && lines < max_num_of_transaction){
        ln = strtok(line, " ");
        int i = offset;
        while(ln != NULL)
        {
            cout<<(int)ln[0]<<" ";
            transactions[i++] = (unsigned int)ln[0];
            ln = strtok(NULL, " ");
        }
        offset += max_items_in_transaction;
        cout<<endl;
    }

    unsigned int *d_transactions;
    //cudaError_t cuda_ret;
    
    cudaMalloc((void**)&d_transactions, max_num_of_transaction * max_items_in_transaction * sizeof(unsigned int));
    cudaMemcpy(d_transactions, transactions , max_num_of_transaction * max_items_in_transaction * sizeof(unsigned int), cudaMemcpyHostToDevice);

    struct node *d_output,*h_output;
    h_output = (node *) malloc(max_items_in_transaction * sizeof(node));
    cudaMalloc((void**)&d_output, max_items_in_transaction * sizeof(node));
    cudaMemset(d_output, 0 , max_items_in_transaction * sizeof(node));

    dim3 grid_dim = ((max_num_of_transaction * max_items_in_transaction) - 1)/max_items_in_transaction + 1;
    dim3 block_dim = max_items_in_transaction;

    generate_fp_tree <<<grid_dim,block_dim>>> (d_transactions,d_output);

    cudaMemcpy(h_output, d_output , max_items_in_transaction * sizeof(node), cudaMemcpyDeviceToHost);

    cout<<"Original output:\n";
    for(int i=0;i<5;i++)
    {
        for(int j=0;j<5;j++)
            cout<<h_output[i].items[j]<<" ";
        cout<<endl;
    }

}

