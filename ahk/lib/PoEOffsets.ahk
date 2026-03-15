;
; PoEOffsets.ahk 1/6/2021 10:45 AM
;

global PoEOffsets = { "version" : "3.28", "offsets"
    : { "GameStates"  : { "active_game_states"          : 0x20
                        , "all_game_states"             : 0x48 }

      , "IngameState" : { "in_game_ui"                  : 0x290
                        , "in_game_data"                : 0x218
                        ,     "server_data"             : 0x8e0
                        , "ui_root"                     : 0x518
                        , "hovered"                     : 0x550
                        , "hovered_item"                : 0x560
                        , "camera"                      : 0x270
                        ,     "width"                   : 0x318
                        ,     "height"                  : 0x31c
                        ,     "matrix"                  : 0x1a8 }

      , "IngameData"  : { "world_area"                  : 0xa8
                        , "area_data"                   : 0xb0
                        ,     "area_index"              : 0x40
                        , "area_level"                  : 0xcc
                        , "area_hash"                   : 0x10c
                        , "local_player"                : 0x8e8
                        , "entity_list"                 : 0x9a0
                        ,     "root"                    : 0x8
                        , "entity_list_count"           : 0x9a8 }

      , "IngameUI"    : { "lefe_panel"                  : 0x5f0
                        , "right_panel"                 : 0x5f8
                        , "panel_flags"                 : 0x600
                        , "entity_list"                 : 0x6d0
                        ,     "root"                    : 0x4f0
                        ,     "count"                   : 0x4f8 }

      , "ServerData"  : { "player_data"                 : 0x9858
                        ,     "passive_skills"          : 0x180
                        ,     "player_class"            : 0x238
                        ,     "level"                   : 0x23c
                        ,     "refund_points_left"      : 0x240
                        ,     "skill_points_from_quest" : 0x244
                        ,     "ascendancy_skill_points" : 0x24c
                        , "league"                      : 0xbd48
                        , "party_status"                : 0xc060
                        , "stash_tabs"                  : 0xbe18
                        , "inventory_slots"             : 0xc348 }

      , "Entity"      : { "internal"                    : 0x8
                        ,     "path"                    : 0x8
                        , "component_list"              : 0x10
                        , "id"                          : 0x88 }

      , "Element"     : { "self"                        : 0xb0
                        , "childs"                      : 0xf0
                        , "root"                        : 0x140
                        , "position"                    : 0x148
                        , "scale"                       : 0x160
                        , "parent"                      : 0x1d0
                        , "is_visible"                  : 0x1d9
                        , "is_enabled"                  : 0x1dd
                        , "size"                        : 0x258
                        , "highlighted"                 : 0x260
                        , "text"                        : 0x380
                        , "item"                        : 0x410 }

      , "StashTab"    : { "name"                        : 0x8
                        , "inventory_id"                : 0x28
                        , "type"                        : 0x34
                        , "index"                       : 0x38
                        , "folder_id"                   : 0x3a
                        , "flags"                       : 0x3d
                        , "is_affinity"                 : 0x3e
                        , "affinities"                  : 0x3f }

      , "Inventory"   : { "type"                        : 0x140
                        , "sub_type"                    : 0x144
                        , "cols"                        : 0x14c
                        , "rows"                        : 0x150
                        , "cells"                       : 0x170
                        , "count"                       : 0x190 } } }
