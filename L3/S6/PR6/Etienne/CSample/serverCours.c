#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <errno.h>
#include <unistd.h>
#include <string.h>
#include <sys/socket.h>
#include <netdb.h>

int main(int argc, char const *argv[]) {
  //Variable pour les retour et erreur
  int retour = 0;
  //Socket Server IPV4
  int sockServer = socket(PF_INET,SOCK_STREAM,0);
  struct sockaddr_in address_sock;

  address_sock.sin_family=AF_INET;
  address_sock.sin_port=htons(4202);
  //Adresse quelqu'onque car localHost
  address_sock.sin_addr.s_addr=htonl(INADDR_ANY);

  //Fonction liant la socket a un port de la machine lui fournir un nom
  retour = bind(sockServer,(struct sockaddr *)&address_sock,sizeof(struct sockaddr_in));
  if(retour == -1){
    perror(strerror(errno));
    exit(1);
  }
  //fonction lancant l'écoute par default 0 nombre de client en attente
  retour = listen(sockServer,0);
  if(retour == -1){
    perror(strerror(errno));
    exit(1);
  }

  while(42){
    //Stocke l'addresse de l'appelant
    struct sockaddr_in caller;
    //Doit être init sinon bug
    socklen_t size=sizeof(caller);

    int descSock=accept(sockServer,(struct sockaddr *)&caller,&size);
    if(retour == -1){
      perror(strerror(errno));
      continue;
    }
    char *mess="Yeah!\n";
    send(descSock,mess,strlen(mess)*sizeof(char),0);
    char buff[1024];
    int recu=recv(descSock,buff,1023*sizeof(char),0);
    buff[recu]='\0';
    printf("Message recu : %s\n",buff);
    close(descSock);
  }
  close(sockServer);
  return 0;
}
