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
   - Un menu d'accueil s'affiche avec 3 options :
     - **Quiz 汉字 → Français** (Quiz Normal)
     - **Quiz Français → 汉字** (Quiz Inversé)
     - **📖 Dictionnaire** (Parcourir tous les mots)

2. **Choisissez votre mode**
   ```
   ┌─────────────────────┐
   │  Le Jardin des      │
   │    Langues          │
   │                     │
   │  Choisissez mode    │
   ├─────────────────────┤
   │ 汉字 → Français  ◄  │  ← Sélectionné
   │ Quiz                │
   │                     │
   │ Français → 汉字     │
   │ Quiz inversé        │
   │                     │
   │ 📖 Dictionnaire     │
   │ Parcourir mots      │
   ├─────────────────────┤
   │ ↑↓ • SELECT         │
   └─────────────────────┘
   ```

3. **Navigation du menu**
   - Bouton UP/DOWN : Changer de mode (3 options)
   - SELECT : Lancer le mode sélectionné
   - Clic tactile : Cliquer directement sur un mode pour le lancer
   - BACK : Quitter l'application

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
   │      nǐ hǎo         │  ← Prononciation (MENU: cacher)
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
   │      (nǐ hǎo)       │  ← Indice pinyin (MENU: cacher)
   ├─────────────────────┤
   │  1. 你好        ◄   │  ← Option sélectionnée
   │  2. 再见            │
   │  3. 谢谢            │
   │  4. 请              │
   ├─────────────────────┤
   │      0/0            │  ← Score actuel
   └─────────────────────┘
   ```

3. **Afficher/Cacher le Pinyin (v1.2+)** 🆕
   - Appuyez sur le bouton **MENU** pour basculer l'affichage du pinyin
   - **Pinyin caché** : Plus difficile, meilleur pour la mémorisation
   - **Pinyin visible** : Aide à la prononciation
   - L'indicateur `[MENU: Pinyin]` s'affiche quand le pinyin est caché
   - Votre choix est conservé pour toutes les questions suivantes

4. **Choisissez votre méthode de réponse**
   
   **Méthode 1 : Navigation avec boutons**
   - Bouton UP (Haut) : Remonter dans la liste
   - Bouton DOWN (Bas) : Descendre dans la liste
   - Bouton MENU : Afficher/Cacher le pinyin 🆕
   - L'option sélectionnée a un fond bleu
   - START/SELECT : Valider la réponse sélectionnée
   
   **Méthode 2 : Tactile (plus rapide !)**
   - Cliquez directement sur l'option désirée
   - Sélection + validation instantanée

4. **Consultez le feedback**
   - Un écran de feedback s'affiche :
     - **Vert** ✓ si correct
     - **Rouge** ✗ si incorrect (+ affichage de la bonne réponse)

5. **Évaluez le mot (Optionnel - v1.3+)** 🆕
   - Après le feedback, vous avez 2 choix :
     - **Cliquer sur "[ Évaluer ]"** en bas : Ouvrir l'écran d'évaluation
     - **Cliquer ailleurs ou SELECT** : Passer directement au mot suivant
   
   **Si vous choisissez d'évaluer** :
   ```
   ┌─────────────────────┐
   │ Niveau de maîtrise ?│
   │       你好           │
   ├─────────────────────┤
   │   ✓ Maîtrisé        │  (vert)
   │   ○ Connu       ◄   │  (orange) ← Sélectionné
   │   ✗ Inconnu         │  (rouge)
   └─────────────────────┘
   ```
   - **✓ Maîtrisé** : Vous connaissez parfaitement ce mot
   - **○ Connu** : Vous reconnaissez le mot mais pas sûr
   - **✗ Inconnu** : Ce mot vous est totalement inconnu
   - Votre évaluation est **sauvegardée** et persiste entre les sessions
   - Naviguez avec UP/DOWN ou cliquez directement

6. **Passez au mot suivant**
   - Une nouvelle question apparaît automatiquement

7. **Suivez votre progression**
   - Le score en bas de l'écran s'actualise : `3/5` = 3 bonnes réponses sur 5 questions

8. **Changez de mode**
   - Appuyez sur le bouton **BACK** pour retourner au menu
   - Choisissez un autre mode (quiz ou dictionnaire)

### Utiliser le Dictionnaire (v1.4+) 🆕

1. **Accédez au dictionnaire**
   - Depuis le menu principal, sélectionnez "📖 Dictionnaire"
   
2. **Parcourez la liste**
   ```
   ┌─────────────────────┐
   │ Dictionnaire        │
   │ 300/300 mots        │
   ├─────────────────────┤
   │ ✓ 你好     bonjour  │ ← Cliquez pour détails
   │ ○ 谢谢     merci    │ ← Swipe pour scroll
   │ ✗ 对不起   pardon   │
   │ ✓ 请       s'il...  │
   └─────────────────────┘
   ```
   - UP/DOWN : Naviguer dans la liste (scroll automatique)
   - Swipe UP/DOWN : Scroll rapide (4 mots à la fois)
   - Icônes : ✓ Maîtrisé / ○ Connu / ✗ Inconnu

3. **Filtrer par statut**
   - Appuyez sur **MENU** pour cycler entre les filtres :
     - **Tous** : 300 mots
     - **Maîtrisés** : Uniquement les ✓
     - **Connus** : Uniquement les ○
     - **Inconnus** : Uniquement les ✗
   - Le compteur s'adapte (ex: "Maîtrisés (42)")

4. **Voir les détails d'un mot**
   - Clic sur un mot : ouvre directement les détails
   - Ou SELECT après avoir navigué sur un mot
   - Affichage complet : hanzi, pinyin, traduction, HSK, statut

5. **Modifier le statut**
   - Depuis la vue détail, cliquez sur la zone "Statut" en bas
   - Ou appuyez sur SELECT
   - Choisissez le nouveau statut :
     - UP/DOWN pour naviguer
     - SELECT pour valider
     - Ou clic direct sur une option
   - BACK pour annuler

6. **Retour**
   - BACK : Retour au dictionnaire
   - BACK (depuis dictionnaire) : Retour au menu

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

3. **Mode Challenge (v1.2+)** 🆕
   - Alternez entre les 2 modes de quiz
   - **Cachez le pinyin** pour augmenter la difficulté (bouton MENU)
   - Essayez de reconnaître les caractères sans aide
   - Visez un taux de réussite > 80%

4. **Mode Révision (v1.3+)** 🆕
   - Évaluez les mots pour suivre votre progression
   - Cliquez sur "[ Évaluer ]" pour marquer les mots :
     - ✓ **Maîtrisé** : Mot parfaitement connu
     - ○ **Connu** : Mot reconnu mais incertain
     - ✗ **Inconnu** : Mot totalement inconnu
   - Les évaluations sont sauvegardées entre les sessions
   - Ou passez directement au mot suivant (évaluation optionnelle)

5. **Mode Dictionnaire (v1.4+)** 🆕
   - Parcourez tous les 300 mots HSK 1 & 2
   - Filtrez par statut (Maîtrisés/Connus/Inconnus)
   - Consultez les détails complets de chaque mot
   - Modifiez les statuts directement depuis le dictionnaire
   - Parfait pour révision ou auto-évaluation avant quiz

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
- **C'est normal** : Le score de la session actuelle n'est pas persisté
- **Mais** : Les évaluations de mots (v1.3+) sont sauvegardées automatiquement
- **À venir** : Historique complet des sessions

## Raccourcis Clavier (Simulateur)

| Touche/Action | Résultat |
|--------|--------|
| ⬆️ | Option précédente / Naviguer dans liste |
| ⬇️ | Option suivante / Naviguer dans liste |
| M | Afficher/Cacher le pinyin (MENU) / Filtrer dictionnaire 🆕 |
| ↩️ | Valider / Ouvrir détails |
| 🖱️ Clic | Sélectionner + valider / Ouvrir détails |
| Esc | Retour / Quitter |
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
3. ✅ Cachez le pinyin pour augmenter la difficulté (v1.2+)
4. ✅ Évaluez vos mots pour suivre votre progression (v1.3+)
5. ✅ Utilisez le dictionnaire pour réviser tous les mots (v1.4+)
6. 📚 Filtrez les mots "Inconnus" dans le dictionnaire et révisez-les
7. 🎯 Marquez les mots comme "Maîtrisés" au fur et à mesure
8. 🚀 Visez 100% de mots maîtrisés !

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

*Dernière mise à jour : 22 octobre 2025 - Version 1.4.0*
