using Godot;
using System;

public class Ammo : WeaponComponentParent
{
    [Signal]
    public delegate void AmmoEmptied();
    [Signal]
    public delegate void AmmoDecremented(int amtLeft);

    [Export]
    public int Amount;

    public override void _Ready()
    {
        base._Ready();
        weapon.Connect(nameof(Weapon.AttackEnded), this, nameof(DecrementAmount));
    }

    private void DecrementAmount()
    {
        if (Amount > 0)
        {
            Amount -= 1;
            EmitSignal(nameof(DecrementAmount), Amount);
            if (Amount == 0)
            {
                EmitSignal(nameof(AmmoEmptied));
            }
        }
    }
}
