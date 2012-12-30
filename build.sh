#!/bin/bash


build ()
{
    local target=$1
    echo "Building for $target"
	rm -fr out/target/product/"$target"/system
	rm -fr out/target/product/"$target"/*.zip
    if [ "$target" = "captivatemtd" ] || [ "$target" = "fascinatemtd" ] || [ "$target" = "galaxysmtd" ] || [ "$target" = "vibrantmtd" ] ; then
	cd bootable/recovery && git checkout devil_touch2
    else
	cd bootable/recovery && git checkout cm-10.1
    fi
	cd ~/android/android*
	
    . build/envsetup.sh && brunch $target
#    scp ~/android/android4.2/out/target/product/$target/Helly*.zip derteufel@ftp.andromirror.com:/hb42-$target
}
    
targets=("$@")
if [ 0 = "${#targets[@]}" ] ; then
    targets=(captivatemtd fascinatemtd galaxysmtd galaxysbmtd vibrantmtd crespo crespo4g i9100 i777 i9300 d2att d2spr n7000 n7100)
fi

START=$(date +%s)

for target in "${targets[@]}" ; do 
    build $target
done

END=$(date +%s)
ELAPSED=$((END - START))
E_MIN=$((ELAPSED / 60))
E_SEC=$((ELAPSED - E_MIN * 60))
printf "Elapsed: "
[ $E_MIN != 0 ] && printf "%d min(s) " $E_MIN
printf "%d sec(s)\n" $E_SEC
