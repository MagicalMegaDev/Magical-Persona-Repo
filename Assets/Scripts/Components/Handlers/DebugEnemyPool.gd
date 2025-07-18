class_name DebugEnemyPool extends Node

var alive_enemies = {}
var dead_enemies = {}
var default_positions = {}
var challenge := false

func _ready():
	for child in get_tree().get_nodes_in_group("Enemies"):
		if(child is BaseCharacter):
			alive_enemies[child] = child.global_position
			default_positions[child] = child.global_position
			child.died.connect(_store)
	#DEBUG
	TestDebugMenu.challenge_enabled.connect(_challenge_mode_on)
	TestDebugMenu.challenge_disabled.connect(_challenge_mode_off)

func _store(enemy:BaseEnemy, trigger_respawn:bool = true):
	enemy.get_node("AnimationTree/AnimationPlayer").stop()
	enemy.process_mode = Node.PROCESS_MODE_DISABLED
	enemy.visible = false
	if enemy in alive_enemies:
		dead_enemies[enemy] = alive_enemies[enemy]
		alive_enemies.erase(enemy)
	if alive_enemies.is_empty() and trigger_respawn:
		_respawn()
		
func _respawn():
	var enemies := alive_enemies.keys()
	for e in enemies:
		assert(e is BaseEnemy, "Pool is trying to store %s, not an enemy!" % e.name)
		_store(e, false)

	for e in dead_enemies:
		var spawn_position = dead_enemies[e]
		if challenge:
			var player := get_tree().get_first_node_in_group("Players")
			var rand_pos := Vector2.ZERO
			var viewport_size = get_viewport().get_visible_rect().size
			if player:
				while true:
					rand_pos = Vector2(randi_range(0,viewport_size.x), randi_range(0,viewport_size.y))
					if(rand_pos.distance_to(player.global_position)>50):
						break
			else: print("Player is missing somehow?")
			e.global_position = rand_pos
			if e.imported_stats and e.imported_stats.base_max_speed:
				var base = e.imported_stats.base_max_speed
				var modifier = randf_range(0.5, 2.0)
				e.stats.base_max_speed = e.imported_stats.base_max_speed * modifier
				e.stats.base_acceleration = e.imported_stats.base_acceleration * modifier
				e.stats.base_friction = e.imported_stats.base_friction * modifier
		else: 
			e.global_position = default_positions[e]
			e.stats.base_max_speed = e.imported_stats.base_max_speed
			e.stats.base_acceleration = e.imported_stats.base_acceleration
			e.stats.base_friction = e.imported_stats.base_friction
		e.health_handler.heal_damage(e.health_handler.max_health)
		e.process_mode = Node.PROCESS_MODE_INHERIT
		e.visible = true
		alive_enemies[e] = dead_enemies[e]
	dead_enemies.clear()
	if(challenge):
		RoomManager.room_cleared.emit()

#DEBUG
func _challenge_mode_on():
	challenge = true
	_respawn()
	
func _challenge_mode_off():
	challenge = false
	_respawn()
