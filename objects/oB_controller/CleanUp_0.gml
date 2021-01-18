/// @description Destroy ds lists
ds_list_destroy(combatant_list);
ds_list_destroy(active_combatant_list);
ds_list_destroy(party_list);
ds_list_destroy(active_party_list);
ds_list_destroy(enemy_list);
ds_list_destroy(active_enemy_list);
ds_list_destroy(text_queue);
ds_list_destroy(temp_active_combatant_list);
ds_list_destroy(turn_order);
ds_list_destroy(next_turn_order);
ds_list_destroy(next_turn_order_2);

surface_free(surf_bk_1);
surface_free(surf_bk_2);
surface_free(surf_ui_base);
surface_free(surf_ui);