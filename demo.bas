#picaxe 18a

; ToDo: Adjust taps if the temperature of the water reaches the selected temperature.
; ToDo: Add sound confirmations via piezo speaker.

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

symbol SELECTED_TEMP  = b1      ; Define the selected temperature as a symbol
symbol CURRENT_TEMP   = b0      ; Define the current temperature as a symbol

init:
    gosub close_taps

main:
    pause 5000

    ; Demo "Full Cold"
    gosub cold_leds
    gosub open_cold_tap
    pause 3000
    gosub close_taps

    ; Demo "Hot and Cold"
    gosub warm_leds
    gosub open_taps
    pause 3000
    gosub close_taps

    ; Demo "Full Hot"
    gosub hot_leds
    gosub open_hot_tap
    pause 3000
    gosub close_taps

    end

open_cold_tap:
    servopos 5,225
    return

open_hot_tap:
    servopos 4,225
    return

open_taps:
    gosub open_cold_tap
    gosub open_hot_tap
    return

close_taps:
    servo COLD_SERVO,75
    servo HOT_SERVO,75
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
