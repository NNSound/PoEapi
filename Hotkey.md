# PoEapikit 快捷鍵與功能說明文件

本文件說明 [PoEapikit](./) 專案中所有預設、寫死（硬編碼）以及隱藏的快捷鍵（Hotkey）功能與其實作邏輯。

> [!NOTE]
> * 在快捷鍵表示法中：`^` 代表 **Ctrl**，`+` 代表 **Shift**，`!` 代表 **Alt**，`#` 代表 **Windows 鍵**。
> * 大多數快捷鍵可以在設定介面中進行啟用/停用或自訂按鍵，但部分內建、寫死或贊助者專屬的功能無法變更快捷鍵。

---

## 1. 預設快捷鍵清單 (可自訂)
這是在 [Hotkeys.ahk](./ahk/lib/Hotkeys.ahk) 的 `defaultHotkeys` 中所定義的快捷鍵，使用者可以透過腳本設定介面來修改或啟閉。

| 預設按鍵 | 功能名稱 (Label) | 預設啟用 | 說明 | 實作邏輯與對應函式 |
| :--- | :--- | :---: | :--- | :--- |
| `` ` `` (反引號) | `ExitGame` | 是 | 返回角色選擇畫面 (快速登出) | 呼叫 [ptask.logout()](./ahk/PoEapikit.ahk#L178-L180) 登出遊戲。 |
| `a` | `AutoPickup` | 是 | 自動拾取附近物品 | 呼叫 [ptask.beginPickup()](./ahk/PoEapikit.ahk#L135-L140) 開始自動尋路並拾取附近物品。 |
| `q` | `QuickDefense` | 是 | 快速防禦動作 | 在非聊天狀態且於地圖中時觸發防禦動作 [QuickDefense](./ahk/PoEapikit.ahk#L124-L129)。 |
| `s` | `LevelupGems` | 是 | 升級技能寶石 | 呼叫 [ptask.levelupGems()](./ahk/PoEapikit.ahk#L131-L133) 自動點擊畫面上的升級寶石圖示。 |
| `w` | [Attack](./ahk/PoEapikit.ahk#L114-L122) (主要) | 是 | 主要攻擊技能 | 若在拾取狀態會先停止拾取，並執行主要攻擊動作。 |
| 滑鼠右鍵 | [Attack](./ahk/PoEapikit.ahk#L114-L122) (次要) | 否 | 次要攻擊技能 | 動作與主要攻擊技能相同，預設為停用。 |
| `Win+d` | `MinimizeWindow` | 是 | 最小化 PoE 視窗 | 使用 `WinMinimize` 最小化當前的 Path of Exile 視窗 [MinimizeWindow](./ahk/PoEapikit.ahk#L291-L293)。 |
| `F1` | `AutoAuras` | 否 | 自動開啟光環 | 發送對應的光環按鍵，快速施放光環 [AutoAuras](./ahk/PoEapikit.ahk#L182-L184)。 |
| `F2` | `OpenPortal` | 否 | 快速開啟傳送門 | 呼叫 [ptask.inventory.openPortal()](./ahk/PoEapikit.ahk#L186-L188) 使用傳送門。 |
| `F3` | `SellItems` | 否 | 自動鑑定並販賣物品 | 在藏身處或有倉庫時，自動向商人鑑定並販賣背包物品 [SellItems](./ahk/PoEapikit.ahk#L190-L195)。 |
| `F4` | `StashItems` | 是 | 存入倉庫物品 (一鍵存倉) | 在藏身處或有倉庫時，將背包內的物品自動存入目前開啟的倉庫分頁 [StashItems](./ahk/PoEapikit.ahk#L197-L202)。 |
| `F5` | `Hideout` | 否 | 快速進入藏身處 | 在聊天視窗中自動輸入並發送 `/hideout` 以傳送回藏身處 [Hideout](./ahk/PoEapikit.ahk#L204-L206)。 |
| `Ctrl+F5` | `Delve` | 否 | 快速進入掘獄營地 (礦坑) | 在聊天視窗中自動輸入並發送 `/delve` [Delve](./ahk/PoEapikit.ahk#L208-L210)。 |
| `Alt+F5` | `Menagerie` | 否 | 快速進入獸欄 | 在聊天視窗中自動輸入並發送 `/menagerie` [Menagerie](./ahk/PoEapikit.ahk#L212-L214)。 |
| `F12` | `ShowLog` | 是 | 顯示/隱藏日誌視窗 | 顯示 `PoEapikit` 的運作偵錯日誌視窗 [ShowLog](./ahk/PoEapikit.ahk#L370-L372)。 |
| `左 Alt` | `ShowPrices` | 是 | 顯示懸停物品的價格與攻略 | 顯示滑鼠懸停物品的估算價格。若是辛迪加或穿越神殿介面，則會顯示對應的攻略圖 [ShowPrices](./ahk/PoEapikit.ahk#L299-L333)。按住 `Ctrl` 可進入鎖定模式。 |
| `Ctrl+左鍵` (長按) | `AutoCtrlClick` | 是 | 自動 Ctrl 點擊器 | 按住時每 50ms 自動執行 Ctrl+點擊 (可搭配 Shift/Alt)，用於快速轉移物品 [AutoCtrlClick](./ahk/PoEapikit.ahk#L216-L224)。 |
| `Shift+左鍵` (長按) | `AutoShiftClick` | 是 | 自動 Shift 點擊器 | 按住時每 50ms 自動執行 Shift+點擊，便於快速使用通貨 [AutoShiftClick](./ahk/PoEapikit.ahk#L226-L228)。 |
| `Shift+右鍵` (長按) | `AutoRButtonClick` | 是 | 自動右鍵點擊器 | 按住時每 50ms 自動連點滑鼠右鍵 [AutoRButtonClick](./ahk/PoEapikit.ahk#L230-L232)。 |
| `Ctrl+右鍵` | `AutoFillPrice` | 是 | 自動填寫物品定價 | 對倉庫公開分頁中的物品進行估價並自動在定價欄位填上價格 [AutoFillPrice](./ahk/PoEapikit.ahk#L234-L282)。 |
| `Ctrl+c` | `CopyItemName` | 否 | 複製懸停物品的名稱 | 複製滑鼠懸停物品的名字。若按住 `Shift` 則顯示詳細剪貼簿資訊 [CopyItemName](./ahk/PoEapikit.ahk#L335-L344)。 |
| `Ctrl+f` | `HighlightItems` | 是 | 高亮倉庫分頁中的物品 | 將懸停物品名稱填入倉庫搜尋欄，且若背包有同名物品也會一併高亮 [HighlightItems](./ahk/PoEapikit.ahk#L346-L358)。 |
| `Ctrl+m` | `ToggleMaphack` | 是 | 切換地圖全開 (Maphack) | 啟用或停用地圖全開 (迷霧解除) 功能 [ToggleMaphack](./ahk/PoEapikit.ahk#L295-L297)。 |
| `Ctrl+w` | `OpenWiki` | 是 | 開啟 Wiki 頁面 | 辨識懸停物品名稱，並以瀏覽器開啟 `poewiki.net` 對應頁面 [OpenWiki](./ahk/PoEapikit.ahk#L360-L368)。 |
| `Ctrl+r` | `Reload` | 是 | 重新載入腳本 | 重新載入 `PoEapikit` 的 AHK 腳本 [Reload()](./ahk/PoEapikit.ahk#L374-L376)。 |
| `Ctrl+q` | `ExitApp` | 是 | 結束 PoEapikit | 關閉並結束 `PoEapikit` 程式 [ExitApp()](./ahk/PoEapikit.ahk#L378-L380)。 |

---

## 2. 額外功能選單 (可於選單啟動或自訂綁定)
這些功能預設沒有綁定快捷鍵（快捷鍵為空），但可在 UI 介面自訂快捷鍵，或者在遊戲內的額外選單中點擊執行：

* **[tradeGems](./ahk/extras/vendor.ahk#L83-L107) (販賣有品質的寶石)**
  * **說明**：自動整理倉庫特定分頁中品質大於 0% 且小於 20%、等級小於 19 的寶石移至背包中販賣，以快速換取寶石匠的棱鏡 (GCP)。
* **[tradeDivinationCards](./ahk/extras/vendor.ahk#L109-L164) (兌換命運卡)**
  * **說明**：自動將目前分頁或背包中已疊滿的命運卡取出，並向 NPC 兌換。
* **[openStackedDecks](./ahk/extras/vendor.ahk#L257-L318) (開啟卡牌套組)**
  * **說明**：自動將背包/倉庫中的卡牌套組 (Stacked Deck) 快速右鍵開啟，並自動將產生的命運卡整理到背包中，且會於日誌中依價值顯示不同顏色的紀錄。
* **[unstackVeildedScarabs](./ahk/extras/vendor.ahk#L320-L382) (拆疊隱匿甲蟲)**
  * **說明**：自動右鍵開啟並整理隱匿甲蟲 (Veiled Scarab)。
* **[dumpUselessItems](./ahk/extras/vendor.ahk#L384-L405) (傾倒無用物品)**
  * **說明**：自動將倉庫目前分頁中，估價低於 1 混沌石的非通貨物品移入背包。
* **[sortItems](./ahk/extras/vendor.ahk#L408-L502) (整理物品)**
  * **說明**：自動整理背包或一般/大倉庫分頁的物品，依據物品估值（高至低）與基本名稱進行排序。

---

## 3. 固定快捷鍵 (硬編碼，無法於設定中變更)
這些快捷鍵直接寫死在程式碼中，無法透過 `Hotkeys.ahk` 介面修改。

| 按鍵 | 對應函式 / 標籤 | 說明 | 實作位置與邏輯 |
| :--- | :--- | :--- | :--- |
| `F6` | [dumpInventoryItems](./ahk/extras/vendor.ahk#L215-L225) | 傾倒背包物品 | 將背包內所有物品自動移入目前開啟的倉庫分頁。按住 `Ctrl` 可以中斷。 |
| `Ctrl+F6` | [dumpStashTabItems](./ahk/extras/vendor.ahk#L227-L255) | 傾倒倉庫分頁中高亮或所有物品 | 將目前倉庫分頁中被高亮搜尋（或全部）的物品自動移入背包。背包滿了即停止。 |
| `F7` | [tradeFullRareSets](./ahk/extras/vendor.ahk#L166-L213) | 整套稀有裝備賣給商店 (混沌石配方) | 自動從指定倉庫分頁取出整套稀有裝備（武器、頭、胸、手、鞋、腰、項鍊、雙戒）並向商店販售換取混沌石。 |
| `Ctrl+滾輪下滑` | (直譯發送 `{Right}`) | 倉庫切換至右邊分頁 | 當焦點在倉庫分頁時，按住 `Ctrl` 往下滾動滑鼠滾輪，會自動切換至右側分頁 [[PoEapikit.ahk:L284](./ahk/PoEapikit.ahk#L284)]。 |
| `Ctrl+滾輪上滑` | (直譯發送 `{Left}`) | 倉庫切換至左邊分頁 | 當焦點在倉庫分頁時，按住 `Ctrl` 往上滾動滑鼠滾輪，會自動切換至左側分頁 [[PoEapikit.ahk:L285](./ahk/PoEapikit.ahk#L285)]。 |
| `+` 鍵 | `NumpadAdd` | 映射為小鍵盤加號 | 方便沒有小鍵盤或特殊配置的鍵盤執行原本綁定在小鍵盤 `+` 的操作 [[PoEapikit.ahk:L289](./ahk/PoEapikit.ahk#L289)]。 |
| `-` 鍵 | `NumpadSub` | 映射為小鍵盤減號 | 映射 `-` 鍵為小鍵盤 `-` 鍵 [[PoEapikit.ahk:L288](./ahk/PoEapikit.ahk#L288)]。 |
| `Shift + -` | (直譯發送 `_`) | 輸入底線 | 避免 `-` 被覆寫後無法輸入底線符號 [[PoEapikit.ahk:L287](./ahk/PoEapikit.ahk#L287)]。 |

---

## 4. 贊助者專專屬快捷鍵 (Patreon Only)
這些快捷鍵通常無法在介面自訂，且需要贊助者身份才可正常運作 [[Hotkeys.ahk:L100-L101](./ahk/lib/Hotkeys.ahk#L100-L101)]。

| 按鍵 | 說明 | 實作邏輯與作用 |
| :--- | :--- | :--- |
| `Ctrl+d` | 查詢所選物品/附近奇珍展示架物品價格 | 快速對目前滑鼠懸停物品或附近的奇珍展示架物品進行線上即時價格查詢。 |
| `Ctrl+Shift+d` | 查詢當前倉庫分頁或背包中物品價格 | 自動大量查詢目前開啟的倉庫分頁或是整個背包中所有物品的估算價格。 |

---

## 5. 隱藏 / 偵錯快捷鍵
專供開發者偵錯、測試或呼叫隱藏 GUI 視窗使用。

| 按鍵 | 對應函式 / 類別 | 說明 | 實作位置與邏輯 |
| :--- | :--- | :--- | :--- |
| `Alt+m` | [showMinimap](./ahk/extras/Minimap.ahk#L88) | 開啟 Web 版小地圖 | 讀取遊戲地形 (Terrain) 資料，以 HTML5 Canvas 於獨立網頁視窗中繪製完整地圖 [[Minimap.ahk:L92](./ahk/extras/Minimap.ahk#L92)]。 |
| `Ctrl+Alt+d` | [openConsole](./ahk/extras/debug.ahk#L335) | 開啟偵錯主控台 (Console) | 開啟 AHK 運算主控台，可以直接輸入並執行 AHK/PoEapi 程式碼表達式，並保存歷史紀錄 [[debug.ahk:L24](./ahk/extras/debug.ahk#L24)]。 |
| `Ctrl+i` | [openInspector](./ahk/extras/debug.ahk#L340) | 開啟 IngameUI 審查元素工具 | 開啟 [IngameUIInspector](./ahk/extras/debug.ahk#L32)，可以用樹狀圖形式檢視 PoE 的遊戲內 UI 結構、記憶體地址及座標位置 [[debug.ahk:L25](./ahk/extras/debug.ahk#L25)]。 |
