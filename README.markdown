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
  * **Ruby** 2.0.0
  * **JavaScript** runtime
  * **Rails** 3.2.12
  * A web/application server, such as **Nginx/Thin**, or if there are not many concurrent requests **Thin** alone may be used
* Configure the server so **emails** may be sent from the rails app, and installing **Postfix** is a good solution
* Install this Ruby on Rails web application
* Use a **Procfile** and **Foreman** to install and setup the Share server


## Add a rails user *nix account

**Note:** this was done if you already installed **osCollect**, so don't do it again.

```
sudo adduser oscollect
```

This is the account that executes/runs the application, so configure it as a **sudo user** so it may be used to install all of the software.


## Add packages, libraries, and build tools needed by other software installations

**Note:** this was done if you already installed **osCollect**, so don't do it again.

Logged in as **oscollect** do:

```
sudo aptitude -y install curl wget nmap nbtscan
```

```
sudo aptitude -y install autoconf automake bison build-essential flex git-core libapr1-dev libaprutil1-dev libc6-dev libcurl4-openssl-dev libexpat1 libffi-dev libpcap-ruby libpcap0.8-dev libpcre3-dev libreadline6 libreadline6-dev libssl-dev libtool libxml2 libxml2-dev libxslt-dev libxslt1-dev libxslt1.1 libyaml-dev ncurses-dev openssl ssl-cert subversion zlib1g zlib1g-dev
```

## Install Ruby 2.0.0

**Note:** this was done if you already installed **osCollect**, so don't do it again.

Installing Ruby using **RVM** is an excellent way to manage different versions of Ruby as well as creating **gemsets** for each application  ... see the osCollect wiki for instructions.


## Install JavaScript runtime

**Note:** this was done if you already installed **osCollect**, so don't do it again.

Installing Node.js provides a JavaScript runtime ... see the osCollect wiki for instructions.


## Install Postfix so the app can send emails

**Note:** this was done if you already installed **osCollect**, so don't do it again.

See these instructions to allow this rails app to send emails ... see the osCollect wiki for instructions.


## Install the Ruby on Rails web application osCollect_Sharing

(1) log in as the **oscollect** (i.e. the rails app user, but not **root**)

(2) cd **/home/oscollect/apps**

(3) **git clone git://github.com/clonesec/osCollect_Sharing.git** ... to download and create the osCollect_Sharing folder

(4) cd **osCollect_Sharing**

(5) ask an admin, or create the **oscollect_sharing** database:

```
mysql -u root -p
> create database `oscollect_sharing` default character set = utf8 default collate = utf8_unicode_ci;
> create user 'railsapp'@'localhost' IDENTIFIED BY 'some_password';
> grant all on oscollect_sharing.* to 'railsapp' identified by 'some_password';
> flush privileges;
```

(6) install **rails** and all of the gems in the **Gemfile**

```
bundle install --deployment --without assets development test
```

(7) edit as appropriate for your installation of MySQL and the oscollect_sharing database (see **step (5)** above)

```
mv database.yml.example database.yml
nano config/database.yml
```

(8) create the oscollect_sharing database:

```
bundle exec rake db:migrate
```

(9) edit db/seed.rb to create the initial **admin** user and be sure to change the admin password and email

```
nano db/seed.rb
bundle exec rake db:seed
```

(10) prepare assets (i.e. CSS and javascripts) to be served by a web server

```
bundle exec rake assets:precompile
```

## Install and set up the web app server

To get started you may use **Thin** as both the app/web server, but with an increase in concurrent requests **Nginx/Thin** will be required.

(1) log in as the **oscollect** (i.e. the rails app user, but not **root**)
	* this is the user that executes the rails app

(2) cd **/home/oscollect/apps/osCollect_Sharing** or wherever osCollect Sharing was installed

(3) use Foreman to setup the Upstart sharing server:

```
rvmsudo bundle exec foreman export upstart /etc/init -a sharing -d /home/oscollect/apps/osCollect_Sharing -f Procfile -u oscollect -c web=1 -p 8888
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


## Visit http://X.X.X.X:8888/
(replace with your domain(or IP) and port) in a web browser, and login using the admin/password you set in the **db/seed.rb** file in step (9) above.

After logging in, an admin may click on **API Keys** then click **Generate New** to generate a new API 
key to be used by an osCollect instance.  Be sure to click the **Create Api Key** button, otherwise the 
key is not valid.

Once generated, the API Key may be copied to the **config/app_config.yml** file of 
each, if more than one, osCollect instance as the config setting **share_api_key**.  Also, be sure to set the **share_url** config setting to the appropriate url of your sharing server.


***
