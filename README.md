# VueR
(pronounced viewer)

VueR is a Vue.js inspired reactive frontend framework in ruby. It allows for the same kind of
declaritive change management as vue, albeit in smaller scope. Many vue-like features
work, and work continues, but the current scope is personal, so it's not meant as
a vue.js replacement.

## Usage

The usage is very close to the original, with off course ruby style.
This means currently working are:
- reactive attributes
- reactive text
- class based data
- class based method
- event dispatch to methods

The current and supported use is for making rails pages dynamic. An application
is defined by deriving from a base class, and can be "mounted" on an element.

There is a syntax to define Event handlers which are methods on the application.
Methods change the data. And any attributes or text that is declared as part of
the html will be updated automatically if needed.

The wiki has more detailed descriptions

## Installation

Installation is straightforward by including the gem and bundling

You can have a main js entry point, or many, it depends a bit.
You can also read the opal-rails to get a feel for how to work with ruby in the frontend.

I use haml, so
the usage is then:
- add the requires to the application.js
- write the application inside the haml template using :opal filter

The wiki has more details on how to use VueR from Haml or Erb

## Contributing

Ask

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
