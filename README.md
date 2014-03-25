CiviTAX: A civiCRM tax field extension 
=====================================

MARCH 24, 2014: REPORTING WORKS! WILL CALL FOR TESTING IN THE NEXT DAY OR TWO.

MARCH 8, 2014: TAXABLE BASIC REPORTING WORKS.
Basic reporting in the Contribution Detailed Report works for Pre Tax, Total Tax but not for the individual taxes yet.

MARCH 4, 2014: TAXABLE TRANSACTIONS WORK AND STARTED ON REPORTING.

MARCH 3, 2014: THE CIVICRM TAX EXTENSION PROJECT IS BACK ON TRACK.

NOTE: 	This extension has been updated for CiviCRM 4.3.x and higher 
		In order for this extension to work correctly it must be named ca.lunahost.civitax and placed into your extensions directory.

This extension is currently in development and is ready for testing. 

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

USAGE
=====

NOTE: This extension has been developed for CiviCRM 4.3.x and higher and is currently in testing phase

 - Download the CiviTax extension by clicking the "Download ZIP" link on the right side of this Github page.
 - Extract the zip file and rename the resulting folder ca.lunahost.civitax  
 - Upload to your CiviCRM website to your extensions folder (check Administer -> System Settings -> Directories for the location of your CiviCRM Extensions Directory).
 - Navigate to Administer -> System Settings -> Manage Extensions to install the CiviTax module.
 - If the module installed without any errors, navigate to the CiviTax main navigational element to the settings page where you can create tax types and apply them to the applicable contribution types.
 
This extension will apply one or more taxes to a contribution type and multiple taxes are added not compounded. ie: tax1 = 5%, tax2 = 7%. Total Tax = tax1 + tax2 = 12%

NOTE: Testing started March 25, 2014. If you have anything to add, experiences, bug reports, feature requests, etc... please use the Issue Queue (https://github.com/awasson/civiTAX/issues).

BACKGROUND
==========

The civiTAX extension is the evolution of a modification (hack) that we made to a copy of civiCRM to add a tax field and reporting for purchasing of memberships and events.

This extension provides the ability to add any number of taxes via a settings page which can then be applied to the appropriate contribution types. Taxes can be edited as necessary to change their name or rate and taxes can also be disabled without removing them completely from the system.

On the reporting side, we've added a database table that tracks invoice id, pre-tax cost, tax charged, the type of taxes applied and post-tax amount. This table can be queried at the time the reports are run and then the report can be appended with the information provided within. 

More information regarding our prior methods can be found here: http://groups.drupal.org/node/182444 
