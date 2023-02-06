import "ecere"
import "sqliteDB"

class PartialDiskCache : SQLiteDB
{
public:
   PartialDiskCache ::open(const String dbFileName)
   {
      // call SQLiteDB::open() etc. passing class(PartialDiskCache)
   }

   uint64 retrieve(byte * buffer, uint64 start, uint64 count, int64 assetID)
   {
      // Look in DB for assetID with this start and count and return the blob if found

      // If cache entry found, set time stamp to global now with DateTime

   }

   bool cache(const byte * buffer, uint64 start, uint64 count, int64 assetID)
   {
      // Add entry to DB with this start, count, assetID and buffer blob

      // If cache entry found, set time stamp to global now with DateTime
   }

   ~PartialDiskCache()
   {
   }
}

public class DiskCachedFile : File
{
   File fHandle;
   int64 assetID;
   int64 position;
   uint64 blockSize; blockSize = 512 * 1024;
   PartialDiskCache cache;

   public property uint64 blockSize { set { blockSize = value; } get { return blockSize; } }

   public DiskCachedFile ::setup(File file, int64 assetID, PartialDiskCache cache)
   {
      DiskCachedFile result = null;
      if(file)
      {
         result = { fHandle = file, cache = cache, assetID = assetID };
         incref file;
      }
      return result;
   }

   uintsize Read(void * buffer, uintsize size, uintsize count)
   {
      uintsize readBytes = 0;
      uint64 fileSize = GetSize();
      uint64 readSize = Min(size * count, fileSize - position); // Can't read more than there is left to read
      uint64 firstBlock = position / blockSize;
      uint64 firstBlockRead = (firstBlock + 1) * blockSize - position; // How much of the first block do we read
      uint64 lastBlock = (position + readSize) / blockSize;
      uint64 lastBlockRead = position + readSize - lastBlock * blockSize; // How much of the last block do we read
      uint64 blockStart = firstBlock * blockSize;
      uint64 veryLastBlock = Max(0, (fileSize-1) / blockSize); // The very last block at the end of the file
      byte * tmp = new byte[blockSize];
      int64 block;

      if(firstBlock == lastBlock)
         firstBlockRead = lastBlockRead = readSize; // Single block read
      if(!lastBlockRead && readSize)
         lastBlockRead = blockSize; // Full last block

      for(block = firstBlock; block <= lastBlock; block++)
      {
         int64 nb = 0;
         int64 expected = block == veryLastBlock ? (fileSize % blockSize) : blockSize;
         bool wasCached = false;

         if(cache)
            nb = cache.retrieve(tmp, blockStart, blockSize, assetID);
         if(nb)
            wasCached = true;
         else
         {
            fHandle.Seek(blockStart, start);
            nb = fHandle.Read(tmp, 1, blockSize);
         }

         if(nb == expected)
         {
            // Which part of the block do we need
            int64 srcStart = block > firstBlock ? 0 : blockSize - firstBlockRead;
            // Where do we copy to in the caller's buffer
            int64 dstStart = block == firstBlock ? 0 : firstBlockRead + (block - firstBlock - 1) * blockSize;
            // How many bytes do we copy
            int64 cpyCount = block == firstBlock ? firstBlockRead : block == lastBlock ? lastBlockRead : blockSize;

            memcpy(buffer + dstStart, tmp + srcStart, cpyCount);
            readBytes += cpyCount;

            if(!wasCached && cache)
               cache.store(tmp, blockStart, blockSize, assetID);

            blockStart += blockSize;
         }
         else
            break;   // Could not read expected number of bytes for block
      }
      delete tmp;
      return readBytes / size;
   }

   bool Seek(int64 pos, FileSeekMode mode)
   {
      uint64 size = GetSize();
      int64 np = -1;
      switch(mode)
      {
         case start:   np = pos;        break;
         case end:     np = size + pos; break;
         case current: np += pos;       break;
      }
      if(np >= 0 && np <= size)
      {
         position = np;
         return true;
      }
      return false;
   }

   uint64 Tell(void) { return position; }

   uint64 GetSize() { return fHandle.GetSize(); }

   ~DiskCachedFile() { delete fHandle; }
}
