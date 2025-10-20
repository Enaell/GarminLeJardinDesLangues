import Toybox.Lang;
import Toybox.WatchUi;

/**
 * MenuDelegate
 * Gère les interactions utilisateur dans l'écran de menu
 */
class MenuDelegate extends WatchUi.InputDelegate {

    private var view as MenuView;

    function initialize(menuView as MenuView) {
        InputDelegate.initialize();
        view = menuView;
    }
    
    /**
     * Gestion des clics/taps sur l'écran tactile
     */
    function onTap(clickEvent as WatchUi.ClickEvent) as Boolean {
        var coords = clickEvent.getCoordinates();
        var y = coords[1];
        
        // Demander à la vue de gérer le clic à cette position
        var handled = view.handleTapAt(y);
        
        // Si une option a été touchée, la lancer directement
        if (handled) {
            view.launchQuiz();
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
            view.selectPreviousOption();
            return true;
        } else if (key == WatchUi.KEY_DOWN) {
            view.selectNextOption();
            return true;
        } else if (key == WatchUi.KEY_ENTER) {
            view.launchQuiz();
            return true;
        }
        
        return false;
    }

    /**
     * Gestion du bouton UP (haut) - Option précédente
     */
    function onPreviousPage() as Boolean {
        view.selectPreviousOption();
        return true;
    }

    /**
     * Gestion du bouton DOWN (bas) - Option suivante
     */
    function onNextPage() as Boolean {
        view.selectNextOption();
        return true;
    }

    /**
     * Gestion du bouton SELECT/START - Lancer le quiz sélectionné
     */
    function onSelect() as Boolean {
        view.launchQuiz();
        return true;
    }

    /**
     * Gestion du bouton BACK - Quitter l'application
     */
    function onBack() as Boolean {
        // Laisser le comportement par défaut (quitter)
        return false;
    }

}
