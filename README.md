# To reproduce

### Install dependencies
 - Install node
 - Install coffee-script `npm -g coffee-script`


### Clone Repo
`git clone https://github.com/rjferguson21/usau-data.git`



### Fetches the list of pages in fetch.txt
`cd usau-data/data`

`wget -i fetch.txt`


### Run rip.coffee

`cd ..`

`npm install`

`coffee rip.coffee`
