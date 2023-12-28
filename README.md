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

COMMAND FOUND FILE OR DIRECTORY :
- $ xlucy -f <[file_name/dir_name]>
  $ xlucy -f <[[file_name,dir_name]]>
  |__ found from filesystem
  
- $ xlucy -f <[file_name/dir_name]> <[/path/path]>
  $ xlucy -f <[[file_name,dir_name]]> <[/path/path]>
  |__ found from path directory
  
- $ xlucy -f <[[file,file]]> <[-s[dir,dir]]>
  $ xlucy -f <[[file,file]]> <[/path/path]> <[-s[dir,dir]]>
  |__ found with skip directory (-s[])

COMMAND CHECKING DIRECTORY :
- $ xlucy -j <[path]>
  $ xlucy -j --ftf <[path]>
  >>> show total file and directory on path

- $ xlucy -j --list <[path]>
  >>> show location file and directory from path
  
- $ xlucy -j --size <[path]>
  >>> show size file in path directory
  
COMMAND TALKING :
- $ xlucy -t
  >>> talking with xlucy
  
- $ xlucy -t --question
  >>> create question between you and lucy
  
- $ xlucy -t --action
  >>> create action scripts talking lucy
