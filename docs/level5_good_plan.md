# Level5GOOD Implementation Plan

## "The Exam of Enlightenment"

### Overview

Level5GOOD is the pacifist ending path where the player proves their worth through intelligence rather than violence. The player must solve 5 definite integral problems at exam tables to gain passage to the Egg.

---

## Core Mechanics

### 1. Interactable Exam Tables

- **5 tables** placed in the arena (already in scene)
- Each table is interactable via **left click** when player is near
- Tables have a collision area for interaction detection
- Visual highlight when player is in range (subtle glow or outline)

### 2. Blue Book System (UP Exam Notebook Mockup)

When a table is interacted:

1. **Blue Book Appears** - A 2D UI overlay showing the closed blue book
   - Simple blue rectangle with "EXAM BOOKLET" text
   - Minimalist design (no actual UP branding for copyright)
2. **Flip Animation** - Player presses left click or spacebar
   - Book "flips open" (simple transition/animation)
3. **Question Display** - Shows the definite integral problem
   - Clean mathematical notation
   - Input field for numerical answer
   - Submit button

### 3. Answer Validation

- **Correct Answer:**
  - Success sound effect
  - Table marked as "DONE" (checkmark symbol appears above)
  - Blue book closes with success feedback
  - Player can move to next table
- **Incorrect Answer:**
  - Error sound effect
  - Player takes damage (small amount, non-lethal)
  - Blue book closes abruptly
  - Player must re-interact to try again
  - Can move to other tables for different problems

### 4. Progress Tracking

Each table displays a floating symbol above it:

- **Not Done (⭕)** - Empty circle/donut shape (default state)
- **Done (✓)** - Green checkmark (after correct answer)

### 5. Door Unlock Condition

- Track completion count (0-5)
- When all 5 tables are correctly answered:
  - Victory dialogue triggers
  - Door ("Doorethy" / AbstractDoor) opens
  - Player proceeds to good ending

---

## The 5 Definite Integral Problems

| Table | Problem            | Accepted Answers     |
| ----- | ------------------ | -------------------- |
| 1     | ∫₋₇⁷ x dx          | 0                    |
| 2     | ∫₀⁵ (x² - 2x) dx   | "50/3", 16.67, 16.66 |
| 3     | ∫₋₂² (6x³ - 4x) dx | 0                    |
| 4     | ∫₁³ (1/x²) dx      | "2/3", 0.67, 0.66    |
| 5     | ∫₋₄⁻¹ (1/x²) dx    | "3/4", 0.75          |

_Note: Accept both fraction form (e.g., "2/3", "50/3") and decimal form (±0.01 tolerance). Parse fractions by splitting on "/" and dividing. Problems 1 and 3 are 0 due to odd function symmetry._

---

## Dialogue Script

### Entry Dialogue (when player enters arena)

```
Speaker: The Egg (warm, welcoming tone)

"You've chosen the path of wisdom over wrath."

"Before you can join with me, you must prove your mind is worthy."

"Five trials of knowledge await you at these sacred tables."

"Solve each integral correctly, and the way shall open."

"But beware... wrong answers carry a price."
```

### Per-Table Interaction (first time)

```
"Approach the table and begin your trial."
```

### Correct Answer

```
"Well done. Your mind grows sharper."
```

### Incorrect Answer

```
"Incorrect. The knowledge wounds you. Try again, or seek another path."
```

### All Tables Complete

```
"You have proven yourself worthy."

"Through patience and wisdom, you have earned your place."

"The door opens. Your destiny awaits."
```

---

## Technical Implementation

### New Scripts Required

#### 1. `exam_table.gd`

```
Extends: Area3D or StaticBody3D

Properties:
- problem_text: String
- correct_answer: float
- tolerance: float = 0.01
- is_completed: bool = false

Signals:
- table_completed

Functions:
- _on_interact() - Shows blue book UI
- check_answer(player_answer: float) -> bool
- mark_complete()
```

#### 2. `blue_book_ui.gd`

```
Extends: CanvasLayer or Control

Properties:
- current_table: ExamTable
- is_open: bool = false

States:
- HIDDEN
- SHOWING_COVER
- SHOWING_QUESTION

Functions:
- show_book(table: ExamTable)
- flip_open()
- submit_answer()
- close_book()
```

#### 3. `level5_good_controller.gd`

```
Extends: Node3D

Properties:
- tables: Array[ExamTable]
- completed_count: int = 0
- door: AbstractDoor
- dialog_system: DialogSystem

Functions:
- _ready() - Setup, show entry dialogue
- _on_table_completed(table)
- check_all_complete()
- trigger_victory()
```

### New UI Elements

#### Blue Book UI (`blue_book_ui.tscn`)

```
CanvasLayer
├── ColorRect (dark overlay)
├── Panel "BookCover" (blue background)
│   ├── Label "Title" ("EXAM BOOKLET")
│   └── Label "Hint" ("Click to open")
├── Panel "BookInside" (white background, initially hidden)
│   ├── Label "QuestionLabel" (displays integral)
│   ├── LineEdit "AnswerInput"
│   ├── Button "SubmitButton"
│   └── Label "FeedbackLabel"
```

#### Progress Symbol (`progress_symbol.tscn`)

```
Node3D
├── Sprite3D "Symbol"
│   - Texture: circle (not done) or checkmark (done)
│   - Billboard mode enabled
```

### Scene Modifications to Level5GOOD.tscn

1. **Remove/Disable** boss-related nodes (boss spawner, boss health bar)
2. **Add** ExamTable script to each table StaticBody3D
3. **Add** ProgressSymbol as child of each table
4. **Add** BlueBookUI as CanvasLayer
5. **Add** Level5GoodController as root script
6. **Update** DialogSystem with new dialogue content
7. **Connect** door to controller for unlock logic

---

## File Structure

```
scripts/
├── exam_table.gd
├── blue_book_ui.gd
├── level5_good_controller.gd
└── progress_symbol.gd

scenes/
├── ui/
│   └── blue_book_ui.tscn
├── puzzles/
│   └── progress_symbol.tscn
└── levels/
    └── Level5GOOD.tscn (modified)

art/
└── dialogSystem/
    └── dialog_content.json (add Level5GOOD dialogues)
```

---

## Implementation Order

1. ✅ Create this plan document
2. Create `exam_table.gd` script
3. Create `progress_symbol.gd` and scene
4. Create `blue_book_ui.gd` and scene
5. Create `level5_good_controller.gd`
6. Add Level5GOOD dialogues to `dialog_content.json`
7. Modify `Level5GOOD.tscn`:
   - Attach scripts to tables
   - Add progress symbols
   - Add UI layer
   - Connect everything
8. Test and iterate

---

## Notes

- Keep damage from wrong answers low (10-15 HP) so it's punishing but not deadly
- Add subtle animations to make the blue book feel interactive
- Consider adding a "skip" or "hint" system if playtesters find it too hard
- The integral problems are intentionally basic (Calc 1 level) for accessibility
