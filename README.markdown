Thinkwell Content Repository Client
===================================

The Thinkwell Content Repository Client gem provides Ruby bindings for the
Thinkwell Content Repository.

## Installation

Add the gem to your Gemfile:

    gem 'content_repository_client'


## Configuration

Add a configuration file in your Rails `config` folder:

    defaults: &defaults
    
      url:              'http://api.thinkwell.com/repository'
      video_player_url: '/flash/TWPlayer_1.0.swf'
    
      version:      1
      signature:
        algorithm:  simple
        options:
          key:               '<your public key>'
          secret:            '<your secret key (do not share it)>'
          key_header:        'X-Api-Key'
          signature_header:  'X-Api-Signature'
          timestamp_header:  'X-Api-Timestamp'
    
    development:
      <<: *defaults
    
    test:
      <<: *defaults
    
    production:
      <<: *defaults


## Usage

All repository commands are available via the `Repository` object:

    repo = Thinkwell::ContentRepository::Repository.new
      => #<Thinkwell::ContentRepository::Repository>

### Products

Obtain a list of products:

    products = repo.products
     => [#<Thinkwell::ContentRepository::Product>, #<Thinkwell::ContentRepository::Product>, ...]

### Courses

Each product has one or more courses.  A course is a tree of containers, where the
branches represent chapters, and the leaves are content (video, lecture notes, etc).

Obtain a list of courses:

    courses = repo.courses
      => [#<Thinkwell::ContentRepository::Course>, #<Thinkwell::ContentRepository::Course>, ...]


Filter by product id:

    courses = repo.courses(:product => product.id)
      => [#<Thinkwell::ContentRepository::Course>, #<Thinkwell::ContentRepository::Course>, ...]


Fetch the most recent version of a single course by id:

    course = repo.course('4de8131599cf2b60fa000003')
      => #<Thinkwell::ContentRepository::Course>


Fetch a specific version of a single course by id:

    course = repo.course('4de8131599cf2b60fa000003', :version => 1)
      => #<Thinkwell::ContentRepository::Course>


See available versions of a specific course:

    courses = repo.courseVersions('4de8131599cf2b60fa000003')
      => [#<Thinkwell::ContentRepository::Course>, #<Thinkwell::ContentRepository::Course>]


### Containers

Containers are used to organize a course tree.

Containers *contain something*.  The content repository has two types of
containers: **container containers** and **content containers** (confused
yet?).  Container containers contain an ordered list of one or more other
containers.  Content containers contain a reference to one piece of content.
The type of container is defined by the
`Thinkwell::ContentRepository::Container` object's `type` property, which will
either be `container` or `content`.


Return *all* containers in a given course.  This will return a single
`Thinkwell::ContentRepository::Container` object representing the course's root
container.  You can use the `descendants` method to return a flat array
representing a depth-first tree of all containers.

    container = repo.container(course.id)
      => #<Thinkwell::ContentRepository::Container>
    container.descendants.count
      => 1057


Return a specific container with no descendants:

    container = repo.container(course.id, '4de8131599cf2b60fa000008', :depth => 0)
      => #<Thinkwell::ContentRepository::Container>
    container.descendants.count
      => 0


Return the children for a specific container:

    containers = repo.containerChildren(course.id, '4de8131599cf2b60fa000008')
      => [#<Thinkwell::ContentRepository::Container>, #<Thinkwell::ContentRepository::Container>, ...]


Return the descendants for a specific container.  This will return a flat array
representing a depth-first tree of all descendant containers.

    containers = repo.containerDescendants(course.id, '4de8131599cf2b60fa000008')
      => [#<Thinkwell::ContentRepository::Container>, #<Thinkwell::ContentRepository::Container>, ...]


Return only content containers:

    containers = repo.containerChildren(course.id, '4de8131599cf2b60fa000008', :type => :content)
      => [#<Thinkwell::ContentRepository::Container>, #<Thinkwell::ContentRepository::Container>, ...]


Sometimes it is helpful to fetch a list of content containers with an embedded
reference to their parent containers.  The `containerContent` method will return an
array of content containers, pre-hydrated with a special `parent_container` attribute
containing the parent container.

    containers = repo.containerContent(course.id, '4de8131599cf2b60fa000008')
      => [#<Thinkwell::ContentRepository::Container>, #<Thinkwell::ContentRepository::Container>, ...]
    containers.first.parent_container
      => #<Thinkwell::ContentRepository::Container>


### Content

The heart of the content repository is its content.

Fetch information about a piece of content:

    content = repo.content(course.id, '4de8131599cf2b60fa000a32')
      => #<Thinkwell::ContentRepository::Content>


Fetch an HTML snippet to display a piece of content:

    content = repo.contentView(course.id, '4de8131599cf2b60fa000008', :html)
      => "<div>Your content!</div>"


Fetch a URL to a piece of content (not supported by all content formats):

    repo.contentView(course.id, '4de8131599cf2b60fa00000d', :url)
      => 'http://thinkwell.cachefly.net/Protected/ajklsdjajkldjklasd'

