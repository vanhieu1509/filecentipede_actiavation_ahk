^+a:: ; Ctrl + Shift + A
; --- Start ---
FileEncoding, UTF-8 ; Ensure UTF-8 encoding for reading/writing

url := "https://filecxx.com/en_US/activation_code.html"
file := A_Temp "\activation_page.html"

; Download the HTML file
URLDownloadToFile, %url%, %file%

; Check if the file was downloaded successfully
if (ErrorLevel || !FileExist(file))
{
    MsgBox, Error: Failed to download page from %url%.
    Return
}

; Read the HTML content
FileRead, htmlContent, %file%
if (ErrorLevel || htmlContent = "")
{
    MsgBox, Error: Failed to read HTML file content.
    Return
}

; Get today's date (YYYYMMDD)
FormatTime, currentDateTime,, yyyyMMddHHmmss

; Regex pattern for activation code inside <pre> section
pattern := "(\d{4}-\d{2}-\d{2} 00:00:00 - \d{4}-\d{2}-\d{2} 00:00:00)\s*([A-Za-z0-9_-]+)"
pos := 1
activationCode := ""
while (pos := RegExMatch(htmlContent, pattern, m, pos))
{
    ; Extract start and end dates from m1
    timeRange := m1
    RegExMatch(timeRange, "(\d{4}-\d{2}-\d{2}) 00:00:00 - (\d{4}-\d{2}-\d{2}) 00:00:00", dateMatch)
    startDateTime := StrReplace(dateMatch1, "-", "") . "000000"
    endDateTime := StrReplace(dateMatch2, "-", "") . "000000"

    ; Check if current date is within the range
    if (currentDateTime >= startDateTime && currentDateTime < endDateTime)

    {
        activationCode := m2
        break
    }
    ; Move past current match to avoid infinite loop
    pos += StrLen(m1) + StrLen(m2) + 1
}

; Check if an activation code was found
if (activationCode = "")
{
    FileAppend, %htmlContent%, %A_Temp%\debug_html.html
    MsgBox, No activation code found for current date (%currentDate%). HTML content saved to %A_Temp%\debug_html.html for debugging.
    Return
}

; Set activation code to clipboard
Clipboard := activationCode
ClipWait, 2
if (ErrorLevel)
{
    MsgBox, Error: Failed to copy activation code to clipboard.
    Return
}

; Clear existing content and paste the activation code
Send ^a
Sleep, 100
Send {Delete}
Sleep, 100
Send ^v

MsgBox, Activation code pasted: %activationCode%
Return
