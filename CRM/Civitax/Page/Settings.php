<?php

require_once 'CRM/Core/Page.php';

/**
 * For testing 
 *
    print "rawParams info: "; 
    print "<div id='rawparams' style='display:none;'><pre>";
    print_r($_SESSION['rawParams']);
    print "</pre></div>";

    print "cookedParams info: "; 
    print "<div id='cookedparams' style='display:none;'><pre>";
    print_r($_SESSION['cookedParams']);
    print "</pre></div>";

    print "paymentObj info: "; 
    print "<div id='paymentobj' style='display:none;'><pre>";
    print_r($_SESSION['paymentObj']);
    print "</pre></div>";
 *
 */

class CRM_Civitax_Page_Settings extends CRM_Core_Page {
  function run() {
  	
  	// ADD STYLESHEET
	CRM_Core_Resources::singleton()->addStyleFile('ca.lunahost.civitax', 'civitax_style.css');

  	
	/**
  	 * GET APPLICABLE CONTRIBUTION TYPES  
  	 * FROM THE civicrm_financial_type TABLE
  	 * PUT RESULTS IN AN ARRAY AND SEND TO THE VIEW 
  	 */
  	$sql = 'SELECT * FROM civicrm_financial_type';
  	$dao = CRM_Core_DAO::executeQuery($sql);
  	$arr_contribution_types = array();
    $x = 0;
    while( $dao->fetch( ) ) {   
       	$arr_contribution_types[$x]['id'] = $dao->id;
       	$arr_contribution_types[$x]['name'] = $dao->name;
       	$x++;	
    }
  	$this->assign('arr_contribution_types', $arr_contribution_types);
  	
  	
  	/**
  	 * GET TAX RATES FROM THE civi_tax_type TABLE  
  	 * PUT RESULTS IN AN ARRAY AND SEND TO THE VIEW 
  	 */
  	$sql = 'SELECT * FROM civi_tax_type';
  	$dao = CRM_Core_DAO::executeQuery($sql);
  	$arr_tax_types = array();
    $x = 0;
    while( $dao->fetch( ) ) {   
       	$arr_tax_types[$x]['id'] = $dao->id;
       	$arr_tax_types[$x]['tax'] = $dao->tax;
       	$arr_tax_types[$x]['rate'] = $dao->rate;
       	$arr_tax_types[$x]['active'] = $dao->active;
       	$x++;	
    }
  	$this->assign('arr_tax_types', $arr_tax_types);
  	
  	
  	/**
  	 * GET CONTRIBUTION TYPES THAT ARE SUBJECT TO
  	 * TAXES FROM THE  civi_tax_contribution_type TABLE  
  	 * PUT RESULTS IN AN ARRAY AND SEND TO THE VIEW 
  	 */
  	$sql = 'SELECT * FROM  civi_tax_contribution_type';
  	$dao = CRM_Core_DAO::executeQuery($sql);
  	$arr_tax_contribution_type = array();
    $x = 0;
    while( $dao->fetch( ) ) {   
       	$arr_tax_contribution_type[$x]['tax_id'] = $dao->tax_id;
       	$arr_tax_contribution_type[$x]['contribution_type_id'] = $dao->contribution_type_id;
       	$x++;	
    }
  	$this->assign('arr_tax_contribution_type', $arr_tax_contribution_type);
  	
  	 
  
    // Set the page-title 
    CRM_Utils_System::setTitle(ts('CiviTax Settings'));

    parent::run();
  }
}
