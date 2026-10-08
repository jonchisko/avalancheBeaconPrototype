class_name ConsumableObjectController extends Node3D


@onready var _parent: Node3D = $ConsumableParent
@onready var _animation_player: AnimationPlayer = $AnimationPlayer

var _consumable_object: PackedScene = preload("res://scenes/objects/consumables/consumable_object.tscn")
var _instantiated_object: ConsumableObject = null


func show_consumable(consumable: Consumable) -> void:
	self._instantiated_object = self._consumable_object.instantiate()
	self._parent.add_child(self._instantiated_object)
	self._instantiated_object.init(consumable)
	self._animation_player.play("consume_animation")


func dequeue_instantiated_consumable() -> void:
	if self._instantiated_object != null:
		self._instantiated_object.call_deferred("queue_free")
