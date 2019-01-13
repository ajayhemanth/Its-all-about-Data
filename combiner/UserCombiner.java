import java.io.IOException;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class UserCombiner extends Reducer<Text, IntWritable, Text, IntWritable> {
	protected void reduce(Text key, Iterable<IntWritable> values, Context context)
		throws IOException, InterruptedException {
		int sum=0;
		for (IntWritable val : values) {
			sum+=val.get();
		}
		context.write(new Text(key), new IntWritable(sum));
	}
}
