# Animate 

[Demo](https://fradav.github.io/quarto-revealjs-animate/example.html)

A Revealjs plugin extension for animating svg, entirely based on [@rajgoel](https://github.com/rajgoel/reveal.js-plugins/

:warning: Requires Quarto Version 1.2.124 or later :warning:

## Installation

```
quarto install extension fradav/quarto-revealjs-animate
```

This will install the extension under the `_extensions` subdirectory. If you're using version control, you will want to check in this directory.


## Usage:

Simply add the extension to the list of reveal plugins, for example:

```
title: My Presentation
format: 
  revealjs: default
revealjs-plugins:
  - animate
filters: 
  - animate
```

## Usage

An animation can be included in a slide by adding an json code block with `animate` class. Furthermore, the filename of an SVG to be loaded can be provided by an attribute `src="drawing.svg"`. Alternatively, an `svg` element can be manually placed within the element. The animation is provided by the json string within the code block. The following example shows the basic structure:

`````markdown
```json { .animate src="drawing.svg" }
{
"setup": [
...
],
"animation": [
...]
}
```
`````

The `setup` object is used to manipulate the SVG after loading. The `animation` object is used to create an SVG animation. Both objects are optional and specified by an array including individual changes to the SVG. Each item in the array has the following properties:

- `element` (optional): The selector for any element(s) within the SVG on which the `modifier` is executed with the given `parameters`. If multiple elements match the selector, the modifier is executed in a sequential fashion to all elements matched. If no `element` is provided, the `modifier` is executed on the SVG element.
- `modifier`: Any function that can be used to [manipulate SVG elements](https://svgjs.dev/docs/3.0/manipulating/). Within the `setup` object, the modifier can be any user defined function manipulating the selected elements. Within the `animation` object, no user defined functions are allowed.
- `parameters`: An array of parameters for the chosen `modifier`.

For animation items the parameters  `duration`, `delay`, and `when` for the [`animate()`](https://svgjs.dev/docs/3.0/animating/#animate) function may be provided. If they are not provided the defaults are taken according to the documentation of SVG.js.

If a slide has fragments, the `animation` object can be provided as an array of an array. The first item of the array is an array of animations applied to the main slide, the following items are arrays of animations applied to the fragments.

The animate plugin is designed to work with the [`audio-slideshow` plugin](https://github.com/rajgoel/reveal.js-plugins/tree/master/audio-slideshow) such that the timeline of the audio is synched with the timeline of the animation and that the animation is controlled with the audio controls. Alternatively, the animations can be controlled via the functions `play()`, `pause()`, and `seek(timstamp)`.

## Examples

The [demo](https://rajgoel.github.io/reveal.js-demos/animate-demo.html) includes various animations showcasing different ways of using the plugin. Please have a look at the the [source code](https://github.com/rajgoel/reveal.js-demos/blob/master/animate-demo.html).

### Example: Heartbeat

The following example loads a heart and creates a heartbeat animation.

`````markdown
```json { .animate src="images/heart.svg"}
{
"setup": [
{
"element": "#heart", 
"modifier": "function() { this.animate(1500).ease('<>').scale(.9).loop(true,true);}"
}
]
}
```
`````

### Example: Fragments

The following example loads a SVG file and makes selected elements of the svg appear as fragments.

`````markdown
[]{.fragment}
[]{.fragment}
[]{.fragment}
[]{.fragment}
[]{.fragment}
[]{.fragment}
[]{.fragment}
[]{.fragment}

```json { .animate src="images/decisiontree.svg"}
{ "setup": [
{ "element": "#Price", "modifier": "attr", "parameters": [ {"class": "fragment", "data-fragment-index": "0"} ] },
{ "element": "#Host1", "modifier": "attr", "parameters": [ {"class": "fragment", "data-fragment-index": "1"} ] },
{ "element": "#Choice11", "modifier": "attr", "parameters": [ {"class": "fragment", "data-fragment-index": "2"} ] },
{ "element": "#Choice12", "modifier": "attr", "parameters": [ {"class": "fragment", "data-fragment-index": "3"} ] },
{ "element": "#Host2", "modifier": "attr", "parameters": [ {"class": "fragment", "data-fragment-index": "4"} ] },
{ "element": "#Choice2", "modifier": "attr", "parameters": [ {"class": "fragment", "data-fragment-index": "5"} ] },
{ "element": "#Host3", "modifier": "attr", "parameters": [ {"class": "fragment", "data-fragment-index": "6"} ] },
{ "element": "#Choice3", "modifier": "attr", "parameters": [ {"class": "fragment", "data-fragment-index": "7"} ] }
]}
```
`````

### Example: Adding SVG elements

The following example loads a SVG file and adds additional SVG elements to it upon loading. When advancing through the fragments, these elements are shown.

`````markdown
[]{.fragment .fade-in-then-out}
[]{.fragment .fade-in-then-out}
[]{.fragment .fade-in-then-out}
[]{.fragment .fade-in-then-out}

```json { .animate src="images/linear_program.svg"}
{
"setup": [
{
"element": "text:not([id])", 
"modifier": "opacity",
"parameters": [ 0 ]
},
{
"modifier": "path",
"parameters": [ { "id": "objective", "d": "M 0,60 L 800,540",  "stroke": "firebrick", "stroke-width": 5 } ]
},
{
"modifier": "text",
"parameters": [ "3x+5y = 15", { "id": "sum_3x_5y_is_15", "opacity": "1", "x": "20", "y": "575", "font-size": "50", "font-family": "Times New Roman", "font-style": "italic", "fill": "firebrick" } ]
},
{
"modifier": "text",
"parameters": [ "3x+5y = 0", { "id": "sum_3x_5y_is_0", "opacity": "0", "x": "20", "y": "575", "font-size": "50", "font-family": "Times New Roman", "font-style": "italic", "fill": "firebrick" } ]
},
{
"modifier": "text",
"parameters": [ "3x+5y = 40", { "id": "sum_3x_5y_is_40", "opacity": "0", "x": "20", "y": "575", "font-size": "50", "font-family": "Times New Roman", "font-style": "italic", "fill": "firebrick" } ]
},
{
"modifier": "text",
"parameters": [ "3x+5y = 36", { "id": "sum_3x_5y_is_36", "opacity": "0", "x": "20", "y": "575", "font-size": "50", "font-family": "Times New Roman", "font-style": "italic", "fill": "firebrick" } ]
},
{
"modifier": "circle",
"parameters": [ { "id": "solution", "opacity": "0", "cx": 500, "cy": 150, "r": 10, "fill": "firebrick"} ]
}],
"animation": [
[],
[
{
"element": "#sum_3x_5y_is_15", 
"modifier": "opacity",
"parameters": [ 0 ]
},
{
"element": "#objective", 
"modifier": "attr",
"duration": 1500,
"parameters": [ { "d": "M 0,210 L 800,690" } ]
},
{
"element": "#sum_3x_5y_is_0", 
"modifier": "opacity",
"parameters": [ 1 ]
}
],
[{
"element": "#sum_3x_5y_is_0", 
"modifier": "opacity",
"parameters": [ 0 ]
},
{
"element": "#objective", 
"modifier": "attr",
"duration": 4000,
"parameters": [ { "d": "M 0,-190 L 800,290" } ]
},
{
"element": "#sum_3x_5y_is_40", 
"modifier": "opacity",
"parameters": [ 1 ]
}
],
[{
"element": "#sum_3x_5y_is_40", 
"modifier": "opacity",
"parameters": [ 0 ]
},
{
"element": "#objective", 
"modifier": "attr",
"duration": 400,
"parameters": [ { "d": "M 0,-150 L 800,330" } ]
},
{
"element": "#sum_3x_5y_is_36", 
"modifier": "opacity",
"parameters": [ 1 ]
}
],
[{
"element": "#solution",
"modifier": "opacity",
"parameters": [ 1 ]
}]
]
}
```
`````



### Example: Sequential animations

The following example loads an SVG file, clones elements of the SVG, and manipulates them. Then, the cloned elements are displayed sequentially.

`````markdown
```json { .animate src="images/integer_program.svg"}
{
"setup": [
{
"element": "#objective", 
"modifier": "opacity",
"parameters": [ 0 ]
},
{
"element": "#feasible", 
"modifier": "opacity",
"parameters": [ 0 ]
},
{
"modifier": "function() {var clone = this.findOne('#points').clone(); clone.attr({'id': 'enumeration'}); clone.addTo(this);}"
},
{
"element": "#enumeration > circle", 
"modifier": "attr",
"parameters": [ { "opacity": 0, "r": 7.5, "fill": "black"} ]
}
],
"animation": [
[{
"element": "#enumeration > circle", 
"modifier": "opacity",
"parameters": [ 1 ]
}]
]
}
```
`````

Full source code for the example is available at [example.qmd](https://github.com/fradav/quarto-revealjs-animate/blob/main/example.qmd).




