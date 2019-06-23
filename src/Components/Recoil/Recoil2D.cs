using Godot;
using System;

public class Recoil2D : WeaponComponentParent
{
    [Export]
    public float MaxRecoil = 15;

    public override void _Ready()
    {
        base._Ready();
        weapon.Connect(nameof(Weapon.AttackEnded), this, nameof(ApplyRecoil));
    }

    public void ApplyRecoil()
    {
        // Node2D weapon2D = (Node2D)weapon;
        // weapon2D.GlobalRotationDegrees += (float)Weapon.rand.NextDouble() * MaxRecoil;
    }
}
