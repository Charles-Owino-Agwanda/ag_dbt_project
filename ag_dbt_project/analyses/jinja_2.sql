{% set colors = ['red', 'green', 'blue', 'orange'] %}

{% for color in colors %}
    {%if color != 'red'%}
        {{ color }}
    {% else %}
        I hate {{ color }}
    {% endif %}
{% endfor %}