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
	  <td>edit</td>
	</tr>	 
	{/foreach}
</table>

{literal}

<style type="text/css">

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


</style>


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
    				jq("#civi-tax-message").html("<p><span class='civi-tax-status'>Update:</span> " + TaxName + "  is <span class='civi-tax-status-status'>" + TaxActive + "</span> for " + Contribution + " contributions.</span>.</p>");
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
		
	});

//-->
</script>



{/literal} 