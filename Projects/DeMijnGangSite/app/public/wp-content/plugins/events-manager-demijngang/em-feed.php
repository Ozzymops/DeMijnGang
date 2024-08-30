<?php
    /**
     * Generate a list of events in xml format for use in De MijnGang app.
     */
    function em_feed() {
        // only generate if url matches
        if (preg_match('/appfeed(\?.+)?$/', $_SERVER['REQUEST_URI']) || $_SERVER['REQUEST_URI'] == '/?app=1') {
            header('Content-Type: text/xml; charset=utf-8');
			header('Content-Disposition: inline; filename="appfeed.xml"');
            
            // retrieve events
            $args = array('orderby' => 'name');
            $EM_Events = EM_Events::get($args);
            
            // format XML
            $xml = new SimpleXMLElement("<events></events>");

            foreach ($EM_Events as $EM_Event) {                
                $xml_child = $xml->addChild('event');
                $xml_child->addAttribute('id', $EM_Event->event_id);
                $xml_title = $xml_child->addChild('title', $EM_Event->event_name);             

                $categories = array();
                foreach ($EM_Event->get_categories() as $EM_Category) {
                    $categories[] = $EM_Category->name;
                }
                $xml_categories = $xml_child->addChild('categories', implode(', ', $categories));

                $tags = array();
                foreach (new EM_Tags($EM_Event) as $EM_Tag) {
                    $tags[] = $EM_Tag->name;
                }
                $xml_tags = $xml_child->addChild('tags', implode(', ', $tags));

                $xml_description = $xml_child->addChild('description', $EM_Event->post_content);
                $xml_excerpt = $xml_child->addChild('excerpt', $EM_Event->post_excerpt);

                if (!empty($EM_Event->location_id)) {
                    $EM_Location = $EM_Event->get_location();
                    $xml_location = $xml_child->addChild('location');
                    $xml_location->addAttribute('id', $EM_Location->location_id);
                    $xml_location_name = $xml_location->addChild('name', $EM_Location->location_name);
                    $xml_location_address = $xml_location->addChild('address', $EM_Location->location_address);
                    $xml_location_town = $xml_location->addChild('town', $EM_Location->location_town);
                    $xml_location_region = $xml_location->addChild('region', $EM_Location->location_region);
                    $xml_location_state = $xml_location->addChild('state', $EM_Location->location_state);
                    $xml_location_postcode = $xml_location->addChild('postcode', $EM_Location->location_postcode);
                }
            
                $xml_startDate = $xml_child->addChild('startDate', $EM_Event->start());
                $xml_endDate = $xml_child->addChild('endDate', $EM_Event->end());
                $xml_image = $xml_child->addChild('image', $EM_Event->get_image_url());
            }
                
            // push
            echo $xml->asXML();
            die();
        }
    }
    add_action('init', 'em_feed');