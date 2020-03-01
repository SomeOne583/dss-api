class MazeClass
    attr_accessor :maze, :size

    def initialize(exp)
        @size = 2 ** exp + 1
        @maze = genMazeTem(size)
        searchWayOut(maze, [1, 1], [[size - 2, 1], [1, size - 2], [size - 2, size - 2]])
        mazeGen(maze)
    end
    
    def displayMaze(maze)
        0.upto(maze.length - 1) do
            |n|
            print "#{maze[n]}\n"
        end
    end

    def genMazeTem (size)
        maze = []
        size.times do
            maze << []
        end
        0.upto(size - 1) do
            | n1 |
            0.upto(size - 1) do
                | n2 |
                if (n1 == 0 || n1 == size - 1) || (n2 == 0 || n2 == size - 1)
                    maze[n1][n2] = 1
                else
                    maze[n1][n2] = 0
                end 
            end
        end
        return maze
    end
    
    def mazeGen(maze, c1 = [1, 1], c2 = [size - 2, 1], c3 = [1, size - 2], c4 = [size - 2, size - 2])
        d = c2[0] - c1[0] + 1
        if d == 3
            if maze[c1[1] + 1][c1[0] + 1] != 2
                maze[c1[1] + 1][c1[0] + 1] = 1
            end
            path = rand(4)
            case path
            when 0
                if maze[c1[1]][c1[0] + 1] != 2
                    maze[c1[1]][c1[0] + 1] = 1
                end
            when 1
                if maze[c2[1] + 1][c2[0]] != 2
                    maze[c2[1] + 1][c2[0]] = 1
                end
            when 2
                if maze[c3[1]][c3[0] + 1] != 2
                    maze[c3[1]][c3[0] + 1] = 1
                end
            when 3
                if maze[c1[1] + 1][c1[0]] != 2
                    maze[c1[1] + 1][c1[0]] = 1
                end
            end
        else
            cc1 = c1[0] + (d/2).floor
            cc2 = c1[1] + (d/2).floor
            center = [cc1, cc2]
            if maze[center[1]][center[0]] != 2
                maze[center[1]][center[0]] = 1
            end
            path = rand(4)
            paths = [0, 1, 2, 3]
            drawWalls(maze, c1, c2, c3, c4, center, paths)
            paths.delete(path)
            openHoles(maze, c1, c2, c3, c4, center, paths)
        end
        if c4[0] + 1 == maze.length - 1 && c4[1] + 1 == maze.length - 1
            if d != 3
                c1 = [1, 1]
                c2 = [c1[0] + (d/2).floor - 1, c1[1]]
                c3 = [c1[0], c1[1] + (d/2).floor - 1]
                c4 = [c2[0], c3[1]]
                mazeGen(maze, c1, c2, c3, c4)
            end
        elsif c4[0] + 1 == maze.length - 1
            c1 = [1, c1[1] + d + 1]
            c2 = [c1[0] + d - 1, c1[1]]
            c3 = [1, c1[1] + d - 1]
            c4 = [c2[0], c3[1]]
            mazeGen(maze, c1, c2, c3, c4)
        else
            c1 = [c1[0] + d + 1, c1[1]]
            c2 = [c1[0] + d - 1, c2[1]]
            c3 = [c3[0] + d + 1, c3[1]]
            c4 = [c3[0] + d - 1, c4[1]]
            mazeGen(maze, c1, c2, c3, c4)    
        end
    end
    
    def openHoles(maze, c1, c2, c3, c4, center, paths)
        paths.each do
            |path|
            d = center[0] - c1[0] - 1
            hole = rand(1..d)
            case path
            when 0
                if maze[center[1] - hole][center[0]] != 2
                    maze[center[1] - hole][center[0]] = 0
                end
            when 1
                if maze[center[1]][center[0] + hole] != 2
                    maze[center[1]][center[0] + hole] = 0
                end
            when 2
                if maze[center[1] + hole][center[0]] != 2
                    maze[center[1] + hole][center[0]] = 0
                end
            when 3
                if maze[center[1]][center[0] - hole] != 2
                    maze[center[1]][center[0] - hole] = 0
                end
            end
        end
    end
    
    def drawWalls(maze, c1, c2, c3, c4, center, paths)
        paths.each do
            |path|
            case path
            when 0
                center[1].downto(c1[1]) do
                    |y|
                    if maze[y][center[0]] != 2
                        maze[y][center[0]] = 1
                    end
                end
            when 1
                center[0].upto(c2[0]) do
                    |x|
                    if maze[center[1]][x] != 2
                        maze[center[1]][x] = 1
                    end
                end
            when 2
                center[1].upto(c3[1]) do
                    |y|
                    if maze[y][center[0]] != 2
                        maze[y][center[0]] = 1
                    end
                end
            when 3
                center[0].downto(c1[0]) do
                    |x|
                    if maze[center[1]][x] != 2
                        maze[center[1]][x] = 1
                    end
                end
            end
        end
    end

    def checkNeighbors(maze, c, query)
      amnt = 0
      tiles = [[c[0], c[1] - 1], [c[0] + 1, c[1]], [c[0], c[1] + 1], [c[0] - 1, c[1]]] # Check up, next, down, before
      tiles.each do
        |cT|
        if maze[cT[1]][cT[0]] == query
          amnt += 1
        end
      end
      return amnt
    end

    def checkPath(maze, c, path, query)
        case path
        when 0
            (c[1] - 1).downto(0) do
                | y |
                if maze[y][c[0]] == query
                    return true
                end
            end
        when 1
            (c[0] + 1).upto(maze.length - 1) do
                | x |
                if maze[c[1]][x] == query
                    return true
                end
            end
        when 2
            (c[1] + 1).upto(maze.length - 1) do
                | y |
                if maze[y][c[0]] == query
                    return true
                end
            end
        when 3
            (c[0] - 1).downto(0) do
                | x |
                if maze[c[1]][x] == query
                    return true
                end
            end
        end
        return false
    end

    def searchWayOut(maze, cI, cF)
        cA = cN = cI
        maze[cA[1]][cA[0]] = 2
        while cF.include?(cA) == false do
            path = rand(4)
            if checkPath(maze, cA, path, 2) == true
                next
            end
            case path
            when 0
                if maze[cA[1] - 1][cA[0]] != 1 && maze[cA[1] - 1][cA[0]] != 2
                    cN = [cA[0], cA[1] - 1]
                    if checkNeighbors(maze, cN, 2) == 1
                        cA = cN
                    end
                end
            when 1
                if maze[cA[1]][cA[0] + 1] != 1 && maze[cA[1]][cA[0] + 1] != 2
                    cN = [cA[0] + 1, cA[1]]
                    if checkNeighbors(maze, cN, 2) == 1
                        cA = cN
                    end
                end
            when 2
                if maze[cA[1] + 1][cA[0]] != 1 && maze[cA[1] + 1][cA[0]] != 2
                    cN = [cA[0], cA[1] + 1]
                    if checkNeighbors(maze, cN, 2) == 1 # Check up, next, down, before
                        cA = cN
                    end
                end
            when 3
                if maze[cA[1]][cA[0] - 1] != 1 && maze[cA[1]][cA[0] - 1] != 2
                    cN = [cA[0] - 1, cA[1]]
                    if checkNeighbors(maze, cN, 2) == 1
                        cA = cN
                    end
                end
            end
            maze[cA[1]][cA[0]] = 2
        end
        maze[cI[1]][cI[0] - 1] = 2
        if cA[0] == cA[1]
            maze[cA[1]][cA[0] + 1] = 2
        elsif cA[0] > cA[1]
            maze[cA[1]][cA[0] + 1] = 2
        elsif cA[0] < cA[1]
            maze[cA[1] + 1][cA[0]] = 2
        end 
    end
end
