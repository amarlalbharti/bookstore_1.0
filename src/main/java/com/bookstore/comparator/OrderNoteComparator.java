package com.bookstore.comparator;

import java.util.Comparator;

import com.bookstore.domain.OrderNote;

public class OrderNoteComparator   implements Comparator<OrderNote>
{
	public int compare(OrderNote note1, OrderNote note2)
	{
		if(note1 ==null || note2 == null) {
			return 0;
		}else {
			return note1.getCreateDate().compareTo(note2.getCreateDate());
		}
		
	}
}
