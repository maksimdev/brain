--REMOVE PROPERTY
UPDATE entities
SET properties = properties - 'removedProperty'
WHERE id = '123'

--ADD/UPDATE PROPERTY
UPDATE entities
SET properties = jsonb_set(
  properties,
  '{addedProperty}',
  '[{"key": "newKey", "values": ["value1", "value2"]}]'
)
WHERE id = '123'