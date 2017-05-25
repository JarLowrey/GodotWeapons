## Gun Plugin for Godot

These two scripts (`examples/GunScripts/Bullet.gd`, `examples/GunScripts/Gun.gd`) can be used to quickly bootstrap guns and physics simulated bullets.
Check out the `examples/` directory for working scenes.

## How To

Attach the scripts to your Gun/Bullet scenes and examine the `Script Variables` that appear.

### Gun.gd

#### Variables

- `auto_fire` - shoot automatically as soon as `can_fire` is set to true. Disable if gun will be shot manually.
- `fire_delay` - time span between shots where `can_fire` is false
- `reload_delay` - time it takes to reload a clip of ammunition
- `ammo` - max ammo of the weapon, once it hits 0 the weapon cannot fire anymore. set to `-1` for infinite
- `clip_size` - number of bullets in a clip/magazine. Bullets in the same clip have a `fire_delay` between them before the clip empties and `reload_delay` must be called
- `shots` - an array of strings that reference bullets scenes. The whole array will be fired every volley

#### Functions

- setters - `set_clip_size`, `set_can_fire` (will begin auto firing if it's true), `set_ammo`
- `reload()` - sets `can_fire` to false, waits for `reload_delay` before shooting again
- `fire()` - exits if `can_fire` is false. spawns a new bullet scene for every bullet in `shots`. Sets vars up for the next bullet volley.

#### Signals

- `volley_fired(bullets_array)` - all the bullets in `shots` have been created. To connect to bullet signals, call `connect` on each bullet in the passed array.
- `out_of_ammo()` - ammo has hit 0 and gun cannot be shot until more ammo is added
- `clip_empty()` - reload() must be called before firing again
- `can_fire_again()`- gun is ready to shoot

#### Scene Requirements

Gun.gd is expecting to be placed upon a Node2D (or Node2D child).
It requires a Node2D child named "GunSprite".

### Bullet.gd

#### Variables

- `fire_pos_offset` - coordinate offset of bullet's spawn location upon the gun. Useful for placing bullet spawn location on a sprite, and ensuring bullets don't overlap when multiple are fired.
- `follow_gun` - if true the bullet will be added as a child to the gun, and will move with the gun. Useful with laser beams.
- `size_scaling_velocity` - added to the bullet's sprite's scale every frame, up to a `max_size_scale`. Again, useful for laser beams
- `max_size_scale` - see `size_scaling_velocity`
- `fit_collider_to_sprite` - automatically resizes bullet's polygon to perfectly fit its sprite.
- `deleted` - set to true when the object is `kill()` and thus `free()`
- `kill_on_collide`: killed on first contact, requires the body to enable `Contact Monitor` and `Contacts Reported` >0
- `kill_viewport_exit`: killed when leaving view port, doesn't always work if spawned outside of view port and never enters the view port
- `kill_after_time`: killed after a set amount of time, -1 disables
- `kill_travel_dist`: killed after traveling a certain distance (may be removed as Time is similar and more performant), -1 disables

Notice there is no `speed`.
Speed is found using the magnitude of your bullet's Linear Velocity (rigid body) property, and is set in the direction the gun was pointing when fired.

#### Functions

- setters - `set_fit_collider_to_sprite`, `set_kill_after_time` , `set_kill_on_collide`, `set_kill_travel_dist`, `set_kill_viewport_exit`
- `setup(gun_fired_from)` - saves the fun, sets parent node, sets pos on gun, sets velocity, that sort of thing. Must be called when spawning from a gun (done automatically for consumers, shouldn't have to worry about this unless you are extending the classes).
- `set_target(target_node, PID_Kp, PID_Ki, PID_Kd)` - sets the node the bullet should track, utilizing its [PID controller](https://en.wikipedia.org/wiki/PID_controller) ([ref1](https://forum.unity3d.com/threads/rigidbody-lookat-torque.146625/), [ref2](https://godotengine.org/qa/14826/having-issues-tracking-an-object-with-a-rigidbody)) for targeting calculations. `PID_K?` parameters are the gain (scalar) multiplied by different types of angle error (p = proportional/current, i = integral/sum of past d=derivative/speed of change). If negative, these values will not set the class variables (will be ignored).

#### Signals

- `bullet_killed(self)` - bullet has met some kill condition and has been `free()`'d. Consider releasing some particles and such.

#### Scene Requirements

Bullet.gd is expecting to be placed upon a RigidBody.
It needs a CollisionShape2D child named "CollisionPolygon" and, if you are using `fit_collider_to_sprite`, a "Sprite" child.


## Common Issues

*Bullets collide with character*:
Usually a gun will be placed on/inside a ship, character, etc's body.
To ensure it does not collide with its overlapping body, you must modify [Collision Layers and Collision Masks](https://godotengine.org/qa/4010/whats-difference-between-collision-layers-collision-masks).

*Gun is too boring*:
Connect particle effects and animations to Gun/bullet signals to juice things up.

*Bullet physics are wonky/weird/bad*:
Try modifying the params on your bullet's rigidbody scene.
Turn off gravity, friction, increase speed, etc.

## Contributing

Always welcome!

## To Do

- Enable bullets for path follow in addition to physics
- Make applicable to 3D


## License

MIT License (MIT)

Copyright (c) 2017 James R. Lowrey

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
