Return-Path: <linux-pwm+bounces-6802-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04174AFE295
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Jul 2025 10:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068CC481E63
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Jul 2025 08:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D531D274FCD;
	Wed,  9 Jul 2025 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NG+gi9vT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F871274B32;
	Wed,  9 Jul 2025 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049764; cv=none; b=eT5GdslEVrpPQU6+Tgh2hgX73ixxnZUUByXZUOpnTas+OXwnLmv5XK6bATYhL92HevrUzqbtCUHpeZeo0/DGE+RbnGA3c/jadKGu+yLMZxDRjC1FiX0jsD3ue0MQOl2RYoJ5ZVBAnIdfoeLM8947iMZXvpapDL2iDThsR7yWi4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049764; c=relaxed/simple;
	bh=Gz615AA1RemfbzZ5O+NZcL2ZlXa7UhUhm7op+3BwqTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXxXFaavM+IFHLiXeD/WFxu/b2HFjLWHxWT2g3kyP8Tr29A5ZKzatEJBevQ8gtbIN55E+TgAUIaHHNmTstu/Orc5ez9IixEOu77EuzVr1BmuOOAymz3jsqqLzV95Av838lGQX9ZfHiWI0SblglzYRtWfvTStqk/5jcPHF+gA8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NG+gi9vT; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso152593266b.0;
        Wed, 09 Jul 2025 01:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752049761; x=1752654561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bi/l3ud7Bd1Vu8GC02tc5orfdCo7D2QgRurFTd5r8ic=;
        b=NG+gi9vT1MYsws0UG0EOeqpSLGkYege6hHlEtiQYQHNmdVUdq7dFjFfnt79ZlFO4uc
         h0r6vQH5uvzIqfvElnbi+KS00ZNu5TkJUcZV5kj95hP9XMOyYkHF9CvBaQPYCmAv1d9f
         OzXNITC7updAKkgdqdTtONMXFhuLjwV7b/Ve/LGf6RhmO6ga4EmzpHr9yYdBEEQrVsG9
         CuuwYjH8AyiSqZNntXaV98trHEo/wSq6H4HT8uJF993lf+e4hrgh6f2mZYoAbs/xu7kj
         LjQx5wlePxd2oV0pOQ2lXlwwSqDJnXJReVYbB165Mud/rEVSr9oYVgfYxEEj5xpMuqMj
         RUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752049761; x=1752654561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bi/l3ud7Bd1Vu8GC02tc5orfdCo7D2QgRurFTd5r8ic=;
        b=Wph2yhYnfo0tp6Ivm7Y+z2EHh4g9as69ihsccmE5cZf1mweTtxHvvvtvva3P1X1+Tm
         7XdbnPZ4rH34ipJ8Okt3sObzQwnOv2z7w9vLdRESPlzlWF1P4owmtzIp0wGMpTCJV6GE
         SS+L9gwWBWeScwPeWCP4TUItuBsZ72xfYVOUXotxD7hXPkSTZ+9FpLY0Nvv9hfwJSAIY
         rEgptKV+n58Uuiq0e3dbgvIflIS4d7OWxqVSH9KuEHd0a6gS2hllOLEyPU19QkOu5aV9
         sIz9c3SmNX2rO9M4ApVogYz825NXs9rjrX/QjMMB+k/5MCvFh+yua1zE4y3+UHwZ/1gU
         2Iyw==
X-Forwarded-Encrypted: i=1; AJvYcCVZktSYw8zVXm9BwB6XPc+ymNdfbWJAiM8eHIbzBSCioEc2F1VbK98eWfod1cDKbA/BPUA8VR58kcsub8g=@vger.kernel.org, AJvYcCXYRVVITqqdNh2oqiwCuTls3ITQqTKPNvUMnSd6Zdj4XAhaw8GPiXYBSbzN5i0iEt86AAki7cdllQCh@vger.kernel.org
X-Gm-Message-State: AOJu0YxNW0p06GURSnWjs6VeDW/tnZ0wpHtC7HlawffPSSHJisFLgpl2
	1Iv/0Op7CfpuClfhu4RcN4hwKdGJoNFAsJw53oLuDNgw5DPta5BdpMpa
X-Gm-Gg: ASbGncurB2VgjqlS76z5Jwe1PxVRZ86ZioYWvJuI23TOb5E0xqb1PziZm89IkMc161k
	WqEv4k/YcaEfAgWn0wq2xrhIuzKc/Y8twXDWL6MYst3Q7oGkqQY6kzt+gdO5Xf/4FtwsKkMlpIn
	2rYWgm4HHwwsOv5FZrzjflJyVU0WRX4aQuTkJN/JS9EYONjhXO+/6QNs+246ceGt7hag1He0Pon
	Qlg0zlTC2UIzKHNUYqGeintXYUy5JkxpKgzallIe1UTzHnvpwhB+3FLORpEel/gxhUkFPgarNcB
	6Tj/wdMmh/eaoYwWcaz0SyyGASzUbPDPCMr+iTVlyTvXUQoejZVugObUBYrZJSRni7Ibt8aH5pK
	TS5WTlEPMkg==
X-Google-Smtp-Source: AGHT+IG7Froez94aK00sHDKtRfqK1t5pvOLh2GahZldwvh4yUsreoBwkPjrJr30QJyEe79WxSjfLsA==
X-Received: by 2002:a17:907:3c88:b0:ae3:ee3a:56ee with SMTP id a640c23a62f3a-ae6d1266a1bmr156027366b.3.1752049760977;
        Wed, 09 Jul 2025 01:29:20 -0700 (PDT)
Received: from [192.168.5.87] ([92.120.5.6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f692d101sm1073719866b.54.2025.07.09.01.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 01:29:20 -0700 (PDT)
Message-ID: <907a40d6-7d55-4bdf-b16b-01c71b5f4104@gmail.com>
Date: Wed, 9 Jul 2025 11:29:16 +0300
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
 <a1b6039e-7020-4d17-8186-d40ac17ba730@gmail.com>
 <xo56zato6pgqqttdriskfgh4kdt2g6q5eg5jxte56uddkdfr63@sa7coeifbsmy>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <xo56zato6pgqqttdriskfgh4kdt2g6q5eg5jxte56uddkdfr63@sa7coeifbsmy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/9/2025 9:05 AM, Uwe Kleine-König wrote:
> Hello Laurentiu,
>
> On Wed, Jul 02, 2025 at 11:31:28AM +0300, Laurentiu Mihalcea wrote:
>> On 7/2/2025 8:51 AM, Uwe Kleine-König wrote:
>>> On Tue, Jul 01, 2025 at 06:01:47PM -0400, Laurentiu Mihalcea wrote:
>>>> +		 * MOD will NOT reset the value of the TPM counter.
>>>> +		 *
>>>> +		 * Therefore, if CNT.COUNT > MOD.MOD, the counter will reset
>>>> +		 * after UINT32_MAX - CNT.COUNT + MOD.MOD cycles, which is
>>>> +		 * incorrect.
>>>> +		 *
>>>> +		 * To avoid this, we need to force a reset of the
>>>> +		 * counter before writing the new MOD value.
>>>> +		 */
>>> Without the reference manual at hand or a deeper understanding of the
>>> hardware this isn't understandable. What is MOD? What is CMOD?
>> so, MOD is the reference value for the counter. The counter needs to
>> count until this value is reached, at which point the counter value
>> gets reset to 0 and the output signal is driven HIGH or LOW (depends
>> on the configured polarity). This value is used to define the period
>> of the PWM.
>>
>> CMOD, on the other hand, is a clocking-related configuration option.
>> I'd say what we're most interested in here is the fact that if CMOD is
>> 0 then the counter will be disabled. Otherwise, it will be enabled.
> JFTR: I marked your patch as "changes requested" now in patchwork and my
> inbox and expect an updated patch, but without holding my breath :-)

Sorry for the long delay! Got this on my TODO list. Busy week :(


Thanks,
Laurentiu

