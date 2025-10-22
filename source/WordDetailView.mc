import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

/**
 * WordDetailView
 * Affiche les détails d'un mot et permet de modifier son statut
 */
class WordDetailView extends WatchUi.View {

    private var wordIndex as Number;
    private var currentStatus as Number;
    private var editMode as Boolean; // Mode édition du statut activé ?
    private var selectedStatusOption as Number; // Option de statut sélectionnée (0-2)
    
    function initialize(index as Number) {
        View.initialize();
        wordIndex = index;
        currentStatus = VocabularyData.getWordStatus(index);
        editMode = false;
        selectedStatusOption = currentStatus; // Par défaut : statut actuel
    }

    function onLayout(dc as Dc) as Void {
        // Pas de layout XML
    }

    function onShow() as Void {
    }

    function onUpdate(dc as Dc) as Void {
        if (editMode) {
            drawEditMode(dc);
        } else {
            drawDetailMode(dc);
        }
    }
    
    /**
     * Affichage du mode détail (consultation)
     */
    private function drawDetailMode(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;
        
        // Fond noir
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        // Récupérer les données du mot
        var hanzi = VocabularyData.getHanzi(wordIndex);
        var pinyin = VocabularyData.getPinyin(wordIndex);
        var translation = VocabularyData.getTranslation(wordIndex);
        var hskLevel = VocabularyData.getHskLevel(wordIndex);
        
        // --- En-tête : Numéro du mot ---
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            (height * 0.05).toNumber(),
            Graphics.FONT_SYSTEM_XTINY,
            "Mot #" + (wordIndex + 1),
            Graphics.TEXT_JUSTIFY_CENTER
        );
        
        // --- Hanzi (grand) ---
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            (height * 0.18).toNumber(),
            Graphics.FONT_SYSTEM_LARGE,
            hanzi,
            Graphics.TEXT_JUSTIFY_CENTER
        );
        
        // --- Pinyin ---
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            (height * 0.32).toNumber(),
            Graphics.FONT_SYSTEM_SMALL,
            pinyin,
            Graphics.TEXT_JUSTIFY_CENTER
        );
        
        // --- Séparateur ---
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawLine((width * 0.15).toNumber(), (height * 0.42).toNumber(), 
                   (width * 0.85).toNumber(), (height * 0.42).toNumber());
        
        // --- Traduction ---
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            (height * 0.50).toNumber(),
            Graphics.FONT_SYSTEM_MEDIUM,
            translation,
            Graphics.TEXT_JUSTIFY_CENTER
        );
        
        // --- Niveau HSK ---
        dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            (height * 0.62).toNumber(),
            Graphics.FONT_SYSTEM_TINY,
            "HSK " + hskLevel,
            Graphics.TEXT_JUSTIFY_CENTER
        );
        
        // --- Séparateur ---
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawLine((width * 0.15).toNumber(), (height * 0.72).toNumber(), 
                   (width * 0.85).toNumber(), (height * 0.72).toNumber());
        
        // --- Statut actuel ---
        var statusText = getStatusText(currentStatus);
        var statusColor = getStatusColor(currentStatus);
        var statusIcon = getStatusIcon(currentStatus);
        
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            (height * 0.76).toNumber(),
            Graphics.FONT_SYSTEM_XTINY,
            "Statut:",
            Graphics.TEXT_JUSTIFY_CENTER
        );
        
        dc.setColor(statusColor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            (height * 0.82).toNumber(),
            Graphics.FONT_SYSTEM_TINY,
            statusIcon + " " + statusText,
            Graphics.TEXT_JUSTIFY_CENTER
        );
        
        // --- Instructions en bas ---
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            (height * 0.93).toNumber(),
            Graphics.FONT_SYSTEM_XTINY,
            "Tap Statut • BACK retour",
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }
    
    /**
     * Affichage du mode édition (modification du statut)
     */
    private function drawEditMode(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;
        
        // Fond noir
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        // --- Titre ---
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            (height * 0.08).toNumber(),
            Graphics.FONT_SYSTEM_SMALL,
            "Modifier le statut",
            Graphics.TEXT_JUSTIFY_CENTER
        );
        
        // --- Mot concerné ---
        var hanzi = VocabularyData.getHanzi(wordIndex);
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            (height * 0.18).toNumber(),
            Graphics.FONT_SYSTEM_MEDIUM,
            hanzi,
            Graphics.TEXT_JUSTIFY_CENTER
        );
        
        // --- Séparateur ---
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawLine((width * 0.10).toNumber(), (height * 0.28).toNumber(), 
                   (width * 0.90).toNumber(), (height * 0.28).toNumber());
        
        // --- Options de statut ---
        var optionHeight = ((height * 0.17)).toNumber();
        
        // Option 1 : Maîtrisé
        drawStatusOption(dc, 0, (height * 0.35).toNumber(), width, optionHeight,
                        "✓ Maîtrisé", Graphics.COLOR_GREEN);
        
        // Option 2 : Connu
        drawStatusOption(dc, 1, (height * 0.52).toNumber(), width, optionHeight,
                        "○ Connu", Graphics.COLOR_ORANGE);
        
        // Option 3 : Inconnu
        drawStatusOption(dc, 2, (height * 0.69).toNumber(), width, optionHeight,
                        "✗ Inconnu", Graphics.COLOR_RED);
        
        // --- Instructions en bas ---
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            (height * 0.93).toNumber(),
            Graphics.FONT_SYSTEM_XTINY,
            "↑↓ • Tap • SELECT • BACK annuler",
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }
    
    /**
     * Dessine une option de statut
     */
    private function drawStatusOption(dc as Dc, index as Number, y as Number, 
                                     width as Number, height as Number,
                                     label as String, color as Number) as Void {
        var isSelected = (index == selectedStatusOption);
        var centerX = width / 2;
        var centerY = y + height / 2;
        
        // Fond de l'option sélectionnée
        if (isSelected) {
            dc.setColor(Graphics.COLOR_DK_BLUE, Graphics.COLOR_DK_BLUE);
            dc.fillRectangle((width * 0.05).toNumber(), y, (width * 0.90).toNumber(), height);
        }
        
        // Label avec couleur
        dc.setColor(isSelected ? color : Graphics.COLOR_DK_GRAY, 
                   Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            centerY - 8,
            Graphics.FONT_SYSTEM_SMALL,
            label,
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }
    
    /**
     * Retourne le texte du statut
     */
    private function getStatusText(status as Number) as String {
        if (status == WordProgressStorage.STATUS_MASTERED) {
            return "Maîtrisé";
        } else if (status == WordProgressStorage.STATUS_KNOWN) {
            return "Connu";
        } else {
            return "Inconnu";
        }
    }
    
    /**
     * Retourne l'icône du statut
     */
    private function getStatusIcon(status as Number) as String {
        if (status == WordProgressStorage.STATUS_MASTERED) {
            return "✓";
        } else if (status == WordProgressStorage.STATUS_KNOWN) {
            return "○";
        } else {
            return "✗";
        }
    }
    
    /**
     * Retourne la couleur du statut
     */
    private function getStatusColor(status as Number) as Number {
        if (status == WordProgressStorage.STATUS_MASTERED) {
            return Graphics.COLOR_GREEN;
        } else if (status == WordProgressStorage.STATUS_KNOWN) {
            return Graphics.COLOR_ORANGE;
        } else {
            return Graphics.COLOR_RED;
        }
    }
    
    /**
     * Active le mode édition
     */
    function enterEditMode() as Void {
        editMode = true;
        selectedStatusOption = currentStatus;
        WatchUi.requestUpdate();
    }
    
    /**
     * Annule le mode édition
     */
    function cancelEditMode() as Void {
        editMode = false;
        WatchUi.requestUpdate();
    }
    
    /**
     * Navigue vers l'option de statut précédente
     */
    function selectPreviousStatusOption() as Void {
        selectedStatusOption--;
        if (selectedStatusOption < 0) {
            selectedStatusOption = 2;
        }
        WatchUi.requestUpdate();
    }
    
    /**
     * Navigue vers l'option de statut suivante
     */
    function selectNextStatusOption() as Void {
        selectedStatusOption++;
        if (selectedStatusOption > 2) {
            selectedStatusOption = 0;
        }
        WatchUi.requestUpdate();
    }
    
    /**
     * Sauvegarde le nouveau statut et quitte le mode édition
     */
    function saveStatus() as Void {
        VocabularyData.setWordStatus(wordIndex, selectedStatusOption);
        currentStatus = selectedStatusOption;
        editMode = false;
        WatchUi.requestUpdate();
    }
    
    /**
     * Vérifie si on est en mode édition
     */
    function isEditMode() as Boolean {
        return editMode;
    }
    
    /**
     * Gère un clic/tap à une position Y donnée
     * Mode détail : Retourne true si le clic est sur la zone du statut (72%-90% de l'écran)
     * Mode édition : Sélectionne l'option cliquée et sauvegarde
     */
    function handleTapAt(y as Number, screenHeight as Number) as Boolean {
        if (editMode) {
            // En mode édition, gérer les clics sur les options de statut
            // Option 1 (Maîtrisé) : 35% - 52% de la hauteur
            var option1Start = (screenHeight * 0.35).toNumber();
            var option1End = (screenHeight * 0.52).toNumber();
            
            // Option 2 (Connu) : 52% - 69% de la hauteur
            var option2Start = (screenHeight * 0.52).toNumber();
            var option2End = (screenHeight * 0.69).toNumber();
            
            // Option 3 (Inconnu) : 69% - 86% de la hauteur
            var option3Start = (screenHeight * 0.69).toNumber();
            var option3End = (screenHeight * 0.86).toNumber();
            
            if (y >= option1Start && y < option1End) {
                // Clic sur "Maîtrisé"
                selectedStatusOption = WordProgressStorage.STATUS_MASTERED;
                saveStatus();
                return true;
            } else if (y >= option2Start && y < option2End) {
                // Clic sur "Connu"
                selectedStatusOption = WordProgressStorage.STATUS_KNOWN;
                saveStatus();
                return true;
            } else if (y >= option3Start && y < option3End) {
                // Clic sur "Inconnu"
                selectedStatusOption = WordProgressStorage.STATUS_UNKNOWN;
                saveStatus();
                return true;
            }
            
            return false;
        }
        
        // Mode détail : Zone du statut : 72% - 90% de la hauteur de l'écran
        var statusZoneStart = (screenHeight * 0.72).toNumber();
        var statusZoneEnd = (screenHeight * 0.90).toNumber();
        
        if (y >= statusZoneStart && y < statusZoneEnd) {
            // Clic sur la zone du statut → activer le mode édition
            enterEditMode();
            return true;
        }
        
        return false;
    }

    function onHide() as Void {
    }

}
