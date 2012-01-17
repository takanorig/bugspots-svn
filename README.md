# Bugspots-Svn - Bug Prediction Heuristic for Subversion

This is implemented of [Bugspots](https://github.com/igrigorik/bugspots) for subversion.

## Requires

This tool requires:

* ruby
* rubygems
* libsvn-ruby

(Ubuntu)

```
$ sudo apt-get install ruby
$ sudo apt-get install rubygems
$ sudo apt-get install libsvn-ruby
```


## Install

```
$ git clone git://github.com/takanorig/bugspots-svn.git
$ cd bugspots-svn
$ gem build bugspots-svn.gemspec
$ sudo gem install --force bugspots-svn-x.x.x.gem
```

## Usage
```
$ svn checkout http://wwww.samplerepo.com/svn/trunk /path/to/repo
$ svn-bugspots /path/to/repo
```

### License

(MIT License) - Copyright (c) 2012 Takanori Suzuki
