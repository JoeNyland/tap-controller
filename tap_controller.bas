#picaxe 18a

; Define output pins as symbols
symbol BLUE_LED   = B.2         ; Blue LED.
symbol AMBER_LED  = B.1         ; Amber LED.
symbol RED_LED    = B.0         ; Red LED.
symbol PIEZO      = B.3         ; Piezo speaker.
symbol COLD_SERVO = B.5         ; Cold tap servo.
symbol HOT_SERVO  = B.4         ; Hot tap servo.

; Define input pins as symbols
symbol THERMISTOR     = C.0     ; Detect the current temperature of the water.
symbol POTENTIOMETER  = C.1     ; Preset the temperature you would like the water to be.
symbol START_BTN      = pin7    ; Start filling button.
symbol STOP_BTN       = pin6    ; Stop filling button.

; Store variables as symbols for easy reference
symbol SELECTED_TEMP  = b1      ; Define the selected temperature as a symbol
symbol CURRENT_TEMP   = b0      ; Define the current temperature as a symbol
symbol FILLING        = b2      ; Store the state - filling or not?

; Define servo (tap) positions as symbols
symbol FULL           = 200
symbol HALF           = 100
symbol CLOSED         = 75

init:
    gosub close_taps

main:
    readadc POTENTIOMETER,SELECTED_TEMP ; Get the selected temperature.
    readadc THERMISTOR,CURRENT_TEMP     ; Get the current water temperature.

    if FILLING = 0 then
        ; We're not currently filling

        ; Check if we should start filling
        if START_BTN = 1 then
            sound PIEZO,(115,25,125,25)
            select case SELECTED_TEMP
                case < 040
                    gosub cold_leds
                    gosub open_cold_tap
                case > 070
                    gosub hot_leds
                    gosub open_hot_tap
                else
                    gosub warm_leds
                    gosub open_taps
            endselect
        end if
        goto main
    else
        ; We're currently filling

        ; Does the user want to stop filling?
        if STOP_BTN = 1 then
            sound PIEZO,(125,25,115,25)
            gosub close_taps
            gosub leds_off
            goto main
        end if

        ; Monitor the water temperature and adjust the taps if need be
        select case SELECTED_TEMP
            case < 040
                ; User wants cold water
                ; We can't make the water any colder - the hot tap is off and cold on full
            case > 070
                ; User wants hot water
                ; We can't make the water any hotter - the cold tap is off and hot on full
            else
                ; User wants warn water
                ; We need to make sure the water doesn't get too hot or too cold
                select case CURRENT_TEMP
                    ; case < 50
                    case < 87
                        ; Water has run cold
                        servopos COLD_SERVO,HALF
                        servopos HOT_SERVO,FULL
                    ; case > 150
                    case > 90
                        ; The water is too hot
                        servopos COLD_SERVO,FULL
                        servopos HOT_SERVO,HALF
                    else
                        ; Water is within the 'warm' range
                        ; We don't need to adjust the taps but we need to reset them both back to full on
                        gosub open_taps
                        goto main
                endselect
        endselect
    end if
    goto main

open_cold_tap:
    servopos COLD_SERVO,FULL
    FILLING = 1
    return

open_hot_tap:
    servopos HOT_SERVO,FULL
    FILLING = 1
    return

open_taps:
    gosub open_cold_tap
    gosub open_hot_tap
    return

close_taps:
    servo COLD_SERVO,CLOSED
    servo HOT_SERVO,CLOSED
    FILLING = 0
    return
    return

cold_leds:
    gosub leds_off  ; Reset LEDS to off
    high BLUE_LED
    return

warm_leds:
    gosub leds_off  ; Reset LEDS to off
    high BLUE_LED
    high AMBER_LED
    return

hot_leds:
    gosub leds_off  ; Reset LEDS to off
    high BLUE_LED
    high AMBER_LED
    high RED_LED
    return

leds_off:
    low BLUE_LED
    low AMBER_LED
    low RED_LED
    return
