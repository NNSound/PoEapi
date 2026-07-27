;
; Hotkeys.ahk, 9/22/22 12:49 AM
;

; Hotkeys (^ for Ctrl, ! for Alt, + for Shift, # for window key)
;
;                           Enabled Prefix Key Name     Label              Description
;                           ------- ------ -----------  -----------------  --------------------------------------
global defaultHotkeys := [ [ true,  "",    "``",        "ExitGame",        "返回角色選擇畫面"]
                         , [ true,  "~*",  "a",         "AutoPickup",      "拾取附近物品"]
                         , [ true,  "$",   "q",         "QuickDefense",    "快速防禦動作"]
                         , [ true,  "~",   "s",         "LevelupGems",     "升級技能寶石"]
                         , [ true,  "~",   "w",         "Attack",          "主要攻擊技能"]
                         , [ false, "~",   "RButton",   "Attack",          "次要攻擊技能"]
                         , [ true,  "",    "#d",        "MinimizeWindow",  "最小化 PoE 視窗"]
                         , [ false,  "",    "F1",       "AutoAuras",       "自動光環 (ALT+F1 顯示效能統計)"]
                         , [ false,  "",    "F2",       "OpenPortal",      "開啟傳送門"]
                         , [ false,  "*",   "F3",       "SellItems",       "自動鑑定並販賣物品"]
                         , [ true,  "",    "F4",        "StashItems",      "存入倉庫物品"]
                         , [ false,  "",    "F5",       "Hideout",         "進入藏身處"]
                         , [ false,  "",    "^F5",      "Delve",           "進入掘獄營地"]
                         , [ false,  "",    "!F5",      "Menagerie",       "進入獸欄"]
                         , [ true,  "",    "F12",       "ShowLog",         "顯示日誌視窗"]
                         , [ true,  "~*",  "LAlt",      "ShowPrices",      "顯示倉庫分頁、背包等處的物品價格"]
                         , [ true,  "*",   "^LButton",  "AutoCtrlClick",   "按住以啟用自動 CTRL 點擊器"]
                         , [ true,  "~",   "+LButton",  "AutoShiftClick",  "按住以啟用自動 SHIFT 點擊器"]
                         , [ true,  "",    "+RButton",  "AutoRButtonClick","按住以啟用自動滑鼠右鍵點擊器"]
                         , [ true,  "~",   "^RButton",  "AutoFillPrice",   "自動填寫所選物品的價格標籤"]
                         , [ false, "~*",  "^c",        "CopyItemName",    "複製所選物品的名稱"]
                         , [ true,  "~",   "^f",        "HighlightItems",  "高亮倉庫分頁中的物品"]
                         , [ true,  "",    "^m",        "ToggleMaphack",   "切換地圖全開 (Maphack)"]
                         , [ true,  "",    "^w",        "OpenWiki",        "開啟 Wiki"]
                         , [ false, "",     "",         "tradeGems",       "販賣有品質的寶石"]
                         , [ false, "",     "",         "tradeDivinationCards", "兌換命運卡"]
                         , [ false, "",     "",         "openStackedDecks","開啟卡牌套組"]
                         , [ false, "",     "",         "sortItems",       "整理物品"]
                         , [ true,  "",    "^r",        "Reload",          "重新載入腳本"]
                         , [ true,  "",    "^q",        "ExitApp",         "結束 PoEapikit"] ]

class Hotkeys extends WebGui {

    __new() {
        base.__new("Hotkeys",, 800, 600)
        this.document.write("
        (%
        <!DOCTYPE html>
        <html>
        <head>
            <style>
                * { font-family: Georgia, Serif; line-height: 1.5; }
                html, body { display: flex; flex-flow: column; height: 100%; background: #f0f0f0; margin: 0; }
                div { flex: 2 1 auto; font-size: 18px; margin: 5px 5px; padding: 0px 15px; overflow: auto; }
                span { flex: 0 1 auto; margin: 0px 5px 5px; }
                button { font-family: Calibri; background-color: #e1e1e1; border: 1px solid #adadad; min-width: 98px; margin: 5px 0 5px 10px; float: right; transition: 0.4s; padding: 0 30px; }
                button:focus { outline: solid; outline-width: 1px; outline-color: #0078d7; }
                button:hover { background-color: #e5f1fb; outline: solid; outline-width: 1px; outline-color: #0078d7; }
                table { font-size: 16px; padding: 10px; }
                tr:nth-child(even) { background-color: #f7f7f7; }
                td:nth-child(2) { color: blue; text-align: right; font-weight: bold; }
                td:nth-child(3) { color: dimgray; padding: 0 15px; }
                input[type=text] { border: 1px solid #adadad; font-size: 16px; font-weight: bold; color: blue; text-align: right; padding: 0 5px 5px; }
                input[type=text]::-ms-clear { display: none; }
                input[type=text]:focus { border-color: #0078d7; }
                .hint { font-size: 14px; color: dimgray; margin: 15px; }
            </style>
        </head>
        <body>
            <div>
                <h2>快捷鍵設定</h2>
                <i class='hint'>* ^ 代表 CTRL，+ 代表 SHIFT，! 代表 ALT，# 代表 Windows 鍵</i><br/>
                <i class='hint'>** 額外功能或贊助者 (Patreon) 專屬功能的快捷鍵無法更改。</i> 
                <table id='hotkeys'>
                </table>
            </div>
            <span>
                <button id='cancel'>取消</button>
                <button id='ok'>確定</button>
            </span>
        </body>
        </html>
        )")
        this.document.close()
        this.list()
        this.bindAll("button")
    }

    list() {
        this.hotkeyOptions := loadHotkeys()
        hotkeyTable := ""
        for i, hotkey in this.hotkeyOptions {
            hotkeyTable .= "<tr>"
            hotkeyTable .= Format("<td><input type='checkbox' id='{}' {}></td>", "hotkey_" i "_enabled", hotkey.enabled ? "checked" : "")
            hotkeyTable .= Format("<td><input type='text' id='{}' size=12 value='{}'></td>", "hotkey_" i "_keyname", hotkey.name)
            hotkeyTable .= "<td>" hotkey.description "</td>"
            hotkeyTable .= "</tr>"
        }
        hotkeyTable .= "<tr><td></td><td>F6</td><td>傾倒背包物品</td></tr>"
        hotkeyTable .= "<tr><td></td><td>Ctrl+F6</td><td>傾倒倉庫分頁中高亮或所有的物品</td></tr>"
        hotkeyTable .= "<tr><td></td><td>F7</td><td>整套稀有裝備賣給商店 (配方)</td></tr>"
        hotkeyTable .= "<tr><td></td><td>Ctrl+d</td><td><b style='color:darkred'>[贊助者專屬]</b> 查詢所選物品或附近奇珍展示架物品的價格</td></tr>"
        hotkeyTable .= "<tr><td></td><td>Ctrl+Shift+d</td><td><b style='color:darkred'>[贊助者專屬]</b> 查詢當前倉庫分頁或背包中物品的價格</td></tr>"
        this._("#hotkeys").innerHtml := hotkeyTable
    }

    ok() {
        for i, hotkey in this.hotkeyOptions {
            hotkey.name := this._("#hotkey_" i "_keyname").value
            hotkey.enabled := this._("#hotkey_" i "_enabled").checked
        }

        if (saveHotkeys(this.hotkeyOptions))
            this.close()
    }

    cancel() {
        this.close()
    }
}

loadHotkeys() {
    try {
        hotkeyOptions := db.exec("SELECT * FROM hotkeys;")
        hotkeyIndex := []
        for i, hotkey in hotkeyOptions
            hotkeyIndex[hotkey.label] := hotkey

        for i, hotkey in defaultHotkeys {
            hkey := hotkeyIndex[hotkey[4]]
            if (Not hkey) {
                hkey := { "enabled": hotkey[1]
                        , "prefix": hotkey[2]
                        , "name": hotkey[3]
                        , "label": hotkey[4]
                        , "description": hotkey[5] }
                hotkeyOptions.Insert(i, hkey)
                hotkeyChanged := true
            } else if (hkey.prefix != hotkey[2]) {
                hkey.prefix := hotkey[2]
                hotkeyChanged := true
            }
        }

        if (hotkeyChanged)
            saveHotkeys(hotkeyOptions)
    } catch {
    } finally {
        if (Not hotkeyOptions) {
            db.exec("
            (
                DROP TABLE IF EXISTS hotkeys;
                CREATE TABLE hotkeys (
                    id INTEGER PRIMARY KEY,
                    enabled INTEGER,
                    prefix TEXT,
                    name TEXT,
                    label TEXT,
                    description TEXT);
            )")

            for i, hotkey in defaultHotkeys
                db.exec("INSERT INTO hotkeys VALUES ({}, {}, '{}', '{}', '{}', ""{}"");", i, hotkey*)
            hotkeyOptions := db.exec("SELECT * FROM hotkeys;")
        }
    }

    Hotkey, IfWinActive, ahk_class POEWindowClass
    for i, hotkey in hotkeyOptions {
        try {
            if (hotkey.enabled && hotkey.name)
                Hotkey, % hotkey.prefix . hotkey.name, % hotkey.label, On
        } catch e {
            hotkey.enabled := false
            db.exec("INSERT OR REPLACE INTO hotkeys VALUES ({}, {}, '{}', '{}', '{}', ""{}"");"
                    , i, hotkey.enabled, hotkey.prefix, hotkey.name, hotkey.label, hotkey.description)
            MsgBox, % "Hotkey error: " e.message
            return
        }
    }

    return hotkeyOptions
}

saveHotkeys(hotkeyOptions) {
    oldHotkeys := db.exec("SELECT * FROM hotkeys;")
    Hotkey, IfWinActive, ahk_class POEWindowClass
    for i, hotkey in hotkeyOptions {
        try {
            if (oldHotkeys[i].enabled && oldHotkeys[i].name)
                Hotkey, % oldHotkeys[i].prefix . oldHotkeys[i].name, Off
        } catch {}
        db.exec("INSERT OR REPLACE INTO hotkeys VALUES ({}, {}, '{}', '{}', '{}', ""{}"");"
                , i, hotkey.enabled, hotkey.prefix, hotkey.name, hotkey.label, hotkey.description)
    }

    ; reload the hotkeys
    return loadHotkeys()
}
