App.Relationship = DS.Model.extend
  contact: DS.belongsTo('contact')
  name: DS.attr('string')
  contactInfo: DS.attr('string')
  relationshipType: DS.attr('string')
  notes: DS.attr('string')
