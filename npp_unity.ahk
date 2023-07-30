; Made by kwan :)   https://github.com/kffans


#SingleInstance Force
Run "notepad++"
#HotIf WinActive("ahk_exe NOTEPAD++.EXE")

; USEFUL non-ahk hotkeys: Ctrl+Shift+Up/Down   ,   Shift+Up/Down   ,   Ctrl+Left/Right   ,   Ctrl+Shift+F
;                         Ctrl+D , Ctrl+I , Ctrl+H , Ctrl+F
;                         F11 (Full Focus!)
;                         Ctrl+[/] (Fast scrolling!)



;---CANCEL HOTSTRINGS: FUNCTIONS AND HOTKEY
global ctrlz := 1
LoopCtrlZ(){
	global ctrlz
	Send("^{z " ctrlz "}")
	ctrlz := 1
}
SetCtrlZ(x){    ;how many times should it click Ctrl+Z until snippet/hotstring disappear
	global ctrlz := x
}
^!z::LoopCtrlZ()   ;Ctrl+Alt+Z



;---DISABLED KEYS
Capslock::return
LWin::return
RWin::return



;---HOTKEYS
LShift & `::Send("+``+``{Backspace}")    ;make single tilde, but writing accents won't work
LCtrl & Backspace::Send("^{i}{Backspace 2}")
LCtrl & g::Send("^{h}")

RShift::Send("{End}")
RCtrl::Send("{Home}")



;---HOTSTRINGS
Hotstring("EndChars", "")
; :*:send`t::Send("{End}"){Space 3},SetCtrlZ(){Left}    ;used for setting ctrlz for hotstrings right here in this script
; :*X:summ`t::SendInput("/// <summary>`n/// `n/// </summary>`n/// <param name=`"`"></param>{Up 2}")   ,SetCtrlZ(7) ;documentation?


:*X:if`t::Send("if(){{}{Enter 2}{}}{Up 2}{End}{Left 2}")         ,SetCtrlZ(6)
 :*:i`t::if(){Left}
:*X:elif`t::Send("else if(){{}{Enter 2}{}}{Up 2}{End}{Left 2}")  ,SetCtrlZ(6)
 :*:eli`t::else if(){Left}
:*X:el`t::Send("else{{}{Enter 2}{}}{Up}")                        ,SetCtrlZ(6)
:*X:e`t::Send("else{Enter}")                                     ,SetCtrlZ(2)

:*X:fore`t::Send("foreach( in ){{}{Enter 2}{}}{Up 2}{End}{Left 6}")             ,SetCtrlZ(6)
:*X:for`t::Send("for(int i=0; i<; i{+}{+}){{}{Enter 2}{}}{Up 2}{End}{Left 7}")  ,SetCtrlZ(6)
 :*:fo`t::for(int i=0; i<; i{+}{+}){Left 6}
:*X:whi`t::Send("while(){{}{Enter 2}{}}{Up 2}{End}{Left 2}")                    ,SetCtrlZ(6)
 :*:wh`t::while(){Left}
 
 :*?://`t:://{@}CHANGE{Space}
:*?X:/`t::Send("/{*}{Enter}{*}/")                             ,SetCtrlZ(3)
:*?X:{ `t::Send("{{}{Enter}{}}^+{Down}{Up}{Home}{Tab}{End}")  ,SetCtrlZ(6)
 :*?:{`t::{{}{Enter 2}{}}{Up}

:*X:fun`t::Send("void (){{}{Enter 2}{}}{Up 2}{End}{Left 3}")            ,SetCtrlZ(6)
:*X:awa`t::Send("void Awake(){{}{Enter 2}{}}{Up}")                      ,SetCtrlZ(6)
:*X:sta`t::Send("void Start(){{}{Enter 2}{}}{Up}")                      ,SetCtrlZ(6)
:*X:upd`t::Send("void Update(){{}{Enter 2}{}}{Up}")                     ,SetCtrlZ(6)
:*X:fix`t::Send("void FixedUpdate(){{}{Enter 2}{}}{Up}")                ,SetCtrlZ(6)
:*X:lat`t::Send("void LateUpdate(){{}{Enter 2}{}}{Up}")                 ,SetCtrlZ(6)
:*X:int`t::Send("public interface I{Enter}{{}{Enter 2}{}}{Up 3}{End}")  ,SetCtrlZ(8)
:*X:str`t::Send("struct {{}{Enter 2}{}}{Up 2}{End}{Left}")              ,SetCtrlZ(6)
:*X:en`t::Send("enum {{}{Enter 2}{}}{Up 2}{End}{Left}")                 ,SetCtrlZ(6)
:*X:ie`t::Send("IEnumerator (){{}{Enter 2}{}}{Up 2}{End}{Left 3}")      ,SetCtrlZ(6)

:*X:cls`t::Send("class  : ScriptableObject{Enter}{{}{Enter 2}{}}{Up 3}{End}{Left 19}")  ,SetCtrlZ(8)
:*X:cl`t::Send("class  : MonoBehaviour{Enter}{{}{Enter 2}{}}{Up 3}{End}{Left 16}")      ,SetCtrlZ(8)
:*X:c`t::Send("class {{}{Enter 2}{}}{Up 2}{End}{Left}")                                 ,SetCtrlZ(6)

:*:[req`t::[RequireComponent(typeof())]{Left 3}
:*:[sel`t::[SelectionBase]
:*:[ss`t::[Serializable]        ;make a public struct serializable
:*:[sf`t::[SerializeField]      ;serialize a serializable struct element OR a private field
:*:[he`t::[Header("")]{Left 3}
:*:[hi`t::[HideInInspector]

:*:rand`t::UnityEngine.Random.Range(,){Left 2}
:*:inst`t::Instantiate(,);{Left 3}
:*:cor`t::StartCoroutine(());{Left 4}
:*:deb`t::Debug.Log();{Left 2}
:*:get`t::GetComponent<>(){Left 3}
:*:dic`t::Dictionary<,>{Left 2}
:*:gf`t::GameObject.Find(""){Left 2}
:*:y`t::yield return Ev.Wait();{Left 2}

:*:pro`t::protected
:*:pr`t::private
:*:p`t::public
:*:ab`t::abstract
:*:vi`t::virtual
:*:ov`t::override
:*:s`t::static
:*:n`t::null
:*:t`t::this.

:*:timef`t::Time.fixedDeltaTime
:*:timed`t::Time.deltaTime
:*:text`t::TextMeshProUGUI
:*:pos`t::position
:*:loc`t::localPosition
:*:len`t::Length
:*:rig`t::Rigidbody2D
:*:raw`t::RawImage
:*:mon`t::MonoBehaviour
:*:scr`t::ScriptableObject
:*:re`t::RectTransform
:*:tr`t::transform
:*:ph`t::Physics.
:*:g`t::gameObject
:*:v`t::Vector
:*:f`t::float


