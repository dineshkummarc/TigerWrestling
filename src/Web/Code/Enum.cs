namespace Web.Code
{
	public enum ConfigKey
	{		
		EmailSmtpServer
		//EmailFrom,
		//EmailFriendlyFrom,
		//ReportNames
	}

	public enum MembershipRole
	{
		Developer,
		Admin,
		//QA,
		Audit,
		Edit,
		Log,
		Approve,
		Report,
		Moderate
	}

	#region Statuses

	public enum WorkflowStatus
	{
		Draft = 0,
        Active = 1,
        Archived = 2,
        Deleted = 3
		//Disabled = 3
	}

	/*
	public enum ModeratorStatus
	{
		Active,
		Reported,
        Rejected, 
        Approved,
        Preview
	}*/
	#endregion

	#region Project-specific

	
	#endregion
}