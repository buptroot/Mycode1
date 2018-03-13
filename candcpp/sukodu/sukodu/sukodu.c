
//用回溯法解决数独Sudoku问题
#include <stdio.h>
//9x9的数独网格
#define N 9
//待填空格用0定义
#define UNASSIGNED 0
//返回01作为指定行中是否有与给定数字相匹配的单元
int is_exist_row(int grid[N][N], int row, int num){
  for (int col = 0; col < 9; col++) {
    if (grid[row][col] == num) {
      return 1;
    }
  }
  return 0;
}
//同上
int is_exist_col(int grid[N][N], int col, int num) {
  for (int row = 0; row < 9; row++) {
    if (grid[row][col] == num) {
      return 1;
    }
  }
  return 0;
}
//返回01,指示3*3网格中任何指定单元是否与指定数字匹配
int is_exist_box(int grid[N][N], int startRow, int startCol, int num) {
  for (int row = 0; row < 3; row++) {
    for (int col = 0; col < 3; col++) {
      if (grid[row + startRow][col + startCol] == num) {
        return 1;
      }
    }
  }
  return 0;
}
//同行同列同小方格不能出现相同数字
int is_safe_num(int grid[N][N], int row, int col, int num) {
  return !is_exist_row(grid, row, num)
      && !is_exist_col(grid, col, num)
      && !is_exist_box(grid, row - (row % 3), col - (col %3), num);
}
//找到未被分配的单元
int find_unassigned(int grid[N][N], int *row, int *col) {
  for (*row = 0; *row < N; (*row)++) {
    for (*col = 0; *col < N; (*col)++) {
      if (grid[*row][*col] == 0) {
        return 1;
      }
    }
  }
  return 0;
}
//回溯算法
int solve(int grid[N][N])
{
  int row = 0;
  int col = 0;

  if (!find_unassigned(grid, &row, &col))
  {
    return 1;//success
  }

  for (int num = 1; num <= N; num++ )
  {

    if (is_safe_num(grid, row, col, num))
    {
      grid[row][col] = num;//初步分配

      if (solve(grid)) {//回溯关键点
        return 1;
      }

      grid[row][col] = UNASSIGNED;//失败重新分配
    }
  }

  return 0;
}

void print_grid(int grid[N][N]) {
  for (int row = 0; row < N; row++) {
    for (int col = 0; col < N; col++) {
      printf("%2d", grid[row][col]);
    }
    printf("\n");
  }
}

int main() {

  int grid[N][N] = {{8,0,0, 0,0,0, 0,0,0},
       {0,0,3, 6,0,0, 0,0,0},
       {0,7,0, 0,9,0, 2,0,0},
       {0,5,0, 0,0,7, 0,0,0},
       {0, 0, 0, 0, 4, 5, 7, 0, 0},
       {0, 0, 0, 1, 0, 0, 0, 3, 0},
       {0, 0, 1, 0, 0, 0, 0, 6, 8},
       {0, 0, 8, 5, 0, 0, 0, 1, 0},
       {0, 9, 0, 0, 0, 0, 4, 0, 0}};

  if (solve(grid)) {
    print_grid(grid);
  } else {
    printf("no solution");
  }

  return 0;
}
