---
title: Code and Other Computing Tips
nav_title: Code
date: 2021-10-02T04:26:33.079Z
author: Mark
layout: page
permalink: /code/
body_class: page_code
---

{% for post in site.categories.code %} {%- assign date_format = site.minima.date_format | default: "%b %-d, %Y" -%}

{% include preview-text.html %}

{% endfor %}
