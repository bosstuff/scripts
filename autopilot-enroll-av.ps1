$ScriptAutoP = Invoke-WebRequest https://raw.githubusercontent.com/bosstuff/scripts/refs/heads/main/hardware-hash-from-end-autopilot.ps1
Invoke-Expression $($ScriptAutoP.content)
