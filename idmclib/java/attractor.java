import java.io.*;
import org.tsho.jidmclib.*;

public class attractor {
	static {
		String path = System.getProperty("user.dir") + File.separator;
		String ext;
		if (System.getProperty("os.name").startsWith("Windows"))
			ext=".dll";
		else
			ext=".so";
		System.load(path + "jidmclib" + ext);
	}

	public static void main(String argv[]) {
		int n = 3;
		SWIGTYPE_p_double x = idmc.new_doubleArray(n);
		attractor_pt p = idmc.idmc_attractor_point_new(x, n);
		idmc.idmc_attractor_point_free(p);

		p = idmc.idmc_attractor_point_new(x, n);
		attractor_pt p1 = idmc.idmc_attractor_point_new(x, n);
		idmc.idmc_attractor_point_add(p, p1);
		//if (idmc.idmc_attractor_point_last(p) != p1)
			//throw new RuntimeException("unexpected result from 'idmc_attractor_point_last'");

		attr_lst attr = idmc.idmc_attractor_new(n);
		idmc.idmc_attractor_free(attr);

		attr = idmc.idmc_attractor_new(n);
		if(idmc.idmc_attractor_length(attr)!=0)
			throw new RuntimeException("unexpected result from 'idmc_attractor_length'");

		idmc.idmc_attractor_check_point(attr, x, 0.1);
		idmc.idmc_attractor_hd_set(attr, p);

		attr_lst attr1 = idmc.idmc_attractor_new(n);

		idmc.idmc_attractor_list_add(attr, attr1);
		idmc.idmc_attractor_list_free(attr);

		attr = idmc.idmc_attractor_new(n);
		attr1 = idmc.idmc_attractor_new(n);

		idmc.idmc_attractor_list_add(attr, attr1);
		if(idmc.idmc_attractor_list_length(attr) != 2)
			throw new RuntimeException("unexpected result from 'idmc_attractor_list_length'");

		//FIXME: add points to each attractor, so that a merge make sense
		//idmc.idmc_attractor_list_merge(attr_lst head, int a, int b);

		idmc.idmc_attractor_list_check_point(attr, x, 0.1);
		//if(idmc.idmc_attractor_list_get(attr, 0) != attr)
		//	throw new RuntimeException("unexpected result from 'idmc_attractor_list_get'");

		//if(idmc.idmc_attractor_list_last(attr) != attr1)
		//	throw new RuntimeException("unexpected result from 'idmc_attractor_list_last'");

		//FIXME: TODO
		//idmc.idmc_attractor_list_append(attr_lst head, attr_lst i);

		//FIXME: TODO
		//idmc.idmc_attractor_list_drop(attr_lst p);
	}
}
