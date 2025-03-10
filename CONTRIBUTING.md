# Contributing Guide

This is mostly an entry point to explain the release procedure.

## Pre-requisite

It's necessary to have write access on the
[docker repository](https://hub.docker.com/r/iamdey/lmn-3-daw-docker-compiler).
Eventually ask @iamdey for it.

## Tag a new image

In rare case scenario[¹](#1) it might be necessary to publish a new set of
images for the lmn-3-daw cross-compiler.

First build the image as described in the [README.md](./README.md) file.

Then tag the image as follow:

```bash
docker tag docker.io/iamdey/lmn-3-daw_compiler:<target-arch> iamdey/lmn-3-daw-docker-compiler:<target-arch>
docker tag docker.io/iamdey/lmn-3-daw_compiler:<target-arch> iamdey/lmn-3-daw-docker-compiler:<target-arch>-<daw-min-version>
```

Replace `target-arch` and `daw-min-version` for example:

```bash
docker tag docker.io/iamdey/lmn-3-daw_compiler:arm64 iamdey/lmn-3-daw-docker-compiler:arm64-0.2.x
```

> The daw-min-version allows us to keep an image for older version of the DAW in
> case we need to maintain or start a fork at this point.

Then push images:

```bash
docker push iamdey/lmn-3-daw-docker-compiler:<target-arch>
docker push iamdey/lmn-3-daw-docker-compiler:<target-arch>-<daw-min-version>
```

And tag the git repository:

```bash
git tag daw-<daw-min-version>
git push --tags
```

e.g. `daw-0.2.x`

## Ref

<span id="#1">
1. In case the framework pre-requisite change, for example the version of c++ used or the target OS of the DAW, it might be necessery to publish a new compiler image.
</span>
