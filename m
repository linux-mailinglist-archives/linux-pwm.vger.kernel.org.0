Return-Path: <linux-pwm+bounces-1689-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3168704BA
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Mar 2024 16:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8061C21A1E
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Mar 2024 15:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E4F46525;
	Mon,  4 Mar 2024 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3AhMCVW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DF13FB02
	for <linux-pwm@vger.kernel.org>; Mon,  4 Mar 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564546; cv=none; b=GKxbfXNbP/1Hq/rrx8vS66oaeF4sFjeZwdwCf4XZanjnaiY7IaopN7XgYufwtRyyCH8UVYdXqzg/WHTK/uMJuYFrFhobIKAknVZBeHPyxw/iu2S1l9jCsbTEiVKNrKqm44HAVIDiBWK7eNXL+SZoZBxIHWniTctw1eU6DbQ60v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564546; c=relaxed/simple;
	bh=A76FdofcX5bcO2jPo3YyAVMPAw8wYMo2MIlnOzf6Tek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UhiTosoWAL/Qr9pEekij4ANWJxxIngoAh54yxwLI+6ih0I/DhpKbs+/dEpI+4wPfrBbJcUkC8Rl6Fc4rWQEygih+GIlTBxuipy8omTV9lj+pTCLZcRB8uiCBjKjtmSNDLdWJp5BXCiqs1OuULAndwMSPSsYcp8oZVguB5SSJjQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q3AhMCVW; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513173e8191so5510023e87.1
        for <linux-pwm@vger.kernel.org>; Mon, 04 Mar 2024 07:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709564542; x=1710169342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8sztT78mA4ZXeKKIX005xkpR3DIfUvvOXL3CwBXH6s8=;
        b=q3AhMCVWdVcqS6FwV3zLYFG+qZbpNDBWsUeZSAXOZEjXYfBaHI/rO0B2Cr3L2o95ev
         cFBcRGTy+fKVHrcXUg2S5gc1oETOEr5o+bnvKqYjTZ6Ri94ze6BcQMbULn59Eu49KseX
         c7kxWjykf3eDTDH4qRwRJK8mdsmyKDowP9LdOZevMHRMwzHqF9+EKpa1bsNjq/cKKz46
         QHP4i1EMNntee6w+E4kyApX9d9piqTJGYDN92VfGc3WbNx83FNz/GY2z98S4RHBu472f
         i2qFaknGkkkJOb5UcyytJmADJeWftle2YGJzUFNG+P06tmXOH2f4nS+o3EavQ4CSCcsY
         UfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564542; x=1710169342;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8sztT78mA4ZXeKKIX005xkpR3DIfUvvOXL3CwBXH6s8=;
        b=Qij5m83txLdZAYWuH+jXrU9IWfCsyEsnpb1KosyFaGg44DaCQsopmvhEV8cF1J8vzw
         tDhIKYMDW0DBEM4CVk8vBYVOIxwgZgFExxZwG1RXarSEq6Ffa9TIZdLlQyVOExCQUj9C
         jQjOkqgvorVzSgu2zGVNwKOXbUTXtnd61YHZz7coZ5slahAj10/vF2fFcUycTT8mwsK6
         a5c9lZPC2oUXBJUZ4p/eF/CmbcefEaxmbMfTvWJoKmOHKM5uBO92se2Yza2TKhgjx6oS
         C/6HiaIpCUg6roiUmSw3AVXH919UZb0v9YIwGYbymznxVXoEocH7Dm3OuofKJg/BBx1P
         zxbA==
X-Forwarded-Encrypted: i=1; AJvYcCU+H8vrwyDNoX1c93Hnz3c4ncUI1do0cFXKdQC+ES40pWd+hvzHmgE/YeqXj2G6s5zeasygl3Ba3fKmQvx8cAL/Z7Wa9ZhQUtpW
X-Gm-Message-State: AOJu0YwkESxK5hnk55XhnPo9zg49Jc3lwSnYFjdRpAKqNkX8ENeSk5bQ
	3Pue64xnre0WT6uvfGJQaX8Ds1WrpToCuU6Fv1hp5E+H2QwNfYq1MtpcKUYI6Ng=
X-Google-Smtp-Source: AGHT+IGGt0MhRhzMw9pd8Dit1e2bT2vtE1n0JuuHGL2iy2Qj/eb4ruaLOzIX4T/rTm1ryJNrqkcBAg==
X-Received: by 2002:a19:f603:0:b0:513:2137:a231 with SMTP id x3-20020a19f603000000b005132137a231mr5552748lfe.67.1709564542511;
        Mon, 04 Mar 2024 07:02:22 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id w11-20020a17090652cb00b00a44879da0f3sm3934073ejn.143.2024.03.04.07.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 07:02:21 -0800 (PST)
Message-ID: <0c957a95-9f82-41c2-8e2c-0b5bf4b061a4@linaro.org>
Date: Mon, 4 Mar 2024 16:02:18 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
Content-Language: en-US
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 dlan@gentoo.org, inochiama@outlook.com
References: <20240304085933.1246964-1-qiujingbao.dlmu@gmail.com>
 <20240304090248.1247215-1-qiujingbao.dlmu@gmail.com>
 <91f0a339-ac0e-49df-bd26-dbfe1485308f@linaro.org>
 <CAJRtX8TPz_jTvPmuBW8t=mC+BR1kWmu=GS9K1k6ys7U9u0ENFw@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAJRtX8TPz_jTvPmuBW8t=mC+BR1kWmu=GS9K1k6ys7U9u0ENFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/03/2024 14:40, Jingbao Qiu wrote:
> On Mon, Mar 4, 2024 at 6:15 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 04/03/2024 10:02, Jingbao Qiu wrote:
>>> Implement the PWM driver for CV1800.
>>>
>>> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
>>
>> ...
>>
>>> +
>>> +     ret = devm_add_action_or_reset(&pdev->dev, devm_clk_rate_exclusive_put,
>>> +                                    priv->clk);
>>> +     if (ret) {
>>> +             clk_rate_exclusive_put(priv->clk);
>>> +             return ret;
>>
>> Please test this path - you have double put.
>>
> 
> Thank you for your reply. You're right. If the
> devm_add_action_or_reset()  function
> fails to add an action, it will call the action.
> 
> By the way, if I need to resend the patch, should I wait for the
> maintainer to review it, or
> should I immediately correct this error and resend it.

I recommend one patchset per day.

Best regards,
Krzysztof


