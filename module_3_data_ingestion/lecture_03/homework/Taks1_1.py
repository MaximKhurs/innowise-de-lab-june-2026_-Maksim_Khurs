#1
raw_sku = "CARROT-001"
raw_regions = ("Minsk", "Warsaw", "Berlin", "Warsaw")
raw_weight_str = "2.5"
raw_stock_str = "150"


#2
weight_kg = float(raw_weight_str)
stock_quantity = int(raw_stock_str)


#3
sku_as_list = list(raw_sku)
regions_list = list(raw_regions)
unique_regions = set(raw_regions)
regions_tuple = tuple(unique_regions)


#4
empty_list_1 = []
empty_list_1 = list()

empty_dict_1 = {}
empty_dict_2 = dict()

empty_tuple_1 = ()
empty_tuple_2 = tuple()

empty_set = set()


#5
print(bool(empty_list_1))
print(bool(empty_dict_1))
print(bool(empty_tuple_1))
print(bool(empty_set))

non_empty_list = [1, 2, 3]
non_empty_dict = {1:2}
non_empty_tuple = (1, 2, 3)
non_empty_set = {1,2,3}

print(bool(non_empty_dict))
print(bool(non_empty_list))
print(bool(non_empty_tuple))
print(bool(non_empty_set))


#6
print(weight_kg, type(weight_kg))
print(stock_quantity, type(stock_quantity))
print(sku_as_list, type(sku_as_list))
print(regions_list, type(regions_list))
print(unique_regions, type(unique_regions))
print(regions_tuple, type(regions_tuple))
