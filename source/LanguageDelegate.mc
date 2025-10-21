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
        } else if (key == WatchUi.KEY_MENU) {
            // Basculer l'affichage du pinyin
            view.togglePinyin();
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
     * Gestion du bouton SELECT/START - Valider la réponse
     */
    function onSelect() as Boolean {
        return view.submitAnswer();
    }

    /**
     * Gestion du bouton BACK - Retourner au menu
     */
    function onBack() as Boolean {
        // Retour au menu de sélection
        var menuView = new MenuView();
        WatchUi.switchToView(menuView, new MenuDelegate(menuView), WatchUi.SLIDE_RIGHT);
        return true;
    }

    /**
     * Gestion du bouton MENU - Basculer l'affichage du pinyin
     */
    function onMenu() as Boolean {
        // Basculer l'affichage du pinyin
        view.togglePinyin();
        return true;
    }

}