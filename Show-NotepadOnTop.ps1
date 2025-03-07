Add-Type @"
  using System;
  using System.Runtime.InteropServices;
  public class WindowTop {
      [DllImport("user32.dll")]
      [return: MarshalAs(UnmanagedType.Bool)]
      public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);

      public static readonly IntPtr HWND_TOPMOST = new IntPtr(-1);
      public static readonly IntPtr HWND_NOTOPMOST = new IntPtr(-2);
      public const UInt32 SWP_NOSIZE = 0x0001;
      public const UInt32 SWP_NOMOVE = 0x0002;
      public const UInt32 SWP_SHOWWINDOW = 0x0040;
  }
"@

# Launch Notepad
$notepadProcess = Start-Process notepad -PassThru

# Wait a moment for the window to initialize
Start-Sleep -Milliseconds 500

# Get the main window handle of Notepad
$notepadHandle = $notepadProcess.MainWindowHandle

# Keep Notepad always on top
[WindowTop]::SetWindowPos($notepadHandle, [WindowTop]::HWND_TOPMOST, 0, 0, 0, 0, [WindowTop]::SWP_NOMOVE -bor [WindowTop]::SWP_NOSIZE -bor [WindowTop]::SWP_SHOWWINDOW)

# Optional: Keep the script running to maintain the always-on-top state
Write-Host "Notepad is running and set to always be on top. Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# Optional: Restore normal window behavior and close Notepad when script ends
[WindowTop]::SetWindowPos($notepadHandle, [WindowTop]::HWND_NOTOPMOST, 0, 0, 0, 0, [WindowTop]::SWP_NOMOVE -bor [WindowTop]::SWP_NOSIZE -bor [WindowTop]::SWP_SHOWWINDOW)
$notepadProcess.CloseMainWindow()