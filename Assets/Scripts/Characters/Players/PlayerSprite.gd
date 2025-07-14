#A helper script to control player sprite behavior. Costumes, small effects like blinking, etc.

extends Sprite2D

#region blinking effect
var blinking := false #is the player currently blinking
var blink_timer:Timer
var blink_frequency := 0.05 #How long between blinks

func _ready():
	#region blink_timer init
	blink_timer = Timer.new()
	blink_timer.one_shot = false
	blink_timer.autostart = false
	blink_timer.wait_time = blink_frequency
	add_child(blink_timer)
	blink_timer.timeout.connect(blink)
	#endregion

#for instant blink
#func _process(delta):
#	if blinking:
#		blink()

func blink():
	visible = !visible

func _on_start_blink():
	blinking = true
	visible = false
	blink_timer.start()
	
func _on_stop_blink():
	blinking = false
	visible = true
	blink_timer.stop()
