#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^+y:: ; Ctrl+Shift+Y billentyuparancs átírása
; Input : 464910N 0172540E 464918N 0173117E 464647N 0173153E 464647N 0172454E
; Output : 46	49	10	17	25	40	46	49	18	17	31	17	46	46	47	17	31	53	46	46	47	17	24	54	
; Output: Két szám között TABULÁTOR gombnyomás történik!

; Vágólap tartalmának feldolgozása
text := Trim(Clipboard)
text := RegExReplace(text, "\x20{2,}", A_Space) ; Reduce whitespaces to one space
; Az összes "N" és "E" karakter eltávolítása, majd szóközre bontás
text := StrReplace(text, "N", "")
text := StrReplace(text, "E", "")
parts := StrSplit(text, A_Space)


textToTabs := []
for index, value in parts {
	part := LTrim(value, "0")
	StringLen, partLength, part
	Loop, %partLength% {
		letter := SubStr(part, A_Index, 1)
		textToTabs.Push(letter)		
	}
}

for iii, numberText in textToTabs {
	;MsgBox, % numberText
	SendInput, %numberText%
	ni := iii + 1
	if (Mod(ni, 2) = 1) {
		SendInput, {Tab}
	}
}