--
-- Created by Philippe La Madeleine
-- User: philippe
-- Date: 24/12/17
-- Time: 3:35 PM
-- To change this template use File | Settings | File Templates.
--

tableTools = {}

function tableTools.add(table1, table2, result)
    if result == nil then
        for i, h in pairs(table1) do
            table1[i] = table1[i]+table2[i]
        end
    else
        result = {}
        for i, h in pairs(table1) do
            result[i] = table1[i]+table2[i]
        end
    end
end
