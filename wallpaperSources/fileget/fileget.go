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

// accepted extensions

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

	// fmt.Println("The Selected File is-")
	fmt.Printf(FileList[random.Intn(len(FileList))])

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
