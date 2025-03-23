extends Node2D

@onready var sprite = $Sprite2D
@onready var timer = $Timer
@onready var message_label = $Label 

@export var texture_vide: Texture
@export var texture_pleine: Texture

var est_pleine = false
var joueur_est_proche = false

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)
	timer.wait_time = 30.0
	timer.one_shot = true
	message_label.visible = false  # cache le message au début

func _on_body_entered(body):
	if body.name == "Perso":
		joueur_est_proche = true
		if not est_pleine:
			message_label.text = "Appuie sur E pour remplir la friteuse"
			message_label.visible = true

func _on_body_exited(body):
	if body.name == "Perso":
		joueur_est_proche = false
		message_label.visible = false

func _process(delta):
	if joueur_est_proche and Input.is_action_just_pressed("interact") and not est_pleine:
		remplir()

func remplir():
	sprite.texture = texture_pleine
	est_pleine = true
	message_label.visible = false
	timer.start()

func _on_timer_timeout():
	sprite.texture = texture_vide
	est_pleine = false
	if joueur_est_proche:
		message_label.text = "Appuie sur E pour remplir la friteuse"
		message_label.visible = true
