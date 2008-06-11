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
	}
}
