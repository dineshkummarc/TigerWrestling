<%@ Page Title="" Language="C#" MasterPageFile="~/Public/Site1.Master" AutoEventWireup="true" CodeBehind="Photos.aspx.cs" Inherits="Web.Public.Photos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style > 
        #contentPhoto {    background-color: #000000;}
    
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


<section id="contentPhoto" class="content">
 

<embed type="application/x-shockwave-flash" style="display: block; margin-left: auto; margin-right: auto;" src="https://picasaweb.google.com/s/c/bin/slideshow.swf" width="600" height="400" flashvars="host=picasaweb.google.com&captions=1&hl=en_US&feat=flashalbum&RGB=0x000000&feed=https%3A%2F%2Fpicasaweb.google.com%2Fdata%2Ffeed%2Fapi%2Fuser%2Fnmacellaio%2Falbumid%2F5659457926247971137%3Falt%3Drss%26kind%3Dphoto%26authkey%3DGv1sRgCPyE5f6hi_i1fA%26hl%3Den_US" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>

</section>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="javascript" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="javascript2" runat="server">
</asp:Content>
