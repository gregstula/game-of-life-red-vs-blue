//
//  GoLGridController.swift
//  LifeGenSwift
//
//  Created by Gregory D. Stula on 8/30/15.
//  Copyright (c) 2015 Gregory D. Stula. All rights reserved.
//

import Foundation
import UIKit

class GoLGrid {
    
    // MARK: Properties
    let rowMax:Int
    let colMax:Int
    
    var useColoredCells:Bool = false
    var generationCount = 0
    private var cellsKnowTheirPosition:Bool = false
    
    let cellGrid:LiteMatrix<Cell>
    
    // Mark: Init
    init (useColor answer:Bool, rowSize:Int, columnSize colSize:Int) {
        rowMax = rowSize
        colMax = colSize
        cellGrid = LiteMatrix<Cell>(rows: rowSize, columns: colSize)
        useColoredCells = answer
        
        if useColoredCells {
            for var i = 0; i < rowMax; i++ {
                for var j = 0; j < colMax; j++ {
                    cellGrid[i,j] = GoLColorCell(grid: self)
                }
            }
        } else {
            for var i = 0; i < rowMax; i++ {
                for var j = 0; j < colMax; j++ {
                    cellGrid[i,j] = GoLCell(grid: self)
                }
            }
        }
    }

    
    // Mark: Generation handling
    private func prepNextGeneration() {
        // Cells should know where they are mapped on the matrix
        if !self.cellsKnowTheirPosition {
            for var i = 0; i < rowMax; i++ {
                for var j = 0; j < colMax; j++ {
                    cellGrid[i,j].coordinates = (row:i, col:j)
                }
            }
            cellsKnowTheirPosition = true
        }
        
        for cell in cellGrid {
            cell.calculateNextAction()
        }
   }
   
    
    private func executeNextGeneration() {
        for cell in cellGrid {
            cell.executeNextAction()
        }
    }
    
    
    func prepareAndExecuteNextGeneration() {
        self.prepNextGeneration()
        self.executeNextGeneration()
        generationCount++
    }
}


// MARK: Console output
extension GoLGrid {

    func printGridToConsole() {
        for i in 0..<rowMax {
            for j in 0..<colMax {
                cellGrid[i, j].isAlive ? print(" \(cellGrid[i,j].numberOfNeighbors)") : print(" . ")
            }
            println()
        }
        println()
        println()
    }
}