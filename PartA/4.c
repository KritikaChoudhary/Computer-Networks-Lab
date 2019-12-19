#include<stdio.h>
void djikstra(int v,int s,int cost[][10])
{
    for(int i=0;i<v;i++)
     {
         printf("\n");
         for(int j=0;j<v;j++)
            printf("%d\t",cost[i][j]);
     }
    int parent[v],dist[v],a,b,visited[v],count,min,next;
    for(int i=0;i<v;i++)
    {
        dist[i]=cost[s][i];
        parent[i]=s;
        visited[i]=0;
    }
    dist[s]=0;
    visited[s]=1;
    count=1;
    while(count<v-1)
    {
        min=999;
        for(int i=0;i<v;i++)
        {
            if(dist[i]<min&&visited[i]==0)
            {
                 min=dist[i];
                 next=i;
            }
        }
        for(int i=0;i<v;i++)
        {
            if(visited[i]==0&&dist[next]+cost[next][i]<dist[i])
            {
                dist[i]=dist[next]+cost[next][i];
                parent[i]=next;
            }
        }
        visited[next]=1;
        count++;
    }
    for(int i=0;i<v;i++)
    {
        if(i!=s)
            printf("\nNode:%d\tDistance:%d\tVia:<-%d",i,dist[i],i);
        int j=i;
        while(j!=s)
        {
            j=parent[j];
            printf("<-%d",j);
        }
    }
}

void main()
{
     printf("Enter vertices:");
     int v;
     scanf("%d",&v);
     printf("\nEnter source:");
     int s;
     scanf("%d",&s);
     printf("Enter graph in matrix form(999 for no link):\n");
     int g[10][10];
     for(int i=0;i<v;i++)
     {
         for(int j=0;j<v;j++)
            scanf("%d",&g[i][j]);
     }
     djikstra(v,s,g);
}
