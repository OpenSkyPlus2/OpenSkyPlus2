GSPro4OSP — Config Feature Guide

Config file: BepInEx\config\GsPro4Osp.json
Format: JSON
Reload: Settings are read at app start. Restart SkyTrak after editing.

Role of G4O2: This plugin bridges OpenSkyPlus2 (OSP2) to GSPro’s OpenConnect. It formats and sends shot data to GSPro and can request mode changes (Normal ↔ Putting) via OSP2 based on your rules below.

Connection
Hostname

What it does: Hostname/IP of the GSPro machine running OpenConnect.
When to change:

Keep 127.0.0.1 if GSPro runs on the same PC as SkyTrak.

Set to your LAN IP (e.g., 192.168.1.50) if GSPro runs on a different PC.
Impact: Wrong host = immediate connect failure.
Tip: If using a remote PC, allow inbound TCP on your Port (below) in Windows Firewall on the GSPro box.

Port

What it does: TCP port for GSPro OpenConnect.
When to change: Only if you changed the port in GSPro. Default is typically 921.
Impact: Must match GSPro exactly, or connection won’t establish.
UNLESS YOU NEED TO CHANGE THIS, DON'T.

Putting mode control (exact behavior)

These options decide when GSPro4OSP asks OSP2 to switch the device to Putting (or back to Normal). OSP2 performs the change on the hardware (and may soft-refresh depending on your OSP2 config).

DistanceToPtMode (integer)

Master switch & distance threshold:

Set to < 0 (e.g., -1) → Disabled: GSPro4OSP makes no mode requests. You must change manually.

Set to 0 → Club-only logic (distance is ignored).

Set to > 0 (e.g., 10, 15, 20) → Club AND Distance logic. Where the value is the distance to the pin in DistanceToPinUnit.

    If distanceToPin > 0, Putting is requested when (club is putting) OR (distance ≤ threshold).

    If distanceToPin ≤ 0 (unknown), fallback to club-only logic.

Internally, distance comparisons use meters via DistanceToPtModeInMeters.

--------------------------------------------------------------------------

DistanceToPtModeUnit ("meters", "feet"/"ft", "yards"/"yd")

Unit used to interpret DistanceToPtMode. Converted precisely to meters behind the scenes (ft×0.3048, yd×0.9144).

--------------------------------------------------------------------------

PuttingModeClubs (array of club abbreviations; comma separated)

List of clubs that you want Putting mode enabled for (case-insensitive) e.g., PT, LW, SW, etc.

PT is always treated as putting even if the list is empty. 

--------------------------------------------------------------------------

Interaction with OSP2:

G4O2 decides when to request Putting; OSP2 executes the hardware change and (optionally) performs a soft refresh after mode flips (see OSP2 config).

Reliability / Retries
MaxRetries

What it does: Number of times G4O2 will retry sending to GSPro on failure.
Conventions:

-1 → Unlimited retries (default).

0 → No retries (fail fast).

N>0 → Retry up to N times.

When to change:

If you frequently start GSPro after SkyTrak, leave unlimited or set a small positive number. 

If you want fast failure for debugging, set to 0.

-------------------------------------------------------------------------

RetryDelay (milliseconds)

What it does: Delay between retries.
Typical values: 5000–20000 ms.
Trade-off: Longer delays reduce busy-loops but increase time-to-recover if GSPro restarts.

-------------------------------------------------------------------------

Operational notes

Order of operations: With the default settings, it does not matter if you launch GSPro or SkyTrak first. I made it so you can connect however you want. With retries enabled, order is flexible; G4O2 will connect when OpenConnect is ready. There is also a retry connection button in the ExpandedUI which will manually attempt to connect to GSPro (in case of drops). 

LAN setups: If GSPro runs on another PC, confirm you can ping the host and that the firewall allows the Port on the GSPro machine.

Club vs distance precedence: Putting is requested when either rule fires (club match OR inside distance). To use distance-only, clear PuttingModeClubs and set a threshold > 0. To use club-only, keep DistanceToPtMode = 0.

Logs: Look for [GSPro4OSP] entries in BepInEx\LogOutput.log to verify connections and sends.

Safety & recovery

If you misconfigure something and lose connection, restore sensible defaults (127.0.0.1:921, keep retries on) and restart SkyTrak.

G4O2’s config file is created the first time the plugin runs. Delete it to regenerate defaults if needed.

Not affiliated. GSPro4OSP and OpenSkyPlus2 are independent community projects and are not affiliated with, endorsed by, or sponsored by SkyTrak, GOLFTEC, GSPro, or their parents, subsidiaries, or affiliates.