extends CanvasLayer

@onready var retry_button: Button = $Control/VBoxContainer/RetryButton
@onready var main_menu_button: Button = $Control/VBoxContainer/MainMenuButton
@onready var animation_player: AnimationPlayer = $AnimationPlayer

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
	
	# Play fade in animation if available
	if animation_player:
		animation_player.play("fade_in")


func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/levels/1_MAIN_MENU.tscn")
