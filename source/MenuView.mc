import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

/**
 * MenuView
 * Écran d'accueil permettant de choisir le type de quiz
 */
class MenuView extends WatchUi.View {

    private var selectedOption as Number;
    private var screenHeight as Number;
    
    enum QuizMode {
        NORMAL = 0,    // Hanzi → Français
        REVERSE = 1    // Français → Hanzi
    }

    function initialize() {
        View.initialize();
        selectedOption = 0; // Par défaut : quiz normal
        screenHeight = 0;
    }

    function onLayout(dc as Dc) as Void {
        // Pas de layout XML, on dessine tout manuellement
    }

    function onShow() as Void {
    }

    function onUpdate(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;
        
        screenHeight = height;
        
        // Fond noir
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        // --- Titre de l'application ---
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            (height * 0.15).toNumber(),
            Graphics.FONT_SYSTEM_MEDIUM,
            "Le Jardin",
            Graphics.TEXT_JUSTIFY_CENTER
        );
        
        dc.drawText(
            centerX,
            (height * 0.25).toNumber(),
            Graphics.FONT_SYSTEM_MEDIUM,
            "des Langues",
            Graphics.TEXT_JUSTIFY_CENTER
        );
        
        // --- Sous-titre ---
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            (height * 0.35).toNumber(),
            Graphics.FONT_SYSTEM_XTINY,
            "Choisissez votre quiz",
            Graphics.TEXT_JUSTIFY_CENTER
        );
        
        // --- Séparateur ---
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawLine((width * 0.1).toNumber(), (height * 0.42).toNumber(), 
                   (width * 0.9).toNumber(), (height * 0.42).toNumber());
        
        // --- Option 1 : Quiz Normal (Hanzi → Français) ---
        drawMenuOption(dc, 0, (height * 0.50).toNumber(), width, (height * 0.15).toNumber(),
                      "汉字 → Français", "");
        
        // --- Option 2 : Quiz Inversé (Français → Hanzi) ---
        drawMenuOption(dc, 1, (height * 0.68).toNumber(), width, (height * 0.15).toNumber(),
                      "Français → 汉字", "");
        
        // --- Instructions en bas ---
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            (height * 0.90).toNumber(),
            Graphics.FONT_SYSTEM_XTINY,
            "↑↓ pour choisir • SELECT pour lancer",
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }
    
    /**
     * Dessine une option du menu
     */
    private function drawMenuOption(dc as Dc, index as Number, y as Number, 
                                   width as Number, height as Number,
                                   title as String, subtitle as String) as Void {
        var isSelected = (index == selectedOption);
        var centerX = width / 2;
        var centerY = y + height / 2;
        
        // Fond de l'option sélectionnée
        if (isSelected) {
            dc.setColor(Graphics.COLOR_DK_BLUE, Graphics.COLOR_DK_BLUE);
            dc.fillRectangle((width * 0.05).toNumber(), y, (width * 0.9).toNumber(), height);
        }
        
        // Titre de l'option
        dc.setColor(isSelected ? Graphics.COLOR_WHITE : Graphics.COLOR_LT_GRAY, 
                   Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            centerY - 10,
            Graphics.FONT_SYSTEM_SMALL,
            title,
            Graphics.TEXT_JUSTIFY_CENTER
        );
        
        // Sous-titre avec les symboles
        dc.setColor(isSelected ? Graphics.COLOR_LT_GRAY : Graphics.COLOR_DK_GRAY, 
                   Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            centerY + 12,
            Graphics.FONT_SYSTEM_XTINY,
            subtitle,
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }

    function onHide() as Void {
    }
    
    /**
     * Navigue vers l'option précédente
     */
    function selectPreviousOption() as Void {
        selectedOption--;
        if (selectedOption < 0) {
            selectedOption = 1; // 2 options (0 et 1)
        }
        WatchUi.requestUpdate();
    }
    
    /**
     * Navigue vers l'option suivante
     */
    function selectNextOption() as Void {
        selectedOption++;
        if (selectedOption > 1) {
            selectedOption = 0;
        }
        WatchUi.requestUpdate();
    }
    
    /**
     * Gère un clic/tap à une position Y donnée
     */
    function handleTapAt(y as Number) as Boolean {
        if (screenHeight == 0) {
            return false;
        }
        
        // Zone option 1 (Quiz Normal) : 50% - 65% de la hauteur
        var option1Start = (screenHeight * 0.50).toNumber();
        var option1End = (screenHeight * 0.65).toNumber();
        
        // Zone option 2 (Quiz Inversé) : 68% - 83% de la hauteur
        var option2Start = (screenHeight * 0.68).toNumber();
        var option2End = (screenHeight * 0.83).toNumber();
        
        if (y >= option1Start && y < option1End) {
            selectedOption = 0;
            WatchUi.requestUpdate();
            return true;
        } else if (y >= option2Start && y < option2End) {
            selectedOption = 1;
            WatchUi.requestUpdate();
            return true;
        }
        
        return false;
    }
    
    /**
     * Lance le quiz avec le mode sélectionné
     */
    function launchQuiz() as Void {
        var quizMode = (selectedOption == 0) ? QuizModel.MODE_NORMAL : QuizModel.MODE_REVERSE;
        var view = new LanguageView(quizMode);
        WatchUi.switchToView(view, new LanguageDelegate(view), WatchUi.SLIDE_LEFT);
    }
    
    /**
     * Retourne l'option sélectionnée
     */
    function getSelectedOption() as Number {
        return selectedOption;
    }

}
