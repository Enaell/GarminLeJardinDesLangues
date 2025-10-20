# Changelog - Le Jardin des Langues

Tous les changements notables de ce projet seront documentés dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/),
et ce projet adhère au [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Non publié]

### À venir
- Mode révision des mots difficiles
- Statistiques détaillées de progression
- Filtrage par niveau HSK
- Mode inverse (français → mandarin)

## [1.0.1] - 2025-10-20

### Corrigé
- **Bug de sélection tactile** : Les clics sur l'écran tactile sélectionnent maintenant correctement l'option cliquée
  - Changement de `BehaviorDelegate` vers `InputDelegate` pour supporter les événements tactiles
  - Ajout de la méthode `onTap()` dans `LanguageDelegate` pour détecter les clics
  - Ajout de la méthode `handleTapAt(y)` dans `LanguageView` pour calculer quelle option a été cliquée
  - Ajout de `selectOptionByIndex(index)` pour sélection directe d'une option
- **Bug de vérification de réponse** : La méthode `shuffleOptions()` utilise maintenant `.equals()` au lieu de `indexOf()` pour comparer les chaînes correctement

### Amélioré
- **Double méthode de contrôle** : 
  - Navigation traditionnelle avec boutons UP/DOWN + SELECT (inchangée)
  - Nouvelle interaction tactile : clic direct sur une option = sélection + validation instantanée
- **Code plus robuste** : Ajout de `onKey()` comme fallback pour les événements clavier

## [1.0.0] - 2025-10-19

### 🎉 Version initiale - MVP (Minimum Viable Product)

#### Ajouté
- **Base de données complète HSK 1 & 2**
  - 150 mots HSK niveau 1
  - 150 mots HSK niveau 2
  - Total : 300 mots avec hanzi, pinyin, traductions françaises et niveau HSK

- **Interface de quiz**
  - Affichage du hanzi (caractères chinois) en grand
  - Affichage du pinyin sous le hanzi pour aide à la prononciation
  - 4 options de réponse à choix multiples
  - Navigation intuitive avec les boutons de la montre
  - Indicateur visuel de l'option sélectionnée (fond bleu)

- **Système de feedback**
  - Feedback immédiat après validation
  - Fond vert + icône ✓ pour bonne réponse
  - Fond rouge + icône ✗ pour mauvaise réponse
  - Affichage de la correction en cas d'erreur

- **Logique de quiz intelligente**
  - Sélection aléatoire des mots
  - Génération de 3 distracteurs pertinents
  - Anti-répétition : mémorisation des 20 derniers mots utilisés
  - Mélange aléatoire des options (algorithme Fisher-Yates)

- **Système de score**
  - Compteur de bonnes réponses
  - Compteur de questions totales
  - Affichage en temps réel (format "X/Y")

- **Contrôles utilisateur**
  - UP : Option précédente
  - DOWN : Option suivante
  - SELECT/START : Valider la réponse
  - BACK : Quitter l'application

- **Optimisations techniques**
  - Gestion efficace de la mémoire (données statiques)
  - Algorithmes optimisés pour performances montre
  - Rendu direct sans overhead de layouts XML
  - Pas de consommation batterie excessive

#### Documentation
- README.md complet avec guide utilisateur
- DEVELOPMENT.md avec guide développeur détaillé
- CHANGELOG.md pour suivi des versions
- Commentaires exhaustifs dans le code source

#### Support
- **Appareils compatibles** :
  - Fenix 8 43mm
  - Fenix 8 47mm
  - Fenix 8 Pro 47mm
  - Fenix 8 Solar 47mm
  - Fenix 8 Solar 51mm
  - Fenix E

#### Architecture
- Pattern MVC adapté à Monkey C
- 5 fichiers source principaux :
  - `LanguageApp.mc` : Point d'entrée
  - `LanguageView.mc` : Interface utilisateur (254 lignes)
  - `LanguageDelegate.mc` : Gestion interactions (51 lignes)
  - `QuizModel.mc` : Logique du quiz (218 lignes)
  - `VocabularyData.mc` : Base de données (367 lignes)

### Limitations Connues
- Pas de persistance des données (score réinitialisé à chaque lancement)
- Pas de statistiques détaillées
- Pas de filtrage par niveau HSK
- Taille de police fixe pour les caractères chinois
- Caractères chinois peuvent ne pas s'afficher sur anciens modèles

### Notes Techniques
- **SDK Garmin** : Connect IQ 5.2.0+
- **Langage** : Monkey C
- **Taille approximative** : ~50 KB compilé
- **Mémoire utilisée** : < 10% sur Fenix 8
- **Langues** : Français (interface) + Mandarin (contenu)

---

## Format des Versions Futures

### [X.Y.Z] - YYYY-MM-DD

#### Ajouté
- Nouvelles fonctionnalités

#### Modifié
- Changements dans les fonctionnalités existantes

#### Déprécié
- Fonctionnalités bientôt supprimées

#### Supprimé
- Fonctionnalités supprimées

#### Corrigé
- Corrections de bugs

#### Sécurité
- Mises à jour de sécurité

---

## Roadmap Prévue

### Version 1.1.0 (Décembre 2025)
- Ajout d'un menu de démarrage
- Statistiques de session (taux de réussite)
- Option pour afficher/masquer le pinyin
- Amélioration de l'interface (polices adaptatives)

### Version 1.2.0 (Janvier 2026)
- Persistance des données (sauvegarde du score)
- Historique des sessions
- Compteur de séries de bonnes réponses

### Version 2.0.0 (Mars 2026)
- Mode révision des mots difficiles
- Filtrage par niveau HSK
- Statistiques détaillées
- Graphiques de progression

### Version 2.1.0 (Mai 2026)
- Exemples de phrases en contexte
- Audio pour prononciation (si possible)
- Mode sombre/clair

### Version 3.0.0 (Septembre 2026)
- Mode inverse (français → mandarin)
- Système de répétition espacée (SRS)
- Badges et achievements
- Synchronisation avec smartphone

---

**Légende des Émojis** :
- 🎉 Version majeure
- ✨ Nouvelle fonctionnalité
- 🐛 Correction de bug
- 📝 Documentation
- ⚡ Performance
- 🎨 Interface
- 🔒 Sécurité
