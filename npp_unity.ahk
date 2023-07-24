; Made by kwan :)   https://github.com/kffans


#SingleInstance Force
Run "notepad++"
#HotIf WinActive("ahk_exe NOTEPAD++.EXE")

; USEFUL non-ahk hotkeys: Ctrl+Shift+Up/Down   ,   Shift+Up/Down   ,   Ctrl+Left/Right   ,   Ctrl+Shift+F
;                         Ctrl+D , Ctrl+I , Ctrl+H , Ctrl+F , F11 (Full Focus!)



;---DISABLED KEYS
Capslock::return
LWin::return
RWin::return



;---HOTKEYS
LShift & `::Send("+``+``{Backspace}")
LCtrl & Backspace::Send("^{i}{Backspace 2}")
LCtrl & g::Send("^{h}")

RShift::Send("{End}")
RCtrl::Send("{Home}^{Right}")



;---HOTSTRINGS
:*:if`t::if(){{}{Enter 2}{}}{Up 2}{End}{Left 2}
:*:i`t::if(){Left}
:*:elif`t::else if(){{}{Enter 2}{}}{Up 2}{End}{Left 2}
:*:eli`t::else if(){Left}
:*:el`t::else{{}{Enter 2}{}}{Up}
:*:e`t::else{Enter}

:*:for`t::for(int i=0; i<; i{+}{+}){Left 6}
:*:wh`t::while(){{}{Enter 2}{}}{Up 2}{End}{Left 2}
:*:{`t::{{}{Enter 2}{}}{Up}
:*:/`t::/{*}{Enter}{*}/

:*:fun`t::void (){{}{Enter 2}{}}{Up 2}{End}{Left 3}
:*:sta`t::void Start(){{}{Enter 2}{}}{Up}
:*:upd`t::void Update(){{}{Enter 2}{}}{Up}
:*:fix`t::void FixedUpdate(){{}{Enter 2}{}}{Up}
:*:int`t::public interface I{Enter}{{}{Enter 2}{}}{Up 3}{End}
:*:str`t::struct {{}{Enter 2}{}}{Up 2}{End}{Left}
:*:ie`t::IEnumerator (){{}{Enter 2}{}}{Up 2}{End}{Left 3}
:*:cl`t::class  : MonoBehaviour{Enter}{{}{Enter 2}{}}{Up 3}{End}{Left 16}
:*:c`t::class {{}{Enter 2}{}}{Up 2}{End}{Left}

:*:rand`t::UnityEngine.Random.Range(,){Left 2}
:*:inst`t::Instantiate(,);{Left 3}
:*:cor`t::StartCoroutine(());{Left 4}
:*:deb`t::Debug.Log();{Left 2}
:*:get`t::GetComponent<>(){Left 3}
:*:gf`t::GameObject.Find(""){Left 2}
:*:y`t::yield return Ev.Wait();{Left 2}

:*:pro`t::protected
:*:pr`t::private
:*:p`t::public
:*:ab`t::abstract
:*:s`t::static
:*:n`t::null
:*:t`t::this{.}

:*:rig`t::Rigidbody2D
:*:pos`t::position
:*:re`t::RectTransform
:*:tr`t::transform
:*:ph`t::Physics{.}
:*:g`t::gameObject
:*:v`t::Vector
:*:f`t::float
