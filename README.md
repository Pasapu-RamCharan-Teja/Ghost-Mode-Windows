# Ghost Mode

**Hide any window instantly with a custom keyboard shortcut.**

Click a window, press your chosen hotkey (like **Ctrl + Shift + G**) — it's covered with a solid black overlay. Press again to reveal it. Nobody nearby sees a thing.

> Made by [Eagle RC](https://discord.gg/4qF5KMUeQx) · Free & open source

---

## Features

- **Customizable shortcut** — Choose your preferred hotkey (e.g., `Win+Shift+P`, `Ctrl+Shift+G`, `F9`, etc.) during setup to toggle the overlay on any window
- **Drag through the overlay** — click and drag the black layer to move the window underneath
- **Follows the window** — overlay repositions automatically when you move or resize
- **Auto-hides on minimise** — reappears when you restore the window
- **Zero config** — the setup handles everything, including AutoHotkey installation

---

## Install

1. Download the setup file from [our GitHub Release](https://github.com/Pasapu-RamCharan-Teja/Ghost-Mode-Windows.git) or [Discord](https://discord.gg/4qF5KMUeQx) and run it
2. Select your preferred hotkey from the dropdown menu
3. Click **Start Setup** — it checks for AutoHotkey, installs it silently if needed, and writes the script
4. When asked _"Add Ghost Mode to Windows startup?"_ — hit **Yes** to have it always ready at login

> **SmartScreen warning?** Click **More info → Run anyway**. Normal for unsigned indie tools.

> **No AutoHotkey?** The setup downloads and installs it silently — nothing for you to do.

---

## How to Use

| Step | Action                                          |
| ---- | ----------------------------------------------- |
| 1    | Click the window you want to hide               |
| 2    | Press your chosen hotkey — black overlay appears |
| 3    | Press the hotkey again — overlay removed        |

You can also **drag the overlay** to move the window without revealing it. For a more detailed walkthrough, [Read the Guide](https://tinyurl.com/Ghost-Mode-By-EagleRC).

---

## Requirements

- Windows 10 or 11
- [AutoHotkey v1.1](https://www.autohotkey.com) (installed automatically by the setup)

---

## Uninstall

1. Right-click the green AutoHotkey tray icon in your taskbar → **Exit**
2. Delete the `Ghost Mode\` folder next to where you ran Setup
3. If you enabled startup: `Win + R` → `shell:startup` → delete `Ghost Mode.ahk`

---

## Troubleshooting

| Problem                       | Fix                                                                                   |
| ----------------------------- | ------------------------------------------------------------------------------------- |
| AutoHotkey download fails     | Install manually from [autohotkey.com](https://www.autohotkey.com), then re-run setup |
| Can't write to startup folder | `Win + R` → `shell:startup` → copy `Ghost Mode.ahk` there manually                    |
| Shortcut not working          | Make sure you clicked the target window first to focus it                             |
| Antivirus flags the file      | AHK scripts are sometimes falsely flagged — the source is open, inspect it yourself   |

---

## How It Works

Ghost Mode is a self-contained **AutoHotkey v1.1** script. No installer framework, no bloat.

- The setup script dynamically writes `Ghost Mode\Ghost Mode.ahk` next to itself with your chosen hotkey baked in
- The overlay is a borderless, always-on-top black GUI window parented to the target
- A highly responsive 30 ms timer keeps it aligned and handles minimize/restore/close lifecycle
- Dragging the overlay sends `WM_NCLBUTTONDOWN` to the target window, so the real window moves seamlessly

---

## License

MIT — do whatever you want with it.

---

_Join our [Discord](https://discord.gg/4qF5KMUeQx) or check out the [Source Code on GitHub](https://github.com/Pasapu-RamCharan-Teja/Ghost-Mode-Windows.git) for more updates._