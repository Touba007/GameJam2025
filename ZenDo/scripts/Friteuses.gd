extends StaticBody2D

@export var texture_vide: Texture2D
@export var texture_pleine: Texture2D

@onready var sprite = $Sprite2D
@onready var timer = $Timer
@onready var area = $Area2D
@onready var label = $Label
@onready var son = $AudioStreamPlayer2D


var pleine = false
var joueur_dans_zone = false
var inventory = null

func _ready():
	sprite.texture = texture_vide
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
	if joueur_dans_zone and Input.is_action_just_pressed("interact") and not pleine:
		if inventory and inventory.has_method("retirer_objet") and "Frites" in inventory.inventaire:
			inventory.retirer_objet("Frites")
			remplir_friteuse()
		else:
			afficher_message("Pas de frites dans l'inventaire !")

func remplir_friteuse():
	sprite.texture = texture_pleine
	pleine = true
	timer.start()
	son.play()
	afficher_message("Friteuse en marche !")

func _on_timer_timeout():
	sprite.texture = texture_vide
	pleine = false
	afficher_message("Friteuse vide")

func afficher_message(txt: String):
	label.text = txt
	label.visible = true
	await get_tree().create_timer(2).timeout
	label.visible = false
