#! /bin/bash 
#this is called a shebang,it tells the shell what program
#to interpret the script 
#this command means run this script in bash
# My first script
#ABle to use the exists function to check for one at a time
#==Function to check the existence of the softaware========
exist_func()
{
  command -v "$1" >/dev/null 2>&1 #linux inbuilt command to do that
}

#function to clone machine over the same network
network_func()
{
  
  read -p "Provide hostname: example: kelvin@ip_address:/path:  " host
  
 #user hostname is provided here 
if [[  $host == *[@:]* ]]
  then
   #the hostname is checked if it contains an @. or / all compulsory
    #this is to provide the user's details
    echo $host

  if  [ "$(ping -c 1 google.com)" ]
   then
      #service network-manager restart
      direct="$HOME/src"
      if [ -e "$direct" ]
       then #to check if drectory exits
        cd $direct
        scp -rv $host ./$

      else 
        echo "Directory doesn't exits"
      fi
    else
      echo "Sorry"
    fi
else 
    echo "Host is invalid"
fi
}

#function to clone from hard drive 
enterPath_func()
{    
read -p "Enter Path to: " paths #get directory from user
if [ -e "$paths" ]; then #check validity of the path provided
  #echo $PATH
  #theLength=$((${#PATH}))
  #echo $theLength
  z=${paths:1:4}  #trim the length to get root directory
  h="home"
     #get the user details 
  if [ "$z" == "$h" ];then   #compare if trimmed is same as home
             #set default directory for comparison
    direct="$HOME/src"  
    if [ -e "$direct" ]; then #check if directory src exits 
       cp -rv $paths $direct  #copy folder from path to src
        lastPath= basename $paths #get basename of path entered by user
        read -p "Provide Domain name: " domain #get domain name from user
        cd /opt/interns/                         #get into the opt intern folder
        sudo ln -s $HOME/src/lastPath ./$domain #create a link to the application
        echo "System set-up is complate"
    else                       
      mkdir -p "$direct"
      cp -rv $paths $direct
               lastPath= basename $paths
               read -p "Provide Domain name: " domain
                cd /opt/interns/
                sudo ln -s $HOME/src/lastPath ./$domain
                echo "System set-up is complete"

    fi

  else 
    echo "Provide full path"
  fi
else
  echo "Directory not found"
fi
   } 
#major function that does all the installation 
#first calls the exist function to check for installed programs
softcheck_func() 
{
  if exist_func apache2; then
    echo 'apache exists!!'
    apache2_VERSION="$( apachectl -V)"
    echo ${apache2_VERSION}   
  else 
    read -p "Do you want to install apache2 (y/n)?" CONT
    if [ "$CONT" = "y" ]; then
      sudo apt-get install apache2
    else
      echo "apache not installed"; 
      error=1
    fi
  fi
   
  if exist_func php; then
    echo 'php exits!!'
    php_VERSION="$(php --version)"
    echo ${php_VERSION}
    if ["$php_VERSION" >="php 5.100.2"]; then
      continue
    else 
      #sudo apt-get purge php
      sudo apt-get install php
    fi
  
    sudo apt-get install php-curl
    sudo apt-get install php-imap
    sudo apt-get install php-idap
    sudo apt-get install php-odbc
    sudo apt-get install php-pgsql
    sudo apt-get install php-pspell
    sudo apt-get install php-soap
    sudo apt-get install php-xsl
    sudo apt-get install php-zip
    sudo apt-get install php-imagick
  else 
    read -p "Do you want to install php (y/n)?" CONT
    if [ "$CONT" = "y" ]; then
      sudo apt-get install php
      sudo apt-get install php-curl
      sudo apt-get install php-imap
      sudo apt-get install php-idap
      sudo apt-get install php-odbc
      sudo apt-get install php-pgsql
      sudo apt-get install php-pspell
      sudo apt-get install php-soap
      sudo apt-get install php-xsl
      sudo apt-get install php-zip
      sudo apt-get install php-imagick
    else
      echo "php not installed";
      error=1 
    fi
  fi

  if exist_func mysql; then
    echo 'mysql exits!!'
    mysql_VERSION="$(mysql --version)"
    echo ${mysql_VERSION}
  else 
    read -p "Do you want to install mysql(y/n)?" CONT
    if [ "$CONT" = "y" ]; then
	    sudo apt-get install mysql
    else
      echo "mysql not installed"; 
    fi
  fi

  if exist_func sshfs; then
    echo 'sshfs exits!!'
    sshfs_VERSION="$(sshfs --version)"
    echo ${sshsf_VERSION}
  else 
    read -p "Do you want to install sshfs(y/n)?" CONT
    if [ "$CONT" = "y" ]; then
      sudo apt-get install sshfs
    else
      echo "sshfs not installed"; 
    fi
  fi

  if exist_func git; then
    echo 'git exits'
    GIT_VERSION="$(git --version)"
    echo ${GIT_VERSION}
  else 
    read -p "Do you want to install git (y/n)?" CONT
    if [ "$CONT" = "y" ]; then
  	  sudo apt-get install git
    else
      echo "git not installed"; 
      error=1 
    fi
  fi

  if exist_func nodejs; then
    echo 'nodejs exits'
    nodejs_VERSION="$(nodejs --version)"
    echo ${nodejs_VERSION}
  else 
    read -p "Do you want to install nodejs (y/n)?" CONT
    if [ "$CONT" = "y" ]; then
  	  sudo apt-get install nodejs
    else
	    echo "nodejs not installed"; 
    fi
  fi

  if exist_func gimp; then
    echo 'gimp exits'
    gimp_VERSION="$(gimp --version)"
    echo ${gimp_VERSION}
  else 
    read -p "Do you want to install gimp (y/n)?" CONT
    if [ "$CONT" = "y" ]; then
  	  sudo apt-get install gimp
    else
	    echo "gimp not installed"; 
      error=1 
    fi
  fi

  if exist_func openssh; then
    echo 'openssh exits'
    openssh_VERSION="$(openssh --version)"
    echo ${openssh_VERSION}
  else 
    read -p "Do you want to install openssh (y/n)?" CONT
    if [ "$CONT" = "y" ]; then
  	  sudo apt-get install openssh-server
    else
      echo "openssh not installed"; 
    fi
  fi

  if exist_func curl; then
    echo 'curl exits'
    curl_VERSION="$(curl --version)"
    echo ${curl_VERSION}
  else 
    read -p "Do you want to install curl (y/n)?" CONT
    if [ "$CONT" = "y" ]; then
  	  sudo apt-get install curl
    else
      echo "curl not installed";
      error=1  
    fi
  fi

  if exist_func kile; then
    echo 'kile exits'
    sudo apt-get install texlive-full
    kile_VERSION="$(kile --version)"
    echo ${kile_VERSION}
  else 
    read -p "Do you want to install kile (y/n)?" CONT
    if [ "$CONT" = "y" ]; then
	    sudo apt-get install kile
      sudo apt-get install texlive-full
    else
      echo "kile not installed";
      error=1 
    fi
  fi

  if exist_func psql; then
    echo 'postgreSql exits'
    psql_VERSION="$(psql --version)"
    echo ${psql_VERSION}
    if [ '$psql_VERSION' = 'psql (PostgreSQL) 9.5.7']; then
      continue
    else 
      sudo apt-get install postgresql-9.5 -y
    fi
  else 
    read -p "Do you want to install psql (y/n)?" CONT
    if [ "$CONT" = "y" ]; then
      sudo apt-get install postgresql-9.5 -y
    else
      echo "psql not installed";
      error=1 
    fi
  fi

  if error=1; then
    return $error;
  else
    error=2;
    return $error;
  fi      
}

#main program
#conditions that need to be met before installation begins
if on_ac_power; then #laptop on ac power
  softcheck_func
  errChk=$error
  if errChk=1; then
    echo "Sorry you dont have all the required packages installed "
    echo "Make sure all softwares are installed and proceed further"
  
  else
    read -p "We are about to set-up your machine with investPlus are you sure you want to continue (Y/n)" CONT
    	if (CONT = 'y|Y'); then
        network=1
        LocalDrive=2
        echo "1.Network"
        echo "2.Local Drive"
        read -p "Where is the location of the source folder(1|2)?" answer
        if ($answer == $network); then
          network_func
        else
        enterPath_func 
         fi
     	else
     	  echo "User has aborted the procedure; "
      fi
  fi

else #else laptop on dc but above 15%
   v=$(upower -i $(upower -e | grep BAT) | grep --color=never -E "percentage") #check if laptop is on dc power and above 15%
	chrLen=$((${#v} - 4)) #get length of the variable v
 	#echo $chrLen
	pect=${v:$chrLen:3} #trim to get the percentage of the battery of the machine
	#echo $pect
	ref=15 #assign
 	#echo $ref
  if [ $pect -gt $ref ] ;then 
    softcheck_func
    errChk=$error
    if errChk=1; then
    echo "Sorry you dont have all the required packages installed "
    echo "Make sure all softwares are installed and proceed further"
  else
    read -p "We are about to set-up your machine with investPlus are you sure you want to continue (Y/n)" CONT
      if (CONT = 'y|Y'); then
        network=1
        echo "1.Network"
        echo "2.Local Drive"
        read -p "Where is the location of the \n1.Network source folder(1|2)?" answer
        if ($answer == $network); then
          network_func
        else
          enterPath_func 
        fi  
      else
        echo "User has aborted the procedure; " 
      fi
    fi
else #else 
    echo "System is low on dc power plug in your charger and try again"
  fi
fi


