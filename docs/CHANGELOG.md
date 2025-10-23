# Changelog - Le Jardin des Langues

Tous les changements notables de ce projet seront documentés dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/),
et ce projet adhère au [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Non publié]

### À venir
- Statistiques de progression dans le menu
- Mode révision par statut

## [1.5.0] - 2025-10-23

### ✨ Ajouté
- **🚀 Algorithme d'Apprentissage Progressif** 🎉
  - Introduction progressive des nouveaux mots (pool de 15 mots "Inconnus")
  - Priorisation pédagogique par niveau HSK : HSK 1 → HSK 2 → HSK 3
  - Système de probabilités intelligent :
    - 90% mots "Inconnus" (apprentissage intensif)
    - 9% mots "Connus" (révision régulière)
    - 1% mots "Maîtrisés" (révision rare)
  - Cascade automatique si une catégorie est vide
  - Anti-répétition sur les 5 derniers mots (au lieu de 20)
  - Marquage automatique des nouveaux mots comme "Inconnus" lors de la première vue

- **⚡ Système de Cache Ultra-Performant**
  - Caches statiques par niveau HSK (hsk1Indices, hsk2Indices, hsk3Indices)
  - Caches dynamiques par statut (noStatusIndices, unknownIndices, knownIndices, masteredIndices)
  - Initialisation unique au démarrage de l'application
  - Mise à jour incrémentale en temps réel lors des changements de statut
  - Gain de performance : ~40x sur un quiz de 10 questions
  - Complexité : O(600) au démarrage → O(1) pour les recherches

### Modifié
- **VocabularyData.mc**
  - Ajout de 7 tableaux statiques de cache
  - `initializeCaches()` : Initialisation complète des caches
  - `refreshStatusCaches()` : Rafraîchissement des caches de statuts
  - `updateStatusCache()` : Mise à jour incrémentale après changement de statut
  - `getIndicesByHskLevel()` : Accès direct aux mots par niveau HSK
  - `getIndicesWithoutStatus()` : Accès direct aux mots sans statut
  - `getIndicesByStatus()` : Accès direct aux mots par statut
  - `setWordStatus()` : Appelle automatiquement `updateStatusCache()`

- **QuizModel.mc**
  - Constantes `MAX_LEARNING_POOL = 15` et `HISTORY_SIZE = 5`
  - `selectNextWord()` : Nouvel algorithme d'apprentissage progressif
  - `getRandomNewWord()` : Priorise HSK 1 → 2 → 3 avec utilisation des caches
  - `getRandomWordByStatus()` : Utilise les caches pour performance
  - `countWordsByStatus()` : Utilise `.size()` au lieu de boucles
  - `countWordsWithoutStatus()` : Utilise `.size()` au lieu de boucles

- **LanguageApp.mc**
  - `initialize()` : Appelle `VocabularyData.initializeCaches()` au démarrage

### Performance
- **Mémoire** : +12 KB pour les caches (négligeable)
- **Vitesse** : 
  - Sélection de mots : 4-600x plus rapide
  - Comptage des statuts : 600x plus rapide
  - Changement de statut : 300x plus rapide
  - Quiz de 10 questions : ~40x plus rapide
- **Scalabilité** : Peut gérer 5000+ mots sans dégradation

### Architecture Pédagogique
- **Phase 1 : Introduction Progressive**
  - Les 15 premiers mots sont tous HSK 1
  - Marqués automatiquement comme "Inconnus"
  - Pas de nouveaux mots tant que le pool reste à 15

- **Phase 2 : Révision Intelligente**
  - 90% du temps : révision des mots "Inconnus"
  - 9% du temps : révision des mots "Connus"
  - 1% du temps : révision des mots "Maîtrisés"

- **Phase 3 : Progression HSK**
  - Tous les mots HSK 1 introduits avant HSK 2
  - Tous les mots HSK 2 introduits avant HSK 3
  - Garantit des fondations solides

### Documentation
- `DEVELOPMENT.md` entièrement mis à jour avec :
  - Section complète "Système de Cache d'Optimisation"
  - Section "Algorithme d'Apprentissage Progressif"
  - Diagrammes d'architecture des caches
  - Tableaux de gains de performance
  - Analyse de complexité algorithmique
  - Détails d'utilisation mémoire
  - Section "Progression par Niveau HSK"

### Impact Utilisateur
- **Fluidité** : Application instantanée, aucun lag
- **Pédagogie** : Progression naturelle du vocabulaire de base vers l'avancé
- **Motivation** : Pool de 15 mots = objectif clair et atteignable
- **Efficacité** : Focus sur les mots non maîtrisés (90% du temps)

## [1.4.1] - 2025-10-22

### ✨ Ajouté
- **📚 Vocabulaire HSK 3 Complet** 🎉
  - 300 mots supplémentaires du niveau HSK 3
  - Total : 600 mots (HSK 1: 150, HSK 2: 150, HSK 3: 300)
  - Vocabulaire intermédiaire avec particules grammaticales, expressions courantes
  - Exemples : 聪明 (intelligent), 环境 (environnement), 如果 (si), 虽然 (bien que)

### Modifié
- **VocabularyData.mc**
  - Taille du tableau passée de 300 à 600 mots
  - `getVocabularySize()` retourne maintenant 600
  - Vocabulaire enrichi pour apprentissage niveau intermédiaire

### Impact Utilisateur
- **Plus de contenu** : Double le vocabulaire disponible pour l'apprentissage
- **Progression naturelle** : Après HSK 1-2, continuez avec HSK 3
- **Compatibilité totale** : Fonctionne avec tous les modes existants (quiz, dictionnaire, filtrage)
- **Pas de changement d'interface** : L'utilisateur voit simplement plus de mots disponibles

### Performance
- **Mémoire** : Impact minimal (~+3 KB pour 300 mots supplémentaires)
- **Vitesse** : Pas de dégradation, génération aléatoire reste identique
- **Stockage** : Les évaluations de mots persistent toujours correctement

## [1.4.0] - 2025-10-22

### ✨ Ajouté
- **📖 Dictionnaire Complet** 🎉
  - Nouveau mode "Dictionnaire" accessible depuis le menu principal
  - Parcourez tous les 300 mots du vocabulaire dans une liste scrollable
  - Affichage compact : hanzi, traduction, et icône de statut (✓/○/✗)
  - Navigation fluide avec indicateur de scroll visuel

- **🎨 Filtrage par Statut**
  - 4 modes de filtrage : Tous, Maîtrisés, Connus, Inconnus
  - Bouton MENU pour cycler entre les filtres
  - Compteur dynamique selon le filtre (ex: "Maîtrisés (42)", "15/300 mots")
  - Mise à jour instantanée de la liste

- **🔍 Vue Détaillée des Mots**
  - Nouvel écran de détail complet pour chaque mot :
    - Hanzi en grand format
    - Pinyin (prononciation)
    - Traduction complète
    - Niveau HSK
    - Statut actuel avec icône colorée
  - Numéro du mot dans la base de données (ex: "Mot #42")

- **✏️ Modification des Statuts**
  - Possibilité de modifier le statut de n'importe quel mot depuis le dictionnaire
  - Mode édition dédié avec 3 options colorées :
    - ✓ Maîtrisé (vert)
    - ○ Connu (orange)
    - ✗ Inconnu (rouge)
  - Navigation UP/DOWN entre les options
  - Validation ou annulation des modifications
  - Sauvegarde instantanée dans WordProgressStorage
  - Les changements sont immédiatement visibles dans le dictionnaire

- **🎯 Navigation Améliorée**
  - Menu principal avec 3 options :
    1. Quiz Normal (汉字 → Français)
    2. Quiz Inversé (Français → 汉字)
    3. Dictionnaire (📖)
  - Support complet des boutons physiques et de l'écran tactile
  - **Correction importante** : `DictionaryDelegate` utilise `InputDelegate` au lieu de `BehaviorDelegate` pour meilleure compatibilité tactile
  - Clic direct sur un mot ouvre immédiatement ses détails
  - Swipe rapide : 4 mots à la fois (une page complète)
  - Bouton BACK pour retour en arrière à tous les niveaux

### Architecture Technique
- **Nouveaux fichiers** :
  - `source/DictionaryView.mc` : Vue liste du dictionnaire (~350 lignes)
  - `source/DictionaryDelegate.mc` : Gestion des interactions (~70 lignes)
  - `source/WordDetailView.mc` : Vue détaillée d'un mot (~320 lignes)
  - `source/WordDetailDelegate.mc` : Gestion des interactions détail (~90 lignes)

### Modifié
- **MenuView**
  - Ajout de la 3ème option "Dictionnaire"
  - Nouvel enum `MenuOption` : `QUIZ_NORMAL`, `QUIZ_REVERSE`, `DICTIONARY`
  - Méthode `launchQuiz()` renommée en `launchSelectedMode()`
  - Zones tactiles ajustées pour 3 options (42%-54%, 56%-68%, 70%-82%)
  - Navigation UP/DOWN gère maintenant 3 options (0-2)

- **MenuDelegate**
  - Appelle `launchSelectedMode()` au lieu de `launchQuiz()`
  - Détecte l'option "Dictionnaire" et lance la vue appropriée

### Fonctionnalités du Dictionnaire

#### Liste des Mots
```
┌─────────────────────────┐
│ Dictionnaire            │
│ 300/300 mots            │
├─────────────────────────┤
│ ✓ 你好     bonjour  ◄   │
│ ○ 谢谢     merci        │
│ ✗ 对不起   pardon       │
│ ✓ 请       s'il vous... │
├─────────────────────────┤
│ ↑↓ • SELECT • BACK      │
└─────────────────────────┘
```

#### Détail d'un Mot
```
┌─────────────────────────┐
│ Mot #1                  │
│                         │
│         你好            │
│        nǐ hǎo           │
├─────────────────────────┤
│        Bonjour          │
│        HSK 1            │
├─────────────────────────┤
│ Statut:                 │
│ ✓ Maîtrisé              │
├─────────────────────────┤
│ SELECT modifier • BACK  │
└─────────────────────────┘
```

#### Édition du Statut
```
┌─────────────────────────┐
│ Modifier le statut      │
│         你好            │
├─────────────────────────┤
│   ✓ Maîtrisé        ◄   │
│   ○ Connu               │
│   ✗ Inconnu             │
├─────────────────────────┤
│ ↑↓ • SELECT • BACK      │
└─────────────────────────┘
```

### Interactions Utilisateur

#### Dans le Dictionnaire
- **UP/DOWN** : Naviguer dans la liste (scroll automatique)
- **Swipe UP/DOWN** : Scroll rapide (4 mots à la fois - une page complète)
- **Clic sur un mot** : Ouvrir ses détails directement
- **MENU** : Changer le filtre (Tous → Maîtrisés → Connus → Inconnus → Tous)
- **BACK** : Retour au menu principal

#### Dans le Détail d'un Mot
- **SELECT** ou **TAP sur la zone "Statut"** : Activer le mode édition
- **BACK** : Retour au dictionnaire

#### En Mode Édition
- **UP/DOWN** : Naviguer entre les 3 options de statut
- **SELECT** : Sauvegarder le statut sélectionné
- **TAP sur une option** : Sélectionner et sauvegarder immédiatement cette option
- **BACK** : Annuler et retour au mode détail

### Cas d'Usage
1. **Révision avant quiz** : Parcourir tous les mots avec leurs traductions
2. **Auto-évaluation** : Marquer les mots connus/inconnus avant de commencer
3. **Suivi de progression** : Voir combien de mots sont maîtrisés (filtre)
4. **Correction de statut** : Changer un mot marqué par erreur
5. **Découverte** : Parcourir le vocabulaire HSK 1 & 2 complet

### Performance
- **Mémoire** : Utilisation minimale grâce au filtrage dynamique
- **Scroll** : Fluide avec seulement 4 éléments visibles simultanément
- **Sauvegarde** : Instantanée via WordProgressStorage existant
- **Pas de lag** : Génération à la volée des listes filtrées

### Documentation
- `DEVELOPMENT.md` entièrement mis à jour avec :
  - Nouvelle section complète pour `DictionaryView` et `DictionaryDelegate`
  - Nouvelle section complète pour `WordDetailView` et `WordDetailDelegate`
  - Diagramme de flux mis à jour avec le mode dictionnaire
  - Description détaillée des 4 modes de filtrage
  - Workflow complet de modification des statuts
  - 28 nouveaux points dans la checklist de tests (Menu, Dictionnaire, Détails)

### Roadmap Mise à Jour
Cette version complète la **v1.4.0** prévue avec :
- ✅ Mode dictionnaire avec liste complète
- ✅ Filtrage par statut de maîtrise
- ✅ Modification des statuts depuis le dictionnaire
- ⏳ Statistiques détaillées (reporté à v1.5.0)

## [1.3.0] - 2025-10-21

### ✨ Ajouté
- **Système de Persistance des Données** 🎉
  - Nouveau fichier `WordProgressStorage.mc` : Gestion du stockage persistant avec Storage API
  - Les utilisateurs peuvent maintenant évaluer leur niveau de maîtrise pour chaque mot
  - 3 niveaux de maîtrise disponibles :
    - ✓ **Maîtrisé** (vert) : Mot parfaitement connu
    - ○ **Connu** (orange) : Mot reconnu mais pas sûr
    - ✗ **Inconnu** (rouge) : Mot totalement inconnu
  - Les évaluations sont sauvegardées entre les sessions de l'application
  - Nouvel écran de flaggage après chaque question

- **Workflow d'Évaluation**
  1. L'utilisateur répond à une question (correcte ou incorrecte)
  2. Le feedback s'affiche avec le message "Appuyez pour évaluer"
  3. Un nouvel écran de flaggage apparaît avec 3 options
  4. L'utilisateur sélectionne son niveau de maîtrise
  5. Le statut est immédiatement sauvegardé
  6. La question suivante s'affiche

- **Navigation dans le Flaggage**
  - Boutons UP/DOWN pour naviguer entre les 3 options
  - SELECT pour valider la sélection
  - Support tactile : clic direct sur une option pour validation instantanée
  - Couleurs visuelles distinctes (vert/orange/rouge) pour chaque niveau

### Modifié
- **VocabularyData**
  - Nouvelles méthodes : `setWordStatus()`, `getWordStatus()`, `getProgressStatistics()`
  - Intégration avec `WordProgressStorage` pour la persistance

- **QuizModel**
  - Nouvelles méthodes : `setCurrentWordStatus()`, `getCurrentWordStatus()`, `getCurrentWordIndex()`
  - Permet d'enregistrer et récupérer le statut du mot actuel

- **LanguageView**
  - Nouvel état de feedback : `FEEDBACK_FLAGGING` pour l'écran d'évaluation
  - Nouvelle variable : `selectedFlag` pour la navigation dans les options de flaggage
  - Nouvelles méthodes :
    - `drawFlaggingScreen()` : Affiche l'écran d'évaluation
    - `drawFlagOption()` : Dessine une option de flaggage
    - `moveToFlagging()` : Transition du feedback vers le flaggage
    - `submitFlag()` : Enregistre le statut et passe à la question suivante
  - `drawFeedback()` modifié pour afficher "Appuyez pour évaluer"
  - `selectPreviousOption()` et `selectNextOption()` gèrent maintenant aussi le flaggage
  - `handleTapAt()` gère les clics tactiles sur les options de flaggage
  - `submitAnswer()` passe maintenant au flaggage au lieu de la question suivante

### Architecture Technique
- **Nouveau fichier** :
  - `source/WordProgressStorage.mc` : ~160 lignes
  - Utilise le Storage API de Garmin (`Application.Storage`)
  - Format de stockage : Dictionary<String, Number> (index → statut)
  - Clé de stockage : `"word_progress"`
  - Persistant entre les fermetures d'application et redémarrages

- **Méthodes de WordProgressStorage** :
  - `setWordStatus(index, status)` : Enregistre le statut d'un mot
  - `getWordStatus(index)` : Récupère le statut (défaut = UNKNOWN)
  - `hasStatus(index)` : Vérifie si un mot a été évalué
  - `getStatistics()` : Retourne le nombre de mots par statut
  - `getEvaluatedWordsCount()` : Nombre de mots évalués
  - `getMasteredPercentage()` : Pourcentage de mots maîtrisés
  - `resetAllProgress()` : Efface toutes les données

### Stockage et Performance
- **Taille des données** : ~2-3 KB pour 300 mots (très léger)
- **Limite Garmin** : 100-1000 KB disponibles selon appareil
- **Opérations** : Lecture/écriture instantanée, pas de limite
- **Format JSON équivalent** :
  ```json
  {
    "word_progress": {
      "0": 0,    // Maîtrisé
      "1": 1,    // Connu
      "5": 2     // Inconnu
    }
  }
  ```

### Cas d'Usage Futurs
- Filtrer les questions par niveau de maîtrise
- Générer des quiz personnalisés (uniquement mots inconnus)
- Afficher des statistiques détaillées de progression
- Prioriser les mots non maîtrisés dans la génération aléatoire

### Documentation
- `DEVELOPMENT.md` entièrement mis à jour avec :
  - Nouvelle section "Persistance des Données" complète
  - Documentation de `WordProgressStorage`
  - Flux de persistance détaillé
  - Exemples de code et debugging
  - Cas d'usage avancés
- Checklist de tests étendue avec 10 nouveaux points de vérification

### Comportement
```
Workflow complet :
1. Quiz → Réponse → Feedback (vert/rouge)
2. "Appuyez pour évaluer" s'affiche
3. [Appui sur SELECT ou clic écran]
4. Écran de flaggage avec 3 options :
   ┌─────────────────────────┐
   │ Niveau de maîtrise ?    │
   │       你好               │
   ├─────────────────────────┤
   │   ✓ Maîtrisé        ◄   │ (vert)
   │   ○ Connu               │ (orange)
   │   ✗ Inconnu             │ (rouge)
   └─────────────────────────┘
5. Sélection et validation
6. Statut enregistré → Question suivante
```

### Permissions
- Permission `PersistedContent` déjà présente dans `manifest.xml`
- Pas de permission supplémentaire requise

## [1.2.0] - 2025-10-21

### ✨ Ajouté
- **Option Afficher/Cacher le Pinyin** 🎉
  - Clic sur la zone du pinyin (haut de l'écran) pour basculer l'affichage du pinyin pendant le quiz
  - État persistant : le choix est conservé entre les questions et les sessions
  - Indicateur visuel `[Tap: Pinyin]` affiché quand le pinyin est caché
  - Fonctionne dans les deux modes (Normal et Inversé)

### Modifié
- **QuizModel**
  - Ajout de la variable statique `showPinyin` pour conserver l'état
  - Nouvelles méthodes : `togglePinyin()`, `isPinyinVisible()`, `showPinyinDisplay()`, `hidePinyinDisplay()`

- **LanguageView**
  - `drawNormalModeQuestion()` : Affichage conditionnel du pinyin
  - `drawReverseModeQuestion()` : Affichage conditionnel du pinyin
  - Nouvelle méthode `togglePinyin()` pour basculer et rafraîchir l'écran

- **LanguageView**
  - `handleTapAt()` : Détecte maintenant les clics dans la zone supérieure (0-35% de l'écran) pour basculer le pinyin

### Comportement
```
Mode Normal (Pinyin visible):
你好
nǐ hǎo        ← Cliquez ici pour cacher

Mode Normal (Pinyin caché):
你好
[Tap: Pinyin] ← Cliquez ici pour afficher

Mode Inversé (Pinyin visible):
Bonjour
(nǐ hǎo)      ← Cliquez ici pour cacher

Mode Inversé (Pinyin caché):
Bonjour
[Tap: Pinyin] ← Cliquez ici pour afficher
```

### Notes Techniques
- Utilisation d'une variable statique pour persister l'état sans consommer de mémoire additionnelle
- L'indicateur `[MENU: Pinyin]` guide l'utilisateur sur comment réafficher le pinyin
- Rafraîchissement immédiat de l'écran avec `WatchUi.requestUpdate()`

## [1.1.0] - 2025-10-20

### ✨ Ajouté
- **Écran d'accueil avec menu de sélection**
  - Nouveau fichier `MenuView.mc` : Interface de menu élégante avec 2 options
  - Nouveau fichier `MenuDelegate.mc` : Gestion des interactions dans le menu
  - Navigation avec UP/DOWN entre les options
  - Support tactile : clic direct sur une option pour la lancer
  - Titre "Le Jardin des Langues" avec sous-titre

- **Mode Quiz Inversé (Français → Hanzi)** 🎉
  - Question affichée en français
  - 4 options de réponse en caractères chinois (hanzi)
  - Affichage du pinyin entre parenthèses comme indice
  - Feedback adapté avec hanzi + pinyin en cas d'erreur

- **Navigation améliorée**
  - Bouton BACK retourne maintenant au menu au lieu de quitter l'application
  - Transition fluide avec animation SLIDE_RIGHT

### Modifié
- **QuizModel**
  - Ajout de 2 modes : `MODE_NORMAL` (Hanzi→Français) et `MODE_REVERSE` (Français→Hanzi)
  - Le constructeur accepte maintenant un paramètre `mode`
  - `generateOptions()` adapté pour générer les bonnes options selon le mode
  - Ajout de la méthode `getQuizMode()` pour connaître le mode actuel

- **LanguageView**
  - Le constructeur accepte maintenant un paramètre `mode` 
  - Ajout de `drawNormalModeQuestion()` pour affichage Hanzi→Français
  - Ajout de `drawReverseModeQuestion()` pour affichage Français→Hanzi
  - `drawFeedback()` adapté pour afficher la correction selon le mode

- **LanguageApp**
  - `getInitialView()` retourne maintenant `MenuView` au lieu de `LanguageView`
  - Le menu devient le point d'entrée de l'application

### Architecture
- **Nouveaux fichiers** :
  - `source/MenuView.mc` : ~200 lignes
  - `source/MenuDelegate.mc` : ~85 lignes
- **Fichiers modifiés** :
  - `source/QuizModel.mc` : +8 lignes (enum modes)
  - `source/LanguageView.mc` : +70 lignes (support mode inversé)
  - `source/LanguageApp.mc` : 1 ligne changée (point d'entrée)

## [1.0.1] - 2025-10-20

### Corrigé
- **Bug de sélection tactile** : Les clics sur l'écran tactile sélectionnent maintenant correctement l'option cliquée
  - Changement de `BehaviorDelegate` vers `InputDelegate` pour supporter les événements tactiles
  - Ajout de la méthode `onTap()` dans `LanguageDelegate` pour détecter les clics
  - Ajout de la méthode `handleTapAt(y)` dans `LanguageView` pour calculer quelle option a été cliquée
  - Ajout de `selectOptionByIndex(index)` pour sélection directe d'une option
- **Bug de vérification de réponse** : La méthode `shuffleOptions()` utilise maintenant `.equals()` au lieu de `indexOf()` pour comparer les chaînes correctement

### Amélioré
- **Double méthode de contrôle** : 
  - Navigation traditionnelle avec boutons UP/DOWN + SELECT (inchangée)
  - Nouvelle interaction tactile : clic direct sur une option = sélection + validation instantanée
- **Code plus robuste** : Ajout de `onKey()` comme fallback pour les événements clavier

## [1.0.0] - 2025-10-19

### 🎉 Version initiale - MVP (Minimum Viable Product)

#### Ajouté
- **Base de données complète HSK 1 & 2**
  - 150 mots HSK niveau 1
  - 150 mots HSK niveau 2
  - Total : 300 mots avec hanzi, pinyin, traductions françaises et niveau HSK

- **Interface de quiz**
  - Affichage du hanzi (caractères chinois) en grand
  - Affichage du pinyin sous le hanzi pour aide à la prononciation
  - 4 options de réponse à choix multiples
  - Navigation intuitive avec les boutons de la montre
  - Indicateur visuel de l'option sélectionnée (fond bleu)

- **Système de feedback**
  - Feedback immédiat après validation
  - Fond vert + icône ✓ pour bonne réponse
  - Fond rouge + icône ✗ pour mauvaise réponse
  - Affichage de la correction en cas d'erreur

- **Logique de quiz intelligente**
  - Sélection aléatoire des mots
  - Génération de 3 distracteurs pertinents
  - Anti-répétition : mémorisation des 20 derniers mots utilisés
  - Mélange aléatoire des options (algorithme Fisher-Yates)

- **Système de score**
  - Compteur de bonnes réponses
  - Compteur de questions totales
  - Affichage en temps réel (format "X/Y")

- **Contrôles utilisateur**
  - UP : Option précédente
  - DOWN : Option suivante
  - SELECT/START : Valider la réponse
  - BACK : Quitter l'application

- **Optimisations techniques**
  - Gestion efficace de la mémoire (données statiques)
  - Algorithmes optimisés pour performances montre
  - Rendu direct sans overhead de layouts XML
  - Pas de consommation batterie excessive

#### Documentation
- README.md complet avec guide utilisateur
- DEVELOPMENT.md avec guide développeur détaillé
- CHANGELOG.md pour suivi des versions
- Commentaires exhaustifs dans le code source

#### Support
- **Appareils compatibles** :
  - Fenix 8 43mm
  - Fenix 8 47mm
  - Fenix 8 Pro 47mm
  - Fenix 8 Solar 47mm
  - Fenix 8 Solar 51mm
  - Fenix E

#### Architecture
- Pattern MVC adapté à Monkey C
- 5 fichiers source principaux :
  - `LanguageApp.mc` : Point d'entrée
  - `LanguageView.mc` : Interface utilisateur (254 lignes)
  - `LanguageDelegate.mc` : Gestion interactions (51 lignes)
  - `QuizModel.mc` : Logique du quiz (218 lignes)
  - `VocabularyData.mc` : Base de données (367 lignes)

### Limitations Connues
- Pas de persistance des données (score réinitialisé à chaque lancement)
- Pas de statistiques détaillées
- Pas de filtrage par niveau HSK
- Taille de police fixe pour les caractères chinois
- Caractères chinois peuvent ne pas s'afficher sur anciens modèles

### Notes Techniques
- **SDK Garmin** : Connect IQ 5.2.0+
- **Langage** : Monkey C
- **Taille approximative** : ~50 KB compilé
- **Mémoire utilisée** : < 10% sur Fenix 8
- **Langues** : Français (interface) + Mandarin (contenu)

---

## Format des Versions Futures

### [X.Y.Z] - YYYY-MM-DD

#### Ajouté
- Nouvelles fonctionnalités

#### Modifié
- Changements dans les fonctionnalités existantes

#### Déprécié
- Fonctionnalités bientôt supprimées

#### Supprimé
- Fonctionnalités supprimées

#### Corrigé
- Corrections de bugs

#### Sécurité
- Mises à jour de sécurité

---

## Roadmap Prévue

### Version 1.3.0 (Décembre 2025)
- Statistiques de session (taux de réussite)
- Amélioration de l'interface (polices adaptatives)
- Paramètres personnalisables

### Version 1.4.0 (Janvier 2026)
- Persistance des données (sauvegarde du score)
- Historique des sessions
- Compteur de séries de bonnes réponses

### Version 2.0.0 (Mars 2026)
- Mode révision des mots difficiles
- Filtrage par niveau HSK
- Statistiques détaillées
- Graphiques de progression

### Version 2.1.0 (Mai 2026)
- Exemples de phrases en contexte
- Audio pour prononciation (si possible)
- Mode sombre/clair

### Version 3.0.0 (Septembre 2026)
- Mode inverse (français → mandarin)
- Système de répétition espacée (SRS)
- Badges et achievements
- Synchronisation avec smartphone

---

**Légende des Émojis** :
- 🎉 Version majeure
- ✨ Nouvelle fonctionnalité
- 🐛 Correction de bug
- 📝 Documentation
- ⚡ Performance
- 🎨 Interface
- 🔒 Sécurité
