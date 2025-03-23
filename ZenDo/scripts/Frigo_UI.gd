extends Control


func _on_frites_selected():
	get_parent().get_node("Inventaire").ajouter_objet("Frites")
	visible = false

func _on_steak_selected():
	get_parent().get_node("Inventaire").ajouter_objet("Steak")
	visible = false

func _on_soda_selected():
	var inventory = get_parent().get_node("Inventaire")
	if inventory.quete_active == "Donner une boisson":
		var stressbar = get_parent().get_node("StressBar")
		stressbar.reduce_stress(25)
		inventory.generer_nouvelle_quete()
	else : 
		inventory.ajouter_objet("Soda")
	visible = false

