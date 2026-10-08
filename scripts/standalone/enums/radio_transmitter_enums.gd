class_name RadioTransmitterEnums extends RefCounted


enum Strength {
	LOW,
	MID,
	HIGH,
}


static func to_float(value: RadioTransmitterEnums.Strength) -> float:
	match value:
		Strength.LOW:
			return 1.0
		Strength.MID:
			return 2.0
		Strength.HIGH:
			return 3.0
		_:
			printerr("Invalid value RadioTransmitterEnums.Strength")
			return 0.0
