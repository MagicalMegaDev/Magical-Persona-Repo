#A helper script to control player sprite behavior. Costumes, small effects like blinking, etc.

class_name PlayerSprite
extends Sprite2D

#region blinking effect
var blinking := false #is the player currently blinking
var blink_timer: Timer
var blink_frequency := 0.05 #How long between blinks
#endregion

func _ready():
	#region blink_timer init
	blink_timer = Timer.new()
	blink_timer.one_shot = false
	blink_timer.autostart = false
	blink_timer.wait_time = blink_frequency
	add_child(blink_timer)
	blink_timer.timeout.connect(blink)
	#endregion

#Called by the blink_timer's timeout signal to create the blinking effect with a toggle
func blink():
	visible = !visible

# Connected to the Player's health node's damage signal
func _on_start_blink():
	blinking = true
	visible = false
	blink_timer.start()
	
# Connected to the Player's Health Node's i_frames_toggled signal
func _on_stop_blink(i_frames_value:bool):
	if(!i_frames_value):
		blinking = false
		visible = true
		blink_timer.stop()
