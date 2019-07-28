## Weapon Plugin for Godot

Weapon bootstrapping in Godot 3.1, written in GDScript.

### What is a weapon?

Essentially, I view it as a tool that can be used periodically. 
This project aims to flexibly implement tool/weapon usage and provide common components.

### How To

View the examples in `Test/` for a full introduction to the API.

#### Elevator Explanation

A weapon is an action with a cooldown.
This action may end immediately, after a time period, through an animation, or however you decide (just be sure to call `end_attack` [or `end_action`/`end_reload` depending on situation]).

Components can be added as direct children to modify the action's ability to start or end, and may have further customization options in the editor.
This project aims to cover most common component needs, but you can extend them or add your own if you like.

### Base components

These components will work immediately.

- Ammo: Disables the gun when the capacity drops to zero. Could also work as Stamina
- Charge: Disables the weapon when capacity is less than Max_Capaciy. 
- AutoAttack: auto starts the attack upon entering the tree. Restarts the attack once it finished successfully
- StartBlocker: conditions/trigger to start action
- EndBlocker: conditions/trigger to end action (useful for a charged weapon with a manual release)
- BulletSpawner: for instancing scenes on weapon state change. For a bullet hell or intensive application, this should be refactored to pull from an object pool.
- Magazine (includes reload action): a magazine. Must make children editable to customize via the Capacity and LongAction children nodes.

### Common Components

These components require further scripting to customize them to your weapon-specific implementation.

- Combo: change weapon data (animation played, cooldown delay, etc) if it is used quickly enough. Need to add extra data to the JSON and apply it.
- Burst: changes multiple attacks into a single atomic attack. Will stop partway through if gun cannot fire (ran out of ammo etc). Relies on developer to implement different cooldown times for burst and non-burst attacks. Need to implement "_apply_burst/original_cooldown"
- Recoil: bounce the weapon after shooting. Need to write application for 3D, or change 2D application if your gun needs it.


### Util

- Capacity: Parent class for Ammo, Charge, MagCapacity, and others. Has a min, max, and step (for easy increment/decrement).
- LongAction: Base class for attacking and cooldowns. Leaves implementation up to developer but allows the components to interact predictably

### Notes

All weapons/components currently only tested in 2D, but should work in 3D too.