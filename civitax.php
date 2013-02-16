<?php

require_once 'civitax.civix.php';

/**
 * Implementation of hook_civicrm_config
 */
function civitax_civicrm_config(&$config) {
  _civitax_civix_civicrm_config($config);
}

/**
 * Implementation of hook_civicrm_xmlMenu
 *
 * @param $files array(string)
 */
function civitax_civicrm_xmlMenu(&$files) {
  _civitax_civix_civicrm_xmlMenu($files);
}

/**
 * Implementation of hook_civicrm_navigationMenu
 *
 * @param $params array(string)
 */
function civitax_civicrm_navigationMenu( &$params ) {
  // get the maximum key of $params
  $maxKey = ( max( array_keys($params) ) );
  $params[$maxKey+1] = array (
    'attributes' => array (
    'label' => 'CiviTax',
    'name' => 'CiviTax',
    'url'        => null,
    'permission' => null,
    'operator'   => null,
    'separator'  => null,
    'parentID'   => null,
    'navID' => $maxKey+1,
    'active' => 1
	),
    	'child' =>  array (
    		'1' => array (
                'attributes' => array (
                    'label'      => 'Settings',
                    'name'       => 'Settings',
                    'url'        => 'civicrm/civitax/settings',
                    'permission' => 'administer CiviCRM',
                    'operator'   => null,
                    'separator'  => 1,
                    'parentID'   => $maxKey+1,
                    'navID'      => 1,
                    'active'     => 1
                ),
            'child' => null
            ) 
        ) 
    );
}



/**
 * Use hook_civicrm_pageRun 
 * Create a variable that points to the root directory of the extension
 * Used to set a path to the CSS file
 */
function civitax_civicrm_pageRun( &$page ) {

	$str_civitax_file = dirname(__FILE__);
	$arr_civitax_file_path = explode('/',$str_civitax_file);
	$civitax_count = count($arr_civitax_file_path);
	$_SESSION['civitax_base'] = $arr_civitax_file_path[$civitax_count-1];

}

/**
 * Use hook_civicrm_buildForm 
 * Identify type of contribution page 
 * Insert statement indicating if a tax is applicable 
 */
function civitax_civicrm_buildForm($formName, $form) {
	
	// Create a variable that points to the root directory of the extension
 	// Used to set a path to the CSS file
	$str_civitax_file = dirname(__FILE__);
	$arr_civitax_file_path = explode('/',$str_civitax_file);
	$civitax_count = count($arr_civitax_file_path);
	$_SESSION['civitax_base'] = $arr_civitax_file_path[$civitax_count-1];
	
	switch($formName) {
	
		// CONTRIBUTION PAGES
		case 'CRM_Contribute_Form_Contribution_Main':

			$civitax_values = $form->getVar('_values');
			$civitax_contribution_type_id = $civitax_values['contribution_type_id'];
			
			$sql = "SELECT civi_tax_type.tax FROM civi_tax_contribution_type INNER JOIN civi_tax_type ON civi_tax_type.id = civi_tax_contribution_type.tax_id WHERE civi_tax_type.active = 1 AND contribution_type_id = " . $civitax_contribution_type_id;
			$dao = CRM_Core_DAO::executeQuery($sql);
			$str_taxes = "";
			
			switch($civitax_contribution_type_id) {
			
				case '1':
					
					if ($dao->N > 0) {
						while( $dao->fetch( ) ) {   
       						$str_taxes .= $dao->tax . "/";
    					}
    					$str_taxes = rtrim($str_taxes, "/"); //remove the extra '/'
						$civitax_statement = "Donations are subject to $str_taxes Tax";	
					}
					
					break;
					
				case '2':
				
					if ($dao->N > 0) {
						while( $dao->fetch( ) ) {   
       						$str_taxes .= $dao->tax . "/";
    					}
    					$str_taxes = rtrim($str_taxes, "/"); //remove the extra '/'
						$civitax_statement = "Memberships are subject to $str_taxes Tax";	
					}
									
					break;
					
				case '3':
					
					if ($dao->N > 0) {
						while( $dao->fetch( ) ) {   
       						$str_taxes .= $dao->tax . "/";
    					}
    					$str_taxes = rtrim($str_taxes, "/"); //remove the extra '/'
						$civitax_statement = "Campaign Contributions are subject to $str_taxes Tax";	
					}
										
					break;
					
				default:
					
					break;
			
			}
			
			if ($dao->N > 0) {
				CRM_Core_Region::instance('page-footer')->add(array(
					'jquery' => "cj('.price_set-section').append('<span class=\'civitax-note\'>NOTE:</span> <span class=\'civitax-applicable-taxes\'>".$civitax_statement."</span>')",
				));
				// ADD STYLESHEET
				CRM_Core_Resources::singleton()->addStyleFile($_SESSION['civitax_base'], 'civitax_style.css');
			}

			break;
			
		
		// EVENT PAGES	
		case 'CRM_Event_Form_Registration_Register':
		
			$sql = "SELECT civi_tax_type.tax FROM civi_tax_contribution_type INNER JOIN civi_tax_type ON civi_tax_type.id = civi_tax_contribution_type.tax_id WHERE civi_tax_type.active = 1 AND contribution_type_id = 4";
			$dao = CRM_Core_DAO::executeQuery($sql);
			$str_taxes = "";
			
			if ($dao->N > 0) {
					while( $dao->fetch( ) ) {   
       				$str_taxes .= $dao->tax . "/";
    			}
    			$str_taxes = rtrim($str_taxes, "/"); //remove the extra '/'
				$civitax_statement = "Event fees are subject to $str_taxes Tax";	
				CRM_Core_Region::instance('page-footer')->add(array(
					'jquery' => "cj('.price_set-section').append('<span class=\'civitax-note\'>NOTE: </span> <span class=\'civitax-applicable-taxes\'>".$civitax_statement."</span>')",
				));
				// ADD STYLESHEET
				CRM_Core_Resources::singleton()->addStyleFile($_SESSION['civitax_base'], 'civitax_style.css');
			}

			break;
			
			
		default:
					
				break;
	
	}

}


/**
 * Implementation of hook_civicrm_install
 */
function civitax_civicrm_install() {
  return _civitax_civix_civicrm_install();
}

/**
 * Implementation of hook_civicrm_uninstall
 */
function civitax_civicrm_uninstall() {
  return _civitax_civix_civicrm_uninstall();
}

/**
 * Implementation of hook_civicrm_enable
 */
function civitax_civicrm_enable() {
  return _civitax_civix_civicrm_enable();
}

/**
 * Implementation of hook_civicrm_disable
 */
function civitax_civicrm_disable() {
  return _civitax_civix_civicrm_disable();
}

/**
 * Implementation of hook_civicrm_upgrade
 *
 * @param $op string, the type of operation being performed; 'check' or 'enqueue'
 * @param $queue CRM_Queue_Queue, (for 'enqueue') the modifiable list of pending up upgrade tasks
 *
 * @return mixed  based on op. for 'check', returns array(boolean) (TRUE if upgrades are pending)
 *                for 'enqueue', returns void
 */
function civitax_civicrm_upgrade($op, CRM_Queue_Queue $queue = NULL) {
  return _civitax_civix_civicrm_upgrade($op, $queue);
}

/**
 * Implementation of hook_civicrm_managed
 *
 * Generate a list of entities to create/deactivate/delete when this module
 * is installed, disabled, uninstalled.
 */
function civitax_civicrm_managed(&$entities) {
  return _civitax_civix_civicrm_managed($entities);
}
