function Get-CodePoint ([string]$s) {
    return [char]::ConvertToUtf32($s, 0)
}

function decomp ([string]$s) {
    if ($s -match '^0x[a-fA-F0-9]{4}$') {
        $s = [string][char][int]$s
    }

    $isSP = [char]::IsSurrogatePair($s, 0)
    $raw = $s.Substring(0, ($isSP ? 2 : 1))
    $nfc = $raw.Normalize([System.Text.NormalizationForm]::FormC)
    $nfkd = $raw.Normalize([System.Text.NormalizationForm]::FormKD)

    $fmt = ' {0,-6} : ''{1}'' (U+{2:X4})'
    $fmt -f 'Input', $raw, (Get-CodePoint $raw)
    $fmt -f 'NFC'  , $nfc, (Get-CodePoint $nfc)
    $fmt -f 'NFKD' , $nfkd, (Get-CodePoint $nfkd)
}