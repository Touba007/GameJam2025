extends Control

# Le vrai inventaire (objet → quantité)
var inventaire: Dictionary = {}

@onready var liste_objets = $Panel/"Liste d'objets"
@onready var message_label = $Panel/"Liste d'objets"/MessageLabel

func _ready():
	visible = false

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		visible = not visible
		if visible:
			afficher_inventaire()

# Ajouter un objet
func ajouter_objet(nom: String, quantite: int = 1):
	if nom in inventaire:
		inventaire[nom] += quantite
	else:
		inventaire[nom] = quantite
	if visible:
		afficher_inventaire()

# Retirer un objet
func retirer_objet(nom: String, quantite: int = 1):
	if nom in inventaire:
		inventaire[nom] -= quantite
		if inventaire[nom] <= 0:
			inventaire.erase(nom)
	if visible:
		afficher_inventaire()

# Afficher les objets dans l'UI
func afficher_inventaire():
	for enfant in liste_objets.get_children():
		if enfant != message_label:
			enfant.queue_free()

	if inventaire.is_empty():
		message_label.text = "Pas d'objets dans l'inventaire"
		message_label.visible = true
	else:
		message_label.visible = false
		for nom in inventaire:
			var quantite = inventaire[nom]
			var label = Label.new()
			label.text = "- " + nom + " x" + str(quantite)
			liste_objets.add_child(label)
