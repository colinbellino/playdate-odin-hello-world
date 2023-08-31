package game

import "core:c"
import "core:c/libc"

import pd_api "pd_api"

State :: struct {
    pd:           ^pd_api.PlaydateAPI,
    font:         ^pd_api.LCDFont,
    text_x:       i32,
    text_y:       i32,
    text_delta_x: i32,
    text_delta_y: i32,
}

TEXT_WIDTH :: 86
TEXT_HEIGHT :: 16

state: State

@(export)
eventHandler :: proc "c" (playdate: ^pd_api.PlaydateAPI, event: pd_api.PDSystemEvent, arg: u32) -> c.int {
    #partial switch event {
        case .kEventInit: {
            state.pd = playdate
            state.pd.display.setRefreshRate(60)
            state.pd.system.setUpdateCallback(update, &state)

            state.text_x = (400 - TEXT_WIDTH) / 2
            state.text_y = (240 - TEXT_HEIGHT) / 2
            state.text_delta_x = 1
            state.text_delta_y = 2

            error : cstring
            state.font = state.pd.graphics.loadFont("/System/Fonts/Asheville-Sans-14-Bold.pft", &error)

            if state.font == nil {
                state.pd.system.error("Couldn't load font: %s.", error)
            }
        }
    }
    
    return 0
}

update :: proc "c" (userdata: rawptr) -> c.int {
    state := cast(^State)userdata

    state.pd.graphics.clear(c.uintptr_t(pd_api.LCDSolidColor.kColorWhite))
    state.pd.graphics.setFont(state.font)

    text : cstring = "Hello World!"
    state.pd.graphics.drawText(text, libc.strlen(text), pd_api.PDStringEncoding.kUTF8Encoding, state.text_x, state.text_y)
    
    state.text_x += state.text_delta_x
    state.text_y += state.text_delta_y
    if state.text_x < 0 || state.text_x > pd_api.LCD_COLUMNS - TEXT_WIDTH {
        state.text_delta_x = -state.text_delta_x
    }
    if state.text_y < 0 || state.text_y > pd_api.LCD_ROWS - TEXT_HEIGHT {
        state.text_delta_y = -state.text_delta_y
    }

    state.pd.system.drawFPS(0, 0)

    return 1
}