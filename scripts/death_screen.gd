extends CanvasLayer

@onready var retry_button: Button = $Control/VBoxContainer/RetryButton
@onready var main_menu_button: Button = $Control/VBoxContainer/MainMenuButton
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var control: Control = $Control

func _ready() -> void:
	# Start hidden
	hide()
	
	# Add to group for easy access
	add_to_group("death_screen")
	
	# Connect button signals
	retry_button.pressed.connect(_on_retry_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)
	
	# Unpause when buttons are clicked
	process_mode = Node.PROCESS_MODE_ALWAYS


func show_death_screen() -> void:
	show()
	get_tree().paused = true
	
	# Ensure control is visible (in case animation fails)
	if control:
		control.modulate = Color(1, 1, 1, 1)
	
	# Play fade in animation if available
	if animation_player and animation_player.has_animation("fade_in"):
		control.modulate = Color(1, 1, 1, 0)  # Reset for animation
		animation_player.play("fade_in")


func _on_retry_pressed() -> void:
	get_tree().paused = false
	queue_free()  # Remove death screen before reloading
	get_tree().reload_current_scene()


func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	queue_free()  # Remove death screen before changing scene
	get_tree().change_scene_to_file("res://scenes/levels/1_MAIN_MENU.tscn")
