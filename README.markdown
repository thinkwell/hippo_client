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

Each product has one or more courses.

Obtain a list of courses:

    courses = hippo.courses
      => [#<Thinkwell::Hippo::Model::Course>, #<Thinkwell::Hippo::Model::Course>, ...]


Filter by product id:

    courses = hippo.courses(:product => product.id)
      => [#<Thinkwell::Hippo::Model::Course>, #<Thinkwell::Hippo::Model::Course>, ...]


Fetch a single course by id:

    course = hippo.course('4de8131599cf2b60fa000003')
      => #<Thinkwell::Hippo::Model::Course>


### Course Tree

Each course has a course tree.  A course tree is a tree of nodes, where the
branches represent containers/chapters, and the leaves are content (video, lecture notes, etc).

Hippo has two types of nodes: container nodes and content nodes.  The type
of node is defined by the `Thinkwell::Hippo::Model::Node` object's `type`
property, which will either be `container` or `content`.  Container nodes contain
child nodes.  Content nodes point to a hippo content object.

Child nodes are accessed via the `child_nodes` property.

Fetch the course tree for a given course.  This will return a single
`Thinkwell::Hippo::CourseTree` object representing the course's tree.
You can use the `child_nodes` method to return a hierarchical array of nodes.

    tree = hippo.course_tree(course.id)
      => #<Thinkwell::Hippo::Model::CourseTree>
    tree.child_nodes.count
      => 10
    tree.child_nodes[0].child_nodes.count
      => 3


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

