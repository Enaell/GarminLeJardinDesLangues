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
     * Sélectionne un mot aléatoire et crée 4 options de réponse
     */
    function generateNewQuestion() as Void {
        var vocabSize = VocabularyData.getVocabularySize();
        
        // Sélectionner un mot aléatoire (éviter les répétitions récentes)
        currentWordIndex = getRandomWordIndex(vocabSize);
        
        // Mettre à jour l'historique des mots utilisés
        usedIndices.add(currentWordIndex);
        if (usedIndices.size() > 20) {
            // Garder seulement les 20 derniers pour éviter les répétitions à court terme
            usedIndices = usedIndices.slice(usedIndices.size() - 20, usedIndices.size());
        }
        
        // Générer les options de réponse
        generateOptions();
    }
    
    /**
     * Génère un index aléatoire qui n'a pas été utilisé récemment
     */
    private function getRandomWordIndex(maxIndex as Number) as Number {
        var attempts = 0;
        var index = Math.rand() % maxIndex;
        
        // Essayer de trouver un index non utilisé récemment (max 10 tentatives)
        while (attempts < 10 && usedIndices.indexOf(index) != -1) {
            index = Math.rand() % maxIndex;
            attempts++;
        }
        
        return index;
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
}
