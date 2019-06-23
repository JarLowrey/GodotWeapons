using Godot;
using System;

public class AutoAttack : WeaponComponentParent
{
    public override void _Ready()
    {
        base._Ready();

        CallDeferred(nameof(BeginAutoAttack));
        Connect("tree_exited", this, nameof(EndAutoAttack));


        if (weapon.HasNode(nameof(Magazine)))
        {
            Magazine m = (Magazine)weapon.GetNode(nameof(Magazine));
            m.Connect(nameof(Magazine.ReloadedSuccessfully), weapon, nameof(Weapon.StartAttack));
        }
    }
    public void BeginAutoAttack()
    {
        weapon.Connect(nameof(Weapon.CanAttackAgain), weapon, nameof(Weapon.StartAttack));
        weapon.StartAttack();
    }
    public void EndAutoAttack()
    {
        if (weapon.IsConnected(nameof(Weapon.CanAttackAgain), weapon, nameof(Weapon.StartAttack)))
        {
            weapon.Disconnect(nameof(Weapon.CanAttackAgain), weapon, nameof(Weapon.StartAttack));
        }


        if (weapon.HasNode(nameof(Magazine)))
        {
            Magazine m = (Magazine)weapon.GetNode(nameof(Magazine));
            if (m.IsConnected(nameof(Magazine.ReloadedSuccessfully), weapon, nameof(Weapon.StartAttack)))
            {
                m.Disconnect(nameof(Magazine.ReloadedSuccessfully), weapon, nameof(Weapon.StartAttack));
            }
        }
    }
}
