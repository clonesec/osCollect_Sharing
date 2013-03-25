# osCollect Sharing

## Application Overview

* This application allows osCollect users to share Searches, Alerts, Charts, Dashboards, and Reports 
with each other.  Sharing may occur within a single osCollect instance or between multiple osCollect 
instances by connecting to the same share server.  Admin's must have a login to generate an API key to 
be used by an osCollect instance.

***

## Installation Overview

* Prerequisites for the rails web app:
  * a rails app user account
  * add packages, libraries, and build tools needed by other software installations
  * **Ruby** 1.9.3 +
  * **JavaScript** runtime
  * **Rails** 3.2.12
  * A web/application server, such as **Nginx/Thin**, or if there are not many concurrent requests **Thin** alone may be used
* Configure the server so **emails** may be sent from the rails app, and installing **Postfix** is a good solution
* Install this Ruby on Rails web application
* Use a **Procfile** and **Foreman** to install and setup the Share server


## Add a rails user *nix account

```
sudo adduser oscollectsharing
```

This is the account that executes/runs the application, so configure it as a **sudo user** so it may be used to install all of the software.


## Add packages, libraries, and build tools needed by other software installations

Logged in as **oscollectsharing** do:

```
sudo aptitude -y install curl wget nmap nbtscan
```

```
sudo aptitude -y install autoconf automake bison build-essential flex git-core libapr1-dev libaprutil1-dev libc6-dev libcurl4-openssl-dev libexpat1 libffi-dev libpcap-ruby libpcap0.8-dev libpcre3-dev libreadline6 libreadline6-dev libssl-dev libtool libxml2 libxml2-dev libxslt-dev libxslt1-dev libxslt1.1 libyaml-dev ncurses-dev openssl ssl-cert subversion zlib1g zlib1g-dev
```

## Install Ruby 1.9.3 +

Installing Ruby using **RVM** is an excellent way to manage different versions of Ruby as well as creating **gemsets** for each application  ... see the osCollect wiki for instructions.


## Install JavaScript runtime

Installing Node.js provides a JavaScript runtime ... see the osCollect wiki for instructions.


## Install Postfix so the osCollect Sharing app can send emails

See these instructions to allow this rails app to send emails ... see the osCollect wiki for instructions.


## Install the Ruby on Rails web application osCollect_Sharing

1. log in as the **oscollectsharing** (i.e. the rails app user, but not **root**)
  * this is the user that executes the rails app
2. cd **/home/oscollectsharing/apps** (mkdir apps, if needed)
3. **git clone git://github.com/clonesec/osCollect_Sharing.git oscollectsharing** ... to download and create the oscollectsharing folder
4. cd **oscollectsharing**
5. **bundle install --deployment --without assets development test** ... to install **rails** and all of the gems in the **Gemfile**
6. edit **config/database.yml.example** and save as **config/database.yml** ... edit as appropriate for your installation of MySQL and the oscollect_sharing database
7. **bundle exec rake db:migrate** ... create the oscollect_sharing database
8. **bundle exec rake db:seed** ... create the initial **admin** user, edit the **db/seed.rb** file to change the admin password and email
9. **bundle exec rake assets:precompile** ... compress/prepare assets to be served by a web server


## Install the Web/Application Server

To get started you may use **Thin** as both the app/web server, but with an increase in concurrent requests **Nginx/Thin** will be required.

(1) log in as the **oscollectsharing** (i.e. the rails app user, but not **root**)
	* this is the user that executes the rails app

(2) cd **/home/oscollectsharing/apps/oscollectsharing** or wherever osCollect Sharing was installed

(3) use Foreman to setup the Upstart sharing server:

```
rvmsudo bundle exec foreman export upstart /etc/init -a sharing -d /home/oscollectsharing/apps/oscollectsharing -f Procfile -u oscollectsharing -c web=1 -p 8888
```

To start the Sharing server when the server boots up do:

```
sudo nano /etc/init/sharing.conf
```

Now add to top of file:

```
  start on runlevel [2345]
```

Start the sharing server using:

```
sudo service sharing start
```


### Visit http://oscollectsharing.com:8888/ (<- replace with your domain and port)
in a web browser, and using the admin/password you set in the **db/seed.rb** file (step 8. above) login.

After logging in, an admin may click on **API Keys** then click **Generate New** to generate a new API 
key to be used by an osCollect instance.  Be sure to click the **Create Api Key** button, otherwise the 
key is not valid.

Once generated, the API Key may be copied to the **config/app_config.yml** file of 
each, if more than one, osCollect instance as the config setting **share_api_key**.
Also, be sure to set the **share_url** config setting to the appropriate url of your sharing server.


***
