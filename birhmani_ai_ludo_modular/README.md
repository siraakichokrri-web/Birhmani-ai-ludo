# Birhmani AI Ludo - Production Build (Single file)

This package contains a production-style single-file Flutter app `lib/main.dart` that implements:
- Full Ludo rules and gameplay skeleton
- Minimax-based AI with iterative deepening and time limits
- Neon black UI, dice animation, token sliding placeholders
- AI chat with optional Google Gemini integration (via .env)
- Confetti winner screen and leaderboard using shared_preferences
- Assets placeholders and sample sounds

## Setup
1. Copy `.env.example` to `.env` and set `GEMINI_API_KEY` and `USE_GEMINI=true` if using Gemini.
2. Run `flutter create .` in the project root to generate native projects if needed.
3. `flutter pub get`
4. `flutter run`

## Notes
- This single-file is for convenience; modular code is recommended for maintenance.
- For Gemini integration, ensure your key has required permissions and use the correct API endpoint.

## Modular update
- Project split into modular files under `lib/`
- Added VoiceService (speech_to_text + flutter_tts hooks)
- Rive animated particle background placeholder
- Skins Store with unlockable skins using SharedPreferences
- Settings screen and persistence for skins/boards/difficulty

Run `flutter pub get` and `flutter create .` if needed, then `flutter run`.
