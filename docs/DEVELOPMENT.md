# Guide de Développement - Le Jardin des Langues

## 📋 Table des Matières
1. [Architecture](#architecture)
2. [Composants Principaux](#composants-principaux)
3. [Flux de Données](#flux-de-données)
4. [Persistance des Données](#persistance-des-données)
5. [Personnalisation](#personnalisation)
6. [Optimisation](#optimisation)
7. [Débogage](#débogage)

## 🏗️ Architecture

### Vue d'Ensemble
L'application suit le pattern MVC (Model-View-Controller) adapté à Monkey C :
- **Model** : `QuizModel.mc` + `VocabularyData.mc` + `WordProgressStorage.mc`
- **View** : `MenuView.mc` + `LanguageView.mc` + `DictionaryView.mc` + `WordDetailView.mc`
- **Controller** : `MenuDelegate.mc` + `LanguageDelegate.mc` + `DictionaryDelegate.mc` + `WordDetailDelegate.mc`

### Diagramme de Flux
```
LanguageApp (entry point)
    ↓
    ├─→ MenuView (écran d'accueil)
    │       ↓
    │   MenuDelegate (interactions menu)
    │       ↓
    │   [Sélection mode]
    │       ↓
    │   ├─→ Quiz Normal/Inversé
    │   │       ↓
    │   │   LanguageView (affichage quiz)
    │   │       ↓
    │   │   QuizModel (logique + mode)
    │   │       ↓
    │   │   VocabularyData (données)
    │   │       ↓
    │   │   WordProgressStorage (persistance)
    │   │       ↓
    │   │   LanguageDelegate (interactions quiz)
    │   │       ↓
    │   │   [Feedback → Flaggage]
    │   │
    │   └─→ Dictionnaire
    │           ↓
    │       DictionaryView (liste des mots)
    │           ↓
    │       DictionaryDelegate (interactions)
    │           ↓
    │       [Sélection d'un mot]
    │           ↓
    │       WordDetailView (détails + édition statut)
    │           ↓
    │       WordDetailDelegate (interactions)
    │           ↓
    │       VocabularyData + WordProgressStorage (sauvegarde)
```

## 🔧 Composants Principaux

### 0. MenuView.mc & MenuDelegate.mc (v1.1+, v1.4+)
**Rôle** : Écran d'accueil pour choisir le mode de quiz ou accéder au dictionnaire

**MenuView - Structure** :
```monkeyc
private var selectedOption    // 0 = Normal, 1 = Inversé, 2 = Dictionnaire
private var screenHeight      // Pour calcul zones tactiles
enum MenuOption {
    QUIZ_NORMAL = 0,
    QUIZ_REVERSE = 1,
    DICTIONARY = 2
}
```

**Méthodes principales** :
- `onUpdate(dc)` : Dessine le menu avec 3 options (v1.4+)
- `drawMenuOption()` : Dessine une option (titre + description)
- `selectPreviousOption/NextOption()` : Navigation UP/DOWN (3 options, v1.4+)
- `handleTapAt(y)` : Gère les clics tactiles (3 zones, v1.4+)
- `launchSelectedMode()` : Lance le quiz ou le dictionnaire selon l'option sélectionnée (v1.4+)

**MenuDelegate - Interactions** :
- `onTap(clickEvent)` : Capture les clics tactiles
- `onKey()` : Gère UP/DOWN/SELECT
- `onSelect()` : Lance le mode sélectionné
- `onBack()` : Quitte l'application (comportement par défaut)

### 0bis. DictionaryView.mc & DictionaryDelegate.mc (v1.4+)
**Rôle** : Affiche la liste complète des mots avec filtrage par statut

**DictionaryView - Structure** :
```monkeyc
private var scrollOffset          // Index du premier mot visible
private var selectedIndex         // Index du mot sélectionné dans la liste filtrée
private var visibleItems          // Nombre de mots affichés simultanément (4)
private var filterStatus          // Filtre actuel (null = tous, 0/1/2 = Maîtrisé/Connu/Inconnu)
private var filteredIndices       // Liste des indices de mots correspondant au filtre
```

**Méthodes principales** :
- `onUpdate(dc)` : Dessine la liste des mots avec statuts
- `drawWordItem()` : Dessine une ligne de la liste (hanzi, traduction, icône de statut)
- `drawScrollIndicator()` : Affiche l'indicateur de scroll si nécessaire
- `selectPreviousWord/NextWord()` : Navigation dans la liste avec scroll automatique
- `cycleFilter()` : Change le filtre (Tous → Maîtrisés → Connus → Inconnus → Tous)
- `updateFilteredIndices()` : Met à jour la liste des mots selon le filtre actif
- `openWordDetail()` : Ouvre la vue détaillée du mot sélectionné
- `getStatusIcon/Color()` : Rendu visuel des statuts (✓/○/✗ + couleurs)

**DictionaryDelegate - Interactions** :
- `onTap(clickEvent)` : Ouvre les détails du mot sélectionné
- `onKey()` : Gère UP/DOWN/SELECT
- `onPreviousPage/NextPage()` : Navigation dans la liste
- `onSelect()` : Ouvre les détails
- `onMenu()` : Change le filtre (cycle entre les 4 modes)
- `onBack()` : Retour au menu principal

**Fonctionnalités** :
- Affichage de tous les mots (300 par défaut)
- Filtrage par statut : Maîtrisés, Connus, Inconnus, ou Tous
- Scroll automatique avec indicateur visuel
- Affichage du compteur (ex: "15/300 mots", "Maîtrisés (42)")
- Navigation rapide avec les boutons physiques ou l'écran tactile

### 0ter. WordDetailView.mc & WordDetailDelegate.mc (v1.4+)
**Rôle** : Affiche les détails complets d'un mot et permet de modifier son statut

**WordDetailView - Structure** :
```monkeyc
private var wordIndex              // Index du mot affiché
private var currentStatus          // Statut actuel du mot
private var editMode               // Mode édition activé (true/false)
private var selectedStatusOption   // Option sélectionnée en mode édition (0-2)
```

**Modes d'affichage** :
1. **Mode Détail** (consultation) :
   - Affichage grand format du hanzi
   - Pinyin
   - Traduction complète
   - Niveau HSK
   - Statut actuel avec icône et couleur

2. **Mode Édition** (modification du statut) :
   - 3 options interactives :
     - ✓ Maîtrisé (vert)
     - ○ Connu (orange)
     - ✗ Inconnu (rouge)
   - Navigation UP/DOWN
   - Validation ou annulation

**Méthodes principales** :
- `onUpdate(dc)` : Dessine le bon mode (détail ou édition)
- `drawDetailMode(dc)` : Affichage consultation
- `drawEditMode(dc)` : Affichage édition
- `drawStatusOption()` : Dessine une option de statut sélectionnable
- `enterEditMode()` : Active le mode édition
- `cancelEditMode()` : Annule les modifications
- `saveStatus()` : Enregistre le nouveau statut et quitte le mode édition
- `selectPreviousStatusOption/NextStatusOption()` : Navigation entre les 3 options
- `getStatusText/Icon/Color()` : Rendu visuel des statuts

**WordDetailDelegate - Interactions** :
- `onTap()` : Mode détail = entre en édition si clic sur zone Statut (72%-90%) / Mode édition = sélectionne et sauvegarde l'option cliquée
- `onKey()` : Gère UP/DOWN/SELECT selon le mode
- `onSelect()` : Mode détail = entre en édition / Mode édition = sauvegarde
- `onBack()` : Mode édition = annule / Mode détail = retour au dictionnaire
- `onPreviousPage/NextPage()` : Navigation en mode édition uniquement

**Workflow de modification** :
```
1. Utilisateur ouvre un mot depuis le dictionnaire
2. WordDetailView affiche les infos complètes
3. Utilisateur appuie sur SELECT ou tape sur la zone "Statut" (72%-90% de l'écran)
4. Mode édition s'active avec 3 options
5. Utilisateur sélectionne un nouveau statut (UP/DOWN ou clic direct)
6. Appuie sur SELECT ou tape sur une option pour valider
7. Le statut est sauvegardé dans WordProgressStorage
8. Retour au mode détail avec le nouveau statut

Note : Un clic direct sur une option (35%-52%, 52%-69%, 69%-86%) sélectionne et sauvegarde immédiatement.
```

### 1. VocabularyData.mc
**Rôle** : Stockage et accès aux données de vocabulaire

**Structure des données** :
```monkeyc
[hanzi, pinyin, traduction, hskLevel]
// Exemple: ["你好", "nǐ hǎo", "bonjour", 1]
```

**Méthodes clés** :
- `getVocabularySize()` : Retourne le nombre total de mots (300)
- `getWordByIndex(index)` : Récupère un mot complet
- `getHanzi(index)` : Récupère uniquement le hanzi
- `getPinyin(index)` : Récupère uniquement le pinyin
- `getTranslation(index)` : Récupère uniquement la traduction
- `getHskLevel(index)` : Récupère le niveau HSK
- `setWordStatus(index, status)` : Définit le statut de maîtrise d'un mot (v1.3+)
- `getWordStatus(index)` : Récupère le statut de maîtrise d'un mot (v1.3+)
- `getProgressStatistics()` : Récupère les statistiques de progression (v1.3+)

**Ajout de nouveaux mots** :
```monkeyc
// Ajouter à la fin du tableau vocabulary
["新词", "xīn cí", "nouveau mot", 2],
```

### 2. QuizModel.mc
**Rôle** : Gestion de la logique du quiz

**Modes de quiz (v1.1+)** :
```monkeyc
enum {
    MODE_NORMAL = 0,   // Hanzi → Français
    MODE_REVERSE = 1   // Français → Hanzi
}
```

**Variables d'état** :
```monkeyc
// Variable statique pour conserver l'état du pinyin entre les sessions
static private var showPinyin as Boolean = true;

private var quizMode             // Mode actuel (NORMAL/REVERSE)
private var currentWordIndex      // Index du mot actuel
private var options               // Array des 4 options de réponse
private var correctAnswerPosition // Position de la bonne réponse (0-3)
private var usedIndices          // Historique des mots utilisés
private var score                // Nombre de bonnes réponses
private var totalQuestions       // Nombre total de questions
```

**Algorithme de génération des questions** :
```
1. Sélectionner un mot aléatoire (éviter les 20 derniers)
2. MODE_NORMAL: Ajouter la traduction française aux options
   MODE_REVERSE: Ajouter le hanzi aux options
3. Générer 3 distracteurs selon le mode
4. Mélanger les 4 options (algorithme Fisher-Yates)
5. Mémoriser la position de la bonne réponse
```

**Méthodes principales** :
- `initialize(mode)` : Constructeur avec mode de quiz (v1.1+)
- `generateNewQuestion()` : Crée une nouvelle question
- `generateOptions()` : Génère les 4 options selon le mode
- `checkAnswer(position)` : Vérifie si la réponse est correcte
- `getCurrentHanzi()` : Récupère le hanzi à afficher
- `getCurrentPinyin()` : Récupère le pinyin
- `getCorrectTranslation()` : Récupère la traduction correcte
- `getOptions()` : Récupère les 4 options de réponse
- `getScore()` : Récupère le score actuel
- `getQuizMode()` : Retourne le mode actuel (v1.1+)
- `getCorrectAnswerPosition()` : Retourne la position de la bonne réponse (0-3)
- `togglePinyin()` : Bascule l'affichage du pinyin (v1.2+)
- `isPinyinVisible()` : Retourne l'état actuel du pinyin (v1.2+)
- `showPinyinDisplay()` : Active l'affichage du pinyin (v1.2+)
- `hidePinyinDisplay()` : Désactive l'affichage du pinyin (v1.2+)
- `setCurrentWordStatus(status)` : Enregistre le statut du mot actuel (v1.3+)
- `getCurrentWordStatus()` : Récupère le statut du mot actuel (v1.3+)
- `getCurrentWordIndex()` : Retourne l'index du mot actuel (v1.3+)

### 2bis. WordProgressStorage.mc (v1.3+)
**Rôle** : Gestion de la persistance des statuts de maîtrise des mots

**Statuts possibles** :
```monkeyc
enum {
    STATUS_MASTERED = 0,   // ✓ Mot maîtrisé
    STATUS_KNOWN = 1,      // ○ Mot connu
    STATUS_UNKNOWN = 2     // ✗ Mot inconnu
}
```

**Stockage** :
- Utilise le Storage API de Garmin Connect IQ
- Clé : `"word_progress"`
- Format : Dictionary<String, Number> (index → statut)
- Persistant entre les sessions

**Méthodes principales** :
- `setWordStatus(index, status)` : Enregistre le statut d'un mot
- `getWordStatus(index)` : Récupère le statut d'un mot (retourne STATUS_UNKNOWN par défaut)
- `hasStatus(index)` : Vérifie si un mot a déjà été évalué
- `getStatistics()` : Retourne les statistiques (nombre de mots par statut)
- `getEvaluatedWordsCount()` : Nombre total de mots évalués
- `getMasteredPercentage()` : Pourcentage de mots maîtrisés
- `resetAllProgress()` : Réinitialise toutes les données (efface tout)

**Exemple d'utilisation** :
```monkeyc
// Enregistrer qu'un mot est maîtrisé
WordProgressStorage.setWordStatus(42, WordProgressStorage.STATUS_MASTERED);

// Récupérer le statut
var status = WordProgressStorage.getWordStatus(42);
if (status == WordProgressStorage.STATUS_MASTERED) {
    System.println("Ce mot est maîtrisé !");
}

// Obtenir les statistiques
var stats = WordProgressStorage.getStatistics();
System.println("Maîtrisés: " + stats["mastered"]);
System.println("Connus: " + stats["known"]);
System.println("Inconnus: " + stats["unknown"]);
```
### 3. LanguageView.mc
**Rôle** : Affichage de l'interface utilisateur du quiz

**Variables d'état** :
```monkeyc
private var quizModel        // Instance du modèle
private var selectedOption   // Option actuellement sélectionnée (0-3)
private var feedbackState    // État du feedback (NONE/CORRECT/INCORRECT/FLAGGING) (v1.3+)
private var selectedFlag     // Option de flaggage sélectionnée (0-2) (v1.3+)
```

**États du feedback (v1.3+)** :
```monkeyc
enum {
    FEEDBACK_NONE = 0,        // Pas de feedback, mode quiz normal
    FEEDBACK_CORRECT = 1,     // Feedback bonne réponse
    FEEDBACK_INCORRECT = 2,   // Feedback mauvaise réponse
    FEEDBACK_FLAGGING = 3     // Mode flaggage (évaluation du mot)
}
```

**Layout de l'écran (Mode Normal)** :
```
┌─────────────────────┐
│                     │  15% - Hanzi (grand)
│        你好          │
│      nǐ hǎo         │  28% - Pinyin (petit)
├─────────────────────┤  35% - Séparateur
│  1. bonjour     ◄   │  40-52.5% - Option 1
│  2. au revoir       │  52.5-65% - Option 2
│  3. merci           │  65-77.5% - Option 3
│  4. pardon          │  77.5-90% - Option 4
├─────────────────────┤
│      3/5            │  95% - Score
└─────────────────────┘
```

**Layout de l'écran (Mode Inversé - v1.1+)** :
```
┌─────────────────────┐
│                     │
│      Bonjour        │  15% - Français (grand)
│      (nǐ hǎo)       │  28% - Pinyin indice
├─────────────────────┤
│  1. 你好        ◄   │  40-52.5% - Option 1
│  2. 再见            │  52.5-65% - Option 2
│  3. 谢谢            │  65-77.5% - Option 3
│  4. 请              │  77.5-90% - Option 4
├─────────────────────┤
│      3/5            │  95% - Score
└─────────────────────┘
```

**Layout de l'écran de flaggage (v1.3+)** :
```
┌─────────────────────┐
│ Niveau de maîtrise ?│  10% - Titre
│       你好           │  22% - Mot concerné
├─────────────────────┤  32% - Séparateur
│   ✓ Maîtrisé    ◄   │  38-55% - Option 1 (vert)
│   ○ Connu           │  55-72% - Option 2 (orange)
│   ✗ Inconnu         │  72-89% - Option 3 (rouge)
├─────────────────────┤
│ ↑↓ • SELECT         │  93% - Instructions
└─────────────────────┘
```

**Rendu** :
- `initialize(mode)` : Constructeur avec mode de quiz (v1.1+)
- `onUpdate(dc)` : Méthode principale de rendu (appelle la bonne méthode selon le mode)
- `drawNormalModeQuestion(dc)` : Dessine question Hanzi → Français (v1.1+, affichage conditionnel du pinyin v1.2+)
- `drawReverseModeQuestion(dc)` : Dessine question Français → Hanzi (v1.1+, affichage conditionnel du pinyin v1.2+)
- `drawOption(dc, index, y, width, height)` : Dessine une option
- `drawFeedback(dc)` : Dessine l'écran de feedback (adapté selon le mode, v1.3+ avec instruction pour évaluer)
- `drawFlaggingScreen(dc)` : Dessine l'écran d'évaluation du mot (v1.3+)
- `drawFlagOption(dc, index, y, width, height, label, color)` : Dessine une option de flaggage (v1.3+)
- `togglePinyin()` : Bascule l'affichage du pinyin et rafraîchit l'écran (v1.2+)

**Interactions** :
- `selectPreviousOption()` : Navigation vers l'option précédente (bouton UP) - gère aussi le flaggage (v1.3+)
- `selectNextOption()` : Navigation vers l'option suivante (bouton DOWN) - gère aussi le flaggage (v1.3+)
- `selectOptionByIndex(index)` : Sélection directe d'une option (pour tactile)
- `handleTapAt(y)` : Calcule quelle option a été cliquée selon position Y, ou bascule le pinyin si clic en haut (v1.2+), gère aussi les clics sur le flaggage (v1.3+)
- `submitAnswer()` : Valide la réponse et affiche le feedback, ou passe au flaggage (v1.3+)
- `moveToFlagging()` : Passe du feedback au mode flaggage (v1.3+)
- `submitFlag()` : Enregistre le statut sélectionné et passe à la question suivante (v1.3+)
- `nextQuestion()` : Passe à la question suivante
- `togglePinyin()` : Bascule l'affichage du pinyin et rafraîchit l'écran (v1.2+)

**Couleurs** :
```monkeyc
// Thème principal
Background: Graphics.COLOR_BLACK
Text: Graphics.COLOR_WHITE
Pinyin: Graphics.COLOR_LT_GRAY

// Sélection
Selected: Graphics.COLOR_DK_BLUE

// Feedback
Correct: Graphics.COLOR_DK_GREEN
Incorrect: Graphics.COLOR_DK_RED
```

### 4. LanguageDelegate.mc
**Rôle** : Gestion des interactions utilisateur dans le quiz

**Héritage** : `WatchUi.InputDelegate` (au lieu de BehaviorDelegate pour supporter le tactile)

**Mapping des interactions** :
```monkeyc
// Boutons physiques
onKey(KEY_UP)    → UP    → selectPreviousOption()
onKey(KEY_DOWN)  → DOWN  → selectNextOption()
onKey(KEY_ENTER) → START → submitAnswer()
onPreviousPage() → UP    → selectPreviousOption() (legacy)
onNextPage()     → DOWN  → selectNextOption() (legacy)
onSelect()       → START → submitAnswer() (legacy)
onBack()         → BACK  → Retour au menu (v1.1+)

// Écran tactile
onTap(clickEvent) → TOUCH → handleTapAt(y) → {
    - Si y < 35% : togglePinyin() (v1.2+)
    - Si y >= 40% : Sélection + validation directe d'une option
}
```

**Méthodes principales** :
- `onTap(clickEvent)` : Capture les clics tactiles et calcule la position Y
- `onKey(keyEvent)` : Gère les événements clavier/boutons
- `onBack()` : Retourne au menu (v1.1+)
- `onPreviousPage/onNextPage/onSelect()` : Méthodes legacy (compatibilité)

## 🔄 Flux de Données

### Démarrage de l'Application
```
1. LanguageApp.initialize()
2. LanguageApp.getInitialView()
   ├─→ Créer MenuView (v1.1+)
   └─→ Créer MenuDelegate(menuView)
3. MenuView.onShow()
4. MenuView.onUpdate(dc) → Affichage menu
5. [Utilisateur sélectionne un mode]
6. MenuView.launchQuiz()
   ├─→ Créer LanguageView(mode)
   │   ├─→ Créer QuizModel(mode)
   │   └─→ generateNewQuestion()
   │       └─→ VocabularyData.getWordByIndex()
   └─→ Créer LanguageDelegate(view)
7. LanguageView.onShow()
8. LanguageView.onUpdate(dc) → Affichage quiz
```

### Interaction Utilisateur (Navigation)
```
1. Utilisateur appuie sur UP/DOWN
2. LanguageDelegate.onPreviousPage/onNextPage()
3. LanguageView.selectPreviousOption/selectNextOption()
4. WatchUi.requestUpdate()
5. LanguageView.onUpdate(dc) → Redessine l'écran
```

### Validation d'une Réponse et Flaggage (v1.3+)
```
1. Utilisateur appuie sur SELECT (ou clic tactile)
2. LanguageDelegate.onSelect()
3. LanguageView.submitAnswer()
   ├─→ QuizModel.checkAnswer(selectedOption)
   │   └─→ Retourne true/false
   └─→ Mettre feedbackState à CORRECT/INCORRECT
4. WatchUi.requestUpdate()
5. LanguageView.onUpdate(dc) → drawFeedback()
   └─→ Affiche "Appuyez pour évaluer"
6. [Utilisateur appuie à nouveau sur SELECT]
7. LanguageView.moveToFlagging()
   └─→ feedbackState = FEEDBACK_FLAGGING
8. WatchUi.requestUpdate()
9. LanguageView.onUpdate(dc) → drawFlaggingScreen()
   └─→ Affiche 3 options : Maîtrisé / Connu / Inconnu
10. [Utilisateur navigue avec UP/DOWN et sélectionne avec SELECT]
11. LanguageView.submitFlag()
    ├─→ QuizModel.setCurrentWordStatus(status)
    │   └─→ VocabularyData.setWordStatus(index, status)
    │       └─→ WordProgressStorage.setWordStatus(index, status)
    │           └─→ Storage.setValue("word_progress", data)
    └─→ nextQuestion()
```

## 💾 Persistance des Données (v1.3+)

### Vue d'Ensemble

L'application utilise le **Storage API** de Garmin Connect IQ pour sauvegarder de manière persistante le niveau de maîtrise de chaque mot. Ces données survivent :
- À la fermeture de l'application
- Au redémarrage de la montre
- Aux mises à jour de l'application (tant que l'ID ne change pas)

### Flux de Persistance

```
[Utilisateur évalue un mot]
        ↓
LanguageView.submitFlag()
        ↓
QuizModel.setCurrentWordStatus(status)
        ↓
VocabularyData.setWordStatus(index, status)
        ↓
WordProgressStorage.setWordStatus(index, status)
        ↓
Storage.setValue("word_progress", Dictionary)
        ↓
[Sauvegardé sur la montre]
```

### Structure des Données Stockées

**Format JSON équivalent** :
```json
{
  "word_progress": {
    "0": 0,    // Mot index 0 = Maîtrisé
    "1": 1,    // Mot index 1 = Connu
    "5": 2,    // Mot index 5 = Inconnu
    "42": 0,   // Mot index 42 = Maîtrisé
    ...
  }
}
```

**Signification des valeurs** :
- `0` = `STATUS_MASTERED` (✓ Maîtrisé)
- `1` = `STATUS_KNOWN` (○ Connu)
- `2` = `STATUS_UNKNOWN` (✗ Inconnu)

**Mots non évalués** : Si un mot n'apparaît pas dans le dictionnaire, il est considéré comme `STATUS_UNKNOWN` par défaut.

### Limites du Storage

**Capacités Garmin** :
- Taille maximale : ~100-1000 KB selon les appareils
- Pour 300 mots : ~2-3 KB utilisés (très léger)
- Pas de limite de lecture/écriture

**Bonnes pratiques** :
- Une seule clé de stockage (`"word_progress"`)
- Stockage d'un Dictionary simple (pas d'objets complexes)
- Mise à jour atomique (remplacement complet du dictionnaire)

### Récupération des Données

Au démarrage de l'application, les données sont automatiquement chargées depuis le Storage :

```monkeyc
// Première fois : Storage retourne null
var data = Storage.getValue("word_progress");
if (data == null) {
    data = {}; // Dictionnaire vide
}

// Ensuite : Storage retourne le Dictionary sauvegardé
var status = data.get("42"); // Récupère le statut du mot 42
```

### Réinitialisation des Données

Pour effacer toute la progression (utile pour un reset) :

```monkeyc
WordProgressStorage.resetAllProgress();
// Efface toutes les données de progression
```

### Statistiques de Progression

L'application peut calculer des statistiques en temps réel :

```monkeyc
var stats = WordProgressStorage.getStatistics();
// Retourne : { "mastered" => X, "known" => Y, "unknown" => Z }

var masteredPercent = WordProgressStorage.getMasteredPercentage();
// Retourne : pourcentage de mots maîtrisés (0.0 - 100.0)

var evaluatedCount = WordProgressStorage.getEvaluatedWordsCount();
// Retourne : nombre de mots qui ont été évalués au moins une fois
```

### Cas d'Usage Avancés

**Filtrer par statut** (future feature) :
```monkeyc
// Générer une question uniquement avec des mots "Inconnus"
var unknownWords = [];
for (var i = 0; i < VocabularyData.getVocabularySize(); i++) {
    if (VocabularyData.getWordStatus(i) == WordProgressStorage.STATUS_UNKNOWN) {
        unknownWords.add(i);
    }
}
// Utiliser unknownWords pour le quiz
```

**Tri par difficulté** (future feature) :
```monkeyc
// Prioriser les mots non maîtrisés dans la génération des questions
function getWeightedRandomWord() {
    var index = Math.rand() % VocabularyData.getVocabularySize();
    var status = VocabularyData.getWordStatus(index);
    
    // Ré-essayer si le mot est maîtrisé (60% du temps)
    if (status == WordProgressStorage.STATUS_MASTERED && Math.rand() % 100 < 60) {
        return getWeightedRandomWord();
    }
    
    return index;
}
```

### Debugging du Storage

Pour afficher les données stockées en debug :

```monkeyc
// Dans LanguageApp.onStart()
var data = Storage.getValue("word_progress");
if (data != null) {
    System.println("Mots enregistrés : " + data.size());
    var keys = data.keys();
    for (var i = 0; i < keys.size(); i++) {
        var index = keys[i];
        var status = data.get(index);
        System.println("Mot " + index + " = " + status);
    }
}
```

## 🎨 Personnalisation

### Évaluation des Mots (v1.3+)

**Fonctionnalité** : Après chaque question, l'utilisateur peut évaluer son niveau de maîtrise du mot.

**Workflow** :
1. L'utilisateur répond à la question (correcte ou incorrecte)
2. Le feedback s'affiche (vert ou rouge)
3. Message "Appuyez pour évaluer" apparaît
4. L'utilisateur appuie sur SELECT ou tape l'écran
5. L'écran de flaggage s'affiche avec 3 options :
   - ✓ **Maîtrisé** (vert) : Je connais parfaitement ce mot
   - ○ **Connu** (orange) : Je reconnais ce mot mais je ne suis pas sûr
   - ✗ **Inconnu** (rouge) : Ce mot m'est totalement inconnu
6. L'utilisateur sélectionne une option avec UP/DOWN ou en tapant
7. Le statut est enregistré et la question suivante s'affiche

**Navigation** :
- **Boutons physiques** : UP/DOWN pour naviguer, SELECT pour valider
- **Écran tactile** : Taper directement sur l'option souhaitée

**Persistance** :
- Le statut est **immédiatement sauvegardé** dans le Storage
- Il persiste entre les sessions
- Peut être modifié à chaque nouvelle rencontre du mot

### Affichage du Pinyin (v1.2+)

**Fonctionnalité** : L'utilisateur peut cacher/afficher le pinyin pendant le quiz.

**Comment l'utiliser** :
- Appuyer sur le bouton **MENU** pendant le quiz pour basculer l'affichage
- L'état est conservé entre les sessions (variable statique)
- Un indicateur `[MENU: Pinyin]` s'affiche quand le pinyin est caché

**Comportement** :
```monkeyc
// Mode Normal (Hanzi → Français)
Pinyin visible: 你好
               nǐ hǎo

Pinyin caché:   你好
               [MENU: Pinyin]

// Mode Inversé (Français → Hanzi)
Pinyin visible: Bonjour
               (nǐ hǎo)

Pinyin caché:   Bonjour
               [MENU: Pinyin]
```

**Implémentation** :
- Variable statique `showPinyin` dans `QuizModel` (conservée entre les quiz)
- Méthodes `togglePinyin()`, `isPinyinVisible()` pour la gestion
- Rendu conditionnel dans `drawNormalModeQuestion()` et `drawReverseModeQuestion()`
- Zone tactile dédiée dans `handleTapAt()` : les clics dans le haut de l'écran (0-35%) basculent le pinyin

### Modifier les Couleurs
Dans `LanguageView.mc` :
```monkeyc
// Changer la couleur de sélection
dc.setColor(Graphics.COLOR_DK_BLUE, Graphics.COLOR_DK_BLUE);
// → Graphics.COLOR_PURPLE, Graphics.COLOR_PURPLE

// Changer la couleur du feedback correct
dc.setColor(Graphics.COLOR_DK_GREEN, Graphics.COLOR_DK_GREEN);
// → Graphics.COLOR_BLUE, Graphics.COLOR_BLUE
```

### Modifier la Taille des Polices
```monkeyc
// Hanzi plus grand
Graphics.FONT_SYSTEM_LARGE
// → Graphics.FONT_NUMBER_HOT

// Options plus petites
Graphics.FONT_SYSTEM_TINY
// → Graphics.FONT_SYSTEM_XTINY
```

### Ajuster le Layout
Dans `LanguageView.onUpdate()` :
```monkeyc
// Position du hanzi (actuellement 15%)
height * 0.15
// → height * 0.10 (plus haut)

// Position des options (actuellement 40%)
var optionStartY = (height * 40) / 100;
// → var optionStartY = (height * 45) / 100; (plus bas)
```

### Ajouter des Niveaux HSK Supplémentaires
Dans `VocabularyData.mc` :
```monkeyc
// Ajouter des mots HSK 3
["因为", "yīnwèi", "parce que", 3],
["所以", "suǒyǐ", "donc", 3],
// etc.
```

Puis dans `QuizModel.mc`, ajouter un filtre :
```monkeyc
// Nouvelle méthode
function setHskFilter(level as Number) as Void {
    // Implémenter le filtrage par niveau
}
```

## ⚡ Optimisation

### Mémoire
**Problème** : Les montres Garmin ont une mémoire limitée (~64-256 KB selon le modèle)

**Solutions appliquées** :
1. **Données statiques** : Utilisation de méthodes static dans VocabularyData
2. **Arrays simples** : Pas de dictionnaires gourmands en mémoire
3. **Historique limité** : Seulement 20 derniers mots mémorisés
4. **Pas de caching** : Génération à la volée

**Vérifier l'utilisation mémoire** :
```monkeyc
// Ajouter dans LanguageView.initialize()
System.println("Memory: " + System.getSystemStats().usedMemory);
```

### Performance
**Optimisations implémentées** :
1. **Génération efficace des distracteurs** : Max 10 tentatives pour éviter les répétitions
2. **Algorithme Fisher-Yates** : Mélange optimal en O(n)
3. **Rendu direct** : Pas d'utilisation de layouts XML (overhead)
4. **Redessins minimaux** : Uniquement sur interaction ou changement d'état

### Batterie
**Conseils** :
- L'application n'utilise pas de GPS, capteurs ou connexion → impact minimal
- Le backlight consomme le plus : l'utilisateur contrôle
- Pas de timers ou de rafraîchissements automatiques

## 🐛 Débogage

### Logs
Ajouter des logs dans le code :
```monkeyc
System.println("Current word index: " + currentWordIndex);
System.println("Selected option: " + selectedOption);
System.println("Score: " + score + "/" + totalQuestions);
```

Visualiser dans VS Code :
```
Output panel → Monkey C (nom de la configuration)
```

### Simulateur
Lancer avec débogage :
```bash
# Via VS Code
F5 (ou Run > Start Debugging)

# Via ligne de commande
monkeydo bin/Language.prg fenix847mm
```

**Contrôles simulateur** :
- Flèches : Navigation
- Enter : SELECT
- Escape : BACK

### Erreurs Courantes

**1. "Invalid type" lors de la compilation**
```monkeyc
// ❌ Mauvais
var height = dc.getHeight() * 0.5; // Float

// ✅ Bon
var height = (dc.getHeight() * 50) / 100; // Number
```

**2. "Undefined symbol"**
```monkeyc
// ❌ Variable non déclarée
centerX = width / 2;

// ✅ Déclaration avec type
var centerX = width / 2;
```

**3. "Symbol not found"**
```monkeyc
// ❌ Import manquant
class MyClass extends WatchUi.View {

// ✅ Ajouter l'import
import Toybox.WatchUi;
class MyClass extends WatchUi.View {
```

### Tests Manuels

**Checklist de test** :

**Quiz** :
- [ ] Les caractères chinois s'affichent correctement
- [ ] Le pinyin est lisible
- [ ] Navigation UP/DOWN fonctionne dans le quiz
- [ ] Sélection correcte → Fond vert
- [ ] Sélection incorrecte → Fond rouge + correction
- [ ] Score s'incrémente correctement
- [ ] Pas de répétition immédiate des mots
- [ ] Toutes les 4 options sont différentes
- [ ] Le bouton BACK retourne au menu (v1.1+)
- [ ] Le bouton MENU bascule l'affichage du pinyin (v1.2+)
- [ ] L'état du pinyin est conservé entre les questions (v1.2+)
- [ ] L'indicateur `[MENU: Pinyin]` s'affiche quand le pinyin est caché (v1.2+)
- [ ] L'écran de feedback s'affiche correctement (v1.3+)
- [ ] Le message "Appuyez pour évaluer" apparaît après le feedback (v1.3+)
- [ ] L'écran de flaggage s'affiche avec 3 options (v1.3+)
- [ ] Navigation UP/DOWN fonctionne dans le flaggage (v1.3+)
- [ ] Les couleurs des options de flaggage sont correctes (vert/orange/rouge) (v1.3+)
- [ ] La sélection d'un statut enregistre les données (v1.3+)
- [ ] Les statuts persistent après fermeture/réouverture de l'app (v1.3+)
- [ ] Les clics tactiles fonctionnent sur les options de flaggage (v1.3+)
- [ ] Le statut peut être modifié à chaque nouvelle rencontre du mot (v1.3+)

**Menu** :
- [ ] Le menu affiche 3 options (Quiz Normal, Quiz Inversé, Dictionnaire) (v1.4+)
- [ ] Navigation UP/DOWN fonctionne dans le menu (v1.4+)
- [ ] Les clics tactiles fonctionnent sur les 3 options (v1.4+)
- [ ] SELECT lance le mode sélectionné (v1.4+)
- [ ] BACK quitte l'application (v1.4+)

**Dictionnaire** :
- [ ] La liste des mots s'affiche correctement (v1.4+)
- [ ] Navigation UP/DOWN fonctionne avec scroll (v1.4+)
- [ ] L'indicateur de scroll apparaît quand nécessaire (v1.4+)
- [ ] Les icônes de statut (✓/○/✗) s'affichent correctement (v1.4+)
- [ ] Les couleurs des statuts sont correctes (vert/orange/rouge) (v1.4+)
- [ ] Le filtre MENU cycle correctement (Tous → Maîtrisés → Connus → Inconnus) (v1.4+)
- [ ] Le compteur de mots s'affiche correctement selon le filtre (v1.4+)
- [ ] La sélection d'un mot ouvre les détails (v1.4+)
- [ ] BACK retourne au menu (v1.4+)

**Détails du mot** :
- [ ] Toutes les informations s'affichent (hanzi, pinyin, traduction, HSK, statut) (v1.4+)
- [ ] SELECT active le mode édition (v1.4+)
- [ ] Tap sur zone "Statut" active le mode édition (v1.4+)
- [ ] Tap ailleurs en mode détail ne fait rien (v1.4+)
- [ ] Navigation UP/DOWN fonctionne en mode édition (v1.4+)
- [ ] Les 3 options de statut s'affichent avec les bonnes couleurs (v1.4+)
- [ ] SELECT sauvegarde le statut sélectionné (v1.4+)
- [ ] Tap direct sur une option sélectionne et sauvegarde immédiatement (v1.4+)
- [ ] BACK annule les modifications en mode édition (v1.4+)
- [ ] BACK retourne au dictionnaire en mode détail (v1.4+)
- [ ] Le statut modifié est immédiatement visible dans le dictionnaire (v1.4+)
- [ ] Le statut modifié persiste après fermeture/réouverture (v1.4+)

## 📚 Ressources

### Documentation Garmin
- [Connect IQ SDK](https://developer.garmin.com/connect-iq/overview/)
- [API Reference](https://developer.garmin.com/connect-iq/api-docs/)
- [Monkey C Programming Guide](https://developer.garmin.com/connect-iq/monkey-c/)

### Outils
- [Simulateur Connect IQ](https://developer.garmin.com/connect-iq/connect-iq-basics/getting-started/)
- [VS Code Extension](https://marketplace.visualstudio.com/items?itemName=garmin.monkey-c)

### Vocabulaire HSK
- [HSK Academy](https://www.hskhsk.com/word-lists.html)
- [Chinese-tools.com](https://chinese-tools.com/tools/hsk.html)

---

**Bon développement ! 💻**
