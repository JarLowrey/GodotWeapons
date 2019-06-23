using Godot;
using System;

public class Magazine : WeaponComponentParent
{
    [Signal]
    public delegate void ReloadedSuccessfully();
    [Signal]
    public delegate void ReloadCancelled();
    [Signal]
    public delegate void MagEmptied();
    [Signal]
    public delegate void MagDecremented(int amountLeft);

    public bool IsReloading { get; private set; }

    [Export]
    public bool AutoReload = false;
    [Export]
    public int MagSize = -1;

    private int amountLeftInMag;

    private float delayForReload = (float)1.0;
    [Export]
    public float ReloadDelay
    {
        get => delayForReload; set
        {
            delayForReload = value;
            if (IsInsideTree()) ReloadTimer.WaitTime = ReloadDelay;
        }
    }

    private Timer ReloadTimer;

    public override void _Ready()
    {
        base._Ready();
        ReloadTimer = (Timer)GetNode("ReloadTimer");
        ReloadTimer.Connect("timeout", this, nameof(SuccessfullyExitReloadClip));
        amountLeftInMag = MagSize;
        weapon.Connect(nameof(Weapon.AttackEnded), this, nameof(DecrementMagizineAmount));
    }


    public void Reload()
    {
        if (!IsReloading && weapon.CanAttack())
        {
            IsReloading = true;
            ReloadTimer.Start();
            weapon.EndAttack();
            // weapon.ExitAttackCooldown(); //if user reloads during attack cooldown, stop the cooldown timer ??
        }
    }
    public void CancelReload()
    {
        IsReloading = false;
        ReloadTimer.Stop();
        EmitSignal(nameof(ReloadCancelled));
    }

    protected void SuccessfullyExitReloadClip()
    {
        amountLeftInMag = MagSize;
        IsReloading = false;
        ReloadTimer.Stop();
        EmitSignal(nameof(ReloadedSuccessfully));
    }

    private void DecrementMagizineAmount()
    {

        if (amountLeftInMag > 0)
        {
            amountLeftInMag--;
            EmitSignal(nameof(MagDecremented), amountLeftInMag);

            if (amountLeftInMag == 0)
            {
                EmitSignal(nameof(MagEmptied));
                if (AutoReload) Reload();
            }
        }
    }
}
