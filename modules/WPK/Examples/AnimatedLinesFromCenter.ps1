New-Window -On_Loaded { 
    $this | Enable-MultiTouch
} -WindowStyle None -WindowState Maximized -On_StylusDown {
    $to = $_.GetPosition($this)        
    $from = New-Object Windows.Point -Property @{
        X = $this.ActualWidth / 2
        Y = $this.ActualHeight / 2
    }
    $xanimation = 
        New-DoubleAnimation -From $from.X -To $to.X -Duration ([Timespan]::FromMilliseconds(250))
    $yanimation = 
        New-DoubleAnimation -From $from.Y -To $to.Y -Duration ([Timespan]::FromMilliseconds(250))
            
    $line = New-Line -Stroke Black `
        -X1 $from.X `
        -X2 $from.X `
        -Y1 $from.Y `
        -Y2 $from.Y 
    $line | 
        Add-ChildControl $this.Content
    $line | 
        Start-Animation -property X2 -animation $xanimation
    $line | 
        Start-Animation -property Y2 -animation $yanimation
} {
    New-Canvas 
} -show