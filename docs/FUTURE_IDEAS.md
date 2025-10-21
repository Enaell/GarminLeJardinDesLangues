# 💡 Idées d'Améliorations Futures

Ce document liste les idées d'améliorations et fonctionnalités supplémentaires pour les versions futures de l'application.

---

## ✅ Version 1.1 - RÉALISÉ (20 oct 2025)

### Menu de Démarrage ✅
**Statut** : IMPLÉMENTÉ  
**Description** :
- ✅ Écran d'accueil avec 2 options de quiz
- ✅ Quiz Normal (Hanzi → Français)
- ✅ Quiz Inversé (Français → Hanzi)
- ✅ Navigation tactile + boutons
- ✅ Transitions fluides

## ✅ Version 1.2 - RÉALISÉ (21 oct 2025)

### Option Pinyin Masquable ✅
**Statut** : IMPLÉMENTÉ  
**Description** :
- ✅ Clic sur zone du pinyin pour cacher/afficher
- ✅ État persistant entre questions
- ✅ Indicateur visuel `[Tap: Pinyin]`
- ✅ Fonctionne dans les 2 modes

## ✅ Version 1.3 - RÉALISÉ (22 oct 2025)

### Système de Persistance des Données ✅
**Statut** : IMPLÉMENTÉ  
**Description** :
- ✅ Évaluation optionnelle des mots après chaque question
- ✅ 3 niveaux de maîtrise (Maîtrisé / Connu / Inconnu)
- ✅ Sauvegarde persistante via Storage API
- ✅ Interface élégante avec bordure
- ✅ Navigation tactile et boutons
- ✅ Les données survivent entre les sessions

## 🎯 Version 1.4 - Prochaines Améliorations

### Affichage des Statistiques de Progression
**Priorité** : Haute  
**Complexité** : Faible  
**Description** :
- Écran de statistiques accessible depuis le menu
- Afficher le nombre de mots par statut (Maîtrisés/Connus/Inconnus)
- Pourcentage de progression globale
- Graphiques simples si possible

### Statistiques de Session
**Priorité** : Haute  
**Complexité** : Faible  
**Description** :
- Afficher à la fin d'une session :
  - Nombre de questions : X
  - Bonnes réponses : Y
  - Taux de réussite : Z%
  - Temps écoulé
- Bouton "Continuer" ou "Nouvelle session"

### Écran de Paramètres
**Priorité** : Moyenne  
**Complexité** : Moyenne  
**Description** :
- Nombre de questions par session (10/20/30/50)
- Niveau de difficulté (HSK 1, HSK 2, ou mixte)
- Délai feedback (1-3 secondes)
- Thème (clair/sombre)

---

## 📊 Version 1.5 - Historique et Suivi

### Historique des Sessions
**Priorité** : Moyenne  
**Complexité** : Moyenne  
**Description** :
- Sauvegarder les 10 dernières sessions :
  - Date
  - Score
  - Durée
  - Taux de réussite
- Vue liste avec détails

### Compteur de Séries
**Priorité** : Basse  
**Complexité** : Faible  
**Description** :
- Compteur de bonnes réponses consécutives
- Affichage pendant le quiz : "🔥 5 d'affilée !"
- Meilleure série de la session
- Record personnel (toutes sessions)

---

## 🎓 Version 2.0 - Apprentissage Avancé

### Mode Révision par Statut
**Priorité** : Haute  
**Complexité** : Moyenne  
**Description** :
- Mode "Révision Inconnus" : uniquement les mots marqués comme inconnus
- Mode "Révision Connus" : renforcer les mots connus
- Mode "Révision Mixte" : mélange intelligent selon les statuts
- Priorité automatique aux mots moins maîtrisés

### Filtrage par Niveau HSK
**Priorité** : Haute  
**Complexité** : Moyenne  
**Description** :
- Menu de sélection :
  - HSK 1 uniquement (150 mots)
  - HSK 2 uniquement (150 mots)
  - HSK 1+2 mixte (300 mots)
- Affichage du niveau actuel en haut de l'écran
- Statistiques séparées par niveau

### Exemples de Phrases
**Priorité** : Moyenne  
**Complexité** : Haute  
**Description** :
- Ajouter 2-3 phrases d'exemple par mot dans VocabularyData
- Après bonne réponse, afficher une phrase d'exemple
- Format : "你好！我是学生。" (pinyin en dessous)
- Bouton "Voir phrase" optionnel

### Système de Répétition Espacée (SRS)
**Priorité** : Haute  
**Complexité** : Très Haute  
**Description** :
- Algorithme SM-2 (SuperMemo) ou similaire
- Chaque mot a un intervalle de révision
- Mots difficiles reviennent plus souvent
- Mots maîtrisés espacés de plus en plus
- Persistance des intervalles

---

## 🔄 Version 2.1 - Modes Alternatifs

### ~~Mode Inverse (Français → Mandarin)~~ ✅
**Statut** : RÉALISÉ dans v1.1  
**Description** :
- ✅ Affiche traduction française
- ✅ Propose 4 hanzi en options
- ✅ Option dans menu principal
- ✅ Pinyin comme indice

### Mode Pinyin
**Priorité** : Moyenne  
**Complexité** : Faible  
**Description** :
- Afficher hanzi
- Proposer 4 pinyin en options
- Entraînement à la prononciation
- Utile pour débutants

### Mode Écriture (Stroke Order)
**Priorité** : Basse  
**Complexité** : Très Haute  
**Description** :
- Afficher hanzi avec ordre des traits
- Animation du tracé (si possible)
- Nécessite données supplémentaires
- Probablement trop complexe pour montre

---

## 📈 Version 2.2 - Statistiques Avancées

### Graphiques de Progression
**Priorité** : Moyenne  
**Complexité** : Haute  
**Description** :
- Graphique taux de réussite sur 7/30 jours
- Graphique nombre de questions par jour
- Nombre de mots maîtrisés vs total
- Utiliser `WatchUi.Drawable` pour graphiques simples

### Badges et Achievements
**Priorité** : Basse  
**Complexité** : Moyenne  
**Description** :
- "Première Victoire" : 1ère bonne réponse
- "Série de 10" : 10 bonnes réponses d'affilée
- "Marathon" : 100 questions en une session
- "Perfectionniste" : 100% sur une session de 20+ questions
- "Assidu" : 7 jours consécutifs
- Affichage des badges dans un écran dédié

### Export des Données
**Priorité** : Basse  
**Complexité** : Haute  
**Description** :
- Export CSV des statistiques
- Via Garmin Connect (si possible)
- Ou fichier sur montre lisible par PC
- Format : date, mot, correct/incorrect, temps

---

## 🎨 Version 3.0 - Interface Améliorée

### Thèmes Visuels
**Priorité** : Basse  
**Complexité** : Moyenne  
**Description** :
- Thème clair / sombre
- Thème automatique selon heure du jour
- Thème "Nuit" (rouge foncé pour préserver vision nocturne)
- Personnalisation des couleurs

### Polices Adaptatives
**Priorité** : Moyenne  
**Complexité** : Moyenne  
**Description** :
- Taille de police adaptée à la longueur du hanzi
- 1 caractère → très grande police
- 2-3 caractères → grande police
- 4+ caractères → police moyenne
- Améliore lisibilité

### Animations
**Priorité** : Basse  
**Complexité** : Haute  
**Description** :
- Transition fluide entre questions
- Animation du feedback (slide, fade)
- Animation du score qui s'incrémente
- Attention : impact batterie !

---

## 🔊 Version 3.1 - Audio et Vibrations

### Feedback Haptique
**Priorité** : Basse  
**Complexité** : Faible  
**Description** :
- Vibration courte pour bonne réponse
- Vibration double pour mauvaise réponse
- Option pour activer/désactiver
- Utiliser `Attention.vibrate()` si disponible

### Sons (si supporté)
**Priorité** : Très Basse  
**Complexité** : Haute  
**Description** :
- Son "ding" pour bonne réponse
- Son "buzz" pour mauvaise réponse
- Prononciation audio des mots (peu probable sur montre)
- Nécessite vérifier capacités audio des montres

---

## 🌐 Version 4.0 - Synchronisation et Social

### Synchronisation Cloud
**Priorité** : Moyenne  
**Complexité** : Très Haute  
**Description** :
- Sync statistiques avec smartphone
- Backup automatique des données
- Restauration sur nouvelle montre
- Nécessite serveur backend ou Garmin Connect API

### Classement et Comparaison
**Priorité** : Basse  
**Complexité** : Très Haute  
**Description** :
- Classement entre amis
- Comparaison de progression
- Défis hebdomadaires
- Nécessite backend + authentification

### Mode Multijoueur
**Priorité** : Très Basse  
**Complexité** : Extrêmement Haute  
**Description** :
- Quiz en simultané avec un ami
- Via Bluetooth ou Wi-Fi
- Probablement hors scope pour montre

---

## 🗂️ Contenu Supplémentaire

### Vocabulaire HSK 3-6
**Priorité** : Haute  
**Complexité** : Moyenne (ajout de données)  
**Description** :
- HSK 3 : +300 mots (total 600)
- HSK 4 : +600 mots (total 1200)
- HSK 5 : +1300 mots (total 2500)
- HSK 6 : +2500 mots (total 5000)
- Attention : limite mémoire montre !

### Autres Langues Asiatiques
**Priorité** : Moyenne  
**Complexité** : Haute (nouvelles données)  
**Description** :
- Japonais (Hiragana/Katakana/Kanji)
- Coréen (Hangul)
- Thaï
- Nécessite refactoring pour support multi-langues

### Champs Lexicaux
**Priorité** : Basse  
**Complexité** : Moyenne  
**Description** :
- Mode thématique :
  - Nourriture uniquement
  - Famille uniquement
  - Couleurs et nombres
  - Verbes d'action
- Extraction automatique depuis tags

---

## 🛠️ Améliorations Techniques

### Optimisation Mémoire
**Priorité** : Haute si nécessaire  
**Complexité** : Haute  
**Description** :
- Lazy loading du vocabulaire
- Compression des données
- Profiling et optimisation
- Support de montres avec moins de mémoire

### Tests Automatisés
**Priorité** : Moyenne  
**Complexité** : Haute  
**Description** :
- Tests unitaires pour QuizModel
- Tests d'intégration
- Tests de performance
- CI/CD pipeline

### Internationalisation (i18n)
**Priorité** : Basse  
**Complexité** : Moyenne  
**Description** :
- Support multi-langues pour l'interface
- Anglais, Français, Chinois
- Fichiers de ressources séparés
- Détection automatique de la langue

---

## 🎯 Priorisation Globale

### ✅ Réalisé (v1.1-1.3)
1. ✅ Menu de démarrage (v1.1)
2. ✅ Mode inversé (v1.1)
3. ✅ Option pinyin masquable (v1.2)
4. ✅ Système de persistance optionnel (v1.3)

### Must Have (v1.4-2.0)
1. Affichage statistiques de progression
2. Mode révision par statut
3. Filtrage par niveau HSK
4. Statistiques de session

### Should Have (v2.0)
1. Mode révision mots difficiles
2. Filtrage par niveau HSK
3. Système SRS

### Nice to Have (v2.1-3.0)
1. Graphiques de progression
2. Thèmes visuels
3. HSK 3-4
4. Mode Pinyin

### Won't Have (probablement jamais)
1. Mode multijoueur
2. Prononciation audio
3. Mode écriture animé

---

## 💬 Notes

- Toujours privilégier la simplicité et la performance
- Tester sur montre réelle avant d'implémenter
- Consulter la communauté pour prioriser
- Respecter les limites hardware des montres Garmin

---

**Vous avez d'autres idées ? N'hésitez pas à contribuer ! 🚀**
