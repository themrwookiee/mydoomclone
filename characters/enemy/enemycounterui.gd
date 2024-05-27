extends Control

var enemy_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	update_enemy_count()

func set_enemy_count(count):
	enemy_count = count
	update_enemy_count()

func update_enemy_count():
	$EnemyCountLabel.text = "Enemies: %d" % enemy_count
