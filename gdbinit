# python
# import sys
# import os
# sys.path.insert(0, os.path.expanduser('~/src/printers/python'))
# from libstdcxx.v6.printers import register_libstdcxx_printers
# register_libstdcxx_printers (None)
# end

define printMatrix
set $n = $arg0
set $m = $arg1
set $arr = $arg2

set $r = 0
while $r < $n
printf "[ "
set $c = 0
while $c < $m - 1
printf "%d\t", $arr[$r][$c]
set $c = $c + 1
end
printf "%d ]\n", $arr[$r][$m - 1]
set $r = $r + 1
end
end
