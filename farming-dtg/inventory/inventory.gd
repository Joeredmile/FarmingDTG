extends Resource

class_name Inv

signal update

@export var slots: Array[InvSlot]

func insert(item: InvItem):
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		itemslots[0].amount += 1
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
	update.emit()

func remove(item: InvItem, count: int) -> int:
	var to_remove := count
	for slot in slots:
		if slot.item == item:
			if slot.amount <= to_remove:
				to_remove -= slot.amount
				slot.item = null
				slot.amount = 0
			else:
				slot.amount -= to_remove
				to_remove = 0
			if to_remove == 0:
				break
	update.emit()
	return count - to_remove
