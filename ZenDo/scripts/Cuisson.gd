extends Node2D


@onready var timer = $Timer
@onready var area = $Area2D
@onready var label = $Label


var joueur_dans_zone = false
var inventory = null

func _ready():
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)
	timer.wait_time = 15.0
	inventory = get_tree().get_current_scene().get_node("Inventaire")

func _on_body_entered(body):
	if body.name == "Perso":
		joueur_dans_zone = true

func _on_body_exited(body):
	if body.name == "Perso":
		joueur_dans_zone = false

func _process(delta):
	if joueur_dans_zone and Input.is_action_just_pressed("interact"):
		if inventory and inventory.has_method("retirer_objet") and "Steak" in inventory.inventaire:
			inventory.retirer_objet("Steak")
			remplir_friteuse()
		else:
			afficher_message("Pas de steaks dans l'inventaire !")

func remplir_friteuse():
	timer.start()
	afficher_message("Cuisson en marche !")

func _on_timer_timeout():
	afficher_message("Steak cuit")

func afficher_message(txt: String):
	label.text = txt
	label.visible = true
	await get_tree().create_timer(2).timeout
	label.visible = false
