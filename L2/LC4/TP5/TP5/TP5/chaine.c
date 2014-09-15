//
//  chaine.c
//  TP5
//
//  Created by Etienne Toussaint on 26/02/2014.
//  Copyright (c) 2014 Etienne Toussaint. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#import "chaine.h"

struct str_s{
    char c;
    struct str_s *next;
};

void str_print(str_s *s){
    printf("%c",s->c);
    if(s->next != NULL)
    {
        str_print(s->next);
    }
}

str_s* str_init(const char* s){
    str_s *result  = malloc(sizeof(str_s));
    if (result == NULL) // On vérifie si la mémoire a été allouée
    {
        exit(0); // Erreur : on arrête tout !
    }
    result->c = *s;
    if(*(s+1)!='\0'){
        result->next = str_init(s+1);
    }
    return result;
}

void str_free(str_s *s){
    if(s->next != NULL)
    {
        str_free(s->next);
    }
    free(s);
}

str_s* str_scan(){
    str_s *result= malloc(sizeof(str_s));
    if (result == NULL) // On vérifie si la mémoire a été allouée
    {
        exit(0); // Erreur : on arrête tout !
    }
    result->c = fgetc(stdin);
    if(result->c != '\n'){
        result->next = str_scan();
    }
    else{
        return NULL;
    }
    return result;
}

str_s* str_concat(str_s* s1,str_s *s2){
    str_s *temp = s1;
    while(temp->next != NULL){
        temp = temp->next;
    }
    temp->next = s2;
    return s1;
}

str_s* str_cpy(str_s* s){
    str_s *result= malloc(sizeof(str_s));
    if (result == NULL) // On vérifie si la mémoire a été allouée
    {
        exit(1); // Erreur : on arrête tout !
    }
    str_s *resultat = result;
    while(s != NULL){
        result->c = s->c;
        result->next = malloc(sizeof(str_s));
        if (result == NULL) // On vérifie si la mémoire a été allouée
        {
            exit(EXIT_FAILURE); // Erreur : on arrête tout !
        }
        result = result->next;
        s = s->next;
    }
    str_free(result);
    result = NULL;
    return resultat;
}

