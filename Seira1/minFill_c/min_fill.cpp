//source: https://www.programiz.com/dsa/prim-algorithm

#include <iostream>
#include <stdio.h>
using namespace std;

#define INF 9999999

int my_text[1000000];
int selected[10000];


void my_reader(char *f) {
    int counter = 0, a;
    FILE *fp = fopen(f, "rt");
    if(fp == NULL) {
        printf("Error opening the file");
        return ; //crazy stuff here
    }
    while(fscanf(fp, "%d", &a) != EOF) {
        //printf("%c", a);
        my_text[counter] = a;
        counter++;
    }
    fclose(fp);
}

int main(int argc, char *argv[]) {
    my_reader(argv[1]);
    int num_of_nodes = my_text[0], num_of_edges = my_text[1], no_edge = 0, node = 0, minimum = INF;
    for(int i = 0; i < num_of_nodes; i++) {
        selected[i]= false;
    }
    selected[0] = true;
    //printf("nodes: %d, edges: %d", my_text[0], my_text[1]);
    while(no_edge < num_of_nodes - 1) {
        minimum = INF;
        for(int i = 0; i < num_of_nodes; i++) {         //Search for each node
            if(selected[i]) {
                for(int m = 0; m < num_of_nodes; m++) {
                    if(!selected[m]){
                        for(int j = 0; j < num_of_edges; j++) {
                            if((my_text[2+3*j] == i+1 && my_text[3+3*j] == m+1) ||
                                (my_text[2+3*j] == m+1 && my_text[3+3*j] == i+1)) {
                                    if(minimum > my_text[4+3*j]) {
                                        minimum = my_text[4+3*j];
                                        node = m;
                                    }
                            }
                        }
                    }
                }
            }
        }
        //printf("Minimum edge is: %d\n", minimum);
        selected[node] = true;
        no_edge++;
    }
    //printf("Minimum L is: %d\n", minimum);
    printf("%d", minimum);
    return 0; 
}




//int *my_text = new  int[1000000];
//delete [] my_text;