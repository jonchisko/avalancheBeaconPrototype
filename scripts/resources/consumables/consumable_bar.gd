class_name ConsumableBar extends Consumable


func consume(stamina_component: StaminaComponent) -> void:
	stamina_component.change_stamina_regen_speed(self.value)


func restore(stamina_component: StaminaComponent) -> void:
	if self.consumable_type == GlobalEnums.ConsumableType.INSTANT:
		return

	stamina_component.change_stamina_regen_speed(-self.value)
