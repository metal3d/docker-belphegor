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
docker run -it -p 8000:8000 -e http_prowy=http://PROXY:PORT metal3d/belphegor
```

# Params

You may use GET params:

- url: mandatory, the url to capture
- waitforselector: a CSS selector to wait before to make the capture
- selector: only capture this selector
- resolution: WxH where W and H are Width and Height in pixel. This set the viewport (default is 1024x768)

Note that height is adapted if the page is higher.

# Build yourself ?

You may build yourself the container:

```
git clone https://github.com/metal3d/docker-belphegor.git
cd docker-belphegor
git submodule update --init
docker build -t $USER/belphegor .
```

That will build a belphegor image prefixed by your username (username/blephegor).
