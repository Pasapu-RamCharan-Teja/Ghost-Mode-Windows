#SingleInstance Force
#NoEnv
SetBatchLines, -1

; ============================================================
;  Ghost Mode - Setup
;  Created by Eagle RC | https://discord.gg/4qF5KMUeQx
;  Requires: AutoHotkey v1.1 (NOT compatible with AHK v2)
; ============================================================

global SCRIPT_DIR  := A_ScriptDir . "\Ghost Mode"
global SCRIPT_DEST := A_ScriptDir . "\Ghost Mode\Ghost Mode.ahk"
global AHK_URL     := "https://www.autohotkey.com/download/ahk-install.exe"
global AHK_TMP     := A_Temp . "\ahk_setup.exe"
global AHK_EXE     := ""

BuildGUI()
OnMessage(0x20, "OnSetCursor")  ; WM_SETCURSOR
return

; ── Close ────────────────────────────────────────────────────
MainGuiClose:
ExitApp

; ============================================================
;  GUI
; ============================================================
BuildGUI() {
    global Step1, Step2, Step3, Step4, LogBox, BtnAction, SelectedHotkey
    Gui, Main:New, -MaximizeBox -Resize, Ghost Mode - Setup
    Gui, Main:Color, E5E9FF

    ; ── Title ─────────────────────────────────────────────
    Gui, Main:Font, s26 bold c0400AB, Bookman Old Style
    Gui, Main:Add, Text, x0 y16 w520 Center, Ghost Mode

    Gui, Main:Font, s10 c888888, Bookman Old Style
    Gui, Main:Add, Text, x0 y58 w520 Center, By

    Gui, Main:Font, s12 cCF0000, Bookman Old Style
    Gui, Main:Add, Text, x0 y75 w520 Center, Eagle RC
    
    Gui, Main:Font, s11 c4A7FC1, Segoe UI
    Gui, Main:Add, Text, x148 y111 w100 Right gOpenWebsite +HwndLinkHwnd, Our Discord
    global g_LinkHwnd := LinkHwnd

    Gui, Main:Font, s11 c888888, Segoe UI
    Gui, Main:Add, Text, x251 y111 w14 Center, |
    Gui, Main:Font, s11 c4A7FC1, Segoe UI
    Gui, Main:Add, Text, x268 y111 w100 gOpenGuide +HwndGuideLinkHwnd, Read Guide
    global g_GuideLinkHwnd := GuideLinkHwnd

    ; ── What this does ────────────────────────────────────
    Gui, Main:Font, s13 bold c262561, Bookman Old Style
    Gui, Main:Add, Text, x0 y156 w520 Center, What this Setup Does:

    Gui, Main:Font, s11 c1A1A1A, Bookman Old Style
    Gui, Main:Add, Text, x80 y192 w20, 1.
    Gui, Main:Add, Text, x105 y192 w350, Check if AutoHotkey is installed on your PC
    Gui, Main:Add, Text, x80 y210 w20, 2.
    Gui, Main:Add, Text, x105 y210 w350, Download and install it silently if not found
    Gui, Main:Add, Text, x80 y228 w20, 3.
    Gui, Main:Add, Text, x105 y228 w350, Create the Ghost Mode script in the same folder
    Gui, Main:Add, Text, x80 y246 w20, 4.
    Gui, Main:Add, Text, x105 y246 w350, Optionally launch it on every Windows startup

    Gui, Main:Add, Text, x20 y268 w480 h1 +0x10  ; ← divider after point 4

    ; ── Steps ─────────────────────────────────────────────
    Gui, Main:Font, s13 bold c262561, Bookman Old Style
    Gui, Main:Add, Text, x0 y276 w520 Center, Steps:

    Gui, Main:Add, Text, x0 y298 w520 Center,

    Gui, Main:Font, s11 c1A1A1A, Bookman Old Style
    Gui, Main:Add, Text, x30 y318 w310, % Chr(0x2022) . "  Check AutoHotkey installation"
    Gui, Main:Font, s11 cAAAAAA, Consolas
    Gui, Main:Add, Text, vStep1 x340 y318 w160 Right, -

    Gui, Main:Font, s11 c1A1A1A, Bookman Old Style
    Gui, Main:Add, Text, x30 y342 w310, % Chr(0x2022) . "  Install AutoHotkey"
    Gui, Main:Font, s11 cAAAAAA, Consolas
    Gui, Main:Add, Text, vStep2 x340 y342 w160 Right, -

    Gui, Main:Font, s11 c1A1A1A, Bookman Old Style
    Gui, Main:Add, Text, x30 y366 w310, % Chr(0x2022) . "  Create Ghost Mode script"
    Gui, Main:Font, s11 cAAAAAA, Consolas
    Gui, Main:Add, Text, vStep3 x340 y366 w160 Right, -

    Gui, Main:Font, s11 c1A1A1A, Bookman Old Style
    Gui, Main:Add, Text, x30 y390 w310, % Chr(0x2022) . "  Add to Windows startup"
    Gui, Main:Font, s11 cAAAAAA, Consolas
    Gui, Main:Add, Text, vStep4 x340 y390 w160 Right, -
    ; ── Hotkey selector ───────────────────────────────────
    Gui, Main:Font, s11 c1A1A1A, Bookman Old Style
    Gui, Main:Add, Text, x20 y422 w160, Select Hotkey:
    Gui, Main:Add, DropDownList, vSelectedHotkey x190 y420 w310, Win+Shift+P||Ctrl+Shift+G|Ctrl+Alt+G|Ctrl+Shift+H|Alt+F9|F9|F2

    ; ── Overview panel ────────────────────────────────────
    Gui, Main:Font, s11 bold cFF0000, Bookman Old Style
    Gui, Main:Add, GroupBox, x20 y455 w480 h140, Overview

    Gui, Main:Font, s10 c1A1A1A, Consolas
    Gui, Main:Add, Edit, vLogBox x28 y473 w464 h114 ReadOnly -TabStop -E0x200 BackgroundE5E9FF +HwndLogHwnd
    global g_LogHwnd := LogHwnd

    ; ── Action button ─────────────────────────────────────
    Gui, Main:Font, s12 bold c1A1A1A, Bookman Old Style
    Gui, Main:Add, Button, vBtnAction gOnStart x20 y607 w480 h36 +Background1A1A1A +HwndBtnActionHwnd, Start Setup

    ; ── Footer ────────────────────────────────────────────
    Gui, Main:Font, s10 c4A7FC1, Segoe UI
    Gui, Main:Add, Text, x0 y651 w520 Center gOpenGitHub +HwndGitHubLinkHwnd, Source Code on GitHub
    global g_GitHubLinkHwnd := GitHubLinkHwnd

    OnMessage(0x200, "OnMouseMove")   ; WM_MOUSEMOVE
    Gui, Main:Show, w520 h686, Ghost Mode - Setup
}

; ── Clickable links ───────────────────────────────────────────
OpenWebsite:
    Run, https://discord.gg/4qF5KMUeQx
return

OpenGuide:
    Run, https://tinyurl.com/Ghost-Mode-By-EagleRC
return

OpenGitHub:
    Run, https://github.com/Pasapu-RamCharan-Teja/Ghost-Mode-Windows.git
return

; ── Hand cursor on link hover ─────────────────────────────────
OnSetCursor(wParam, lParam) {
    global g_LinkHwnd, g_GuideLinkHwnd, g_GitHubLinkHwnd
    if (wParam = g_LinkHwnd || wParam = g_GuideLinkHwnd || wParam = g_GitHubLinkHwnd) {
        DllCall("SetCursor", "Ptr", DllCall("LoadCursor", "Ptr", 0, "Ptr", 32649, "Ptr"))
        return 1
    }
}

; ============================================================
;  Button: Start Setup
; ============================================================
OnStart:
    Gui, Main:Submit, NoHide   ;
    GuiControl, Disable, BtnAction
    GuiControl, , BtnAction, Working...
    RunSetup()
return


; ============================================================
;  Setup flow
; ============================================================
RunSetup() {
    global AHK_EXE, AHK_URL, AHK_TMP, SCRIPT_DEST
    launchFrom := SCRIPT_DEST

    ; ── Step 1: Check AutoHotkey ─────────────────────────
    SetStep(1, "checking...")
    Log("> Checking for AutoHotkey...")

    foundExe := FindAHK()
    if (foundExe != "") {
        AHK_EXE := foundExe
        Log("  Found: " . foundExe)
        SetStep(1, "OK")
        SetStep(2, "not needed")
        Log("> Install step skipped - already installed.")
    } else {
        Log("  Not found on this PC.")
        SetStep(1, "OK")

        ; ── Step 2: Install AutoHotkey ───────────────────
        SetStep(2, "installing...")
        Log("> Downloading AutoHotkey installer...")
        psCmd := "powershell.exe -NoProfile -Command ""[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object Net.WebClient).DownloadFile('" . AHK_URL . "', '" . AHK_TMP . "')"""
        RunWait, % psCmd,, Hide
        if !FileExist(AHK_TMP) {
            ; Retry once
            Sleep, 1500
            RunWait, % psCmd,, Hide
        }
        if !FileExist(AHK_TMP) {
            Log("  [ERROR] Could not download the installer.")
            Log("")
            Log("  Fallback - install manually:")
            Log("    https://www.autohotkey.com")
            Log("  Then re-run this setup.")
            SetStep(2, "FAILED")
            SetupFailed()
            return
        }
        Log("  Running installer silently...")
        RunWait, % AHK_TMP . " /S",, Hide
        FileDelete, % AHK_TMP
        newExe := FindAHK()
        if (newExe != "") {
            AHK_EXE := newExe
            Log("  AutoHotkey installed successfully.")
            SetStep(2, "OK")
        } else {
            Log("  [ERROR] Installation finished but AHK was not found.")
            Log("")
            Log("  Fallback - install manually:")
            Log("    https://www.autohotkey.com")
            SetStep(2, "FAILED")
            SetupFailed()
            return
        }
    }

    ; ── Step 3: Write script file ────────────────────────
    SetStep(3, "creating...")
    Log("> Writing Ghost Mode script...")
    WriteScriptFile()
    if FileExist(SCRIPT_DEST) {
        Log("  Created: " . SCRIPT_DEST)
        SetStep(3, "OK")
    } else {
        Log("  [ERROR] Could not write the file.")
        Log("  Check that the script folder is accessible.")
        SetStep(3, "FAILED")
        SetupFailed()
        return
    }

    ; ── Step 4: Startup ──────────────────────────────────
    SetStep(4, "asking...")
    Log("> Add to Windows startup?")

    MsgBox, 36, Ghost Mode - Startup, Add Ghost Mode to Windows startup?`n`nIt will launch automatically every time you log in.
    IfMsgBox, Yes
    {
        startupScript := A_Startup . "\Ghost Mode.ahk"
        FileCopy, % SCRIPT_DEST, % startupScript, 1
        if (ErrorLevel = 0) {
            Log("  Added: " . startupScript)
            SetStep(4, "OK")
            launchFrom := startupScript
        } else {
            Log("  [ERROR] Could not write to startup folder.")
            Log("  Fallback - add manually:")
            Log("    Win+R  ->  shell:startup")
            Log("    Paste Ghost Mode.ahk there.")
            SetStep(4, "FAILED")
            launchFrom := SCRIPT_DEST
        }
    }
    IfMsgBox, No
    {
        Log("  Skipped.")
        Log("  To add later: Win+R -> shell:startup")
        SetStep(4, "skipped")
        launchFrom := SCRIPT_DEST
    }

    ; ── Done — auto-launch ───────────────────────────────
    Log("")
    Log("Launching Ghost Mode...")
    GuiControl, , BtnAction, Launching Ghost Mode...
    if (AHK_EXE != "")
        Run, % """" . AHK_EXE . """ """ . launchFrom . """"
    else
        Run, % launchFrom

    ShowReadyDialog()
    ExitApp
}

; ============================================================
;  Ready dialog
; ============================================================
ShowReadyDialog() {
    Gui, Ready:New, -MaximizeBox -Resize, Ghost Mode - Ready!
    Gui, Ready:Color, F6F6F6

    Gui, Ready:Font, s11 bold c1A1A1A, Segoe UI
    Gui, Ready:Add, Text, x20 y24 w420, Ghost Mode is now running!
    Gui, Ready:Font, s11 c505050, Segoe UI
    Gui, Ready:Add, Text, x20 y54, HOW TO USE:

    Gui, Ready:Font, s11 c505050, Segoe UI
    Gui, Ready:Add, Text, x28 y72,  1.  Click on any window you want to hide.
    chosenKey := GetHotkeyLabel()
    Gui, Ready:Add, Text, x28 y90,  % "2.  Press  " . chosenKey . "  to cover it with a black overlay."
    Gui, Ready:Add, Text, x28 y108,  % "3.  Press  " . chosenKey . "  again to remove it."

    Gui, Ready:Add, Text, x20 y136 w420, The overlay follows the window - even if you move or resize it.
    Gui, Ready:Add, Text, x20 y154 w420, It also hides automatically when you minimise the window.
    Gui, Ready:Font, s11 bold c1A1A1A, Segoe UI
    Gui, Ready:Add, Text, x20 y182, Enjoy Ghost Mode!
    Gui, Ready:Add, Text, x20 y208 w420 +0x10

    Gui, Ready:Font, s11 bold cF6F6F6, Segoe UI
    Gui, Ready:Add, Button, gReadyOK x126 y210 w208 h32 +Background2C2C2C, OK

    Gui, Ready:Show, w460 h265, Ghost Mode - Ready!
    WinWaitClose, Ghost Mode - Ready!
}

ReadyOK:
    Gui, Ready:Destroy
return

ReadyGuiClose:
    Gui, Ready:Destroy
return

; ============================================================
; Write the embedded script to disk (fully self-contained)
; ============================================================
WriteScriptFile() {
    global SCRIPT_DIR, SCRIPT_DEST
    FileCreateDir, % SCRIPT_DIR
    FileDelete,    % SCRIPT_DEST
    
    hotkeyStr := GetHotkeyString()

    ; Build the entire script in memory first
    scriptCode =
    (
#SingleInstance Force
#NoEnv
SetBatchLines, -1

global g_Overlays       := {}
global g_OverlayToTarget := {}

OnMessage(0x84, "OverlayHitTest")
OnMessage(0xA1, "OverlayDragStart")

global g_WinEventProc := RegisterCallback("WinEventCallback")
global g_WinEventHook := DllCall("SetWinEventHook", "UInt", 0x0016, "UInt", 0x0017, "Ptr", 0, "Ptr", g_WinEventProc, "UInt", 0, "UInt", 0, "UInt", 0x0002, "Ptr")

SetTimer, SyncOverlays, 30
return

; ── Hotkey ───────────────────────────────────────────────────
%hotkeyStr%::
    activeHwnd := WinExist("A")
    if (!activeHwnd)
        return

    if (g_OverlayToTarget.HasKey(activeHwnd)) {
        RemoveOverlay(g_OverlayToTarget[activeHwnd])
        return
    }

    if (g_Overlays.HasKey(activeHwnd)) {
        RemoveOverlay(activeHwnd)
        return
    }

    CreateOverlay(activeHwnd)
return

; ── Functions ────────────────────────────────────────────────
CreateOverlay(targetHwnd) {
    WinGetPos, x, y, w, h, ahk_id `%targetHwnd`%
    if (w = "" || h = "")
        return

    Gui, New, +HwndoverlayHwnd +ToolWindow -Caption -SysMenu
    Gui, Color, 000000
    Gui, Show, x`%x`% y`%y`% w`%w`% h`%h`% NoActivate

    DllCall("SetWindowLong" . (A_PtrSize = 8 ? "Ptr" : ""), "Ptr", overlayHwnd, "Int", -8, "Ptr", targetHwnd)
    g_Overlays[targetHwnd]        := overlayHwnd
    g_OverlayToTarget[overlayHwnd] := targetHwnd

    DllCall("SetWindowPos", "Ptr", overlayHwnd, "Ptr", 0, "Int", x, "Int", y, "Int", w, "Int", h, "UInt", 0x0010)
}

RemoveOverlay(targetHwnd) {
    overlayHwnd := g_Overlays[targetHwnd]
    Gui, `%overlayHwnd`%:Destroy
    g_Overlays.Delete(targetHwnd)
    g_OverlayToTarget.Delete(overlayHwnd)
    WinActivate, ahk_id `%targetHwnd`%
}

OverlayHitTest(wParam, lParam, msg, hwnd) {
    if (g_OverlayToTarget.HasKey(hwnd))
        return 2
}

OverlayDragStart(wParam, lParam, msg, hwnd) {
    if (g_OverlayToTarget.HasKey(hwnd) && wParam = 2) {
        targetHwnd := g_OverlayToTarget[hwnd]
        PostMessage, 0xA1, 2, lParam,, ahk_id `%targetHwnd`%
        return 0
    }
}

WinEventCallback(hHook, event, hwnd, idObj, idChild, thread, time) {
    global g_Overlays
    if (idObj != 0 || idChild != 0)
        return
    targetHwnd := hwnd + 0
    if (!g_Overlays.HasKey(targetHwnd))
        return
    overlayHwnd := g_Overlays[targetHwnd]
    if (event = 0x0016) {
        Gui, `%overlayHwnd`%:Hide
    } else if (event = 0x0017) {
        WinGetPos, x, y, w, h, ahk_id `%targetHwnd`%
        if (w != "" && h != "")
            DllCall("SetWindowPos", "Ptr", overlayHwnd, "Ptr", 0, "Int", x, "Int", y, "Int", w, "Int", h, "UInt", 0x0010 | 0x0040)
    }
}

SyncOverlays:
    for targetHwnd, overlayHwnd in g_Overlays {
        if !WinExist("ahk_id " . targetHwnd) {
            Gui, `%overlayHwnd`%:Destroy
            g_Overlays.Delete(targetHwnd)
            g_OverlayToTarget.Delete(overlayHwnd)
            continue
        }
        WinGet, state, MinMax, ahk_id `%targetHwnd`%
        if (state = -1) {
            WinGet, oState, MinMax, ahk_id `%overlayHwnd`%
            if (oState != -1)
                Gui, `%overlayHwnd`%:Hide
            continue
        }
        WinGetPos, x, y, w, h, ahk_id `%targetHwnd`%
        DllCall("SetWindowPos", "Ptr", overlayHwnd, "Ptr", 0, "Int", x, "Int", y, "Int", w, "Int", h, "UInt", 0x0010 | 0x0040)
    }
return
    )

    ; Write it all in one go
    FileAppend, %scriptCode%, % SCRIPT_DEST
}

; ============================================================
;  Helpers
; ============================================================
FindAHK() {
    for _, regPath in ["HKLM\SOFTWARE\AutoHotkey", "HKLM\SOFTWARE\WOW6432Node\AutoHotkey"] {
        RegRead, installDir, % regPath, InstallDir
        if (installDir != "" && FileExist(installDir . "\AutoHotkey.exe"))
            return installDir . "\AutoHotkey.exe"
    }
    for _, candidate in [A_ProgramFiles . "\AutoHotkey\AutoHotkey.exe"
                        , A_ProgramFiles . "\AutoHotkey\v2\AutoHotkey64.exe"
                        , A_ProgramFilesX86 . "\AutoHotkey\AutoHotkey.exe"] {
        if FileExist(candidate)
            return candidate
    }
    return ""
}

Log(msg) {
    global g_LogHwnd
    Gui, Main:Default
    GuiControlGet, current,, LogBox
    newText := (current = "") ? msg : current . "`r`n" . msg
    GuiControl, , LogBox, % newText
    PostMessage, 0x115, 7, 0, Edit1, % "ahk_id " . WinExist("Ghost Mode - Setup")
    DllCall("HideCaret", "Ptr", g_LogHwnd)
}

SetStep(n, status) {
    GuiControl, , % "Step" . n, % status
}

SetupFailed() {
    GuiControl, , BtnAction, Setup failed - see details above
    GuiControl, Enable, BtnAction
}
OnMouseMove(wParam, lParam, msg, hwnd) {
    global BtnActionHwnd
    if (hwnd = BtnActionHwnd) {
        GuiControl, +Background00AA00, BtnAction
        ; Track mouse leave manually
        SetTimer, CheckMouseLeave, 100
    }
}

CheckMouseLeave:
    global BtnActionHwnd
    MouseGetPos,,, hWndUnderMouse
    if (hWndUnderMouse != BtnActionHwnd) {
        GuiControl, +Background1A1A1A, BtnAction
        SetTimer, CheckMouseLeave, Off
    }
return

GetHotkeyString() {
    global SelectedHotkey
    if (SelectedHotkey = "Win+Shift+P")
        return "#+p"
    else if (SelectedHotkey = "Ctrl+Shift+G")
        return "^+g"
    else if (SelectedHotkey = "Ctrl+Alt+G")
        return "^!g"
    else if (SelectedHotkey = "Ctrl+Shift+H")
        return "^+h"
    else if (SelectedHotkey = "Alt+F9")
        return "!F9"
    else if (SelectedHotkey = "F9")
        return "F9"
    else if (SelectedHotkey = "F2")
        return "F2"
    else
        return "#+p"
}

GetHotkeyLabel() {
    global SelectedHotkey
    return (SelectedHotkey = "") ? "Win+Shift+P" : SelectedHotkey
}