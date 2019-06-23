using Godot;
using System;

public class Burst : WeaponComponentParent
{
    public override void _Ready()
    {
        base._Ready();

        weapon.Connect(nameof(Weapon.AttackEnded), this, nameof(SetWeaponDelay));

        if (weapon.HasNode(nameof(Magazine)))
        {
            Magazine m = (Magazine)weapon.GetNode(nameof(Magazine));
            m.Connect(nameof(Magazine.ReloadedSuccessfully), this, nameof(resetCurrentAttackInBurst));
        }
    }

    private int currentAttackInBurst = 0;

    [Export]
    public int NumberOfBursts = 1;
    [Export]
    public float BurstDelay = 1;
    [Export]
    public float AfterBurstDelay = 1;

    private void SetWeaponDelay()
    {
        currentAttackInBurst++;

        float wait = (currentAttackInBurst < NumberOfBursts) ? BurstDelay : AfterBurstDelay;
        weapon.RecoveryDelay = wait;

        if (currentAttackInBurst == NumberOfBursts) currentAttackInBurst = 0;
    }

    private void resetCurrentAttackInBurst()
    {
        currentAttackInBurst = 0;
    }
}
