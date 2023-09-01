package game

import "core:c"
import "core:c/libc"

import pd_api "pd_api"

State :: struct {
    pd:                ^pd_api.PlaydateAPI,
    font:              ^pd_api.LCDFont,
    text_x:            i32,
    text_y:            i32,
    text_delta_x:      i32,
    text_delta_y:      i32,
    background_h:      i32,
    background_y:      i32,
    background_sprite: ^pd_api.LCDSprite,
    background_bitmap: ^pd_api.LCDBitmap,
    player_sprite:     ^pd_api.LCDSprite,
    player_bitmap:     ^pd_api.LCDBitmap,
}

SpriteType :: enum u8 {
    kPlayer       = 0,
    kPlayerBullet = 1,
    kEnemyPlane   = 2,
}

TEXT_WIDTH :: 86
TEXT_HEIGHT :: 16

state: State

@(export)
eventHandler :: proc "c" (playdate: ^pd_api.PlaydateAPI, event: pd_api.PDSystemEvent, arg: u32) -> c.int {
    #partial switch event {
        case .kEventInit: init(playdate)
    }
    
    return 0
}

init :: proc "c" (playdate: ^pd_api.PlaydateAPI) {
    state.pd = playdate
    state.pd.display.setRefreshRate(50)
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

    { // setupBackground
        state.background_sprite = state.pd.sprite.newSprite()

        state.background_bitmap = load_image_at_path("images/background")
        state.pd.graphics.getBitmapData(state.background_bitmap, nil, &state.background_h, nil, nil, nil)
        state.pd.sprite.setUpdateFunction(state.background_sprite, update_background_sprite)
        state.pd.sprite.setDrawFunction(state.background_sprite, draw_background_sprite)
        background_bounds := pd_api.PDRectMake(0, 0, 400, 240)
        state.pd.sprite.setBounds(state.background_sprite, background_bounds)
        state.pd.sprite.setZIndex(state.background_sprite, 0)
        state.pd.sprite.addSprite(state.background_sprite)
    }

    { // createPlayer
        state.player_sprite = state.pd.sprite.newSprite()
        state.player_bitmap = load_image_at_path("images/player")
        state.pd.sprite.setUpdateFunction(state.player_sprite, update_player)
        w, h: i32
        state.pd.graphics.getBitmapData(state.player_bitmap, &w, &h, nil, nil, nil)
        state.pd.sprite.setImage(state.player_sprite, state.player_bitmap, .kBitmapUnflipped)
        cr := pd_api.PDRectMake(5, 5, f32(w - 10), f32(h - 10))
        state.pd.sprite.setCollideRect(state.player_sprite, cr)
        state.pd.sprite.setCollisionResponseFunction(state.player_sprite, player_collision_response)

        state.pd.sprite.moveTo(state.player_sprite, 200, 180)

        state.pd.sprite.setZIndex(state.player_sprite, 1000)
        state.pd.sprite.addSprite(state.player_sprite)
        state.pd.sprite.setTag(state.player_sprite, u8(SpriteType.kEnemyPlane))

        // backgroundPlaneCount += 1
    }
}

update :: proc "c" (userdata: rawptr) -> c.int {
    state := cast(^State)userdata

    state.pd.graphics.clear(c.uintptr_t(pd_api.LCDSolidColor.kColorWhite))
    state.pd.sprite.updateAndDrawSprites()

    {
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
    }

    state.pd.system.drawFPS(0, 0)

    return 1
}

load_image_at_path :: proc "c" (path: cstring) -> ^pd_api.LCDBitmap {
    error: cstring
    image := state.pd.graphics.loadBitmap(path, &error)
    if error != nil {
        state.pd.system.logToConsole("Error loading image at path '%s': %s", path, error)
    }
    return image
}

update_background_sprite :: proc "c" (s: ^pd_api.LCDSprite) {
    state.background_y += 1
    if state.background_y > state.background_h {
        state.background_y = 0
    }

    state.pd.sprite.markDirty(state.background_sprite)
}

draw_background_sprite :: proc "c" (sprite: ^pd_api.LCDSprite, bounds: pd_api.PDRect, drawrect: pd_api.PDRect) {
    state.pd.graphics.drawBitmap(state.background_bitmap, 0, state.background_y, .kBitmapUnflipped)
    state.pd.graphics.drawBitmap(state.background_bitmap, 0, state.background_y - state.background_h, .kBitmapUnflipped)
}

update_player :: proc "c" (s: ^pd_api.LCDSprite) {
    current: pd_api.PDButtons
    state.pd.system.getButtonState(&current, nil, nil)

    delta_x, delta_y: f32
    current_bit_set := pd_api.PDButtonsBitSet { current }

    if .kButtonUp in current_bit_set {
        delta_y = -4
    } else if .kButtonDown in current_bit_set {
        delta_y = 4
    }

    if .kButtonLeft in current_bit_set {
        delta_x = -4
    } else if .kButtonRight in current_bit_set {
        delta_x = 4
    }

    x, y: f32
    state.pd.sprite.getPosition(s, &x, &y)

    len: i32
    cInfo := state.pd.sprite.moveWithCollisions(s, x + delta_x, y + delta_y, nil, nil, &len)

    // int i
    // for ( i = 0 i < len i++ )
    // {
    // 	SpriteCollisionInfo info = cInfo[i]

    // 	if ( pd->sprite->getTag(info.other) == kEnemyPlane ) {
    // 		destroyEnemyPlane(info.other)
    // 		score -= 1
    // 		pd->system->logToConsole("Score: %d", score)
    // 	}
    // }

    // pd->system->realloc(cInfo, 0) // caller is responsible for freeing memory of array returned by moveWithCollisions()
}

player_collision_response :: proc "c" (sprite, other: ^pd_api.LCDSprite) -> pd_api.SpriteCollisionResponseType {
    return .kCollisionTypeOverlap
}