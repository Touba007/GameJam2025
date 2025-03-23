extends Control


func _on_frites_selected():
	get_parent().get_node("Inventory").ajouter_objet("Frites")
	visible = false

func _on_steak_selected():
	get_parent().get_node("Inventory").ajouter_objet("Viande")
	visible = false

func _on_soda_selected():
	get_parent().get_node("Inventory").ajouter_objet("Soda")
	visible = false

