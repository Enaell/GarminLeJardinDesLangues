# Guide de Démarrage Rapide 🚀

## Installation

### Option 1 : Utiliser le Simulateur (Recommandé pour test)

1. **Ouvrir le projet dans VS Code**
   ```bash
   cd "C:\Users\oreli\OneDrive\Documents\Dev\Garmin\Language\Language"
   code .
   ```

2. **Compiler l'application**
   - Appuyez sur `Ctrl+Shift+P`
   - Tapez "Monkey C: Build for Device"
   - Sélectionnez "fenix847mm"

3. **Lancer le simulateur**
   - Appuyez sur `F5` (ou Run > Start Debugging)
   - L'application se lance automatiquement dans le simulateur

4. **Contrôles du simulateur**
   - ⬆️ **Flèche Haut** : Option précédente
   - ⬇️ **Flèche Bas** : Option suivante
   - ↩️ **Entrée** : Valider la réponse sélectionnée
   - 🖱️ **Clic souris** : Cliquer directement sur une option (sélection + validation)
   - **Escape** : Quitter

### Option 2 : Installer sur Montre Réelle

1. **Compiler en mode Release**
   - Ouvrir le terminal dans VS Code
   - Exécuter :
     ```bash
     monkey c -f monkey.jungle -d fenix847mm -o bin/Language.prg -r
     ```

2. **Transférer sur la montre**
   - Connecter la montre via USB
   - Copier `bin/Language.prg` dans le dossier `GARMIN/APPS/`
   - Déconnecter la montre

3. **Lancer l'application**
   - Sur la montre : Menu > Applications > Le Jardin des Langues

## Première Utilisation

### Écran d'Accueil - Menu

1. **Lancez l'application**
   - Un menu d'accueil s'affiche avec 2 options :
     - **Quiz 汉字 → Français** (Quiz Normal)
     - **Quiz Français → 汉字** (Quiz Inversé)

2. **Choisissez votre mode**
   ```
   ┌─────────────────────┐
   │  Le Jardin des      │
   │    Langues          │
   │                     │
   │ Choisissez quiz     │
   ├─────────────────────┤
   │ Quiz 汉字→Français ◄│  ← Sélectionné
   │                     │
   │ Quiz Français→汉字  │
   ├─────────────────────┤
   │ ↑↓ • SELECT lancer  │
   └─────────────────────┘
   ```

3. **Navigation du menu**
   - Bouton UP/DOWN : Changer de mode
   - SELECT : Lancer le quiz sélectionné
   - Clic tactile : Cliquer directement sur un mode pour le lancer

### Démarrer un Quiz

1. **Lancez l'application et choisissez votre mode**
   - Sélectionnez "Quiz 汉字 → Français" ou "Quiz Français → 汉字"
   - Un caractère chinois (mode normal) ou un mot français (mode inversé) s'affiche
   - Le pinyin (prononciation) est visible

2. **Lisez la question**
   
   **Mode Normal (汉字 → Français)** :
   ```
   ┌─────────────────────┐
   │                     │
   │        你好          │  ← Caractère chinois
   │      nǐ hǎo         │  ← Prononciation
   ├─────────────────────┤
   │  1. bonjour     ◄   │  ← Option sélectionnée
   │  2. au revoir       │
   │  3. merci           │
   │  4. pardon          │
   ├─────────────────────┤
   │      0/0            │  ← Score actuel
   └─────────────────────┘
   ```
   
   **Mode Inversé (Français → 汉字)** :
   ```
   ┌─────────────────────┐
   │                     │
   │      Bonjour        │  ← Mot français
   │      (nǐ hǎo)       │  ← Indice pinyin
   ├─────────────────────┤
   │  1. 你好        ◄   │  ← Option sélectionnée
   │  2. 再见            │
   │  3. 谢谢            │
   │  4. 请              │
   ├─────────────────────┤
   │      0/0            │  ← Score actuel
   └─────────────────────┘
   ```

3. **Choisissez votre méthode de réponse**
   
   **Méthode 1 : Navigation avec boutons**
   - Bouton UP (Haut) : Remonter dans la liste
   - Bouton DOWN (Bas) : Descendre dans la liste
   - L'option sélectionnée a un fond bleu
   - START/SELECT : Valider la réponse sélectionnée
   
   **Méthode 2 : Tactile (plus rapide !)**
   - Cliquez directement sur l'option désirée
   - Sélection + validation instantanée

4. **Consultez le feedback**
   - Un écran de feedback s'affiche :
     - **Vert** ✓ si correct
     - **Rouge** ✗ si incorrect (+ affichage de la bonne réponse)

5. **Passez au mot suivant**
   - Appuyez sur START/SELECT ou cliquez sur l'écran
   - Une nouvelle question apparaît

6. **Suivez votre progression**
   - Le score en bas de l'écran s'actualise : `3/5` = 3 bonnes réponses sur 5 questions

7. **Changez de mode**
   - Appuyez sur le bouton **BACK** pour retourner au menu
   - Choisissez l'autre mode de quiz

### Quitter

- Appuyez sur le bouton **BACK** depuis le menu pour quitter l'application

## Astuces d'Utilisation

### 📚 Stratégies d'Apprentissage

1. **Mode Découverte (Quiz Normal)**
   - Lisez le pinyin avant de chercher la réponse
   - Essayez de prononcer le mot
   - Apprenez de vos erreurs (la correction s'affiche)

2. **Mode Reconnaissance (Quiz Inversé)**
   - Essayez de visualiser le hanzi avant de voir les options
   - Utilisez le pinyin comme indice si besoin
   - Renforcez votre mémoire visuelle des caractères

3. **Mode Challenge**
   - Alternez entre les 2 modes de quiz
   - Essayez de reconnaître sans lire le pinyin
   - Visez un taux de réussite > 80%

4. **Mode Révision**
   - Notez les mots que vous ratez souvent
   - Refaites des sessions pour les revoir
   - L'anti-répétition évite de voir le même mot 2 fois de suite

### 🎯 Objectifs Quotidiens

| Niveau | Objectif |
|--------|----------|
| Débutant | 10 questions/jour (5 min) |
| Intermédiaire | 30 questions/jour (15 min) |
| Avancé | 50+ questions/jour (25 min) |

### 📊 Interprétation du Score

| Taux de Réussite | Niveau |
|------------------|--------|
| 0-30% | Découverte - C'est normal au début ! |
| 30-50% | Apprentissage - Vous progressez |
| 50-70% | Consolidation - Continuez ! |
| 70-85% | Bon niveau - Bravo ! |
| 85-100% | Excellent - Passez au HSK 3 ? |

## Dépannage

### Les caractères chinois ne s'affichent pas
- **Cause** : Police de la montre ne supporte pas les caractères chinois
- **Solution** : Utiliser le simulateur ou mettre à jour le firmware de la montre

### L'application ne se lance pas
- **Vérifications** :
  1. Montre compatible ? (Fenix 8 série)
  2. Espace disque suffisant ? (>1 MB)
  3. Firmware à jour ?

### L'application plante
- **Cause possible** : Mémoire insuffisante
- **Solution** : Fermer d'autres applications en arrière-plan

### Le score ne se sauvegarde pas
- **C'est normal** : La version 1.0 ne persiste pas les données
- **À venir** : Version 1.2 avec sauvegarde automatique

## Raccourcis Clavier (Simulateur)

| Touche/Action | Résultat |
|--------|--------|
| ⬆️ | Option précédente |
| ⬇️ | Option suivante |
| ↩️ | Valider la réponse sélectionnée |
| 🖱️ Clic | Sélectionner + valider directement l'option cliquée |
| Esc | Quitter |
| F5 | Relancer le simulateur |
| Ctrl+Shift+B | Compiler |

## Commandes Utiles (Terminal)

```bash
# Compiler
monkey c -f monkey.jungle -d fenix847mm -o bin/Language.prg

# Compiler + Warnings
monkey c -f monkey.jungle -d fenix847mm -o bin/Language.prg -w

# Compiler + Lancer simulateur
monkeydo bin/Language.prg fenix847mm

# Nettoyer le build
rm -rf bin/*
```

## Vocabulaire HSK - Aperçu

### HSK 1 (150 mots)
- **Thèmes** : Salutations, nombres, famille, temps, actions de base
- **Exemples** : 你好 (bonjour), 我 (je), 谢谢 (merci)

### HSK 2 (150 mots)
- **Thèmes** : Couleurs, activités, émotions, descriptions
- **Exemples** : 漂亮 (beau), 游泳 (nager), 因为 (parce que)

## Prochaines Étapes

### Après avoir maîtrisé les bases
1. ✅ Atteignez 70% de réussite sur 50 questions en mode normal
2. ✅ Testez le mode inversé pour renforcer la mémorisation
3. 📚 Révisez les mots difficiles (notez-les)
4. 🎯 Essayez de reconnaître les caractères sans le pinyin
5. 🚀 Attendez la v1.2 pour les statistiques détaillées et la persistance

### Pour contribuer au projet
- Consultez `DEVELOPMENT.md` pour le guide développeur
- Proposez des améliorations sur GitHub
- Signalez des bugs ou erreurs de traduction

## Support

- 📖 Documentation complète : `README.md`
- 💻 Guide développeur : `DEVELOPMENT.md`
- 📝 Historique des versions : `CHANGELOG.md`
- 🐛 Problème ? Ouvrir une issue sur GitHub

---

**Bon apprentissage ! 加油！(jiā yóu - courage !)**

*Dernière mise à jour : 20 octobre 2025*
