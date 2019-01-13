import java.io.IOException;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.compress.GzipCodec;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;


//ALL COMMENTS DESCRIBE THE LINE OF CODE IMMEDIATELY BELOW IT


public class UserDriver {

	public static void main(String[] args) throws IOException, ClassNotFoundException, InterruptedException {
		// TODO Auto-generated method stub
		
		Job job = new Job();
		
		job.setJobName("ClassAvg");
		job.setJarByClass(UserDriver.class);
    	
    	job.setMapperClass(UserMap.class);
		job.setReducerClass(UserReduce.class);
    	
    	job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(IntWritable.class);
		
		Path in = new Path(args[0]);
		Path out = new Path(args[1]);
		FileInputFormat.setInputPaths(job, in);
		FileOutputFormat.setOutputPath(job, out);

		//below 2 line are used to overwrite the output file if already exists
		Configuration conf = new Configuration();
		out.getFileSystem(conf).delete(out,true);

	    //FileOutputFormat.setCompressOutput(job, true);
	    //FileOutputFormat.setOutputCompressorClass(job, GzipCodec.class);

		//job.setNumReduceTasks(3);

		System.exit(job.waitForCompletion(true) ? 0 : 1);

	}

}
