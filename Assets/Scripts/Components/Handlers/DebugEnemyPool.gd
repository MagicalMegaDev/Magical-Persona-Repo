class_name DebugEnemyPool extends Node


var alive_enemies = {} #Enemies currently alive {BaseEnemy, position}
var dead_enemies = {} #Enmies pooled waiting to respawn {BaseEnemy, position}
var default_positions = {} #Default spawn location for each enemy
var challenge := false #Challenge mode for debugging
var spawn_bounds : Area2D #Bounds to contain enemy spawn

func _ready():
	for child in get_tree().get_nodes_in_group("Enemies"):
		if(child is BaseCharacter):
			alive_enemies[child] = child.global_position
			default_positions[child] = child.global_position
			if child is BaseEnemy:
				child.died.connect(_store)
	if has_node("EnemySpawnBounds"):
		spawn_bounds = $EnemySpawnBounds
	else:
		spawn_bounds = null
	#DEBUG
	TestDebugMenu.challenge_enabled.connect(_challenge_mode_on)
	TestDebugMenu.challenge_disabled.connect(_challenge_mode_off)

func _store(enemy:BaseEnemy, trigger_respawn:bool = true):
	var anim_player:AnimationPlayer = enemy.get_node_or_null("AnimationTree/AnimationPlayer")
	if(anim_player):
		anim_player.stop()
	else:
		print("Probably a typo getting Animation player in DebugEnemyPool")
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
		if challenge:
			var player := get_tree().get_first_node_in_group("Players")
			var rand_pos = generate_spawn_position(player)
			e.global_position = rand_pos
			if e.imported_stats and e.imported_stats.base_max_speed:
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

func generate_spawn_position(player:Node) -> Vector2:
	var rand_pos := Vector2.ZERO
	if spawn_bounds and spawn_bounds.has_node("CollisionShape2D"):
		var shape_node := spawn_bounds.get_node("CollisionShape2D") as CollisionShape2D
		if shape_node and shape_node.shape is RectangleShape2D:
			var size = shape_node.shape.size
			var top_left = shape_node.global_position - size * 0.5
			while true:
				rand_pos = Vector2(randf_range(top_left.x, top_left.x + size.x), randf_range(top_left.y, top_left.y + size.y))
				if not player or rand_pos.distance_to(player.global_position) > 50:
					break
		else:
			push_warning("DebugEnemyPool: EnemySpawnBounds invalid")
			rand_pos = shape_node.global_position
	else:
		var viewport_size = get_viewport().get_visible_rect().size
		while true:
			rand_pos = Vector2(randi_range(0, viewport_size.x), randi_range(0, viewport_size.y))
			if not player or rand_pos.distance_to(player.global_position) > 50:
				break
	return rand_pos
	
#DEBUG
func _challenge_mode_on():
	challenge = true
	_respawn()
	
func _challenge_mode_off():
	challenge = false
	_respawn()
