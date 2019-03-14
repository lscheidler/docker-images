# Prerequirements

- ansible
- debootstrap 
- docker
- make
- tar

# Initial setup

Please copy ../Makefile.global-vars.mk.template and adjust it to Your needs:

```
cp ../Makefile.global-vars.mk.template ../Makefile.global-vars.mk
editor ../Makefile.global-vars.mk
```

# Create new base image for debian stretch

```
sudo make
```

# Create new base image for debian stretch and force apt update

```
sudo ansible-playbook create_base_image.yml -e local_repository=localrepo -e distribution=stretch -e force=true
```

# License

The playbook is available as open source under the terms of the [Apache 2.0 License](http://opensource.org/licenses/Apache-2.0).
