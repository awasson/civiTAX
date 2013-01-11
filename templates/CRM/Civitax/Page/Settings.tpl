<h3>CiviCRM Tax Module Settings</h3>

<p>Select applicable taxes for contribution types from the table below.</p>

<table class="civi-tax-configuration" cellpadding="0" cellspacing="0" border="0">
  <tr>
    <th>Contribution Type</th>
    <th>Applicable Taxes</th>
  </tr>
{foreach from=$arr_contribution_types key=contribution_id item=contribution_item}
  <tr>
    <td class="civi-tax-contribution-type">{$contribution_item.name}</td>
    <td class="civi-tax-applicable-taxes">
    {foreach from=$arr_tax_types key=tax_id item=tax_i}
		<input type="checkbox" id="memberships_{$tax_i.tax}" value="{$tax_i.id}" name="contribution_{$contribution_item.id}[]"> - {$tax_i.tax} ({$tax_i.rate}) &nbsp;   
	{/foreach}
    </td>
  </tr>
{/foreach}
</table>

<p>Adjust existing tax rates or add new tax types using the form below.</p>



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


</style>

{/literal} 