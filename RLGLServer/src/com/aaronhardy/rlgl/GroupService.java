package com.aaronhardy.rlgl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

public class GroupService {
	public Map<String, String> getColorForGroup(String groupName)
	{
		System.out.println("Startup called.");
		Group group = getGroupByName(groupName);
		Map<String, String> map = new HashMap<String, String>();
		map.put("lastModifiedAlias", group.getLastModifiedAlias());
		map.put("color", group.getColor());
		return map;
	}
	
	@SuppressWarnings("unchecked")
	private Group getGroupByName(String groupName)
	{
		Group group = null;
		
		PersistenceManager pm = PMF.get().getPersistenceManager();
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
		}
		finally
		{
			query.closeAll();
			pm.close();
		}
		
		if (group == null)
		{
			group = createGroupByName(groupName);
		}
		
		return group;
	}
	
	private Group createGroupByName(String groupName)
	{
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Group group = new Group();
		group.setName(groupName);
		group.setColor("green");
		group.setLastModifiedAlias("nobody");
		
		try
		{
			pm.makePersistent(group);
		}
		finally
		{
			pm.close();
		}
		
		return group;
	}
}
