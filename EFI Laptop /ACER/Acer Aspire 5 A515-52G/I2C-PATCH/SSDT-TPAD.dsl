/*
 * Find _CRS:          5F 43 52 53
 * Replace XCRS:       58 43 52 53
 * Target Bridge TPAD: 54504144
 */
DefinitionBlock("", "SSDT", 2, "hack", "I2Cpatch", 0)
{
    External(_SB.PCI0.I2C1.TPAD, DeviceObj)
    External(_SB.PCI0.I2C1.TPAD.SBFB, IntObj)
    External(_SB.PCI0.I2C1.TPAD.SBFG, IntObj)
    External(OSYS, FieldUnitObj)
    External(_SB.PCI0.I2C1.TPAD.HID2, IntObj)
    Scope(_SB.PCI0.I2C1.TPAD)
    {
                Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                {
                    Local0 = Zero
                    Local1 = Zero
                    Local1 = DerefOf (DerefOf (TPID [Local0]) [Zero])
                    While (((Local1 != 0xFE) && (Local1 != TPDF)))
                    {
                        Local0++
                        If ((Local0 >= SizeOf (TPID)))
                        {
                            Break
                        }

                        Local1 = DerefOf (DerefOf (TPID [Local0]) [Zero])
                    }

                    ADR0 = DerefOf (DerefOf (TPID [Local0]) [One])
                    HID2 = DerefOf (DerefOf (TPID [Local0]) [0x02])
                    If ((OSYS < 0x07DC))
                    {
                        Return (ConcatenateResTemplate (SBFB, SBFG)) // Usually this return won't function, please check your Windows Patch
                    }

                    If (Ones)
                    {
                        Return (ConcatenateResTemplate (SBFB, SBFG))
                    }

                    Return (ConcatenateResTemplate (SBFB, SBFG))
                }
    }
}