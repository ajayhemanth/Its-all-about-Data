import java.io.IOException;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;


//ALL COMMENTS DESCRIBE THE LINE OF CODE IMMEDIATELY BELOW IT


//we need to inherit the mapper class so that we can override the map function inside it.

//the sequence of java generic is <key-in, value-in, key-out, value-out>
//for mapper key-in is row offset.since it is very big we have given as LongWritable
//for mapper value-in is row value, which is Text
//for mapper key-out is group by column, which is sent as Text
//for mapper value-out is the column on which aggregation is to be done is reducer. so it is IntWritable

//The key class of a mapper that maps text files is always LongWritable. That is because it contains the byte offset of the current line and this could easily overflow an integer.

public class UserMap extends Mapper<LongWritable, Text, Text, IntWritable>{
	
	//whatever written in the map function is the code that goes to the place where the input split is present to be executed
	@Override
	protected void map(LongWritable key, Text value, Context context)
			throws IOException, InterruptedException {
		//splitting the column based on the delimiter and storing it in a variable
		String[] columns=value.toString().split(",");
		//storing the aggregate column in a variable
		Integer mark = new Integer(columns[3]);
		//sending the key and value output to the reducer.
		//here key is the group by column and value is the aggregate column
		context.write(new Text(columns[0]), new IntWritable(mark) );
		
		}
}
