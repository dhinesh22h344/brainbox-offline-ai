# Get a one-click Android APK download link

So users can **click a link → APK downloads → they install and use Brainbox** (all your questions/code work offline in the app).

---

## Step 1: Create a release tag and push

From your project folder (e.g. `Offline Chatgpt Ios`), run:

```bash
cd "/Users/dhineshs/Desktop/Offline Chatgpt Ios"

git add .
git commit -m "Add Android build workflow and Gradle wrapper"   # if you have new changes
git push origin main

# Create and push tag v1.0 (this triggers the workflow)
git tag v1.0
git push origin v1.0
```

---

## Step 2: Wait for the workflow to finish

1. Open: **https://github.com/dhinesh22h344/brainbox-offline-ai/actions**
2. Click the run **"Build Android APK & Release"** for the `v1.0` push.
3. Wait until the job is **green** (about 5–10 minutes).

---

## Step 3: Your APK download link

After the workflow succeeds, the release is created with the APK attached.

**Use this link (one-click download for users):**

```
https://github.com/dhinesh22h344/brainbox-offline-ai/releases/download/v1.0/app-debug.apk
```

- **Short link for sharing:**  
  **https://github.com/dhinesh22h344/brainbox-offline-ai/releases/latest**  
  (Users click “Latest” → then download **app-debug.apk** from the release.)

Or the **direct APK link** (starts download when opened on phone or PC):

**https://github.com/dhinesh22h344/brainbox-offline-ai/releases/download/v1.0/app-debug.apk**

---

## What to tell your user

- **“Download the app here: [paste the link above]”**
- **“On your Android phone, open the link → download → open the file and install. Allow ‘Install from unknown sources’ if asked. Then open Brainbox and ask any coding question; it works offline.”**

---

## Later: new version (e.g. v1.1)

When you want to release an update:

```bash
git tag v1.1
git push origin v1.1
```

New link:  
`https://github.com/dhinesh22h344/brainbox-offline-ai/releases/download/v1.1/app-debug.apk`

---

## If you run the workflow manually (no tag)

1. Go to **Actions** → **Build Android APK & Release** → **Run workflow** → **Run**.
2. When the run finishes, open that run → under **Artifacts** download **brainbox-app-debug** (the APK).
3. There is **no** public one-click link in this case; you’d have to upload that APK to a release yourself or share the file (e.g. Drive, WhatsApp).

For a **stable one-click link**, use a tag (e.g. `v1.0`) as above.
