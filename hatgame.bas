;   Author: Zinadine M. L.

    playfield:
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    X.............X.X..............X
    X.............XXX..............X
    X..............................X
    X..............................X
    X..............................X
    X..............................X
    X..............................X
    X.............XXX..............X
    X.............X.X..............X
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end

;   Constants
    const WHITE = $0E
    const YELLOW = $1E
    COLUPF = YELLOW
;   Main loop
mainloop
    drawscreen

    goto mainloop


