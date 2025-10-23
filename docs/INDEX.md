# 📚 Documentation Index - Le Jardin des Langues

Bienvenue dans la documentation du projet **Le Jardin des Langues** - Application de quiz mandarin HSK pour Garmin Fenix 8.

---

## 🚀 Pour Commencer

### Je veux utiliser l'application
👉 **[QUICKSTART.md](QUICKSTART.md)** - Guide de démarrage rapide (5 min)
- Installation sur montre ou simulateur
- Première utilisation avec le menu (3 modes)
- Contrôles pour les 2 modes de quiz
- Comment utiliser le dictionnaire (v1.4+)
- Comment cacher/afficher le pinyin (v1.2+)
- Comment évaluer les mots (v1.3+)

### Je veux comprendre le projet
👉 **[../README.md](../README.md)** - Présentation générale (racine du projet)
- Description de l'application
- Fonctionnalités actuelles (2 quiz + dictionnaire + évaluation + pinyin masquable)
- Architecture technique
- Contenu pédagogique (vocabulaire HSK)

---

## 💻 Pour Développeurs

### Je veux contribuer au code
👉 **[DEVELOPMENT.md](DEVELOPMENT.md)** - Guide développeur complet
- Architecture détaillée (MVC + Menu)
- Composants principaux (MenuView, QuizModel, etc.)
- Flux de données
- Guide de personnalisation
## 📋 Informations Projet

### Historique des versions
👉 **[CHANGELOG.md](CHANGELOG.md)** - Historique des versions
- Notes de la version 1.5.0 (algorithme d'apprentissage progressif + optimisations)
- Notes de la version 1.4.1 (vocabulaire HSK 3 complet)
- Notes de la version 1.4.0 (dictionnaire complet avec filtrage)
- Notes de la version 1.3.0 (système de persistance optionnel)
- Notes de la version 1.2.0 (option pinyin masquable)
- Notes de la version 1.1.0 (menu + mode inversé)
- Historique complet depuis v1.0.0
- Format standardisé (Keep a Changelog)

### Idées pour le futur
👉 **[FUTURE_IDEAS.md](FUTURE_IDEAS.md)** - Améliorations potentielles
- Fonctionnalités futures (v2.0+)
- Améliorations de l'interface
- Contenu supplémentaire (HSK 3-6)
- Modes de révision avancés

---

## 📂 Structure du Projet

```
Language/
├── 📄 README.md              ← Commencez ici ! (racine du projet)
├── 📁 docs/                  ← Documentation (ce dossier)
│   ├── 📄 INDEX.md             (Ce fichier - navigation)
│   ├── 📄 QUICKSTART.md        (Installation & Utilisation)
│   ├── 📄 DEVELOPMENT.md       (Guide développeur)
│   ├── 📄 CHANGELOG.md         (Historique des versions)
│   └── 📄 FUTURE_IDEAS.md      (Idées d'améliorations)
│
├── 📁 source/                ← Code source
│   ├── LanguageApp.mc          (Point d'entrée)
│   ├── MenuView.mc             (Écran d'accueil - 3 modes)
│   ├── MenuDelegate.mc         (Interactions du menu)
│   ├── LanguageView.mc         (Interface du quiz)
│   ├── LanguageDelegate.mc     (Interactions du quiz)
│   ├── QuizModel.mc            (Logique du quiz)
│   ├── VocabularyData.mc       (Base de données HSK 1-3: 600 mots)
│   ├── WordProgressStorage.mc  (Persistance des évaluations)
│   ├── DictionaryView.mc       (Liste des mots - v1.4)
│   ├── DictionaryDelegate.mc   (Interactions dictionnaire - v1.4)
│   ├── WordDetailView.mc       (Détail d'un mot - v1.4)
│   └── WordDetailDelegate.mc   (Interactions détail - v1.4)
│
├── 📁 resources/             ← Ressources
│   ├── strings/strings.xml     (Textes interface)
│   ├── layouts/layout.xml      (Layouts - non utilisés)
│   ├── drawables/              (Images et icônes)
│   └── menus/menu.xml          (Menus - non utilisés)
│
├── 📁 bin/                   ← Fichiers compilés
│   └── Language.prg            (Application compilée)
│
├── 📄 manifest.xml           ← Configuration app
└── 📄 monkey.jungle          ← Configuration build
```

---

## 🎯 Workflows Courants

### Scénario 1 : Je découvre le projet
```
1. Lire README.md (vue d'ensemble)
2. Lire QUICKSTART.md (installation)
3. Tester sur simulateur (F5 dans VS Code)
4. Explorer PROJECT_SUMMARY.md si intéressé
```

### Scénario 2 : Je veux modifier le code
```
1. Lire DEVELOPMENT.md (architecture)
2. Explorer le code source dans source/
3. Faire des modifications
4. Compiler avec Ctrl+Shift+B
5. Tester avec F5
6. Documenter dans CHANGELOG.md
```

### Scénario 3 : Je veux ajouter des mots
```
1. Ouvrir source/VocabularyData.mc
2. Ajouter dans le tableau vocabulary :
   ["新词", "xīn cí", "nouveau mot", 4]  # HSK 4
3. Compiler et tester
4. Mettre à jour README.md (nombre de mots)
Note: HSK 1-3 déjà complets (600 mots)
```

### Scénario 4 : Je veux proposer une amélioration
```
1. Consulter FUTURE_IDEAS.md (déjà prévu ?)
2. Si nouveau : ajouter dans FUTURE_IDEAS.md
3. Créer une issue GitHub (si projet public)
4. Discuter avec la communauté
```

---

## 📊 Métriques Projet

| Métrique | Valeur |
|----------|--------|
| **Version actuelle** | 1.5.0 |
| **Date release** | 23 oct 2025 |
| **Lignes de code** | ~2,800 |
| **Lignes documentation** | ~1,500 |
| **Fichiers source** | 12 |
| **Fichiers documentation** | 5 |
| **Mots HSK** | 600 (HSK 1-3) |
| **Modes** | 2 Quiz + Dictionnaire |
| **Fonctionnalités** | Apprentissage progressif + Pinyin masquable + Évaluation + Dictionnaire filtrable + Caches optimisés |
| **Appareils compatibles** | 6 modèles Fenix 8 |
| **Langue interface** | Français |
| **Langue contenu** | Mandarin |
| **Modes de contrôle** | Boutons + Tactile |
| **Persistance** | Oui (Storage API) |
| **Performance** | ~40x plus rapide (v1.5) |

---

## 🔗 Liens Utiles

### Ressources Garmin
- [Garmin Connect IQ SDK](https://developer.garmin.com/connect-iq/)
- [API Documentation](https://developer.garmin.com/connect-iq/api-docs/)
- [Forum Développeurs](https://forums.garmin.com/developer/)
- [Connect IQ Store](https://apps.garmin.com/)

### Ressources HSK
- [HSK Academy](https://www.hskhsk.com/)
- [Chinese-tools.com](https://chinese-tools.com/)
- [ChineseSkill App](https://www.chineseskill.com/)

### Outils de Développement
- [VS Code](https://code.visualstudio.com/)
- [Monkey C Extension](https://marketplace.visualstudio.com/items?itemName=garmin.monkey-c)
- [Connect IQ Simulator](https://developer.garmin.com/connect-iq/connect-iq-basics/getting-started/)

---

## ❓ FAQ Rapide

**Q : Quelle version dois-je lire en premier ?**  
A : Commencez par README.md, puis QUICKSTART.md pour l'installation.

**Q : Comment contribuer au projet ?**  
A : Lisez DEVELOPMENT.md, puis proposez vos modifications via GitHub (si projet public).

**Q : Où sont les données de vocabulaire ?**  
A : Dans `source/VocabularyData.mc`, tableau `vocabulary` (ligne ~15). Contient 600 mots HSK 1-3.

**Q : Comment ajouter de nouveaux mots ?**  
A : Ajoutez une ligne dans VocabularyData.mc au format : `["hanzi", "pinyin", "traduction", niveau]`

**Q : L'application fonctionne-t-elle sur ma Fenix 7 ?**  
A : Non, uniquement Fenix 8 série et Fenix E. Voir manifest.xml pour liste complète.

**Q : Puis-je changer les couleurs ?**  
A : Oui, voir DEVELOPMENT.md > Personnalisation > Modifier les Couleurs.

**Q : Quel mode de quiz choisir ?**  
A : Quiz Normal pour apprendre à reconnaître les hanzi, Quiz Inversé pour renforcer la mémorisation.

**Q : Où puis-je télécharger l'application ?**  
A : Actuellement en développement. Compilez depuis le source ou attendez publication sur Connect IQ Store.

---

## 📞 Support

- **Documentation** : Lisez les fichiers listés ci-dessus
- **Bugs** : Ouvrir une issue GitHub (si projet public)
- **Questions** : Consulter FAQ ci-dessus ou forum Garmin
- **Améliorations** : Proposer dans FUTURE_IDEAS.md

---

## 🏆 Crédits

- **Développement** : Le Jardin des Langues Team
- **Vocabulaire** : Basé sur listes officielles HSK
- **Framework** : Garmin Connect IQ SDK
- **Documentation** : Markdown / GitHub style

---

## 📅 Dernière Mise à Jour

**Date** : 23 octobre 2025  
**Version** : 1.5.0  
**État** : Stable - Production Ready ✅  
**Dernière modification** : Ajout de l'algorithme d'apprentissage progressif et système de cache ultra-performant

---

## 🎉 Merci !

Merci d'utiliser **Le Jardin des Langues** !  
Bon apprentissage du mandarin ! 加油！(jiā yóu - courage !)

Pour toute question, consultez les fichiers listés ci-dessus. 📚

---

**Navigation Rapide** :
[README](../README.md) | 
[QUICKSTART](QUICKSTART.md) | 
[DEVELOPMENT](DEVELOPMENT.md) | 
[CHANGELOG](CHANGELOG.md) | 
[FUTURE_IDEAS](FUTURE_IDEAS.md)
