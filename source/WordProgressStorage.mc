import Toybox.Lang;
import Toybox.Application.Storage;

/**
 * WordProgressStorage
 * Gère la persistance du niveau de maîtrise des mots
 * Utilise le Storage API de Garmin Connect IQ
 * 
 * Statuts possibles :
 * - UNKNOWN (null ou 2) : Mot non évalué ou inconnu
 * - KNOWN (1) : Mot connu mais pas totalement maîtrisé
 * - MASTERED (0) : Mot maîtrisé
 */
class WordProgressStorage {
    
    enum {
        STATUS_MASTERED = 0,   // Mot maîtrisé
        STATUS_KNOWN = 1,      // Mot connu
        STATUS_UNKNOWN = 2     // Mot inconnu
    }
    
    private static const STORAGE_KEY = "word_progress";
    
    /**
     * Enregistre le statut d'un mot
     * @param wordIndex Index du mot dans VocabularyData
     * @param status Statut (STATUS_MASTERED, STATUS_KNOWN, ou STATUS_UNKNOWN)
     */
    static function setWordStatus(wordIndex as Number, status as Number) as Void {
        var progressData = loadProgressData();
        
        // Convertir l'index en String car les clés doivent être des String
        var key = wordIndex.toString();
        progressData.put(key, status);
        
        // Sauvegarder dans le Storage
        Storage.setValue(STORAGE_KEY, progressData);
    }
    
    /**
     * Récupère le statut d'un mot
     * @param wordIndex Index du mot dans VocabularyData
     * @return Statut (STATUS_MASTERED, STATUS_KNOWN, ou STATUS_UNKNOWN)
     *         Retourne STATUS_UNKNOWN si le mot n'a jamais été évalué
     */
    static function getWordStatus(wordIndex as Number) as Number {
        var progressData = loadProgressData();
        
        var key = wordIndex.toString();
        var status = progressData.get(key);
        
        if (status == null) {
            return STATUS_UNKNOWN;
        }
        
        return status as Number;
    }
    
    /**
     * Vérifie si un mot a déjà été évalué
     * @param wordIndex Index du mot
     * @return true si le mot a un statut enregistré, false sinon
     */
    static function hasStatus(wordIndex as Number) as Boolean {
        var progressData = loadProgressData();
        var key = wordIndex.toString();
        return progressData.hasKey(key);
    }
    
    /**
     * Récupère le nombre de mots par statut
     * @return Dictionary avec les clés "mastered", "known", "unknown"
     */
    static function getStatistics() as Dictionary<String, Number> {
        var stats = {
            "mastered" => 0,
            "known" => 0,
            "unknown" => 0
        };
        
        var totalWords = VocabularyData.getVocabularySize();
        
        // Compter les mots évalués par statut
        for (var i = 0; i < totalWords; i++) {
            var status = getWordStatus(i);
            
            if (status == STATUS_MASTERED) {
                stats["mastered"] = stats["mastered"] + 1;
            } else if (status == STATUS_KNOWN) {
                stats["known"] = stats["known"] + 1;
            } else {
                stats["unknown"] = stats["unknown"] + 1;
            }
        }
        
        return stats;
    }
    
    /**
     * Réinitialise tous les statuts (efface toutes les données)
     */
    static function resetAllProgress() as Void {
        Storage.setValue(STORAGE_KEY, {});
    }
    
    /**
     * Charge les données de progression depuis le Storage
     * @return Dictionary avec les statuts des mots (clé = index, valeur = statut)
     */
    private static function loadProgressData() as Dictionary<String, Number> {
        var data = Storage.getValue(STORAGE_KEY);
        
        if (data == null) {
            // Première utilisation, créer un dictionnaire vide
            return {} as Dictionary<String, Number>;
        }
        
        return data as Dictionary<String, Number>;
    }
    
    /**
     * Retourne le nombre total de mots évalués (ayant un statut)
     */
    static function getEvaluatedWordsCount() as Number {
        var progressData = loadProgressData();
        return progressData.keys().size();
    }
    
    /**
     * Retourne le pourcentage de mots maîtrisés
     */
    static function getMasteredPercentage() as Float {
        var totalWords = VocabularyData.getVocabularySize();
        if (totalWords == 0) {
            return 0.0f;
        }
        
        var masteredCount = 0;
        for (var i = 0; i < totalWords; i++) {
            if (getWordStatus(i) == STATUS_MASTERED) {
                masteredCount++;
            }
        }
        
        return (masteredCount.toFloat() / totalWords.toFloat()) * 100.0f;
    }
}
