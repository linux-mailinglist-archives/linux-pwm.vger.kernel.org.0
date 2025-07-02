Return-Path: <linux-pwm+bounces-6690-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECB6AF0E14
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 10:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC4D188123A
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 08:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8483229B13;
	Wed,  2 Jul 2025 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuJbHRsh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2376F211F;
	Wed,  2 Jul 2025 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751445093; cv=none; b=Do2ttBgeJjiymyhbXEwp54d6XGKjSZpALkQnikig/Bv3cmvdpDCAs/KDriWj6umXFfqA55SflOWhTF/jNfw7ypxV19C04TZM6I8QWRHvLC7CAj8t1uxp65HduDVIWupY/sqTvGZcCPp07JsOjeuZ7kiL5PC8olRHeT8EoD6meq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751445093; c=relaxed/simple;
	bh=JNmpxopemuV+JMfhr083rEc/bP1EJp3VvuBjftidUa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MC7CwiVJmjzQM3IE5OpegyoGxMUh8ZkA890DSa+15PJgI9H+QPgf1e+g8udW1IBy198vtl2f+Hzs5P3JOql44QgfPHZRSR/GV0AQKyS6a+Nf86EyqQt8L6zvYmXKg8MspeNjJy/ERS0wsqKRcfFrOBDXFZSIPnFDwMqvcJzFbkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuJbHRsh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ade5b8aab41so842668666b.0;
        Wed, 02 Jul 2025 01:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751445090; x=1752049890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYgO9gPGPFem/ue3nHcSi2VYa5driBXGjHPtXbD9tHw=;
        b=OuJbHRshECEpjQ7HlvY1SNdw3cGAA4H/Mz3wGdnLLOan3DXVIPK94aghBuNcjiaiQS
         AKEWPh7nO8wQXOAFM9D+lIbiQkKM39yz3X4q9N+JASSwV/rPSOoEJughJxbhyUomup5l
         UpTIlT8bYkH7bmndMEXZ2Ud7eaZGwsi2edgmNbd9stIHDk318hm931jgOlt65OgwLHfB
         xeQuF+hCL2nGjIVmLQ85+ptTpIEy+8+W8plLfoGy3k9js9kUad2Q9G1P5+HzNDooJ3Sx
         QYh74im8JZaa1LozcxtcZNXIunIa/jGUmpU0km4BSZhTz2vFVlC8ornFnKr/1MHxxoEY
         mNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751445090; x=1752049890;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYgO9gPGPFem/ue3nHcSi2VYa5driBXGjHPtXbD9tHw=;
        b=hk2FrFrF3yhF24C4/aOoJfPzRmPAsQABy3N0ibPKm7aQjyJ6CUO/GbqCKnxVBHoP4E
         5Pjz+RogNlnbdAtTO3LdN2sIuvFvkMq44CEwzyjaMIVniVGh69bDOvp1RGOruQQT65d+
         TZMJ3t58oxxRQoumuTlBQtOuZW3hOovb/ZjuTBWi92FYqU7Y/blaOz4qtBWCkQLSTzP4
         iE+71d2KizcYL9SEmaP52//9NMBokF3Sn3k+O39yCGY12VuZmUdmH6ZPn+phrLfCH7W+
         VKQGbpcWfsI0L4USXIJz+LdacmYYPzPbGINfycz9hHRuqgHTEgfo5OhIeTqIOx/4ll9J
         +1zw==
X-Forwarded-Encrypted: i=1; AJvYcCVQFwso65Ui1xvLjcQwFFqxhdPUoEGZEky8cz8I00GwC+F5D1TBYrR3KNWvfoqG8VUmONRdDaoXwjZW@vger.kernel.org, AJvYcCXVI1XvqSwAymTISUykx4+FyjFf94LccQEjsRe2FNYSpiQD1rtM2lnrRrdNcW+FrT0E7BYKEfKhuwRUKtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzmJzmuWdJCjoDlDzUFdUx0ItPB4z36oyJDMIotdB4lUFlplDZ
	L4JMzYOvJmw7ZjUveUlvwQg0C2QaVL55Ln+BkTvTFbPHtRgImVEDgaid3tvrTQ==
X-Gm-Gg: ASbGncsurafO3VgUlSHCHwvSkC2YvzeK3xfA4Ed+ySyMuFEh8FckCIvxN5CpJ1qWqRv
	ylQM1Saq/OG89f478LDv4vDlyfpWfp60XAIQF+xHP0780oZZa71z6WtQ2bf7uQ6ZgvTM36nd+gu
	pNbPZEIsNBxv4ZWY+pvISY2TCz3IX8uhSZoQ8W457WuO1JQCI3oDzmUrpT11mb4aNBXek5ZDmcb
	OnmDDGgGqRwsoTS9xxQUnPQBp/rtipH54bWZGMSph9H0Iv1aSNdSXz8HHuvF5x4LWuD7yVn7nl0
	v0LjwnNjtnTxjrImVUrFrEtG1YxNEDqMd9vaREkKFpBWrlxZfLufaZdb38tzuaxYcYVzGKX+16P
	URw4JFwdiyEBUFbtfJHswX0g=
X-Google-Smtp-Source: AGHT+IHLIAeFsGaHxS4ciQ6iWXJqr5BcWAMimCo+KVlmSdchXq5TGkILRI11lt2Dhr4SijLUwuD1pA==
X-Received: by 2002:a17:907:96a8:b0:ae0:34d4:28a5 with SMTP id a640c23a62f3a-ae3c28bcd88mr187429266b.0.1751445090007;
        Wed, 02 Jul 2025 01:31:30 -0700 (PDT)
Received: from [192.168.7.237] ([92.120.5.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b24fsm1032167466b.34.2025.07.02.01.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 01:31:29 -0700 (PDT)
Message-ID: <a1b6039e-7020-4d17-8186-d40ac17ba730@gmail.com>
Date: Wed, 2 Jul 2025 11:31:28 +0300
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: imx-tpm: reset counter if CMOD is 0
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, linux-pwm@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
References: <20250701220147.1007786-1-laurentiumihalcea111@gmail.com>
 <vwozlwajisjw5qomwtmnfdklmucevyxncsxl2cdmixn2yixxrk@x6j3r2lrl5qz>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <vwozlwajisjw5qomwtmnfdklmucevyxncsxl2cdmixn2yixxrk@x6j3r2lrl5qz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/2/2025 8:51 AM, Uwe Kleine-König wrote:
> Hello,
>
> On Tue, Jul 01, 2025 at 06:01:47PM -0400, Laurentiu Mihalcea wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> As per the i.MX93 TRM, section 67.3.2.1 "MOD register update", the value
>> of the TPM counter does NOT get updated when writing MOD.MOD unless
>> SC.CMOD != 0. Therefore, with the current code, assuming the following
>> sequence:
>>
>> 	1) pwm_disable()
>> 	2) pwm_apply_might_sleep() /* period is changed here */
>> 	3) pwm_enable()
>>
>> and assuming only one channel is active, if CNT.COUNT is higher than the
>> MOD.MOD value written during the pwm_apply_might_sleep() call then, when
>> re-enabling the PWM during pwm_enable(), the counter will end up resetting
>> after UINT32_MAX - CNT.COUNT + MOD.MOD cycles instead of MOD.MOD cycles as
>> normally expected.
>>
>> Fix this problem by forcing a reset of the TPM counter before MOD.MOD is
>> written.
>>
>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>> ---
>>  drivers/pwm/pwm-imx-tpm.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
>> index 7ee7b65b9b90..30f271826aed 100644
>> --- a/drivers/pwm/pwm-imx-tpm.c
>> +++ b/drivers/pwm/pwm-imx-tpm.c
>> @@ -204,6 +204,19 @@ static int pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
>>  		val |= FIELD_PREP(PWM_IMX_TPM_SC_PS, p->prescale);
>>  		writel(val, tpm->base + PWM_IMX_TPM_SC);
>>  
>> +		/*
>> +		 * VERY IMPORTANT: if CMOD is set to 0 then writing
> The "VERY IMPORTANT" is correct today as this is missing and so
> disturbing operation. However once this patch is applied, it's only
> normal to have it. So I suggest to drop this.

ACK

>
>> +		 * MOD will NOT reset the value of the TPM counter.
>> +		 *
>> +		 * Therefore, if CNT.COUNT > MOD.MOD, the counter will reset
>> +		 * after UINT32_MAX - CNT.COUNT + MOD.MOD cycles, which is
>> +		 * incorrect.
>> +		 *
>> +		 * To avoid this, we need to force a reset of the
>> +		 * counter before writing the new MOD value.
>> +		 */
> Without the reference manual at hand or a deeper understanding of the
> hardware this isn't understandable. What is MOD? What is CMOD?

so, MOD is the reference value for the counter. The counter needs to count until this
value is reached, at which point the counter value gets reset to 0 and the output signal
is driven HIGH or LOW (depends on the configured polarity). This value is used to define
the period of the PWM.


CMOD, on the other hand, is a clocking-related configuration option. I'd say what we're most
interested in here is the fact that if CMOD is 0 then the counter will be disabled. Otherwise,
it will be enabled.

>
>> +		if (!cmod)
>> +			writel(0x0, tpm->base + PWM_IMX_TPM_CNT);
>>  		/*
>>  		 * set period count:
>>  		 * if the PWM is disabled (CMOD[1:0] = 2b00), then MOD register
> Best regards
> Uwe


