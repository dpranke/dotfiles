# Report the total number of bytes used in the current directory
# and all of its subdirectories.
$totalsize=[long]0;
gci -File -r -fo -ea Silent|%{$totalsize+=$_.Length};
$totalsize;
