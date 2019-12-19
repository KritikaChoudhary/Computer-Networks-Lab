//Length of generating polynomial(divisor)=N
//Length of data word=a
//Length of codeword=a+N-1
#include<stdio.h>
#include<string.h>
#define N strlen(divisor)
char data[40],syn[40],s[40];
char divisor[50]="1001001001";
int a,i;
void strToBin()
{
    int val;
    char bin[40];
    strcpy(bin,"");
    for(int i=0;i<strlen(data);i++)
    {
        val=(int)data[i];
        do
        {
            (val%2)?strcat(bin,"1"):strcat(bin,"0");//important
            val/=2;
        }while(val>0);
    }
    strcpy(data,strrev(bin));
}
void xor()
{
    for(int i=0;i<N;i++)
        s[i]=(s[i]==divisor[i]?'0':'1');
}
void crc()
{
    int e,i;
    for(e=0;e<N;e++)
       s[e]=data[e];
    do
    {
        if(s[0]=='1')
            xor();
        for(i=0;i<N-1;i++)
            s[i]=s[i+1];
        s[i]=data[e++];
    }while(e<=a+N-1);
}
void main()
{
    printf("1.String input?\n2.Binary input\nEnter:");
    int ch;
    scanf("%d",&ch);
    printf("\nEnter:");
    scanf("%s",data);
    if(ch==1)
        strToBin();
    a=strlen(data);
    for(int i=a;i<N+a-1;i++)
        data[i]='0';
    crc();
    for(int i=a;i<a+N-1;i++)
        data[i]=s[i-a];
    printf("\nSyndrome:%s",s);
    printf("\nCodeWord:%s",data);
    printf("\n1.Erroneous data?\n2.Error Free data?\nEnter:");
    scanf("%d",&ch);
    if(ch==1)
    {
        int k=rand()%a;
        data[k]=(data[k]=='1'?'0':'1');
    }
    crc();
    printf("\nNew Syndrome:%s",s);
    printf("\nCodeWord:%s",data);
    for(i=0;i<N && s[i]!='1';i++);
    if(i<N)
        printf("\nErroneous data");
    else
        printf("\nError free data");
}
