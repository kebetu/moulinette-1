# moulinette.sh

Pour utiliser le script il faut donner en argument l'exécutable du projet a tester.
La liste de test est a remplir comme dans l'exemple suivant

test[1]="premier test"
test[2]="second test"
test[3]=..

et ainsi de suite ces tests sont l'équivalent des arguments que vous enverrez à votre programme

par exemple :
test[1]="test"
test[2]="lapin"

./moulinette.sh my_putstr | la moulinette va tester :
./my_putstr "test"
./my_putstr "lapin"

Il existe 4 sortie possible en rapport avec l'exécution
1 - Le timeout défini dans la configuration de moulinette.sh qui considére votre programme en boucle inf.
2 - Le crash équivalent a un segfault ou tout autre signal pas cool
3 - L'error handled qui signifie que vous avez geré ce cas comme une erreur -> valeur de retour = 84
4 - Le completed qui signifie que l'exécutable est arrivé jusqu'au bout et a return un nombre correct

Les sorties 1 et 2 sont considérées comme un test [KO]
Les sorties 3 et 4 sont considérées comme un test [OK]

Bon tests à vous !