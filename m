Return-Path: <linux-pwm+bounces-2624-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B59F91A0D9
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jun 2024 09:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4BD282819
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jun 2024 07:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFE074040;
	Thu, 27 Jun 2024 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USSkShYw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB0C6E61B
	for <linux-pwm@vger.kernel.org>; Thu, 27 Jun 2024 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719474738; cv=none; b=pMOXGGqO56lxRV8bh+S/db5MY0gtxXcvFqI7KFTlvUVsayMBeaKUYwa1HiSxzcDi2t+HwlGZP/IbuA8qEOlGxI8zc8mmvGIfysB6gvcqKf66htIQg8pFvceZbs/mDkm2UlFA89kD3IkmbmcBXzqgA3fWz8blBiWq6DYpDXAzAtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719474738; c=relaxed/simple;
	bh=CPYR1hPVE1flFMf8KEd5p3bzirmrED+VzmsLSEVpaMg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZNY4K2e2CgYa0nWjGglsCpyljsOLZ402S4w2T8aJo8HGV9OV4pEI8lmvF/k75Xlqf7yEby3mIEFbvo5toUlnLuB771sALVrUjd6makl6Sb/PGUCGZ0PoMo/7AaVtX/CVJQMxb0y3JkRRufgmSKcwnEZqcyN6Khx61Y2khmIiarM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=USSkShYw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-424ad991c1cso19066045e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 27 Jun 2024 00:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719474735; x=1720079535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBCMffxn4LAJXAIWptmBWF5BGGjLSTVC76JfyXsytmc=;
        b=USSkShYwiuTuFhaE2eHRdkyItogmBk6sPyMx6ejYzbQKh8pFsfJAVFbHZe4i5XwRgB
         +9JaSySgCkvkWVZzhJiDF93VeKK/dYzJ7dI2oh+/9G/mc4+f2BjnWOj28d3bnIfURx+v
         nENDdldtKbM73d6pKrJ0SGn64dwqR8hHNwc/KtnleHzZzOYCzo5ynE9XWB97BdDe0qWp
         rTkOlknopHqppa6yZjwE6SdlknHY7jWWnWcuS0NwdCXOjRG4yCRtZ9OGVEj16bIEn1Jw
         s1Wx9yCWC15imDgTHM/iLwDsHETJ7QZ/CKZDktTkEN6GXysdZy8WhWp60lPjAJHzVLY/
         6qUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719474735; x=1720079535;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XBCMffxn4LAJXAIWptmBWF5BGGjLSTVC76JfyXsytmc=;
        b=j8KJAq0wCYNizslUTvHzqj7if0I/1z868ronfGoRtlaHu/LpEzczBB5PwbXM+5EgY3
         u1XaJv8wTbDEXadyB9m9HNYvFPOQqkDW/g84TQzWwhVmXbdLZyWjprH3KIk4no2xr5mj
         kIMN/vv4qe2GPQ//f3gQDItjgwGjaeZDoTKlD4OWaIPSAnn80bpyZViQxOZ0hGKRbKnY
         Nq2HK6LXpqeOee8+tfc8EZfK3TqoT9TV8dw8cZSSNMmwVfR1tMFS7T3Z5khaByHv9hXm
         jOQne+A0melA0L37puvv2rxpoOLgh9fdcYrd0bEo8i/oBba3nJTyu55ym5bjb6cTa9e1
         E8Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXmu4uFrqYJ0TFP+F9cDi4o2CRywdSSoWhTZ2pTTOwYw8M47FIC6Ds9mnUy/n5jpR2xEI65UVAYSk10gVYtx6jR5Hz4BO0ZSXKc
X-Gm-Message-State: AOJu0Yw7iXQLnm8oFcTENOjkezN1zA7/paYKtSmAqaaVqy8yNRxPhZuG
	hrUqiuFC+NwlV5jrDJX9aSilUjTSCeB7AHbCapGGpbu3uUSmB4ZCKNn9BUtOyh8=
X-Google-Smtp-Source: AGHT+IEjUL+j70G/hi3yuY2Bt9Gi9CL/4CNNycH9kWTRZ1nc6f9jw44NE1DzWx8PIaKqbU2R2xAN0Q==
X-Received: by 2002:a05:600c:681:b0:424:a578:fcc with SMTP id 5b1f17b1804b1-424a5781102mr48497425e9.7.1719474734436;
        Thu, 27 Jun 2024 00:52:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:feeb:faed:66fa:9e6a? ([2a01:e0a:982:cbb0:feeb:faed:66fa:9e6a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8266a37sm52129085e9.19.2024.06.27.00.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 00:52:13 -0700 (PDT)
Message-ID: <02a58f83-2340-4004-9412-692967639908@linaro.org>
Date: Thu, 27 Jun 2024 09:52:12 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v8 2/2] arm64: dts: amlogic: Add Amlogic S4 PWM
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>
Cc: kelvin.zhang@amlogic.com,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Junyi Zhao <junyi.zhao@amlogic.com>, George Stark <gnstark@salutedevices.com>
References: <20240613-s4-pwm-v8-0-b5bd0a768282@amlogic.com>
 <20240613-s4-pwm-v8-2-b5bd0a768282@amlogic.com>
 <a5ucz5r4eb2z5uzi4zaunpqhym5b6l37qszozhv4igcuduatnp@lzzk4tvil3yd>
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
In-Reply-To: <a5ucz5r4eb2z5uzi4zaunpqhym5b6l37qszozhv4igcuduatnp@lzzk4tvil3yd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Uwe,

On 27/06/2024 07:50, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Jun 13, 2024 at 07:46:36PM +0800, Kelvin Zhang via B4 Relay wrote:
>> From: Junyi Zhao <junyi.zhao@amlogic.com>
>>
>> Add device nodes for PWM_AB, PWM_CD, PWM_EF, PWM_GH and PWM_IJ
>> along with GPIO PIN configs of each channel.
>>
>> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
>> Reviewed-by: George Stark <gnstark@salutedevices.com>
>> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
>> ---
>>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 199 ++++++++++++++++++++++++++++++
>>   1 file changed, 199 insertions(+)
> 
> What is the merge plan for this patch? Technically it's independent from
> driver support (i.e. patch #1 in this series). The obvious options are:
> 
>   - I pick it up together with patch #1 via pwm
>   - You pick it up via arm-soc
> 
> Can I please get an Ack iff you prefer the first option?

I can take but I was waiting for the driver part to be merged.

Anyway, I'll take, something less on the list!

Neil
> 
> Best regards
> Uwe


