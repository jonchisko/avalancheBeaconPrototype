class_name ConsumableDrink extends Consumable


func consume(stamina_component: StaminaComponent) -> void:
	stamina_component.increase_stamina(self.value)


func restore(stamina_component: StaminaComponent) -> void:
	if self.consumable_type == GlobalEnums.ConsumableType.INSTANT:
		return

	# Will reduce by the value it should have added (even if it added a lesser amount, due to
	# current stamina being close to the max value).
	stamina_component.reduce_stamina(self.value, true)
