<?php
/*
+--------------------------------------------------------------------+
| CiviCRM version 4.4                                                |
+--------------------------------------------------------------------+
| Copyright CiviCRM LLC (c) 2004-2013                                |
+--------------------------------------------------------------------+
| This file is a part of CiviCRM.                                    |
|                                                                    |
| CiviCRM is free software; you can copy, modify, and distribute it  |
| under the terms of the GNU Affero General Public License           |
| Version 3, 19 November 2007 and the CiviCRM Licensing Exception.   |
|                                                                    |
| CiviCRM is distributed in the hope that it will be useful, but     |
| WITHOUT ANY WARRANTY; without even the implied warranty of         |
| MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.               |
| See the GNU Affero General Public License for more details.        |
|                                                                    |
| You should have received a copy of the GNU Affero General Public   |
| License and the CiviCRM Licensing Exception along                  |
| with this program; if not, contact CiviCRM LLC                     |
| at info[AT]civicrm[DOT]org. If you have questions about the        |
| GNU Affero General Public License or the licensing of CiviCRM,     |
| see the CiviCRM license FAQ at http://civicrm.org/licensing        |
+--------------------------------------------------------------------+
*/
/**
 *
 * @package CRM
 * @copyright CiviCRM LLC (c) 2004-2013
 *
 * Generated from xml/schema/CRM/Core/Component.xml
 * CUSTOMIZED FOR CIVI_TAX EXTENSION
 */
require_once 'CRM/Core/DAO.php';
require_once 'CRM/Utils/Type.php';
class CRM_Core_DAO_TaxInvoicing extends CRM_Core_DAO
{
  /**
   * static instance to hold the table name
   *
   * @var string
   * @static
   */
  static $_tableName = 'civi_tax_invoicing';
  /**
   * static instance to hold the field values
   *
   * @var array
   * @static
   */
  static $_fields = null;
  /**
   * static instance to hold the FK relationships
   *
   * @var string
   * @static
   */
  static $_links = null;
  /**
   * static instance to hold the values that can
   * be imported
   *
   * @var array
   * @static
   */
  static $_import = null;
  /**
   * static instance to hold the values that can
   * be exported
   *
   * @var array
   * @static
   */
  static $_export = null;
  /**
   * static value to see if we should log any modifications to
   * this table in the civicrm_log table
   *
   * @var boolean
   * @static
   */
  static $_log = false;
  /**
   * Unique Tax Invoice ID
   *
   * @var int unsigned
   */
  public $id;
  /**
   * Invoice ID
   *
   * @var varchar
   */
  public $invoice_id;
  /**
   * Unique Tax ID
   *
   * @var int unsigned
   */
  public $tax_id;
  /**
   * Name of Tax
   *
   * @var varchar
   */
  public $tax_name;
  /**
   * Before tax is added.
   *
   * @var varchar
   */
  public $pre_tax;
  /**
   * Tax rate
   *
   * @var varchar
   */
  public $tax_rate;
  /**
   * Tax amount charged
   *
   * @var varchar
   */
  public $tax_charged;
  /**
   * After tax is charged
   *
   * @var varchar
   */
  public $post_tax;
  /**
   * class constructor
   *
   * @access public
   * @return civicrm_component
   */
  function __construct()
  {
    $this->__table = 'civi_tax_invoicing';
    parent::__construct();
  }
  /**
   * return foreign links
   *
   * @access public
   * @return array
   */
  function &links()
  {
    if (!(self::$_links)) {
      self::$_links = array(
        'civi_tax_invoicing_id' => 'civi_tax_invoicing:id',
      );
    }
    return self::$_links;
  }
  /**
   * returns all the column names of this table
   *
   * @access public
   * @return array
   */
  static function &fields()
  {
    if (!(self::$_fields)) {
      self::$_fields = array(
        'id' => array(
          'name' => 'id',
          'type' => CRM_Utils_Type::T_INT,
          'required' => true,
        ) ,
        'invoice_id' => array(
          'name' => 'invoice_id',
          'type' => CRM_Utils_Type::T_STRING,
        ) ,
        'tax_id' => array(
          'name' => 'tax_id',
          'type' => CRM_Utils_Type::T_INT,
        ) ,
        'tax_name' => array(
          'name' => 'tax_name',
          'type' => CRM_Utils_Type::T_STRING,
        ) ,
        'pre_tax' => array(
          'name' => 'pre_tax',
          'type' => CRM_Utils_Type::T_STRING,
        ) ,
        'tax_rate' => array(
          'name' => 'tax_rate',
          'type' => CRM_Utils_Type::T_STRING,
        ) ,
        'tax_charged' => array(
          'name' => 'tax_charged',
          'type' => CRM_Utils_Type::T_STRING,
        ) ,
        'post_tax' => array(
          'name' => 'post_tax',
          'type' => CRM_Utils_Type::T_STRING,
        ) ,
      );
    }
    return self::$_fields;
  }
    /**
   * Returns an array containing, for each field, the arary key used for that
   * field in self::$_fields.
   *
   * @access public
   * @return array
   */
  static function &fieldKeys()
  {
    if (!(self::$_fieldKeys)) {
      self::$_fieldKeys = array(
        'id' => 'id',
        'invoice_id' => 'invoice_id',
        'tax_id' => 'tax_id',
        'tax_name' => 'tax_name',
        'pre_tax' => 'pre_tax',
        'tax_rate' => 'tax_rate',
        'tax_charged' => 'tax_charged',
        'post_tax' => 'post_tax',
     );
    }
    return self::$_fieldKeys;
  }
  /**
   * returns the names of this table
   *
   * @access public
   * @static
   * @return string
   */
  static function getTableName()
  {
    return self::$_tableName;
  }
  /**
   * returns if this table needs to be logged
   *
   * @access public
   * @return boolean
   */
  function getLog()
  {
    return self::$_log;
  }  
  /**
   * returns the list of fields that can be imported
   *
   * @access public
   * return array
   * @static
   */
  static function &import($prefix = false)
  {
    if (!(self::$_import)) {
      self::$_import = array();
      $fields = self::fields();
      foreach($fields as $name => $field) {
        if (CRM_Utils_Array::value('import', $field)) {
          if ($prefix) {
            self::$_import['civi_tax_invoicing'] = & $fields[$name];
          } else {
            self::$_import[$name] = & $fields[$name];
          }
        }
      }
    }
    return self::$_import;
  }
  /**
   * returns the list of fields that can be exported
   *
   * @access public
   * return array
   * @static
   */
  static function &export($prefix = false)
  {
    if (!(self::$_export)) {
      self::$_export = array();
      $fields = self::fields();
      foreach($fields as $name => $field) {
        if (CRM_Utils_Array::value('export', $field)) {
          if ($prefix) {
            self::$_export['civi_tax_invoicing'] = & $fields[$name];
          } else {
            self::$_export[$name] = & $fields[$name];
          }
        }
      }
    }
    return self::$_export;
  }
}
