c = {
  'actions' => {
    1 => {
      'action' => 'delete_indices',
      'description' => 'Delete indices older than 7',
      'options' => {
        'ignore_empty_list' => true,
        'continue_if_exception' => true,
        'disable_action' => false,
      },
      'filters' => [
        { 'filtertype' => 'pattern',
          'kind' => 'prefix',
          'value' => 'logstash-' },
        { 'filtertype' => 'age',
          'source' => 'creation_date',
          'direction' => 'older',
          'unit' => 'days',
          'unit_count' => 7 },
      ],
    },
  },
}

elasticsearch_curator_action 'action' do
  config c
  minute '0'
  hour '*'
  action :create
end
