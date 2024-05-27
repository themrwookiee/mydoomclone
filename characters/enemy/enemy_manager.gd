extends Node

@export var enemy_scene: PackedScene
@export var spawn_point: Node3D
@export var spawn_interval = 3.0

var remaining_enemies

@onready var ui = get_tree().get_first_node_in_group("ui")
var enemy_counter_ui = null

func _ready():
	remaining_enemies = get_tree().get_nodes_in_group("enemies")
	if remaining_enemies.size() > 0:
		var timer = Timer.new()
		timer.wait_time = spawn_interval
		timer.connect("timeout", Callable(self, "_on_spawn_timer_timeout"))
		add_child(timer)
		timer.start()
	# Find the EnemyCounterUI node in the scene tree
	enemy_counter_ui = get_node("/root/World/Player/CanvasLayer/EnemyCounterUI")
	update_enemy_count()

func _on_spawn_timer_timeout():
	if remaining_enemies.size() > 0:
		spawn_enemy()
		
func spawn_enemy():
	if enemy_scene == null:
		return
	if spawn_point == null:
		return
	var enemy = enemy_scene.instantiate()
	if enemy == null:
		return
	enemy.global_position = spawn_point.global_position
	add_child(enemy)
	remaining_enemies.resize(remaining_enemies.size() + 1)
	update_enemy_count()

func enemy_killed():
	remaining_enemies.resize(remaining_enemies.size() - 1)
	update_enemy_count()
	if remaining_enemies.size() == 0:
		check_win_condition()

func update_enemy_count():
	if enemy_counter_ui:
		enemy_counter_ui.set_enemy_count(remaining_enemies.size())

func check_win_condition():
	var ui = get_tree().get_first_node_in_group("ui")
	ui.get_node("WinScreen").show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
