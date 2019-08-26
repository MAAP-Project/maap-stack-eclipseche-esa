docker build -t kosted/bmap-stack:latest .
docker run --rm kosted/bmap-stack:latest pip freeze
docker push kosted/bmap-stack:latest
