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
        // Pour l'instant, un tap ouvre les détails du mot sélectionné
        view.openWordDetail();
        return true;
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
