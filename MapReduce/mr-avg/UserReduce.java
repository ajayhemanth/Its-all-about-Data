import java.io.IOException;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;


//ALL COMMENTS DESCRIBE THE LINE OF CODE IMMEDIATELY BELOW IT



//we need to inherit the reducer class so that we can override the reduce function inside it.

//the sequence of java generic is <key-in, value-in, key-out, value-out>
//for reducer key-in and value-in is mapper's key-out and value-out

public class UserReduce extends Reducer<Text, IntWritable, Text, IntWritable> {

	protected void reduce(Text key, Iterable<IntWritable> values, Context context)
			throws IOException, InterruptedException {
		int count=0;
		int sum=0;

		//iterate through and add each and every <value-in> of reducer for the particular <key-in> that it is executing for
		for (IntWritable val : values) {
			count++;
			sum+=val.get();
			}
	
		//find the average of reducer <value-in> of that particular reducer <key-in>
		int avg=sum/count;
		
		context.write(new Text(key), new IntWritable(avg));

	}
}
