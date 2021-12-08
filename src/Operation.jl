module Operation
   ## Общие функции
   # Поменять местами строки
   function swaprows(A::Array{Float64,2},row::Int64,row2::Int64)
      for j = 1:size(A)[end]
         r = A[row,j]
         A[row,j] = A[row2,j]
         A[row2,j] = r
      end
      return A
   end
   #Поменять местами столбцы
   function swapcols(A::Array{Float64,2},col::Int64,col2::Int64)
      for i = 1:size(A)[1]
         c = A[i,col]
         A[i,col] = A[i,col2]
         A[i,col2] = c
      end
      return A
   end

   #Поиск элемента с указанным или отличным значением, возвращает координаты этого элемента
   function search(sr::Int64,A::Array{Float64,2},startr::Int64,startc::Int64,same::Bool)
      for i = startr+1:size(A)[1], j = startc+1:size(A)[end]
         if (same == true)
            if (A[i,j] == sr)
               return (i,j)
            end
         else
            if (A[i,j] != sr)
               return (i,j)
            end
         end
      end
      return 0
   end
   #Функция для представления в qml
   function transH(str, rows, cols)
      A = str2num(str, rows, cols)
      S = Array{Float64,2}(undef,size(A)[end],size(A)[1])
      for i=1:size(A)[1]
         for j=1:size(A)[end]
            S[j,i] = A[i,j]
         end
      end
      return S
   end
   #Строка в массив
   function str2num(A, rows, cols)
      c = 1
      S = Array{Float64,2}(undef,rows,cols)
      for i=1:rows
         for j=1:cols
            f = findnext(isequal(' '), A, c)
            if f == nothing
               help = A[c:length(A)]
               S[i,j] = tryparse(Float64,help)
            else
               help = A[c:f]
               S[i,j] = tryparse(Float64,help)
               c = f + 1
            end
         end
      end
      return S
   end

   ## Транспонирование
   function transfake(A,rows,cols)
      B = str2num(A,rows,cols)
      return B
   end
   ## Определитель
   # Функция получения матрицы без i-ой строки и j-ого столбца
   function dethelp(A::Array{Float64,2},str::Int64,stlb::Int64)
      S = Array{Float64,2}(undef,size(A)[1]-1,size(A)[end]-1)
      di=0
      for i = 1:size(A)[1]-1
         if (i == str)
            di = 1
         end
         dj = 0
         for j = 1:size(A)[1] - 1
            if (j == stlb)
               dj = 1
            end
             S[i,j] = A[i + di ,j + dj];
         end
      end
      return S
   end

   # Рекурсивная функция определителя
   function det(S,rows,cols)
      A = str2num(S,rows,cols)
      if (size(A)[end] != size(A)[1])
         d = "Матрица должна быть квадратной"
         return d
      end
      d = 0
      k = 1
      if (size(A)[end] == 1)
         d=A[1,1]
         return d
      end
      if (size(A)[end] == 2)
         d = A[1,1] * A[2,2] - A[2,1] * A[1,2]
         return d
      end
      if (size(A)[end] > 2)
         for i = 1:size(A)[1]
            S = dethelp(A,i,1)
            str = ""
            for i=1:length(S)
               str = str * string(S[i]) * " "
            end
            d = d + k * A[i,1] * det(str,size(S)[1],size(S)[end])
            k = -k
         end
      end

      return d
   end
   ## След
   function tr(A,rows,cols)
      B = str2num(A,rows,cols)
      if size(B)[end] != size(B)[1]
         g = "Матрица должна быть квадратной"
         return g
      end
      g = 0
      for i = 1:size(B)[1]
         g += B[i,i]
      end
      return g
   end
   ##Ранг
   function rang(str,rows,cols)
      A = str2num(str,rows,cols)
      iter = min(size(A)[end],size(A)[1])
      for i = 1:iter
         if (A[i,i] == 0)
            check = search(0,A,i,i,false)
            if (!(typeof((1,1))==typeof(check)))
               break
            end
            if (i != check[1])
               swaprows(A,i,check[1])
            end
            if (i != check[2])
               swapcols(A,i,check[2])
            end
         end
         tmp=A[i,i]
         for x = i:size(A)[end]
            A[i,x] = div(A[i,x],tmp)
         end
         for y = (i+1):size(A)[1]
            tmp = A[y,i]
            for x = i:size(A)[end]
               A[y,x] -= (A[i,x] * tmp)
            end
         end
         for x = (i+1):size(A)[end]
            tmp = A[i,x]
            for y = i:size(A)[1]
               A[y,x] -= (A[y,i] * tmp)
            end
         end
      end
      cnt = 0
      for i = 1:iter
         if (A[i,i] == 0)
            break
         else
            cnt += 1
         end
      end
      if (cnt == 0)
         cnt += 1
      end
      return cnt
   end
   ##Обратная матрица
   function obr(str,rows,cols)
      A = str2num(str,rows,cols)
      if rows != cols
         wrn = "Матрица должна быть квадратной"
         return wrn
      end
      if det(str,rows,cols) == 0
         wrn = "Определитель равен нулю"
         return wrn
      end
      B = convert(Array{Float64,2}, A)
      S = zeros(size(B)[1],size(B)[1])
      for i = 1:size(B)[1]
         S[i,i] = 1
      end
      for k = 1:size(B)[1]
         tmp = B[k,k]
         for j = 1:size(B)[1]
            B[k,j] = B[k,j]/tmp
            S[k,j] = S[k,j]/tmp
         end
         for i = k + 1:size(B)[1]
            tmp = B[i,k]
            for j = 1:size(B)[1]
               B[i,j] -= B[k,j] * tmp;
               S[i,j] -= S[k,j] * tmp;
            end
         end
      end
      k = size(B)[1]
      while (k > 1)
         i = k - 1
         while (i >= 1)
            tmp = B[i,k]
            for j=1:size(B)[1]
               B[i,j] -= B[k,j] * tmp;
               S[i,j] -= S[k,j] * tmp;
            end
            i -= 1
         end
         k -= 1
      end
      return S
   end
   ## Умножение
   function mul(strA,rowsA,colsA,strB,rowsB,colsB)
      A = str2num(strA,rowsA,colsA)
      B = str2num(strB,rowsB,colsB)
      if size(A)[end] != size(B)[1]
         wrn = "Количество столбцов первой матрицы должно быть равно количеству строк второй"
         return wrn
      end
      S = zeros(size(A)[1],size(B)[end])
      for i = 1:size(A)[1], j = 1:size(B)[end]
         S[i,j] = 0
         for k = 1:size(A)[end]
            S[i,j] += A[i,k] * B[k,j]
         end
      end
      return S
   end
   ##Сложение матриц
   function plus(strA,rowsA,colsA,strB,rowsB,colsB)
      A = str2num(strA,rowsA,colsA)
      B = str2num(strB,rowsB,colsB)
      if (rowsA != rowsB) || (colsA != colsB)
         wrn = "Размеры матриц должны совпадать"
         return wrn
      end
      S = Array{Float64,2}(undef,size(A)[1],size(A)[end])
      for i = 1:size(A)[1], j = 1:size(A)[end]
         S[i,j] = A[i,j] + B[i,j]
      end
      return S
   end

   ##Разность матриц
   function minus(strA,rowsA,colsA,strB,rowsB,colsB)
      A = str2num(strA,rowsA,colsA)
      B = str2num(strB,rowsB,colsB)
      if (rowsA != rowsB) || (colsA != colsB)
         wrn = "Размеры матриц должны совпадать"
         return wrn
      end
      S = Array{Float64,2}(undef,size(A)[1],size(A)[end])
      for i = 1:size(A)[1], j = 1:size(A)[end]
         S[i,j] = A[i,j] - B[i,j]
      end
      return S
   end
   ##Перевод десятичной дроби в обычную
   function float_to_frac(x,error=0.00000001)
      n = convert(Int64,round(x,RoundDown))
      x -= n
      if x < error
         return n
      elseif 1 - error < x
         return n+1
      end
      lower_n = 0
      lower_d = 1
      upper_n = 1
      upper_d = 1
      while (true)
         middle_n = lower_n + upper_n
         middle_d = lower_d + upper_d
         if middle_d * (x + error) < middle_n
            upper_n = middle_n
            upper_d = middle_d
         elseif middle_n < (x - error) * middle_d
            lower_n = middle_n
            lower_d = middle_d
         else
            s = ""
            help = n * middle_d + middle_n
            s = string(help) * "/" * string(middle_d)
            return s
         end
      end
   end
end
