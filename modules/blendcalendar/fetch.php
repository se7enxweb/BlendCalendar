<?php
$tpl    = eZTemplate::factory();
$http   = eZHttpTool::instance();
$ini    = eZIni::instance('content.ini');
$module = $Params['Module'];

$filter = array();
$filter[ 'calendar_node_id' ] = (int) $http->variable( 'calendar_node_id' , null );
$filter[ 'start' ]            = (int) $http->variable( 'start' , null );  // should default to beginning of month
$filter[ 'end' ]              = (int) $http->variable( 'end' , null ); // should default to end of month
// more security if we would check for a maximal time spawn ( end - start )

// categories
$filter[ 'categories' ] = array();

if( $http->hasVariable( 'categories' ) )
{
    $cats = explode( '-', $http->variable( 'categories' ) );

    foreach( $cats as $cat )
    {
        if( (int)$cat )
        {
            $filter[ 'categories' ][] = $cat;
        }
    }
}

$result = CalendarEvent::getEventsInRange(
        	$ini->variable( "BlendCalendarSettings", "EventClassAttributeIds" ),
        	$filter[ 'start' ],
        	$filter[ 'end' ]
		);

$return = array();

foreach( $result as $e => $entry )
{

    foreach( $entry as $aux)
    {
        $returnEvent    = array();

        $start_time = $e;
        $end_time= $e;

        foreach( $aux as $f => $value )
        {

            switch( $f )
            {
                case 'all_day':
                {
                    $returnEvent[ 'allDay' ] = ( $value == 1 );
                }
                break;
                case 'start_time':
                {
                    $start_time = (int)$value;
                    $end_time   = (int)$value;
                }
                break;
                case 'duration':
                {
                    $end_time   += $value;
                }
                break;
                case 'object':
                {

                    $node = eZContentObjectTreeNode::fetch( $value->attribute( 'main_node_id' ) );
                    if( $node )
                    {
                        $url = $node->attribute( 'url_alias' );
                        eZURI::transformURI( $url );
                        $returnEvent[ "title" ] = $node->attribute( 'name' );
                    }
                    else
                    {
                        $url = '/';
                        $returnEvent[ "title" ] = 'Unknown';
                    }

                    $returnEvent[ 'url' ] = $url;
                }
                break;

            }
        }

        $returnEvent[ "start" ] = date( 'c', (int)$start_time );
        $returnEvent[ "end" ] = date( 'c', (int)$end_time );

        array_push($return, $returnEvent);
    }
}

// use a template for caching and url handling - maybe also for calendar content parsing
echo json_encode( $return );

eZExecution::cleanExit();
?>