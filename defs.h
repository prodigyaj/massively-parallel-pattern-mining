#ifdef TEST_MODE
#define max_items_in_transaction 5
#define max_num_of_transaction 8//00000
#define max_unique_items 30//32000
#define BLOCK_SIZE 1024
#define TRANSACTION_PER_SM 4
#define support 1
#else
#define max_items_in_transaction 5//128//64//32
#define max_num_of_transaction 8
#define max_unique_items 32000
#define BLOCK_SIZE 1024
#define TRANSACTION_PER_SM 192//96//47//95//380//190//
#define support 1
#endif
#define INVALID 0XFFFFFF 
