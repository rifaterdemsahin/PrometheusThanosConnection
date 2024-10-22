# Setting Path in Windows PowerShell

To set the path for `oc.exe` in Windows PowerShell, follow these steps:

1. Open Windows PowerShell as an Administrator.
2. Run the following command to add `c:\Projects\oc` to your system's PATH environment variable:

    ```powershell
    [System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";c:\Projects\oc", [System.EnvironmentVariableTarget]::Machine)
    ```

3. Verify that the path has been added by running:

    ```powershell
    $env:Path
    ```

4. You should now be able to run `oc` from any directory in PowerShell.

    ```powershell
    oc.exe
    ```

This will ensure that `oc.exe` is recognized system-wide.
