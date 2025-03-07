# Show-NotepadOnTop

# Show-NotepadOnTop.ps1

## PowerShell Documentation

## Overview
This PowerShell script launches Notepad, sets its window to "always on top," and waits for user input before restoring its normal window behavior and closing it.

## Prerequisites
- Windows operating system
- PowerShell (tested on PowerShell 5.1 and later)

## Script Breakdown
### 1. Define the `WindowTop` Class
The script uses `Add-Type` to inject C# code that interacts with the Windows API via `user32.dll`. The class includes:
- `SetWindowPos` function: Changes window positioning properties.
- Constants:
  - `HWND_TOPMOST`: Keeps the window always on top.
  - `HWND_NOTOPMOST`: Restores the normal window behavior.
  - `SWP_NOSIZE`: Keeps the window size unchanged.
  - `SWP_NOMOVE`: Keeps the window position unchanged.
  - `SWP_SHOWWINDOW`: Ensures the window remains visible.

### 2. Launch Notepad
The script starts Notepad using `Start-Process` with the `-PassThru` flag to retain the process handle.

### 3. Wait for Initialization
A `Start-Sleep` command waits 500 milliseconds to allow Notepad to fully launch before proceeding.

### 4. Get Notepad's Window Handle
Retrieves the main window handle using `$notepadProcess.MainWindowHandle`.

### 5. Set Notepad as Always on Top
Calls `[WindowTop]::SetWindowPos` with `HWND_TOPMOST` to ensure Notepad remains on top of all other windows.

### 6. Wait for User Input
Displays a message prompting the user to press any key before closing Notepad. The script remains active using `$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")`.

### 7. Restore Normal Window Behavior and Close Notepad
Before exiting:
- The script calls `SetWindowPos` with `HWND_NOTOPMOST` to restore Notepad’s default behavior.
- `CloseMainWindow()` is used to close Notepad gracefully.

## Usage
Run the script in PowerShell:

```powershell

.\path\to\script.ps1
```

## Notes
- The script ensures Notepad stays on top only while it is running.
- If Notepad is manually closed before user input, the script may fail to restore its normal behavior.
- The script does not force Notepad to remain open indefinitely; it only controls the window state while running.

## Customization
- To change the target application, replace `notepad` in `Start-Process` with another executable.
- Modify `Start-Sleep` duration if the target application takes longer to initialize.
- Remove or modify the final `CloseMainWindow()` call to prevent forced closure of Notepad.

