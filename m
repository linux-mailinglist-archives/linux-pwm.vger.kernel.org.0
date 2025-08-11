Return-Path: <linux-pwm+bounces-6983-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE404B2043E
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 11:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E524C7B196B
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 09:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA332DEA9D;
	Mon, 11 Aug 2025 09:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHa57DjN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC432DEA80
	for <linux-pwm@vger.kernel.org>; Mon, 11 Aug 2025 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905478; cv=none; b=nwkYT5QPc1w1bVPbftFDNnJtRb6LJvBoxOXx7AgBMJqE8G3ZEUkC/v/0lFH/aqZjVpE0bd+NBR0ZaCYJ52jhC1ArDHNbeEYYHwpowvXGTlVdclfugHGCRmQpWpFGOf1Ab1k2KbanoGWt0HIweu6PWIw7Ew5wvLPgXELhfQQZeSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905478; c=relaxed/simple;
	bh=u6mPPSp7cA/PRGa2f30vHbLCcQCA5uyudzzgCU/QGt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WjHTZ390GpkZinKc3F/2aCnU/fQAc2nQ2UCEkB8n1hpPDpiE9HPhOj9x4bbp5StA7NOleZc9/iUlWsnnaDigEHrbnzpsJjJSShRGuZmKcrKVHQMNMbTuymzWucyTQUppTqpB6g7N4vTnhO9HjkuGjdGi/gNLlpjI7GlxaHC73WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KHa57DjN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-458ba079338so32161655e9.1
        for <linux-pwm@vger.kernel.org>; Mon, 11 Aug 2025 02:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754905474; x=1755510274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/e8vToSJSCReNRAEx8RxbA8CPAOFtmnWv5RzQRjO+Y=;
        b=KHa57DjN1802mNVzC8/0C5ONUN9K4SCY5TifsDPH8x2XL0w+N08G5xwIb87SeKQ+0D
         Gwmwi3mhtDGGdVVfwodK7+cTIZ4xi6GKzxod2w4Zrd58gO1DvFwBmq32iS14Qw0ZRw8B
         YJ7uNcxcIY3s9zTOSYSzTmvxTvzF0SqgyvgGZdEbqGB33lhoGC/RVErKMamXO33DTKjt
         rnoImfxOrfzY0ESMqYbrL+ffKUojLweuCQZjHSKKaAE9jtcVAli6iqTF4iJEooB5TrX1
         eKd1VMuKaURaEcdDjDfQCAUsbN+yUioNdOZ8Gn10BZZTzxQvIWfe1E1/GEqb8ZTMFODr
         Zt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754905474; x=1755510274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/e8vToSJSCReNRAEx8RxbA8CPAOFtmnWv5RzQRjO+Y=;
        b=l7erGWMP3oBwnKJgpFKnnU1tZtrs96ryR1IV/bZchVgY6jzsToz1hwtzJVw/aVuih/
         L9X9eAkejz7r3jS0Rh7u5w3zb4Ixjv6i8hsehTp5QEShWJ3m81IAUakwBhpeofvcL0lP
         Ny631bKYEydq7i+LruGYARaJjRTSZDxQuc2+gjql551VQe/PlcAWAZRgqXWJsXc/qD8V
         2vGQsr4spu2XCqyjsHLaqNqSi0BWKoFnBYnXD3MWW1adyFZpM+1rtEdBgofkWQPWyLfV
         t3eOjGB/QIXfjbyiyIlSwvXtqKUuYBNh2P0/6clKi1w4+q192np055DBBfZuq8Khl84f
         NKMA==
X-Forwarded-Encrypted: i=1; AJvYcCXqIxEHnobE4+QgMFkTRJ5xeybhmUZauS5NIGJgP9n83d5I94eLJBqh4MNxkzWAhlfyIsoKLDnnXfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+W9fik5F83GLfdLaCKz69PskMXK52ueglQd0tAf4swkpvrDnI
	NusHJAgn7BLWWh81Xemdm6b0df2jJ4H+UgOMJLF+uah3+WJ1GJRpI4dzinhQo56USfk=
X-Gm-Gg: ASbGncvhSTMRJPkwVjfEbLpPiFhEiEFyEeb5KnaGi/ucWCNsrIYbzpisxWUXGQQ0dxM
	QTOLyxJQf3cuMdnvvc5swlQ1Bdgeepg9FWCtwk6vJouyNXqzXIITs4/DiUROjQQaFH5unLxvzwO
	UsElpagWY//Uty0zTM7jXtSjjbpOYnT54XmFeAsYa6yA+G+FG+gdK+pgDuJWnnXqZf1t9plIsyN
	k3w9Sk/fmKLLzXv5N2ccKAzeTqGjOW9zRBVpLkZKpLxmJxjwWgklCtBXnzJnB2aA/SZrRrAbryV
	TGSJP8gGuh7+zRYlB5j8TGu77y033Fv95S2Dq0UEmZ9E2AlMVqPy/iCTHmvnsHjNYpuoQP+GWP3
	YSt4+z4dAR8IKkNsG1kBrT9DpwoVU/szN5qB3HzOc2o+jbs7vUz5S0sFmr/xDbhh+zpP7mMjX
X-Google-Smtp-Source: AGHT+IG+NEOXjyCznvP7UhqVqao6kNGxrVLq1JKLDQ1iHyYHEwilg3xM4Im8/dlulSQA849qP8Xp/A==
X-Received: by 2002:a05:600c:c089:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-459f3a7ee89mr92100265e9.10.1754905474135;
        Mon, 11 Aug 2025 02:44:34 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-459e586a011sm266892965e9.19.2025.08.11.02.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 02:44:33 -0700 (PDT)
Message-ID: <47ed1b83-9ace-475b-8279-6c7f394c35f3@linaro.org>
Date: Mon, 11 Aug 2025 11:44:32 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] pwm: Add the S32G support in the Freescale FTM
 driver
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 Frank.Li@nxp.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ghennadi.Procopciuc@nxp.com, s32@nxp.com
References: <20250810185221.2767567-1-daniel.lezcano@linaro.org>
 <20250810185221.2767567-3-daniel.lezcano@linaro.org>
 <p5pwwdlrldqdkpqtfvgo3dz2liz46ywy7crjfe4nybxmrhlh55@b6v7lccczczs>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <p5pwwdlrldqdkpqtfvgo3dz2liz46ywy7crjfe4nybxmrhlh55@b6v7lccczczs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Uwe,

thanks for reviewing the changes

On 11/08/2025 07:18, Uwe Kleine-König wrote:
> Hello,
> 
> On Sun, Aug 10, 2025 at 08:52:18PM +0200, Daniel Lezcano wrote:
>> From: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
>>
>> The Automotive S32G2 and S32G3 platforms include two FTM timers for
>> pwm. Each FTM has 6 PWM channels.
>>
>> The current Freescale FTM driver supports the iMX8 and the Vybrid
>> Family FTM IP. The FTM IP found on the S32G platforms is almost
>> identical except for the number of channels and the register mapping.
>>
>> These changes allow to deal with different number of channels and
>> support the holes found in the register memory mapping for s32gx for
>> suspend / resume.
>>
>> Tested on a s32g274-rdb2 J5 PWM pin output with signal visualization
>> on oscilloscope.
>>
>> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
>> Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/pwm/pwm-fsl-ftm.c | 42 +++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 40 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
>> index c45a5fca4cbb..cdf2e3572c90 100644
>> --- a/drivers/pwm/pwm-fsl-ftm.c
>> +++ b/drivers/pwm/pwm-fsl-ftm.c
>> @@ -3,6 +3,7 @@
>>    *  Freescale FlexTimer Module (FTM) PWM Driver
>>    *
>>    *  Copyright 2012-2013 Freescale Semiconductor, Inc.
>> + *  Copyright 2020-2025 NXP
>>    */
>>   
>>   #include <linux/clk.h>
>> @@ -31,6 +32,9 @@ enum fsl_pwm_clk {
>>   
>>   struct fsl_ftm_soc {
>>   	bool has_enable_bits;
>> +	bool has_fltctrl;
>> +	bool has_fltpol;
> 
> All variants (up to now) have .has_fltctrl == .has_fltpol. Is there a
> good reason that justifies two bools for the register description?

Yeah, I agree it can be folded into a single has_flt_reg boolean. I can 
only guess that was done with the idea of sticking to the reference 
manual and perhaps having more variant to come with, eg.,  fltctrl=false 
and fltpol=true

Do you want me to merge these boolean ?

> Also I wonder about the fuss given that the two registers are not used
> in the PWM driver. So this is only to prevent reading these registers
> via regmap debug stuff? What happens if the memory locations are read
> where the other implementations have these registers?

The problem arises at resume time.

	/* restore all registers from cache */
         clk_prepare(fpc->ipg_clk);
	regcache_cache_only(fpc->regmap, false);
         regcache_sync(fpc->regmap);

Without skipping these registers, the kernel crashes on s32g2/3


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

