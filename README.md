## Weapon Plugin for Godot

Weapon bootstrapping in Godot 4.5, written in GDScript.

### What is a weapon?

Essentially, I view it as a tool that can be used periodically. 
This project aims to flexibly implement tool/weapon usage and provide common components.

### How To

View the examples in `Test/`.

#### Elevator Explanation

A weapon is an action with a cooldown.
This action may end immediately, after a time period, through an animation, or however you decide (just be sure to call `end_attack` [or `end_action`/`end_reload` depending on situation]).

Components can be added as direct children to modify the action's ability to start or end, and may have further customization options in the editor.
This project aims to cover most common component needs, but you can extend them or add your own if you like.

### Base components

- Ammo: Disables the gun when the capacity drops to zero. Could also work as Stamina
- Charge: Disables the weapon when capacity is less than Max_Capaciy. 
- AutoAttack: auto starts the attack upon entering the tree. Restarts the attack once it finished successfully
- BoolBlocker: conditions/trigger to start/end action
- BulletSpawner: for instancing scenes on weapon state change. For a bullet hell or intensive application, this should be refactored to pull from an object pool.
- Magazine (includes reload action): a magazine. Must make children editable to customize via the Capacity and LongAction children nodes.
- Combo: counts combos

### Util

- Capacity: Parent class for Ammo, Charge, MagCapacity, and others. Has a min, max, and step (for easy increment/decrement).
- LongAction: Base class for attacking and cooldowns. Leaves implementation up to developer but allows the components to interact predictably
