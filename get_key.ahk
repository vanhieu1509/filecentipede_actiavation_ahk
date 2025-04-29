^+a:: ; Ctrl + Shift + A
; --- Bắt đầu ---
FileEncoding, UTF-8 ; Đảm bảo đọc ghi đều dùng UTF-8

url := "https://filecxx.com/en_US/activation_code.html"
file := A_Temp "\activation_page.html"

; Tải file HTML
URLDownloadToFile, %url%, %file%

; Kiểm tra xem file có tải thành công không
if (ErrorLevel || !FileExist(file))
{
    MsgBox, Lỗi: Không thể tải trang web từ %url%.
    Return
}

; Đọc nội dung HTML
FileRead, htmlContent, %file%
if (ErrorLevel || htmlContent = "")
{
    MsgBox, Lỗi: Không thể đọc nội dung file HTML.
    Return
}

; Lấy ngày hiện tại (YYYYMMDD)
FormatTime, currentDate,, yyyyMMdd

; Tìm tất cả các khoảng thời gian và mã kích hoạt trong thẻ <pre>
pattern := "(\d{4}-\d{2}-\d{2} 00:00:00 - \d{4}-\d{2}-\d{2} 00:00:00)\s*([A-Za-z0-9_-]+)"
pos := 1
activationCode := ""
while (pos := RegExMatch(htmlContent, pattern, m, pos))
{
    ; Lấy ngày bắt đầu và kết thúc từ m1
    timeRange := m1
    RegExMatch(timeRange, "(\d{4}-\d{2}-\d{2}) 00:00:00 - (\d{4}-\d{2}-\d{2}) 00:00:00", dateMatch)
    startDate := StrReplace(dateMatch1, "-", "") ; Ví dụ: 20250424
    endDate := StrReplace(dateMatch2, "-", "")   ; Ví dụ: 20250501

    ; Kiểm tra xem ngày hiện tại có nằm trong khoảng thời gian không
    if (currentDate >= startDate && currentDate <= endDate)
    {
        activationCode := m2
        break
    }
    ; Cập nhật pos để tránh vòng lặp vô tận
    pos += StrLen(m1) + StrLen(m2) + 1 ; Di chuyển qua khoảng thời gian, mã kích hoạt và ít nhất 1 ký tự
}

; Kiểm tra xem có tìm thấy mã kích hoạt không
if (activationCode = "")
{
    FileAppend, %htmlContent%, %A_Temp%\debug_html.html
    MsgBox, Không tìm thấy mã kích hoạt cho ngày hiện tại (%currentDate%). Nội dung HTML đã được lưu vào %A_Temp%\debug_html.html để kiểm tra.
    Return
}

; Gán activation code vào clipboard
Clipboard := activationCode
ClipWait, 2
if (ErrorLevel)
{
    MsgBox, Lỗi: Không thể sao chép mã kích hoạt vào clipboard.
    Return
}

; Xóa nội dung cũ và dán activation code mới
Send ^a
Sleep, 100
Send {Delete}
Sleep, 100
Send ^v

MsgBox, Đã dán mã kích hoạt: %activationCode%
Return
