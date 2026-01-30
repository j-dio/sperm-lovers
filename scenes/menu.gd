extends VBoxContainer

# Go to prologue first, not directly to level1
# Flow: main_menu > prologue > test_level > level1 > level2 > level3 > level4 > Level5

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/prologue.tscn")

func _on_button_2_pressed() -> void:
	get_tree().quit()
