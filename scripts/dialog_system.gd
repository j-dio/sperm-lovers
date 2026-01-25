extends Control

@export var text_speed: float = 30.0
@export_file("*.json") var jsonsrc: String

@onready var name_label: RichTextLabel = $DialogBox/NameLabel
@onready var text_label: RichTextLabel = $DialogBox/TextLabel

signal dialogue_started
signal dialogue_finished

var scene_script: Dictionary = {}
var current_entry: Dictionary = {}     # The actual {name, text, next?} we're showing
var current_key: String = ""           # last used key (for debugging mostly)

func _ready() -> void:
	hide()
	process_mode = Node.PROCESS_MODE_ALWAYS
	set_process(false)
	if jsonsrc: load_json(jsonsrc)

func load_json(path: String) -> void:
	var file = FileAccess.open(path, FileAccess.READ)
	if not file:
		push_error("Cannot open " + path)
		return
	var text = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var err = json.parse(text)
	if err != OK:
		push_error("JSON error: " + json.get_error_message())
		return
	
	var data = json.data
	if not data is Dictionary:
		push_error("Root must be Dictionary")
		return
	scene_script = data

func start_dialogue(entry_point: String = "start", _auto_advance: bool = false) -> void:
	if not scene_script.has(entry_point):
		push_warning("No such block: " + entry_point)
		return
	
	var entry = scene_script[entry_point]
	var selected = _pick_random_line(entry)
	if selected == null:
		push_warning("No valid line found in " + entry_point)
		return
	
	_show_line(selected, entry_point)
	show()
	set_process(true)
	get_tree().paused = true
	dialogue_started.emit()

# Core: pick one concrete line (supports groups)
func _pick_random_line(value) -> Dictionary:
	if value is Dictionary:
		# Group -> pick random child and recurse
		if value.has("text"): return value
		var keys = value.keys()
		if keys.is_empty(): return {}
		var k = keys[randi() % keys.size()]
		return _pick_random_line(value[k])
	
	if value is Array:
		if value.is_empty(): return {}
		var idx = randi() % value.size()
		return _pick_random_line(value[idx])
	
	push_warning("Bad dialogue node type")
	return {}

func _show_line(line: Dictionary, from_key: String = "") -> void:
	current_entry = line.duplicate()
	current_key = from_key
	
	name_label.text = line.get("name", "")
	text_label.text = line.get("text", "")
	text_label.visible_characters = 0
	
	set_process(true)

func _process(delta: float) -> void:
	if text_label.visible_characters >= text_label.get_total_character_count():
		set_process(false)
		return
	
	var total = text_label.get_total_character_count()
	var chars_per_sec = text_speed
	
	text_label.visible_characters += int(delta * chars_per_sec) + 1
	text_label.visible_characters = mini(text_label.visible_characters, total)

func _unhandled_input(event: InputEvent) -> void:
	if not visible: return
	if not event.is_action_pressed("shoot"): return
	
	get_viewport().set_input_as_handled()
	
	# Skip typing
	if text_label.visible_characters < text_label.get_total_character_count():
		text_label.visible_characters = text_label.get_total_character_count()
	else:
		# advance
		var next_id = current_entry.get("next", "")
		if next_id.is_empty():
			_end()
			return
		
		var next_line = _resolve_next_line(next_id)
		if next_line.is_empty():
			push_warning("Cannot resolve next: " + next_id)
			_end()
			return
		
		_show_line(next_line, next_id)

func _resolve_next_line(path: String) -> Dictionary:
	var parts = path.split(".", false, 1)
	if parts.size() == 1:
		if scene_script.has(path) and scene_script[path] is Dictionary:
			if scene_script[path].has("text"): return scene_script[path]
			else: return _pick_random_line(scene_script[path])
		return {}
	
	var group = parts[0]
	var key   = parts[1]
	
	if not scene_script.has(group): return {}
	var g = scene_script[group]
	if not g is Dictionary or not g.has(key): return {}
	var line = g[key]
	if line is Dictionary and line.has("text"): return line
	return {}

func _end() -> void:
	hide()
	set_process(false)
	current_entry.clear()
	current_key = ""
	get_tree().paused = false
	dialogue_finished.emit()

func complete_text() -> void:
	text_label.visible_characters = text_label.get_total_character_count()
