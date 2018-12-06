import org.apache.spark.SparkContext
import org.apache.spark.input.PortableDataStream
import ncsa.hdf.hdf5lib.H5
import ncsa.hdf.hdf5lib.HDF5Constants

object Hello {
  def getLyrics(content: PortableDataStream): (String, String) = {
    H5.
    content.open()
  }

  def main(args: Array[String]): Unit = {
    println("Hi there!")
    val sc = new SparkContext("local[*]", "karaoke")
    val rdd = sc.binaryFiles("").map { case (_, content: PortableDataStream) => getLyrics(content) }



  }
}