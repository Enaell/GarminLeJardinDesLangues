Descriptif du Projet
Nom du Projet
Le Jardin des Langues - Quiz Mandarin HSK

Objectif
Créer une application Monkey C pour montres Garmin Fenix 8 (47mm) permettant d'apprendre et réviser le vocabulaire mandarin des niveaux HSK 1 et 2 à travers un système de quiz à choix multiples.

Fonctionnalités Principales
Version 1.0 (MVP - Minimum Viable Product)
Affichage d'un mot en mandarin (caractères chinois)
Proposition de 4 traductions possibles en français
Sélection de la réponse via les boutons de la montre
Feedback visuel (bonne/mauvaise réponse)
Navigation vers le mot suivant
Fonctionnalités Futures (v2.0+)
Statistiques de progression
Mode révision des mots difficiles
Affichage du pinyin
Exemples de phrases
Filtrage par niveau HSK
Mode inverse (français → mandarin)
Structure des Données
Format de stockage des mots
Chaque entrée de vocabulaire contient :

id : identifiant unique
hanzi : caractères chinois (ex: "你好")
pinyin : prononciation romanisée (ex: "nǐ hǎo")
translations : array de traductions françaises (ex: ["bonjour", "salut"])
examples : array de phrases d'exemple (optionnel pour v1.0)
hskLevel : niveau HSK (1 ou 2)
Taille du vocabulaire
HSK 1 : ~150 mots
HSK 2 : ~150 mots
Total : ~300 mots
Architecture Technique
Technologies
Langage : Monkey C (Connect IQ SDK)
Plateforme cible : Garmin Fenix 8 47mm (006-B4534-00)
Format de données : Ressources JSON ou Array Monkey C
Composants principaux
QuizView : Vue principale du quiz
QuizModel : Logique de gestion des questions
VocabularyData : Stockage et accès aux données
ScoreManager : Gestion des scores (v2.0)
Étapes de Développement
Phase 1 : Préparation des Données (1-2 jours)
Étape 1.1 : Collecte du vocabulaire HSK
 Récupérer la liste officielle des mots HSK 1 (environ 150 mots)
 Récupérer la liste officielle des mots HSK 2 (environ 150 mots)
 Pour chaque mot, collecter :
Caractères chinois (hanzi)
Pinyin avec tons
Traduction(s) française(s) principale(s)
Niveau HSK
Étape 1.2 : Structuration des données
 Créer un fichier de données structuré (JSON ou format compatible)
 Valider la complétude des données (tous les champs requis présents)
 Créer quelques phrases d'exemple pour 10-20 mots (pour test futur)
Étape 1.3 : Intégration dans Monkey C
 Convertir les données en format compatible Monkey C
 Créer un module VocabularyData.mc pour stocker les mots
 Implémenter une fonction d'accès aux données par index
 Implémenter une fonction de recherche aléatoire
Phase 2 : Structure de Base de l'Application (2-3 jours)
Étape 2.1 : Configuration du projet
 Mettre à jour manifest.xml avec :
Support Fenix 8 47mm (aucune modification nécessaire si déjà configuré)
Permissions nécessaires
Icônes et ressources
 Configurer monkey.jungle pour le device cible
Étape 2.2 : Création du modèle de données (QuizModel.mc)
 Créer la classe QuizModel avec :
Sélection aléatoire d'un mot
Génération de 3 mauvaises réponses (distracteurs)
Mélange des 4 options
Vérification de la réponse
Passage au mot suivant
 Implémenter la logique d'évitement des répétitions immédiates
Étape 2.3 : Création de la vue principale (QuizView.mc)
 Créer la classe QuizView héritant de Ui.View
 Implémenter onLayout() pour définir la structure :
Zone d'affichage du mot en mandarin (hanzi)
Zone pour les 4 options de réponse
Indicateur de sélection actuelle
 Implémenter onUpdate() pour le rendu graphique
 Optimiser l'affichage pour l'écran rond de 47mm
Phase 3 : Interactions Utilisateur (2-3 jours)
Étape 3.1 : Gestion des entrées (QuizDelegate.mc)
 Créer QuizDelegate héritant de Ui.BehaviorDelegate
 Implémenter la navigation entre options :
Bouton UP : option précédente
Bouton DOWN : option suivante
Bouton START/SELECT : valider la réponse
Bouton BACK : retour au menu (ou quitter)
 Connecter le delegate à la vue
Étape 3.2 : Feedback visuel
 Implémenter l'affichage de la bonne réponse (fond vert, icône ✓)
 Implémenter l'affichage de la mauvaise réponse (fond rouge, icône ✗)
 Ajouter un délai de 1-2 secondes avant de passer au mot suivant
 Afficher la correction si mauvaise réponse
Étape 3.3 : Menu de démarrage (optionnel pour v1.0)
 Créer un écran de démarrage simple
 Ajouter un bouton "Commencer le quiz"
 Ajouter une option "Quitter"
Phase 4 : Ressources et Polissage (1-2 jours)
Étape 4.1 : Ressources graphiques
 Mettre à jour strings.xml avec les textes nécessaires
 Créer/adapter les layouts dans layout.xml
 Ajouter des drawables si nécessaire (icônes, fond)
 S'assurer du support des caractères chinois (police appropriée)
Étape 4.2 : Tests sur simulateur
 Tester l'affichage des caractères chinois
 Vérifier la lisibilité sur écran rond 47mm
 Tester toutes les interactions
 Vérifier les performances (fluidité)
 Tester avec différents mots (courts, longs)
Étape 4.3 : Optimisation
 Optimiser l'utilisation de la mémoire
 Réduire les temps de chargement si nécessaire
 Vérifier qu'il n'y a pas de répétitions de mots à court terme
Phase 5 : Build et Déploiement (1 jour)
Étape 5.1 : Build final
 Compiler l'application pour Fenix 8 47mm
 Résoudre tous les warnings et erreurs
 Vérifier la taille du fichier .prg (limites de la montre)
Étape 5.2 : Tests sur appareil réel (si disponible)
 Installer sur Fenix 8
 Tester en conditions réelles
 Vérifier la batterie et les performances
 Ajuster si nécessaire
Étape 5.3 : Documentation
 Rédiger un README avec :
Description de l'application
Instructions d'installation
Instructions d'utilisation
Vocabulaire source (HSK 1-2)
 Documenter le code (commentaires)
 Créer une liste des améliorations futures
Structure des Fichiers du Projet
Recommandations Techniques
Gestion des Caractères Chinois
Vérifier que la police de la montre supporte les caractères chinois
Si non, inclure une police personnalisée dans les ressources
Tester l'affichage avec différents caractères (simples et complexes)
Optimisation Mémoire
Les montres Garmin ont une mémoire limitée
Charger les données de manière efficiente
Utiliser des tableaux plutôt que des dictionnaires si possible
Limiter le nombre de variables globales
Génération des Distracteurs
Sélectionner 3 mauvaises réponses aléatoires parmi les autres mots
S'assurer qu'elles soient différentes de la bonne réponse
Éviter les réponses trop similaires ou trop évidentes
Interface Utilisateur
Privilégier la simplicité et la lisibilité
Utiliser de grandes polices pour le texte chinois
Contraste élevé pour une lecture en extérieur
Interface responsive pour l'écran rond
Livrables Attendus
Code source complet de l'application
Fichier de données avec vocabulaire HSK 1-2
Application compilée (.prg) prête à installer
Documentation utilisateur (README)
Documentation développeur (commentaires dans le code)
