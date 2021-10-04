# hobbes-store: HOG based store application

## Building and running

```sh
> nix shell github:morganstanley/hobbes#hobbesPackages/gcc-10/llvm-12/hobbes github:smunix/hobbes-store
> store
> hog -d store-rehog-8083 -c -g Orders -s 8083
> hog -d store-rehog-8082 -c -g Orders -s 8082
> hog -d store-hog -g Orders -p 1s 1MB localhost:8082 localhost:8083 -c -z
```
