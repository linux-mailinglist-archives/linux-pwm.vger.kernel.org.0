Return-Path: <linux-pwm+bounces-149-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82807F4E21
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 18:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9561C20AA8
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 17:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159035B5B1;
	Wed, 22 Nov 2023 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TG61KYYx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8971A5
	for <linux-pwm@vger.kernel.org>; Wed, 22 Nov 2023 09:18:16 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-409299277bbso32322755e9.2
        for <linux-pwm@vger.kernel.org>; Wed, 22 Nov 2023 09:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700673495; x=1701278295; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=EhO7+CVm1m1oUE9z/3Z07Nkno2ujdBPUPga6VKMIC2w=;
        b=TG61KYYxYiZwFVhLw4zA98zhDdQXArTG98dhGxFPk4HoPJBs6obRLQe7VuxqadMPPO
         eBuoZQJzoWtRBb+QrdgiUTgWx/uwlBOii4L2doWVCnyq0LaU0kZOn4OxP5YoEUReswZ/
         MecotTcCxjzQdiFBk34/F4Q8R40jCF4ERuP8nC1nTOQRJKiyu+ivIANYVZPSL++sE/01
         jNC8OuObEBaUzqV/Ni3frX/aR4r9BSBEDNe70liP5OgeqWYbusi3HdKo6DOUvVdauS/0
         r9v7mzM0StyIFqLR0XQRVws90c2sEH1dD7F4mPpTlTpdm2sRuGtQ1x/yXkUrpEOyPCYv
         0C/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673495; x=1701278295;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhO7+CVm1m1oUE9z/3Z07Nkno2ujdBPUPga6VKMIC2w=;
        b=FyGpShUgQ2adMlk9fdfps8+wNM6mjRHqmIp1croG/5flIz2xfImvAYBIUHM+9x8aAy
         oFQ1JDLhWIVajS/+LGSj1/QU/S0k4Fc038gkFRIydfaIS9EeyPWsKpmUb3wyVSvDp+7W
         BsHBoP7FarUANoA509COvTkBoHNDSZFicciRtBoKeTVZ3DwKJGG32IgL+1iZdfoWjWby
         kHm28BLovPJsC7DbtAcrwtmiVYfPcD4c9S0gl7Q2mYpXCBUDT6s0eDu2UZjs5PlX2SJA
         QgKoMR3olWGNJtyvwAIFnGe6GbnKWIV60j8nYz4/UsT+J9A0V9oniPr6TwJX2XzdtRgM
         ITvQ==
X-Gm-Message-State: AOJu0YzI8JVu759v3w6sNkWb6mFySMZ99J3HdjLIPQOThIUmvP91S5lW
	4R2ciYS9j3v4gkIf+QpyzwBYLg==
X-Google-Smtp-Source: AGHT+IFGdEFm+aNRJMiaufK8tp1EybalqBvtuMK496Fp/eAzQQiZ+CFnVm6AN+L996HflL2LKvAZfw==
X-Received: by 2002:a05:600c:5102:b0:405:3455:e1a3 with SMTP id o2-20020a05600c510200b004053455e1a3mr2350009wms.17.1700673495188;
        Wed, 22 Nov 2023 09:18:15 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:d0a1:9a3c:4f4b:fa20])
        by smtp.gmail.com with ESMTPSA id n5-20020a7bc5c5000000b0040775501256sm8791wmk.16.2023.11.22.09.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:18:13 -0800 (PST)
References: <20231117125919.1696980-1-jbrunet@baylibre.com>
 <20231117125919.1696980-3-jbrunet@baylibre.com>
 <170040994064.269288.960284011884896046.robh@kernel.org>
 <4608012c-059f-4d6a-914b-e85ad0c32ff0@linaro.org>
 <1j5y1wg3sb.fsf@starbuckisacylon.baylibre.com>
 <2e7a65da-5c1d-4dd4-ac69-7559a53afdf3@linaro.org>
 <1j1qckg21u.fsf@starbuckisacylon.baylibre.com>
 <94e69281-93e1-41cd-9cf5-81cbbc15572c@linaro.org>
 <1jwmu9et6j.fsf@starbuckisacylon.baylibre.com>
 <2bbc2031-89d7-42e9-828e-068fa06eabf4@linaro.org>
 <1jo7flerag.fsf@starbuckisacylon.baylibre.com>
 <2d9c4c93-6cea-4a44-9093-c1fd51d0a21c@linaro.org>
User-agent: mu4e 1.10.7; emacs 29.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, neil.armstrong@linaro.org, Rob
 Herring <robh@kernel.org>, JunYi Zhao <junyi.zhao@amlogic.com>,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Thierry Reding
 <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: pwm: amlogic: add new compatible
 for meson8 pwm type
Date: Wed, 22 Nov 2023 17:14:56 +0100
In-reply-to: <2d9c4c93-6cea-4a44-9093-c1fd51d0a21c@linaro.org>
Message-ID: <1jjzq9emga.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Wed 22 Nov 2023 at 16:46, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:


>>>>>
>>>>> Again, where the "v2" is defined? Where is any document explaining the
>>>>> mapping between version blocks and SoC parts? Why do you list here only
>>>>> major version? Blocks almost always have also minor (e.g. v2.0).
>>>>
>>>> Again, v2 does has nothing to do with the HW. Never wrote it was.
>>>> The HW remains the same.
>>>
>>> Don't add compatibles which are not related to HW, but represent
>>> software versioning. Software does not matter for the bindings.
>> 
>> What I did I explicitly what is recommended in Grant's presentation from
>> 2013. 10y old, but I assume slide 10 "Making an incompatible update" is
>> still valid.
>> 
>> https://elinux.org/images/1/1e/DT_Binding_Process_glikely_ksummit_2013_10_28.pdf
>> 
>> Breaking the ABI of the old compatible would break all boards which use
>> u-boot DT and pass it to the kernel, because the meaning of the clock
>> property would change.
>
> You broke U-Boot now as well - it will get your new DTS from the kernel
> and stop working.

U-boot will continue to match the old compatible and work properly.
When the dts using the new compatible lands in u-boot, it won't
match until proper driver support is added. It is a lot better than
breaking the ABI, which would have silently broke u-boot.

I don't really see a way around that.

If you have better way to fix a bad interface, feel free to share it.

>
>> 
>> Doing things has suggested in this slide, and this patch, allows every
>> device to continue to work properly, whether the DT given is the one
>> shipped with u-boot (using the old compatible for now) or the kernel.
>
> OK, that explains the reasons. I read your commit msg and nothing like
> this was mentioned there. What's more, you did not deprecate the old
> binding, thus the confusion - it looked like you add entirely new
> hardware (although you put "deprecated" but in some unrelated place, not
> next to the compatibles).

The old interface being obsoleted by the new one is mentionned in the
commit description, the comments in the bindings and the bindings itself.
Thanks a lot for pointing out the placement mistake. I'll fix it.

The commit description says:
* What the patch does
* Why it does it:
  * Why the old bindings is bad/broken
  * How the new ones fixes the problem
* Why a single compatible properly describes, IMO, all the related HW.

This describes the entirety of what the change does.
That seemed clear enough for Rob. If that is not enough for you and you
would like it reworded, could please provide a few suggestions ?

>
> Anyway, the main point of Neil was that you started using generic
> compatible for all SoCs, which is wrong as well. I guess this was the
> original discussion.

The whole reason for this change is to properly describe the HW, which
is the 100% same on all the SoCs, or SoC families, concerned. The only
reason there was a lot of old compatibles is because it was used to match
data in the driver (this is clearly wrong). This data would now be
passed through DT.

I have been clear about this in the change description.

So why is it wrong to have single compatible for a type of device that
is 100% the same HW ?

It is lot a easier to apply a rule correctly when the intent is clear.

>
> Best regards,
> Krzysztof


