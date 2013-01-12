<?php

require_once 'CRM/Core/Page.php';

class CRM_Civitax_Page_Activate extends CRM_Core_Page {
  function run() {
   
   	  // This script is called via jQuery.post() and sets the session year variable 
	  if(isset($_REQUEST['tax_status'])) {
		
		$tax_status = $_REQUEST['tax_status'];
		$tax_name = $_REQUEST['tax_name'];
		$tax_id = $_REQUEST['tax_id'];
		
		// If the tax_status has been changed then we run a query updating it setting it active/inactive
		$sql = "UPDATE civi_tax_type SET active= " . $tax_status . " WHERE id = " . $tax_id;
  		$dao = CRM_Core_DAO::executeQuery($sql);
		
		$output = 1;
	  } else {
		$output = 0;
	  } 
	
	  $this->assign('output', $output);

    parent::run();
  }
}
