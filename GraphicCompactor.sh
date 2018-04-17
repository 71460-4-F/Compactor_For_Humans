#!/bin/bash
#                                                                                                By Tiago A.F.
#                                                                                             UFC-CAMPUS-QUIXADÁ
#                                                                                               DATE 25/11/2017
 clear
 DIR=$(dialog --stdout --title "Select the desired directory" --fselect / 12 100)
 if [ $? == 1 ]; then
    dialog --infobox " Operation canceled!" 3 27; sleep 3
    clear
    exit
 fi
 CONTENT=$(ls $DIR -l | grep ^- | awk '{ print $9 }' | sed -e '$a\' -e '' | sed ':a;$!N;s/\n/ "To compact" off /g;ta')
 if [ $? == 1 ]; then
    dialog --infobox " Operation canceled!" 3 27; sleep 3
    clear
    exit
 fi
 SELECTED=$(dialog --stdout --title "Select the files to be compressed: " --checklist " Press space to select" 8 100 0 $CONTENT)
 if [ $? == 1 ]; then
    dialog --infobox " Operation canceled!" 3 27; sleep 3
    clear
    exit
 fi
 OPTION=$(dialog --stdout --menu "Choose the type of compression: " 0 50 0 1 tar.gz 2 tar.bz2)
 if [ $? == 1 ]; then
    dialog --infobox " Operation canceled!" 3 27; sleep 3
    clear
    exit
 fi
 if [ $OPTION == 1 ]; then
    NAME_ARCHIVE_COMPRESED=$(dialog --stdout --inputbox "Type the name of the compressed file: " 0 50)
    if [ $? == 1 ]; then
       dialog --infobox " Operation canceled!" 3 27; sleep 3
       clear
       exit
    fi
    DIR_LOCAL=$(pwd)'/'
    cd $DIR
    tar -zcvf $DIR_LOCAL$NAME_ARCHIVE_COMPRESED.tar.gz $SELECTED
    dialog --msgbox "Archive $NAME_ARCHIVE_COMPRESED.tar.gz successfully compacted!!!" 6 50
    clear
    exit
 elif [ $OPTION == 2 ]; then
    NAME_ARCHIVE_COMPRESED=$(dialog --stdout --inputbox "Type the name of the compressed file: " 0 50)
    if [ $? == 1 ]; then
       dialog --infobox " Operation canceled!" 3 27; sleep 3
       clear
       exit
    fi
    DIR_LOCAL=$(pwd)'/'
    cd $DIR
    tar -jcvf $DIR_LOCAL$NAME_ARCHIVE_COMPRESED.tar.bz2 $SELECTED
    dialog --msgbox "Archive $NAME_ARCHIVE_COMPRESED.tar.bz2 successfully compacted!!!" 6 50
    clear
    exit
 else
    dialog --infobox " Operation canceled!" 3 27; sleep 3
    clear
    exit
 fi
