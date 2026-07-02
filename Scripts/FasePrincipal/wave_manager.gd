extends Node

@export var wave_time := 30.0


var wave_enemies = {
	#1: {"A": 20, "B": 0, "C": 0},
	#2: {"A": 20, "B": 2, "C": 4},
	#3: {"A": 25, "B": 5, "C": 4},
	1: {"A": 2, "B": 0, "C": 0},
	2: {"A": 2, "B": 0, "C": 0},
	3: {"A": 2, "B": 0, "C": 0},
	4: {"A": 10, "B": 20, "C": 5},
	5: {"A": 15, "B": 15, "C": 8},
	6: {"A": 20, "B": 20, "C": 5},
	7: {"A": 5, "B": 20, "C": 10},
	8: {"A": 20, "B": 10, "C": 10},
	9: {"A": 10, "B": 15, "C": 12},
	10: {"A": 25, "B": 25, "C": 15}
}

var wave := 0

var wave_timer := 0.0
var wave_finished := false

var enemies_alive := 0

var spawn_events = []
var current_event := 0

var spawner_default
var spawner_magro
var spawner_gordo

func _ready():

	spawner_gordo = $"../Path2D/EnemySpawner"
	spawner_magro = $"../Path2D2/EnemySpawner2"
	spawner_default = $"../Path2D3/EnemySpawner3"

	spawner_default.enemy_removed.connect(_on_enemy_removed)
	spawner_magro.enemy_removed.connect(_on_enemy_removed)
	spawner_gordo.enemy_removed.connect(_on_enemy_removed)

	start_wave()

func start_wave():

	GameManager.waveCounter += 1

	wave_timer = 0.0
	wave_finished = false

	current_event = 0

	spawn_events.clear()

	var data = wave_enemies[GameManager.waveCounter]

	generate_events("A", data["A"])
	generate_events("B", data["B"])
	generate_events("C", data["C"])

	spawn_events.sort_custom(
		func(a,b):
			return a.time < b.time
	)

func generate_events(enemy_type:String, amount:int):

	if amount <= 0:
		return

	for i in range(amount):

		spawn_events.append({
			"time": randf_range(0.0, wave_time),
			"type": enemy_type
		})

func _process(delta):

	if wave_finished:

		if enemies_alive <= 0:
			GameManager.incrementXp()
			wave_finished=true
			GameManager.changeSceneShop()
		return

	wave_timer += delta

	while current_event < spawn_events.size():

		var event = spawn_events[current_event]

		if wave_timer >= event.time:

			spawn_enemy(event.type)

			current_event += 1

		else:
			break

	if wave_timer >= wave_time:

		wave_finished = true


func spawn_enemy(enemy_type:String):

	match enemy_type:

		"A":
			spawner_default.spawn_enemy()

		"B":
			spawner_magro.spawn_enemy()

		"C":
			spawner_gordo.spawn_enemy()

	enemies_alive += 1

func _on_enemy_removed():
	enemies_alive -= 1

	if enemies_alive < 0:
		enemies_alive = 0
