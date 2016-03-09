# execute me using                                                                                            
#                  . commitGIT_iurisegtovich.sh                                                               
#                                                                                                             

gedit CommitMessage.txt ToDo.txt

quit=false

while true; do
    read -p "Changelog and ToDo updated?***" yn
    case $yn in
        [yY]* ) break;;
        [nN]* ) gedit CommitMessage.txt ToDo.txt;;
        [qQ]* ) quit=true; break;;
        * ) echo "yY to proceed, nN to gedit, qQ to quit";;
    esac
done

if [ $quit = false ]; then

  OLD_CHANGELOG_FNAME=$(ls -t "Changelog"*".txt" | head -n 1) #This gets a list of names that match #I feel lucky*** 

  NEW_CHANGELOG_FNAME=Changelog.$(date +%Y.%m.%d.%Hh.%Mm).txt
  
  echo $OLD_CHANGELOG_FNAME
  echo $NEW_CHANGELOG_FNAME

  cat CommitMessage.txt > $NEW_CHANGELOG_FNAME

  cat $OLD_CHANGELOG_FNAME >> $NEW_CHANGELOG_FNAME

  mv $OLD_CHANGELOG_FNAME bk.$OLD_CHANGELOG_FNAME
  
  git init

  git add -A

  git config --global user.name "iurisegtovich"
  git config --global user.email iurisegtovich@gmail.com

  CommitMessageString=$(cat CommitMessage.txt)
  echo $CommitMessageString

  git commit -m "$CommitMessageString"

  7z a ../oop_design_extension_vs_injection_.$(date +%Y.%m.%d.%Hh.%Mm)_.7z ../oop_design_extension_vs_injection

fi

echo "Done"