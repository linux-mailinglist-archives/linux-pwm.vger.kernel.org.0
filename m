Return-Path: <linux-pwm+bounces-5171-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5872BA5F7FB
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 15:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5F219C4667
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 14:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06724267F76;
	Thu, 13 Mar 2025 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoR5w33N"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B59C267F5E;
	Thu, 13 Mar 2025 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875951; cv=none; b=ae9BunNOAuvLFfinkpyq7wzHEsb2JUuDumCZXbKrmTMVBbB8WH8/zVTDV7AmC8uPFSdf5EyTXI1CzvPLhentn22pxUvAmbLX5QarzVfAoEsu/w6KWwL1/9n1OFI5tzK72nfPlgjxgAwC7N+QlfKddYblQBqBVwBfBLc0pVDPI5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875951; c=relaxed/simple;
	bh=/X1T8m4Bnen3WeN9vFB5QU0qKn0cMJp+nlGe1TVUSho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JNs/D3LvLIQTLWOvxb2OEQWi+KTvqTwFSpFvh5S5OKJYWOsT2ftD4KFEGG4dGLtWl2c7ezWFTbfuQmStv5QXao+20ljXSJhHJ3JytqqwD+hUFJ5Jih+cmKi93uXqHxKNKqEhpHbjqzR6q98iwVxAU4h5Kf1ff+6kAyt0DfvMRco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoR5w33N; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2255003f4c6so18965805ad.0;
        Thu, 13 Mar 2025 07:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741875950; x=1742480750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yt2liAs3aMHm+KHHmdHu8tTJ1pcBVxGtNnpneo2Ud6Y=;
        b=JoR5w33NivKJALkb6NI/0Tj4ERc/hIGZwYklI1bH1GNq0l6o73fdvKDp0uK6TxX29h
         oz5wuO/bK9joahXh5UdAX8lV+zXmjuDQ8pSFO2SMIrdyjey1BwZpnJjmJl3LJ7moyvn+
         4tXGf9UtTe5MhXTSjJIwersYs0//3F0V+drlZi2ZidiI+QpysecM/dn6ZohgscLl80MA
         zQGxHfTpaBl+vCviHYGl6DrSWPim0lAZRSQpJ2xUZUAJFfrXhulfL2MGd9P56tzQN9Hy
         7/Q6LBZ8XLZTrRGD32PT7xa/Ay6x8eDgIrUeypd7Xtu3Of62xVNwQh093jejuPWbtwML
         YVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741875950; x=1742480750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yt2liAs3aMHm+KHHmdHu8tTJ1pcBVxGtNnpneo2Ud6Y=;
        b=jj4iwlVPcIczKuVQV4LuALpWswe8x/sOV3g2DoC6gFyAMEIFjOh7mLAyifv/BwcHBE
         4qxJ0k6/ShBJ5rXyf3ziDdz5VyeJBZEyh+ufHvOKK3jJBN5K6KuAcmYFTXKWzjgzEY44
         BIR32LMgVRuFfQLtvzU/3mifzlSx1e0Z3EjN+95Solld3ZaNay2/LvRsZDks7IC2AR8V
         Ygv/+lpuYeQvBmkEVZx/NIY4mt0zwKwbmq1wb9OEPV0CQC/7K3vx1NnJubMZhXk9zzUq
         SVzHP+DIgqIkhZHfE8JfnT0HPKSFXXzT3PM2fRkJiPNbCGXF3nbYbyvRetIqVlnSgQMH
         cYKA==
X-Forwarded-Encrypted: i=1; AJvYcCUpudtwQWwSkmnM2iwCzd2N5eZeTb2PgivqySqGkuRcvms8BxWjhCt0blIm3wBE9CFXarJJNOuIM2jWV+xX@vger.kernel.org, AJvYcCV9xgXsY8MLL6eZHxlrdwAw+CYKq6sHBBVEgzMiNjKEk7CRaWYg9Zp2vvWeuHb3Kv3DhYul/qGAPo5b@vger.kernel.org
X-Gm-Message-State: AOJu0YwSsBvDAk/ut9k4HebIx+XzxsPAy1KkjrvNM821ojR8WYechSqo
	xIx2XiCZDnEsuRbqPTSpcDmboDECHSA47ykBU7RAcHVQU/dLR5Lqun65WbzcgRo=
X-Gm-Gg: ASbGncuI6ZcdD06Z655DFuLbIdBXgHhVSDyLzaWOIqfij2/9GMfcjENic7yFRdLmFo4
	7XG5/JHEbLvEpkhQ34WF88DrPU/+5m0Mnuu/ELjQJHVNXf7ifwc+GyI8k5tciIwTCLl8DZ/6Uah
	4MIXUjIRc8ZggPX3Ph1UHF7umA3CL7+fiYBVumf6FExf6ZQqX16KMyq0r2z+/GIJfx8+UrRxdkF
	XLbhklOa5n5t23UHarrUmGsl+QUegS48GuHsMS/rDr9KZpHroFFRSGB8hTGG6aa4NJ53UxGKSP7
	qmdABDBVg6e3z9CAvLcIs5na0HKw4grn3e44A25g619us0A8Tw0u/hllJvvLcCDOdBPieWQ8eaR
	OWgFWW5s6D8gNuiwtcldM/Q==
X-Google-Smtp-Source: AGHT+IF6eAtFOSwvFOI4Gm40tsebSeGzoaBQCU7pRdsE126LhuSwKSdaUakjB7uJmyjpQif4VQKq2g==
X-Received: by 2002:a05:6a20:9f0a:b0:1f5:7eb5:72c7 with SMTP id adf61e73a8af0-1f58cbc5d79mr17800801637.29.1741875949583;
        Thu, 13 Mar 2025 07:25:49 -0700 (PDT)
Received: from ?IPV6:2409:4081:1112:2682:8c5d:7e25:b34:fa93? ([2409:4081:1112:2682:8c5d:7e25:b34:fa93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9e195asm1318840a12.25.2025.03.13.07.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 07:25:49 -0700 (PDT)
Message-ID: <70cab705-c656-48bd-9b65-841f68c41d40@gmail.com>
Date: Thu, 13 Mar 2025 19:55:41 +0530
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: pwm: Convert lpc32xx-pwm.txt to YAML
To: Krzysztof Kozlowski <krzk@kernel.org>, ukleinek@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, vz@mleia.com,
 piotr.wojtaszczyk@timesys.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250312122750.6391-1-purvayeshi550@gmail.com>
 <b2f6a357-a468-4526-a1b6-69ab2c643b2c@kernel.org>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <b2f6a357-a468-4526-a1b6-69ab2c643b2c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/03/25 16:34, Krzysztof Kozlowski wrote:
> On 12/03/2025 13:27, Purva Yeshi wrote:
>> Convert the existing `lpc32xx-pwm.txt` bindings documentation into a
>> YAML schema (`nxp,lpc3220-pwm.yaml`).
>>
>> Set `"#pwm-cells"` to `const: 3` for expected PWM cell properties.
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>> ---
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 
> ---
> 
> <form letter>
> This is an automated instruction, just in case, because many review tags
> are being ignored. If you know the process, you can skip it (please do
> not feel offended by me posting it here - no bad intentions intended).
> If you do not know the process, here is a short explanation:
> 
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new versions
> of patchset, under or above your Signed-off-by tag, unless patch changed
> significantly (e.g. new properties added to the DT bindings). Tag is
> "received", when provided in a message replied to you on the mailing
> list. Tools like b4 can help here. However, there's no need to repost
> patches *only* to add the tags. The upstream maintainer will do that for
> tags received on the version they apply.
> 
> Full context and explanation:
> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
> </form letter>
> 
> Best regards,
> Krzysztof

Hi Krzysztof,

Thank you for your review! I will include your Reviewed-by tag in the 
next version if no significant changes are made.

Best regards,
Purva Yeshi

