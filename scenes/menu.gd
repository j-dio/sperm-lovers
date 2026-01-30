extends VBoxContainer

const LEVEL_1 = preload("uid://c1ik22b8i70y5")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(LEVEL_1)


func _on_button_2_pressed() -> void:
	get_tree().quit()
