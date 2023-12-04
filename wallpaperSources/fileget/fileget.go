package main

import (
	"fmt"
	"io/fs"
	"math/rand"
	"os"
	"path/filepath"
	"slices"
	"strings"
	"time"
)

// func visit(path string, di fs.DirEntry, err error) error {
// 	fmt.Printf("Visited: %s\n", path)
// 	return nil
// }

var Extensions []string
var FileList []string

func addToList(path string, di fs.DirEntry, err error) error {
	if slices.Contains(Extensions, string(strings.Split(path, ".")[len(strings.Split(path, "."))-1])) {
		FileList = append(FileList, path)
	}
	return nil
}

func main() {
	// accepted extensions
	Extensions = []string{"png", "jpg", "jpeg"}

	source := rand.NewSource(time.Now().UnixNano())
	random := rand.New(source)

	for _, directory := range os.Args[1:] {
		err := filepath.WalkDir(directory, addToList)
		if err != nil {
			fmt.Printf("There was a problem reading %v-\n%v", directory, err)
		}
		// fmt.Printf("yooo added %v\n", directory)
	}

	selectedFile := FileList[random.Intn(len(FileList))]
	// fmt.Println("The Selected File is-")
	fmt.Print(selectedFile)

	file, err := os.OpenFile("/home/harshit/.config/awesome/wallpaperSources/fileget/history.lua", os.O_WRONLY, os.ModeAppend)
	if err != nil {
		fmt.Printf("There was a problem opening history.lua-\n%v", err)
	}
	file.Seek(-1, 2) // offset -1 from the end
	_, err = file.WriteString(fmt.Sprintf("\"%v\",\n}", selectedFile))
	if err != nil {
		fmt.Printf("There was a problem writing to history.lua-\n%v", err)
	}
	file.Close()

	// fmt.Println(FileList)

	// flag.Parse()
	// // root := flag.Arg(0)

}

// package main

// import (
// 	"fmt"
// 	"os"
// 	"path/filepath"
// 	"io/fs"
// )

// func main() {

// 	for _, hey := range os.Args[1:] {
// 		fmt.Println(hey)
// 	}
// 	// for hey of os.Args[1:] {
// 	// 	fmt.Println(hey)
// 	// }
// 	filepath.WalkDir("/")
// }
