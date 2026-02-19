# Publishing Brainbox to App Store (iOS) and Play Store (Android)

This guide walks you through the process of publishing the Brainbox app on both stores.

---

## Part 1: iOS — App Store

### Requirements

- **Apple Developer Program** — **$99 USD/year** (required to publish)
  - Sign up: [developer.apple.com/programs/enroll](https://developer.apple.com/programs/enroll)
  - Use the same Apple ID you’ll use in Xcode for signing.

### Steps to publish on the App Store

#### 1. Prepare the app in Xcode

- Open **OfflineCursorBrain.xcodeproj** in Xcode.
- Select the **OfflineCursorBrain** target → **Signing & Capabilities**.
  - Check **Automatically manage signing**.
  - **Team:** Select your Apple Developer account (your paid team).
  - **Bundle Identifier:** Must be unique worldwide, e.g. `com.yourname.brainbox` (change from `com.offlinecursorbrain.app` if needed).
- Set **Version** (e.g. `1.0`) and **Build** (e.g. `1`) in the target’s **General** tab.

#### 2. Create the app in App Store Connect

- Go to [App Store Connect](https://appstoreconnect.apple.com) → **My Apps** → **+** → **New App**.
- Fill in:
  - **Platform:** iOS  
  - **Name:** Brainbox  
  - **Primary Language**  
  - **Bundle ID:** Choose the same one you set in Xcode (e.g. `com.yourname.brainbox`).  
  - **SKU:** Any unique string (e.g. `brainbox-ios`).

#### 3. App Store listing (metadata)

In App Store Connect, for your app → **App Information** and **1.0 Prepare for Submission**:

- **Name:** Brainbox  
- **Subtitle:** Short tagline (e.g. “Offline AI chat & code help”).  
- **Description:** What the app does, that it works fully offline, and that it gives code examples/tips.  
- **Keywords:** e.g. offline, chat, code, programming, Java, Python, React, learning.  
- **Category:** e.g. **Education** or **Developer Tools**.  
- **Privacy Policy URL:** Required. Host a page that says you don’t collect or send user data (everything is on-device). You can use GitHub Pages, your website, or a free host.  
- **Support URL:** A page or email where users can get help.  
- **Screenshots:** Required for each device size (e.g. 6.7", 6.5", 5.5" for iPhone). Run the app in the simulator, take screenshots, and upload in App Store Connect.

#### 4. Build and upload with Xcode

- In Xcode, select **Any iOS Device (arm64)** (not a simulator).
- Menu: **Product → Archive**.
- When the archive is done, the **Organizer** window opens.
- Click **Distribute App** → **App Store Connect** → **Upload**.
- Follow the prompts (signing is usually automatic if you have a paid account).
- After upload, wait 5–15 minutes. In App Store Connect → your app → **TestFlight** or **App Store** tab, the new build will appear under the version.

#### 5. Submit for review

- In App Store Connect, open the version (e.g. 1.0) you’re releasing.
- Select the build you just uploaded.
- Answer **Export Compliance**, **Content Rights**, **Advertising Identifier** (typically “No” if you don’t use ads).
- Click **Add for Review** → **Submit to App Review**.

Apple usually reviews within 24–48 hours. Once approved, you can release manually or set to **Automatically release**.

---

## Part 2: Android — Google Play Store

### Requirements

- **Google Play Developer account** — **One-time $25 USD** registration fee.
  - Sign up: [play.google.com/console/signup](https://play.google.com/console/signup)

### Steps to publish on the Play Store

#### 1. Prepare the app in Android Studio

- Open the **BrainboxAndroid** project in Android Studio.
- **Build → Generate Signed Bundle / APK** → choose **Android App Bundle** (recommended for Play Store).
- Create or choose a **keystore** (e.g. `brainbox-release.keystore`).  
  - **Keep this file and passwords safe.** You need them for every future update.
- Fill in **key alias** and **passwords**.
- Select **release** build variant → **Create**.

You’ll get an **.aab** file (e.g. `app-release.aab`) in `app/build/outputs/bundle/release/`.

(For **debug** install only, you can use **Build → Build Bundle(s) / APK(s) → Build APK(s)** and install the debug APK on a device; that build is not for Play Store.)

#### 2. Create the app in Play Console

- Go to [Play Console](https://play.google.com/console) → **Create app**.
- Fill in **App name** (Brainbox), **Default language**, and accept the declarations.

#### 3. Complete store listing and policy

In Play Console, for your app:

- **Main store listing**
  - **Short description** (up to 80 characters): e.g. “Offline AI chat & code examples. No internet needed.”
  - **Full description:** What Brainbox does, that it’s offline-only, and which languages/frameworks it supports.
  - **Graphics**
    - **App icon:** 512 x 512 px (PNG, no transparency).
    - **Feature graphic:** 1024 x 500 px (optional but recommended).
    - **Screenshots:** At least 2 (phone); add 7" and 10" if you support tablets.

- **Privacy policy**
  - Play requires a **privacy policy URL**. Use the same idea as iOS: no data collection, everything on-device.

- **App content**
  - Complete **Privacy policy**, **Ads** (declare if your app has no ads), **App access** (if no login, say “No login required”), and any other required questionnaires.

#### 4. Create a release

- In the left menu: **Release → Production** (or **Testing** first if you want internal/closed testing).
- **Create new release** → upload your **.aab** file.
- **Release name:** e.g. “1.0 (1)”.
- Add **Release notes** (what’s new for users).
- **Save** → **Review release** → **Start rollout to Production** (or to a testing track).

#### 5. Review and publish

- Finish any remaining setup (e.g. **Content rating** questionnaire, **Target audience**, **News app** declaration if applicable).
- Once the release is submitted, Google reviews the app (often within a few days). After approval, the app goes live on the Play Store according to your rollout.

---

## Checklist summary

### iOS (App Store)

| Step | Action |
|------|--------|
| 1 | Enroll in Apple Developer Program ($99/year). |
| 2 | In Xcode: set Team, unique Bundle ID, version & build. |
| 3 | In App Store Connect: create app, fill name, description, keywords, category, privacy policy URL, support URL. |
| 4 | Add screenshots (required sizes). |
| 5 | Xcode: Product → Archive → Distribute to App Store Connect. |
| 6 | In App Store Connect: select build, complete compliance, submit for review. |

### Android (Play Store)

| Step | Action |
|------|--------|
| 1 | Register Google Play Developer account ($25 one-time). |
| 2 | In Android Studio: build a **release** Android App Bundle (.aab) with a **release keystore** (keep it safe). |
| 3 | In Play Console: create app, complete store listing (short/full description, icon, screenshots, feature graphic). |
| 4 | Add privacy policy URL and complete “App content” (ads, app access, etc.). |
| 5 | Create a release, upload the .aab, add release notes, submit for review. |

---

## Privacy policy (both stores)

Both Apple and Google require a **public privacy policy URL**. For Brainbox you can use something like:

- **Data collection:** None. The app does not collect, store, or transmit personal data to any server.
- **Storage:** Chat history is stored only on the user’s device and is not sent elsewhere.
- **Offline:** The app works fully offline and does not use the network for its “brain” responses.

Host this on a webpage (e.g. GitHub Pages, your site, or a free hosting service) and use that URL in both App Store Connect and Play Console.

---

## Costs (approximate)

- **Apple:** $99 USD per year (Apple Developer Program).  
- **Google:** $25 USD one-time (Play Developer account).

You’ll need to handle taxes/payouts in each developer console (e.g. tax forms, bank details for paid apps if you add in-app purchases later).

---

## Useful links

- **Apple**
  - [App Store Connect](https://appstoreconnect.apple.com)
  - [Developer Program](https://developer.apple.com/programs/)
  - [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- **Google**
  - [Play Console](https://play.google.com/console)
  - [Launch checklist](https://support.google.com/googleplay/android-developer/answer/9859152)

Once you’ve done one release on each store, future updates follow the same flow: bump version/build, upload a new build, and submit (or roll out) the new version.
