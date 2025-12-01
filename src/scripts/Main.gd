extends Node

@export var dvd_scene: PackedScene

var game_score := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_over():
	$DVDTimer.stop()

func new_game():
	$Player.start($SpawnPoint.position)
	$StartTimer.start()

func restart_game():
	get_tree().reload_current_scene()


func _on_dvd_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = dvd_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("DVDPath/DVDSpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(100.0, 150.0), 0.0)
	mob.velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
	game_score += 1

func _on_start_timer_timeout():
	%DVDTimer.start()


func _on_button_pressed():
	$DVDTimer.stop()
	restart_game()
	
func _on_control_visibility_changed():
	%Score.text = "Score: " + str(game_score)
