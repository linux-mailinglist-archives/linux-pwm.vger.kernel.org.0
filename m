Return-Path: <linux-pwm+bounces-1530-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8148F856CFF
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 19:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C49F1F2251E
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 18:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929ED13849A;
	Thu, 15 Feb 2024 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yn8PqIiF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C801386B1
	for <linux-pwm@vger.kernel.org>; Thu, 15 Feb 2024 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708022700; cv=none; b=RszIaaCLqOwPcwcVtrMXMXMtzniDwZJKmKfWAEl2ULPKNwSbYQn2aZQ4Aq4ae8X/scnBJrPqnavu2TtbB23mwYYC6aZ8FXKsL1NWOb0JpYjCOYOGBN1lqehXsxyrfRby697k0vZOMK66kV3PtNI08EE4zwuxz9/cmbUDrm9BaYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708022700; c=relaxed/simple;
	bh=PbhhQzsCOzluMRuJrO5H2BPda4J2I15V9bFTUKFH6J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgZ+qD9BiCsY6ktPiYtnCefFMbvBTrnhv4RHXkp5wnqL8CXujWpDwmeb6Z4IkQuebevnVC2q1EF71R1XeMsR8d+WMfwWr1tVlqwAMl2+7f4lKig++J1SjA/7PKjKEI17xKSsL8veCPYotHHlGRj8LembrEzZruTW1hlSkx+Ixc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yn8PqIiF; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-511ac701428so1406615e87.2
        for <linux-pwm@vger.kernel.org>; Thu, 15 Feb 2024 10:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708022697; x=1708627497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BA2WiEiZ8gMhFWkJbMFNImep7UDUbAJ5L5wptDO6vH8=;
        b=Yn8PqIiFLGQLTdu69uklZRkamueVKyB3ZvRxo4smHxbjmPVDOawOVyl78nQBzxOrNb
         S344N05bqD1jRjbnYhDIx6T0G35SOJB9Oc5+0puNQr/cPYQXeQ5ruHmv8nM+tZWsNrVp
         pyvlQKKogaRdcDXZB9LQzWJptLeMVvnhM8LKspT9lC4ayQvmMTfjKPKukD/supxjwyte
         FZaaftGWVlU9k720/WtLdIZpBK2RVU+GF0T9FlhOVYdephnbRVlRB758BxgPphSg12zp
         epaIiQ1YwIdUuW7LJ97ZcQRs90AgQ0kcG7pu65ZvutG0Nprqw+OlrvlmAYo3InpnnXuY
         YSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708022697; x=1708627497;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BA2WiEiZ8gMhFWkJbMFNImep7UDUbAJ5L5wptDO6vH8=;
        b=XLb2lzjar0xCiADmlqgvq7UJSr+aRzciloiroZw8TzLAllgh/FRYg+piqLklJ9OCKf
         pHLPLc0313PSku/plXMG8mqbOeh4yhx9Ozlh37GjwTocz+eZ+lO4Zv33Qd20FwYJyKn2
         CvZW7qG3UJXuP+DvQs1hkPjlhVWlvc7vvJf+4Y8zYaAVCj1IYVPatNv/ufVt8QkCwWck
         WfuS74eCn9JzkYPJb0nnYeA70rKuhrVO9H65EAUt2M20n6YqGyHzMqYnj8fK4visJnPi
         eUkodkB/X1IpRaGEdB4IythUDUD/KdugG4XT6P0BIqvwB11L+oxBgMWpnrTx7hmj4Cy3
         Jj3g==
X-Forwarded-Encrypted: i=1; AJvYcCUWbP5gfxH/CBGmIFVTdnMLXo5/ORE1DFbU5uuEKEdU2gT+8eNbsRildeNR3FfHAD2xeP0g5tH8ZXkg5PkuggNzoSLOsUg/UYu7
X-Gm-Message-State: AOJu0Yx1vl/2mlvnizLDhmL+ZLMwd8vW/kQPrJfZ9Q/W7eSGLT5gH3ex
	TBk6RsbwLsFz9ABFv8u7hdJ8D3nvHp70CaBpP05WHPbVVkmMHVFzb6AVeK4gIU8=
X-Google-Smtp-Source: AGHT+IH1y1N708HUEGsnjoS6q4nNZv5jpR1ruiNr5BhgXx9htfbJ5Gvlx0osVvA0Xyky5zIXqmiVjw==
X-Received: by 2002:a05:6512:945:b0:511:4175:8d16 with SMTP id u5-20020a056512094500b0051141758d16mr1702012lft.55.1708022696771;
        Thu, 15 Feb 2024 10:44:56 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id i9-20020a0565123e0900b005128a755676sm284393lfv.110.2024.02.15.10.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 10:44:55 -0800 (PST)
Message-ID: <2e96c824-47e8-48bd-9e03-8c7390b02d24@linaro.org>
Date: Thu, 15 Feb 2024 19:44:53 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [linux][PATCH v6 3/3] dt-bindings: mfd: atmel,hlcdc:
 Convert to DT schema format
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Lee Jones <lee@kernel.org>, sam@ravnborg.org, bbrezillon@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
 linux-pwm@vger.kernel.org, Dharma Balasubiramani <dharma.b@microchip.com>,
 hari.prasathge@microchip.com, manikandan.m@microchip.com,
 Conor Dooley <conor.dooley@microchip.com>
References: <20240202001733.91455-1-dharma.b@microchip.com>
 <20240202001733.91455-4-dharma.b@microchip.com>
 <170738899221.920003.15342446791449663430.b4-ty@kernel.org>
 <cedecdb7-fe4a-42ea-9a11-faa82f84b57d@linaro.org>
 <aamdttvdk3jmswvy3rw3debk3ouddkgjbs6xmixroe6kqakjw4@lnd5crcgoeyj>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <aamdttvdk3jmswvy3rw3debk3ouddkgjbs6xmixroe6kqakjw4@lnd5crcgoeyj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/02/2024 11:02, Uwe Kleine-König wrote:
> On Mon, Feb 12, 2024 at 11:23:02AM +0100, Krzysztof Kozlowski wrote:
>> On 08/02/2024 11:43, Lee Jones wrote:
>>> On Fri, 02 Feb 2024 05:47:33 +0530, Dharma Balasubiramani wrote:
>>>> Convert the atmel,hlcdc binding to DT schema format.
>>>>
>>>> Align clocks and clock-names properties to clearly indicate that the LCD
>>>> controller expects lvds_pll_clk when interfaced with the lvds display. This
>>>> alignment with the specific hardware requirements ensures accurate device tree
>>>> configuration for systems utilizing the HLCDC IP.
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [3/3] dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format
>>>       commit: cb946db1335b599ece363d33966bf653ed0fa58a
>>>
>>
>> Next is still failing.
> 
> Failing in the sense of dtbs_check, right?

No, bindings were failing. dt_binding_check. This must not fail, so kind
of bummer...


> 
>> Dharma,
>> You must explain and clearly mark dependencies between patches.
>>
>> Lee,
>> Can you pick up two previous patches as well?
> 
> I applied the pwm patch now. If Lee wants to pick up this one via his
> tree that would be fine for me, too. If that's the case please tell me,
> then I'll drop it from my for-next branch again. Feel free to add
> my Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de> for patch
> #2 then.

At least next is happy.
> 

Best regards,
Krzysztof


