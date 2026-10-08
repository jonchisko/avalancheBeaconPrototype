class_name ConsumeComponent extends Node


@export_category("Dependencies")
@export var stamina_component: StaminaComponent
@export var inventory_controller: InventoryController
@export var consumable_object_controller: ConsumableObjectController


var _current_over_time_consumable: Consumable = null
var _consumable_duration: float = 0.0


func _ready() -> void:
	self.inventory_controller.consumable_used.connect(self._on_consumable_used)


func _process(delta: float) -> void:
	self._consumable_duration = max(self._consumable_duration - delta, 0.0)
	#print(self._consumable_duration, ", ", self._current_over_time_consumable)
	if self._current_over_time_consumable != null && self._consumable_duration <= 0.0:
		print("reducing consumable")
		self._current_over_time_consumable.restore(self.stamina_component)
		self._current_over_time_consumable = null


func _on_consumable_used(consumable: Consumable) -> void:
	self.consumable_object_controller.show_consumable(consumable)

	if consumable.consumable_type == GlobalEnums.ConsumableType.OVER_TIME:
		print("over time consumable used")
		self._consumable_duration += consumable.duration
		# Do not "consume" an over time consumable if one is already active, just increase the time.
		if self._current_over_time_consumable != null:
			return
		self._current_over_time_consumable = consumable

	consumable.consume(self.stamina_component)
