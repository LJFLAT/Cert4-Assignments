SELECT [sTBL].[name] [Table], 
       [sCOL].[name] AS [ColumnName], 
       CASE
          WHEN [sTYP].[name] IN ('char','varchar','nchar','nvarchar','binary','varbinary')
             THEN [sTYP].[name] + '(' + CAST([sCOL].[max_length] AS VARCHAR(10)) + ')'
          WHEN [sTYP].[name] IN ('float','decimal','numeric','real')
             THEN [sTYP].[name] + '(' + CAST([sCOL].[precision] AS VARCHAR(10)) + ',' + CAST([sCOL].[scale] AS VARCHAR(10)) + ')'
          ELSE [sTYP].[name]
       END AS [DataType],
       CASE
          WHEN [IdxDtls].[column_id] IS NOT NULL THEN 'Yes'
          ELSE 'No'
       END AS [IsPK],
       CASE
          WHEN [sFKC].[parent_column_id] IS NOT NULL THEN 'Yes'
          ELSE 'No'
       END AS [IsFK],
       [sEXP].[value] AS [ColumnDescription]
FROM [sys].[Tables] AS [sTBL] INNER JOIN [sys].[columns] AS [sCOL] ON [sTBL].[object_id] = [sCOL].[object_id]
                              LEFT JOIN [sys].[types] AS [sTYP] ON [sCOL].[user_type_id] = [sTYP].[user_type_id]
                              LEFT JOIN (SELECT [sIDX].[object_id], [sIXC].[column_id]
                                         FROM [sys].[indexes] AS [sIDX]
                                              INNER JOIN [sys].[index_columns] AS [sIXC] 
											     ON [sIDX].[object_id] = [sIXC].[object_id]
                                                AND [sIDX].[index_id] = [sIXC].[index_id]
                                         WHERE [sIDX].[is_primary_key] = 0x1) AS [IdxDtls]
                                     ON [sCOL].[object_id] = [IdxDtls].[object_id]
                                    AND [sCOL].[column_id] = [IdxDtls].[column_id]
                              LEFT JOIN [sys].[foreign_key_columns] AS [sFKC] ON [sCOL].[object_id] = [sFKC].[parent_object_id]
                                    AND [sCOL].[column_id] = [sFKC].[parent_column_id]
                              LEFT JOIN [sys].[extended_properties] AS [sEXP] ON [sTBL].[object_id] = [sEXP].[major_id]
                                    AND [sCOL].[column_id] = [sEXP].[minor_id]
                                    AND [sEXP].[class] = 1
                                    AND [sEXP].[minor_id] > 0
                                    AND [sEXP].[name] = N'MS_Description'
WHERE [sTBL].[type] = 'U'
ORDER BY [Table]