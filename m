Return-Path: <linux-pwm+bounces-3707-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4008B9A3BB3
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 12:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3AAD1F24B25
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 10:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C222720111E;
	Fri, 18 Oct 2024 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVL7aEUo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FF1201101;
	Fri, 18 Oct 2024 10:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247810; cv=none; b=MtfwnkjJBAGUK4Cpo0PJDghHK1XhnE4TZq6OFiogtCgwWIP53OcIadc1E3MKgwHNr2AvqmKWvZ3DIug4CLo+YyzM16NN6DubSkV1gczcouIOX/thMBkdPAThAwnItQNnCPg0L0lDPyPUlRFZMQYMk+87Sx7g2NhfXgo1+i87DCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247810; c=relaxed/simple;
	bh=3EZzw0TRDpMnBBKmqDmn+ZAhs72yR1VpFFwzwVTYW9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGFJ5vhaWLz92E+/cDE3rWxOE5okQU8aj22kjzBUErI2uwqx46I22EUh2a5rg2rKPrNnx1zHbE5zDd3idZOe6tAt53nQgkgFkGHGQjF8cwIs2DChFDYmYpNRwzhgMqGqS5UGS6DoOCVnX3J3HrtZJseGme2GSEnm92LHLxwLZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVL7aEUo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ca388d242so14515165ad.2;
        Fri, 18 Oct 2024 03:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729247809; x=1729852609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9prvIfb7MzQ5XjuizNCYs8tPPvB3E6WNDXl+clYfa3A=;
        b=eVL7aEUoYx+4t4M82o/OjBwrUhqF9yYasUUw1kJFYRGdXFGJsDTCwt/goDhUWmGwI+
         83iroLLTELSyUAL245/C7woYG6r+cIndenhOjOTKG22gWFsOVEk3BMlaDkBR2I0MlItP
         T7GjRT6nHlhp5GaI/BCpp8T0maE/8ORQlGzzXZuvHLXmz80xuSNqkjLG/hSEgsayvvXW
         JXwcCKBNt17MFaTZXqApbbs15m7XNA6ZbjhUmBVKAgD1hJ5GahIsiyw8YegvLdhwL9fW
         e8qzIrQG/DnC7j16M9hECMEoViGRyfwOPrX5Aaq5mPxYOrEtz/djrUZVwTZ7IGtseqDg
         Eb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729247809; x=1729852609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9prvIfb7MzQ5XjuizNCYs8tPPvB3E6WNDXl+clYfa3A=;
        b=ZE6k30YjppVFtNpnyuNqGjuYG8LAAsxn++jCwqdYfE2ewbbrT3ZumHvH/qdsQiyJjL
         y4gTrGuyZgx/RcCC6DkPrIMjirE4x9M8iIdLbdJWAG4Ncv0N4EM+7IwoNvDbVDZY2+5j
         sEe/+ib7++2MtQM2Da4blMg8rgi8OZ70PhmAmYSu+i1Hr494yfi+ZZw058LkgWlaD2YT
         iaLve4LBkFk4rRS7kWLKuB36XG5EI7pjRC7dphAhEwoswCazjaDmiprsHTjt+GTGBImL
         iG+nhmglVY/C541fnihYIq7ZY+zUi4QlkP83eXAThdiLxAnO44SwoCHGl/jrplKFT/rO
         O1lg==
X-Forwarded-Encrypted: i=1; AJvYcCWO8xeMtE9s6RhFDPalrDnnMAe47BsCFMEhsYWI+FttAzaSy/hWg6oxKFCmHx2AZCvk4SgzXF2NgsJD@vger.kernel.org, AJvYcCWnRnPqqWq95lUmIYdO+QLYvmUDzUOT9+txdyVvGGeJcHU3x3TTW/uNjrCyKavKQ2N2CF7R5Qx4S5Of@vger.kernel.org
X-Gm-Message-State: AOJu0YzRAdAQhnSaBwAeILmKln1qkiExuJM3eMgSJ8z9Lw1w0rfRfSC7
	PPXUnhiOU4UYL4KANOOzB8uM+XtIvVLw++1fZlGxQ7LQcs5xOpf0
X-Google-Smtp-Source: AGHT+IHWlAy79f9iyox1Phf+TXG8tVB51Ogqf40BLZ8Ie4w/fLaNgnT3CULMAUfVaMlFniFwwYVskA==
X-Received: by 2002:a17:903:244a:b0:1fb:90e1:c8c5 with SMTP id d9443c01a7336-20e5a8fb2b8mr27756285ad.33.1729247808658;
        Fri, 18 Oct 2024 03:36:48 -0700 (PDT)
Received: from [172.19.1.42] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a72d5cbsm9988515ad.39.2024.10.18.03.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 03:36:48 -0700 (PDT)
Message-ID: <471d77fb-c30c-40de-b3bc-ed661a2acbd5@gmail.com>
Date: Fri, 18 Oct 2024 18:36:46 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pwm: Add Nuvoton PWM controller support
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Sean Young <sean@mess.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, ychuang3@nuvoton.com, schung@nuvoton.com
References: <20241018034857.568-1-cwweng.linux@gmail.com>
 <20241018034857.568-3-cwweng.linux@gmail.com>
 <ZxISVBz1Os0T4eqP@gofer.mess.org>
 <obu4hy7dwioinyn3npwy42lwmijd2sctdsy4b3lad3d6bfvaq5@gzbcnua3unuv>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <obu4hy7dwioinyn3npwy42lwmijd2sctdsy4b3lad3d6bfvaq5@gzbcnua3unuv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Uwe,

Thank you for your reply.


On 2024/10/18 下午 04:22, Uwe Kleine-König wrote:
> Hello Sean,
>
> On Fri, Oct 18, 2024 at 08:46:28AM +0100, Sean Young wrote:
>>> +static int nuvoton_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>> +			     const struct pwm_state *state)
>>> +{
>>> +	struct nuvoton_pwm *nvtpwm;
>>> +	unsigned int ch = pwm->hwpwm;
>>> +
>>> +	nvtpwm = to_nuvoton_pwm(chip);
>>> +	if (state->enabled) {
>>> +		u64 duty_cycles, period_cycles;
>>> +
>>> +		/* Calculate the duty and period cycles */
>>> +		duty_cycles = mul_u64_u64_div_u64(nvtpwm->clkrate,
>>> +						  state->duty_cycle, NSEC_PER_SEC);
>>> +		if (duty_cycles > 0xFFFF)
>>> +			duty_cycles = 0xFFFF;
>>> +
>>> +		period_cycles = mul_u64_u64_div_u64(nvtpwm->clkrate,
>>> +						    state->period, NSEC_PER_SEC);
>>> +		if (period_cycles > 0xFFFF)
>>> +			period_cycles = 0xFFFF;
>> If a period is not supported, return -EINVAL - maybe even do a dev_err().
>> Same for the duty cycle above. It might make sense to calculate the period
>> first, so that the error is more likely to be about the period than the
>> duty cycle.
> That's a wrong advice. Drivers are supposed to implement the highest
> period possible that is not bigger than the requested one. So clamping
> the value to 0xFFFF looks right.
Thanks for your explanation.
> However I wonder what happens in hardware if period_cycles == 0. If that
> disables the hardware that is something to catch and return an error
> for.
If period_cycles = 0, the waveform output will be always low.
>> Then again I don't know if all the drivers do this, but at least some of
>> them do.
> Yeah, and I hesitate to align them because their behaviour might be
> relied on. But for new drivers the above rule applies.
>
> (And with the new waveform stuff, consumers can rely on the rounding
> rule and even query the resulting waveform before calling the equivalent
> of pwm_apply_might_sleep().
>
>
>>> +	chip->ops = &nuvoton_pwm_ops;
>> I think you can add chip->atomic = true; here
> ack.
>
> Best regards
> Uwe

Thanks.

Chi-Wen Weng


