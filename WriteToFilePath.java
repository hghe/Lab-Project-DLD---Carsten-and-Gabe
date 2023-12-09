import java.io.FileWriter;
import java.io.BufferedWriter;
import java.io.IOException;

public class WriteToFilePath {

    public static void main(String[] args) {
        // Specify the file path
        String filePath = "datapath.out";

        // Call a method to generate and write declarations to the file
        generateDeclarations(filePath, 16);
    }

    private static void generateDeclarations(String filePath, int gridSize) {
        try {
            // Create a FileWriter with the specified file path
            FileWriter fileWriter = new FileWriter(filePath);

            // Create a BufferedWriter for efficient writing
            BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);

            // Loop through each row and column to generate declarations
            for (int row = 0; row < gridSize; row++) {
                for (int col = 0; col < gridSize; col++) {
                    int index = row * gridSize + col;

                    // Write declarations to the file
                    writeDeclaration(bufferedWriter, row, col, index);
                }
            }

            // Close the BufferedWriter to flush and release resources
            bufferedWriter.close();

            System.out.println("Declarations have been written to " + filePath);
        } catch (IOException e) {
            // Handle potential IOException (e.g., file not found, permission issues)
            e.printStackTrace();
        }
    }

    private static void writeDeclaration(BufferedWriter writer, int row, int col, int index) throws IOException {
        // Write evolve3 and evolve5 declarations to the file
        /*
        if ((col == 0 || col == 15) && (row == 0 || row == 15)) {
            writer.write(String.format("evolve3 e%d_%d (grid_evolve[%d], grid[%d], grid[%d], grid[%d], grid[%d], grid[%d]);\n",
                    row, col, index, index, index - 1, index + 1, index + 16, index + 16 - 1));
        } else if(row == 0 || row == 15 || col == 0 || col ==15){
            writer.write(String.format("evolve5 e%d_%d (grid_evolve[%d], grid[%d], grid[%d], grid[%d], grid[%d], grid[%d], grid[%d]);\n",
                    row, col, index, index - 1, index + 1, index - 16, index + 16, index - 16 - 1, index + 16 + 1));
        } else{
            writer.write(String.format("evolve8 e%d_%d (grid_evolve[%d], grid[%d], grid[%d], grid[%d], grid[%d], grid[%d], grid[%d]);\n",
                    row, col, index, index - 1, index + 1, index - 16, index + 16, index - 16 - 1, index + 16 + 1));
        }
    }*/ if((row == 0 && col == 0) || (row == 0 && col == 15) || (row == 15 && col == 0) || (row == 15 && col == 15)) {
            writer.write(String.format("Fill In!!!!!!\n"));
        }
        else if (row == 0 && (col != 0 || col != 15)) {
            writer.write(String.format("evolve5 e%d_%d (grid_evolve[%d], grid[%d], grid[%d], grid[%d], grid[%d], grid[%d], grid[%d]);\n",
                    row, col, index, index - 1, index + 1, index + 15, index + 16, index + 17, index));
        } else if (row == 15 && (col != 0 || col != 15)) {
            writer.write(String.format("evolve5 e%d_%d (grid_evolve[%d], grid[%d], grid[%d], grid[%d], grid[%d], grid[%d], grid[%d]);\n",
                    row, col, index, index - 1, index + 1, index - 15, index - 16, index - 17, index));
        } else if (row != 0 && row != 15 && col == 0) {
            writer.write(String.format("evolve5 e%d_%d (grid_evolve[%d], grid[%d], grid[%d], grid[%d], grid[%d], grid[%d], grid[%d]);\n",
                    row, col, index, index - 16, index - 15, index + 1, index + 16, index + 17, index));
        } else if (row != 0 && row != 15 && col == 15) {
            writer.write(String.format("evolve5 e%d_%d (grid_evolve[%d], grid[%d], grid[%d], grid[%d], grid[%d], grid[%d], grid[%d]);\n",
                    row, col, index, index - 16, index - 17, index - 1, index + 15, index + 16, index));
        } else {
            writer.write(String.format("evolve8 e%d_%d (grid_evolve[%d], grid[%d], grid[%d], grid[%d], grid[%d], grid[%d], grid[%d], grid[%d], grid[%d], grid[%d]);\n",
                    row, col, index, index - 17, index - 16, index - 15, index - 1, index + 1, index + 15, index + 16, index + 17, index));
        }
    }
}
