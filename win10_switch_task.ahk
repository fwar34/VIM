#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

switch_flag = 0
^Tab::
if (switch_flag == 0) {
	Send, #^{Right}
	switch_flag = 1
} else {
	Send, #^{Left}
	switch_flag = 0
}
return

MButton::
if (switch_flag == 0) {
	Send, #^{Right}
	switch_flag = 1
} else {
	Send, #^{Left}
	switch_flag = 0
}
return

desktop_flag = 0
^MButton::
if (desktop_flag == 0) {
	Send, #+{Right}
	desktop_flag = 1
} else {
	Send, #+{Left}
	desktop_flag = 0
}
return
