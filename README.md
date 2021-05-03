# borgmatic-binary

Single file static binaries for [borgmatic](https://github.com/witten/borgmatic).

### Usage

Either manually down the binary from the [releases page](https://github.com/danihodovic/borgmatic-binary/releases)
or use [gruntwork-io/fetch](https://github.com/gruntwork-io/fetch).

```sh
fetch --repo https://github.com/danihodovic/borgmatic-binary --release-asset='borgmatic' --tag 1.5.13 /tmp/
chmod +x /tmp/borgmatic
/tmp/borgmatic -c ./my_config.yaml
```

Tested on:

- Ubuntu 20.04
- Ubuntu 18.04
- Ubuntu 16.04
