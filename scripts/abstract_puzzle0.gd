extends Node3D

signal puzzle_completed
var remaining_pillars: int = 0

func _ready() -> void:
	var pillars = get_tree().get_nodes_in_group("pillars")
	remaining_pillars = pillars.size()
	
	if remaining_pillars == 0:
		push_warning("No pillars found in group 'pillars'!")
		return
	
	for pillar in pillars:
		if not is_instance_valid(pillar): continue
		if not pillar.has_signal("destroyed"):
			push_warning("Node in 'pillars' group missing 'destroyed' signal – is Pillar.gd attached? Node: " + pillar.name)
			continue
		pillar.destroyed.connect(_on_pillar_destroyed)
	
	print("Puzzle initialized – tracking ", remaining_pillars, " pillars")

func _on_pillar_destroyed() -> void:
	remaining_pillars -= 1
	print("Pillars left: ", remaining_pillars)
	
	if remaining_pillars <= 0:
		emit_signal("puzzle_completed")
		print("Puzzle COMPLETE!")
