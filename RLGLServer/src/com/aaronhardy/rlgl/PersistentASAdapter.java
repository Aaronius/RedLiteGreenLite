package com.aaronhardy.rlgl;

import java.util.Date;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import flex.messaging.io.amf.ASObject;
import flex.messaging.messages.AsyncMessage;
import flex.messaging.messages.AsyncMessageExt;
import flex.messaging.messages.Message;
import flex.messaging.services.messaging.adapters.ActionScriptAdapter;

public class PersistentASAdapter extends ActionScriptAdapter {
	private PersistenceManager pm = PMF.get().getPersistenceManager();
	
	@Override
	public Object invoke(Message message) {
		System.out.println("my adapter invoked");
		persistMessage(message);
		return super.invoke(message);
	} 
	
	private void persistMessage(Message message)
	{
		AsyncMessageExt asyncMessage = (AsyncMessageExt)message;
		ASObject body = (ASObject)asyncMessage.getBody();
		String group = body.get("group").toString();
		String alias = body.get("alias").toString();
		String color = body.get("color").toString();
		updateGroup(group, alias, color);
	}
	
	private void updateGroup(String groupName, String alias, String color)
	{
		PersistenceManager pm = PMF.get().getPersistenceManager();
		
		Group group = null;
		Query query = pm.newQuery(Group.class);
		query.setFilter("name == nameParam");
		query.declareParameters("String nameParam");
		query.setRange(0, 1);
		
		try
		{
			List<Group> results = (List<Group>)query.execute(groupName);
			
			if (results.size() > 0)
			{
				group = results.get(0);
			}
			else
			{
				System.err.println("Group " + groupName + " doesn't exist.");
				return;
			}
			
			group.setLastModifiedAlias(alias);
			group.setColor(color);
		}
		finally
		{
			query.closeAll();
			pm.close();
		}
	}
}
