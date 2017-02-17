#include <stdio.h>

int main(void) 
{
    int i = 233;
    int a = i >> 12&0xf;
    int b = i >> 8&0xf;
    int c = i >> 4&0xf;
    int d = i&0xf;
    a = a&0xf;
    printf("%x%x%x%x\n",a,b,c,d);
}