$(document).ready(function() {
  var t = $('#datatable').DataTable({
    'columnDefs': [{
      'searchable': false,
      'targets': 0
    }],
    'order': [[ 0, 'asc' ]],
    'pageLength': 25,
    destroy: true
  });

  t.on( 'order.dt search.dt', function () {
    t.column(0, {search: 'applied', order: 'applied'}).nodes().each(function(cell, i) {
      cell.innerHTML = i+1;
    });
  }).draw();
});
