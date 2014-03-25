civiTAX: A civiCRM tax field extension 
=====================================

MARCH 24, 2014: REPORTING WORKS! WILL CALL FOR TESTING IN THE NEXT DAY OR TWO.

MARCH 8, 2014: TAXABLE BASIC REPORTING WORKS.
Basic reporting in the Contribution Detailed Report works for Pre Tax, Total Tax but not for the individual taxes yet.

MARCH 4, 2014: TAXABLE TRANSACTIONS WORK AND STARTED ON REPORTING.

MARCH 3, 2014: THE CIVICRM TAX EXTENSION PROJECT IS BACK ON TRACK.

NOTE: 	This extension has been updated for CiviCRM 4.3.x and higher 
		In order for this extension to work correctly it must be named ca.lunahost.civitax and placed into your extensions directory.

This extension is currently in development and is not ready for production. 

The following features are functional.

Settings: Tax management is controlled via the CiviTAX settings page which is available once the extension has been installed. From the settings page you can:
 - Create, Delete, Activate or Suspend tax types 
 - You can apply your taxes to any of the Contributions types
 - You may have one or more taxes and apply them
 
 Once taxes have been activated they will be applied to the transaction at the point of confirmation when the transaction is confirmed and CiviCRM passes the transaction to the processor.
 
 This extension keeps a record of transactions in the database which will be used for reporting.
 
The following Features have not been added
 - Editing Taxes: You can delete a tax but you can not edit yet. 
 - Emailed Receipts: Emailed receipts do not reflect tax charges. I've got nothing for this yet.



BACKGROUND
==========

The civiTAX extension is the evolution of a modification (hack) that we made to a copy of civiCRM to add a tax field and reporting for purchasing of memberships and events.

This extension provides the ability to add any number of taxes via a settings page which can then be applied to the appropriate contribution types. Taxes can be edited as necessary to change their name or rate and taxes can also be disabled without removing them completely from the system.

On the reporting side, we've added a database table that tracks invoice id, pre-tax cost, tax charged, the type of taxes applied and post-tax amount. This table can be queried at the time the reports are run and then the report can be appended with the information provided within. 

More information regarding our prior methods can be found here: http://groups.drupal.org/node/182444 
