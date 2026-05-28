OUTPUT=`niri msg focused-output | sed -n 's/Output ".*" (\(.*\))/\1/p'`; niri msg workspaces | sed -n "/Output \"$OUTPUT\":/,/Output/p" | sed -n "s/\*.\([0-9]*\).\?\(\"\(.*\)\"\)\?.*/\3;\1/p"
