//**do not forget \n's in printf
//**do not forget to use manpages
#include<stdio.h>
#include<string.h>
#include<sys/socket.h>
#include<unistd.h>
#include<arpa/inet.h>
#include<unistd.h>
#include<netinet/in.h>
void main()
{
	struct sockaddr_in serverAddr;
	socklen_t addr;

	int clientSocket;

	clientSocket=socket(PF_INET,SOCK_STREAM,0);

	serverAddr.sin_family=AF_INET;
	serverAddr.sin_port=htons(7891);
	serverAddr.sin_addr.s_addr=inet_addr("127.0.0.1");
	memset(serverAddr.sin_zero,'\0',sizeof serverAddr.sin_zero);

	addr=sizeof serverAddr;
	connect(clientSocket,(struct sockaddr*)&serverAddr,addr);

	printf("\nEnter filename:");
	char fname[255],msg[1024];
	scanf("%s",fname);
	
	send(clientSocket,fname,255,0);//client sends the filename 
	
	printf("\nResponse:\n");
	while(recv(clientSocket,msg,1024,0)>0)//receive file content
		printf("%s\n",msg);
	
	close(clientSocket);
}
