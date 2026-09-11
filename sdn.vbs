Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

' Path to the file to check
targetFile = "C:\Users\DELL\Desktop\New Text Document.txt"

' Initialize the random number generator
Randomize

Do
    ' Check if the text file does NOT exist
    If Not objFSO.FileExists(targetFile) Then
        
        ' Calculate random time between 15 and 30 minutes
        ' Formula: Int((upperbound - lowerbound + 1) * Rnd + lowerbound)
        ' 15 mins = 900,000ms | 30 mins = 1,800,000ms
        lowerBound = 900000
        upperBound = 1800000
        waitTime = Int((upperBound - lowerBound + 1) * Rnd + lowerBound)
        
        ' Wait for the randomized duration
        WScript.Sleep waitTime
        
        ' Re-verify file is still missing after the wait
        If Not objFSO.FileExists(targetFile) Then
            ' Close the browsers with High Priority
            objShell.Run "cmd /c start """" /high taskkill /F /IM chrome.exe /T", 0, True
            objShell.Run "cmd /c start """" /high taskkill /F /IM firefox.exe /T", 0, True
            objShell.Run "cmd /c start """" /high taskkill /F /IM msedge.exe /T", 0, True
	    objShell.Run "cmd /c start """" /high taskkill /F /IM scalc.exe /T", 0, True
        End If
    End If

    ' Wait 60 seconds before scanning again
    WScript.Sleep 60000
Loop