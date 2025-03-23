extends StaticBody2D

@export var texture_vide: Texture2D
@export var texture_pleine: Texture2D
@export var texture_cuites: Texture2D  


@onready var sprite = $Sprite2D
@onready var area = $Area2D
@onready var label = $Label
@onready var son = $AudioStreamPlayer2D


var pleine = false
var prete = false
var joueur_dans_zone = false
var inventory = null

func _ready():
	sprite.texture = texture_vide
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)
	son.finished.connect(_on_son_termine)
	inventory = get_tree().get_current_scene().get_node("Inventaire")

func _on_body_entered(body):
	if body.name == "Perso":
		joueur_dans_zone = true

func _on_body_exited(body):
	if body.name == "Perso":
		joueur_dans_zone = false

func _process(delta):
	if joueur_dans_zone and Input.is_action_just_pressed("interact"):
		if not pleine:
			if inventory and inventory.has_method("retirer_objet") and "Frites" in inventory.inventaire:
				inventory.retirer_objet("Frites")
				remplir_friteuse()
			else:
				afficher_message("Pas de frites dans l'inventaire")
		elif prete:
			if inventory.quete_active == "Préparer une frite":
				inventory.get_parent().get_node("StressBar").reduce_stress(25)
				inventory.generer_nouvelle_quete()
			else : 
				inventory.ajouter_objet("Frites Cuites")
			vider_friteuse()
			
			
func vider_friteuse():
	sprite.texture = texture_vide
	pleine = false
	prete = false
	afficher_message("Friteuse vide")



func remplir_friteuse():
	sprite.texture = texture_pleine
	pleine = true
	prete = false
	son.play()
	afficher_message("Friteuse en marche !")
	
func _on_son_termine():
	sprite.texture = texture_cuites
	prete = true
	afficher_message("Frites prêtes !")

func _on_timer_timeout():
	sprite.texture = texture_vide
	pleine = false
	afficher_message("Friteuse vide")

func afficher_message(txt: String):
	label.text = txt
	label.visible = true
	await get_tree().create_timer(2).timeout
	label.visible = false
