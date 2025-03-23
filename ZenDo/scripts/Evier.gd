extends Node2D

@onready var sprite = $Sprite2D
@onready var timer = $Timer

@export var texture_vide: Texture
@export var texture_plein: Texture

@onready var sfx = $AudioStreamPlayer2D  # référence au nœud audio

var est_pleine = false
var joueur_est_proche = false

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)
	timer.wait_time = 30.0
	timer.one_shot = true

func _on_body_entered(body):
	if body.name == "Perso":
		joueur_est_proche = true

func _on_body_exited(body):
	if body.name == "Perso":
		joueur_est_proche = false

func _process(delta):
	if joueur_est_proche and Input.is_action_just_pressed("interact") and not est_pleine:
		remplir()

func remplir():
	sprite.texture = texture_plein
	est_pleine = true
	timer.start()
	sfx.play()

func _on_timer_timeout():
	sprite.texture = texture_vide
	est_pleine = false
