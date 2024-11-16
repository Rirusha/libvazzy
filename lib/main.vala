/*
 * Copyright (C) 2024 Vladimir Vaskov
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

namespace Vazzy {

    // Thanks to https://stackoverflow.com/a/33883233
    public static int compute_damerau_levenshtein_distance (
        string source,
        string target,
        int insert_cost = 1,
        int delete_cost = 1,
        int replace_cost = 1,
        int swap_cost = 1
    ) {
        int delete_distance = 0;
        int insert_distance = 0;
        int match_distance = 0;
        int j_swap = 0;
        int max_source_letter_match_index = 0;
        int? candidate_swap_index = 0;
        int swap_distance = 0;

        if (source.length == 0)
        {
            return target.length * insert_cost;
        }
        if (target.length == 0)
        {
            return source.length * delete_cost;
        }

        int[,] table = new int[source.length, target.length];
        Gee.HashMap<char, int> source_index_by_character = new Gee.HashMap<char, int> ();

        if (source[0] != target[0])
            table[0, 0] = int.min (replace_cost, delete_cost + insert_cost);

        source_index_by_character.set (source[0], 0);

        for (int i = 1; i < source.length; i++)
        {
            delete_distance = table[i - 1, 0] + delete_cost;
            insert_distance = (i + 1) * delete_cost + insert_cost;
            match_distance = i * delete_cost + (source[i] == target[0] ? 0 : replace_cost);
            table[i, 0] = int.min (int.min (delete_distance, insert_distance), match_distance);
        }

        for (int j = 1; j < target.length; j++)
        {
            delete_distance = (j + 1) * insert_cost + delete_cost;
            insert_distance = table[0, j - 1] + insert_cost;
            match_distance = j * insert_cost + (source[0] == target[j] ? 0 : replace_cost);
            table[0, j] = int.max (int.min (delete_distance, insert_distance), match_distance);
        }

        for (int i = 1; i < source.length; i++)
        {
            max_source_letter_match_index = source[i] == target[0] ? 0 : -1;
            for (int j = 1; j < target.length; j++)
            {
            candidate_swap_index = source_index_by_character.get (target[j]);
            j_swap = max_source_letter_match_index;
            delete_distance = table[i - 1, j] + delete_cost;
            insert_distance = table[i, j - 1] + insert_cost;
            match_distance = table[i - 1, j - 1];

            if (source[i] != target[j])
                match_distance += replace_cost;
            else
                max_source_letter_match_index = j;

            if (candidate_swap_index != null && j_swap != -1)
            {
                int i_swap = candidate_swap_index;
                int pre_swap_cost;
                if (i_swap == 0 && j_swap == 0)
                pre_swap_cost = 0;
                else
                pre_swap_cost = table[int.max (0, i_swap - 1), int.max (0, j_swap - 1)];
                swap_distance = pre_swap_cost + (i - i_swap - 1) * delete_cost + (j - j_swap - 1) * insert_cost + swap_cost;
            }
            else
                swap_distance = int.MAX;
            table[i, j] = int.min (int.min (int.min (delete_distance, insert_distance), match_distance), swap_distance);
            }
            source_index_by_character.set (source[i], i);
        }
        return table[source.length - 1, target.length - 1];
    }
}
