---
title: Woodworking
date: 2015-05-29T22:49:48+00:00
author: Mark
layout: page
permalink: /woodworking/
body_class: page_ww
class: post-summary
---

{% comment %}
{% assign filterCategory = "woodworking" %}

{% for category in site.categories %}

{% comment %}creates an empty array{% endcomment %}
{% assign postsInCategory = "" | split: "/" %}

{% for post in category[1] %}
{% if post.categories contains filterCategory %}
{% assign postsInCategory = postsInCategory | push: post %}
{% endif %}
{% endfor %}

    {% if postsInCategory.size > 0 %}
        <h1>{{ category[0] }}</h1>
        {% for post in postsInCategory %}
          {% include preview.html %}
        {% endfor %}
    {% endif %}

{% endfor %}
{% endcomment %}

{% for post in site.categories.woodworking %}

{% include preview.html %}

{% endfor %}
