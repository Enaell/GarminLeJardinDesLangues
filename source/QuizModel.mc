import Toybox.Lang;
import Toybox.Math;

/**
 * QuizModel
 * Gère la logique du quiz : sélection aléatoire des mots,
 * génération des distracteurs, vérification des réponses
 */
class QuizModel {
    
    enum {
        MODE_NORMAL = 0,   // Hanzi → Français
        MODE_REVERSE = 1   // Français → Hanzi
    }
    
    // Variable statique pour conserver l'état du pinyin entre les sessions
    static private var showPinyin as Boolean = true;
    
    // Constantes pour l'algorithme d'apprentissage progressif
    private const MAX_LEARNING_POOL = 15;  // Taille du pool d'apprentissage
    private const HISTORY_SIZE = 5;         // Nombre de mots à éviter en répétition
    
    private var currentWordIndex as Number;
    private var options as Array<String>;
    private var correctAnswerPosition as Number;
    private var usedIndices as Array<Number>;
    private var score as Number;
    private var totalQuestions as Number;
    private var quizMode as Number;
    
    /**
     * Constructeur
     * @param mode Mode du quiz (MODE_NORMAL ou MODE_REVERSE)
     */
    function initialize(mode as Number) {
        currentWordIndex = -1;
        options = [] as Array<String>;
        correctAnswerPosition = 0;
        usedIndices = [] as Array<Number>;
        score = 0;
        totalQuestions = 0;
        quizMode = mode;
    }
    
    /**
     * Génère une nouvelle question
     * Sélectionne un mot selon l'algorithme d'apprentissage progressif et crée 4 options de réponse
     */
    function generateNewQuestion() as Void {
        // Sélectionner un mot selon l'algorithme d'apprentissage
        currentWordIndex = selectNextWord();
        
        // Mettre à jour l'historique des mots utilisés
        usedIndices.add(currentWordIndex);
        if (usedIndices.size() > HISTORY_SIZE) {
            // Garder seulement les 5 derniers pour éviter les répétitions à court terme
            usedIndices = usedIndices.slice(usedIndices.size() - HISTORY_SIZE, usedIndices.size());
        }
        
        // Générer les options de réponse
        generateOptions();
    }
    
    /**
     * Sélectionne le prochain mot selon l'algorithme d'apprentissage progressif
     * Logique :
     * 1. Si moins de 15 mots "Inconnus", introduire un nouveau mot et le marquer "Inconnu"
     * 2. Sinon :
     *    - 90% : Mot "Inconnu"
     *    - 9% : Mot "Connu"
     *    - 1% : Mot "Maîtrisé"
     * 3. Si une catégorie est vide, cascader vers la catégorie supérieure :
     *    Nouveau → Inconnu → Connu → Maîtrisé
     */
    private function selectNextWord() as Number {
        var unknownCount = countWordsByStatus(WordProgressStorage.STATUS_UNKNOWN);
        var newCount = countWordsWithoutStatus();
        
        // Phase 1 : Introduction progressive (pool de 15 mots "Inconnus")
        if (unknownCount < MAX_LEARNING_POOL && newCount > 0) {
            var newWordIndex = getRandomNewWord();
            // Marquer automatiquement comme "Inconnu" lors de la première introduction
            VocabularyData.setWordStatus(newWordIndex, WordProgressStorage.STATUS_UNKNOWN);
            return newWordIndex;
        }
        
        // Phase 2 : Système de probabilités (90% / 9% / 1%)
        var rand = Math.rand() % 100; // 0-99
        var selectedIndex;
        
        if (rand < 90) {
            // 90% : Mot "Inconnu"
            selectedIndex = getRandomWordByStatus(WordProgressStorage.STATUS_UNKNOWN);
            if (selectedIndex == -1) {
                // Cascade : Inconnu → Nouveau → Connu → Maîtrisé
                selectedIndex = getRandomNewWord();
                if (selectedIndex == -1) {
                    selectedIndex = getRandomWordByStatus(WordProgressStorage.STATUS_KNOWN);
                    if (selectedIndex == -1) {
                        selectedIndex = getRandomWordByStatus(WordProgressStorage.STATUS_MASTERED);
                    }
                }
            }
        } else if (rand < 99) {
            // 9% : Mot "Connu"
            selectedIndex = getRandomWordByStatus(WordProgressStorage.STATUS_KNOWN);
            if (selectedIndex == -1) {
                // Cascade : Connu → Maîtrisé → Inconnu → Nouveau
                selectedIndex = getRandomWordByStatus(WordProgressStorage.STATUS_MASTERED);
                if (selectedIndex == -1) {
                    selectedIndex = getRandomWordByStatus(WordProgressStorage.STATUS_UNKNOWN);
                    if (selectedIndex == -1) {
                        selectedIndex = getRandomNewWord();
                    }
                }
            }
        } else {
            // 1% : Mot "Maîtrisé"
            selectedIndex = getRandomWordByStatus(WordProgressStorage.STATUS_MASTERED);
            if (selectedIndex == -1) {
                // Cascade : Maîtrisé → Connu → Inconnu → Nouveau
                selectedIndex = getRandomWordByStatus(WordProgressStorage.STATUS_KNOWN);
                if (selectedIndex == -1) {
                    selectedIndex = getRandomWordByStatus(WordProgressStorage.STATUS_UNKNOWN);
                    if (selectedIndex == -1) {
                        selectedIndex = getRandomNewWord();
                    }
                }
            }
        }
        
        // Fallback de sécurité : si aucun mot trouvé, prendre un mot au hasard
        if (selectedIndex == -1) {
            selectedIndex = Math.rand() % VocabularyData.getVocabularySize();
        }
        
        return selectedIndex;
    }
    
    /**
     * Compte les mots ayant un statut donné
     * Utilise le cache pour performance optimale
     */
    private function countWordsByStatus(status as Number) as Number {
        return VocabularyData.getIndicesByStatus(status).size();
    }
    
    /**
     * Compte les mots sans statut (nouveaux mots jamais vus)
     * Utilise le cache pour performance optimale
     */
    private function countWordsWithoutStatus() as Number {
        return VocabularyData.getIndicesWithoutStatus().size();
    }
    
    /**
     * Récupère un mot aléatoire sans statut (nouveau)
     * Priorise les niveaux HSK : HSK 1 → HSK 2 → HSK 3
     * Utilise les caches pour performance optimale
     * @return Index du mot, ou -1 si aucun mot nouveau disponible
     */
    private function getRandomNewWord() as Number {
        // Chercher d'abord parmi les niveaux HSK dans l'ordre (1 → 2 → 3)
        for (var hskLevel = 1; hskLevel <= 3; hskLevel++) {
            var hskIndices = VocabularyData.getIndicesByHskLevel(hskLevel);
            var noStatusIndices = VocabularyData.getIndicesWithoutStatus();
            var candidates = [] as Array<Number>;
            
            // Intersection : mots de ce niveau HSK ET sans statut ET non récemment utilisés
            for (var i = 0; i < hskIndices.size(); i++) {
                var wordIndex = hskIndices[i] as Number;
                
                if (noStatusIndices.indexOf(wordIndex) != -1 && !isRecentlyUsed(wordIndex)) {
                    candidates.add(wordIndex);
                }
            }
            
            // Si des candidats trouvés pour ce niveau, en sélectionner un aléatoirement
            if (candidates.size() > 0) {
                return candidates[Math.rand() % candidates.size()] as Number;
            }
        }
        
        // Si aucun mot non récent trouvé, accepter un mot récemment utilisé (en respectant HSK)
        for (var hskLevel = 1; hskLevel <= 3; hskLevel++) {
            var hskIndices = VocabularyData.getIndicesByHskLevel(hskLevel);
            var noStatusIndices = VocabularyData.getIndicesWithoutStatus();
            
            for (var i = 0; i < hskIndices.size(); i++) {
                var wordIndex = hskIndices[i] as Number;
                
                if (noStatusIndices.indexOf(wordIndex) != -1) {
                    return wordIndex;
                }
            }
        }
        
        // Aucun nouveau mot disponible
        return -1;
    }
    
    /**
     * Récupère un mot aléatoire ayant un statut donné
     * Utilise les caches pour performance optimale
     * @param status Statut recherché
     * @return Index du mot, ou -1 si aucun mot avec ce statut disponible
     */
    private function getRandomWordByStatus(status as Number) as Number {
        var statusIndices = VocabularyData.getIndicesByStatus(status);
        var candidates = [] as Array<Number>;
        
        // Collecter tous les mots avec ce statut non récemment utilisés
        for (var i = 0; i < statusIndices.size(); i++) {
            var wordIndex = statusIndices[i] as Number;
            
            if (!isRecentlyUsed(wordIndex)) {
                candidates.add(wordIndex);
            }
        }
        
        // Si aucun candidat, accepter des mots récemment utilisés
        if (candidates.size() == 0) {
            candidates = statusIndices;
        }
        
        // Sélectionner un candidat aléatoire
        if (candidates.size() > 0) {
            return candidates[Math.rand() % candidates.size()] as Number;
        }
        
        // Aucun mot avec ce statut
        return -1;
    }
    
    /**
     * Vérifie si un mot a été utilisé récemment
     */
    private function isRecentlyUsed(index as Number) as Boolean {
        return usedIndices.indexOf(index) != -1;
    }
    
    /**
     * Génère 4 options de réponse (1 correcte + 3 distracteurs)
     * En mode NORMAL : options = traductions françaises
     * En mode REVERSE : options = hanzi
     */
    private function generateOptions() as Void {
        options = [] as Array<String>;
        var vocabSize = VocabularyData.getVocabularySize();
        
        // Ajouter la bonne réponse selon le mode
        var correctAnswer;
        if (quizMode == MODE_NORMAL) {
            correctAnswer = VocabularyData.getTranslation(currentWordIndex);
        } else {
            correctAnswer = VocabularyData.getHanzi(currentWordIndex);
        }
        options.add(correctAnswer);
        
        // Générer 3 distracteurs
        var distractorIndices = [] as Array<Number>;
        while (distractorIndices.size() < 3) {
            var randomIndex = Math.rand() % vocabSize;
            
            // S'assurer que le distracteur est différent de la réponse correcte
            // et qu'il n'a pas déjà été ajouté
            if (randomIndex != currentWordIndex && 
                distractorIndices.indexOf(randomIndex) == -1) {
                var distractor;
                if (quizMode == MODE_NORMAL) {
                    distractor = VocabularyData.getTranslation(randomIndex);
                } else {
                    distractor = VocabularyData.getHanzi(randomIndex);
                }
                
                // Éviter les doublons
                if (options.indexOf(distractor) == -1) {
                    distractorIndices.add(randomIndex);
                    options.add(distractor);
                }
            }
        }
        
        // Mélanger les options aléatoirement
        shuffleOptions();
    }
    
    /**
     * Mélange les options de réponse et mémorise la position de la bonne réponse
     */
    private function shuffleOptions() as Void {
        var correctAnswer = options[0] as String;
        
        // Algorithme de Fisher-Yates pour mélanger
        for (var i = options.size() - 1; i > 0; i--) {
            var j = Math.rand() % (i + 1);
            var temp = options[i];
            options[i] = options[j];
            options[j] = temp;
        }
        
        // Trouver la nouvelle position de la bonne réponse
        correctAnswerPosition = 0;
        for (var i = 0; i < options.size(); i++) {
            if (options[i].equals(correctAnswer)) {
                correctAnswerPosition = i;
                break;
            }
        }
    }
    
    /**
     * Vérifie si la réponse sélectionnée est correcte
     * @param selectedPosition Position de l'option sélectionnée (0-3)
     * @return true si correct, false sinon
     */
    function checkAnswer(selectedPosition as Number) as Boolean {
        totalQuestions++;
        
        if (selectedPosition == correctAnswerPosition) {
            score++;
            return true;
        }
        return false;
    }
    
    /**
     * Retourne le hanzi du mot actuel
     */
    function getCurrentHanzi() as String {
        if (currentWordIndex >= 0) {
            return VocabularyData.getHanzi(currentWordIndex);
        }
        return "";
    }
    
    /**
     * Retourne le pinyin du mot actuel
     */
    function getCurrentPinyin() as String {
        if (currentWordIndex >= 0) {
            return VocabularyData.getPinyin(currentWordIndex);
        }
        return "";
    }
    
    /**
     * Retourne la traduction correcte du mot actuel
     */
    function getCorrectTranslation() as String {
        if (currentWordIndex >= 0) {
            return VocabularyData.getTranslation(currentWordIndex);
        }
        return "";
    }
    
    /**
     * Retourne le niveau HSK du mot actuel
     */
    function getCurrentHskLevel() as Number {
        if (currentWordIndex >= 0) {
            return VocabularyData.getHskLevel(currentWordIndex);
        }
        return 1;
    }
    
    /**
     * Retourne les 4 options de réponse
     */
    function getOptions() as Array<String> {
        return options;
    }
    
    /**
     * Retourne l'option à une position donnée
     */
    function getOption(index as Number) as String {
        if (index >= 0 && index < options.size()) {
            return options[index] as String;
        }
        return "";
    }
    
    /**
     * Retourne la position de la réponse correcte (0-3)
     */
    function getCorrectAnswerPosition() as Number {
        return correctAnswerPosition;
    }
    
    /**
     * Retourne le score actuel
     */
    function getScore() as Number {
        return score;
    }
    
    /**
     * Retourne le nombre total de questions posées
     */
    function getTotalQuestions() as Number {
        return totalQuestions;
    }
    
    /**
     * Réinitialise le score
     */
    function resetScore() as Void {
        score = 0;
        totalQuestions = 0;
        usedIndices = [] as Array<Number>;
    }
    
    /**
     * Retourne le pourcentage de réussite
     */
    function getSuccessRate() as Float {
        if (totalQuestions == 0) {
            return 0.0f;
        }
        return (score.toFloat() / totalQuestions.toFloat()) * 100.0f;
    }
    
    /**
     * Retourne le mode de quiz actuel
     */
    function getQuizMode() as Number {
        return quizMode;
    }
    
    /**
     * Bascule l'affichage du pinyin
     * @return Le nouvel état (true = affiché, false = caché)
     */
    static function togglePinyin() as Boolean {
        showPinyin = !showPinyin;
        return showPinyin;
    }
    
    /**
     * Retourne l'état actuel de l'affichage du pinyin
     */
    static function isPinyinVisible() as Boolean {
        return showPinyin;
    }
    
    /**
     * Active l'affichage du pinyin
     */
    static function showPinyinDisplay() as Void {
        showPinyin = true;
    }
    
    /**
     * Désactive l'affichage du pinyin
     */
    static function hidePinyinDisplay() as Void {
        showPinyin = false;
    }
    
    /**
     * Définit le statut de maîtrise du mot actuel
     * @param status Statut (WordProgressStorage.STATUS_MASTERED/KNOWN/UNKNOWN)
     */
    function setCurrentWordStatus(status as Number) as Void {
        if (currentWordIndex >= 0) {
            VocabularyData.setWordStatus(currentWordIndex, status);
        }
    }
    
    /**
     * Récupère le statut de maîtrise du mot actuel
     * @return Statut (WordProgressStorage.STATUS_MASTERED/KNOWN/UNKNOWN)
     */
    function getCurrentWordStatus() as Number {
        if (currentWordIndex >= 0) {
            return VocabularyData.getWordStatus(currentWordIndex);
        }
        return WordProgressStorage.STATUS_UNKNOWN;
    }
    
    /**
     * Retourne l'index du mot actuel
     */
    function getCurrentWordIndex() as Number {
        return currentWordIndex;
    }
}
