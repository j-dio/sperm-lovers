extends CanvasLayer

# Node references for labels
@onready var sibling_label: Label = $MarginContainer/PanelContainer/VBoxContainer/SiblingRow/Label
@onready var wbc_label: Label = $MarginContainer/PanelContainer/VBoxContainer/WBCRow/Label
@onready var pillar_label: Label = $MarginContainer/PanelContainer/VBoxContainer/PillarRow/Label

# Total counts (set at level start)
var total_siblings: int = 0
var total_wbcs: int = 0
var total_pillars: int = 0

func _ready() -> void:
	# Wait two frames for all entities to be added to groups (matching enemy scripts)
	await get_tree().physics_frame
	await get_tree().physics_frame
	_count_initial_totals()
	_update_labels()

func _count_initial_totals() -> void:
	total_siblings = get_tree().get_nodes_in_group("siblings").size()
	total_wbcs = get_tree().get_nodes_in_group("white_blood_cells").size()
	total_pillars = get_tree().get_nodes_in_group("pillars").size()

func _get_current_counts() -> Dictionary:
	return {
		"siblings": get_tree().get_nodes_in_group("siblings").size(),
		"wbcs": get_tree().get_nodes_in_group("white_blood_cells").size(),
		"pillars": get_tree().get_nodes_in_group("pillars").size()
	}

func _update_labels() -> void:
	var counts = _get_current_counts()
	sibling_label.text = "%d/%d" % [counts.siblings, total_siblings]
	wbc_label.text = "%d/%d" % [counts.wbcs, total_wbcs]
	pillar_label.text = "%d/%d" % [counts.pillars, total_pillars]

func _process(_delta: float) -> void:
	_update_labels()
