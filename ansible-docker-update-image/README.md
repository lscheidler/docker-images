# Prerequirements

- ansible
- docker

# Initial setup

Please copy ../Makefile.global-vars.mk.template and adjust it to Your needs:

```
cp ../Makefile.global-vars.mk.template ../Makefile.global-vars.mk
editor ../Makefile.global-vars.mk
```

# Update image localrepo:debian-stretch-latest

```
make
```

# License

The playbook is available as open source under the terms of the [Apache 2.0 License](http://opensource.org/licenses/Apache-2.0).
