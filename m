Return-Path: <linux-pwm+bounces-6068-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2150DABF6A2
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 15:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215F73B37D0
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 13:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DE314F125;
	Wed, 21 May 2025 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QZwU5kyJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F210015381A
	for <linux-pwm@vger.kernel.org>; Wed, 21 May 2025 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747835629; cv=none; b=hHGfE+jdFo+y7M4YrVSbVG90GsIj6V8wQBWi0g6gXGPvcfLOmlNgMGPF6/LXh5s/uAPyISQbnaC/01D+nKsM2uxSyVPdxqePLHdid0ZnQ/IPkBsz5JEFxFClnPFx5IJ2ifiqagp2/vPjQz3Jlud054pHflDovV/ivOz8hcrGLpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747835629; c=relaxed/simple;
	bh=IrZ5eRKdvHnLfdBgA5Nxy0weSbvz1ttlkMPa/YVUH3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBOPLCcfDrpFLjkSv6oNIAxiCtkE70IPZ2dF0hFBBaRrzYR8fBdHIDcK+1Cbf4gOG1921mKvxzbzmuaPs0JuMr/lLxuyJGjrlLI1r2yV4pAAj4HodQmyxEsg1+cQG5GT39hc9IHtfG987ZIkyRm/oFZ9np7hQEYtbf2F+8zZ50I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QZwU5kyJ; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3fbaa18b810so2208824b6e.2
        for <linux-pwm@vger.kernel.org>; Wed, 21 May 2025 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747835627; x=1748440427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TN8vNo4OsWHNsyvidVWWosuPqSbZZ3DbbQtiLkxvupM=;
        b=QZwU5kyJp0JmCMBREBew1TKaiL1qXlLZhkany+saxezNUpRsyLhA11LVE7RrUbnv+G
         8+iER+bT/aDJc5X6rqZ8Ah3tP9pKpp3DDsSBXMfmL6vneSw5m25M4nvOsyh5VptH2s9Z
         OK3yi8O/wWe4LoFkOkdSknFOG90oel6gotMBIQYPu3bT4kmrZ+5zLAoooltsd8k13NQ/
         hIcwaG96f+ctNZP2CPpIbeKQovtdXQ2d7rciAoH0QOgZK4UQ1mkkoJxUMmL1Orww4Jdi
         0CC3IuJcw71pQxtbYMJHl3qGpjMdbLKyLfuEeK40bGagVADY1edtnaTwoTCHBdEuR9rT
         bX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747835627; x=1748440427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TN8vNo4OsWHNsyvidVWWosuPqSbZZ3DbbQtiLkxvupM=;
        b=SpfpGBihcyMhREPAl+48r3bq+wW8GbeVrGtJzImBAEIL+ArvVJmW5W+HtjIu1F4z5X
         OvJeq4qJPYg30sgACXcfyB54F7yFIbaHA04P25j0bp4Cb0bSxVj6kfAjqdW5ElUCKYTF
         yWNK8gTKHtbxTXzgZbOvGtyd/+BDEvQRa6UR2w0EqlfisygKK0Lv15KANovAkOj5xsvI
         C+gVIt3J2HCftVuhiy/ybD/TJDc9cvtVR+Cucv//mVbsimO6883y3qA9onqrW9NEbj+u
         K0gO7pml3dvcKkRBz7w/R2IzDboI+v6eoh8RamzNlvkNdHsn/WUpABIb7JiosfFmL9J7
         nl0g==
X-Forwarded-Encrypted: i=1; AJvYcCUjm1YAYp4+kuTGf217ETznNvg9y2VOD5UtPuoxakrdYs9j7uRXJc5DHB4V8olpxzsjCurFmQzewEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrjriokk3DcsfODCqWvau/PHovdWGsAzgAyzwN/KISInznIft0
	TyqrmgIKl6CNgbslK8sHcvHphMXAvsYk9aVNwEh+8XdmdLszDlVVEhm8CWOxNzNKvps=
X-Gm-Gg: ASbGncsa7cCcVAXA0B/LFmNHshHbJW+oCQ6j95iS6FsgStwKw7s0m14AlAuxiDNwb/M
	TO8cywMgpZksqIeOrEZ2uCA7gNTnSUYQyVTZ1o4nlpKo+5WfBjtZlFXtNrXbaRYJSd5muhPmuzA
	cie+Tl3Y287lXBJGbuF5iEgBKMt1R+XxqvhpNsOS0wF/nmX7g9WegSDvTKXKCb4cHJy052E4O0l
	COtSOKYPFxg2qpkVSOLklmdN+CRNG5EAG2BzgFmcpeS5KPvp3xr4LMr0/9t5tj1ilXGvbBomY0M
	YSK2YuDK+2vAD4fLqBo9m/YOH3i4dZXqwhOwOWhFVZ9KD9C5snXAPeQk+WiCGRh4qxnf2JG9exJ
	fWwBzkWNut9r7YNE8hC8HMbSzOw==
X-Google-Smtp-Source: AGHT+IFYCXtc00k34yANAC2zmBuis0tebfqeNN9MhmWjygKNfbvjf2hqAzmrtv2L+E0iPrKoPM/yoQ==
X-Received: by 2002:a05:6808:4486:b0:3f7:dd2b:229 with SMTP id 5614622812f47-404da70a2c2mr12335197b6e.7.1747835626938;
        Wed, 21 May 2025 06:53:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d77b:6acc:2ad1:8ff? ([2600:8803:e7e4:1d00:d77b:6acc:2ad1:8ff])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-404eacec299sm1630070b6e.26.2025.05.21.06.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 06:53:45 -0700 (PDT)
Message-ID: <99c6295c-9ed8-4611-a3db-ad57a33f4f38@baylibre.com>
Date: Wed, 21 May 2025 08:53:43 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pwm: axi-pwmgen: add support for external clock
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250520-pwm-axi-pwmgen-add-external-clock-v1-0-6cd63cc001c8@baylibre.com>
 <20250520-pwm-axi-pwmgen-add-external-clock-v1-3-6cd63cc001c8@baylibre.com>
 <20250521-nostalgic-pretty-hedgehog-d08a77@kuoka>
 <dc9c370c-e1e7-4ef9-8738-e6ac8887ee61@baylibre.com>
 <17a9ee62-8185-4833-acfc-1639fd17efc5@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <17a9ee62-8185-4833-acfc-1639fd17efc5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/25 8:30 AM, Krzysztof Kozlowski wrote:
> On 21/05/2025 15:23, David Lechner wrote:
>> On 5/21/25 5:10 AM, Krzysztof Kozlowski wrote:
>>> On Tue, May 20, 2025 at 04:00:46PM GMT, David Lechner wrote:
>>>> Add support for external clock to the AXI PWM generator driver.
>>>>
>>>> In most cases, there is a separate external clock that drives the PWM
>>>> output separate from the peripheral clock. This allows enabling both
>>>> clocks.
>>>>
>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>>> ---
>>>>  drivers/pwm/pwm-axi-pwmgen.c | 23 ++++++++++++++++++++---
>>>>  1 file changed, 20 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
>>>> index 4337c8f5acf055fc87dc134f2a70b99b0cb5ede6..67992a7561ec0440b1c1fa327f844a0602872771 100644
>>>> --- a/drivers/pwm/pwm-axi-pwmgen.c
>>>> +++ b/drivers/pwm/pwm-axi-pwmgen.c
>>>> @@ -280,9 +280,26 @@ static int axi_pwmgen_probe(struct platform_device *pdev)
>>>>  	ddata = pwmchip_get_drvdata(chip);
>>>>  	ddata->regmap = regmap;
>>>>  
>>>> -	clk = devm_clk_get_enabled(dev, NULL);
>>>> -	if (IS_ERR(clk))
>>>> -		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
>>>> +	/* When clock-names is present, there is a separate ext clock. */
>>>> +	if (device_property_present(dev, "clock-names")) {
>>>
>>> No. List is ordered, you do not need such dance at all.
>>
>> I should have added more to the comment here. This is also needed for
>> backwards compatibility where only what should be the "ext" clock is
>> given as clocks = <&spi_clk>; and the AXI clock was missing.
> 
> I do not see this needed at all. That's already handled by old code. You
> only need to take new optional, second clock - axi clk. You take it by
> index.

Except that it is the "ext" clock that is supposed to be optional and
the "axi" clock is supposed to be required.

> 
> Best regards,
> Krzysztof


