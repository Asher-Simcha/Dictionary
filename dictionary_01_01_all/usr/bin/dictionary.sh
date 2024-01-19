#!/usr/bin/bash
# Title: Dictionary
# Author: Asher Simcha
# _____/\\\\\\\\\________/\\\\\\\\\\\____/\\\________/\\\__/\\\\\\\\\\\\\\\____/\\\\\\\\\_____        
#  ___/\\\\\\\\\\\\\____/\\\/////////\\\_\/\\\_______\/\\\_\/\\\///////////___/\\\///////\\\___       
#   __/\\\/////////\\\__\//\\\______\///__\/\\\_______\/\\\_\/\\\_____________\/\\\_____\/\\\___      
#    _\/\\\_______\/\\\___\////\\\_________\/\\\\\\\\\\\\\\\_\/\\\\\\\\\\\_____\/\\\\\\\\\\\/____     
#     _\/\\\\\\\\\\\\\\\______\////\\\______\/\\\/////////\\\_\/\\\///////______\/\\\//////\\\____    
#      _\/\\\/////////\\\_________\////\\\___\/\\\_______\/\\\_\/\\\_____________\/\\\____\//\\\___   
#       _\/\\\_______\/\\\__/\\\______\//\\\__\/\\\_______\/\\\_\/\\\_____________\/\\\_____\//\\\__  
#        _\/\\\_______\/\\\_\///\\\\\\\\\\\/___\/\\\_______\/\\\_\/\\\\\\\\\\\\\\\_\/\\\______\//\\\_ 
#         _\///________\///____\///////////_____\///________\///__\///////////////__\///________\///__2024
# Additional Authors: 
# Additional Authors: 
# Filename: dictionary.sh
# Description: This is a dictionary, no searching the internet.
# Additional_Notes: 
# Version: 1
# Date: 01-19-2024
# Last_Modified: 01-19-2024
# Source: https://github.com/Asher-Simcha/Dictionary/tree/main
# Additional_Sources: 
# License: The 2-Clause BSD License
# Additional_Licenses: 
# Credits: 
# Additional Credits: Icon Created by: https://openverse.org/image/93fdcc74-1c81-4cc4-839b-cff4683f6700?q=open%20book
# Additional Credits: 
# Audio_Location: 
# Location_of_the_Video: 
# Embed_YouTube: 
# Website_For_Video: 
# Start_Time: 
# Parent_File: /usr/bin/dictionary.sh
# Sibling_File: /usr/bin/yad
# Sibling_File: /usr/bin/dict 
# Sibling_File: 
# Child_File: /usr/share/applications/dictionary.desktop
# Child_File: /usr/share/icon/dictionary.png
# Child_File: /usr/share/pixmaps/dictionary.png
# Child_File: 
# Linkable: 1
# Display_Links: 1
# Display_Code: 1
# Visible: 1
# The 2-Clause BSD License # https://opensource.org/license/bsd-2-clause/
# Copyright 2024 Gregory Wienands
# Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
# 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
DICTIONARY="/usr/bin/dict"
YAD="/usr/bin/yad"
TMPFILE="$HOME/dic_tmp.txt"
CheckFileSystem(){
    if [ ! -e $DICTIONARY ]; then echo "You need to install dict before the program can continue."; exit 1; fi
    if [ ! -e $YAD ]; then echo "You need to install yad before the program can continue."; exit 1; fi
}
Question(){
    YADRESULTS=$(${YAD} --form \
    --window-icon="/usr/share/icons/dictionary.png" \
    --title="Dictionary" \
    --width="400" \
    --field="Word(s) to Define: ")
    RESULTS=$? # This is the exit code from yad 
    if [ $RESULTS -eq "1" ]; then exit 0; fi
    echo "YADRESULTS $YADRESULTS"
    # if the response was blank
    if [ "$YADRESULTS" == "|" ]; then Question; fi
    # replace the output | with a space
    YADRESULTS=$(echo "$YADRESULTS" | sed 's/|/ /g' )
    # run the dictionary program output to tmp file.
    ${DICTIONARY} $YADRESULTS > $TMPFILE
    Display
}
Display(){
    # display the tmp file to the screen
    $YAD --text-info \
    --window-icon="/usr/share/icons/dictionary.png" \
    --title="Dictionary" \
    --width="700" \
    --height="600" \
    --filename="$TMPFILE"
    RESULTS=$? # This is the exit code
    rm $TMPFILE
    if [ $RESULTS -eq "1" ]; then
        exit 0;
    else
        Question
    fi
}
main(){
    CheckFileSystem
    Question
}
main
# EOF
