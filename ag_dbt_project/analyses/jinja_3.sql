{% set inc_flag = true %}
{% set last_load = 3 %}

{% set col_list = ['sales_id', 'date_sk', 'gross_amount'] %}

SELECT

    {% for col in col_list %}
        {{ col }}
        {% if not loop.last %},{% endif %}
    {% endfor %}

FROM 
    {{ ref('bronze_sale') }}

{% if inc_flag %}
    WHERE 
        date_sk > {{ last_load }}
{% endif %}