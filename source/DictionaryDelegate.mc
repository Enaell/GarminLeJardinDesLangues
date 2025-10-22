import Toybox.Lang;
import Toybox.WatchUi;

/**
 * DictionaryDelegate
 * Gère les interactions utilisateur dans le dictionnaire
 */
class DictionaryDelegate extends WatchUi.InputDelegate {

    private var view as DictionaryView;

    function initialize(dictionaryView as DictionaryView) {
        InputDelegate.initialize();
        view = dictionaryView;
    }
    
    /**
     * Gestion des clics/taps sur l'écran tactile
     */
    function onTap(clickEvent as WatchUi.ClickEvent) as Boolean {
        var coords = clickEvent.getCoordinates();
        var y = coords[1];
        
        // Demander à la vue quel mot a été cliqué
        var clickedIndex = view.handleTapAt(y);
        
        if (clickedIndex >= 0) {
            // Si un mot a été cliqué, ouvrir ses détails immédiatement
            view.openWordDetailAt(clickedIndex);
            return true;
        }
        
        // Si pas géré (clic en dehors des zones), ouvrir les détails du mot actuellement sélectionné
        view.openWordDetail();
        return true;
    }
    
    /**
     * Gestion du swipe vers le haut (scroll down dans la liste)
     */
    function onSwipe(swipeEvent as WatchUi.SwipeEvent) as Boolean {
        var direction = swipeEvent.getDirection();
        
        if (direction == WatchUi.SWIPE_UP) {
            // Swipe vers le haut = scroll down (descendre dans la liste)
            // Avancer de 4 mots à la fois (une page complète)
            for (var i = 0; i < 4; i++) {
                view.selectNextWord();
            }
            return true;
        } else if (direction == WatchUi.SWIPE_DOWN) {
            // Swipe vers le bas = scroll up (remonter dans la liste)
            for (var i = 0; i < 4; i++) {
                view.selectPreviousWord();
            }
            return true;
        }
        
        return false;
    }
    
    /**
     * Gestion des touches de la montre
     */
    function onKey(keyEvent as WatchUi.KeyEvent) as Boolean {
        var key = keyEvent.getKey();
        
        if (key == WatchUi.KEY_UP) {
            view.selectPreviousWord();
            return true;
        } else if (key == WatchUi.KEY_DOWN) {
            view.selectNextWord();
            return true;
        } else if (key == WatchUi.KEY_ENTER) {
            view.openWordDetail();
            return true;
        }
        
        return false;
    }

    /**
     * Gestion du bouton UP (haut) - Mot précédent
     */
    function onPreviousPage() as Boolean {
        view.selectPreviousWord();
        return true;
    }

    /**
     * Gestion du bouton DOWN (bas) - Mot suivant
     */
    function onNextPage() as Boolean {
        view.selectNextWord();
        return true;
    }

    /**
     * Gestion du bouton SELECT/START - Ouvrir les détails
     */
    function onSelect() as Boolean {
        view.openWordDetail();
        return true;
    }

    /**
     * Gestion du bouton BACK - Retour au menu
     */
    function onBack() as Boolean {
        return view.goBack();
    }
    
    /**
     * Gestion du bouton MENU - Changer le filtre
     */
    function onMenu() as Boolean {
        view.cycleFilter();
        return true;
    }

}
