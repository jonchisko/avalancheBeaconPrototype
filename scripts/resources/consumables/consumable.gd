@abstract class_name Consumable extends Resource


## The type of consumable.
@export var consumable_type: GlobalEnums.ConsumableType
## How long does the affect persists? The value of 0.0 is instant.
@export var duration: float = 0.0
## Absolute value increase.
@export var value: float = 0.0
## The 3D consumable object.
@export var consumable_object: Mesh
## Consumable brand/name
@export var consumable_name: String
## What does the consumable do?
@export_multiline var description: String


var consumable_class_name: String:
	get:
		return self.get_script().get_global_name()


@abstract func consume(stamina_component: StaminaComponent) -> void
@abstract func restore(stamina_component: StaminaComponent) -> void
