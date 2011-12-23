using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.DynamicData; 
using System.Web.UI;
using System.Collections;

[AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
public class ColumnMetadataAttribute : Attribute
{
    public int Order { get; private set; }


    public ColumnMetadataAttribute()
        : this(int.MaxValue )
    { }
     

    public ColumnMetadataAttribute(int order )
    {
        //Sets the column order.
        Order = order; 
    }

    public ColumnMetadataAttribute(params PageTemplate[] lookupTable)
        : this(int.MaxValue )
    { }

    public static ColumnMetadataAttribute Default = new ColumnMetadataAttribute();
}



[AttributeUsage(AttributeTargets.Property)]
public class HideColumnInAttribute : Attribute
{
    public PageTemplate[] PageTemplates { get; private set; }

    public HideColumnInAttribute()
    {
        PageTemplates = new PageTemplate[0];
    }

    public HideColumnInAttribute(params PageTemplate[] lookupTable)
    {
        PageTemplates = lookupTable;
    }

    public static HideColumnInAttribute Default = new HideColumnInAttribute();
}

public enum PageTemplate
{
    Details,
    Edit,
    Insert,
    List,
    ListDetails,
    // add any custom page templates here
}

public class HideColumnFieldsManager : IAutoFieldGenerator
{
    protected MetaTable _table;
    protected PageTemplate _currentPage;

    public HideColumnFieldsManager(MetaTable table, PageTemplate currentPage)
    {
        _table = table;
        _currentPage = currentPage;
    }

    public ICollection GenerateFields(Control control)
    {
        var oFields = new List<DynamicField>();

        foreach (var column in _table.Columns)
        {
            // carry on the loop at the next column  
            // if scaffold table is set to false or DenyRead
            if (!column.Scaffold ||
                column.IsLongString ||
                column.IsHidden(_currentPage))
                continue;

            var f = new DynamicField();

            f.DataField = column.Name;
            oFields.Add(f);
        }
        return oFields;
    }
}

public static class ExtensionMethods
{
    public static Boolean IsHidden(this MetaColumn column, PageTemplate currentPage)
    {
        var hideIn = column.Attributes.OfType<HideColumnInAttribute>().DefaultIfEmpty(new HideColumnInAttribute()).First() as HideColumnInAttribute;
        return hideIn.PageTemplates.Contains(currentPage);
    }
}
