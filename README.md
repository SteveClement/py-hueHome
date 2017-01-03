# py-hueHome
Python Philips Hue Home Automation

# Scope
Easy home automation using the Philips Hue hardware and python

# Plus
This will also walk the user through connecting OSRMA Lightify bulbs to the Hue Bridge.

## Important Notes /!\

### Working offline (aka. No Internetz)
When developing with Flask-Bootstrap or Flask-Moment make sure to either cache the the JS files or do an offline installl.
Once the Internet is gone, and you do a hard refresh, it tries to re-download these files from the Web.

### uWSGI et al.

There are a few ways to run, test, debug a Flask project.
By far the easiest is to use the internal WSGI interface and just not bother about it. For performance and cleanliness reasons you might want to use a web browser to relay the WSGI calls.
The solution proposed in this project, works for me. There might be better and more elegant ways to implement such a "server-side" schim. If there is, please let me know.

# Install env

```
cd ~
mkdir code ; cd code
git clone https://github.com/SteveClement/py-hueHome.git
cd py-hueHome
```

# OSX

```
virtualenv -p python3 app/venv
source ~/code/py-hueHome/app/venv/bin/activate
brew install --with-gunzip --with-http2 nginx
pip install -U -r requirements/dev.txt
```

## nginx

### OSX
Default Docroot is: /usr/local/var/www

The default port has been set in /usr/local/etc/nginx/nginx.conf to 8080 so that
nginx can run without sudo.

nginx will load all files in /usr/local/etc/nginx/servers/.

To have launchd start nginx now and restart at login:
  brew services start nginx
Or, if you don't want/need a background service you can just run:
  nginx

#### /usr/local/etc/nginx/nginx.conf
```
        set $homeWebDir /Users/steve/code/py-hueHome/app;
        set $virtualEnvDir /Users/steve/code/py-hueHome/app/venv;

        location /static {
                alias $homeWebDir/static;
                    }

        location / {
            root   html;
            index  index.html index.htm;
            include uwsgi_params;
            # make sure the sock below is in-line with your ini file
            uwsgi_pass unix:/tmp/uwsgi_application.sock;
            uwsgi_param UWSGI_PYHOME $virtualEnvDir;
            uwsgi_param UWSGI_CHDIR $homeWebDir;
            uwsgi_param UWSGI_CALLABLE application;
            #uwsgi_param UWSGI_MODULE application;
        }
```

## run

```
~/code/py-hueHome/bin/hueHome.sh
```
