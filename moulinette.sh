#!/bin/bash

# Message d'utilisation.

if [ $# = 0 ]
then
    echo "Usage : ./moulinette.sh 'Nom du projet'"
    echo "Ouvrez moulinette.sh pour configurer vos tests."
    exit 0
fi


# Configuration de la moulinette de test.

# A ne pas modifier !
projet=$1
repertoire=`pwd`

# A configurer.
# time -> temps à attendre avant de considérer un timeout.
time=5s
# test_to_do -> nombre de tests a effectuer.
test_to_do=2


# Configuration de l'exécutable a ne pas modifier.
try="timeout $time $repertoire/$projet"


# Configuration des tests.

test[1]=""
test[2]="game-tiles/pos1"


# Test du programme

make clean
make
clear
echo "Compilation du projet :"
if [ -e $projet ] && [ -x $projet ]
then
    echo -e "[\033[32mOK\033[0m]"
else
    echo -e "[\033[31mKO\033[0m]"
    exit 84
fi

let "test_to_do += 1"
nb_test=1
while [ $nb_test -ne $test_to_do ]
do
    echo ""
    echo "Test -" $nb_test
    $try ${test[$nb_test]}
    return=`echo $?`
    echo "Argument" ${test[$nb_test]} ":"
    if [ $return = 124 ]
    then
	echo -e "[\033[33mTimeout\033[0m]"
	echo -e ${test[$nb_test]} ": [\033[31mKO\033[0m]"
    elif [ $return = 139 ]
    then
	echo -e "[\033[31mCrashed\033[0m]"
	echo -e ${test[$nb_test]} ": [\033[31mKO\033[0m]"
    elif [ $return = 84 ]
    then
	echo -e "[\033[32mError handled\033[0m]"
	echo -e ${test[$nb_test]} ": [\033[32mOK\033[0m]"
    else
	echo -e "[\033[32mTerminated\033[0m]"
	echo -e ${test[$nb_test]} ": [\033[32mOK\033[0m]"
    fi
    let "nb_test += 1"
done
exit 0
