{* some ezwebin settings *}
{set scope=global persistent_variable=hash('left_menu', false(),
                                           'extra_menu', false(),
                                           'show_path', true())}

{ezcss_require( 'fullcalendar.css' )}
{ezcss_require( 'calendar2.css' )}
{ezscript_require( 'ezjsc::jquery' )}
{ezscript_require( 'fullcalendar.js' )}


<h2>{$node.name|wash()}</h2>
<br />

<div id="calendar"></div>
<div id="loading">Loading...</div>

<script type="text/javascript">

var web_service_url = {'blendcalendar/fetch'|ezurl( 'single', 'full' )};
var calendar_node_id = {$node.node_id};

{literal}
$(document).ready(function() {

	$('#calendar').fullCalendar({
        // You can set the default month with the parameters month and year
		editable: false,
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'month,agendaWeek,agendaDay' // There are also basicWeekBackup and basicWeekTest views, which are experimental
		},

		events: function( eventStart, eventEnd, reportEventsAndPop )
		{
			var params = {};
			params[ 'start' ]            = Math.round( eventStart.getTime() / 1000 );
			params[ 'end' ]              = Math.round( eventEnd.getTime() / 1000 );
			params[ 'calendar_node_id' ] = calendar_node_id;
			params[ 'categories' ]       = '';

			//adding categories
			$('.calendar2category:checked').each( function()
			{
				params[ 'categories' ] += $(this).val() + '-';
			});

			// not available in current scope
			//pushLoading();

			$.ajax({
				url: web_service_url,
				dataType: 'json',
				data: params,
				success: reportEventsAndPop
			});
		},
		firstDay: 0,

		loading: function(bool)
		{
			if (bool) $('#loading').show();
			else $('#loading').hide();
		}

	})
});

$('#calendar2-refetch').bind("click", function(e)
{
	$('#calendar').fullCalendar( 'refetchEvents' );
	return false;
});

{/literal}
</script>