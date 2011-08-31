Thinkwell Hippo Client
===================================

The Thinkwell Hippo Client gem provides Ruby bindings for Hippo.

## Installation

Add the gem to your Gemfile:

    gem 'hippo_client'


## Configuration

Configure the gem:

    Thinkwell::Hippo.configure({
      'url'       => 'http://hippo.thinkwell.com',
      'version'   => 1,
      'signature' => {
        'algorithm' => simple,
        'options'   => {
          'key'              => '<your public key>',
          'secret'           => '<your secret key (do not share it)>',
          'key_header'       => 'X-Api-Key',
          'signature_header' =>  'X-Api-Signature',
          'timestamp_header' => 'X-Api-Timestamp',
        }
      }
    })


## Usage

All hippo commands are available via the `Hippo` object:

    hippo = Thinkwell::Hippo.client
      => #<Thinkwell::Hippo::Client>

### Products

Obtain a list of products:

    products = hippo.products
     => [#<Thinkwell::Hippo::Model::Product>, #<Thinkwell::Hippo::Model::Product>, ...]

### Courses

Each product has one or more courses.  A course is a tree of containers, where the
branches represent chapters, and the leaves are content (video, lecture notes, etc).

Obtain a list of courses:

    courses = hippo.courses
      => [#<Thinkwell::Hippo::Model::Course>, #<Thinkwell::Hippo::Model::Course>, ...]


Filter by product id:

    courses = hippo.courses(:product => product.id)
      => [#<Thinkwell::Hippo::Model::Course>, #<Thinkwell::Hippo::Model::Course>, ...]


Fetch the most recent version of a single course by id:

    course = hippo.course('4de8131599cf2b60fa000003')
      => #<Thinkwell::Hippo::Model::Course>


Fetch a specific version of a single course by id:

    course = hippo.course('4de8131599cf2b60fa000003', :version => 1)
      => #<Thinkwell::Hippo::Model::Course>


See available versions of a specific course:

    courses = hippo.courseVersions('4de8131599cf2b60fa000003')
      => [#<Thinkwell::Hippo::Model::Course>, #<Thinkwell::Hippo::Model::Course>]


### Containers

Containers are used to organize a course tree.

Containers *contain something*.  Hippo has two types of
containers: **container containers** and **content containers** (confused
yet?).  Container containers contain an ordered list of one or more other
containers.  Content containers contain a reference to one piece of content.
The type of container is defined by the
`Thinkwell::Hippo::Model::Container` object's `type` property, which will
either be `container` or `content`.


Return *all* containers in a given course.  This will return a single
`Thinkwell::Hippo::Container` object representing the course's root
container.  You can use the `descendants` method to return a flat array
representing a depth-first tree of all containers.

    container = hippo.container(course.id)
      => #<Thinkwell::Hippo::Model::Container>
    container.descendants.count
      => 1057


Return a specific container with no descendants:

    container = hippo.container(course.id, '4de8131599cf2b60fa000008', :depth => 0)
      => #<Thinkwell::Hippo::Model::Container>
    container.descendants.count
      => 0


Return the children for a specific container:

    containers = hippo.containerChildren(course.id, '4de8131599cf2b60fa000008')
      => [#<Thinkwell::Hippo::Model::Container>, #<Thinkwell::Hippo::Model::Container>, ...]


Return the descendants for a specific container.  This will return a flat array
representing a depth-first tree of all descendant containers.

    containers = hippo.containerDescendants(course.id, '4de8131599cf2b60fa000008')
      => [#<Thinkwell::Hippo::Model::Container>, #<Thinkwell::Hippo::Model::Container>, ...]


Return only content containers:

    containers = hippo.containerChildren(course.id, '4de8131599cf2b60fa000008', :type => :content)
      => [#<Thinkwell::Hippo::Model::Container>, #<Thinkwell::Hippo::Model::Container>, ...]


Sometimes it is helpful to fetch a list of content containers with an embedded
reference to their parent containers.  The `containerContent` method will return an
array of content containers, pre-hydrated with a special `parent_container` attribute
containing the parent container.

    containers = hippo.containerContent(course.id, '4de8131599cf2b60fa000008')
      => [#<Thinkwell::Hippo::Model::Container>, #<Thinkwell::Hippo::Model::Container>, ...]
    containers.first.parent_container
      => #<Thinkwell::Hippo::Model::Container>


### Content

The heart of hippo is its content.

Fetch information about a piece of content:

    content = hippo.content(course.id, '4de8131599cf2b60fa000a32')
      => #<Thinkwell::Hippo::Model::Content>


Fetch an HTML snippet to display a piece of content:

    content = hippo.contentView(course.id, '4de8131599cf2b60fa000008', :html)
      => "<div>Your content!</div>"


Fetch a URL to a piece of content (not supported by all content formats):

    hippo.contentView(course.id, '4de8131599cf2b60fa00000d', :url)
      => 'http://thinkwell.cachefly.net/Protected/ajklsdjajkldjklasd'

