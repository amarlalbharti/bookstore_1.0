package com.bookstore.comparator;

import java.util.Comparator;

import com.bookstore.domain.OrderItem;

public class OrderItemComparator  implements Comparator<OrderItem>
{

	public int compare(OrderItem item1, OrderItem item2)
	{
		if(item1 ==null || item2 == null) {
			return 0;
		}else {
			return item1.getProduct().getProductName().compareToIgnoreCase(item2.getProduct().getProductName());
		}
		
	}

}
