# PlistPulse — installer sans NewTerm

## Le plus simple : GitHub Actions

Le fichier `.github/workflows/build.yml` demande à GitHub de compiler PlistPulse pour vous. Il utilise l'installateur officiel RootHide Theos et fournit un fichier `.deb` à télécharger.

### 1. Créer le dépôt

1. Allez sur https://github.com et connectez-vous (ou créez un compte gratuit).
2. Cliquez sur **+** en haut à droite → **New repository**.
3. Nom : `PlistPulse`. Choisissez **Private** si vous voulez, puis **Create repository**.
4. Sur la page qui s'ouvre, cliquez sur **uploading an existing file**.

### 2. Envoyer les fichiers

1. Sur le PC, ouvrez le dossier `PlistPulse` (pas seulement le ZIP).
2. Sélectionnez **tout ce qu'il contient**, y compris le dossier caché `.github`, puis faites glisser les fichiers dans la page GitHub.
   - Le dossier `.github` est indispensable : c'est lui qui lance la compilation.
   - Si Windows ne l'affiche pas, dans l'explorateur : **Affichage → Afficher → Éléments masqués**.
3. En bas de la page, cliquez sur **Commit changes**.

### 3. Lancer la compilation

1. Dans votre dépôt, ouvrez l'onglet **Actions**.
2. Si GitHub demande l'autorisation, cliquez sur **I understand my workflows, go ahead and enable them**.
3. À gauche, cliquez sur **Build PlistPulse (.deb)**.
4. Cliquez sur **Run workflow** → **Run workflow**.
5. Attendez quelques minutes. Un rond jaune = en cours ; une coche verte = terminé. Une croix rouge = erreur : ouvrez le build et copiez le message d'erreur.

### 4. Installer sur l'iPhone

1. Quand la coche est verte, cliquez sur le nom du build.
2. En bas, dans **Artifacts**, cliquez sur **PlistPulse-deb**. GitHub télécharge un petit ZIP.
3. Décompressez ce ZIP et envoyez le fichier **`.deb`** sur votre iPhone (iCloud Drive, AirDrop, etc.).
4. Dans **Filza**, touchez le `.deb` → **Installer** avec Sileo/Zebra.
5. Ouvrez **PlistPulse** sur l'écran d'accueil.

### 5. Surveiller un plist

1. Dans Filza, faites **Copy path** sur le plist voulu.
2. Dans PlistPulse : **Paste path from Filza** → **Start monitoring**.
3. Utilisez l'application cible, puis revenez lire les changements.

⚠️ **Open in** dans Filza importe souvent une copie : utilisez **Copy path** pour surveiller le fichier original.

Le build n'a pas encore été testé sur un appareil réel. Si GitHub affiche une erreur, envoyez le texte exact pour correction.
