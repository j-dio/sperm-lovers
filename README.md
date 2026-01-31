# 🎮 Sperm Sanity

> _"A morality tale wrapped in biological absurdity"_

A dark comedy isometric shooter/puzzle game where you play as a self-aware sperm navigating the reproductive system. Every choice matters—kill your siblings or solve puzzles to progress. Both paths are morally compromised. Made for **"The Path Less Taken"** game jam.

![Godot](https://img.shields.io/badge/Godot-4.5-blue) ![Status](https://img.shields.io/badge/Status-In%20Development-yellow)

---

## 📖 Story

You are **Spermy**, one of millions racing toward the egg. But unlike your mindless siblings, you're _aware_. Armed with a shotgun and existential dread, you must navigate through the hostile reproductive system.

Along the way, you'll encounter **Doorethy**—a sassy, flesh-covered door who serves as both guide and moral compass. She watches your choices, judges your actions, and ultimately determines your fate.

**The question isn't whether you'll reach the egg. It's what kind of monster you'll become to get there.**

---

## 🎯 Core Gameplay

### Two Paths, No Easy Answers

| **Violence Path**                        | **Puzzle Path**                         |
| ---------------------------------------- | --------------------------------------- |
| Blast through siblings with your shotgun | Solve environmental puzzles to progress |
| Fast but morally devastating             | Slower but preserves your humanity      |
| Decreases Karma                          | Maintains/Increases Karma               |
| Leads to Bad Ending                      | Leads to Good Ending                    |

### Karma System

Your choices are tracked through a **Karma meter**:

- **Killing siblings** = Karma decreases
- **Solving puzzles peacefully** = Karma maintained/increased
- **Final karma score** determines which ending you get

---

## 🚪 Meet Doorethy

Doorethy is a sentient door made of flesh—equal parts helpful and judgmental. She:

- Provides cryptic hints and sarcastic commentary
- Blocks your path until conditions are met
- Reacts differently based on your karma
- Delivers the game's most memorable dialogue

> _"Oh, another one of you wiggly little monsters. Tell me, how many of your brothers did you murder to get here?"_

---

## 🏁 Multiple Endings

### 🟢 Good Ending

Maintain high karma by solving puzzles peacefully. The egg welcomes you as worthy—not through violence, but virtue.

### 🔴 Bad Ending

Low karma from killing siblings. Doorethy reveals the truth: _you_ were the monster all along. She crushes you.

### ⭐ Secret Ending

Discover the hidden path. Question why you're racing at all. Perhaps the real victory is choosing not to compete.

---

## 🎮 Controls

| Action           | Key                              |
| ---------------- | -------------------------------- |
| Move             | WASD                             |
| Aim              | Hold Right Mouse Button          |
| Shoot            | Left Mouse Button (while aiming) |
| Interact         | Left Mouse Button                |
| Advance Dialogue | Left Mouse Button                |

---

## 🗺️ Level Progression

1. **Level 0** - Tutorial: Learn basic movement and mechanics
2. **Level 1** - Introduction to combat and puzzle mechanics
3. **Level 2** - Valve puzzles and environmental hazards
4. **Level 3** - Increased complexity, more moral choices
5. **Level 4** - Final gauntlet before the egg
6. **Level 5** - The Egg Chamber (Good or Bad ending based on karma)
7. **Secret Zone** - Hidden area with the secret ending

---

## 🎨 Visual Style

- **PSX-era aesthetics** with low-poly models and pixelated textures
- **Isometric camera** perspective
- **Dark, fleshy environments** representing the reproductive system
- **Red fog and volumetric lighting** for atmosphere
- Custom **PSX shader** for authentic retro feel

---

## 🔊 Audio

- Retro-styled sound effects
- Dynamic background music that shifts during combat
- Satisfying shotgun blast and reload sounds
- Squelchy impact sounds for that biological authenticity

---

## 🛠️ Technical Details

- **Engine:** Godot 4.5
- **Language:** GDScript
- **Resolution:** 640x380 (upscaled)
- **3D with Isometric View**

### Key Systems

- **Dialogue System** - JSON-based branching dialogue with typewriter effect
- **Karma Tracking** - Global karma value affecting story outcomes
- **Enemy AI** - Activation radius system for performance
- **Death/Retry System** - Themed death screen with instant retry
- **Multiple Ending Videos** - .ogv video playback with typewriter epilogue

---

## 👥 Credits

Developed for **"The Path Less Taken"** Game Jam

### 🔌 Addon

- **[TileMapLayer3D](https://github.com/DanTrz/TileMapLayer3D)** by DanTrz — Licensed under [MIT License](https://opensource.org/licenses/MIT)

### 🎨 3D Models / Assets

| Asset                                                                                                           | Author           | License                                                        |
| --------------------------------------------------------------------------------------------------------------- | ---------------- | -------------------------------------------------------------- |
| [LOWPOLY - REMINGTON SHOTGUN - PS1 / PSX STYLE](https://skfb.ly/oNCnC)                                          | Colin Greenall   | [CC BY 4.0](http://creativecommons.org/licenses/by/4.0/)       |
| [PSX Air Conditioners Pack](https://skfb.ly/pCtPN)                                                              | DeadFrame Studio | [CC BY 4.0](http://creativecommons.org/licenses/by/4.0/)       |
| [PSX Low-poly Car - Renault](https://skfb.ly/ptXrN)                                                             | korkskrew2000    | [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/) |
| [PSX Style Barricade Pack](https://skfb.ly/p8SU6)                                                               | wooolvie         | [CC BY 4.0](http://creativecommons.org/licenses/by/4.0/)       |
| [Blind Van PSX Style](https://skfb.ly/pxVo9)                                                                    | Han66st          | [CC BY 4.0](http://creativecommons.org/licenses/by/4.0/)       |
| [Realistic Human Heart](https://sketchfab.com/3d-models/realistic-human-heart-3f8072336ce94d18b3d0d055a1ece089) | Sketchfab        | As per asset license                                           |

### 🛒 Fab Assets

- [Fab Asset](https://www.fab.com/listings/5fb90354-4591-4fb8-a893-72eba7ee0d37) — Used under Fab license
- [Fab Asset](https://www.fab.com/listings/96cccff5-f73c-4ffa-bba7-a11f24e6cf4c) — Used under Fab license
- [Fab Asset](https://www.fab.com/listings/64de4fea-7e65-4e44-b763-843d4a130f15) — Used under Fab license

### 🖼️ Textures / Images

| Asset                                                                                                                                                    | Author           | License         |
| -------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------- | --------------- |
| [Minced Meat with Spices](https://www.freepik.com/free-photo/minced-meat-with-spices-paper-table-closeup-macro_15101074.htm)                             | valeria_aksakova | Freepik License |
| [Fresh Beef Meat Steak (Macro Shot)](https://www.freepik.com/free-photo/macro-shot-fresh-beef-meat-steak_37782118.htm)                                   | valeria_aksakova | Freepik License |
| [Detailed Structure Marble Natural Pattern](https://www.freepik.com/free-photo/detailed-structure-marble-natural-pattern-background-design_19133519.htm) | benzoix          | Freepik License |

### 👁️ Other Assets

- [Creepy Eyes PNG (Transparent)](https://www.deviantart.com/unsermanemamamamaam/art/Creepy-Eyes-PNG-transparent-1103579018) by unsermanemamamamaam
- [Throwaway Faces for Hard Time 3D](https://www.reddit.com/r/mdickie/comments/1c1lvjp/throwaways_faces_i_made_for_hardtime_3d_yall_can/) — Shared by Reddit author

### 🔊 Audio Assets

All audio from [Pixabay](https://pixabay.com/) under their license:

- [People Crowd Cheer](https://pixabay.com/sound-effects/people-crowd-cheer-406646/)
- [Film Special Effects Buzzer](https://pixabay.com/sound-effects/film-special-effects-buzzer-227217/)
- [Film Special Effects Notification](https://pixabay.com/sound-effects/film-special-effects-notification-05-140376/)
- [People Crowd Laughing](https://pixabay.com/sound-effects/people-crowd-laughing-sound-effect-no-copyright-390899/)
- [Film Special Effects Right Answer](https://pixabay.com/sound-effects/film-special-effects-rightanswer-95219/)

---

## 📁 Project Structure

```
├── art/              # Shaders, textures, dialogue JSON
├── assets/           # Audio, models, textures
├── autoload/         # Global managers (GameManager)
├── endings/          # Ending video files (.ogv)
├── scenes/           # All game scenes
│   ├── levels/       # Level scenes (0-5, menu)
│   ├── player/       # Player scene
│   ├── enemies/      # Enemy scenes
│   ├── puzzles/      # Puzzle scenes
│   └── ui/           # UI scenes (death screen, endings)
├── scripts/          # All GDScript files
└── sounds/           # Audio files
```

---

## 🎮 How to Play

1. Clone the repository
2. Open in Godot 4.5+
3. Run the project
4. Navigate the moral maze of reproductive biology
5. Question your life choices

## Or download the latest build that I'll attach here soon since the game uploaded in the jam has bugs that didn't appear in testing.

_Remember: In the race of life, sometimes the real winner is the one who asks "why am I running?"_
