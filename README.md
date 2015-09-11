# Belphegor - a service to create website capture

Belphegor makes use of [Ghost.py](https://github.com/jeanphix/Ghost.py) to create screen captures of webpages. It comes with a dockerfile to build a container based on gunicorn.

Belphegor project is located at http://github.com/metal3d/belphegor

# Usage

Just launch:

```
docker run -it -p 8000:8000 metal3d/belphegor 
```

Then go to `http://localhost:8000/?url=http://a-page-url`

You may set gunicorn worker number with environment variable:

```
docker run -it -p 8000:8000 -e NUMWORKER=8 metal3d/belphegor 
```

If you launch service behind a proxy, you may give environment variable to let belphegor to use it:

```
docker run -it -p 8000:8000 -e http_proxy=http://PROXY:PORT metal3d/belphegor
```

# Microsoft Core Fonts

You may use Microsoft Core Font if you accepts the licence agreements: http://corefonts.sourceforge.net/eula.htm

Belphegor docker image **doesn't include that fonts** because that doesn't respect Microsoft licence to provide them. 
But you can ask your container to install them.

To activate Microsoft generation, pass `ACCEPT_MSCOREFONT_EULA=yes` to the "run" command:

```
docker run -e ACCEPT_MSCOREFONT_EULA=yes [...] metal3d/belphegor
```

What will be done is:

- install package needed to download and build fonts (rpbbuild, wget, and so on)
- build the rpm spec file: http://corefonts.sourceforge.net/msttcorefonts-2.0-1.spec
- install msttcorefont package

That operation could take a while.

# Environment variables

You may give those environment variables to the container:

- `http_proxy`: set `http_proxy` to be use by `dnf` and `belphegor`
- `ACCEPT_MSCOREFONT_EULA`: activate Microsoft fonts installation
- `USER_AGENT_SUFFIX`: Always set this string after USER-AGENT (can be overriden by `uasuffix` GET param)


# Params

You may use GET params:

- url: mandatory, the url to capture
- selector: only capture this selector
- waitforselector: a CSS selector to wait before to realize the capture
- waitfortext: wait for that text on the page to realize the capture
- viewportwidth: with of the virtual browser
- output: format for output, png or jpg or html (any other given format will result of a png)
- lazy: if there are lazy loaded content (images when scroll down for example), this option set to "true" will load page twice (one time to get the real height, and another time to get images)
- sleep: Wait N second before to make capture
- uasuffix: add given string in user-agent


# Build yourself ?

You may build yourself the container:

```
git clone https://github.com/metal3d/docker-belphegor.git
cd docker-belphegor
git submodule update --init
docker build -t $USER/belphegor .
```

That will build a belphegor image prefixed by your username (username/blephegor).
