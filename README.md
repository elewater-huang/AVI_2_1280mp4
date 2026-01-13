# AVI_2_1280mp4

Batch convert `.avi` files in one (or more) folders to `.mp4` using **ffmpeg**.

- Output size: **1280×720** (exact)
- Keeps aspect ratio (no stretching)
- Pads borders when needed
- Output folder: `converted_mp4/` under each input folder

---

## Requirements

- macOS (zsh)
- ffmpeg

Install ffmpeg (Homebrew):

```bash
brew install ffmpeg
```

---

## Usage

Go to this repo folder first:

```bash
cd ~/Projects/AVI_2_1280mp4
```

Convert one folder:

```bash
./src/avi2mp4.zsh "/path/to/folder"
```

Convert multiple folders:

```bash
./src/avi2mp4.zsh "/path/A" "/path/B"
```

Tip: you can type `./src/avi2mp4.zsh ` (with a trailing space), then **drag a folder from Finder into Terminal**, and press Enter.

---

## Output

For each input folder, results go to:

```bash
<folder>/converted_mp4/*.mp4
```

Example:

- Input: `/Volumes/Shared/Pics/20260110-0111外展行動日_龍潭/1_temp`
- Output: `/Volumes/Shared/Pics/20260110-0111外展行動日_龍潭/1_temp/converted_mp4/*.mp4`

---

## Options (edit in script)

Open `src/avi2mp4.zsh` and edit:

- `WIDTH=1280`
- `HEIGHT=720`
- `CRF=20` (lower = better quality, bigger file)
- `PRESET=medium` (`faster` / `medium` / `slow`)

---

## How scaling works (short)

The script uses:

- `scale=WIDTH:HEIGHT:force_original_aspect_ratio=decrease`
- `pad=WIDTH:HEIGHT:(ow-iw)/2:(oh-ih)/2`

So the output is always **WIDTH×HEIGHT** without stretching.

---

## Automator (optional)

You can wrap the script with an Automator app for drag-and-drop convenience.
This repo keeps the **script + docs** only (the generated `.app` bundle is usually machine-specific and not tracked).
