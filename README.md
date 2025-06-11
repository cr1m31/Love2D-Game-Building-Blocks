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
* **`Basic-space-invaders-like`** : Un mini-jeu de tir vertical pour démontrer des mécaniques de gameplay simples.
* **`Driver-test`** : Un petit jeu de conduite incluant le défilement continu du décor, des collisions, et des effets de particules. (Note : Ce jeu a été en grande partie développé avec l'aide de ChatGPT.)

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