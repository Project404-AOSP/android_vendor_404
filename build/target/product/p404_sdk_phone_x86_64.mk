# Copyright (C) 2022-2024 The Project 404
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

$(call inherit-product, $(SRC_TARGET_DIR)/product/sdk_phone_x86_64.mk)
$(call inherit-product, vendor/p404/build/target/product/p404_generic_target.mk)

## SDK addon
PRODUCT_SDK_ADDON_NAME := p404
PRODUCT_SDK_ADDON_SYS_IMG_SOURCE_PROP := $(LOCAL_PATH)/source.properties

## Device identifier, this must come after all inclusions
PRODUCT_NAME := p404_sdk_phone_x86_64
PRODUCT_DEVICE := p404_sdk_phone_x86_64
PRODUCT_BRAND := p404
PRODUCT_MODEL := P404 SDK built for x86_64
PRODUCT_MANUFACTURER := p404
