import java.io.*;
import org.tsho.jidmclib.*;

public class basin_multi {
	static {
		String path = System.getProperty("user.dir") + File.separator;
		String ext;
		if (System.getProperty("os.name").startsWith("Windows"))
			ext=".dll";
		else
			ext=".so";
		System.load(path + "jidmclib" + ext);
	}

	static SWIGTYPE_p_double as_C_array(double[] x) {
		SWIGTYPE_p_double ans = idmc.new_doubleArray(x.length);
		for(int i=0; i<x.length; i++) {
			idmc.doubleArray_setitem(ans, i, x[i]);
		}
		return ans;
	}

	static double[] as_Java_array(SWIGTYPE_p_double x, int size) {
		double ans[] = new double[size];
		for(int i=0; i<ans.length; i++) {
			ans[i] = idmc.doubleArray_getitem(x, i);
		}
		return ans;
	}

	public static void main(String argv[]) {
		int ntries = 40;
		String modelBuffer = readFile(new File("basin_test1.lua"));
		Model m = new Model(modelBuffer, modelBuffer.length());
		BasinMulti bs = new BasinMulti(m,
			as_C_array(new double[] {1,1, 2,2, 3,1, 0.499}), 0, 4, 8, 0, 2, 4, //parameters, x-ranges, y-ranges
			1e-4, 2, 2, //eps, attractorLimit, attractorIterations
			ntries, 0, 1, //ntries, xvar, yvar
			as_C_array(new double[] {0, 0, 0, 0}));
		for(int i=0; i<ntries; i++)
			bs.find_next_attractor();
		
		attr_lst attractors = bs.getAttr_head();
		if(idmc.idmc_attractor_list_length(attractors) != 3)
			throw new RuntimeException("found unexpected number of attractors");

		int i=0;
		while(bs.finished()==0) {
			bs.step();
			if(i>=32)
				throw new RuntimeException("unexpected number of iterations needed to fill basins");
			i++;
		}

	}

	static String readFile(File f) {
		StringBuffer contents = new StringBuffer();
		BufferedReader input = null;
		try {
			input = new BufferedReader( new FileReader(f) );
			String line = null; //not declared within while loop
			while (( line = input.readLine()) != null){
				contents.append(line);
				contents.append(System.getProperty("line.separator"));
			}
		}
		catch (FileNotFoundException ex) {
			ex.printStackTrace();
		}
		catch (IOException ex){
			ex.printStackTrace();
		}
		finally {
			try {
				if (input!= null) {
					input.close();
				}
			}
			catch (IOException ex) {
				ex.printStackTrace();
			}
		}
		return contents.toString();
	}
}
