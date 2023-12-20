# xlucy-assisten
# version 1.2

COMMAND INSTALL :
- $ chmod +x install-xlucy.sh
- $ ./install-xlucy.sh

COMMAND FIND FILE SETTINGS :
- $ xlucy -l --file
  >>> found path file settings
  
- $ xlucy -l --dir
  >>> found path directory settings
  
- $ xlucy -l --module
  >>> found path module file binary using
  
- $ xlucy -l --action
  >>> show action command talking xlucy
  
COMMAND FILE MANAGER :
- $ xlucy -k
  $ xlucy -k <[path]>
  >>> open file manager on path
  
- $ xlucy -p
  $ xlucy -p <[directory_name]>
  >>> open file manager to xlucy settings
  
COMMAND CHECKING DIRECTORY :
- $ xlucy -j <[path]>
  $ xlucy -j --ftf <[path]>
  >>> show total file and directory on path

- $ xlucy -j --list <[path]>
  >>> show location file and directory from path
  
COMMAND TALKING :
- $ xlucy -t
  >>> talking with xlucy
  
- $ xlucy -t --question
  >>> create question between you and lucy
  
- $ xlucy -t --action
  >>> create action scripts talking lucy
