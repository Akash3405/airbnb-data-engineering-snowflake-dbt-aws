{% set flag = 3 %}

SELECT * FROM {{ref('bronze_bookings')}}
{% if flag == 1 %}
  where NIGHTS_BOOKED >1    
{%else%}  
  where NIGHTS_BOOKED = 1
{% endif %}