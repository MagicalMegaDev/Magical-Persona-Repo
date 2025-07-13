#This class holds all bespoke health logic for the player character
class_name PlayerHealthHandler extends HealthHandler

var max_health_cap:int = 20 #The maximum amount of pip a player can have, 10 total hearts.

signal i_frames_finished

#region i-frames set up
var i_frames:bool = false #i-frames after getting hit.
var i_frames_timer:Timer
var i_frames_timer_length := 0.5 #seconds of i-frames

#endregion

func _ready():
	super()
	health_changed.connect(SignalBus._on_player_health_changed)
	current_health = max_health
	health_changed.emit(current_health, max_health)
	i_frames_timer = Timer.new()
	i_frames_timer.wait_time = i_frames_timer_length
	i_frames_timer.one_shot = true
	i_frames_timer.timeout.connect(_on_i_frames_finish)
	add_child(i_frames_timer)
	
#GainMaxHealth(value)
#value: The amount of pips to gain
#Adds pip containers to the player

func GainMaxHealth(value):
	max_health = min(max_health + value, max_health_cap)
	health_changed.emit(current_health, max_health)

func take_damage(damage_value:int, attacker_position:Vector2):
	if(!i_frames):
		super(damage_value, attacker_position)
		i_frames = true
		i_frames_timer.start()
		
func _on_i_frames_finish():
	i_frames = false
	i_frames_finished.emit()
