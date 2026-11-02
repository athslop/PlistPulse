# PlistPulse

Read-only, live plist change monitor for **RootHide on iOS 15–17**.

- Paste an absolute plist path copied from **Filza**.
- See `ADDED`, `REMOVED`, and `CHANGED old → new` entries with timestamps.
- Background recorder keeps watching while you press buttons or navigate in the target app.
- Pause/resume the viewer, clear, tap an event to copy it, or share the text log.
- Supports nested dictionaries and arrays, plus binary and XML plists.
- Keeps the most recent 1,000 visible events.

## Important

1. In Filza, select the plist and use **More / Copy path** (wording varies by version). Switch to PlistPulse and tap **Paste path from Filza**.
2. Filza **Open in → PlistPulse** normally imports a temporary copy into the app's Inbox. That is **not the original file** and cannot provide live original-file changes. PlistPulse labels this case explicitly.
3. Only changes saved to disk are visible. A button that only changes memory, UI state, or a database will not change a plist. Apps using `cfprefsd` may delay saving, cache old values, or use a different preferences domain/path.
4. Monitoring polls every 150 ms and also uses vnode events. Multiple writes within one polling interval may be coalesced; this is not a per-write audit trail.
5. The selected plist is never modified by PlistPulse. Logs may contain sensitive preference values; export them carefully.

## Build directly on your RootHide iPhone

You need a RootHide terminal app (for example NewTerm), Filza, and your RootHide package manager. The official RootHide Theos installer downloads the build dependencies, toolchain, Theos, and patched SDKs; you do **not** need to clone Theos or download an SDK separately.

1. Transfer `PlistPulse.zip` to your iPhone and extract it in Filza. The ZIP contains source code, **not a ready-to-install app**.
2. Open a terminal as the normal **mobile** user, not root. Install the small set of prerequisites needed by the official installer:

   ```sh
   sudo apt-get update
   sudo apt-get install -y bash curl sudo coreutils xz-utils
   ```

   Use `sudo` only for package installation. Do not run the Theos installer or `make` as root.

3. Run [RootHide's official Theos installer](https://github.com/roothide/Developer):

   ```sh
   bash -c "$(curl -fsSL https://raw.githubusercontent.com/roothide/theos/master/bin/install-theos)"
   ```

   When asked about repositories, confirm the Procursus repository normally used by RootHide: `https://apt.procurs.us`. Answer **no** to the optional Swift question; PlistPulse is Objective-C. Follow any password prompts.

4. Restart the terminal as the installer requests, then verify Theos:

   ```sh
   export THEOS="$HOME/theos"
   echo "$THEOS"
   ```

   It should print your Theos path. The installer also adds this setting to your shell profile for future sessions.

5. In Filza, copy the full path of the **extracted `PlistPulse` folder**. Back in the terminal, enter the following, replacing the placeholder with that path (keep the quotes):

   ```sh
   cd "PASTE_EXTRACTED_PLISTPULSE_FOLDER_PATH"
   make clean package FINALPACKAGE=1
   ```

6. After a successful build, open `PlistPulse/packages/` in Filza. Tap the generated `.deb` and install it with your RootHide package manager (Sileo/Zebra).

If a command fails, stop and use its exact error output to troubleshoot; do not rerun the installer as root. The Makefile already sets `THEOS_PACKAGE_SCHEME=roothide`, `arm64`, and an iOS 15 minimum. The package includes the app, RootHide entitlements, an on-demand recorder daemon, and `jbroot` path handling.

If the app icon does not appear after installation, run `uicache -a` in the RootHide shell. The package installer also attempts this.

### Build on another computer (optional)

The same official installer also supports macOS/Linux/WSL. On macOS, full Xcode is required. After installing RootHide Theos, run `make clean package FINALPACKAGE=1` from the extracted project and transfer the `.deb` from `packages/` to your iPhone.

The Windows machine used to prepare this source did not have Theos or an iOS SDK. No prebuilt `.deb` or device-tested binary is included.

## Use

1. Open PlistPulse.
2. Copy a full plist path in Filza and paste it in PlistPulse.
3. Tap **Start monitoring**. The status should say the background recorder is running.
4. Switch to the target app and press buttons/navigate.
5. Return to PlistPulse to review timestamped changes. The visible list also refreshes while open.

## Host-side checks

```sh
python -m unittest discover -s Tests -v
```

The included tests cover the diff algorithm's nested keys, arrays, added/removed keys, false/zero values, and unchanged snapshots. They are host-side algorithm regression tests, not an iOS device test. A real RootHide device must still verify compilation, launch-daemon privileges, Filza path flow, and target-app save behavior.
