blasr
=====

Dockerfile for blasr (https://github.com/PacificBiosciences/blasr)

Invoke using docker run:

```
docker run --rm \
           --interactive \
           --tty \
           -v "${PWD}:/data" \
           -it muccg/blasr --help
```

There is a convenience script in ./bin
