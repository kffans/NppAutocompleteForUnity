# Notepad++ Autocomplete for Unity
An AHK (AutoHotkey) script to help you write C# code for Unity in Notepad++, with many snippets, shortcuts, hotstrings and hotkeys. 

How to run the ``npp_unity.ahk`` script:
1. Download Notepad++ here: https://notepad-plus-plus.org/downloads/
2. Download AHK v2 here:    https://www.autohotkey.com/download/ahk-v2.exe
3. Launch AutoHotkey Dash, go into "Editor Settings" and in the Command Line textarea, type in: ``Notepad++.exe "%L"``
4. Double-click the ``npp_unity.ahk`` script.

The script will open a new Notepad++ window and run its autocomplete features in the background. If you have Notepad's default autocomplete on and it clashes with this script, you can turn it off in ``Settings->Autocomplete`` and uncheck for functions and words, or alternatively set the autocomplete trigger from >4 characters.

*Test if it works:* in Notepad++, type in ``sta`` and then a Tab key, you should see ``void Start(){}`` function fully typed out.

*Disclaimer:* this script is highly personalized for my workflow, that's why some buttons may be turned off :p (e.g. Capslock, Win).
You can easily modify the disabled keys, Hotkeys and Hotstrings by editing ``npp_unity.ahk`` contents to your liking.
If you feel lost in editing the script, check the AHK documentation: https://www.autohotkey.com/docs/v2/



**Examples:** ('|' character is caret position)

``for``+Tab   ->   ``for(int i=0; i<|; i++)``

``p``+Tab   ->   ``public``

``fun``+Tab -> ``void |(){}``

``cor``+Tab   ->   ``StartCoroutine(|());``

``deb``+Tab   ->   ``Debug.Log(|);``


and many more. Check the file's content for all functionalities!
