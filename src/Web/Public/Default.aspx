<%@ Page Language="C#" MasterPageFile="Site.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Web.Public.Default" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<p>
		Vestibulum placerat elit sit amet erat ultricies mattis. Donec tortor mauris, congue
		sit amet sollicitudin sed, lobortis a quam. Nulla sagittis euismod eros, eget egestas
		purus vestibulum eu. Nullam lacinia urna eget purus tincidunt faucibus. Suspendisse
		turpis tortor, consequat suscipit tincidunt id, pellentesque nec velit. Sed sit
		amet justo et dolor posuere fermentum. Mauris mi risus, tristique in mattis et,
		congue non justo. Suspendisse augue nulla, fermentum in elementum sed, laoreet quis
		diam. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus
		mus. Phasellus scelerisque malesuada blandit. Duis blandit congue metus, quis hendrerit
		tortor sagittis id. Donec interdum sem sapien. Phasellus tellus urna, porta id porta
		sit amet, congue et ante. Ut elit orci, faucibus in ornare nec, sagittis in elit.
		Donec augue nisi, placerat non aliquet ac, bibendum nec mauris. Vestibulum lectus
		turpis, facilisis ut commodo nec, imperdiet non purus. Sed sed tempus ligula. Cum
		sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.
	</p>
    
	<uc1:ContentInline ID="SideBar" runat="server" ContentName="test">
		<p>
			bbbbbbbbbbbbb
		</p>
	</uc1:ContentInline>
</asp:Content>