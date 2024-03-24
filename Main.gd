extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	#new_game()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#esta es la señal hit del player
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	
func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_score_timer_timeout():
	score += 1

func _on_mob_timer_timeout():
	#Crear una instnacia de la escena del mob
	var mob = mob_scene.instantiate()
	
	#Cambia una locacización random en Path2D ("MobPath")
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	#Establece la dirección del mob's perpendicular a la dirección de la ruta
	var direction = mob_spawn_location.rotation + PI / 2
	
	#Establece la posición del mob a una localización random
	mob.position = mob_spawn_location.position
	
	#Agrega algo de aleatoridad a la direción
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	#Cambia la velocidad de los mob
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	#Aparece el Mob para añadirlo en la escena principal
	add_child(mob)
	
	$HUD.update_score(score)
	
	
	
	
