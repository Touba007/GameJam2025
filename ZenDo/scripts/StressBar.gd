extends TextureProgressBar

@export var max_stress: float = 100.0
var stress: float = 0.0
@export var stress_speed: float = 10.0  # stress par seconde

func _ready():
	min_value = 0
	max_value = max_stress
	value = stress

func _process(delta):
	stress += delta * stress_speed
	stress = clamp(stress, 0, max_stress)
	value = stress

	# Si stress max atteint, déclenche game over
	if stress >= max_stress:
		get_tree().change_scene_to_file("res://scenes/deathscreen.tscn")


