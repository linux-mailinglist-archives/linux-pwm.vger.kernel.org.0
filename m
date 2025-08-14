Return-Path: <linux-pwm+bounces-7053-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BE5B2670C
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 15:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56E4B4E59DD
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 13:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D353009F7;
	Thu, 14 Aug 2025 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wBMrmAc/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19693002C3
	for <linux-pwm@vger.kernel.org>; Thu, 14 Aug 2025 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177837; cv=none; b=XRngv/7/kXZfH5DY8+vEM+Ag+/0DAbWfHAD24UaepEIqtyDHmMAo1QICSFFqpeTCqLerrYtcnsLKk+LJ+t3yF3u8uiAMusfJwQpk3AfSiITNH77+6VGEyZpjmzPcIosKDzF8IdfxfX8VxmcNmRS2U0qaXmzKS+a1E2BwmbHt6dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177837; c=relaxed/simple;
	bh=j2lJMHwL/mryALVVeqNju/rLZLU5pws84MPhbxVUNy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUErja6qnKNN5lP0aUZVpACJdB4wCxeULXz4i0p2/IAFSNUcto/7IgJy5iE6h/uM7H15x2nVjr05007Rrviig1+I4mi2k37eXmvJjfegvAczRYW3mhsqurYK9ATVTmYa1x7/42e31IVFGbDqlLkgbEZfE0I+V0SFSaPhaMfiCgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wBMrmAc/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b00f187so4149585e9.0
        for <linux-pwm@vger.kernel.org>; Thu, 14 Aug 2025 06:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755177833; x=1755782633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hEb06N5Fa4rPEtmflX9srzTgGFvnEZaC4f274YC/kn4=;
        b=wBMrmAc/ssv8H3ItNktg+xvObTxNhaBKsCut3lcqhwweVBmxpBbddYH7grGRfTvCur
         ThyImNueh+zmu3bkFDzKHBtGWcefrFXwyPyzrAGRGtlxaTe3BQPmijo3PiJaoYUgra4e
         tOYoQfklvzP7u37OvKQLpGCrBpZljYpOKGzNdogVvhZI60qNULR+zkN8UiBKJhZZji1B
         4v3kI/bR5pZPhwzsfm2hH1+DYmCQanqtwR6H1VnVzb1rrCTe28tXrIlVkF1LrZfq37OI
         5/y3IKh168mzjhICLnu3VbNSrnXfqbatIBY7Wox4mU8AoJg/aEiFBSvzeEoPfQs3/o0E
         OhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177833; x=1755782633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hEb06N5Fa4rPEtmflX9srzTgGFvnEZaC4f274YC/kn4=;
        b=YefqlpoYFe6teo8ZLiPO2uBI+4f8Ku8Vw4kjmv2CgXYh7DQurpaPhCWbX5qD0sTjmp
         HgMJyYkhC3zFlT12Guyymo2ON2ZOHt5gRiwgAXs6hpk+ySUUPJ03JxMZmjKEXpRuDeaP
         TXWUU1t2/u6G2Cyhjzqo17oRs/BnXuI8fXmQ1Egtj43BMSdNXjRW2M5i72hFJlWR5zSl
         wY8lih4ShcbkO1N00Gg1BBf72S7Z5uVbd2zE022gQy5rFCLmxCY6ha00JblAFB6Cn2+I
         5gVBeyo9rqJavED8Fd3+o71XtPiKYUo2i+FeMKAsVyRBP22tkXINf5ug/3B24kr1iPqo
         zggQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDBCgcFRx8DB0CF6E2PY/wyuDT6ize1RATjZzBF24d+5y1AHj8/iGHMdR9CUzeG/uxi4XUCKZcxA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSB6IpAc4Cag4Bw1m1Ns5UUOLwq8kEWP7+5/BRs7q/vSNaU6WA
	c/PZKOdebhYFYgO73Hp0zjeaXQJ8cupsfSCxCakh0+Fsfb7Hk3sdzvtlulCrkHk+NGY=
X-Gm-Gg: ASbGncvi7M11P6XRfxTx7k3BzYmDYgV0eoIiKJ3LGefg/lzPrLxJ2JTBwl5pYM1MiSe
	sOHVWVKRD3iguTTgGs/Gp5cwYIEBea+21ZK6uvtgW5PnKmkNzccQBfoNp49KmikTaPtgIMMF2Kj
	q4c5BLtr/mTxO8SWcVqO1d7xrj6/bb0HYlC6jFGZM2K9YGOimPNPQLKy+UTj8aOq1ybJvZPP8lE
	nx5h+KX9v5CHZT9Nek8a3r9TBM12Hky3rXETG+DceY5nG6LFf2YGp6n77nn+gEbdwJWdXTTIhAO
	J1ZMFeYysZQ0B2IOAJw8KYE9F56+28ZA2686Uh96Bjb7ug7ErdHG7j6QiPCbfQm9Uiay68VZk4h
	k9LdbXxCLaoWT8eT4mzvnEC+dVS2SeBAvo8iVweArDEch8YF2cCu03XRsgFEu9A==
X-Google-Smtp-Source: AGHT+IEeWDaYHaX1ixVeGZrg1niQ27if5sJYq8roDVzPgUppHd5n/Iw2kUmDMcNmiQTa/EJbkU3Psw==
X-Received: by 2002:a05:600c:450e:b0:456:496:2100 with SMTP id 5b1f17b1804b1-45a1b6753a2mr28657505e9.31.1755177832928;
        Thu, 14 Aug 2025 06:23:52 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45a1c70acc7sm20591415e9.25.2025.08.14.06.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 06:23:52 -0700 (PDT)
Message-ID: <a0d431ef-effd-49b8-8124-0c0890a70ffb@linaro.org>
Date: Thu, 14 Aug 2025 15:23:51 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Add the s32g2 and s32g3 FTM PWM support
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 Frank.Li@nxp.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ghennadi.Procopciuc@nxp.com, s32@nxp.com
References: <20250812200036.3432917-1-daniel.lezcano@linaro.org>
 <jmhzng2ezrrqhy52y7eru2ik6uburn4rnilfwreqmvkeirqbnm@b5ksjlufwuwf>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <jmhzng2ezrrqhy52y7eru2ik6uburn4rnilfwreqmvkeirqbnm@b5ksjlufwuwf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/08/2025 12:54, Uwe Kleine-König wrote:
> Hello Daniel,
> 
> On Tue, Aug 12, 2025 at 10:00:34PM +0200, Daniel Lezcano wrote:
>> The NXP Automotive platform s32g2 and s32g3 have on their board a
>> FlexTimer (FTM) dedicated for the PWM. The same IP is found on the
>> Freescale Vybrid Family and the i.MX8 SoCs. However, there is a small
>> difference with some registers not available on the s32g2/3 and 6
>> channels instead of 8.
>>
>> These two patches provide the DT bindings for the s32g2/3 compatible
>> strings and the code to deal with the FTM difference.
>>
>> Changelog:
>>          v3:
>> 	 - Fixed dt-bindings subject prefix
>>          v2:
>> 	 - Merged the two booleans for the regmap holes check
>> 	 - Clarified why this is needed in the changelog
>> 	v1:
>> 	 - Initial post
>>
>> Daniel Lezcano (1):
>>    dt-bindings: pwm: fsl,vf610-ftm-pwm: Add compatible for s32g2 and
>>      s32g3
>>
>> Ghennadi Procopciuc (1):
>>    pwm: Add the S32G support in the Freescale FTM driver
> 
> Applied to
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-next
> 
> with this merge conflict resolution:

Thanks for fixing the conflict.

Restested it and I can confirm it works as expected.


> diff --cc drivers/pwm/pwm-fsl-ftm.c
> index 6683931872fc,e0069dbdb02d..000000000000
> --- a/drivers/pwm/pwm-fsl-ftm.c
> +++ b/drivers/pwm/pwm-fsl-ftm.c
> @@@ -396,7 -428,9 +416,7 @@@ static int fsl_pwm_probe(struct platfor
>    		return PTR_ERR(chip);
>    	fpc = to_fsl_chip(chip);
>    
>   -	mutex_init(&fpc->lock);
>   -
> - 	fpc->soc = of_device_get_match_data(&pdev->dev);
> + 	fpc->soc = soc;
>    
>    	base = devm_platform_ioremap_resource(pdev, 0);
>    	if (IS_ERR(base))
> 
> The pro tip here to make your upstream maintainer lucky is to work on
> their tree or next or at least the latest development release and make
> use of `git format-patch --base`.

Ok noted, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

