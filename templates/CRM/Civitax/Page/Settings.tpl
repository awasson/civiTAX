<div id="civi-tax-message"></div>

<h3>CiviCRM Tax Field Settings</h3>

<p><strong>Select applicable taxes for contribution types from the table below.</strong>
<br/><em>NOTE: If a tax type has been disabled it will not be applied to contribution transactions even if it appears checked. Only active taxes will be applied to transactions.</em></p>

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

/* Configuration Styles */
#crm-container p {
    font-family: Helvetica,Arial,Sans;
    font-size: 0.9em;
    margin: 1em 0.3em;
}

.civi-tax-contribution-type {
    font-weight: bold;
}

.civi-tax-applicable-taxes {
    font-size: 0.9em;
}

.civi-tax-checkboxes {
	margin-right: 1em;
}

#crm-container .civi-tax-status {
	font-weight: bold;
}

#crm-container .civi-tax-status-status {
	text-decoration: underline;
}

#crm-container #civi-tax-message {
    background-color: #CDE8FE;
    border: 3px solid #48A9E4;
    color: infotext;
    font-family: Helvetica,Arial,Sans;
    font-size: 0.9em;
    font-style: italic;
    padding: 5px 10px;
    position: absolute;
    top: -30px;
    display: none;
}

#crm-container #civi-tax-message p {
    font-size: 0.9em;
    margin: 0.25em;
}

#crm-container .civi-tax-type td {
	width: 25%;
}

#crm-container .civi-tax-edit-cancel {
	display: none;
}

#crm-container .civi-tax-edit,
#crm-container .civi-tax-edit-cancel {
    cursor: pointer;
}

#crm-container .civi-tax-edit:hover,
#crm-container .civi-tax-edit-cancel:hover {
	text-decoration: underline;
}

#crm-container .new-tax {
	display: none;
}

#crm-container .civi-tax-alert {
	font-style: italic;
	color: #990000;
}

<script type="text/javascript">
<!-- 
	var jq = jQuery.noConflict();
	
	jQuery(function(){
	
		// Change which taxes apply to contribution types
		jq('.civi-tax-checkboxes input').change(function() {
			
			var Action				= "set_tax";
			var ArrTaxEnt			= jq(this).attr('id').split("_");
			var ArrContributionEnt	= jq(this).attr('name').split("_");
			var Contribution		= ArrTaxEnt[0];
			var ContributionID		= ArrContributionEnt[1];
			var TaxName				= ArrTaxEnt[1];
			var TaxID				= jq(this).attr('value');	
			var TaxStatus			= jq(this).attr('checked');	
			
			var TaxActive;
			if(TaxStatus==true) {
				TaxActive = 'Active';
			} else {
				TaxActive = 'Disabled';
			}
			
			jq.ajax({
  				type: 'POST',
  				url: '/civicrm/civitax/activate?reset=1&snippet=2',
  				data: { action : Action, tax_status : TaxStatus, tax_id : TaxID, contribution_type_id : ContributionID },
  				
  				success: function(data){
    				jq("#civi-tax-message").html("<p><span class='civi-tax-status'>Update:</span> " + TaxName + "  is <span class='civi-tax-status-status'>" + TaxActive + "</span> for " + Contribution + " contributions.</p>");
    				jq("#civi-tax-message").fadeIn('slow');
					setTimeout(function(){
    					jq("#civi-tax-message").fadeOut("slow");
					},5000)
  				},
  				
  				error: function(){
    				jq("#civi-tax-message").html("<p><span class='civi-tax-status'>Error:</span> There was a problem changing this items status. <br/>Please refresh the page and try again.</p>");
  				}
			});
			
		});
		
		
		// Change the 'active' state of existing taxes.
		jq('.active-tax').change(function() {
			
			var Action = "activate_tax";
			var TaxID = jq(this).attr('value');
			var TaxName = jq(this).attr('name');		
			var TaxStatus = jq(this).attr('checked');
			
			var TaxActive;
			if(TaxStatus==true) {
				TaxActive = 'Active';
				jq("input." + TaxName).removeAttr("disabled");
			} else {
				TaxActive = 'Disabled';
				jq("input." + TaxName).attr("disabled", true);
			}
			
  			
  			jq.ajax({
  				type: 'POST',
  				url: '/civicrm/civitax/activate?reset=1&snippet=2',
  				data: { action : Action , tax_status : TaxStatus, tax_id : TaxID, tax_name : TaxName },
  				
  				success: function(data){
    				jq("#civi-tax-message").html("<p><span class='civi-tax-status'>Update:</span> " + TaxName + " tax is now <span class='civi-tax-status-status'>" + TaxActive + "</span>.</p>");
    				jq("#civi-tax-message").fadeIn('slow');
					setTimeout(function(){
    					jq("#civi-tax-message").fadeOut("slow");
					},3000)
  				},
  				
  				error: function(){
    				jq("#civi-tax-message").html("<p><span class='civi-tax-status'>Error:</span> There was a problem changing this items status. <br/>Please refresh the page and try again.</p>");
  				}
			});
			
		});
		
		
		// New Tax Form
		jq('a#add_tax').click(function() {
			jq(this).fadeOut('fast', function() {
    			// Add Form fields
    			jq('.new-tax').fadeIn('slow');
  			}); 
  			return false;
		});
		
		
		// Cancel New Tax Form
		jq('a#cancel_tax').click(function() {
			jq('.new-tax').fadeOut('fast', function() {
				jq('a#add_tax').fadeIn('slow');
    			jq('input.new-tax').val('');
    			jq(".civi-tax-alert").each(function() {
					jq(this).remove();
				});
  			}); 
  			return false;
		});
		
		
		// Edit/Delete Tax
		jq('.civi-tax-edit').click(function() {
			if(jq(this).text() == 'edit') {
				jq(this).text('delete');
				jq(this).next('.civi-tax-edit-cancel').fadeIn('fast');
			} else {
			
				var ThisObj = jq(this);
				var Action  = "delete_tax";
				var TaxName = jq(this).attr('name');
				var TaxID   = jq(this).parent().prev('td').find('input').attr('value');
				
				//var TaxID   = jq(this).parent().prev('td').child(':input').attr('value');
	 
			
				// Insert a modal window
				jq('<div></div>').appendTo('body')
        		.html('<div><p>Once a Tax has been removed, it cannot be restored<br/>without manually re-entering it. All references <br/>of it will be removed from the applicable taxes table. <br/>Please confirm this deletion.</p></div>')
        		.dialog({
                	modal: true, title: 'DELETE CONFIRMATION', zIndex: 10000, autoOpen: true,
                	width: 'auto', resizable: false,
                	buttons: {
                    	Yes: function () {
                    		jq(this).dialog("close");
                    		//  Use Ajax to remove this tax type
                    		jq.ajax({
  								type: 'POST',
  								url: '/civicrm/civitax/activate?reset=1&snippet=2',
  								data: { action : Action , tax_name : TaxName , tax_id : TaxID},
  				
  								success: function(data){
  								
  									ThisObj.parent().parent().remove();
                    				jq("label.civi-tax-checkboxes input." + TaxName).each(function() {
										jq(this).parent().remove();
									});
  								
    								jq("#civi-tax-message").html("<p><span class='civi-tax-status'>Update:</span> " + TaxName + " has been <span class='civi-tax-status-status'>removed</span> from the database.</p>");
    								jq("#civi-tax-message").fadeIn('slow');
									setTimeout(function(){
    									jq("#civi-tax-message").fadeOut("slow");
									},3000)
  								},
  				
  								error: function(){
    								jq("#civi-tax-message").html("<p><span class='civi-tax-status'>Error:</span> There was a problem removing this tax from the databases. <br/>Please refresh the page and try again.</p>");
  								}
							});

                    		ThisObj.text('edit');
                    		ThisObj.next('.civi-tax-edit-cancel').fadeOut('fast');
                    	},
                    	No: function () {
                    		jq(this).dialog("close");
                    		
                    	}
                	},
                	close: function (event, ui) {
                    	jq(this).remove();
                	}
        		});
			}
		}); 
		
		
		// Cancel Delete Tax
		jq('.civi-tax-edit-cancel').click(function() {
			jq(this).prev('.civi-tax-edit').text('edit');
			jq(this).fadeOut('fast');
		});
		
		
		// Insert New Tax
		jq('a#insert_tax').click(function() {
		
		
			// Validate the inputs	
			jq(".civi-tax-alert").each(function() {
				jq(this).remove();
			});
			
			var IsValid = 0;
			
			jq( ".civi-tax-required" ).each(function() {
				if(jq(this).val()=="") {
					jq(this).after(' <span class="civi-tax-alert">Required Field</span>');
					IsValid ++;
				}
			});
			
			jq( ".civi-tax-numeric" ).each(function() {
							
				if(jq(this).val() != "") {
    				var value = jq(this).val().replace(/^\s\s*/, '').replace(/\s\s*$/, '');
    				var intRegex = /^\d+$/;
    				if(!intRegex.test(value)) {
        				jq(this).after(' <span class="civi-tax-alert">Numeric Field</span>');
        				IsValid ++;
    				}
				} else {
    				jq(this).after(' <span class="civi-tax-alert">Required Field</span>');
    				IsValid ++;
				}

			});
		
			var Action		= "insert_tax";
			var TaxName		= jq('#tax_name').val();
			var TaxRate		= jq('#tax_rate').val();	
			var TaxStatus	= jq('#tax_active').attr('checked');	
			
			/*			*/
			
			if(IsValid == 0) {
				jq.ajax({
  					type: 'POST',
  					url: '/civicrm/civitax/activate?reset=1&snippet=2',
  					data: { action : Action , tax_name : TaxName, tax_rate : TaxRate, tax_status : TaxStatus },
  					
  					success: function(data){
  					
  						window.setTimeout('location.reload()', 0);
  					
  						jq('.new-tax').fadeOut('fast', function() {
							jq('a#add_tax').fadeIn('slow');
    						jq('input.new-tax').val('');
  						}); 
  						jq('.civi-tax-type tr:last').before('<tr><td>'+TaxName+'</td><td>'+TaxRate+'%</td><td><input type="checkbox" checked="checked" name="'+TaxName+'" class="active-tax"></td><td>edit</td></tr>');
    					jq("#civi-tax-message").html("<p><span class='civi-tax-status'>Update:</span> " + TaxName + " has been added to the database.</p>");
    					jq("#civi-tax-message").fadeIn('slow');
						setTimeout(function(){
    						jq("#civi-tax-message").fadeOut("slow");
						},3000)
  					},
  				
  					error: function(){
    					jq("#civi-tax-message").html("<p><span class='civi-tax-status'>Error:</span> There was a problem inserting the new tax type. <br/>Please refresh the page and try again.</p>");
  					}
				});
			}

			
			return false;
		});
		
	});

//-->
</script>



{/literal} 