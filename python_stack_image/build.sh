docker build -t kosted/bmap-stack-python:1.0 . 
docker run --rm kosted/bmap-stack-python:1.0 pip freeze
docker push kosted/bmap-stack-python:1.0 
