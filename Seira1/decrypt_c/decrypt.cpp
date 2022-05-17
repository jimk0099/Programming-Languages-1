#include <iostream>
#include <fcntl.h>
#include <stdio.h>
#include <math.h> 
using namespace std;


void make_alphabet_small(int *letters, int offset) {
    for (int i = 0; i < 26; i++) {
        letters[i] = 97 + (offset + i) % 26;
    }
}

void make_alphabet_cap(int *letters, int offset) {
    for (int i = 0; i < 26; i++) {
        letters[i] = 65 + (offset + i) % 26;
    }
}

int main(int argc, char **argv) {
    int letters_cap[26], letters_small[26], my_text[10001], counter = 0, fN[26], answer[10001], dec_text[10001];
    double H = 0.0, Hmin = 100000.0;   //Hmin might need change
    double entropies[26] = {0.08167, 0.01492, 0.02782, 0.04253, 0.12702, 0.02228, 0.02015, 
                        0.06094, 0.06966, 0.00153, 0.00772, 0.04025, 0.02406, 0.06749, 
                        0.07507, 0.01929, 0.00095, 0.05987, 0.06327, 0.09056, 0.02758, 
                        0.00978, 0.02360, 0.00150, 0.01974, 0.00074};
    char a;
    for (int i = 0; i <26; i++) {
        fN[i] = 0;
    }
    FILE *filos = fopen(argv[1], "rt");
    while(fscanf(filos, "%c", &a) != EOF) {
        //printf("%d\n", a);
        my_text[counter] = a;
        counter++;
    }
    fclose(filos);
    for(int k = 0; k < 26; k++) {
        //printf("%2d   ", k);
        make_alphabet_small(letters_small, k);
        make_alphabet_cap(letters_cap, k);
        for(int j = 0; j < counter; j++) {
            if(my_text[j] >= 65 && my_text[j] <= 90) {
                //printf("%c", letters_cap[my_text[j] - 65]);
                dec_text[j] = letters_cap[my_text[j] - 65];
                fN[letters_cap[my_text[j] - 65] - 65] += 1; 
                //H -=  1 * log(entropies[my_text[j] - 65]);
            }
            else if(my_text[j] >= 97 && my_text[j] <= 122) {
                //printf("%c", letters_small[my_text[j] - 97]);
                dec_text[j] = letters_small[my_text[j] - 97];
                fN[letters_small[my_text[j] - 97] - 97] += 1;
            }
            else {
                //printf("%c", my_text[j]);
                dec_text[j] = my_text[j];
            }
        }
        for(int m = 0; m < 26; m++) {
            H -= fN[m] * log(entropies[m]);
        }
        //printf(" -- Entropy = %lf\n", H);
        //reset variables to iterate with new alphabet
        if(H < Hmin) {
            Hmin = H;
            for (int i = 0; i < counter; i++) {
                answer[i] = dec_text[i];
            }
        }
        H = 0.0;
        for (int i = 0; i <26; i++) {
            fN[i] = 0;
        }
    }
    for (int i = 0; i < counter; i++) {
        printf("%c", answer[i]);
    }
    return 0;
}