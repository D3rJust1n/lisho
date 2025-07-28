# Lisho
A simple personal link shortener with no external dependencies in under 200 lines of Rust.
The links are maintained as a simple text file on the host machine.

```
[jzbor@desktop-i5] ~ lisho mappings.txt
Listening on localhost:8080 (5 links)
Token requested: mars
Token requested: asdfasdf
...
```
## Installation and Run using Docker

**Information**

To get started, you will need Docker. See [the docker install docs](https://docs.docker.com/engine/install/).  
To create our container we use [docker compose](https://docs.docker.com/compose/).

1. Create a directory for the project where you can store the needed files
2. Copy the `compose.yml` and the `mappings.txt` to the directory
    ```bash
    curl -O https://raw.githubusercontent.com/d3rjust1n/lisho/main/compose.yml && \
    curl -O https://raw.githubusercontent.com/d3rjust1n/lisho/main/mappings.txt 
    ```
3. Deploy the stack
    ```bash
    docker compose up -d
    ```

The container should start and the logs should display `Listening on 0.0.0.0:8080 (3 links)` 

To make the container accessible on the Internet, I recommend the blog article by Jojodicus ["Cloudflare Tunnel: Accessing your Homelab from Anywhere"](https://dittrich.pro/cloudflare-tunnel-homelab/). Of course, you can also use existing or other solutions.

## Post-Install
To add or remove link mappings, simply edit the mappings.txt file in your Lisho folder and save the changes.  
It is not necessary to restart the container, the changes are recognized automatically.

## Adding Link Mappings
Lisho reads mappings from a simple text file.
Entries consist of the short token and redirection URL separated by a whitespace.
Lines starting with a `#` are ignored, as are fields after the URL.
It is also possible to add a redirection for the root path by adding a mapping with a leading whitespace.

Example:
```
cb https://codeberg.org
gh https://github.com
gl https://gitlab.com
sh https://sr.ht
```


## Static Files
There are some files that are compiled into `lisho` by default:
* `/`
* `/index.html`
* `/style.css`
* `404.html` for 404 errors

You can override these defaults by simply adding a mapping to your preferred pages, in which case `lisho` will redirect them as usual.
Similarly, you can also set a favicon by redirecting it somewhere on the internet where your favicon is hosted.

```
# override index page
 https://github.com/jzbor/lisho
index.html https://github.com/jzbor/lisho

# add favicon
favicon.ico https://jzbor.de/favicon.ico
```

Of course this approach is rather limited, but `lisho`'s primary goal is simplicity.


## Convenient Alias
To make editing aliases on a remote machine easier you can add an alias in your shell config like so:
```sh
alias lisho-edit='ssh <hostname> -t <editor> <path>'
```

