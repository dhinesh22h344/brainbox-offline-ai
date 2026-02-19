# Build Brainbox Android APK (to share with users)

## Quick way (Android Studio)

1. **Open the project**  
   In Android Studio: **File → Open** → select the **BrainboxAndroid** folder (this folder). Wait for Gradle sync to finish.

2. **Build the APK**  
   Menu: **Build → Build Bundle(s) / APK(s) → Build APK(s)**.  
   Wait until you see "APK(s) generated successfully" at the bottom.

3. **Find the APK**  
   Click **locate** in the notification, or open this folder on your computer:
   ```
   BrainboxAndroid/app/build/outputs/apk/debug/app-debug.apk
   ```

4. **Share the APK**  
   Send `app-debug.apk` to your user (email, Google Drive, WhatsApp, Telegram, etc.).  
   The user installs it on their Android phone (they may need to allow "Install from unknown sources" for your file manager or browser).

---

## Install on the user's phone

- **Option A:** Copy the APK to the phone (USB, Drive, etc.) and open it with a file manager. Tap the APK → Install.
- **Option B:** Send the APK via chat/email. They download it, open the file, and install.

If they see "For your security, your phone is not allowed to install unknown apps from this source":  
→ Open **Settings → Security** (or **Apps → Special app access**) → **Install unknown apps** → enable for the app they used to open the APK (e.g. Files, Chrome).

---

## One-line summary

**Build in Android Studio:** Build → Build Bundle(s) / APK(s) → Build APK(s) → share **app/build/outputs/apk/debug/app-debug.apk**.
