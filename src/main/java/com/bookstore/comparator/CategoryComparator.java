package com.bookstore.comparator;

import java.util.Comparator;

import com.bookstore.domain.Category;

public class CategoryComparator implements Comparator<Category>
{

	public int compare(Category o1, Category o2)
	{
		return o1.getDisplayOrder() - o2.getDisplayOrder() ;
	}

}
