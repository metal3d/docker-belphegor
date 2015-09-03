# Belphegor - a service to create website capture

Belphegor makes use of [Ghost.py](https://github.com/jeanphix/Ghost.py) to create screen captures of webpages. It comes with a dockerfile to build a container based on gunicorn.

# Usage

## With docker

docker run -it -p 8000:8000 metal3d/belphegor 

Then go to `http://localhost:8000/?url=http://a-page-url`

## Without docker

just launch 

```
python main.py

# or

gunicorn main:app -b :8000 -w 4 

```

# Params

You may use GET params:

- url: mandatory, the url to capture
- waitforselector: a CSS selector to wait before to make the capture
- selector: only capture this selector
- resolution: WxH where W and H are Width and Height in pixel. This set the viewport (default is 1024x768)

Note that height is adapted if the page is higher.


