# Changelog - Le Jardin des Langues

Tous les changements notables de ce projet seront documentés dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/),
et ce projet adhère au [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Non publié]

### À venir
- Filtrage par niveau HSK
- Affichage des statistiques de progression dans le menu
- Mode révision des mots par statut de maîtrise

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
