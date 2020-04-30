

total=0
ok=0
renamed=0	
for f in *
do
	y=${f: -4}
	ett=$( echo $y | tr '[:upper:]' '[:lower:]')
	std=$(date -r "$f" +"%Y%m%d_%H%M%S")
	
	if [[ $ett == @(.jpg|.png|.mov|.mp4) ]]
	then 
		# se ja existe um outro arquivo com a data.
		# current name is dated.
		echo "$f > "$std$ett""		
		if [[ ! -f $std$ett ]] && [[ ! $f =~ ^$std ]];then
			mv -n "$f" "$std$ett"	
			echo "Renamed to standard."
			let total=$total+1
			let renamed=$renamed+1
		elif [[ ! $f =~ ^$std ]]; then			
			suffix=1
			until ! [[ -f $std_$suffix$ett ]]; do
			    suffix=$((suffix+1))
		    	done
			mv -n $f $std"("$suffix")"$ett	
			echo "Renamed to standard with suffix"
			let total=$total+1
			let renamed=$renamed+1
		else 					
			[[ $f =~ ^$std ]] && echo "Standard ok."	
			let total=$total+1
			let ok=$ok+1
		fi		
	fi
done
echo "Analysed: "$total". Ok: "$ok". Renamed: "$renamed"."