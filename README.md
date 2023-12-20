# xlucy-assisten
# version 1.2

COMMAND INSTALL :
- $ chmod +x install-xlucy.sh
- $ ./install-xlucy.sh

COMMAND FIND FILE SETTINGS :
- $ xlucy -l --file
  |__ found path file settings
  
- $ xlucy -l --dir
  |__ found path directory settings
  
- $ xlucy -l --module
  |__ found path module file binary using
  
- $ xlucy -l --action
  |__ show action command talking xlucy
  
COMMAND FILE MANAGER :
- $ xlucy -k
  $ xlucy -k <[path]>
  |__ open file manager on path
  
- $ xlucy -p
  $ xlucy -p <[directory_name]>
  |__ open file manager to xlucy settings
  
COMMAND CHECKING DIRECTORY :
- $ xlucy -j <[path]>
  $ xlucy -j --ftf <[path]>
  |__ show total file and directory on path
  
- $ xlucy -j --list <[path]>
  |__ show location file and directory from path
  
COMMAND TALKING :
- $ xlucy -t
  |__ talking with xlucy
  
- $ xlucy -t --question
  |__ create question between you and lucy
  
- $ xlucy -t --action
  |__ create action scripts talking lucy
