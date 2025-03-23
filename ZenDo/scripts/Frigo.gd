extends Node2D

var joueur_dans_zone = false

@onready var fridge_ui = get_parent().get_node("Frigo_UI")

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name == "Perso":
		joueur_dans_zone = true

func _on_body_exited(body):
	if body.name == "Perso":
		joueur_dans_zone = false

func _process(delta):
	if joueur_dans_zone and Input.is_action_just_pressed("interact"):
		if fridge_ui:
			fridge_ui.visible = true
