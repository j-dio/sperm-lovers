extends Node3D

@export var idle_position := Vector3(0.302, 0.678, 0.409)
@export var idle_rotation := Vector3(3.5, -10.7, 0.0)
@export var aim_position := Vector3(0.0, 0.5, 0.5)
@export var aim_rotation := Vector3(0.0, 0.0, 0.0)
@export var aim_speed := 15.0

# Recoil settings
@export var recoil_kickback := 0.5
@export var recoil_rotation := 10.0     # degrees upward kick

# Gunslinger spin
@export var spin_duration := 0.5         # how long the full spin lasts
@export var spin_speed := 720.0          # degrees per second (720 = 2 full spins)
@export var spin_axis := Vector3(-1,0,0) # directional vectors I LOVE VECTORS
@export var fixed_scale := Vector3(3.02, 4.577, 2.55)

var recoil_offset := 0.0
var recoil_rot_offset := 0.0
var spin_time_left := 0.0
var is_spinning := false
var base_rotation := Vector3.ZERO
var spin_rotation := 0.0

@onready var player: CharacterBody3D = get_parent()

func _ready() -> void:
	position = idle_position
	rotation_degrees = idle_rotation
	base_rotation = idle_rotation
	scale = fixed_scale

func _process(delta: float) -> void:
	var target_pos := aim_position if player.is_aiming else idle_position
	var target_rot := aim_rotation if player.is_aiming else idle_rotation
	
	# Recoil
	var current_target_pos = target_pos + Vector3(0, 0, recoil_offset)
	var current_target_rot = target_rot + Vector3(-recoil_rot_offset, 0, 0)

	base_rotation = base_rotation.lerp(current_target_rot, aim_speed * delta)
	
	if is_spinning:
		spin_time_left -= delta
		var extra_rot = spin_speed * delta
		spin_rotation += extra_rot
		if spin_time_left <= 0:
			is_spinning = false
			spin_rotation = 0.0
	
 	# Apply final rotation
	rotation_degrees = base_rotation
	if is_spinning: rotate_object_local(spin_axis, deg_to_rad(spin_rotation))
	
	# Position lerp
	position = position.lerp(current_target_pos, aim_speed * delta)
	scale = fixed_scale
	recoil_offset = lerpf(recoil_offset, 0.0, 10.0 * delta)
	recoil_rot_offset = lerpf(recoil_rot_offset, 0.0, 10.0 * delta)

func recoil() -> void:
	recoil_offset = recoil_kickback
	recoil_rot_offset = recoil_rotation
	start_gunslinger_spin()

func start_gunslinger_spin() -> void:
	is_spinning = true
	spin_time_left = spin_duration
	spin_rotation = 0.0

func ease_out_cubic(t: float) -> float:
	return 1.0 - pow(1.0 - t, 3.0)
