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
