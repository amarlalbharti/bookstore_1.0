/**
 * 
 */
package test.bookstore.config;

import static org.junit.Assert.assertNotEquals;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.bookstore.config.Util;

import junit.framework.TestCase;

/**
 * @author amar.b
 *
 */
public class UtilTest extends TestCase
{

	/* (non-Javadoc)
	 * @see junit.framework.TestCase#setUp()
	 */
	@Before
	protected void setUp() throws Exception
	{
		super.setUp();
	}

	/* (non-Javadoc)
	 * @see junit.framework.TestCase#tearDown()
	 */
	@After
	protected void tearDown() throws Exception
	{
		super.tearDown();
	}

	/**
	 * Test method for {@link com.bookstore.config.Util#getNumeric(java.lang.String)}.
	 */
	@Test
	public void testGetNumeric()
	{
		assertEquals(10, Util.getNumeric("10").intValue());
		assertEquals(100, Util.getNumeric("100").intValue());
		assertEquals(150, Util.getNumeric("150").intValue());
		assertNotEquals(10.0, Util.getNumeric("100").doubleValue(), .5);
	}

}
