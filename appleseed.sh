#!/usr/bin/env bash
# appleseed is a command line widget (CLW), designed for macOS and iTerm2.

#Variables
args=("$@")
endscript="false"
imgcat="/Users/matthew/.iterm2/imgcat"
minutes="10"
status1="Working.. "
copying="Copying.. "
host=$HOSTNAME
DIR="$HOME/git/appleseed/img"
BDIR="$HOME/git/appleseed/backup" #your backup directory
IFS='
'

#What do you want to backup?
dotfile0="$HOME/.zshrc"
dotfile1="$HOME/.oh-my-zsh/themes/trident.zsh-theme"
dotfile2="$HOME/Library/Fonts/Hack-Regular.ttf"
dotfile3="$HOME/.tmux.conf"
dotfile4="/etc/tmux.conf.local"
dotfile5="$HOME/osxui/okeanos/demo/trident.coffee"
#dotfile6=""
#dotfile7=""
#dotfile8=""
many="6"

#Colors
reset="$(tput sgr0)"
#black="$(tput bold; tput setaf 0)"
blue="$(tput bold; tput setaf 4)"
cyan="$(tput bold; tput setaf 6)"
green="$(tput bold; tput setaf 2)"
purple="$(tput bold; tput setaf 5)"
red="$(tput bold; tput setaf 1)"
#white="$(tput bold; tput setaf 7)"
yellow="$(tput bold; tput setaf 3)"
orange=$(tput bold; tput setaf 166);
#violet=$(tput bold; tput setaf 61);
header="${cyan}[ ${reset}${green}${reset}${cyan} appleseed @ ${blue}${host}${reset} ${cyan}]${reset}"
backup="${purple}Backup:${reset}"
packages="${purple}Packages:${reset}"
network="${purple}Network:${reset}"
resources="${purple}Resources:${reset}"

#Arguments
version=${cyan}1.0.0${reset}

license="
${cyan}${reset} appleseed v${version}

        ${purple}Copyright (C) 2018 Matthew A. Brassey${reset}

        This program is free software: you can redistribute it and/or modify
        it under the terms of the GNU General Public License as published by
        the Free Software Foundation, either version 3 of the License, or
        (at your option) any later version.

        This program is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        GNU General Public License for more details.

        You should have received a copy of the GNU General Public License
        along with this program.  If not, see <http://www.gnu.org/licenses/>.
"

help="
${cyan}Usage:${cyan}${green} ./appleseed.sh ${reset}${purple}[--help|--version]${reset}

${cyan}[options]${reset}${green}
        --license       Show lisense information.
        --about         What is appleseed?${reset}
"

about="
${cyan}${reset} appleseed v${version}

        Is a command line widget (CLW), designed for macOS and iTerm2. For best results,
        launch in a tall by thin proportioned shell.
"

#Functions
function panel() {
       start=$SECONDS
       clear
       echo "$header"
       echo ""
       echo "$backup"
       backup
       echo ""
       echo "$packages"
       macOS
       homebrew
       echo ""
       echo "$network"
       network
       echo ""
       echo "$resources"
       system
       echo ""
       graphix

#Sleep sequence
       completed
       secs=$((minutes * 60))
       while [ $secs -gt 0 ]; do
          echo -ne "${blue}╰────╼${reset}${green} Re-launch in:${reset} ${cyan}$secs\\033[0Ks\\r${reset}"
          sleep 1
          : $((secs--))
       done
}

function graphix() {
     if [[ -d "${DIR}" ]]
     then
       file_matrix=($(ls "${DIR}"))
       num_files=${#file_matrix[*]}
       $imgcat "${DIR}/${file_matrix[$((RANDOM%num_files))]}"
     fi
}

function homebrew() {
      echo "${cyan}[${reset} ${blue}Homebrew: ${reset} ${yellow}$status1${reset} ${cyan}]${reset}"
      temp0="$(brew update 2>&1)"
      if [[ "$temp0" = *"Already"* ]]; then
      status4="${green}Updated!${reset}"
      img_brew="✔"
      echo "${cyan}[${reset} ${blue}Homebrew: ${reset} ${green}$status4${reset}   ${cyan}]${reset}"
      else
      status4="${orange}Missing!${reset}"
      echo "${cyan}[${reset} ${blue}Homebrew: ${reset} ${green}$status4${reset}   ${cyan}]${reset}"
      img_brew="${orange}✗${reset}${cyan}"
          if [[ "$temp0" = *"Updated"* ]]; then
          echo "${cyan}[${reset} ${green}✔ ${temp0:0:14}${reset}      ${cyan}]${reset}"
          img_brew="✔"
          fi
      fi
      brew_ver="$(brew --version 2>&1)"
      brew_ver_num=(${brew_ver[@]})
      echo "${cyan}[${reset}${cyan} $img_brew $brew_ver_num${reset}     ${cyan}]${reset}"
      temp0=""
}

function macOS() {
      echo "${cyan}[${reset} ${blue}macOS:    ${reset} ${yellow}$status1${reset} ${cyan}]${reset}"
      temp="$(softwareupdate -l 2>&1)"
#      temp="No"
      temp2="$(echo "$temp"|grep "No" 2>&1)"
      if [ -s "$temp2" ]
      then
      status3="${red}Missing!${reset}" #need root to actually update macOS
      img_os="${orange}✗${reset}${cyan}"
      else
      status3="${green}Updated!${reset}"
      img_os="✔"
      fi
      echo "${cyan}[${reset} ${blue}macOS:    ${reset} ${yellow}$status3${reset}   ${cyan}]${reset}"
      os_ver="$(sw_vers -productVersion 2>&1)"
      echo "${cyan}[${reset} ${cyan}$img_os macOS ${reset}${cyan}$os_ver${reset}       ${cyan}]${reset}"
      temp2=""
}

function network(){
      public_ip=$(wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//')
      city_raw=$(curl ipinfo.io/"$public_ip" 2>&1|grep city|sed 's/\(.*\)../\1/')
      city=${city_raw:11}
      region_raw=$(curl ipinfo.io/"$public_ip" 2>&1|grep region|sed 's/\(.*\)../\1/')
      region=${region_raw:13}
      country_raw=$(curl ipinfo.io/"$public_ip" 2>&1|grep country|sed 's/\(.*\)../\1/')
      country=${country_raw:14}
      echo "• ${blue}IP: ${reset}${green}$public_ip${reset}"
      if [ -s "$city" ]
      then
      :
      else
      echo "• ${blue}City: ${reset}${green}$city${reset}"
      fi
      if [ -s "$region" ]
      then
      :
      else
          if [ "$region" == "$city" ]
          then
          :
          else
          echo "• ${blue}Region: ${reset}${green}$region${reset}"
          fi
      fi
      if [ "$country" != "US" ]
      then
      vpn="${cyan}✔ ${reset}${green}VPN${reset}"
      else
      vpn="${orange}✗ ${reset}${yellow}VPN${reset}"
      fi
      echo "• ${blue}Country: ${reset}${green}$country${reset}       $vpn"
}

function backup(){
     count="0"
     echo "${cyan}[${reset} ${blue}dotfiles:  ${reset}${yellow}$copying${reset} ${cyan}]${reset}"

     if [ -f "$dotfile0" ]
     then
     cp "$dotfile0" "${BDIR}" 2>&1
     ((count++))
     else
     :
     fi

     if [ -f "$dotfile1" ]
     then
     cp "$dotfile1" "${BDIR}" 2>&1
     ((count++))
     else
     :
     fi

     if [ -f "$dotfile2" ]
     then
     cp "$dotfile2" "${BDIR}" 2>&1
     ((count++))
     else
     :
     fi

     if [ -f "$dotfile3" ]
     then
     cp "$dotfile3" "${BDIR}" 2>&1
     ((count++))
     else
     :
     fi

     if [ -f "$dotfile4" ]
     then
     cp "$dotfile4" "${BDIR}" 2>&1
     ((count++))
     else
     :
     fi

     if [ -f "$dotfile5" ]
     then
     cp "$dotfile5" "${BDIR}" 2>&1
     ((count++))
     else
     :
     fi

#     if [ -f "$dotfile6" ]
#     then
#     :
#     ((count++))
#     else
#     :
#     fi

     if [ $count -eq $many ]
     then
     img_backup="✔"
     else
     img_backup="${orange}✗${reset}"
     fi
     echo "${cyan}[${reset} ${cyan}$img_backup Copied:  ${reset}${green}$count${reset}/${cyan}$many${reset}${cyan} files!${reset} ${cyan}]${reset}"

}

function system(){
     cpu2=$(top -l 2 -n 0 -F | egrep -o ' \d*\.\d+% idle' | tail -1 | awk -F% -v prefix="$prefix" '{ printf "%s%.1f%%\n", prefix, 100 - $1 }') # – mklement0
     cpu1=${cpu2::-3}
     cpu0=$((100 - $cpu1))
     if [ "$cpu0" -lt "10" ]
     then 
     cpu=" ${orange}"$cpu0"%${reset} "
     else
     cpu="${green}"$cpu0"%${reset} " 
     fi 
     capacity=$(df -h /)
     capacity2=$capacity[2]
     capacity2=$(echo ${capacity:110:-30}) 
     capacity3=$((100 - $capacity2))
     echo "${cyan}[ ${reset}${blue}SSD:${reset} ${green}$capacity3${reset}${green}%${reset}${cyan} ]${reset} ${cyan}[ ${reset}${blue}CPU:${reset} $cpu${cyan}]${reset}"
}
function completed(){
      duration=$(( SECONDS - start ))
      echo "${blue}╭────╼${reset}${purple} Completed in: ${reset}${cyan}$duration${reset}${cyan}s${reset}"
}

#Arguments
for ((arg=0;arg<"${#args[@]}";arg++)); do
        [ "${args[$arg]}" == "--version" ] && echo "${version}" && exit
        [ "${args[$arg]}" == "--help" ] && echo "${help}" && exit
        [ "${args[$arg]}" == "--license" ] && echo "${license}" && exit
        [ "${args[$arg]}" == "--about" ] && echo "${about}" && exit
        #[ "${args[$arg]}" == "--" ] && echo ${args[$arg]}
done

#Activate panel
while [ $endscript = "false" ]
do
        panel
done
