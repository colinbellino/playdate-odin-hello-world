package pd_api

foreign import "pd_api"

import c "core:c"

// FIXME(colin): These are bindings for Playdate 1.x so i need to go over them and upgrade to 2.x.
//               Also needs a lot of clean up, not production ready by any means.

PLAYDATEAPI_H :: 1
pdext_display_h :: 1
pdext_file_h :: 1
SEEK_SET :: 0
SEEK_CUR :: 1
SEEK_END :: 2
pdext_gfx_h :: 1
LCD_COLUMNS :: 400
LCD_ROWS :: 240
LCD_ROWSIZE :: 52
pdext_lua_h :: 1
pdext_scoreboards_h :: 1
pdext_sound_h :: 1
AUDIO_FRAMES_PER_CYCLE :: 512
NOTE_C4 :: 60
pdext_sprite_h :: 1
pdext_sys_h :: 1

SDFile :: struct {}
LCDPattern :: [16]u8
LCDColor :: c.uintptr_t
lua_State :: rawptr
lua_CFunction :: #type proc "c" (L : ^lua_State) -> c.int
AddScoreCallback :: #type proc "c" (score : ^PDScore, errorMessage : cstring)
PersonalBestCallback :: #type proc "c" (score : ^PDScore, errorMessage : cstring)
BoardsListCallback :: #type proc "c" (boards : ^PDBoardsList, errorMessage : cstring)
ScoresCallback :: #type proc "c" (scores : ^PDScoresList, errorMessage : cstring)
MIDINote :: c.float
sndCallbackProc :: #type proc "c" (c : ^SoundSource)
signalStepFunc :: #type proc "c" (userdata : rawptr, ioframes : ^c.int, ifval : ^c.float) -> c.float
signalNoteOnFunc :: #type proc "c" (userdata : rawptr, note : c.float, vel : c.float, len : c.float)
signalNoteOffFunc :: #type proc "c" (userdata : rawptr, stopped : c.int, offset : c.int)
signalDeallocFunc :: #type proc "c" (userdata : rawptr)
synthRenderFunc :: #type proc "c" (userdata : rawptr, left : ^i32, right : ^i32, nsamples : c.int, rate : u32, drate : i32) -> c.int
synthNoteOnFunc :: #type proc "c" (userdata : rawptr, note : c.float, velocity : c.float, len : c.float)
synthReleaseFunc :: #type proc "c" (userdata : rawptr, stop : c.int)
synthSetParameterFunc :: #type proc "c" (userdata : rawptr, parameter : c.int, value : c.float) -> c.int
synthDeallocFunc :: #type proc "c" (userdata : rawptr)
SequenceFinishedCallback :: #type proc "c" (seq : ^SoundSequence, userdata : rawptr)
effectProc :: #type proc "c" (e : ^SoundEffect, left : ^i32, right : ^i32, nsamples : c.int, bufactive : c.int) -> c.int
AudioSourceFunction :: #type proc "c" (ctx : rawptr, left : ^i16, right : ^i16, len : c.int) -> c.int
RecordCallback :: #type proc "c" (ctx : rawptr, buffer : ^i16, length : c.int) -> c.int
LCDSpriteDrawFunction :: #type proc "c" (sprite : ^LCDSprite, bounds : PDRect, drawrect : PDRect)
LCDSpriteUpdateFunction :: #type proc "c" (sprite : ^LCDSprite)
LCDSpriteCollisionFilterProc :: #type proc "c" (sprite : ^LCDSprite, other : ^LCDSprite) -> SpriteCollisionResponseType
PDCallbackFunction :: #type proc "c" (userdata : rawptr) -> c.int
PDMenuItemCallbackFunction :: #type proc "c" (userdata : rawptr)

PDSystemEvent :: enum i32 {
    kEventInit,
    kEventInitLua,
    kEventLock,
    kEventUnlock,
    kEventPause,
    kEventResume,
    kEventTerminate,
    kEventKeyPressed,
    kEventKeyReleased,
    kEventLowPower,
}

FileOptions :: enum i32 {
    kFileRead = 1,
    kFileReadData = 2,
    kFileWrite = 4,
    kFileAppend = 8,
}

LCDBitmapDrawMode :: enum i32 {
    kDrawModeCopy,
    kDrawModeWhiteTransparent,
    kDrawModeBlackTransparent,
    kDrawModeFillWhite,
    kDrawModeFillBlack,
    kDrawModeXOR,
    kDrawModeNXOR,
    kDrawModeInverted,
}

LCDBitmapFlip :: enum i32 {
    kBitmapUnflipped,
    kBitmapFlippedX,
    kBitmapFlippedY,
    kBitmapFlippedXY,
}

LCDSolidColor :: enum i32 {
    kColorBlack,
    kColorWhite,
    kColorClear,
    kColorXOR,
}

LCDLineCapStyle :: enum i32 {
    kLineCapStyleButt,
    kLineCapStyleSquare,
    kLineCapStyleRound,
}

LCDFontLanguage :: enum i32 {
    kLCDFontLanguageEnglish,
    kLCDFontLanguageJapanese,
    kLCDFontLanguageUnknown,
}

PDStringEncoding :: enum i32 {
    kASCIIEncoding,
    kUTF8Encoding,
    k16BitLEEncoding,
}

LCDPolygonFillRule :: enum i32 {
    kPolygonFillNonZero,
    kPolygonFillEvenOdd,
}

l_valtype :: enum i32 {
    kInt,
    kFloat,
    kStr,
}

LuaType :: enum i32 {
    kTypeNil,
    kTypeBool,
    kTypeInt,
    kTypeFloat,
    kTypeString,
    kTypeTable,
    kTypeFunction,
    kTypeThread,
    kTypeObject,
}

SoundFormat :: enum i32 {
    kSound8bitMono = 0,
    kSound8bitStereo = 1,
    kSound16bitMono = 2,
    kSound16bitStereo = 3,
    kSoundADPCMMono = 4,
    kSoundADPCMStereo = 5,
}

LFOType :: enum i32 {
    kLFOTypeSquare,
    kLFOTypeTriangle,
    kLFOTypeSine,
    kLFOTypeSampleAndHold,
    kLFOTypeSawtoothUp,
    kLFOTypeSawtoothDown,
    kLFOTypeArpeggiator,
    kLFOTypeFunction,
}

SoundWaveform :: enum i32 {
    kWaveformSquare,
    kWaveformTriangle,
    kWaveformSine,
    kWaveformNoise,
    kWaveformSawtooth,
    kWaveformPOPhase,
    kWaveformPODigital,
    kWaveformPOVosim,
}

TwoPoleFilterType :: enum i32 {
    kFilterTypeLowPass,
    kFilterTypeHighPass,
    kFilterTypeBandPass,
    kFilterTypeNotch,
    kFilterTypePEQ,
    kFilterTypeLowShelf,
    kFilterTypeHighShelf,
}

SpriteCollisionResponseType :: enum i32 {
    kCollisionTypeSlide,
    kCollisionTypeFreeze,
    kCollisionTypeOverlap,
    kCollisionTypeBounce,
}

PDButtons :: enum i32 {
    kButtonLeft = 1,
    kButtonRight = 2,
    kButtonUp = 4,
    kButtonDown = 8,
    kButtonB = 16,
    kButtonA = 32,
}

PDLanguage :: enum i32 {
    kPDLanguageEnglish,
    kPDLanguageJapanese,
    kPDLanguageUnknown,
}

PDPeripherals :: enum i32 {
    kNone = 0,
    kAccelerometer = 1,
    kAllPeripherals = 65535,
}

PlaydateAPI :: struct {
    system : ^playdate_sys,
    file : ^playdate_file,
    graphics : ^playdate_graphics,
    sprite : ^playdate_sprite,
    display : ^playdate_display,
    sound : ^playdate_sound,
    lua : ^playdate_lua,
    json : ^playdate_json,
    scoreboards : ^playdate_scoreboards,
}

playdate_sys :: struct {
    realloc : #type proc "c" (ptr : rawptr, size : c.size_t) -> rawptr,
    formatString : #type proc "c" (ret : ^cstring, fmt : cstring) -> c.int,
    logToConsole : #type proc "c" (fmt : cstring, #c_vararg args: ..any),
    error : #type proc "c" (fmt : cstring, #c_vararg args: ..any),
    getLanguage : #type proc "c" () -> PDLanguage,
    getCurrentTimeMilliseconds : #type proc "c" () -> c.uint,
    getSecondsSinceEpoch : #type proc "c" (milliseconds : ^c.uint) -> c.uint,
    drawFPS : #type proc "c" (x : c.int, y : c.int),
    setUpdateCallback : #type proc "c" (update : PDCallbackFunction, userdata : rawptr),
    getButtonState : #type proc "c" (current : ^PDButtons, pushed : ^PDButtons, released : ^PDButtons),
    setPeripheralsEnabled : #type proc "c" (mask : PDPeripherals),
    getAccelerometer : #type proc "c" (outx : ^c.float, outy : ^c.float, outz : ^c.float),
    getCrankChange : #type proc "c" () -> c.float,
    getCrankAngle : #type proc "c" () -> c.float,
    isCrankDocked : #type proc "c" () -> c.int,
    setCrankSoundsDisabled : #type proc "c" (flag : c.int) -> c.int,
    getFlipped : #type proc "c" () -> c.int,
    setAutoLockDisabled : #type proc "c" (disable : c.int),
    setMenuImage : #type proc "c" (bitmap : ^LCDBitmap, xOffset : c.int),
    addMenuItem : #type proc "c" (title : cstring, callback : PDMenuItemCallbackFunction, userdata : rawptr) -> ^PDMenuItem,
    addCheckmarkMenuItem : #type proc "c" (title : cstring, value : c.int, callback : PDMenuItemCallbackFunction, userdata : rawptr) -> ^PDMenuItem,
    addOptionsMenuItem : #type proc "c" (title : cstring, optionTitles : [^]cstring, optionsCount : c.int, f : PDMenuItemCallbackFunction, userdata : rawptr) -> ^PDMenuItem,
    removeAllMenuItems : #type proc "c" (),
    removeMenuItem : #type proc "c" (menuItem : ^PDMenuItem),
    getMenuItemValue : #type proc "c" (menuItem : ^PDMenuItem) -> c.int,
    setMenuItemValue : #type proc "c" (menuItem : ^PDMenuItem, value : c.int),
    getMenuItemTitle : #type proc "c" (menuItem : ^PDMenuItem) -> cstring,
    setMenuItemTitle : #type proc "c" (menuItem : ^PDMenuItem, title : cstring),
    getMenuItemUserdata : #type proc "c" (menuItem : ^PDMenuItem) -> rawptr,
    setMenuItemUserdata : #type proc "c" (menuItem : ^PDMenuItem, ud : rawptr),
    getReduceFlashing : #type proc "c" () -> c.int,
    getElapsedTime : #type proc "c" () -> c.float,
    resetElapsedTime : #type proc "c" (),
    getBatteryPercentage : #type proc "c" () -> c.float,
    getBatteryVoltage : #type proc "c" () -> c.float,
    getTimezoneOffset : #type proc "c" () -> i32,
    shouldDisplay24HourTime : #type proc "c" () -> c.int,
    convertEpochToDateTime : #type proc "c" (epoch : u32, datetime : ^PDDateTime),
    convertDateTimeToEpoch : #type proc "c" (datetime : ^PDDateTime) -> u32,
}

playdate_file :: struct {
    geterr : #type proc "c" () -> cstring,
    listfiles : #type proc "c" (path : cstring, unamed0 : #type proc "c" (path : cstring, userdata : rawptr), userdata : rawptr, showhidden : c.int) -> c.int,
    stat : #type proc "c" (path : cstring, stat : ^FileStat) -> c.int,
    mkdir : #type proc "c" (path : cstring) -> c.int,
    unlink : #type proc "c" (name : cstring, recursive : c.int) -> c.int,
    rename : #type proc "c" (from : cstring, to : cstring) -> c.int,
    open : #type proc "c" (name : cstring, mode : FileOptions) -> rawptr,
    close : #type proc "c" (file : rawptr) -> c.int,
    read : #type proc "c" (file : rawptr, buf : rawptr, len : c.uint) -> c.int,
    write : #type proc "c" (file : rawptr, buf : rawptr, len : c.uint) -> c.int,
    flush : #type proc "c" (file : rawptr) -> c.int,
    tell : #type proc "c" (file : rawptr) -> c.int,
    seek : #type proc "c" (file : rawptr, pos : c.int, whence : c.int) -> c.int,
}

playdate_graphics :: struct {
    video : ^playdate_video,
    clear : #type proc "c" (color : c.uintptr_t),
    setBackgroundColor : #type proc "c" (color : LCDSolidColor),
    setStencil : #type proc "c" (stencil : ^LCDBitmap),
    setDrawMode : #type proc "c" (mode : LCDBitmapDrawMode),
    setDrawOffset : #type proc "c" (dx : c.int, dy : c.int),
    setClipRect : #type proc "c" (x : c.int, y : c.int, width : c.int, height : c.int),
    clearClipRect : #type proc "c" (),
    setLineCapStyle : #type proc "c" (endCapStyle : LCDLineCapStyle),
    setFont : #type proc "c" (font : ^LCDFont),
    setTextTracking : #type proc "c" (tracking : c.int),
    pushContext : #type proc "c" (target : ^LCDBitmap),
    popContext : #type proc "c" (),
    drawBitmap : #type proc "c" (bitmap : ^LCDBitmap, x : c.int, y : c.int, flip : LCDBitmapFlip),
    tileBitmap : #type proc "c" (bitmap : ^LCDBitmap, x : c.int, y : c.int, width : c.int, height : c.int, flip : LCDBitmapFlip),
    drawLine : #type proc "c" (x1 : c.int, y1 : c.int, x2 : c.int, y2 : c.int, width : c.int, color : c.uintptr_t),
    fillTriangle : #type proc "c" (x1 : c.int, y1 : c.int, x2 : c.int, y2 : c.int, x3 : c.int, y3 : c.int, color : c.uintptr_t),
    drawRect : #type proc "c" (x : c.int, y : c.int, width : c.int, height : c.int, color : c.uintptr_t),
    fillRect : #type proc "c" (x : c.int, y : c.int, width : c.int, height : c.int, color : c.uintptr_t),
    drawEllipse : #type proc "c" (x : c.int, y : c.int, width : c.int, height : c.int, lineWidth : c.int, startAngle : c.float, endAngle : c.float, color : c.uintptr_t),
    fillEllipse : #type proc "c" (x : c.int, y : c.int, width : c.int, height : c.int, startAngle : c.float, endAngle : c.float, color : c.uintptr_t),
    drawScaledBitmap : #type proc "c" (bitmap : ^LCDBitmap, x : c.int, y : c.int, xscale : c.float, yscale : c.float),
    drawText : #type proc "c" (text : cstring, len : c.size_t, encoding : PDStringEncoding, x : c.int, y : c.int) -> c.int,
    newBitmap : #type proc "c" (width : c.int, height : c.int, bgcolor : c.uintptr_t) -> ^LCDBitmap,
    freeBitmap : #type proc "c" (unamed0 : ^LCDBitmap),
    loadBitmap : #type proc "c" (path : cstring, outerr : ^cstring) -> ^LCDBitmap,
    copyBitmap : #type proc "c" (bitmap : ^LCDBitmap) -> ^LCDBitmap,
    loadIntoBitmap : #type proc "c" (path : cstring, bitmap : ^LCDBitmap, outerr : ^cstring),
    getBitmapData : #type proc "c" (bitmap : ^LCDBitmap, width : ^c.int, height : ^c.int, rowbytes : ^c.int, mask : ^^u8, data : ^^u8),
    clearBitmap : #type proc "c" (bitmap : ^LCDBitmap, bgcolor : c.uintptr_t),
    rotatedBitmap : #type proc "c" (bitmap : ^LCDBitmap, rotation : c.float, xscale : c.float, yscale : c.float, allocedSize : ^c.int) -> ^LCDBitmap,
    newBitmapTable : #type proc "c" (count : c.int, width : c.int, height : c.int) -> ^LCDBitmapTable,
    freeBitmapTable : #type proc "c" (table : ^LCDBitmapTable),
    loadBitmapTable : #type proc "c" (path : cstring, outerr : ^cstring) -> ^LCDBitmapTable,
    loadIntoBitmapTable : #type proc "c" (path : cstring, table : ^LCDBitmapTable, outerr : ^cstring),
    getTableBitmap : #type proc "c" (table : ^LCDBitmapTable, idx : c.int) -> ^LCDBitmap,
    loadFont : #type proc "c" (path : cstring, outErr : ^cstring) -> ^LCDFont,
    getFontPage : #type proc "c" (font : ^LCDFont, character : u32) -> ^LCDFontPage,
    getPageGlyph : #type proc "c" (page : ^LCDFontPage, character : u32, bitmap : ^^LCDBitmap, advance : ^c.int) -> ^LCDFontGlyph,
    getGlyphKerning : #type proc "c" (glyph : ^LCDFontGlyph, glyphcode : u32, nextcode : u32) -> c.int,
    getTextWidth : #type proc "c" (font : ^LCDFont, text : rawptr, len : c.size_t, encoding : PDStringEncoding, tracking : c.int) -> c.int,
    getFrame : #type proc "c" () -> ^u8,
    getDisplayFrame : #type proc "c" () -> ^u8,
    getDebugBitmap : #type proc "c" () -> ^LCDBitmap,
    copyFrameBufferBitmap : #type proc "c" () -> ^LCDBitmap,
    markUpdatedRows : #type proc "c" (start : c.int, end : c.int),
    display : #type proc "c" (),
    setColorToPattern : #type proc "c" (color : ^c.uintptr_t, bitmap : ^LCDBitmap, x : c.int, y : c.int),
    checkMaskCollision : #type proc "c" (bitmap1 : ^LCDBitmap, x1 : c.int, y1 : c.int, flip1 : LCDBitmapFlip, bitmap2 : ^LCDBitmap, x2 : c.int, y2 : c.int, flip2 : LCDBitmapFlip, rect : LCDRect) -> c.int,
    setScreenClipRect : #type proc "c" (x : c.int, y : c.int, width : c.int, height : c.int),
    fillPolygon : #type proc "c" (nPoints : c.int, coords : ^c.int, color : c.uintptr_t, fillrule : LCDPolygonFillRule),
    getFontHeight : #type proc "c" (font : ^LCDFont) -> u8,
    getDisplayBufferBitmap : #type proc "c" () -> ^LCDBitmap,
    drawRotatedBitmap : #type proc "c" (bitmap : ^LCDBitmap, x : c.int, y : c.int, rotation : c.float, centerx : c.float, centery : c.float, xscale : c.float, yscale : c.float),
    setTextLeading : #type proc "c" (lineHeightAdustment : c.int),
    setBitmapMask : #type proc "c" (bitmap : ^LCDBitmap, mask : ^LCDBitmap) -> c.int,
    getBitmapMask : #type proc "c" (bitmap : ^LCDBitmap) -> ^LCDBitmap,
    setStencilImage : #type proc "c" (stencil : ^LCDBitmap, tile : c.int),
    makeFontFromData : #type proc "c" (data : ^LCDFontData, wide : c.int) -> ^LCDFont,
}

playdate_sprite :: struct {
    setAlwaysRedraw : #type proc "c" (flag : c.int),
    addDirtyRect : #type proc "c" (dirtyRect : LCDRect),
    drawSprites : #type proc "c" (),
    updateAndDrawSprites : #type proc "c" (),
    newSprite : #type proc "c" () -> ^LCDSprite,
    freeSprite : #type proc "c" (sprite : ^LCDSprite),
    copy : #type proc "c" (sprite : ^LCDSprite) -> ^LCDSprite,
    addSprite : #type proc "c" (sprite : ^LCDSprite),
    removeSprite : #type proc "c" (sprite : ^LCDSprite),
    removeSprites : #type proc "c" (sprites : ^^LCDSprite, count : c.int),
    removeAllSprites : #type proc "c" (),
    getSpriteCount : #type proc "c" () -> c.int,
    setBounds : #type proc "c" (sprite : ^LCDSprite, bounds : PDRect),
    getBounds : #type proc "c" (sprite : ^LCDSprite) -> PDRect,
    moveTo : #type proc "c" (sprite : ^LCDSprite, x : c.float, y : c.float),
    moveBy : #type proc "c" (sprite : ^LCDSprite, dx : c.float, dy : c.float),
    setImage : #type proc "c" (sprite : ^LCDSprite, image : ^LCDBitmap, flip : LCDBitmapFlip),
    getImage : #type proc "c" (sprite : ^LCDSprite) -> ^LCDBitmap,
    setSize : #type proc "c" (s : ^LCDSprite, width : c.float, height : c.float),
    setZIndex : #type proc "c" (sprite : ^LCDSprite, zIndex : i16),
    getZIndex : #type proc "c" (sprite : ^LCDSprite) -> i16,
    setDrawMode : #type proc "c" (sprite : ^LCDSprite, mode : LCDBitmapDrawMode),
    setImageFlip : #type proc "c" (sprite : ^LCDSprite, flip : LCDBitmapFlip),
    getImageFlip : #type proc "c" (sprite : ^LCDSprite) -> LCDBitmapFlip,
    setStencil : #type proc "c" (sprite : ^LCDSprite, stencil : ^LCDBitmap),
    setClipRect : #type proc "c" (sprite : ^LCDSprite, clipRect : LCDRect),
    clearClipRect : #type proc "c" (sprite : ^LCDSprite),
    setClipRectsInRange : #type proc "c" (clipRect : LCDRect, startZ : c.int, endZ : c.int),
    clearClipRectsInRange : #type proc "c" (startZ : c.int, endZ : c.int),
    setUpdatesEnabled : #type proc "c" (sprite : ^LCDSprite, flag : c.int),
    updatesEnabled : #type proc "c" (sprite : ^LCDSprite) -> c.int,
    setCollisionsEnabled : #type proc "c" (sprite : ^LCDSprite, flag : c.int),
    collisionsEnabled : #type proc "c" (sprite : ^LCDSprite) -> c.int,
    setVisible : #type proc "c" (sprite : ^LCDSprite, flag : c.int),
    isVisible : #type proc "c" (sprite : ^LCDSprite) -> c.int,
    setOpaque : #type proc "c" (sprite : ^LCDSprite, flag : c.int),
    markDirty : #type proc "c" (sprite : ^LCDSprite),
    setTag : #type proc "c" (sprite : ^LCDSprite, tag : u8),
    getTag : #type proc "c" (sprite : ^LCDSprite) -> u8,
    setIgnoresDrawOffset : #type proc "c" (sprite : ^LCDSprite, flag : c.int),
    setUpdateFunction : #type proc "c" (sprite : ^LCDSprite, func : LCDSpriteUpdateFunction),
    setDrawFunction : #type proc "c" (sprite : ^LCDSprite, func : LCDSpriteDrawFunction),
    getPosition : #type proc "c" (sprite : ^LCDSprite, x : ^c.float, y : ^c.float),
    resetCollisionWorld : #type proc "c" (),
    setCollideRect : #type proc "c" (sprite : ^LCDSprite, collideRect : PDRect),
    getCollideRect : #type proc "c" (sprite : ^LCDSprite) -> PDRect,
    clearCollideRect : #type proc "c" (sprite : ^LCDSprite),
    setCollisionResponseFunction : #type proc "c" (sprite : ^LCDSprite, func : ^LCDSpriteCollisionFilterProc),
    checkCollisions : #type proc "c" (sprite : ^LCDSprite, goalX : c.float, goalY : c.float, actualX : ^c.float, actualY : ^c.float, len : ^c.int) -> ^SpriteCollisionInfo,
    moveWithCollisions : #type proc "c" (sprite : ^LCDSprite, goalX : c.float, goalY : c.float, actualX : ^c.float, actualY : ^c.float, len : ^c.int) -> ^SpriteCollisionInfo,
    querySpritesAtPoint : #type proc "c" (x : c.float, y : c.float, len : ^c.int) -> ^^LCDSprite,
    querySpritesInRect : #type proc "c" (x : c.float, y : c.float, width : c.float, height : c.float, len : ^c.int) -> ^^LCDSprite,
    querySpritesAlongLine : #type proc "c" (x1 : c.float, y1 : c.float, x2 : c.float, y2 : c.float, len : ^c.int) -> ^^LCDSprite,
    querySpriteInfoAlongLine : #type proc "c" (x1 : c.float, y1 : c.float, x2 : c.float, y2 : c.float, len : ^c.int) -> ^SpriteQueryInfo,
    overlappingSprites : #type proc "c" (sprite : ^LCDSprite, len : ^c.int) -> ^^LCDSprite,
    allOverlappingSprites : #type proc "c" (len : ^c.int) -> ^^LCDSprite,
    setStencilPattern : #type proc "c" (sprite : ^LCDSprite, pattern : [8]u8),
    clearStencil : #type proc "c" (sprite : ^LCDSprite),
    setUserdata : #type proc "c" (sprite : ^LCDSprite, userdata : rawptr),
    getUserdata : #type proc "c" (sprite : ^LCDSprite) -> rawptr,
    setStencilImage : #type proc "c" (sprite : ^LCDSprite, stencil : ^LCDBitmap, tile : c.int),
}

playdate_display :: struct {
    getWidth : #type proc "c" () -> c.int,
    getHeight : #type proc "c" () -> c.int,
    setRefreshRate : #type proc "c" (rate : c.float),
    setInverted : #type proc "c" (flag : c.int),
    setScale : #type proc "c" (s : c.uint),
    setMosaic : #type proc "c" (x : c.uint, y : c.uint),
    setFlipped : #type proc "c" (x : c.int, y : c.int),
    setOffset : #type proc "c" (x : c.int, y : c.int),
}

playdate_sound :: struct {
    channel : ^playdate_soundchannel,
    fileplayer : ^playdate_sound_fileplayer,
    sample : ^playdate_sound_sample,
    sampleplayer : ^playdate_sound_sampleplayer,
    synth : ^playdate_sound_synth,
    sequence : ^playdate_sound_sequence,
    effect : ^playdate_sound_effect,
    lfo : ^playdate_sound_lfo,
    envelope : ^playdate_sound_envelope,
    source : ^playdate_sound_source,
    controlsignal : ^playdatecontrol_signal,
    track : ^playdate_sound_track,
    instrument : ^playdate_sound_instrument,
    getCurrentTime : #type proc "c" () -> u32,
    addSource : #type proc "c" (callback : ^AudioSourceFunction, ctx : rawptr, stereo : c.int) -> ^SoundSource,
    getDefaultChannel : #type proc "c" () -> ^SoundChannel,
    addChannel : #type proc "c" (channel : ^SoundChannel) -> c.int,
    removeChannel : #type proc "c" (channel : ^SoundChannel) -> c.int,
    setMicCallback : #type proc "c" (callback : ^RecordCallback, ctx : rawptr, forceInternal : c.int),
    getHeadphoneState : #type proc "c" (headphone : ^c.int, headsetmic : ^c.int, unamed0 : #type proc "c" (headphone : c.int, mic : c.int)),
    setOutputsActive : #type proc "c" (headphone : c.int, speaker : c.int),
    removeSource : #type proc "c" (source : ^SoundSource) -> c.int,
    signal : ^playdate_sound_signal,
}

playdate_lua :: struct {
    addFunction : #type proc "c" (f : lua_CFunction, name : cstring, outErr : ^cstring) -> c.int,
    registerClass : #type proc "c" (name : cstring, reg : ^lua_reg, vals : ^lua_val, isstatic : c.int, outErr : ^cstring) -> c.int,
    pushFunction : #type proc "c" (f : lua_CFunction),
    indexMetatable : #type proc "c" () -> c.int,
    stop : #type proc "c" (),
    start : #type proc "c" (),
    getArgCount : #type proc "c" () -> c.int,
    getArgType : #type proc "c" (pos : c.int, outClass : ^cstring) -> LuaType,
    argIsNil : #type proc "c" (pos : c.int) -> c.int,
    getArgBool : #type proc "c" (pos : c.int) -> c.int,
    getArgInt : #type proc "c" (pos : c.int) -> c.int,
    getArgFloat : #type proc "c" (pos : c.int) -> c.float,
    getArgString : #type proc "c" (pos : c.int) -> cstring,
    getArgBytes : #type proc "c" (pos : c.int, outlen : ^c.size_t) -> cstring,
    getArgObject : #type proc "c" (pos : c.int, type : cstring, outud : ^^LuaUDObject) -> rawptr,
    getBitmap : #type proc "c" (pos : c.int) -> ^LCDBitmap,
    getSprite : #type proc "c" (pos : c.int) -> ^LCDSprite,
    pushNil : #type proc "c" (),
    pushBool : #type proc "c" (val : c.int),
    pushInt : #type proc "c" (val : c.int),
    pushFloat : #type proc "c" (val : c.float),
    pushString : #type proc "c" (str : cstring),
    pushBytes : #type proc "c" (str : cstring, len : c.size_t),
    pushBitmap : #type proc "c" (bitmap : ^LCDBitmap),
    pushSprite : #type proc "c" (sprite : ^LCDSprite),
    pushObject : #type proc "c" (obj : rawptr, type : cstring, nValues : c.int) -> ^LuaUDObject,
    retainObject : #type proc "c" (obj : ^LuaUDObject) -> ^LuaUDObject,
    releaseObject : #type proc "c" (obj : ^LuaUDObject),
    setUserValue : #type proc "c" (obj : ^LuaUDObject, slot : c.uint),
    getUserValue : #type proc "c" (obj : ^LuaUDObject, slot : c.uint) -> c.int,
    callFunction_deprecated : #type proc "c" (name : cstring, nargs : c.int),
    callFunction : #type proc "c" (name : cstring, nargs : c.int, outerr : ^cstring) -> c.int,
}

playdate_json :: struct {}

playdate_scoreboards :: struct {
    addScore : #type proc "c" (boardId : cstring, value : u32, callback : AddScoreCallback) -> c.int,
    getPersonalBest : #type proc "c" (boardId : cstring, callback : PersonalBestCallback) -> c.int,
    freeScore : #type proc "c" (score : ^PDScore),
    getScoreboards : #type proc "c" (callback : BoardsListCallback) -> c.int,
    freeBoardsList : #type proc "c" (boardsList : ^PDBoardsList),
    getScores : #type proc "c" (boardId : cstring, callback : ScoresCallback) -> c.int,
    freeScoresList : #type proc "c" (scoresList : ^PDScoresList),
}

FileStat :: struct {
    isdir : c.int,
    size : c.uint,
    m_year : c.int,
    m_month : c.int,
    m_day : c.int,
    m_hour : c.int,
    m_minute : c.int,
    m_second : c.int,
}

LCDRect :: struct {
    left : c.int,
    right : c.int,
    top : c.int,
    bottom : c.int,
}

LCDBitmap :: struct {}

LCDBitmapTable :: struct {}

LCDFont :: struct {}

LCDFontData :: struct {}

LCDFontPage :: struct {}

LCDFontGlyph :: struct {}

LCDVideoPlayer :: struct {}

playdate_video :: struct {
    loadVideo : #type proc "c" (path : cstring) -> ^LCDVideoPlayer,
    freePlayer : #type proc "c" (p : ^LCDVideoPlayer),
    setContext : #type proc "c" (p : ^LCDVideoPlayer, ctx : ^LCDBitmap) -> c.int,
    useScreenContext : #type proc "c" (p : ^LCDVideoPlayer),
    renderFrame : #type proc "c" (p : ^LCDVideoPlayer, n : c.int) -> c.int,
    getError : #type proc "c" (p : ^LCDVideoPlayer) -> cstring,
    getInfo : #type proc "c" (p : ^LCDVideoPlayer, outWidth : ^c.int, outHeight : ^c.int, outFrameRate : ^c.float, outFrameCount : ^c.int, outCurrentFrame : ^c.int),
    getContext : #type proc "c" (p : ^LCDVideoPlayer) -> ^LCDBitmap,
}

LuaUDObject :: struct {}

LCDSprite :: struct {}

lua_reg :: struct {
    name : cstring,
    func : lua_CFunction,
}

lua_val :: struct {
    name : cstring,
    type : l_valtype,
    v : AnonymousUnion0,
}

PDScore :: struct {
    rank : u32,
    value : u32,
    player : cstring,
}

PDScoresList :: struct {
    boardID : cstring,
    count : c.uint,
    lastUpdated : u32,
    playerIncluded : c.int,
    limit : c.uint,
    scores : ^PDScore,
}

PDBoard :: struct {
    boardID : cstring,
    name : cstring,
}

PDBoardsList :: struct {
    count : c.uint,
    lastUpdated : u32,
    boards : ^PDBoard,
}

SoundSource :: struct {}

playdate_sound_source :: struct {
    setVolume : #type proc "c" (channel : ^SoundSource, lvol : c.float, rvol : c.float),
    getVolume : #type proc "c" (channel : ^SoundSource, outl : ^c.float, outr : ^c.float),
    isPlaying : #type proc "c" (channel : ^SoundSource) -> c.int,
    setFinishCallback : #type proc "c" (channel : ^SoundSource, callback : sndCallbackProc),
}

FilePlayer :: struct {}

playdate_sound_fileplayer :: struct {
    newPlayer : #type proc "c" () -> ^FilePlayer,
    freePlayer : #type proc "c" (player : ^FilePlayer),
    loadIntoPlayer : #type proc "c" (player : ^FilePlayer, path : cstring) -> c.int,
    setBufferLength : #type proc "c" (player : ^FilePlayer, bufferLen : c.float),
    play : #type proc "c" (player : ^FilePlayer, repeat : c.int) -> c.int,
    isPlaying : #type proc "c" (player : ^FilePlayer) -> c.int,
    pause : #type proc "c" (player : ^FilePlayer),
    stop : #type proc "c" (player : ^FilePlayer),
    setVolume : #type proc "c" (player : ^FilePlayer, left : c.float, right : c.float),
    getVolume : #type proc "c" (player : ^FilePlayer, left : ^c.float, right : ^c.float),
    getLength : #type proc "c" (player : ^FilePlayer) -> c.float,
    setOffset : #type proc "c" (player : ^FilePlayer, offset : c.float),
    setRate : #type proc "c" (player : ^FilePlayer, rate : c.float),
    setLoopRange : #type proc "c" (player : ^FilePlayer, start : c.float, end : c.float),
    didUnderrun : #type proc "c" (player : ^FilePlayer) -> c.int,
    setFinishCallback : #type proc "c" (player : ^FilePlayer, callback : sndCallbackProc),
    setLoopCallback : #type proc "c" (player : ^FilePlayer, callback : sndCallbackProc),
    getOffset : #type proc "c" (player : ^FilePlayer) -> c.float,
    getRate : #type proc "c" (player : ^FilePlayer) -> c.float,
    setStopOnUnderrun : #type proc "c" (player : ^FilePlayer, flag : c.int),
    fadeVolume : #type proc "c" (player : ^FilePlayer, left : c.float, right : c.float, len : i32, finishCallback : sndCallbackProc),
    setMP3StreamSource : #type proc "c" (player : ^FilePlayer, unamed0 : #type proc "c" (data : ^u8, bytes : c.int, userdata : rawptr) -> c.int, userdata : rawptr, bufferLen : c.float),
}

AudioSample :: struct {}

SamplePlayer :: struct {}

playdate_sound_sample :: struct {
    newSampleBuffer : #type proc "c" (byteCount : c.int) -> ^AudioSample,
    loadIntoSample : #type proc "c" (sample : ^AudioSample, path : cstring) -> c.int,
    load : #type proc "c" (path : cstring) -> ^AudioSample,
    newSampleFromData : #type proc "c" (data : ^u8, format : SoundFormat, sampleRate : u32, byteCount : c.int) -> ^AudioSample,
    getData : #type proc "c" (sample : ^AudioSample, data : ^^u8, format : ^SoundFormat, sampleRate : ^u32, bytelength : ^u32),
    freeSample : #type proc "c" (sample : ^AudioSample),
    getLength : #type proc "c" (sample : ^AudioSample) -> c.float,
}

playdate_sound_sampleplayer :: struct {
    newPlayer : #type proc "c" () -> ^SamplePlayer,
    freePlayer : #type proc "c" (player : ^SamplePlayer),
    setSample : #type proc "c" (player : ^SamplePlayer, sample : ^AudioSample),
    play : #type proc "c" (player : ^SamplePlayer, repeat : c.int, rate : c.float) -> c.int,
    isPlaying : #type proc "c" (player : ^SamplePlayer) -> c.int,
    stop : #type proc "c" (player : ^SamplePlayer),
    setVolume : #type proc "c" (player : ^SamplePlayer, left : c.float, right : c.float),
    getVolume : #type proc "c" (player : ^SamplePlayer, left : ^c.float, right : ^c.float),
    getLength : #type proc "c" (player : ^SamplePlayer) -> c.float,
    setOffset : #type proc "c" (player : ^SamplePlayer, offset : c.float),
    setRate : #type proc "c" (player : ^SamplePlayer, rate : c.float),
    setPlayRange : #type proc "c" (player : ^SamplePlayer, start : c.int, end : c.int),
    setFinishCallback : #type proc "c" (player : ^SamplePlayer, callback : sndCallbackProc),
    setLoopCallback : #type proc "c" (player : ^SamplePlayer, callback : sndCallbackProc),
    getOffset : #type proc "c" (player : ^SamplePlayer) -> c.float,
    getRate : #type proc "c" (player : ^SamplePlayer) -> c.float,
    setPaused : #type proc "c" (player : ^SamplePlayer, flag : c.int),
}

PDSynthSignalValue :: struct {}

PDSynthSignal :: struct {}

playdate_sound_signal :: struct {
    newSignal : #type proc "c" (step : signalStepFunc, noteOn : signalNoteOnFunc, noteOff : signalNoteOffFunc, dealloc : signalDeallocFunc, userdata : rawptr) -> ^PDSynthSignal,
    freeSignal : #type proc "c" (signal : ^PDSynthSignal),
    getValue : #type proc "c" (signal : ^PDSynthSignal) -> c.float,
    setValueScale : #type proc "c" (signal : ^PDSynthSignal, scale : c.float),
    setValueOffset : #type proc "c" (signal : ^PDSynthSignal, offset : c.float),
}

PDSynthLFO :: struct {}

playdate_sound_lfo :: struct {
    newLFO : #type proc "c" (type : LFOType) -> ^PDSynthLFO,
    freeLFO : #type proc "c" (lfo : ^PDSynthLFO),
    setType : #type proc "c" (lfo : ^PDSynthLFO, type : LFOType),
    setRate : #type proc "c" (lfo : ^PDSynthLFO, rate : c.float),
    setPhase : #type proc "c" (lfo : ^PDSynthLFO, phase : c.float),
    setCenter : #type proc "c" (lfo : ^PDSynthLFO, center : c.float),
    setDepth : #type proc "c" (lfo : ^PDSynthLFO, depth : c.float),
    setArpeggiation : #type proc "c" (lfo : ^PDSynthLFO, nSteps : c.int, steps : ^c.float),
    setFunction : #type proc "c" (lfo : ^PDSynthLFO, unamed0 : #type proc "c" (lfo : ^PDSynthLFO, userdata : rawptr) -> c.float, userdata : rawptr, interpolate : c.int),
    setDelay : #type proc "c" (lfo : ^PDSynthLFO, holdoff : c.float, ramptime : c.float),
    setRetrigger : #type proc "c" (lfo : ^PDSynthLFO, flag : c.int),
    getValue : #type proc "c" (lfo : ^PDSynthLFO) -> c.float,
    setGlobal : #type proc "c" (lfo : ^PDSynthLFO, global : c.int),
}

PDSynthEnvelope :: struct {}

playdate_sound_envelope :: struct {
    newEnvelope : #type proc "c" (attack : c.float, decay : c.float, sustain : c.float, release : c.float) -> ^PDSynthEnvelope,
    freeEnvelope : #type proc "c" (env : ^PDSynthEnvelope),
    setAttack : #type proc "c" (env : ^PDSynthEnvelope, attack : c.float),
    setDecay : #type proc "c" (env : ^PDSynthEnvelope, decay : c.float),
    setSustain : #type proc "c" (env : ^PDSynthEnvelope, sustain : c.float),
    setRelease : #type proc "c" (env : ^PDSynthEnvelope, release : c.float),
    setLegato : #type proc "c" (env : ^PDSynthEnvelope, flag : c.int),
    setRetrigger : #type proc "c" (lfo : ^PDSynthEnvelope, flag : c.int),
    getValue : #type proc "c" (env : ^PDSynthEnvelope) -> c.float,
    setCurvature : #type proc "c" (env : ^PDSynthEnvelope, amount : c.float),
    setVelocitySensitivity : #type proc "c" (env : ^PDSynthEnvelope, velsens : c.float),
    setRateScaling : #type proc "c" (env : ^PDSynthEnvelope, scaling : c.float, start : c.float, end : c.float),
}

PDSynth :: struct {}

playdate_sound_synth :: struct {
    newSynth : #type proc "c" () -> ^PDSynth,
    freeSynth : #type proc "c" (synth : ^PDSynth),
    setWaveform : #type proc "c" (synth : ^PDSynth, wave : SoundWaveform),
    setGenerator : #type proc "c" (synth : ^PDSynth, stereo : c.int, render : synthRenderFunc, noteOn : synthNoteOnFunc, release : synthReleaseFunc, setparam : synthSetParameterFunc, dealloc : synthDeallocFunc, userdata : rawptr),
    setSample : #type proc "c" (synth : ^PDSynth, sample : ^AudioSample, sustainStart : u32, sustainEnd : u32),
    setAttackTime : #type proc "c" (synth : ^PDSynth, attack : c.float),
    setDecayTime : #type proc "c" (synth : ^PDSynth, decay : c.float),
    setSustainLevel : #type proc "c" (synth : ^PDSynth, sustain : c.float),
    setReleaseTime : #type proc "c" (synth : ^PDSynth, release : c.float),
    setTranspose : #type proc "c" (synth : ^PDSynth, halfSteps : c.float),
    setFrequencyModulator : #type proc "c" (synth : ^PDSynth, mod : ^PDSynthSignalValue),
    getFrequencyModulator : #type proc "c" (synth : ^PDSynth) -> ^PDSynthSignalValue,
    setAmplitudeModulator : #type proc "c" (synth : ^PDSynth, mod : ^PDSynthSignalValue),
    getAmplitudeModulator : #type proc "c" (synth : ^PDSynth) -> ^PDSynthSignalValue,
    getParameterCount : #type proc "c" (synth : ^PDSynth) -> c.int,
    setParameter : #type proc "c" (synth : ^PDSynth, parameter : c.int, value : c.float) -> c.int,
    setParameterModulator : #type proc "c" (synth : ^PDSynth, parameter : c.int, mod : ^PDSynthSignalValue),
    getParameterModulator : #type proc "c" (synth : ^PDSynth, parameter : c.int) -> ^PDSynthSignalValue,
    playNote : #type proc "c" (synth : ^PDSynth, freq : c.float, vel : c.float, len : c.float, _when : u32),
    playMIDINote : #type proc "c" (synth : ^PDSynth, note : c.float, vel : c.float, len : c.float, _when : u32),
    noteOff : #type proc "c" (synth : ^PDSynth, _when : u32),
    stop : #type proc "c" (synth : ^PDSynth),
    setVolume : #type proc "c" (synth : ^PDSynth, left : c.float, right : c.float),
    getVolume : #type proc "c" (synth : ^PDSynth, left : ^c.float, right : ^c.float),
    isPlaying : #type proc "c" (synth : ^PDSynth) -> c.int,
    getEnvelope : #type proc "c" (synth : ^PDSynth) -> ^PDSynthEnvelope,
}

ControlSignal :: struct {}

playdatecontrol_signal :: struct {
    newSignal : #type proc "c" () -> ^ControlSignal,
    freeSignal : #type proc "c" (signal : ^ControlSignal),
    clearEvents : #type proc "c" (control : ^ControlSignal),
    addEvent : #type proc "c" (control : ^ControlSignal, step : c.int, value : c.float, interpolate : c.int),
    removeEvent : #type proc "c" (control : ^ControlSignal, step : c.int),
    getMIDIControllerNumber : #type proc "c" (control : ^ControlSignal) -> c.int,
}

PDSynthInstrument :: struct {}

playdate_sound_instrument :: struct {
    newInstrument : #type proc "c" () -> ^PDSynthInstrument,
    freeInstrument : #type proc "c" (inst : ^PDSynthInstrument),
    addVoice : #type proc "c" (inst : ^PDSynthInstrument, synth : ^PDSynth, rangeStart : c.float, rangeEnd : c.float, transpose : c.float) -> c.int,
    playNote : #type proc "c" (inst : ^PDSynthInstrument, frequency : c.float, vel : c.float, len : c.float, _when : u32) -> ^PDSynth,
    playMIDINote : #type proc "c" (inst : ^PDSynthInstrument, note : c.float, vel : c.float, len : c.float, _when : u32) -> ^PDSynth,
    setPitchBend : #type proc "c" (inst : ^PDSynthInstrument, bend : c.float),
    setPitchBendRange : #type proc "c" (inst : ^PDSynthInstrument, halfSteps : c.float),
    setTranspose : #type proc "c" (inst : ^PDSynthInstrument, halfSteps : c.float),
    noteOff : #type proc "c" (inst : ^PDSynthInstrument, note : c.float, _when : u32),
    allNotesOff : #type proc "c" (inst : ^PDSynthInstrument, _when : u32),
    setVolume : #type proc "c" (inst : ^PDSynthInstrument, left : c.float, right : c.float),
    getVolume : #type proc "c" (inst : ^PDSynthInstrument, left : ^c.float, right : ^c.float),
    activeVoiceCount : #type proc "c" (inst : ^PDSynthInstrument) -> c.int,
}

SequenceTrack :: struct {}

playdate_sound_track :: struct {
    newTrack : #type proc "c" () -> ^SequenceTrack,
    freeTrack : #type proc "c" (track : ^SequenceTrack),
    setInstrument : #type proc "c" (track : ^SequenceTrack, inst : ^PDSynthInstrument),
    getInstrument : #type proc "c" (track : ^SequenceTrack) -> ^PDSynthInstrument,
    addNoteEvent : #type proc "c" (track : ^SequenceTrack, step : u32, len : u32, note : c.float, velocity : c.float),
    removeNoteEvent : #type proc "c" (track : ^SequenceTrack, step : u32, note : c.float),
    clearNotes : #type proc "c" (track : ^SequenceTrack),
    getControlSignalCount : #type proc "c" (track : ^SequenceTrack) -> c.int,
    getControlSignal : #type proc "c" (track : ^SequenceTrack, idx : c.int) -> ^ControlSignal,
    clearControlEvents : #type proc "c" (track : ^SequenceTrack),
    getPolyphony : #type proc "c" (track : ^SequenceTrack) -> c.int,
    activeVoiceCount : #type proc "c" (track : ^SequenceTrack) -> c.int,
    setMuted : #type proc "c" (track : ^SequenceTrack, mute : c.int),
    getLength : #type proc "c" (track : ^SequenceTrack) -> u32,
    getIndexForStep : #type proc "c" (track : ^SequenceTrack, step : u32) -> c.int,
    getNoteAtIndex : #type proc "c" (track : ^SequenceTrack, index : c.int, outStep : ^u32, outLen : ^u32, outNote : ^c.float, outVelocity : ^c.float) -> c.int,
    getSignalForController : #type proc "c" (track : ^SequenceTrack, controller : c.int, create : c.int) -> ^ControlSignal,
}

SoundSequence :: struct {}

playdate_sound_sequence :: struct {
    newSequence : #type proc "c" () -> ^SoundSequence,
    freeSequence : #type proc "c" (sequence : ^SoundSequence),
    loadMidiFile : #type proc "c" (seq : ^SoundSequence, path : cstring) -> c.int,
    getTime : #type proc "c" (seq : ^SoundSequence) -> u32,
    setTime : #type proc "c" (seq : ^SoundSequence, time : u32),
    setLoops : #type proc "c" (seq : ^SoundSequence, loopstart : c.int, loopend : c.int, loops : c.int),
    getTempo : #type proc "c" (seq : ^SoundSequence) -> c.int,
    setTempo : #type proc "c" (seq : ^SoundSequence, stepsPerSecond : c.int),
    getTrackCount : #type proc "c" (seq : ^SoundSequence) -> c.int,
    addTrack : #type proc "c" (seq : ^SoundSequence) -> ^SequenceTrack,
    getTrackAtIndex : #type proc "c" (seq : ^SoundSequence, track : c.uint) -> ^SequenceTrack,
    setTrackAtIndex : #type proc "c" (seq : ^SoundSequence, track : ^SequenceTrack, idx : c.uint),
    allNotesOff : #type proc "c" (seq : ^SoundSequence),
    isPlaying : #type proc "c" (seq : ^SoundSequence) -> c.int,
    getLength : #type proc "c" (seq : ^SoundSequence) -> u32,
    play : #type proc "c" (seq : ^SoundSequence, finishCallback : SequenceFinishedCallback, userdata : rawptr),
    stop : #type proc "c" (seq : ^SoundSequence),
    getCurrentStep : #type proc "c" (seq : ^SoundSequence, timeOffset : ^c.int) -> c.int,
    setCurrentStep : #type proc "c" (seq : ^SoundSequence, step : c.int, timeOffset : c.int, playNotes : c.int),
}

TwoPoleFilter :: struct {}

playdate_sound_effect_twopolefilter :: struct {
    newFilter : #type proc "c" () -> ^TwoPoleFilter,
    freeFilter : #type proc "c" (filter : ^TwoPoleFilter),
    setType : #type proc "c" (filter : ^TwoPoleFilter, type : TwoPoleFilterType),
    setFrequency : #type proc "c" (filter : ^TwoPoleFilter, frequency : c.float),
    setFrequencyModulator : #type proc "c" (filter : ^TwoPoleFilter, signal : ^PDSynthSignalValue),
    getFrequencyModulator : #type proc "c" (filter : ^TwoPoleFilter) -> ^PDSynthSignalValue,
    setGain : #type proc "c" (filter : ^TwoPoleFilter, gain : c.float),
    setResonance : #type proc "c" (filter : ^TwoPoleFilter, resonance : c.float),
    setResonanceModulator : #type proc "c" (filter : ^TwoPoleFilter, signal : ^PDSynthSignalValue),
    getResonanceModulator : #type proc "c" (filter : ^TwoPoleFilter) -> ^PDSynthSignalValue,
}

OnePoleFilter :: struct {}

playdate_sound_effect_onepolefilter :: struct {
    newFilter : #type proc "c" () -> ^OnePoleFilter,
    freeFilter : #type proc "c" (filter : ^OnePoleFilter),
    setParameter : #type proc "c" (filter : ^OnePoleFilter, parameter : c.float),
    setParameterModulator : #type proc "c" (filter : ^OnePoleFilter, signal : ^PDSynthSignalValue),
    getParameterModulator : #type proc "c" (filter : ^OnePoleFilter) -> ^PDSynthSignalValue,
}

BitCrusher :: struct {}

playdate_sound_effect_bitcrusher :: struct {
    newBitCrusher : #type proc "c" () -> ^BitCrusher,
    freeBitCrusher : #type proc "c" (filter : ^BitCrusher),
    setAmount : #type proc "c" (filter : ^BitCrusher, amount : c.float),
    setAmountModulator : #type proc "c" (filter : ^BitCrusher, signal : ^PDSynthSignalValue),
    getAmountModulator : #type proc "c" (filter : ^BitCrusher) -> ^PDSynthSignalValue,
    setUndersampling : #type proc "c" (filter : ^BitCrusher, undersampling : c.float),
    setUndersampleModulator : #type proc "c" (filter : ^BitCrusher, signal : ^PDSynthSignalValue),
    getUndersampleModulator : #type proc "c" (filter : ^BitCrusher) -> ^PDSynthSignalValue,
}

RingModulator :: struct {}

playdate_sound_effect_ringmodulator :: struct {
    newRingmod : #type proc "c" () -> ^RingModulator,
    freeRingmod : #type proc "c" (filter : ^RingModulator),
    setFrequency : #type proc "c" (filter : ^RingModulator, frequency : c.float),
    setFrequencyModulator : #type proc "c" (filter : ^RingModulator, signal : ^PDSynthSignalValue),
    getFrequencyModulator : #type proc "c" (filter : ^RingModulator) -> ^PDSynthSignalValue,
}

DelayLine :: struct {}

DelayLineTap :: struct {}

playdate_sound_effect_delayline :: struct {
    newDelayLine : #type proc "c" (length : c.int, stereo : c.int) -> ^DelayLine,
    freeDelayLine : #type proc "c" (filter : ^DelayLine),
    setLength : #type proc "c" (d : ^DelayLine, frames : c.int),
    setFeedback : #type proc "c" (d : ^DelayLine, fb : c.float),
    addTap : #type proc "c" (d : ^DelayLine, delay : c.int) -> ^DelayLineTap,
    freeTap : #type proc "c" (tap : ^DelayLineTap),
    setTapDelay : #type proc "c" (t : ^DelayLineTap, frames : c.int),
    setTapDelayModulator : #type proc "c" (t : ^DelayLineTap, mod : ^PDSynthSignalValue),
    getTapDelayModulator : #type proc "c" (t : ^DelayLineTap) -> ^PDSynthSignalValue,
    setTapChannelsFlipped : #type proc "c" (t : ^DelayLineTap, flip : c.int),
}

Overdrive :: struct {}

playdate_sound_effect_overdrive :: struct {
    newOverdrive : #type proc "c" () -> ^Overdrive,
    freeOverdrive : #type proc "c" (filter : ^Overdrive),
    setGain : #type proc "c" (o : ^Overdrive, gain : c.float),
    setLimit : #type proc "c" (o : ^Overdrive, limit : c.float),
    setLimitModulator : #type proc "c" (o : ^Overdrive, mod : ^PDSynthSignalValue),
    getLimitModulator : #type proc "c" (o : ^Overdrive) -> ^PDSynthSignalValue,
    setOffset : #type proc "c" (o : ^Overdrive, offset : c.float),
    setOffsetModulator : #type proc "c" (o : ^Overdrive, mod : ^PDSynthSignalValue),
    getOffsetModulator : #type proc "c" (o : ^Overdrive) -> ^PDSynthSignalValue,
}

SoundEffect :: struct {}

playdate_sound_effect :: struct {
    newEffect : #type proc "c" (_proc : ^effectProc, userdata : rawptr) -> ^SoundEffect,
    freeEffect : #type proc "c" (effect : ^SoundEffect),
    setMix : #type proc "c" (effect : ^SoundEffect, level : c.float),
    setMixModulator : #type proc "c" (effect : ^SoundEffect, signal : ^PDSynthSignalValue),
    getMixModulator : #type proc "c" (effect : ^SoundEffect) -> ^PDSynthSignalValue,
    setUserdata : #type proc "c" (effect : ^SoundEffect, userdata : rawptr),
    getUserdata : #type proc "c" (effect : ^SoundEffect) -> rawptr,
    twopolefilter : ^playdate_sound_effect_twopolefilter,
    onepolefilter : ^playdate_sound_effect_onepolefilter,
    bitcrusher : ^playdate_sound_effect_bitcrusher,
    ringmodulator : ^playdate_sound_effect_ringmodulator,
    delayline : ^playdate_sound_effect_delayline,
    overdrive : ^playdate_sound_effect_overdrive,
}

SoundChannel :: struct {}

playdate_soundchannel :: struct {
    newChannel : #type proc "c" () -> ^SoundChannel,
    freeChannel : #type proc "c" (channel : ^SoundChannel),
    addSource : #type proc "c" (channel : ^SoundChannel, source : ^SoundSource) -> c.int,
    removeSource : #type proc "c" (channel : ^SoundChannel, source : ^SoundSource) -> c.int,
    addCallbackSource : #type proc "c" (channel : ^SoundChannel, callback : ^AudioSourceFunction, ctx : rawptr, stereo : c.int) -> ^SoundSource,
    addEffect : #type proc "c" (channel : ^SoundChannel, effect : ^SoundEffect),
    removeEffect : #type proc "c" (channel : ^SoundChannel, effect : ^SoundEffect),
    setVolume : #type proc "c" (channel : ^SoundChannel, volume : c.float),
    getVolume : #type proc "c" (channel : ^SoundChannel) -> c.float,
    setVolumeModulator : #type proc "c" (channel : ^SoundChannel, mod : ^PDSynthSignalValue),
    getVolumeModulator : #type proc "c" (channel : ^SoundChannel) -> ^PDSynthSignalValue,
    setPan : #type proc "c" (channel : ^SoundChannel, pan : c.float),
    setPanModulator : #type proc "c" (channel : ^SoundChannel, mod : ^PDSynthSignalValue),
    getPanModulator : #type proc "c" (channel : ^SoundChannel) -> ^PDSynthSignalValue,
    getDryLevelSignal : #type proc "c" (channel : ^SoundChannel) -> ^PDSynthSignalValue,
    getWetLevelSignal : #type proc "c" (channel : ^SoundChannel) -> ^PDSynthSignalValue,
}

PDRect :: struct {
    x : c.float,
    y : c.float,
    width : c.float,
    height : c.float,
}

CollisionPoint :: struct {
    x : c.float,
    y : c.float,
}

CollisionVector :: struct {
    x : c.int,
    y : c.int,
}

SpriteCollisionInfo :: struct {
    sprite : ^LCDSprite,
    other : ^LCDSprite,
    responseType : SpriteCollisionResponseType,
    overlaps : u8,
    ti : c.float,
    move : CollisionPoint,
    normal : CollisionVector,
    touch : CollisionPoint,
    spriteRect : PDRect,
    otherRect : PDRect,
}

SpriteQueryInfo :: struct {
    sprite : ^LCDSprite,
    ti1 : c.float,
    ti2 : c.float,
    entryPoint : CollisionPoint,
    exitPoint : CollisionPoint,
}

CWCollisionInfo :: struct {}

CWItemInfo :: struct {}

PDDateTime :: struct {
    year : u16,
    month : u8,
    day : u8,
    weekday : u8,
    hour : u8,
    minute : u8,
    second : u8,
}

PDMenuItem :: struct {}

AnonymousUnion0 :: struct #raw_union {
    intval : c.uint,
    floatval : c.float,
    strval : cstring,
}

@(default_calling_convention="c")
foreign pd_api {

    @(link_name="eventHandler")
    eventHandler :: proc(playdate : ^PlaydateAPI, event : PDSystemEvent, arg : u32) -> c.int ---

    @(link_name="LCDMakeRect")
    LCDMakeRect :: proc(x : c.int, y : c.int, width : c.int, height : c.int) -> LCDRect ---

    @(link_name="LCDRect_translate")
    LCDRect_translate :: proc(r : LCDRect, dx : c.int, dy : c.int) -> LCDRect ---

    @(link_name="SoundFormat_bytesPerFrame")
    SoundFormat_bytesPerFrame :: proc(fmt : SoundFormat) -> u32 ---

    @(link_name="pd_noteToFrequency")
    pd_noteToFrequency :: proc(n : c.float) -> c.float ---

    @(link_name="pd_frequencyToNote")
    pd_frequencyToNote :: proc(f : c.float) -> c.float ---

    // @(link_name="PDRectMake")
    // PDRectMake :: proc(x : c.float, y : c.float, width : c.float, height : c.float) -> PDRect ---
}

PDRectMake :: proc(x : c.float, y : c.float, width : c.float, height : c.float) -> PDRect {
    r : PDRect = { x = x, y = y, width = width, height = height }
    return r
}