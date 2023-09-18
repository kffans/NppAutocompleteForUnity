; made by kwan :)   https://github.com/kffans



#SingleInstance Force                         ; Forces only one instance of the script
Run "notepad++"                               ; Runs the new Notepad++ window
#HotIf WinActive("ahk_exe NOTEPAD++.EXE")     ; Executes the hotstrings and hotkeys only in Notepad++
Hotstring("EndChars", "")



; AHK v2 Documentation:   https://www.autohotkey.com/docs/v2/
;
;
; AHK hotkey symbols:     ! - Alt   ^ - Ctrl   + - Shift
;
;
; USEFUL non-ahk hotkeys: Ctrl+Shift+Up/Down   ,   Shift+Up/Down   ,   Ctrl+Left/Right   ,   Ctrl+Shift+F
;                         Ctrl+D , Ctrl+I , Ctrl+H , Ctrl+F
;                         F11 (Full Focus!)
;                         Ctrl+[/] (Fast scrolling!)



;---CANCEL HOTSTRINGS AND SEND TEXT: FUNCTIONS
global CtrlZ := 1
LoopCtrlZ(){                           ; Loops Ctrl+Z hotkey a number of times, which is set in T() and C() functions
	global CtrlZ
	SendInput("^{z " CtrlZ "}")
	CtrlZ := 1
}
T(text, _ctrlZ := 1){                  ; Used for short text, hotkeys and inputs (like {Left}, {Home}, {Backspace} etc.)
	SendInput(text)
	global CtrlZ := _ctrlZ
}



;---CLIPBOARD USAGE AND SEND LARGE TEXT: FUNCTIONS
global OldClip := ClipboardAll()       ; Stuff we need
global NewClip := ""                   ; Stuff of temporary nature
global ClipState := 0
global ActionText := ""
global ActionCtrlZ := 1
Empty(){
}
global RegAction := Empty
global RegText := ""
           
OnClipboardChange ChangeClip
ChangeClip(DataType){
	switch ClipState {
	case 0: global OldClip := ClipboardAll()             ; When copying and cutting with Ctrl+X or Ctrl+C
	case 1: SendInput("^v")                              ; When pasting with Ctrl+V
	case 2: SendInput("^v") T(ActionText, ActionCtrlZ)   ; When pasting by the C() function
	case 3: global RegText := A_Clipboard                ; When copying text for RegEx functions
		    RegAction.Call()
	}
	global ClipState := 0
}
PasteFromOld(){
	global ClipState := 1
	A_Clipboard := OldClip             ; ChangeClip is called here
}
CopyPasteToNew(text, _actionText, _actionCtrlZ){
	global ClipState := 2
	global NewClip := text
	global ActionText := _actionText
	global ActionCtrlZ := _actionCtrlZ
	A_Clipboard := NewClip             ; ChangeClip is called here
}
C(text, _actionText := "", _actionCtrlZ := 1){           ; Used for usual text, templates etc.
	CopyPasteToNew(text, _actionText, _actionCtrlZ)
}



;---REGEX: FUNCTIONS
Shorter(p, side := "left"){
	(side = "left") ? SendInput("{Home}{Right " p "}") : SendInput("{End}{Left " p "}")
}
EqualRight(){    ;{End}+{Home}^c{End}
	pos := RegExMatch(RegText, "=[^=]")
	diff := StrLen(RegText)-pos
	(diff>StrLen(RegText)/2) ? Shorter(pos, "left") : Shorter(diff, "right")
}
EqualLeft(){     ;{End}+{Home}^c{End}
	pos := RegExMatch(RegText, ".[\+\-\*\/\%\!=\:]=")
	if(pos = 0)
		pos := RegExMatch(RegText, ".\?\?=")
	if(pos = 0)
		pos := RegExMatch(RegText, ".=")
	diff := StrLen(RegText)-pos
	(diff>StrLen(RegText)/2) ? Shorter(pos, "left") : Shorter(diff, "right")
}
R(func, text){
	global ClipState := 3
	global RegAction := func
	SendInput(text)                    ; ChangeClip is called here
}



;---DISABLED KEYS
SetCapsLockState("AlwaysOff")
NumpadIns::return
NumpadEnd::return
NumpadDown::return
NumpadLeft::return
NumpadHome::return
NumLock::return
Delete::return
LWin::return
RWin::return
^q::return
^e::return



;---HOTKEYS
^v::PasteFromOld()

RShift::T("{End}")
RCtrl::T("{Home}")

LShift & `::T("+``+``{Backspace}", 2)                                 ; Make single tilde, but writing accents won't work
LShift & RShift::T("+{End}")
LShift & RCtrl::T("+{Home}")

Capslock & Backspace::T("{End}{Home}{Right 3}{Backspace 3}{End}")     ; Uncomment a whole line by removing "// "

<^Space::SendInput("{Right}")                                         ; [Ctrl+Space]         - Moves once to right, useful when inside many brackets
^!z::LoopCtrlZ()                                                      ; [Ctrl+Alt+Z]         - Cancel a hotstring
<^Enter::T("{End}{Enter}")                                            ; [Ctrl+Enter]         - New line below the current
<^<!Enter::T("{End}a{Enter}^+{Up}{Down}{End}{Backspace}{Up}{End}")    ; [Ctrl+Alt+Enter]     - New line above the current
<^Backspace::T("a^{i}{Backspace}{Down}{Backspace}{Up}{End}", 3)       ; [Ctrl+Backspace] - Remove a whole line, move caret upwards
<^<!Backspace::T("a^{i}{Backspace}{Down}{Backspace}{End}", 3)         ; [Ctrl+Alt+Backspace]     - Remove a whole line, move caret downwards
LCtrl & RShift::T("+{End}{Backspace}")                                ; Removes right-side of current line from caret
LCtrl & RCtrl::T("+{Home}{Backspace}")                                ; Removes left-side of current line from caret
LCtrl & g::Send("^h{Tab}^v{Tab 11}{Enter}{Esc}")                      ; Fast replace-all: copy(cut) the replacer text, select(highlight) the replacee text

LAlt & RShift::R(EqualRight, "{End}+{Home}^c{End}")                   ; Find an equals sign (e.g. += , == , =) in current line, and goes to its right-most side
LAlt & RCtrl::R(EqualLeft, "{End}+{Home}^c{End}")                     ; Like above, but goes to the left-most side
<!Backspace::T("{End}a+{Home}{Backspace}")                            ; [Alt+Backspace]      - Clears a line
!x::SendInput("{End}+{Home}^xa^i{Backspace 2}")                       ; [Alt+X]              - Cuts the current line
!c::SendInput("{End}+{Home}^c{End}")                                  ; [Alt+C]              - Copies the current line
!v::SendInput("{End}a+{Home}^v{End}")                                 ; [Alt+V]              - Replaces the current line with copied content

Capslock & x::SendInput("{End}+{Home}^xa^i{Backspace 2}")             ; Cuts the current line
Capslock & c::SendInput("{End}+{Home}^c{End}")                        ; Copies the current line
Capslock & v::SendInput("{End}a+{Home}^v{End}")                       ; Replaces the current line with copied content





;---HOTSTRINGS


; question mark in   :*?X:          means that this hotstring can be activated after ANY letter or character
; X character in     :*X:           means that this hotstring executes functions; these functions can be separated by commas
; C character in     :*XC:          means that this hotstring is case-sensitive
; `t or `n in        :*X:abc`t::    `t is for Tab, `n is for Enter  -  press these keys when needed to write out a hotstring


:*X:profile`t::C("Profiler.BeginSample(`"`");Profiler.EndSample();", "^{Left 4}{Enter}{Up}{End}{Left 3}", 3)               ; using UnityEngine.Profiling;
:*X:nullable`t::T("a^{i}{Backspace}"), C("#nullable enable`n#nullable disable")
:*X:summ`t::T("a^{i}{Backspace}"), C("/// <summary>`n/// `n/// </summary>`n/// <param name=`"`"></param>", "{Up 2}", 3)    ; Documentation?

:*?X://`n::C("/**/", "{Left 2}{Enter}^+{Down}", 4)
:*?X:/`n::T("{End}{Home}// {End}", 3)
:*?X:@`t::C("// @TODO ")
:*?X:/`t::C("// ")
:*?X:{  ::T("{{}{End}{}}{Left} {Left}", 3)
:*?X:{ `t::T("{{}{Enter}{}}", 4)
:*?X:{`t::C("{}", "{Left}{Enter}", 4)
:*?X:+`t::C(" + `" `" + ")              ; Mostly used in Debug.Log() to separate variables
:*?Xb0:""::T("{Left}")
:*?Xb0:''::T("{Left}")
:*?Xb0:{}::T("{Left}")
:*?Xb0:<>::T("{Left}")
:*?Xb0:[]::T("{Left}")
:*?Xb0:()::T("{Left}")
:*?Xb0:() ::T("{Backspace}{Right}", 3)
:*?Xb0:();::T("{Backspace}{Right};", 3)

:*X:if`t::C("if(){}", "{Left}{Enter}{Up}{End}{Left 2}", 4)
:*X:i`t::C("if()", "{Left}")
:*X:elif`t::C("else if(){}", "{Left}{Enter}{Up}{End}{Left 2}", 4)
:*X:eli`t::C("else if()", "{Left}")
:*X:el`t::C("else{}", "{Left}{Enter}", 4)
:*X:e`t::C("else", "{Enter}", 2)

:*X:forea`t::C("foreach( in ){}", "{Left}{Enter}{Up}{End}^{Left 2}{Left}", 4)
:*X:fore`t::C("foreach( in )", "^{Left 2}{Left}")
:*X:for`t::C("for(int i=0; i<; i++){}", "{Left}{Enter}{Up}{End}^{Left 3}{Right}", 4)
:*X:fo`t::C("for(int i=0; i<; i++)", "^{Left 3}{Right}")
:*X:whi`t::C("while(){}", "{Left}{Enter}{Up}{End}{Left 2}", 4)
:*X:wh`t::C("while()", "{Left}")
:*X:swi`t::C("switch(){}", "{Left}{Enter}{Up}{End}{Left 2}", 4)
:*X:cas`t::C("case :break;", "^{Left 2}{Enter}{Tab}{Enter}{Up 2}{End}{Left}", 6)
:*X:ca`t::C("case :  break;", "^{Left 3}")
:*X:def`t::C("default:break;", "^{Left 2}{Enter}{Tab}{Enter}{Up}", 6)
:*X:de`t::C("default:  break;", "^{Left 2}{Left}")

:*X:onena`t::C("void OnEnable(){}", "{Left}{Enter}", 4)
:*X:ondis`t::C("void OnDisable(){}", "{Left}{Enter}", 4)
:*X:ondes`t::C("void OnDestroy(){}", "{Left}{Enter}", 4)

:*X:fun`t::C("void (){}", "{Left}{Enter}{Up}{End}^{Left}", 4)
:*X:awa`t::C("void Awake(){}", "{Left}{Enter}", 4)
:*X:sta`t::C("void Start(){}", "{Left}{Enter}", 4)
:*X:upd`t::C("void Update(){}", "{Left}{Enter}", 4)
:*X:fix`t::C("void FixedUpdate(){}", "{Left}{Enter}", 4)
:*X:lat`t::C("void LateUpdate(){}", "{Left}{Enter}", 4)
:*X:int`t::C("public interface I{}", "^{Left}{Enter}{Right}{Enter}{Up 2}{End}", 6)
:*X:str`t::C("struct {}", "{Left}{Enter}{Up}{End}{Left}", 4)
:*X:en`t::C("enum {}", "{Left}{Enter}{Up}{End}{Left}", 4)
:*XC:ie`t::C("IEnumerator (){}", "{Left}{Enter}{Up}{End}^{Left}", 4)
:*X:fu`t::C("(){}", "{Left}{Enter}{Up}{End}^{Left}", 4)

:*X:cla`t::C("public class  : {}", "^{Left}{Enter}{Right}{Enter}{Up 2}{End}^{Left}{Left}", 8)
:*X:cl`t::C("class {}", "{Left}{Enter}{Up}{End}{Left}", 4)

:*X:[req`t::C("[RequireComponent(typeof())]", "{Left 3}")
:*X:[sel`t::C("[SelectionBase]")
:*X:[ss`t::C("[Serializable]")            ; Make a public struct serializable
:*X:[sf`t::C("[SerializeField]")          ; Serialize a serializable struct element OR a private field
:*X:[he`t::C("[Header(`"`")]", "{Left 3}")
:*X:[hi`t::C("[HideInInspector]")

:*X:rand`t::C("UnityEngine.Random.Range(,)", "{Left 2}")
:*X:inst`t::C("Instantiate(,);", "{Left 3}")
:*X:debe`t::C("Debug.LogError();", "{Left 2}")
:*X:debw`t::C("Debug.LogWarning();", "{Left 2}")
:*X:deb`t::C("Debug.Log();", "{Left 2}")
:*X:cor`t::C("StartCoroutine(());", "{Left 4}")
:*X:des`t::C("Destroy();", "{Left 2}")
:*?X:get`t::C("GetComponent<>()", "{Left 3}")
:*X:gf`t::C("GameObject.Find(`"`")", "{Left 2}")
:*X:di`t::C("Dictionary<,>", "{Left 2}")
:*X:li`t::C("List<>", "{Left}")
:*X:eq`t::C("Equals()", "{Left}")
:*X:yi`t::C("yield return `;", "{Left}")
:*X:y`t::C("yield return Ev.Wait();", "{Left 2}")
:*X:a`t::C("Add();", "{Left 2}")

:*X:rea`t::C("readonly")
:*X:pro`t::C("protected")
:*X:pr`t::C("private")
:*X:p`t::C("public")
:*X:ab`t::C("abstract")
:*X:vi`t::C("virtual")
:*X:ov`t::C("override")
:*X:s`t::C("static")
:*X:n`t::C("null")
:*X:r`t::C("return")
:*XC:d`t::C("default")
:*XC:D`t::C("Default")
:*XC:t`t::C("this.")
:*XC:T`t::C("This")
:*X:con`t::C("continue;")
:*X:br`t::C("break;")

:*X:prof`t::C("using UnityEngine.Profiling;")
:*X:coll`t::C("using System.Collections;")
:*X:gen`t::C("using System.Collections.Generic;")
:*X:sys`t::C("using System;")                        ; , "{Left}"
:*X:sce`t::C("using UnityEngine.SceneManagement;")
:*X:uni`t::C("using UnityEngine;")                   ; , "{Left}"
:*X:vni`t::C("using Vnitarka;")
:*X:mis`t::C("using static Vnitarka.Misc;")
:*X:us`t::C("using ")

:*X:timef`t::C("Time.fixedDeltaTime")
:*X:timed`t::C("Time.deltaTime")
:*X:text`t::C("TextMeshProUGUI")
:*?XC:pos`t::C("position")
:*?XC:Pos`t::C("Position")
:*X:loc`t::C("localPosition")
:*X:rig`t::C("Rigidbody2D")
:*X:raw`t::C("RawImage")
:*?X:mon`t::C("MonoBehaviour")
:*?X:but`t::C("Button")
:*?X:scr`t::C("ScriptableObject")
:*?XC:tr`t::C("transform")
:*?XC:Tr`t::C("Transform")
:*XC:IE`t::C("IEnumerator")
:*X:re`t::C("RectTransform")
:*X:co`t::C("Coroutine")
:*X:ph`t::C("Physics.")
:*X:in`t::C("Input.")
:*XC:g`t::C("gameObject")
:*XC:G`t::C("GameObject")
:*?X:c`t::C("Count")
:*?X:l`t::C("Length")
:*X:v`t::C("Vector")
:*X:f`t::C("float")
:*X:b`t::C("bool")


