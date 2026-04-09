/*******************************************************************************
* Copyright (c) 2022-2023 Intel Corporation
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*******************************************************************************/

/// @file
/// C++ API

#pragma once

#include "common/common.hpp"

namespace gpu::xetla {

/// @brief xetla 4bits data packed as 8bits data type.
/// 2 4bit data pack to one byte
struct int4x2 {
    uint8_t data;

    operator uint8_t() const { return data; }
    int4x2(uint8_t val) { data = val; }
};

/// @brief Used to check if the type is xetla internal data type
template <>
struct is_internal_type<int4x2> {
    static constexpr bool value = true;
};

/// @brief Set uint8_t as the native data type of int4x2.
template <>
struct native_type<int4x2> {
    using type = uint8_t;
};

/// @brief xetla 2bits data packed as 8bits data type.
/// 4 2bit data pack to one byte
struct int2x4 {
    uint8_t data;

    operator uint8_t() const { return data; }
    int2x4(uint8_t val) { data = val; }
};

template <>
struct get_packed_num<int2x4> {
    static constexpr uint32_t value = 4;
};

/// @brief xetla 2bits data packed as 32bits data type.
/// 16 2bit data pack to 4 bytes
struct int2x16 {
    uint32_t data;

    operator uint32_t() const { return data; }
    int2x16(uint32_t val) { data = val; }
};

template <>
struct get_packed_num<int2x16> {
    static constexpr uint32_t value = 16;
};

/// @brief Used to check if the type is xetla internal data type
template <>
struct is_internal_type<int2x4> {
    static constexpr bool value = true;
};

/// @brief Set uint8_t as the native data type of int2x4.
template <>
struct native_type<int2x4> {
    using type = uint8_t;
};

/// @brief Set uint32_t as the native data type of int2x16.
template <>
struct native_type<int2x16> {
    using type = uint32_t;
};

} // namespace gpu::xetla
