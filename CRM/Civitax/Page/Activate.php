<?php

require_once 'CRM/Core/Page.php';

class CRM_Civitax_Page_Activate extends CRM_Core_Page {
  function run() {
   
	if(isset($_REQUEST['action'])) {
	
		$action = $_REQUEST['action'];
		
		switch ($action) {
		
  			case 'activate_tax':
  				
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
  			
  				break;
  				
  			
  			case 'set_tax':
  			
  				if(isset($_REQUEST['tax_status'])) {
  				
  					$tax_status = $_REQUEST['tax_status'];
  					$tax_id = $_REQUEST['tax_id'];
  					$contribution_type_id = $_REQUEST['contribution_type_id'];
  					
  					if($tax_status == 'true') {
  						$sql = "INSERT INTO civi_tax_contribution_type(tax_id, contribution_type_id) VALUES(".$tax_id.",".$contribution_type_id.")";
  						$dao = CRM_Core_DAO::executeQuery($sql);
  					} else {
  						$sql = "DELETE FROM civi_tax_contribution_type WHERE tax_id = ".$tax_id." AND contribution_type_id = " . $contribution_type_id;
  						$dao = CRM_Core_DAO::executeQuery($sql);
  					}
  				
  					$output = 1;
	  			} else {
					$output = 0;
				} 
  			
   				break;
   				
   			case 'insert_tax':
   				
   				if(isset($_REQUEST['tax_name']) && isset($_REQUEST['tax_rate']) && isset($_REQUEST['tax_status'])) {
   					
   					$tax_name 	= $_REQUEST['tax_name'];
   					$tax_rate	= $_REQUEST['tax_rate'];
   					$tax_status = $_REQUEST['tax_status'];
   					
   					$sql = "INSERT INTO civi_tax_type(tax, rate, active) VALUES('".$tax_name."',".$tax_rate.",".$tax_status.")";
  					$dao = CRM_Core_DAO::executeQuery($sql);
   					
   					$output = 1;
	  			} else {
					$output = 0;
				} 
   				
   				break;
   				
   			default:
   				break;
		}
   				
   				
   				
   
   	  
	
	  
	  
	}
	  
	$this->assign('output', $output);

    parent::run();
  }
}
