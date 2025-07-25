# Love2D Game Building Blocks
---

Ce dépôt GitHub est une collection d'exemples de code, de jeux et de modules en Lua, conçus comme des briques qui représentent des concepts fondamentaux de la création de jeux 2D avec le framework Love2D.

---

## Concept

Créer un jeu est comme assembler des pièces de Lego. Chaque jeu est construit à partir de concepts de base comme les mouvements du joueur, les collisions, les tilesets constituant les cartes de mondes, l'affichage des divers éléments, etc.

Ce dépôt a pour but de décomposer les concepts de base des jeux vidéo en briques ou blocs de construction réutilisables et faciles à comprendre.

---

## Structure

Chaque dossier de ce dépôt contient soit :

* Un petit jeu représentant un concept ou un ensemble de concepts.
* Un concept de base de création de jeux vidéo, souvent sous forme de module autonome.

Voici des exemples de dossiers que vous trouverez :

* **`Basic-collision`** : Contient un jeu de base illustrant les collisions AABB (Axis-Aligned Bounding Box).
* **`Basic-collision-with-velocity`** : Basé sur `Basic-collision`, cet exemple ajoute la vélocité du joueur et adapte la détection des collisions pour une interaction plus réaliste.
* **`Basic-little-platformer`** : Petit jeu avec des mouvements du joueur utilisant la vélocité pour la physique. **Attention**, la vitesse des mouvements peut varier selon l'ordinateur exécutant ce code. La friction n'a pas de correction du delta time et la technique du fixed step utilisée dans le jeu Platformer-with-fixed-step-and-asymmetric-jumps.
* **`Basic-map-navigation`** : Cartes (maps) de niveaux de jeu fixes (une carte par écran) avec des portails pour naviguer entre les cartes et dans les deux sens. Séparation du code des portails des tuiles de collision dans les fichiers (maps) permettant de géer les portails et tuiles séparément. 
* **`Basic-space-invaders-like`** : Un mini-jeu de tir vertical pour démontrer des mécaniques de gameplay simples.
* **`Driver-test`** : Un petit jeu de conduite incluant le défilement continu du décor, des collisions, et des effets de particules. (Note : Ce jeu a été en grande partie développé avec l'aide de ChatGPT.)
* **`Jeu les confins ...`** : Basé sur le code du jeu "Platformer-with-fixed-step-and-asymmetric-jumps". Commencer à tester les mouvements de la physique du jeu et de les comparer sur diverses machines. Continuer d'ajouter des nouvelles fonctionnalités selon un thème et une histoire et ajouter des éléments graphiques plus fidèles à la vision du jeu.
* **`Platformer-with-fixed-step-and-asymmetric-jumps`** : Jeu recommencé depuis le début et emprunt de bouts de code des autres dossiers. Petit jeu de plateforme avec des niveaux de jeu fixes et navigation entre les niveaux. Ajout de la vélocité pour les mouvements du joueur, collisions, détection du sol, sauts asymétriques (monté plus lente que la descente), coyote time, et des réparations liées aux fonctionnalités ajoutées etc.

---

## Pré-requis

Pour utiliser ce dépôt, vous aurez besoin de :

* **Love2D** : Installez la version 11.5 (compatible avec ce dépôt). Vous pouvez la télécharger depuis le [site officiel de Love2D](https://love2d.org/).
* **Un éditeur de code** : Utilisez l'éditeur de votre choix (comme [ZeroBrane Studio Lua IDE](http://studio.zerobrane.com/) ou [Microsoft Visual Studio Code](https://code.visualstudio.com/)).

---

## Comment utiliser ce dépôt

1.  **Cloner le dépôt** :
    Ouvrez votre terminal ou invite de commande et exécutez la commande suivante :
    ```bash
    git clone [https://github.com/VotreNomUtilisateur/Love2D-Game-Building-Blocks.git](https://github.com/VotreNomUtilisateur/Love2D-Game-Building-Blocks.git)
    ```
    N'oubliez pas de remplacer `VotreNomUtilisateur` par votre nom d'utilisateur GitHub réel. Cette commande créera un nouveau dossier contenant tous les modules et exemples du dépôt.

2.  **Exécuter un exemple** :
Chaque dossier représente un module ou un petit jeu indépendant. Pour exécuter un exemple, vous avez deux options :

### Via votre éditeur de code (recommandé)

La plupart des éditeurs de code (comme **Visual Studio Code** avec l'extension Lua, ou **ZeroBrane Studio**) permettent de configurer un "lanceur" ou un "débogueur" pour les projets Love2D.

* **Ouvrez le dossier de l'exemple** : Dans votre éditeur, ouvrez directement le dossier du concept ou du jeu que vous souhaitez lancer (par exemple, ouvrez le dossier `Basic-collision`).
* **Lancez le projet** : Utilisez la fonctionnalité d'exécution de votre éditeur pour lancer un projet Love2D. Cela se fait généralement en cliquant sur un bouton "Exécuter", "Lancer", ou en utilisant un raccourci clavier configuré (souvent `F5` ou `Ctrl+F5`) qui pointera Love2D vers le dossier ouvert.

### Via l'invite de commande / terminal

Si vous préférez la ligne de commande ou si votre éditeur n'est pas configuré :

* Naviguez dans le dossier de l'exemple choisi via votre terminal (par exemple, `cd Love2D-Game-Building-Blocks/Basic-collision`).
* Une fois dans le dossier de l'exemple, lancez-le avec Love2D :
    ```bash
    love .
    ```
Assurez-vous que **Love2D est bien installé et accessible via votre PATH** pour que la commande `love` fonctionne directement.

Vous pouvez ensuite explorer le code avec l'éditeur de votre choix et le modifier à votre guise.

## Crédits
Crédits des Assets pour Driver-Test
Tous les assets suivants sont sous licence CC0 (domaine public), sauf indication contraire.

Vary Car Pack 1 par Vary (https://opengameart.org/content/vary-car-pack-1)
2D Top Down Highway Background par Surt (https://opengameart.org/content/2d-top-down-highway-background)
HD River Rock Pack par Ragewortt (https://opengameart.org/content/hd-river-rock-pack)
Pixel Wooden Crate par artisticdude (https://opengameart.org/content/pixel-wooden-crate)
Les assets de yurinikolai proviennent de OpenGameArt.org (https://opengameart.org/users/yurinikolai). 
Pour les détails de licence spécifiques à ces assets, veuillez vous référer au fichier readme situé dans 
le dossier des images du jeu.