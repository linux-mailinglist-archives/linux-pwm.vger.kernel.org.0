Return-Path: <linux-pwm+bounces-2040-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DEB8AAB66
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Apr 2024 11:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579E81F2239C
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Apr 2024 09:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C2971B3D;
	Fri, 19 Apr 2024 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Dn6Yg5We"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9328BE2
	for <linux-pwm@vger.kernel.org>; Fri, 19 Apr 2024 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713518578; cv=none; b=n/wt3T8vhHzm2Kr9J7bGqg+78+5mI/uHHbtXgFHEkG36/iDiZTbuwy3aKHbhOMXuMIPyiWs7fLWYfM6KG0hjTs8tWSiJhvQyP6lujg6DZpm1Dg6Yj8OefA1vOIyTKOIcaFqaW5j7bDTF7tChZKGmr6SWQpe1jtSKiYhnhVmtOJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713518578; c=relaxed/simple;
	bh=NcKAO7tP/x4sIAxUUHYXR+L4ly5ODcgul0HtEzI6yDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R86dYJgWqHHPtAkg7na6lNL1zJcHOsncyhl6aD7szR3XkjX17rwFwzxyUmXWtQSlAB2gcuCSD9gEFZq2LWnXckP6Aljf7KeYxlXjfbTOFDeGfh8tv4Z9T8ALHWCFZ4m4BqcrMTZtd4xrPT9yVEc7M+PAe41DZCSCad99Yb+IC7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Dn6Yg5We; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-418c2bf2f55so13117375e9.2
        for <linux-pwm@vger.kernel.org>; Fri, 19 Apr 2024 02:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713518574; x=1714123374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y576gXoPcjc3Y2FVL6fqBu3Gc7Q1+NXvtH+iYdNf3yU=;
        b=Dn6Yg5WeRyohMHQrnYNQylmvY2rP9Q/jJSLAWy2V/CYgQnS7egZ6pUimHcVTyV1nnU
         VEOrjF3JgoX3FCzvpjGF+kIb6lEpo4S5N0SULLkxDw3XgwcIaYQQl3uEK9pL1f/QKjWG
         6Rj5ZO23Cfsq4cyoCuafdyGJ2cCT/tJzgMko2+vu1UB/vV7OSs/uhKDBFhJ9BX2Woy0K
         82UYHxSRvaulHZDlnD+kcVaHdf2nesT2EDM0iGcwvsS3qUYXqtelKJmw9nKYi3s1ckOo
         +HS55Y6RE+eCJsy4NTFAMrn7mW3yXK5YKuscWt4jo74mcoUcR1m7VNoYZtgUAN6tPs57
         Hy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713518574; x=1714123374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y576gXoPcjc3Y2FVL6fqBu3Gc7Q1+NXvtH+iYdNf3yU=;
        b=xMwejHE8F/sAQIQuA6FJZ+x+zs0VEDltjVk0vjoEDQe9g9SAPL0E6FnSOEzKNO00bw
         JZtWwC9+HtO41pYzNsxwhwonj0wrgGavnWj5nbzaf5+2uUSFMO7M9L0Ox+N1TqzGxKcl
         cunXI36LrMIzzkIu0BCwKlqWNepw8T1e2cCZ6xf5Y2JPluCUelPMZPWu9SDHFCRpoehA
         kRCeafM0CSBdAChdZPPR/3dDH+2VXS3gYWWwraSi/VsnZK2vrPdzQLD1nv3GNMIrzEvP
         LUanSHHukmfIKZKpQx6AYwWQkLWFR8xyDC6w9d3ThsNTHMgJwIFfZP9LnVuJGPnBfCQS
         2QoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4h6x4gu7BWu1WYzBOasmWHscMo1vJxuuoL7x1FZZr9iRJsZuFiI8jfzcRj0myjvUnGB2qr/Qpahg6nYzi0v/be9DqhFr4o7tL
X-Gm-Message-State: AOJu0Yzb1mYEf74LylVt01ua3ZTKpI+NDgY58HheDrmQH9BX+RtN3HC4
	8ShWvPn00AIr/5jLQe+agHgcuUpitrSXdNkmnR/LNoAMZPDQZO20GVTeBsRCuK4=
X-Google-Smtp-Source: AGHT+IGEMMwvqsWa1wBPlb1YxcuxGJHgk4ZlrLlGwj3TJU4+1nuQXEqo0CbuUtJgEODgebOizRMxsg==
X-Received: by 2002:a05:600c:1d0f:b0:418:f6b7:a383 with SMTP id l15-20020a05600c1d0f00b00418f6b7a383mr990122wms.2.1713518574007;
        Fri, 19 Apr 2024 02:22:54 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id b10-20020a05600c4e0a00b00418f30874b4sm4015450wmq.17.2024.04.19.02.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 02:22:53 -0700 (PDT)
Message-ID: <57705980-e776-4178-878d-15c2007f7ef3@baylibre.com>
Date: Fri, 19 Apr 2024 11:22:52 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/17] drm/mediatek: add MT8365 SoC support
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Jitao Shi <jitao.shi@mediatek.com>,
 CK Hu <ck.hu@mediatek.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Fabien Parent <fparent@baylibre.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20231023-display-support-v3-0-53388f3ed34b@baylibre.com>
 <20231023-display-support-v3-14-53388f3ed34b@baylibre.com>
 <9ef43fff-ee2a-4b2c-a595-30f5bf7588c2@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <9ef43fff-ee2a-4b2c-a595-30f5bf7588c2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19/04/2024 10:01, AngeloGioacchino Del Regno wrote:
> Il 18/04/24 16:17, amergnat@baylibre.com ha scritto:
>> From: Fabien Parent <fparent@baylibre.com>
>>
>> Add DRM support for MT8365 SoC.
>>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> 
> There are two things that I want to point out. Please check below.
> 
> The series that I've sent for adding OF Graphs [1] support to MediaTek DRM is
> not going to be picked in time for v6.10, but I think neither your MT8365 support
> series is, and that's why I'm telling you this.
> 
> If your work was based off my series, you would not need to add the MT8365 ddp
> MAIN and EXT paths to mtk_drm_drv: you'd just add it to the bindings and then
> you would declare the paths in devicetree.

Ok then I will rebase my v4 on top of your serie

> 
> 
> [1]: https://lore.kernel.org/r/20240409120211.321153-1-angelogioacchino.delregno@collabora.com
> 
> There's also one more comment....
> 
>> ---
>>   drivers/gpu/drm/mediatek/mtk_drm_drv.c | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> index 74832c213092..427b601309c4 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> 
> ..snip..
> 
>> @@ -793,6 +821,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
>>         .data = (void *)MTK_DSI },
>>       { .compatible = "mediatek,mt8188-dsi",
>>         .data = (void *)MTK_DSI },
>> +    { .compatible = "mediatek,mt8365-dpi",
> 
> You removed the mt8365 specific compatible from the DPI driver - why did you keep
> it here?! that's not needed! :-)

Sorry for that, I forgot to remove it in this driver too. Thanks to catched it.

> 
> Cheers,
> Angelo
> 
>> +      .data = (void *)MTK_DPI },
>>       { }
>>   };
>>
> 

-- 
Regards,
Alexandre

