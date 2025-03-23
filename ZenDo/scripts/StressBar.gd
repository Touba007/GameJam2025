extends TextureProgressBar

@export var max_stress: float = 100.0
var stress: float = 0.0
@export var stress_speed: float = 2.5  # stress par seconde

@export var content: Texture2D
@export var medium: Texture2D
@export var zehef: Texture2D  
@onready var sprite = $Sprite2D  
@onready var son = $AudioStreamPlayer2D
@onready var sona = $AudioStreamPlayer2D2


func _ready():
	min_value = 0
	max_value = max_stress
	value = stress

func _process(delta):
	stress += delta * stress_speed
	stress = clamp(stress, 0, max_stress)
	value = stress
	
	
	if stress < 50 : 
		sprite.texture = content
	elif stress >= 50 and stress <= 70 : 
		son.play()
		sprite.texture = medium
	else :
		sona.play()
		sprite.texture = zehef
		

	# Si stress max atteint, déclenche game over
	if stress >= max_stress:
		get_tree().change_scene_to_file("res://scenes/deathscreen.tscn")
		
		
func reduce_stress(amount : float) :
	stress -= amount
	if stress < 0:
		stress = 0
	value = stress
	


