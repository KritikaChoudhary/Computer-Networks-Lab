#include<stdio.h>
#include<stdlib.h>
 #define MIN(x,y) (x>y)?y:x
 int main()
  {
        int orate=50,drop=0,cap=100,x,count=0,inp[5]={0},i=0,nsec;
        do
        {
            inp[i]=rand();
            i++;
        }while(i<5);
        nsec=i;
        printf("\n second \t recieved \t sent \t dropped \t remained \n");
        for(i=0;count || i<nsec;i++)
        {
            printf("      %d",i+1);
            if(i>=nsec)
                inp[i]=0;
            printf("      \t%d\t      ",inp[i]);
            printf(" \t     %d\t ",MIN((inp[i]+count),orate));
            if((x=inp[i]+count-orate)>0)
            {
                if(x>cap)
                {
                    count=cap;
                    drop=x-cap;
                }
                else
                {
                    count=x;

                    drop=0;
                }
            }
            else
            {

                    drop=0;
                    count=0;
             }
            printf(" \t %d        \t %d \n",drop,count);
    }
    return 0;
}

