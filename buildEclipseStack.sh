docker build -t kosted/bmap-stack .
docker run --rm kosted/bmap-stack pip freeze
docker push kosted/bmap-stack
