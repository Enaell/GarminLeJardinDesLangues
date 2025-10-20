import Toybox.Lang;
import Toybox.WatchUi;

class LanguageDelegate extends WatchUi.InputDelegate {

    private var view as LanguageView;

    function initialize(languageView as LanguageView) {
        InputDelegate.initialize();
        view = languageView;
    }
    
    /**
     * Gestion des clics/taps sur l'écran tactile
     */
    function onTap(clickEvent as WatchUi.ClickEvent) as Boolean {
        var coords = clickEvent.getCoordinates();
        var y = coords[1];
        
        // Demander à la vue de gérer le clic à cette position
        return view.handleTapAt(y);
    }
    
    /**
     * Gestion des touches de la montre (alternative aux méthodes BehaviorDelegate)
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
            return view.submitAnswer();
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
     * Gestion du bouton SELECT/START - Valider la réponse
     */
    function onSelect() as Boolean {
        return view.submitAnswer();
    }

    /**
     * Gestion du bouton BACK - Quitter l'application
     */
    function onBack() as Boolean {
        // Laisser le comportement par défaut (quitter)
        return false;
    }

    /**
     * Gestion du bouton MENU - Afficher le menu (optionnel)
     */
    function onMenu() as Boolean {
        // Pour l'instant, pas de menu
        // WatchUi.pushView(new Rez.Menus.MainMenu(), new LanguageMenuDelegate(), WatchUi.SLIDE_UP);
        return false;
    }

}