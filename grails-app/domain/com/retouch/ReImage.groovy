package com.retouch

class ReImage {

    String imagePath

    static constraints = {
        imagePath(nullable: false, blank:false)
    }

    String toString(){
        return imagePath
    }

    String getLargeImageName(){
       return getSubName(imagePath,"_L")
    }

    String getThumbnailImageName(){
        return getSubName(imagePath,"_T")
    }

     static String getSubName(String fullFileName,subSuffix){
         int lastIndexOf = fullFileName.lastIndexOf(".");
         def part = subSuffix
         if (lastIndexOf == -1) {
             return fullFileName + part; // empty extension
         }
         return  fullFileName.substring(0,lastIndexOf) + part + fullFileName.substring(lastIndexOf);
    }

}
