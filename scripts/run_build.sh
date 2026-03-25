#!/bin/bash
# ce script est à lancer depuis la racine du projet
# il va construire l'image docker et la tagger avec le nom "partacheur:latest"

set -a
source .env
set +a

# vérification que les variables d'environnement nécessaires sont définies
check_env_var() {
    if [ -z "$1" ]; then
        echo "Erreur: La variable d'environnement $1 doit être définie."
        exit 1
    fi
}

check_env_var "$POSTGRES_PWD" 
check_env_var "$POSTGRES_USER" 
check_env_var "$POSTGRES_DB" 
check_env_var "$POSTGRES_HOST" 
check_env_var "$POSTGRES_PORT" 

# build de l'image docker avec les variables d'environnement pour le build
docker build \
  --build-arg POSTGRES_PWD=$POSTGRES_PWD \
  --build-arg POSTGRES_USER=$POSTGRES_USER \
  --build-arg POSTGRES_DB=$POSTGRES_DB \
  --build-arg POSTGRES_HOST=$POSTGRES_HOST \
  --build-arg POSTGRES_PORT=$POSTGRES_PORT \
  -t partacheur:latest .