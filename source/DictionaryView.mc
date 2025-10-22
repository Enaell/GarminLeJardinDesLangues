import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

/**
 * DictionaryView
 * Affiche la liste de tous les mots du vocabulaire avec possibilité de filtrer par statut
 */
class DictionaryView extends WatchUi.View {

    private var scrollOffset as Number;       // Index du premier mot visible
    private var selectedIndex as Number;      // Index du mot actuellement sélectionné
    private var visibleItems as Number;       // Nombre de mots affichables à l'écran
    private var filterStatus as Number?;      // Filtre par statut (null = tous les mots)
    private var filteredIndices as Array<Number> = []; // Liste des indices filtrés
    
    enum FilterMode {
        ALL = -1,
        MASTERED = 0,
        KNOWN = 1,
        UNKNOWN = 2
    }

    function initialize() {
        View.initialize();
        scrollOffset = 0;
        selectedIndex = 0;
        visibleItems = 4; // On affiche 4 mots à la fois
        filterStatus = null; // Par défaut : tous les mots
        updateFilteredIndices();
    }

    function onLayout(dc as Dc) as Void {
        // Pas de layout XML
    }

    function onShow() as Void {
    }

    function onUpdate(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;
        
        // Fond noir
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        // --- En-tête ---
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            (height * 0.05).toNumber(),
            Graphics.FONT_SYSTEM_SMALL,
            "Dictionnaire",
            Graphics.TEXT_JUSTIFY_CENTER
        );
        
        // Affichage du filtre actif
        var filterText = getFilterText();
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            (height * 0.14).toNumber(),
            Graphics.FONT_SYSTEM_XTINY,
            filterText,
            Graphics.TEXT_JUSTIFY_CENTER
        );
        
        // --- Séparateur ---
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawLine((width * 0.05).toNumber(), (height * 0.22).toNumber(), 
                   (width * 0.95).toNumber(), (height * 0.22).toNumber());
        
        // --- Liste des mots ---
        var totalWords = filteredIndices.size();
        if (totalWords == 0) {
            // Aucun mot trouvé
            dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawText(
                centerX,
                (height * 0.50).toNumber(),
                Graphics.FONT_SYSTEM_TINY,
                "Aucun mot trouvé",
                Graphics.TEXT_JUSTIFY_CENTER
            );
        } else {
            var itemHeight = ((height * 0.63) / visibleItems).toNumber();
            var startY = (height * 0.25).toNumber();
            
            for (var i = 0; i < visibleItems; i++) {
                var wordIndex = scrollOffset + i;
                if (wordIndex >= totalWords) {
                    break;
                }
                
                var realWordIndex = filteredIndices[wordIndex];
                var isSelected = (wordIndex == selectedIndex);
                var y = startY + (i * itemHeight);
                
                drawWordItem(dc, realWordIndex, y, width, itemHeight, isSelected);
            }
        }
        
        // --- Indicateur de scroll ---
        if (totalWords > visibleItems) {
            drawScrollIndicator(dc, width, height);
        }
        
        // --- Instructions en bas ---
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            (height * 0.92).toNumber(),
            Graphics.FONT_SYSTEM_XTINY,
            "↑↓ • SELECT détails • BACK retour",
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }
    
    /**
     * Dessine un élément de la liste (un mot)
     */
    private function drawWordItem(dc as Dc, wordIndex as Number, y as Number, 
                                 width as Number, height as Number, 
                                 isSelected as Boolean) as Void {
        var leftMargin = (width * 0.08).toNumber();
        var centerY = y + height / 2;
        
        // Fond de l'élément sélectionné
        if (isSelected) {
            dc.setColor(Graphics.COLOR_DK_BLUE, Graphics.COLOR_DK_BLUE);
            dc.fillRectangle((width * 0.03).toNumber(), y, (width * 0.94).toNumber(), height);
        }
        
        // Récupérer les données du mot
        var hanzi = VocabularyData.getHanzi(wordIndex);
        var translation = VocabularyData.getTranslation(wordIndex);
        var status = VocabularyData.getWordStatus(wordIndex);
        
        // Icône de statut
        var statusIcon = getStatusIcon(status);
        var statusColor = getStatusColor(status);
        dc.setColor(statusColor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            leftMargin,
            centerY - 8,
            Graphics.FONT_SYSTEM_XTINY,
            statusIcon,
            Graphics.TEXT_JUSTIFY_LEFT
        );
        
        // Hanzi
        dc.setColor(isSelected ? Graphics.COLOR_WHITE : Graphics.COLOR_LT_GRAY, 
                   Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            leftMargin + 20,
            centerY - 8,
            Graphics.FONT_SYSTEM_TINY,
            hanzi,
            Graphics.TEXT_JUSTIFY_LEFT
        );
        
        // Traduction (tronquée si trop longue)
        var maxTranslationLength = 15;
        if (translation.length() > maxTranslationLength) {
            translation = translation.substring(0, maxTranslationLength) + "...";
        }
        dc.setColor(isSelected ? Graphics.COLOR_LT_GRAY : Graphics.COLOR_DK_GRAY, 
                   Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            (width * 0.92).toNumber(),
            centerY - 8,
            Graphics.FONT_SYSTEM_XTINY,
            translation,
            Graphics.TEXT_JUSTIFY_RIGHT
        );
    }
    
    /**
     * Dessine l'indicateur de scroll
     */
    private function drawScrollIndicator(dc as Dc, width as Number, height as Number) as Void {
        var totalWords = filteredIndices.size();
        var scrollBarHeight = (height * 0.63).toNumber();
        var scrollBarY = (height * 0.25).toNumber();
        var scrollBarX = (width * 0.98).toNumber();
        
        // Barre de fond
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawLine(scrollBarX, scrollBarY, scrollBarX, scrollBarY + scrollBarHeight);
        
        // Indicateur de position
        var indicatorHeight = (scrollBarHeight * visibleItems) / totalWords;
        var indicatorY = scrollBarY + ((scrollBarHeight * scrollOffset) / totalWords);
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.fillRectangle(scrollBarX - 1, indicatorY.toNumber(), 3, indicatorHeight.toNumber());
    }
    
    /**
     * Retourne l'icône correspondant au statut
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
     * Retourne la couleur correspondant au statut
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
     * Retourne le texte du filtre actif
     */
    private function getFilterText() as String {
        var totalWords = filteredIndices.size();
        var totalVocab = VocabularyData.getVocabularySize();
        
        if (filterStatus == null) {
            return totalWords + "/" + totalVocab + " mots";
        } else if (filterStatus == WordProgressStorage.STATUS_MASTERED) {
            return "Maîtrisés (" + totalWords + ")";
        } else if (filterStatus == WordProgressStorage.STATUS_KNOWN) {
            return "Connus (" + totalWords + ")";
        } else {
            return "Inconnus (" + totalWords + ")";
        }
    }
    
    /**
     * Met à jour la liste des indices filtrés
     */
    function updateFilteredIndices() as Void {
        filteredIndices = [];
        var totalWords = VocabularyData.getVocabularySize();
        
        for (var i = 0; i < totalWords; i++) {
            if (filterStatus == null) {
                // Pas de filtre : tous les mots
                filteredIndices.add(i);
            } else {
                // Filtre par statut
                var wordStatus = VocabularyData.getWordStatus(i);
                if (wordStatus == filterStatus) {
                    filteredIndices.add(i);
                }
            }
        }
        
        // Réinitialiser la sélection si nécessaire
        if (selectedIndex >= filteredIndices.size()) {
            selectedIndex = 0;
            scrollOffset = 0;
        }
    }
    
    /**
     * Navigue vers le mot précédent
     */
    function selectPreviousWord() as Void {
        if (filteredIndices.size() == 0) {
            return;
        }
        
        selectedIndex--;
        if (selectedIndex < 0) {
            selectedIndex = filteredIndices.size() - 1;
            scrollOffset = selectedIndex - visibleItems + 1;
            if (scrollOffset < 0) {
                scrollOffset = 0;
            }
        } else if (selectedIndex < scrollOffset) {
            scrollOffset = selectedIndex;
        }
        WatchUi.requestUpdate();
    }
    
    /**
     * Navigue vers le mot suivant
     */
    function selectNextWord() as Void {
        if (filteredIndices.size() == 0) {
            return;
        }
        
        selectedIndex++;
        if (selectedIndex >= filteredIndices.size()) {
            selectedIndex = 0;
            scrollOffset = 0;
        } else if (selectedIndex >= scrollOffset + visibleItems) {
            scrollOffset = selectedIndex - visibleItems + 1;
        }
        WatchUi.requestUpdate();
    }
    
    /**
     * Cycle à travers les filtres
     */
    function cycleFilter() as Void {
        if (filterStatus == null) {
            filterStatus = WordProgressStorage.STATUS_MASTERED;
        } else if (filterStatus == WordProgressStorage.STATUS_MASTERED) {
            filterStatus = WordProgressStorage.STATUS_KNOWN;
        } else if (filterStatus == WordProgressStorage.STATUS_KNOWN) {
            filterStatus = WordProgressStorage.STATUS_UNKNOWN;
        } else {
            filterStatus = null;
        }
        
        updateFilteredIndices();
        WatchUi.requestUpdate();
    }
    
    /**
     * Ouvre le détail du mot sélectionné
     */
    function openWordDetail() as Void {
        if (filteredIndices.size() == 0) {
            return;
        }
        
        var wordIndex = filteredIndices[selectedIndex];
        var view = new WordDetailView(wordIndex);
        WatchUi.pushView(view, new WordDetailDelegate(view), WatchUi.SLIDE_LEFT);
    }
    
    /**
     * Ouvre les détails d'un mot spécifique par son index dans filteredIndices
     */
    function openWordDetailAt(index as Number) as Void {
        if (index < 0 || index >= filteredIndices.size()) {
            return;
        }
        
        var wordIndex = filteredIndices[index];
        var view = new WordDetailView(wordIndex);
        WatchUi.pushView(view, new WordDetailDelegate(view), WatchUi.SLIDE_LEFT);
    }
    
    /**
     * Retourne au menu
     */
    function goBack() as Boolean {
        return false; // Laisser le comportement par défaut (pop la view)
    }
    
    /**
     * Gère un clic/tap à une position Y donnée
     * Retourne l'index du mot cliqué dans filteredIndices, ou -1 si clic en dehors
     */
    function handleTapAt(y as Number) as Number {
        if (filteredIndices.size() == 0) {
            return -1;
        }
        
        // Obtenir la hauteur de l'écran via le système
        var deviceSettings = System.getDeviceSettings();
        var screenHeight = deviceSettings.screenHeight;
        
        // Utiliser les MÊMES calculs que dans onUpdate()
        var itemHeight = ((screenHeight * 0.63) / visibleItems).toNumber();
        var startY = (screenHeight * 0.25).toNumber();
        var endY = startY + (itemHeight * visibleItems);
        
        // Vérifier si le clic est dans la zone de la liste
        if (y < startY || y >= endY) {
            return -1; // Clic en dehors de la liste
        }
        
        // Calculer quelle ligne a été cliquée (0, 1, 2, 3)
        var relativeY = y - startY;
        var clickedLine = relativeY / itemHeight;
        
        // Calculer l'index du mot dans la liste filtrée
        var wordIndex = scrollOffset + clickedLine;
        
        // Vérifier que l'index est valide et qu'il y a un mot à cette position
        if (wordIndex >= 0 && wordIndex < filteredIndices.size()) {
            return wordIndex;
        }
        
        return -1;
    }

    function onHide() as Void {
    }

}
