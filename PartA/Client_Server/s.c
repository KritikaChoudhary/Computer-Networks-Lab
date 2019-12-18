//**do not forget \n's in printf
//**do not forget to use manpages
//manpages for function present in a section eg:accept(2) use man 2 accept
#include<stdio.h>
#include<string.h>
#include<netinet/in.h>
#include<fcntl.h>
#include<arpa/inet.h>
#include<unistd.h>
#include<sys/socket.h>
void main()
{
	struct sockaddr_in serverAddr,serverStorage;

	int serverSocket;

	serverSocket=socket(PF_INET,SOCK_STREAM,0);//place it before below declarations

	serverAddr.sin_family=AF_INET;
	serverAddr.sin_port=htons(7891);
	serverAddr.sin_addr.s_addr=inet_addr("127.0.0.1");
	memset(serverAddr.sin_zero,'\0',sizeof serverAddr.sin_zero); 

	bind(serverSocket,(struct sockaddr*)&serverAddr,sizeof serverAddr);//binding server to an address(serverAddr)

	if(listen(serverSocket,5)==0)
		printf("\nListening...\n");
	else
		printf("\nError\n");

	int clientSocket,n,fd;
	socklen_t addr=sizeof serverStorage;

	clientSocket=accept(serverSocket,(struct sockaddr*) &serverStorage,&addr);//server accepting client request(serverStorage)

	char fname[255],msg[1024];

	recv(clientSocket,fname,255,0);//receiving file name from the client
	fd=open(fname,O_RDONLY);//open file in read only mode

	if(fd==-1)
	{
		strcpy(msg,"Not found");
		n=strlen(msg);
	}
	else
		n=read(fd,msg,1024);//reading from the new file descriptor
	
	send(clientSocket,msg,n,0);//sending the file content to the client

	close(serverSocket);
	close(clientSocket);
}
