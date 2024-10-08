Return-Path: <linux-pwm+bounces-3531-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B433C9940B8
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 10:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C9F1F218B6
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 08:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF78208238;
	Tue,  8 Oct 2024 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HWi4WuED"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43BF208236
	for <linux-pwm@vger.kernel.org>; Tue,  8 Oct 2024 07:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372674; cv=none; b=sJ/74DPiNGNVVclAhIYfUZ7Z9m7sGPp6pdNjJiDz0p7Yij8zL6z2iL3zBZHo9UEvAMa/oLYyBqwwSZBEEwhSfJhP1vQbggGQ4VnBL5ANelQbHs3LezXl1cC9uPVkvnRqbMW0iwZIF/NXY8exlC5BjRD3+DjJWvr2hyW9wgjUN1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372674; c=relaxed/simple;
	bh=3/kv+Uje3xe3w+hRUUmjWdgYuZhvxSacOd8Q3N4S7ts=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZT4ESVGDx5SaL8Yh2HZSCCsLQ3k6jzsl/fsExTGA/UhKK5fIfb9+KtkpdWkPBzCA8Yg1yNUyPafUfp4S3QF+vpGiUIANKgw0wGqq+zcHV8vXXwooVqlpPE6yQ+S6epJ3L11xBPIWRgOlZzzKLZJhRUV6VjCOiRgTnXOCjT1qs1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HWi4WuED; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37cc810ce73so2777160f8f.1
        for <linux-pwm@vger.kernel.org>; Tue, 08 Oct 2024 00:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728372671; x=1728977471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fy2shiK3fmb6j9W5GjzkVqsj9Kn/pQMnvw0hDyVzAGg=;
        b=HWi4WuEDLM3/y2o5+DDSmfzsmvO5oP2Bi7+BCF4GCNoO4dENk7trw8IU9XjOEY5PmM
         7A9vR7HSCUpAeL7xC1BTtRnU6t/Y3iVKIJuucFsUxcITTdecuJxYbkF5o54DebFelUDe
         Y0N0sY1288q3Sw+i7v39V+hlkLJbGdFM/+qlDuJs491GfOlRvEBGcghV0Qv7NZWh98zU
         mbCLWTEZm09mSbu1Z/pynMK9001svY1PC3UsK/T/JfU/CMjJvkP46eu6RYhnUL0iHgi3
         GjclICF4CuGfi7dCuKRk9tTNHKOtifkySgQriHPnMdMAvvmYEGK0eYxdCz1fV4QrHRy7
         S0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728372671; x=1728977471;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fy2shiK3fmb6j9W5GjzkVqsj9Kn/pQMnvw0hDyVzAGg=;
        b=lb6knGFnQ5Kuo2DaJOdiAUlaRrGAw1+q0JAKpzGwCsDqjFn5b1ng94eXtDz/cw1K7l
         TYkraoFsXfuxp1duEWQf5IreqBHJOcAEBUYFM7OwBvbd37TL+QeNh8emNjBoA5bYS0C3
         46P0vNEAGigbp3w6zzS8m0YViC2HCDykgXKUzDxEZnObi4L8ymy703y3YiyoBT9kCbYm
         dv1UgiP2SAaX8jHU+E9cqwAAxIoiQW2f1uE5QmFCKrtQycvszCW3cPnFjx5C0RGhzy2+
         FGUJ6MqHwG5W/UEQwZAfkz5/6Lfz0P+4CsTSZ3nWz2I+qSwyBI39Olg4Gl95MmJ5yiX0
         dhAA==
X-Gm-Message-State: AOJu0YzK0fegFkO1pkM9rOlV4hh+r33aZc6GZWJkcmStws1p5YwILd2D
	+M3RzciPzE+pOI85Q7X/dES9RWeGfiJa9vu0ex1HqIgmTpoBpGS4ulCY6mr/fFAVu/xVO/zdLPC
	+7JI=
X-Google-Smtp-Source: AGHT+IHIPRLHczs/vsnv1oAAp5+Q/um5G5Z/VdRLJkNxGk807Uk3XMrbK8IQ+3b5doUrR7C6rxdWqQ==
X-Received: by 2002:a05:6000:1b8b:b0:37c:ce45:96f2 with SMTP id ffacd0b85a97d-37d0e8f7390mr7513067f8f.50.1728372671045;
        Tue, 08 Oct 2024 00:31:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4595:23ef:4ba2:2d19? ([2a01:e0a:982:cbb0:4595:23ef:4ba2:2d19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a20393sm116449555e9.12.2024.10.08.00.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 00:31:09 -0700 (PDT)
Message-ID: <5c3a6fdb-e4f0-4a22-9a8d-84baee12769c@linaro.org>
Date: Tue, 8 Oct 2024 09:31:09 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/3] pwm: meson: Enable constant and polarity features for
 g12, axg, s4
To: George Stark <gnstark@salutedevices.com>, u.kleine-koenig@pengutronix.de,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com
Cc: linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@salutedevices.com
References: <20241007193203.1753326-1-gnstark@salutedevices.com>
 <20241007193203.1753326-4-gnstark@salutedevices.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20241007193203.1753326-4-gnstark@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/10/2024 21:32, George Stark wrote:
> g12, axg and s4 SoC families support constant and polarity bits so enable
> those features in corresponding chip data structs.
> 
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> ---
>   drivers/pwm/pwm-meson.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 6701738c55e3..c6f032bdfe78 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -571,26 +571,36 @@ static const struct meson_pwm_data pwm_gxbb_ao_data = {
>   static const struct meson_pwm_data pwm_axg_ee_data = {
>   	.parent_names = { "xtal", "fclk_div5", "fclk_div4", "fclk_div3" },
>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
> +	.has_constant = true,
> +	.has_polarity = true,
>   };
>   
>   static const struct meson_pwm_data pwm_axg_ao_data = {
>   	.parent_names = { "xtal", "axg_ao_clk81", "fclk_div4", "fclk_div5" },
>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
> +	.has_constant = true,
> +	.has_polarity = true,
>   };
>   
>   static const struct meson_pwm_data pwm_g12a_ee_data = {
>   	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
> +	.has_constant = true,
> +	.has_polarity = true,
>   };
>   
>   static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
>   	.parent_names = { "xtal", "g12a_ao_clk81", "fclk_div4", "fclk_div5" },
>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
> +	.has_constant = true,
> +	.has_polarity = true,
>   };
>   
>   static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
>   	.parent_names = { "xtal", "g12a_ao_clk81", NULL, NULL },
>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
> +	.has_constant = true,
> +	.has_polarity = true,
>   };
>   
>   static const struct meson_pwm_data pwm_meson8_v2_data = {
> @@ -599,6 +609,8 @@ static const struct meson_pwm_data pwm_meson8_v2_data = {
>   
>   static const struct meson_pwm_data pwm_s4_data = {
>   	.channels_init = meson_pwm_init_channels_s4,
> +	.has_constant = true,
> +	.has_polarity = true,
>   };
>   
>   static const struct of_device_id meson_pwm_matches[] = {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

