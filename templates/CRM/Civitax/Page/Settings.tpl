<h3>CiviCRM Tax Field Settings</h3>

<p>Select applicable taxes for contribution types from the table below.</p>

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
		<label class="civi-tax-checkboxes"><input type="checkbox" id="memberships_{$tax_i.tax}" value="{$tax_i.id}" name="contribution_{$contribution_item.id}[]"> {$tax_i.tax} ({$tax_i.rate|floor}%) </label>  
	{/foreach}
    </td>
  </tr>
{/foreach}
</table>

<p>&nbsp;</p>

<p>Adjust existing tax rates or add new tax types using the form below.</p>

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
	  <td><input type="checkbox" id="taxes_{$tax_i.tax}" value="{$tax_i.id}" name="tax_types_{$tax_i.tax}[]" {if $tax_i.active == 1} checked {/if}</td>
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


</style>

{/literal} 