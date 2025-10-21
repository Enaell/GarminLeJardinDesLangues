import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

class LanguageView extends WatchUi.View {

    private var quizModel as QuizModel;
    private var selectedOption as Number;
    private var feedbackState as Number; // 0: none, 1: correct, 2: incorrect
    private var screenHeight as Number; // Hauteur de l'écran
    
    enum {
        FEEDBACK_NONE = 0,
        FEEDBACK_CORRECT = 1,
        FEEDBACK_INCORRECT = 2
    }

    function initialize(mode as Number) {
        View.initialize();
        quizModel = new QuizModel(mode);
        selectedOption = 0;
        feedbackState = FEEDBACK_NONE;
        screenHeight = 0; // Sera initialisé dans onUpdate
        
        // Générer la première question
        quizModel.generateNewQuestion();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        // Pas de layout XML, on dessine tout manuellement
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;
        
        // Sauvegarder la hauteur de l'écran pour la gestion des clics
        screenHeight = height;
        
        // Fond noir
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        // Afficher le feedback si actif
        if (feedbackState != FEEDBACK_NONE) {
            drawFeedback(dc);
            return;
        }
        
        // Afficher la question selon le mode
        if (quizModel.getQuizMode() == QuizModel.MODE_NORMAL) {
            drawNormalModeQuestion(dc, width, height, centerX);
        } else {
            drawReverseModeQuestion(dc, width, height, centerX);
        }
        
        // --- Séparateur ---
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawLine(width * 0.1, height * 0.35, width * 0.9, height * 0.35);
        
        // --- Options de réponse (4 choix) ---
        var optionStartY = (height * 40) / 100;
        var optionHeight = (height * 50) / 100 / 4;
        
        for (var i = 0; i < 4; i++) {
            var optionY = optionStartY + (i * optionHeight);
            drawOption(dc, i, optionY, width, optionHeight);
        }
        
        // --- Score en bas ---
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        var scoreText = quizModel.getScore().format("%d") + "/" + 
                       quizModel.getTotalQuestions().format("%d");
        dc.drawText(
            centerX,
            height * 0.95,
            Graphics.FONT_SYSTEM_XTINY,
            scoreText,
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
    }
    
    /**
     * Affiche la question en mode normal (Hanzi → Français)
     */
    private function drawNormalModeQuestion(dc as Dc, width as Number, 
                                           height as Number, centerX as Number) as Void {
        // --- Zone supérieure: Hanzi (caractères chinois) ---
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            height * 0.15,
            Graphics.FONT_SYSTEM_LARGE,
            quizModel.getCurrentHanzi(),
            Graphics.TEXT_JUSTIFY_CENTER
        );
        
        // --- Pinyin (optionnel, petit texte sous le hanzi) ---
        if (QuizModel.isPinyinVisible()) {
            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawText(
                centerX,
                height * 0.28,
                Graphics.FONT_SYSTEM_XTINY,
                quizModel.getCurrentPinyin(),
                Graphics.TEXT_JUSTIFY_CENTER
            );
        } else {
            // Indicateur que le pinyin est caché - Cliquer ici pour afficher
            dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawText(
                centerX,
                height * 0.28,
                Graphics.FONT_SYSTEM_XTINY,
                "[Tap: Pinyin]",
                Graphics.TEXT_JUSTIFY_CENTER
            );
        }
    }
    
    /**
     * Affiche la question en mode inversé (Français → Hanzi)
     */
    private function drawReverseModeQuestion(dc as Dc, width as Number, 
                                            height as Number, centerX as Number) as Void {
        // --- Zone supérieure: Traduction française ---
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            height * 0.15,
            Graphics.FONT_SYSTEM_MEDIUM,
            quizModel.getCorrectTranslation(),
            Graphics.TEXT_JUSTIFY_CENTER
        );
        
        // --- Pinyin (indice) ---
        if (QuizModel.isPinyinVisible()) {
            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawText(
                centerX,
                height * 0.28,
                Graphics.FONT_SYSTEM_XTINY,
                "(" + quizModel.getCurrentPinyin() + ")",
                Graphics.TEXT_JUSTIFY_CENTER
            );
        } else {
            // Indicateur que le pinyin est caché - Cliquer ici pour afficher
            dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawText(
                centerX,
                height * 0.28,
                Graphics.FONT_SYSTEM_XTINY,
                "[Tap: Pinyin]",
                Graphics.TEXT_JUSTIFY_CENTER
            );
        }
    }
    
    /**
     * Dessine une option de réponse
     */
    private function drawOption(dc as Dc, index as Number, y as Number, 
                               width as Number, height as Number) as Void {
        var isSelected = (index == selectedOption);
        
        // Fond de l'option sélectionnée
        if (isSelected) {
            dc.setColor(Graphics.COLOR_DK_BLUE, Graphics.COLOR_DK_BLUE);
            dc.fillRectangle(width * 0.05, y - 2, width * 0.9, height - 4);
        }
        
        // Numéro de l'option
        dc.setColor(isSelected ? Graphics.COLOR_WHITE : Graphics.COLOR_LT_GRAY, 
                   Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            width * 0.1,
            y + height / 2,
            Graphics.FONT_SYSTEM_XTINY,
            (index + 1).format("%d"),
            Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER
        );
        
        // Texte de l'option
        dc.setColor(isSelected ? Graphics.COLOR_WHITE : Graphics.COLOR_LT_GRAY, 
                   Graphics.COLOR_TRANSPARENT);
        var optionText = quizModel.getOption(index);
        dc.drawText(
            width * 0.2,
            y + height / 2,
            Graphics.FONT_SYSTEM_TINY,
            optionText,
            Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER
        );
    }
    
    /**
     * Dessine le feedback (bonne/mauvaise réponse)
     */
    private function drawFeedback(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;
        var centerY = height / 2;
        
        // Fond coloré selon le résultat
        if (feedbackState == FEEDBACK_CORRECT) {
            dc.setColor(Graphics.COLOR_DK_GREEN, Graphics.COLOR_DK_GREEN);
        } else {
            dc.setColor(Graphics.COLOR_DK_RED, Graphics.COLOR_DK_RED);
        }
        dc.clear();
        
        // Icône et texte
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        if (feedbackState == FEEDBACK_CORRECT) {
            dc.drawText(centerX, centerY - 40, Graphics.FONT_SYSTEM_LARGE, 
                       "✓", Graphics.TEXT_JUSTIFY_CENTER);
            dc.drawText(centerX, centerY, Graphics.FONT_SYSTEM_MEDIUM, 
                       "Correct!", Graphics.TEXT_JUSTIFY_CENTER);
        } else {
            dc.drawText(centerX, centerY - 40, Graphics.FONT_SYSTEM_LARGE, 
                       "✗", Graphics.TEXT_JUSTIFY_CENTER);
            dc.drawText(centerX, centerY - 20, Graphics.FONT_SYSTEM_MEDIUM, 
                       "Incorrect", Graphics.TEXT_JUSTIFY_CENTER);
            
            // Afficher la bonne réponse selon le mode
            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
            if (quizModel.getQuizMode() == QuizModel.MODE_NORMAL) {
                // Mode normal : afficher la traduction
                dc.drawText(centerX, centerY + 10, Graphics.FONT_SYSTEM_SMALL, 
                           quizModel.getCorrectTranslation(), 
                           Graphics.TEXT_JUSTIFY_CENTER);
            } else {
                // Mode inversé : afficher le hanzi + pinyin
                dc.drawText(centerX, centerY + 5, Graphics.FONT_SYSTEM_MEDIUM, 
                           quizModel.getCurrentHanzi(), 
                           Graphics.TEXT_JUSTIFY_CENTER);
                dc.drawText(centerX, centerY + 30, Graphics.FONT_SYSTEM_XTINY, 
                           quizModel.getCurrentPinyin(), 
                           Graphics.TEXT_JUSTIFY_CENTER);
            }
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }
    
    /**
     * Navigue vers l'option précédente
     */
    function selectPreviousOption() as Void {
        if (feedbackState != FEEDBACK_NONE) {
            return; // Pas de navigation pendant le feedback
        }
        
        selectedOption--;
        if (selectedOption < 0) {
            selectedOption = 3;
        }
        WatchUi.requestUpdate();
    }
    
    /**
     * Navigue vers l'option suivante
     */
    function selectNextOption() as Void {
        if (feedbackState != FEEDBACK_NONE) {
            return; // Pas de navigation pendant le feedback
        }
        
        selectedOption++;
        if (selectedOption > 3) {
            selectedOption = 0;
        }
        WatchUi.requestUpdate();
    }
    
    /**
     * Sélectionne directement une option par son index (pour les clics tactiles)
     */
    function selectOptionByIndex(index as Number) as Void {
        if (feedbackState != FEEDBACK_NONE) {
            return; // Pas de sélection pendant le feedback
        }
        
        if (index >= 0 && index < 4) {
            selectedOption = index;
            WatchUi.requestUpdate();
        }
    }
    
    /**
     * Gère un clic/tap à une position Y donnée
     * Calcule quelle option a été cliquée et la sélectionne/valide
     * Ou bascule le pinyin si clic en haut de l'écran
     */
    function handleTapAt(y as Number) as Boolean {
        if (feedbackState != FEEDBACK_NONE) {
            // Si on est en feedback, passer à la question suivante
            nextQuestion();
            return true;
        }
        
        // Utiliser la hauteur d'écran sauvegardée
        if (screenHeight == 0) {
            return false; // Pas encore initialisé
        }
        
        // Zone supérieure (0-35% de l'écran) : Basculer le pinyin
        var pinyinZoneEnd = (screenHeight * 35) / 100;
        if (y < pinyinZoneEnd) {
            togglePinyin();
            return true;
        }
        
        var optionStartY = (screenHeight * 40) / 100;
        var optionHeight = (screenHeight * 50) / 100 / 4;
        
        // Déterminer quelle option a été cliquée en fonction de la position Y
        if (y >= optionStartY) {
            var relativeY = y - optionStartY;
            var clickedOption = relativeY / optionHeight;
            
            if (clickedOption >= 0 && clickedOption < 4) {
                // Sélectionner l'option cliquée et valider immédiatement
                selectOptionByIndex(clickedOption);
                submitAnswer();
                return true;
            }
        }
        
        return false;
    }
    
    /**
     * Valide la réponse sélectionnée
     */
    function submitAnswer() as Boolean {
        if (feedbackState != FEEDBACK_NONE) {
            // Si on est en feedback, passer à la question suivante
            nextQuestion();
            return true;
        }
        
        // Vérifier la réponse
        var isCorrect = quizModel.checkAnswer(selectedOption);
        
        // Afficher le feedback
        feedbackState = isCorrect ? FEEDBACK_CORRECT : FEEDBACK_INCORRECT;
        WatchUi.requestUpdate();
        
        return true;
    }
    
    /**
     * Passe à la question suivante
     */
    function nextQuestion() as Void {
        feedbackState = FEEDBACK_NONE;
        selectedOption = 0;
        quizModel.generateNewQuestion();
        WatchUi.requestUpdate();
    }
    
    /**
     * Retourne le modèle de quiz
     */
    function getQuizModel() as QuizModel {
        return quizModel;
    }
    
    /**
     * Bascule l'affichage du pinyin
     */
    function togglePinyin() as Void {
        QuizModel.togglePinyin();
        WatchUi.requestUpdate();
    }

}
