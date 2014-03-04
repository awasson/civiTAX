<div id="civi-tax-message"></div>

<h3>CiviCRM Tax Field Settings</h3>

<p><strong>Select applicable taxes for contribution types from the table below.</strong></p>
<p><em><strong>NOTE:</strong> If a tax type has been disabled it will not be applied to contribution transactions even if it appears checked. Only active taxes will be applied to transactions.</em></p>

<table class="civi-tax-contribution-type" cellpadding="0" cellspacing="0" border="0">
  <tr>
    <th>Contribution Type</th>
    <th>Applicable Taxes</th>
  </tr>
{foreach from=$arr_contribution_types key=contribution_id item=contribution_item}
  <tr>
    <td class="civi-tax-contribution-type">{$contribution_item.name}</td>
    <td class="civi-tax-applicable-taxes">
    {foreach from=$arr_tax_types key=tax_id item=tax_i}
    
		<label class="civi-tax-checkboxes">
			<input class="{$tax_i.tax}" type="checkbox" id="{$contribution_item.name}_{$tax_i.tax}" value="{$tax_i.id}" name="contribution_{$contribution_item.id}" {if $tax_i.active == false} disabled="true" {/if} {foreach from=$arr_tax_contribution_type key=tax_contribution_id item=tax_contribution_i} {if $tax_contribution_i.contribution_type_id == $contribution_item.id && $tax_contribution_i.tax_id == $tax_i.id} checked {/if} {/foreach} /> {$tax_i.tax} ({$tax_i.rate|floor}%) 
		</label>  
	
	{/foreach}
    </td>
  </tr>
{/foreach}
</table>

<p>&nbsp;</p>

<p><strong>Adjust existing tax rates or add new tax types using the fields below.</strong></p>

<table class="civi-tax-type" cellpadding="0" cellspacing="0" border="0">
  <tr>
    <th>Name</th>
    <th>Rate (%)</th>
    <th>Active</th>
    <th>Action</th>
  </tr>
	{foreach from=$arr_tax_types key=tax_id item=tax_i}
	<tr>
	  <td>{$tax_i.tax}</td>
	  <td>{$tax_i.rate|floor}%</td>
	  <td>
	    <input class="active-tax" type="checkbox" name="{$tax_i.tax}" value="{$tax_i.id}" {if $tax_i.active == 1} checked="checked" {/if} />
	    </td>
	  <td>
	    <a class="civi-tax-edit" name="{$tax_i.tax}">edit</a>
	    <a class="civi-tax-edit-cancel">cancel</a>
	  </td>
	</tr>	 
	{/foreach}
	<tr id="add_tax_row">
	  <td>
	    <a href="#" id="add_tax" class="button" title="Add New Tax">
	      <span>
	        <div class="icon dropdown-icon"></div>
	        Add New Tax
	      </span>
	    </a>
	    <input type="text" name="tax_name" id="tax_name" size="5" class="new-tax civi-tax-required" />
	  </td>
	  <td>
	    <input type="text" name="tax_rate" id="tax_rate" size="5" class="new-tax civi-tax-numeric" />
	  </td>
	  <td>
	    <input type="checkbox" checked="checked" name="tax_active" id="tax_active" class="new-tax">
	  </td>
	  <td>
	    <span class="new-tax">
	      <a href="#" id="insert_tax" class="button" title="Insert">
	      <span>
	        Insert
	      </span>
	    </a>
	    </span>
	    <span class="new-tax">
	      <a href="#" id="cancel_tax" class="button" title="Cancel">
	      <span>
	        Cancel
	      </span>
	    </a>
	    </span>
	  </td>
	</tr>
</table>

{literal}

<script type="text/javascript">
<!-- 
	
	jQuery(function(){
	
		// Change which taxes apply to contribution types
		jQuery('.civi-tax-checkboxes input').change(function() {
			
			var Action				= "set_tax";
			var ArrTaxEnt			= jQuery(this).attr('id').split("_");
			var ArrContributionEnt	= jQuery(this).attr('name').split("_");
			var Contribution		= ArrTaxEnt[0];
			var ContributionID		= ArrContributionEnt[1];
			var TaxName				= ArrTaxEnt[1];
			var TaxID				= jQuery(this).attr('value');	
			var TaxStatus			= jQuery(this).attr('checked');	
			
			var TaxActive;
			if(TaxStatus==true) {
				TaxActive = 'Active';
				TaxActiveClass = 'isactive';
			} else {
				TaxActive = 'Disabled';
				TaxActiveClass = 'isdisabled';
			}
			
			jQuery.ajax({
  				type: 'POST',
  				url: '/civicrm/civitax/activate?reset=1&snippet=2',
  				data: { action : Action, tax_status : TaxStatus, tax_id : TaxID, contribution_type_id : ContributionID },
  				
  				success: function(data){
  				    jQuery("#civi-tax-message").removeClass();
    				jQuery("#civi-tax-message").html("<p><span class='civi-tax-status'>Update:</span> " + TaxName + "  is <span class='civi-tax-status-status'>" + TaxActive + "</span> for " + Contribution + " contributions.</p>").addClass(TaxActiveClass);
    				jQuery("#civi-tax-message").fadeIn('slow');
					setTimeout(function(){
    					jQuery("#civi-tax-message").fadeOut("slow");
					},5000)
  				},
  				
  				error: function(){
    				jQuery("#civi-tax-message").html("<p><span class='civi-tax-status'>Error:</span> There was a problem changing this items status. <br/>Please refresh the page and try again.</p>");
  				}
			});
			
		});
		
		
		// Change the 'active' state of existing taxes.
		jQuery('.active-tax').change(function() {
			
			var Action = "activate_tax";
			var TaxID = jQuery(this).attr('value');
			var TaxName = jQuery(this).attr('name');		
			var TaxStatus = jQuery(this).attr('checked');
			
			var TaxActive;
			if(TaxStatus==true) {
				TaxActive = 'Active';
				TaxActiveClass = 'isactive';
				jQuery("input." + TaxName).removeAttr("disabled");
			} else {
				TaxActive = 'Disabled';
				TaxActiveClass = 'isdisabled';
				jQuery("input." + TaxName).attr("disabled", true);
			}
			
  			
  			jQuery.ajax({
  				type: 'POST',
  				url: '/civicrm/civitax/activate?reset=1&snippet=2',
  				data: { action : Action , tax_status : TaxStatus, tax_id : TaxID, tax_name : TaxName },
  				
  				success: function(data){
  				    jQuery("#civi-tax-message").removeClass();
    				jQuery("#civi-tax-message").html("<p><span class='civi-tax-status'>Update:</span> " + TaxName + " tax is now <span class='civi-tax-status-status'>" + TaxActive + "</span>.</p>").addClass(TaxActiveClass);
    				jQuery("#civi-tax-message").fadeIn('slow');
					setTimeout(function(){
    					jQuery("#civi-tax-message").fadeOut("slow");
					},3000)
  				},
  				
  				error: function(){
    				jQuery("#civi-tax-message").html("<p><span class='civi-tax-status'>Error:</span> There was a problem changing this items status. <br/>Please refresh the page and try again.</p>");
  				}
			});
			
		});
		
		
		// New Tax Form
		jQuery('a#add_tax').click(function() {
			jQuery(this).fadeOut('fast', function() {
    			// Add Form fields
    			jQuery('.new-tax').fadeIn('slow');
  			}); 
  			return false;
		});
		
		
		// Cancel New Tax Form
		jQuery('a#cancel_tax').click(function() {
			jQuery('.new-tax').fadeOut('fast', function() {
				jQuery('a#add_tax').fadeIn('slow');
    			jQuery('input.new-tax').val('');
    			jQuery(".civi-tax-alert").each(function() {
					jQuery(this).remove();
				});
  			}); 
  			return false;
		});
		
		
		// Edit/Delete Tax
		jQuery('.civi-tax-edit').click(function() {
			if(jQuery(this).text() == 'edit') {
				jQuery(this).text('delete');
				jQuery(this).next('.civi-tax-edit-cancel').fadeIn('fast');
			} else {
			
				var ThisObj = jQuery(this);
				var Action  = "delete_tax";
				var TaxName = jQuery(this).attr('name');
				var TaxID   = jQuery(this).parent().prev('td').find('input').attr('value');
				
				//var TaxID   = jQuery(this).parent().prev('td').child(':input').attr('value');
	 
			
				// Insert a modal window - USE CiviCRM jQuery (cj) not Drupal's (jQuery)
				cj('<div></div>').appendTo('body').html('<div><p>Once a Tax has been removed, it cannot be restored<br/>without manually re-entering it. All references <br/>of it will be removed from the applicable taxes table. <br/>Please confirm this deletion.</p></div>').dialog({
                	modal: true, title: 'DELETE CONFIRMATION', zIndex: 10000, autoOpen: true,
                	width: 'auto', resizable: false,
                	buttons: {
                    	Yes: function () {
                    		cj(this).dialog("close");
                    		//  Use Ajax to remove this tax type
                    		jQuery.ajax({
  								type: 'POST',
  								url: '/civicrm/civitax/activate?reset=1&snippet=2',
  								data: { action : Action , tax_name : TaxName , tax_id : TaxID},
  				
  								success: function(data){
  								
  									ThisObj.parent().parent().remove();
                    				jQuery("label.civi-tax-checkboxes input." + TaxName).each(function() {
										jQuery(this).parent().remove();
									});
									
  								    jQuery("#civi-tax-message").removeClass();
    								jQuery("#civi-tax-message").html("<p><span class='civi-tax-status'>Update:</span> " + TaxName + " has been <span class='civi-tax-status-status'>removed</span> from the database.</p>");
    								jQuery("#civi-tax-message").fadeIn('slow');
									setTimeout(function(){
    									jQuery("#civi-tax-message").fadeOut("slow");
									},3000)
  								},
  				
  								error: function(){
    								jQuery("#civi-tax-message").html("<p><span class='civi-tax-status'>Error:</span> There was a problem removing this tax from the databases. <br/>Please refresh the page and try again.</p>");
  								}
							});

                    		ThisObj.text('edit');
                    		ThisObj.next('.civi-tax-edit-cancel').fadeOut('fast');
                    	},
                    	No: function () {
                    		cj(this).dialog("close");
                    		
                    	}
                	},
                	close: function (event, ui) {
                    	jQuery(this).remove();
                	}
        		});
			}
		}); 
		
		
		// Cancel Delete Tax
		jQuery('.civi-tax-edit-cancel').click(function() {
			jQuery(this).prev('.civi-tax-edit').text('edit');
			jQuery(this).fadeOut('fast');
		});
		
		
		// Insert New Tax
		jQuery('a#insert_tax').click(function() {
		
		
			// Validate the inputs	
			jQuery(".civi-tax-alert").each(function() {
				jQuery(this).remove();
			});
			
			var IsValid = 0;
			
			jQuery( ".civi-tax-required" ).each(function() {
				if(jQuery(this).val()=="") {
					jQuery(this).after(' <span class="civi-tax-alert">Required Field</span>');
					IsValid ++;
				}
			});
			
			jQuery( ".civi-tax-numeric" ).each(function() {
							
				if(jQuery(this).val() != "") {
    				var value = jQuery(this).val().replace(/^\s\s*/, '').replace(/\s\s*$/, '');
    				var intRegex = /^\d+$/;
    				if(!intRegex.test(value)) {
        				jQuery(this).after(' <span class="civi-tax-alert">Numeric Field</span>');
        				IsValid ++;
    				}
				} else {
    				jQuery(this).after(' <span class="civi-tax-alert">Required Field</span>');
    				IsValid ++;
				}

			});
		
			var Action		= "insert_tax";
			var TaxName		= jQuery('#tax_name').val();
			var TaxRate		= jQuery('#tax_rate').val();	
			var TaxStatus	= jQuery('#tax_active').attr('checked');	
			
			/*			*/
			
			if(IsValid == 0) {
				jQuery.ajax({
  					type: 'POST',
  					url: '/civicrm/civitax/activate?reset=1&snippet=2',
  					data: { action : Action , tax_name : TaxName, tax_rate : TaxRate, tax_status : TaxStatus },
  					
  					success: function(data){
  					
  					    TaxActiveClass = 'isactive';
  					
  						window.setTimeout('location.reload()', 0);
  					
  						jQuery('.new-tax').fadeOut('fast', function() {
							jQuery('a#add_tax').fadeIn('slow');
    						jQuery('input.new-tax').val('');
  						}); 
  						jQuery('.civi-tax-type tr:last').before('<tr><td>'+TaxName+'</td><td>'+TaxRate+'%</td><td><input type="checkbox" checked="checked" name="'+TaxName+'" class="active-tax"></td><td>edit</td></tr>');
    					jQuery("#civi-tax-message").removeClass();
    					jQuery("#civi-tax-message").html("<p><span class='civi-tax-status'>Update:</span> " + TaxName + " has been added to the database.</p>").addClass(TaxActiveClass);
    					jQuery("#civi-tax-message").fadeIn('slow');
						setTimeout(function(){
    						jQuery("#civi-tax-message").fadeOut("slow");
						},3000)
  					},
  				
  					error: function(){
    					jQuery("#civi-tax-message").html("<p><span class='civi-tax-status'>Error:</span> There was a problem inserting the new tax type. <br/>Please refresh the page and try again.</p>");
  					}
				});
			}

			
			return false;
		});
		
	});

//-->
</script>



{/literal} 