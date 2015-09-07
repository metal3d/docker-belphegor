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

# Params

You may use GET params:

- url: mandatory, the url to capture
- selector: only capture this selector
- waitforselector: a CSS selector to wait before to realize the capture
- waitfortext: wait for that text on the page to realize the capture
- viewportwidth: with of the virtual browser
- output: format for output, png or jpg (any other given format will result of a png)
- lazy: if there are lazy loaded content (images when scroll down for example), this option set to "true" will load page twice (one time to get the real height, and another time to get images)


# Build yourself ?

You may build yourself the container:

```
git clone https://github.com/metal3d/docker-belphegor.git
cd docker-belphegor
git submodule update --init
docker build -t $USER/belphegor .
```

That will build a belphegor image prefixed by your username (username/blephegor).
