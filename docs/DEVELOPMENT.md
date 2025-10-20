# Guide de Développement - Le Jardin des Langues

## 📋 Table des Matières
1. [Architecture](#architecture)
2. [Composants Principaux](#composants-principaux)
3. [Flux de Données](#flux-de-données)
4. [Personnalisation](#personnalisation)
5. [Optimisation](#optimisation)
6. [Débogage](#débogage)

## 🏗️ Architecture

### Vue d'Ensemble
L'application suit le pattern MVC (Model-View-Controller) adapté à Monkey C :
- **Model** : `QuizModel.mc` + `VocabularyData.mc`
- **View** : `MenuView.mc` + `LanguageView.mc`
- **Controller** : `MenuDelegate.mc` + `LanguageDelegate.mc`

### Diagramme de Flux
```
LanguageApp (entry point)
    ↓
    ├─→ MenuView (écran d'accueil)
    │       ↓
    │   MenuDelegate (interactions menu)
    │       ↓
    │   [Sélection mode quiz]
    │       ↓
    ├─→ LanguageView (affichage quiz)
    │       ↓
    │   QuizModel (logique + mode)
    │       ↓
    │   VocabularyData (données)
    │
    └─→ LanguageDelegate (interactions quiz)
            ↓
        LanguageView (mise à jour)
```

## 🔧 Composants Principaux

### 0. MenuView.mc & MenuDelegate.mc (v1.1+)
**Rôle** : Écran d'accueil pour choisir le mode de quiz

**MenuView - Structure** :
```monkeyc
private var selectedOption    // 0 = Normal, 1 = Inversé
private var screenHeight      // Pour calcul zones tactiles
enum QuizMode {
    NORMAL = 0,
    REVERSE = 1
}
```

**Méthodes principales** :
- `onUpdate(dc)` : Dessine le menu avec 2 options
- `drawMenuOption()` : Dessine une option (titre + description)
- `selectPreviousOption/NextOption()` : Navigation UP/DOWN
- `handleTapAt(y)` : Gère les clics tactiles
- `launchQuiz()` : Lance le quiz avec le mode sélectionné

**MenuDelegate - Interactions** :
- `onTap(clickEvent)` : Capture les clics tactiles
- `onKey()` : Gère UP/DOWN/SELECT
- `onSelect()` : Lance le quiz
- `onBack()` : Quitte l'application (comportement par défaut)

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

### 3. LanguageView.mc
**Rôle** : Affichage de l'interface utilisateur du quiz

**Variables d'état** :
```monkeyc
private var quizModel        // Instance du modèle
private var selectedOption   // Option actuellement sélectionnée (0-3)
private var feedbackState    // État du feedback (NONE/CORRECT/INCORRECT)
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

**Rendu** :
- `initialize(mode)` : Constructeur avec mode de quiz (v1.1+)
- `onUpdate(dc)` : Méthode principale de rendu (appelle la bonne méthode selon le mode)
- `drawNormalModeQuestion(dc)` : Dessine question Hanzi → Français (v1.1+)
- `drawReverseModeQuestion(dc)` : Dessine question Français → Hanzi (v1.1+)
- `drawOption(dc, index, y, width, height)` : Dessine une option
- `drawFeedback(dc)` : Dessine l'écran de feedback (adapté selon le mode)

**Interactions** :
- `selectPreviousOption()` : Navigation vers l'option précédente (bouton UP)
- `selectNextOption()` : Navigation vers l'option suivante (bouton DOWN)
- `selectOptionByIndex(index)` : Sélection directe d'une option (pour tactile)
- `handleTapAt(y)` : Calcule quelle option a été cliquée selon position Y
- `submitAnswer()` : Valide la réponse et affiche le feedback
- `nextQuestion()` : Passe à la question suivante

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
onTap(clickEvent) → TOUCH → handleTapAt(y) → Sélection + validation directe
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

### Validation d'une Réponse
```
1. Utilisateur appuie sur SELECT
2. LanguageDelegate.onSelect()
3. LanguageView.submitAnswer()
   ├─→ QuizModel.checkAnswer(selectedOption)
   │   └─→ Retourne true/false
   └─→ Mettre feedbackState à CORRECT/INCORRECT
4. WatchUi.requestUpdate()
5. LanguageView.onUpdate(dc) → drawFeedback()
6. [Utilisateur appuie à nouveau sur SELECT]
7. LanguageView.nextQuestion()
   └─→ QuizModel.generateNewQuestion()
```

## 🎨 Personnalisation

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
- [ ] Les caractères chinois s'affichent correctement
- [ ] Le pinyin est lisible
- [ ] Navigation UP/DOWN fonctionne
- [ ] Sélection correcte → Fond vert
- [ ] Sélection incorrecte → Fond rouge + correction
- [ ] Score s'incrémente correctement
- [ ] Pas de répétition immédiate des mots
- [ ] Toutes les 4 options sont différentes
- [ ] Le bouton BACK quitte l'application

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
