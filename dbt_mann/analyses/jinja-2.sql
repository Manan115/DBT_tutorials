{%- set apples = [
    "red delicious",
    "granny smith",
    "honeycrisp","fuji",
    "mcintosh",
] -%}

{% for i in apples %}

    {% if i != "honeycrisp" %}

        {{ i }}

    {% else %}

        I hate {{i}}

    {% endif %} 

    
{% endfor %}