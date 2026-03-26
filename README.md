# Privacy Mode

**Hide any window instantly with a keyboard shortcut.**

Click a window, press **Win + Shift + P** — it's covered with a solid black overlay. Press again to reveal it. Nobody nearby sees a thing.

> Made by [Arshit Vaghasiya](https://geek-updates.com) · Free & open source

---

## Features

- **One shortcut** — `Win + Shift + P` toggles the overlay on any window
- **Drag through the overlay** — click and drag the black layer to move the window underneath
- **Follows the window** — overlay repositions automatically when you move or resize
- **Auto-hides on minimise** — reappears when you restore the window
- **Zero config** — the setup handles everything, including AutoHotkey installation

---

## Install

1. Download `Setup.exe` from [geek-updates.com](https://geek-updates.com) and run it
2. Click **Start Setup** — it checks for AutoHotkey, installs it silently if needed, and writes the script
3. When asked _"Add to Windows startup?"_ — hit **Yes** to have Privacy Mode always ready at login

> **SmartScreen warning?** Click **More info → Run anyway**. Normal for unsigned indie tools.

> **No AutoHotkey?** The setup downloads and installs it silently — nothing for you to do.

---

## How to Use

| Step | Action                                          |
| ---- | ----------------------------------------------- |
| 1    | Click the window you want to hide               |
| 2    | Press `Win + Shift + P` — black overlay appears |
| 3    | Press `Win + Shift + P` again — overlay removed |

You can also **drag the overlay** to move the window without revealing it.

---

## Requirements

- Windows 10 or 11
- [AutoHotkey v1.1](https://www.autohotkey.com) (installed automatically by the setup)

---

## Uninstall

1. Right-click the tray icon → **Exit**
2. Delete the `Privacy Mode\` folder next to where you ran Setup
3. If you enabled startup: `Win + R` → `shell:startup` → delete `PrivacyOverlay.ahk`

---

## Troubleshooting

| Problem                       | Fix                                                                                   |
| ----------------------------- | ------------------------------------------------------------------------------------- |
| AutoHotkey download fails     | Install manually from [autohotkey.com](https://www.autohotkey.com), then re-run setup |
| Can't write to startup folder | `Win + R` → `shell:startup` → copy `PrivacyOverlay.ahk` there manually                |
| Shortcut not working          | Make sure you clicked the target window first to focus it                             |
| Antivirus flags the file      | AHK scripts are sometimes falsely flagged — the source is open, inspect it yourself   |

---

## How It Works

Privacy Mode is a single **AutoHotkey v1.1** script (`Setup.ahk`). No installer framework, no bloat.

- The setup writes `Privacy Mode\PrivacyOverlay.ahk` next to itself
- The overlay is a borderless, always-on-top black GUI window parented to the target
- A 100 ms timer keeps it aligned and handles minimize/restore/close lifecycle
- Dragging the overlay sends `WM_NCLBUTTONDOWN` to the target window, so the real window moves

---

## License

MIT — do whatever you want with it.

---

_Follow [@geek_updates](https://www.instagram.com/geek_updates/) for more tools like this._
