#NoEnv
#InstallKeybdHook
#UseHook
#SingleInstance Force
Process, Priority,, High
SetBatchLines, -1
ListLines Off
DetectHiddenWindows, On
SetTitleMatchMode, 2

SetWinDelay, -1
SetKeyDelay, -1, -1
SetControlDelay, -1

; ================================
; GLOBAL STATE
; ================================
global mirrorOn := false
global targetTitle := "StarBreak"
global keyState := {}

; ================================
; SEND TO ALL MATCHING WINDOWS
; ================================
SendToAllStarBreak(keys) {
    WinGet, list, List, % targetTitle
    Loop %list% {
        id := list%A_Index%
        ControlSend,, %keys%, ahk_id %id%, , SendEvent
    }
}

; ================================
; TOGGLE MIRRORING
; ================================
\::
    mirrorOn := !mirrorOn

    ; Release all keys when turning OFF (ONLY safety net)
    if (!mirrorOn) {
        for key, state in keyState {
            if (state = "down")
                SendToAllStarBreak("{" key " up}")
            keyState[key] := "up"
        }
    }

    ToolTip % "Mirror " (mirrorOn ? "ON" : "OFF")
    Sleep 500
    ToolTip
return

; ================================
; SEND KEY WITH STATE TRACKING
; ================================
SendKey(key, state) {
    global mirrorOn, keyState

    if (!mirrorOn)
        return

    ; Ignore duplicate transitions
    if (keyState[key] = state)
        return

    keyState[key] := state
    SendToAllStarBreak("{" key " " state "}")
}

; ================================
; MOVEMENT / ACTION KEYS
; ================================
~*w::SendKey("w","down")
~*w up::SendKey("w","up")

~*a::SendKey("a","down")
~*a up::SendKey("a","up")

~*s::SendKey("s","down")
~*s up::SendKey("s","up")

~*d::SendKey("d","down")
~*d up::SendKey("d","up")

~*q::SendKey("q","down")
~*q up::SendKey("q","up")

~*r::SendKey("r","down")
~*r up::SendKey("r","up")

~*j::SendKey("j","down")
~*j up::SendKey("j","up")

~*k::SendKey("k","down")
~*k up::SendKey("k","up")

~*i::SendKey("i","down")
~*i up::SendKey("i","up")

~*l::SendKey("l","down")
~*l up::SendKey("l","up")

~*Up::SendKey("Up","down")
~*Up up::SendKey("Up","up")

~*Down::SendKey("Down","down")
~*Down up::SendKey("Down","up")

~*Left::SendKey("Left","down")
~*Left up::SendKey("Left","up")

~*Right::SendKey("Right","down")
~*Right up::SendKey("Right","up")

~*Space::SendKey("Space","down")
~*Space up::SendKey("Space","up")

~*h::SendKey("h","down")
~*h up::SendKey("h","up")
