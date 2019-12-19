#include<stdio.h>
#include<stdlib.h>
int csum,ncsum;
int cs(char data[])
{
    int n,temp,sum=0;
    if(strlen(data)%2==0)
        n=strlen(data)/2;
    else
        n=(strlen(data)+1)/2;
    for(int i=0;i<n;i++)
    {
        temp=data[i*2];
        temp=temp*256+data[i*2+1]; //eg: F=46 o=6F F*256=4600 hence, F*256+o=4600+6F=466F
        printf("\nFor %c%c :%x",data[i*2],data[i*2+1],temp);
        sum+=temp;
    }
    if(sum%65536!=0) //there is a carry
        sum=sum/65536+(sum%65536);
    return 65535-sum; //complementing sum
}
void main()
{
    char data[40];
    printf("Enter data:");
    scanf("%s",data);
    csum=cs(data);
    printf("\nChecksum:%x",csum);
    printf("\n1.Erroneous data\n2.Error free data?\nEnter:");
    int ch;
    scanf("%d",&ch);
    if(ch==1)
    {
        int i=rand()%strlen(data);
        data[i]=data[i]+1;
    }
    ncsum=cs(data);
    printf("\nNew Checksum:%x",ncsum);
    if(csum-ncsum==0)
        printf("\nError free data");
    else
        printf("\nData is erroneous");
}
