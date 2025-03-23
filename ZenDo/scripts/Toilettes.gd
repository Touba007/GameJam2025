extends Node2D

@export var son_toilettes: AudioStreamPlayer2D
@export var temps_disparition: float = 10.0

@onready var player_audio = $AudioStreamPlayer2D
@onready var timer = $Timer
@onready var area = $Area2D

var joueur_dans_zone = false
var joueur = null

func _ready():
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)
	timer.wait_time = temps_disparition
	timer.one_shot = true

func _on_body_entered(body):
	if body.name == "Perso":
		joueur_dans_zone = true
		joueur = body

func _on_body_exited(body):
	if body.name == "Perso":
		joueur_dans_zone = false
		joueur = null

func _process(delta):
	if joueur_dans_zone and Input.is_action_just_pressed("interact"):
		activer_toilettes()

func activer_toilettes():
	if joueur:
		joueur.visible = false
		joueur.set_physics_process(false)
		joueur.velocity = Vector2.ZERO
		player_audio.stream = son_toilettes
		player_audio.play()
		timer.start()

func _on_Timer_timeout():
	if joueur:
		joueur.visible = true
		joueur.set_physics_process(true)


func _on_timer_timeout():
	pass # Replace with function body.
