from ghost import Ghost
from cgi import parse_qs, escape

from PyQt4.QtCore import QBuffer, QIODevice

def app(environ, start_response):
    d = parse_qs(environ['QUERY_STRING'])
    url = d.get('url',[''])[0]
    selector = d.get('selector',[''])[0]
    waitforselector = d.get('waitforselector',[None])[0]
    resolution = d.get('resolution', ['1024x768'])[0]
    
    w,h = [int(x) for x in resolution.split('x')]

    ghost = Ghost()
    status = "404 NotFound"
    response_headers = []
    response_body = ["404 NotFound"]

    if url:
        try:
            with ghost.start() as session:
                # manage proxy
                if "http_proxy" in environ:
                    host, port = environ["http_proxy"].replace("http://","").split(":")
                    session.set_proxy("http", host=host, port=int(port))

                # set viewport size
                session.set_viewport_size(w,h)
                
                # wait for a css selector
                if waitforselector is not None:
                    session.wait_for_selector(waitforselector)

                # load page
                page, extra_resources = session.open(url)
                
                cap = None
                if selector:
                    cap = session.capture(selector=selector)
                else:
                    cap = session.capture()

                # create a buffered image
                buffer = QBuffer()
                buffer.open(QIODevice.ReadWrite)
                cap.save(buffer, "PNG")
                buffer.close()

            # write image
            response_body = [bytes(buffer.data())]
            status = "200 OK"
            response_headers = [
                ('Content-Type', 'image/png'),
            ]
        except Exception, e:
            response_body = [
                "There were an error...",
                "\n",
                str(e)
            ]
            status = "500 InternalServerError"
            response_headers = [
                ('Content-Type', 'text/plain'),
            ]
            
    start_response(status, response_headers)
    return response_body
    
if __name__ == "__main__":
    from wsgiref.simple_server import make_server
    httpd = make_server(
        '0.0.0.0',
        8000,
        app
    )

    httpd.serve_forever()
