# Le Jardin des Langues - Quiz Mandarin HSK 🇨🇳

Application Garmin Connect IQ pour apprendre le vocabulaire mandarin des niveaux HSK 1 et 2 sur votre montre Fenix 8.

## 📱 Fonctionnalités

### Version 1.2 - Implémentée ✅
- ✅ **Écran d'accueil avec menu** : Choisissez votre type de quiz
- ✅ **Quiz Normal (Hanzi → Français)** : Voir un caractère chinois et trouver sa traduction
- ✅ **Quiz Inversé (Français → Hanzi)** : Voir un mot français et trouver le bon caractère chinois
- ✅ **Afficher/Cacher le Pinyin** : Bouton MENU pour basculer l'affichage du pinyin pendant le quiz (état conservé) 🆕
- ✅ **Quiz à choix multiples** : 4 options de réponse par question
- ✅ **Vocabulaire complet HSK 1 & 2** : ~300 mots avec caractères chinois, pinyin et traductions françaises
- ✅ **Affichage des hanzi** : Les polices système de Garmin affichent correctement les caractères chinois sur Fenix 8
- ✅ **Feedback visuel immédiat** : Fond vert pour bonne réponse, rouge pour mauvaise réponse
- ✅ **Affichage du pinyin** : Aide à la prononciation sous les caractères chinois
- ✅ **Score en temps réel** : Suivi de vos bonnes réponses
- ✅ **Navigation intuitive** : Utilisation des boutons de la montre ou écran tactile
- ✅ **Anti-répétition** : Évite de proposer les mêmes mots trop rapidement

### Fonctionnalités Futures (v2.0+)
- 🔜 Statistiques détaillées de progression
- 🔜 Mode révision des mots difficiles
- 🔜 Exemples de phrases en contexte
- 🔜 Filtrage par niveau HSK (1 ou 2)
- 🔜 Système de répétition espacée (SRS)

## 🎮 Utilisation

### Menu Principal
Au lancement, vous verrez un écran d'accueil avec 2 options :
1. **Quiz Normal** : 汉字 → Français (voir hanzi, trouver traduction)
2. **Quiz Inversé** : Français → 汉字 (voir français, trouver hanzi)

**Navigation du menu** :
- **Bouton UP/DOWN** : Choisir une option
- **Bouton SELECT** ou **Clic tactile** : Lancer le quiz sélectionné

### Contrôles du Quiz
- **Bouton UP (Haut)** : Option précédente
- **Bouton DOWN (Bas)** : Option suivante
- **Bouton SELECT/START** : Valider la réponse sélectionnée
- **Clic sur la zone du pinyin (haut de l'écran)** : Afficher/Cacher le pinyin 🆕
- **Clic tactile sur une option** : Sélectionner et valider directement cette option
- **Bouton BACK** : Retourner au menu de sélection

### Comment jouer

#### Option Pinyin (v1.2+) 🆕
À tout moment pendant le quiz, vous pouvez **cliquer sur la zone du pinyin** (en haut de l'écran) pour :
- **Cacher le pinyin** : Si vous voulez un défi plus difficile
- **Afficher le pinyin** : Si vous avez besoin d'aide pour la prononciation

Quand le pinyin est caché, l'indicateur `[Tap: Pinyin]` s'affiche pour vous rappeler comment le réafficher.

**Votre choix est conservé** : Si vous cachez le pinyin, il restera caché pour toutes les questions suivantes jusqu'à ce que vous le réaffichiez.

#### Quiz Normal (Hanzi → Français)
1. Lancez l'application sur votre Fenix 8
2. Sélectionnez "Quiz Normal" dans le menu
3. Un caractère chinois (hanzi) s'affiche avec son pinyin
4. **Deux façons de répondre** :
   - **Navigation** : UP/DOWN pour sélectionner, SELECT pour valider
   - **Tactile** : Cliquer directement sur l'option désirée (sélection + validation instantanée)
5. Un feedback visuel s'affiche :
   - **Vert** ✓ : Bonne réponse !
   - **Rouge** ✗ : Mauvaise réponse (la correction s'affiche)
6. Appuyez à nouveau sur SELECT (ou cliquez sur l'écran) pour passer au mot suivant

#### Quiz Inversé (Français → Hanzi)
1. Sélectionnez "Quiz Inversé" dans le menu
2. Un mot en français s'affiche avec le pinyin entre parenthèses (indice)
3. Choisissez le bon caractère chinois parmi 4 options
4. Le feedback affiche le hanzi + pinyin en cas d'erreur

## 🏗️ Architecture Technique

### Structure du Projet
```
Language/
├── source/
│   ├── LanguageApp.mc          # Point d'entrée de l'application
│   ├── MenuView.mc             # Écran d'accueil avec choix du mode ⭐ NEW
│   ├── MenuDelegate.mc         # Gestion du menu d'accueil ⭐ NEW
│   ├── LanguageView.mc         # Interface graphique du quiz
│   ├── LanguageDelegate.mc     # Gestion des interactions utilisateur
│   ├── QuizModel.mc            # Logique du quiz (questions, réponses, score)
│   ├── VocabularyData.mc       # Base de données des 300 mots HSK
│   └── LanguageMenuDelegate.mc # Gestion du menu
├── resources/
│   ├── strings/strings.xml     # Textes de l'interface
│   ├── drawables/              # Icônes et images
│   └── menus/menu.xml          # Menus
├── docs/                       # Documentation du projet
├── manifest.xml                # Configuration de l'application
├── monkey.jungle               # Configuration du build
└── README.md                   # Ce fichier
```

### Technologies
- **Langage** : Monkey C (Connect IQ SDK)
- **Plateforme cible** : Garmin Fenix 8 47mm (et compatibles)
- **Version SDK minimale** : 5.2.0
- **Taille du vocabulaire** : 300 mots (150 HSK 1 + 150 HSK 2)

## 📚 Contenu Pédagogique

### Vocabulaire HSK 1 (150 mots)
Mots de base pour conversations simples :
- Pronoms, nombres, jours, heures
- Famille, métiers, pays
- Actions courantes (manger, boire, aller, venir...)
- Objets du quotidien

### Vocabulaire HSK 2 (150 mots)
Extension du vocabulaire pour conversations quotidiennes :
- Adjectifs descriptifs (couleurs, tailles, sensations)
- Verbes d'action supplémentaires
- Vocabulaire lié aux activités (sport, loisirs)
- Expressions de temps et de lieu

## ️ Développement

### Prérequis
- Garmin Connect IQ SDK (version 7.0+)
- Visual Studio Code avec extension Monkey C
- Garmin Fenix 8 ou simulateur

### Compilation
```bash
# Via VS Code
Ctrl+Shift+B

# Via ligne de commande
monkeyc -o bin/Language.prg -f monkey.jungle -d fenix847mm -w
```

### Test sur Simulateur
```bash
# Lancer le simulateur
monkeydo bin/Language.prg fenix847mm
```

### Installation sur Montre
1. Compiler l'application en mode Release
2. Copier `bin/Language.prg` sur la montre via Garmin Express
3. Ou publier sur Connect IQ Store

## 🎯 Logique du Quiz

### Génération des Questions
1. **Sélection aléatoire** : Un mot est choisi parmi les 300 disponibles
2. **Anti-répétition** : Les 20 derniers mots sont mémorisés et évités
3. **Génération des distracteurs** : 3 traductions incorrectes sont choisies aléatoirement
4. **Mélange** : Les 4 options sont mélangées aléatoirement

### Système de Score
- **Score** : Nombre de bonnes réponses
- **Total** : Nombre de questions posées
- **Affichage** : Format "Score/Total" en bas de l'écran

## 📊 Données de Vocabulaire

Chaque mot contient :
- **hanzi** : Caractères chinois (ex: "你好")
- **pinyin** : Prononciation romanisée avec tons (ex: "nǐ hǎo")
- **traduction** : Traduction française (ex: "bonjour")
- **hskLevel** : Niveau HSK (1 ou 2)

Exemple :
```monkeyc
["你好", "nǐ hǎo", "bonjour", 1]
```

## 🐛 Problèmes Connus

- La taille de police des caractères chinois est fixe (pas d'adaptation automatique)
- Le linter VS Code peut afficher des erreurs sur `fonts.xml` et le chargement de police (faux positifs - l'application fonctionne correctement sur la montre)

## 🚀 Roadmap

### Version 1.3
- Statistiques de session (taux de réussite)
- Amélioration de l'interface (polices adaptatives)
- Paramètres personnalisables

### Version 2.0
- Persistance des données (sauvegarde du score)
- Historique des mots difficiles
- Mode révision ciblée
- Filtrage par niveau HSK

### Version 3.0
- Mode inverse (français → mandarin)
- Exemples de phrases en contexte
- Système de répétition espacée (SRS)
- Graphiques de progression

## 📝 Licence

Ce projet est développé à des fins éducatives.

## 👤 Auteur

Développé avec ❤️ pour les apprenants de mandarin qui veulent réviser n'importe où, n'importe quand, directement depuis leur montre Garmin !

## 🙏 Remerciements

- Vocabulaire basé sur les listes officielles HSK (Hanyu Shuiping Kaoshi)
- Police Noto Sans SC de Google Fonts (SIL Open Font License)
- Communauté Connect IQ pour la documentation et les exemples

---

**Bon apprentissage ! 加油！(jiā yóu - courage !)**
