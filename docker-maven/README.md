Usage
=====

```
docker run -it --rm=true -v $PWD:/home/user/workspace -v $HOME/.m2/:/home/user/.m2 lscheidler:debian-buster-maven-latest -f pom.xml -B clean
```
