# One Minute

> **Your thoughts. Just one minute.**

One Minute is a minimalist journaling application designed for people who struggle to journal consistently.

Instead of asking users to write long pages every day, One Minute gives them exactly **60 seconds** to capture their thoughts.

When the timer ends, the entry is automatically saved, creating a simple daily habit:

**One day. One entry. One minute.**

---

## 📱 Screenshots

> Screenshots will be added as development progresses.

| Home           | Writing        | Journal        | Settings       |
| -------------- | -------------- | -------------- | -------------- |
| Add screenshot | Add screenshot | Add screenshot | Add screenshot |

---

## ✨ Features

### Current MVP

* 🚀 Simple onboarding experience
* ⏱️ 60-second daily writing session
* 📝 Automatic entry saving when the timer ends
* 🔒 One journal entry per day
* 📖 View previous journal entries
* 📅 Calendar view for browsing past entries
* 🔥 Daily streak tracking
* 📊 Total entry statistics
* 🔔 Daily journal reminders
* 🌙 Light and dark themes
* 💾 Local-first data storage
* 🔐 Journal entries remain private on the user's device

---

## 🧠 The Core Concept

Journaling can sometimes feel like a task.

People often think they need to write:

* Several paragraphs
* A detailed summary of their day
* Something meaningful
* Something perfectly written

One Minute removes that pressure.

The app gives the user one simple instruction:

> **Write for one minute.**

There is no expectation to write a perfect journal entry.

Just start.

---

# 📲 User Flow

## First-Time User

```text
Open App
    ↓
Splash Screen
    ↓
Onboarding
    ↓
Optional Reminder Setup
    ↓
Home Screen
```

---

## Daily Writing Flow

```text
Home Screen
    ↓
Start Your Minute
    ↓
Writing Screen
    ↓
60-Second Countdown Starts
    ↓
User Writes
    ↓
Timer Reaches 00:00
    ↓
Entry Automatically Saved
    ↓
Completion Screen
    ↓
Back to Home
```

---

## Journal Flow

```text
Home
    ↓
Journal
    ↓
View Entries
    ├── Entry History
    │       ↓
    │   Entry Details
    │
    └── Calendar
            ↓
        Select Date
            ↓
        Entry Details
```

---

# 📸 App Screens

## 1. Onboarding

Introduces the user to the core concept of One Minute.

Example flow:

### Screen 1

> Your thoughts don't need an hour.

### Screen 2

> Just give yourself one minute.

### Screen 3

> One entry. Every day. No pressure.

---

## 2. Home

The main dashboard of the application.

Displays:

* Current greeting
* Current date
* Today's journal status
* Start writing button
* Daily streak
* Total number of entries

Before completing an entry:

```text
Good morning 👋

Tuesday, August 26

TODAY'S MOMENT

You haven't captured
your moment today.

        01:00

[ Start Your Minute ]

🔥 7 Day Streak

📝 24 Total Entries
```

After completing an entry:

```text
Today's moment is complete ✓

"Today was more productive than
I expected..."

[ Read Today's Entry ]
```

---

## 3. Writing Screen

This is the core experience of the application.

When the user taps **Start Your Minute**, the countdown begins immediately.

```text
              00:47

Tuesday, August 26

What's on your mind?

Today was interesting because...
```

### Rules

* The timer starts at `01:00`.
* The user can write while the timer is running.
* When the timer reaches `00:00`, the entry is automatically saved.
* The completed entry becomes read-only.
* The user cannot create another entry on the same day.

---

## 4. Completion Screen

Displayed when the user's minute is complete.

```text
✓

That's your minute!

Your moment has been saved
for today.

01:00       67
Time Spent  Words

[ Read Today's Entry ]

[ Back to Home ]
```

---

## 5. Journal

Allows users to explore their previous thoughts.

Features:

* Chronological journal entries
* Entry previews
* Full entry view
* Calendar navigation

Example:

```text
YOUR JOURNAL

Today
Today was more productive than...

Yesterday
I spent most of today thinking...

August 24
One thing I need to improve is...
```

---

## 6. Calendar

Users can view the days on which they completed their one-minute journal entry.

```text
AUGUST 2026

 S  M  T  W  T  F  S

             1
 2  3  4  5  6  7  8
 9 10 ● 12 ● 14 15
16 ● 18 19 ● 21 22
23 ● 24 ● 26 27 28 29
```

Highlighted dates indicate completed journal entries.

---

## 7. Settings

The settings screen allows users to manage:

### General

* Daily reminder
* Reminder time
* App theme
* Text size

### Data

* Export journal entries
* Clear all data

### About

* About One Minute
* Rate the app

---

# 🏗️ Architecture

One Minute follows a **Feature-First architecture combined with MVVM**.

The application separates UI, business logic, and data management.

```text
UI
 ↓
ViewModel / Notifier
 ↓
Repository
 ↓
Database / Service
```

For example:

```text
Writing Screen
      ↓
Writing ViewModel
      ↓
Journal Repository
      ↓
Local Database
```

Riverpod manages application state and keeps the UI reactive.

---

# 📁 Project Structure

```text
lib/
│
├── main.dart
│
├── app/
│   ├── app.dart
│   │
│   ├── router/
│   │   └── app_router.dart
│   │
│   └── theme/
│       ├── app_theme.dart
│       ├── app_colors.dart
│       └── app_text_styles.dart
│
├── core/
│   ├── constants/
│   │   └── app_constants.dart
│   │
│   ├── services/
│   │   └── notification_service.dart
│   │
│   └── utils/
│       ├── date_utils.dart
│       └── streak_calculator.dart
│
└── features/
    │
    ├── onboarding/
    │   ├── presentation/
    │   │   ├── screens/
    │   │   └── widgets/
    │   │
    │   └── view_model/
    │
    ├── home/
    │   ├── presentation/
    │   │   ├── screens/
    │   │   └── widgets/
    │   │
    │   └── view_model/
    │
    ├── writing/
    │   ├── presentation/
    │   │   ├── screens/
    │   │   └── widgets/
    │   │
    │   └── view_model/
    │
    ├── journal/
    │   ├── data/
    │   │   ├── models/
    │   │   └── repositories/
    │   │
    │   ├── presentation/
    │   │   ├── screens/
    │   │   └── widgets/
    │   │
    │   └── view_model/
    │
    └── settings/
        ├── presentation/
        │   ├── screens/
        │   └── widgets/
        │
        └── view_model/
```

---

# 🛠️ Tech Stack

| Technology                  | Purpose                                |
| --------------------------- | -------------------------------------- |
| Flutter                     | Cross-platform application development |
| Dart                        | Programming language                   |
| Riverpod                    | State management                       |
| Isar                        | Local database                         |
| Flutter Local Notifications | Daily reminders                        |
| Intl                        | Date and time formatting               |
| Table Calendar              | Journal calendar                       |
| Google Fonts                | Typography                             |
| Flutter Animate             | UI animations                          |

---

# 📦 Packages

The project is expected to use packages similar to:

```yaml
dependencies:
  flutter:
    sdk: flutter

  flutter_riverpod:

  isar:
  isar_flutter_libs:
  path_provider:

  flutter_local_notifications:
  timezone:

  intl:
  table_calendar:

  google_fonts:
  flutter_animate:
```

Development dependencies:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter

  build_runner:
  isar_generator:
```

> Package versions should be selected based on the latest compatible versions when the project is set up.

---

# 🎨 Design System

One Minute uses a calm and reflective visual identity.

## Design Philosophy

The interface should feel:

* Minimal
* Warm
* Personal
* Calm
* Uncluttered

The user should focus on their thoughts rather than the interface.

---

## Color Palette

### Light Theme

| Color         | Hex       | Usage                          |
| ------------- | --------- | ------------------------------ |
| Deep Sage     | `#5E7A6B` | Primary actions                |
| Light Sage    | `#DDE8E1` | Containers and accents         |
| Warm Paper    | `#FAF9F6` | Main background                |
| White         | `#FFFFFF` | Surface                        |
| Soft Black    | `#1C1C1A` | Primary text                   |
| Warm Gray     | `#74746F` | Secondary text                 |
| Light Border  | `#E8E6E1` | Borders                        |
| Success Green | `#4F8A65` | Completed states               |
| Muted Red     | `#B85450` | Errors and destructive actions |

---

### Dark Theme

| Color         | Hex       | Usage          |
| ------------- | --------- | -------------- |
| Deep Ink      | `#181A19` | Background     |
| Soft Charcoal | `#232624` | Surface        |
| Soft Sage     | `#9BB8A7` | Primary        |
| Dark Sage     | `#314239` | Containers     |
| Warm White    | `#F4F2ED` | Primary text   |
| Soft Gray     | `#B8B7B2` | Secondary text |
| Dark Border   | `#343835` | Borders        |

---

# 🔤 Typography

The application uses **DM Sans**.

Recommended typography:

| Element        | Weight            |
| -------------- | ----------------- |
| Large headings | Bold              |
| Screen titles  | SemiBold          |
| Buttons        | Medium / SemiBold |
| Body text      | Regular           |
| Labels         | Medium            |
| Timer          | Medium            |

Example:

```dart
ThemeData(
  textTheme: GoogleFonts.dmSansTextTheme(),
)
```

---

# 🗄️ Data Model

## Journal Entry

A journal entry may contain:

```text
JournalEntry
│
├── id
├── content
├── createdAt
├── completedAt
├── wordCount
└── duration
```

Example:

```dart
class JournalEntry {
  final int id;
  final String content;
  final DateTime createdAt;
  final DateTime completedAt;
  final int wordCount;
  final int duration;
}
```

---

# 🔥 Streak Logic

A streak represents consecutive days with completed journal entries.

Example:

```text
Monday     ✓
Tuesday    ✓
Wednesday  ✓
Thursday   ✓

Current Streak: 4 days
```

If the user misses a day:

```text
Monday     ✓
Tuesday    ✓
Wednesday  ✗
Thursday   ✓

Current Streak: 1 day
```

The streak logic should compare normalized dates rather than exact timestamps.

---

# ⏱️ One Entry Per Day

One of the core rules of One Minute is:

> **A user can only complete one journal entry per calendar day.**

Before allowing a new writing session, the application checks whether an entry already exists for the current day.

```text
Does today's entry exist?

       │
   ┌───┴───┐
   │       │
  YES      NO
   │       │
   ↓       ↓
View       Start
Entry      Writing
```

Completed entries are read-only.

---

# 🔔 Notifications

Users can optionally enable a daily reminder.

Example notification:

> ✍️ Your minute is waiting. What's on your mind?

Users should be able to:

* Enable or disable reminders
* Select a preferred reminder time
* Update their reminder time

---

# 🚀 Getting Started

## Prerequisites

Make sure you have the following installed:

* Flutter SDK
* Dart SDK
* Android Studio or VS Code
* Android emulator or physical device

Check your Flutter installation:

```bash
flutter doctor
```

---

## Clone the Repository

```bash
git clone YOUR_REPOSITORY_URL
```

Navigate into the project:

```bash
cd one_minute
```

---

## Install Dependencies

```bash
flutter pub get
```

---

## Generate Database Files

If using Isar code generation:

```bash
dart run build_runner build
```

Or continuously watch for changes:

```bash
dart run build_runner watch
```

---

## Run the Application

```bash
flutter run
```

---

# 🧪 Testing

Run all tests:

```bash
flutter test
```

Important areas to test include:

* Timer behavior
* Automatic saving
* One-entry-per-day restriction
* Streak calculations
* Date changes
* Notification scheduling
* Theme switching
* Journal entry retrieval

---

# 🗺️ Roadmap

## Version 1 — MVP

* [x] Define product concept
* [x] Define application flow
* [x] Define initial design direction
* [x] Build onboarding
* [x] Build home screen
* [x] Build writing experience
* [x] Implement 60-second timer
* [x] Implement automatic saving
* [ ] Implement local database
* [ ] Implement journal history
* [ ] Implement calendar
* [ ] Implement streak calculation
* [ ] Implement notifications
* [ ] Implement settings
* [ ] Add dark mode
* [ ] Test the application
* [ ] Prepare screenshots
* [ ] Write project documentation

---

## Version 2

Potential future improvements:

* [ ] Cloud backup
* [ ] User authentication
* [ ] Multi-device synchronization
* [ ] Export journal entries as PDF
* [ ] Search journal entries
* [ ] Writing prompts
* [ ] Mood tracking
* [ ] Journal statistics
* [ ] App lock with biometrics
* [ ] Custom themes
* [ ] Home screen widgets

---

# 🤝 Contributing

Contributions, issues, and feature suggestions are welcome.

If you would like to contribute:

1. Fork the repository.
2. Create a new branch.
3. Make your changes.
4. Test your changes.
5. Submit a pull request.

---

# 📄 License

This project is currently intended as a personal portfolio project.

A license can be added later depending on whether the project becomes open source or a commercial application.

---

# 👨‍💻 Author

**David Shittu**

Mobile Developer focused on building useful, thoughtful, and user-centered applications.

---

## 🌱 Final Thought

One Minute is built around a simple idea:

> You don't need to write a lot to remember a moment.

**One minute is enough to begin.**

---

⭐ If you find this project interesting, consider starring the repository.
