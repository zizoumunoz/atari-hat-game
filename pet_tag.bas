; PET TAG for the Atari 2600

    ; Set assembler to use NTSC Northamerican format.
    set tv ntsc
    
    ; Remove spaces between playfield blocks
    set kernel_options no_blank_lines

    ; Sets the playfield to use p0 color on the right and p1 color on the left.
    CTRLPF = $23

; ======== PLAYFIELD ====
    playfield:
    ..XXXXXXXXXXXXXXXXXXXXXXXXXXXX..
    ..X.............................
    ..X............X.........XX..X..
    ..X..X..XX........XX..X..XX..X..
    ..X..X...X.....X.............X..
    ..X..X..XX.....XXXXXXXXXXXXXXX..
    ..X............X.........XX.....
    .......XXXXXX.....XX..X..XX..X..
    ..X....X.......X......X......X..
    ..XXXXXX.XXXXXXXXXXXXXXXXXXXXX..
    ................................ 
end

; ======== PLAYER SPRITES ========

    player0:
    %00100010
    %00101010
    %00111111
    %00111111
    %11110001
    %01110011
    %01010000
end

; ======== CONSTANTS : COLORS ========
    const WHITE = $0F
    const PURPLE = $6A
    const GREEN = $BE
    const YELLOW = $1E

; ======== VARIABLE DECLARATIONS ========
    a = 0
    dim _old0x = a
    b = 0
    dim _old0y = b

; ======== PLAYER DATA INITIALIZERS ========

    player0x = 120
    player0y = 39

; ================================================
;                  SUB-ROUTINES
; ================================================



; ================================================
;                  MAIN LOOP
; ================================================
__main

    COLUP0 = PURPLE
    COLUP1 = GREEN
    COLUPF = YELLOW
    PF0 = %11110000

    gosub __handleInput

    drawscreen
    goto __main

__handleInput
    rem -- Storing old positions for later
    _old0x = player0x
    _old0y = player0y

    rem -- player0 movement
    if joy0right then player0x = player0x + 1 : REFP0 = 8
    return
