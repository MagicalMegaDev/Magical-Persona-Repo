#Handles the player's maximum health, as well as i-frames
class_name PlayerHealthHandler
extends HealthHandler


const MAX_HEALTH_CAP:int = 20 #The maximum amount of pip a player can have, 10 total hearts.

signal i_frames_toggled(value:bool) #emitted whenever i-frames are toggled on or off

#region i-frames set up
var i_frames:bool = false #true while the player is invulnerable
var i_frames_timer:Timer #timer controlling i-frame duration
@export var i_frames_timer_length := 0.5 #seconds of i-frames

#endregion

#applies recieved stats
func _receive_stats(stats:CharacterStats):
	change_max_health(stats.max_health)
	if(!SignalBus.reset_room.is_connected(_on_room_reset)):
		SignalBus.reset_room.connect(_on_room_reset)
	
func _ready():
	super()
	health_changed.connect(SignalBus._on_player_health_changed)
	health_changed.emit(current_health, max_health)
	i_frames_timer = Timer.new()
	i_frames_timer.wait_time = i_frames_timer_length
	i_frames_timer.one_shot = true
	i_frames_timer.timeout.connect(_on_i_frames_finish)
	add_child(i_frames_timer)
	
# Updates the maximum health value, clamped by the health cap.
# Change_max_health is a flat change, adjust_max_health changes by a set amount
# Value: Amount to change max_health by
func change_max_health(value:int):
	max_health = min(value, MAX_HEALTH_CAP)
	health_changed.emit(current_health, max_health)

func adjust_max_health(value:int):
	max_health = min(value + max_health, MAX_HEALTH_CAP)
	health_changed.emit(current_health, max_health)
	
# Takes in an attack and applies damage if the player can be hurt.
func _on_take_damage(stats:AttackStats, attacker_position:Vector2):
	if(!i_frames):
		super(stats, attacker_position)
		i_frames = true
		i_frames_timer.start()
		i_frames_toggled.emit(true)

# Called when i-frames have completed.
func _on_i_frames_finish():
	i_frames = false
	i_frames_toggled.emit(false)

#DEBUG

const RESET_HEAL_AMOUNT = 1
#Called when the room manager signals a reset
func _on_room_reset():
	heal_damage(RESET_HEAL_AMOUNT)
