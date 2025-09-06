OpenSkyPlus 2 — Config Feature Guide

Config file: BepInEx\config\OpenSkyPlus2.cfg
Format: INI (BepInEx ConfigFile)
Reload: Settings are read at app start. Restart SkyTrak after editing. If changes are made in the UI, they can be saved and are applied immediately.

The on-screen OSP2 UI only exposes the main options. Everything below can be edited in the .cfg for fine-grained control.

Logging
Logging:LogPath

What it does: Sets a dedicated logfile for OSP2 (in addition to BepInEx’s LogOutput.log).
Why you’d change it: Put logs somewhere easy to share for support, or onto a faster drive.
Gotchas: If you point to a protected folder, Windows may block writes.

Logging:LogLevel (Info | Debug | Warn | Error)

What it does: Controls verbosity of OSP2 log messages.
When to change: Use Debug when diagnosing device/telemetry issues.
Keep "Info" for normal play to minimize overhead.
Impact: Higher verbosity = more disk I/O and potentially noisier logs.

Launch Monitor
Launch Monitor:LaunchMonitor

What it does: Human-readable name of the connected Launch Monitor. Auto-detected and used in the UI and internal routing.
When to change: Rarely. Only if you’re testing alternate device strings.

Launch Monitor:AppPath

What it does: Optional absolute path to the vendor app/exe.
When to change: If you want helper tooling to know exactly where the app lives (e.g., future diagnostics).
Impact: Does not affect BepInEx hooking or plugin loading.
ONLY USE IF NECESSARY.

Plugins
Plugins:PluginPath

What it does: Base folder where OSP2 looks for plugin assemblies (e.g., GSPro4OSP).
When to change: If you maintain custom plugin layouts.
Impact: Moving this without moving your plugins will make them disappear from discovery.
Leave default, unless required.

Gameplay
Gameplay:EnableSmartDataInterpolation (bool)

What it does: Turns on SmartShotInterpolator to include advanced metrics (e.g., AoA, Face-to-Path) using cascading inference aligned to in-range physics and the selected club in GSPro.
When to change: If you want all metrics that can be provided to GSPro, enable this. Please note: These will be calculated using physics/math models (similarly to how the app does when in the driving range). 

Off for purist “measured-only” sessions.
Behavior: OSP2 does not overwrite known measured values; it fills gaps and stabilizes outliers.
Trade-off: Slight CPU cost per shot; capped by your internal compute budget.

Gameplay:RefreshConnectionAfterModeSwitch (bool)

What it does: Performs a soft device refresh after switching Normal ↔ Putting.
Why it matters: Some firmware/app combos “stick” after a mode flip; this keeps hardware state honest.
When to change: Keep off unless you see a reaason to add a delay to the switch.

Gameplay:ShortPuttClampEnabled (bool)

What it does: Applies a safety clamp to Horizontal Launch Angle (HLA) for short putts within the PuttingDistanceThreshold.
Why: Putts can exhibit exaggerated HLA due to misreads; the clamp keeps them playable.
When to change: Turn Off if you want raw HLA on short putts.
Interaction: Uses the next two settings to define when/how strongly it clamps.

Gameplay:PuttingDistanceThreshold

Units: meters (when changed in the UI, it is in feet).
What it does: Distance-to-pin at or within which the short-putt clamp applies.
Typical values: 3–8 m. Default 6 m suits most setups.
Note: GSPro4OSP obtains the distanceToTarget from GSPro, and OSP2 uses that to determine when to clamp to your desired PuttingMaxHLADeviation. All distances are converted from meters (back-end default) to feet automatically.

Gameplay:PuttingMaxHLADeviation

Units: degrees
What it does: Maximum HLA allowed for short putts (when within the threshold).
Typical values: 1–3°. Lower = straighter short putts; higher = more “raw” feel.

Gameplay:ShotConfidence (Forgiving | Normal | Strict) 

What it does: Selects the minimum confidence floor OSP2 accepts for a shot.
Effect:

Forgiving — lets borderline reads through (fewest drops).

Normal — balanced gate (default).

Strict — drops anything questionable (cleanest data, most drops).
When to change: If you see spurious reads, try Strict. If valid shots are being filtered, try Forgiving.

Gameplay:ThresholdForgiving / ThresholdNormal / ThresholdStrict

What they do: Advanced numeric floors (0.0–1.0) used internally by the three confidence modes above.
When to change: Only if you’re tuning at a developer level. The defaults are calibrated for typical SkyTrak+ behavior.
Tip: Small changes go a long way (±0.05). Note: When SmartShotInterpolator is enabled, the confidence value is weighted across all metrics. Default is forgiving and should work for most users since the interpolator cannot function with bad data.

UI

UI:ExpandedPanelWidthPct

Range: 0.0–1.0 (fraction of screen width)
What it does: Sets the width of the expanded OSP2 overlay.
Why you’d change it: Make logs/controls more readable on ultrawide or 1080p screens.
Notes: Values outside 0–1 are clamped.

UI:ExpandedPanelHeightPct

Range: 0.0–1.0 (fraction of screen height)
What it does: Sets the height of the expanded overlay.
Best practice: Keep the minimized bar clear of SkyTrak’s on-screen Exit area; the overlay is intentionally designed not to cover that control.

How these options work together

Interpolation + Confidence: Interpolation can complete otherwise valid shots; Strict confidence may still drop them if upstream signals are weak. If strict mode is filtering real putts, either lower to Normal or slightly ease the strict floor.

Short putt handling: The clamp is OSP2-side only; mode switching is driven by GSPro or by your G4O2 distance/club rules.

Stability around mode flips: Keep RefreshConnectionAfterModeSwitch off unless you’ve proven your firmware + scene flow needs it.


If you break something in this config, delete or rename OpenSkyPlus2.cfg and OSP2 will rebuild it with defaults on next launch.

Logs live at LogPath (BepInEx\LogOutput.log). Include config and logs in all bug reports.