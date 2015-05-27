{% set baseURL = "salt://template" %}

include:
  - otherState
  - .otherSubstate

{{baseURL}} - State description:
  state:
    - name: template
    - other: option
