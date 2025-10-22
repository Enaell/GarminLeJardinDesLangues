import Toybox.Lang;
import Toybox.WatchUi;

/**
 * WordDetailDelegate
 * Gère les interactions utilisateur dans la vue détail d'un mot
 */
class WordDetailDelegate extends WatchUi.InputDelegate {

    private var view as WordDetailView;

    function initialize(detailView as WordDetailView) {
        InputDelegate.initialize();
        view = detailView;
    }
    
    /**
     * Gestion des clics/taps sur l'écran tactile
     */
    function onTap(clickEvent as WatchUi.ClickEvent) as Boolean {
        var coords = clickEvent.getCoordinates();
        var y = coords[1];
        
        // Obtenir la hauteur de l'écran via le système
        var deviceSettings = System.getDeviceSettings();
        var screenHeight = deviceSettings.screenHeight;
        
        // Demander à la vue de gérer le clic (mode détail ou édition)
        return view.handleTapAt(y, screenHeight);
    }
    
    /**
     * Gestion des touches de la montre
     */
    function onKey(keyEvent as WatchUi.KeyEvent) as Boolean {
        var key = keyEvent.getKey();
        
        if (view.isEditMode()) {
            // Mode édition
            if (key == WatchUi.KEY_UP) {
                view.selectPreviousStatusOption();
                return true;
            } else if (key == WatchUi.KEY_DOWN) {
                view.selectNextStatusOption();
                return true;
            } else if (key == WatchUi.KEY_ENTER) {
                view.saveStatus();
                return true;
            }
        } else {
            // Mode détail
            if (key == WatchUi.KEY_ENTER) {
                view.enterEditMode();
                return true;
            }
        }
        
        return false;
    }

    /**
     * Gestion du bouton UP (haut)
     */
    function onPreviousPage() as Boolean {
        if (view.isEditMode()) {
            view.selectPreviousStatusOption();
            return true;
        }
        return false;
    }

    /**
     * Gestion du bouton DOWN (bas)
     */
    function onNextPage() as Boolean {
        if (view.isEditMode()) {
            view.selectNextStatusOption();
            return true;
        }
        return false;
    }

    /**
     * Gestion du bouton SELECT/START
     */
    function onSelect() as Boolean {
        if (view.isEditMode()) {
            view.saveStatus();
        } else {
            view.enterEditMode();
        }
        return true;
    }

    /**
     * Gestion du bouton BACK
     */
    function onBack() as Boolean {
        if (view.isEditMode()) {
            // Annuler le mode édition
            view.cancelEditMode();
            return true;
        }
        // Retour à la liste du dictionnaire
        return false;
    }

}
