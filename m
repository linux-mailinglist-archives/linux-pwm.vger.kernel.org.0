Return-Path: <linux-pwm+bounces-3958-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFE09B4E00
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Oct 2024 16:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1FE1F2170B
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Oct 2024 15:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244BF19415D;
	Tue, 29 Oct 2024 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z6cIzhPE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CE5191F7C
	for <linux-pwm@vger.kernel.org>; Tue, 29 Oct 2024 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215852; cv=none; b=oUbsZk0IX5tr6cmFFIulKYsX/6SVvifRrIeYecdNiVFUezPu7667HU3HiyU/8/M5TXXj0dtBsRRPfwJuimDJA+GI1cEZczlK1hA1Ay+NA0Cfw1MsMNTeHmDfR+RS4rrZNIXDzrRnkpRlqhghmRnlGgTe5QiQFrWr90DnBzogGy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215852; c=relaxed/simple;
	bh=C2Bf/CpiazCRHi+JMjkoraHCMogNvMrpX8KWNoU7cSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E7uFnKia/ehbAtHEtIYSMn+lVNyuJb16pM3VfajQd1bpPGV1ub8ViU8FppFCIOgrHw5B7HoF6N7a8nP2F9t8JdVqjrTdvrYSZ0KTrIB/YndWooYx4evcg/TuDDPoE0k3ICMAo1MdAhgmUHSdfewkwjZpWQSi9Nn8UuvguyXBxNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z6cIzhPE; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e6005781c0so2983452b6e.3
        for <linux-pwm@vger.kernel.org>; Tue, 29 Oct 2024 08:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730215849; x=1730820649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n6oLt4cwqIvtLgDoKzl4RIUjXVN/+Dx6j96wTlFjHfs=;
        b=z6cIzhPEa1IGJh40CFi+FEMWamYrZIx08dC+vmYjtQCDOxvW364Gclqd78i3pcDygY
         XrJGjkkYmldK/lyBICRa0H8sSFN2kihL8XYLFJm7qte+ktQQldASeI39x93WHJ55EP2z
         0InmLEndWN6PjlmGFTImRaDr9PYRIsP9doGC/gQY6uqschjpZl6m652tdNgvG5q67Zjc
         pqNXnCvtIEwibGgpAPtu44nHhaigJfiUMO7pp8OKTfhSrw2fEztFj+hLsfnai6gnZvz8
         VTqqsN94QhMtfsTDfiDemVi8Ot1L8XFgpwhg4ro7rOdfdrk64tWThk79aEBxDe8cb703
         24kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730215849; x=1730820649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6oLt4cwqIvtLgDoKzl4RIUjXVN/+Dx6j96wTlFjHfs=;
        b=hVgUxMDmlp3BkYVwppaMzQettjrHTenzKWdQVMLI7zPwB2cisWbq8vln7vyutu8iQ+
         5yuOQtA/qpPESFig67e4E5f/admUDryaC7fOdTO1cxD8rP0SZclmnTJ6e4jR0mpeTYu2
         gkkCZlE3NiJCM73q1SdOlLB49Az6kOkZmt6SRcjkTYzM2QCYOTmirWwpZz09unElOdyK
         EiTxZ0uj/DgbsfmNfwzGFnpQgmqXbfdIovma0v5fYeUQb7h9oe6E4pveM5/KxxFT/dse
         gffkeRUcyFBUkyNi7kUjyayg7UtPCJ+o0IBl7cljCJcLoeixARLHE+eqgw/GO3aB1bFs
         byoA==
X-Forwarded-Encrypted: i=1; AJvYcCVT1RPBElDW+O1NqpR/iSK3sY7BvlgW20S03V6Vo+g8jMMvd16HgNmDEUBfGG4ljrwr/uMopcLwN/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym8kaiIOJmu4qanle5kGNIdyjFVBQ5A8qkAxLlxsuZZS8REEJl
	4ulsEY+KDELLUQ9Mz0mxeBEANlZh9ue5ivONXq6bmGjgTN2ULsrDt07rHxbAcyI=
X-Google-Smtp-Source: AGHT+IE2SkDygBFnyOcXc/xSl2iBsuYxGCBH6q3GOhnV+kWltCIyrT3d5jLZv9ddzix44MMFYznHAA==
X-Received: by 2002:a05:6871:69f:b0:288:34aa:20a3 with SMTP id 586e51a60fabf-294649be62amr49618fac.45.1730215847206;
        Tue, 29 Oct 2024 08:30:47 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-290360f4540sm2856004fac.31.2024.10.29.08.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 08:30:45 -0700 (PDT)
Message-ID: <82edfbb9-5e65-4292-b15b-d5cde7b53e42@baylibre.com>
Date: Tue, 29 Oct 2024 10:30:43 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 01/15] pwm: core: export pwm_get_state_hw()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Guillaume Stols <gstols@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
 <20241023-dlech-mainline-spi-engine-offload-2-v4-1-f8125b99f5a1@baylibre.com>
 <mavlxxjza7ud7ylgoewz6fz3chtuwljvcjjf6o3kcv555iolwa@wdnrsiow5u5w>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <mavlxxjza7ud7ylgoewz6fz3chtuwljvcjjf6o3kcv555iolwa@wdnrsiow5u5w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/29/24 3:05 AM, Uwe Kleine-König wrote:
> Hello David,
> 
> On Wed, Oct 23, 2024 at 03:59:08PM -0500, David Lechner wrote:
>> Export the pwm_get_state_hw() function. This is useful in cases where
>> we want to know what the hardware is actually doing, rather than what
>> what we requested it should do.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>
>> v4 changes: new patch in v4
>>
>> And FYI for Uwe and Jonathan, there are a couple of other series
>> introducing PWM conversion triggers that could make use of this
>> so that the sampling_frequency attribute can return the actual rate
>> rather than the requested rate.
>>
>> Already applied:
>> https://lore.kernel.org/linux-iio/20241015-ad7606_add_iio_backend_support-v5-4-654faf1ae08c@baylibre.com/
>>
>> Under review:
>> https://lore.kernel.org/linux-iio/aea7f92b-3d12-4ced-b1c8-90bcf1d992d3@baylibre.com/T/#m1377d5acd7e996acd1f59038bdd09f0742d3ac35
>> ---
>>  drivers/pwm/core.c  | 55 +++++++++++++++++++++++++++++++++++++----------------
>>  include/linux/pwm.h |  1 +
>>  2 files changed, 40 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>> index 634be56e204b..a214d0165d09 100644
>> --- a/drivers/pwm/core.c
>> +++ b/drivers/pwm/core.c
>> @@ -718,7 +718,7 @@ int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state)
>>  }
>>  EXPORT_SYMBOL_GPL(pwm_apply_atomic);
>>  
>> -static int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
>> +static int __pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
>>  {
>>  	struct pwm_chip *chip = pwm->chip;
>>  	const struct pwm_ops *ops = chip->ops;
>> @@ -730,29 +730,50 @@ static int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
>>  
>>  		BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
>>  
>> -		scoped_guard(pwmchip, chip) {
>> -
>> -			ret = __pwm_read_waveform(chip, pwm, &wfhw);
>> -			if (ret)
>> -				return ret;
>> +		ret = __pwm_read_waveform(chip, pwm, &wfhw);
>> +		if (ret)
>> +			return ret;
>>  
>> -			ret = __pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf);
>> -			if (ret)
>> -				return ret;
>> -		}
>> +		ret = __pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf);
>> +		if (ret)
>> +			return ret;
>>  
>>  		pwm_wf2state(&wf, state);
>>  
>>  	} else if (ops->get_state) {
>> -		scoped_guard(pwmchip, chip)
>> -			ret = ops->get_state(chip, pwm, state);
>> -
>> +		ret = ops->get_state(chip, pwm, state);
>>  		trace_pwm_get(pwm, state, ret);
>>  	}
>>  
>>  	return ret;
>>  }
> 
> I don't understand why you introduce __pwm_get_state_hw() (a variant of
> pwm_get_state_hw() that expects the caller to hold the chip lock) when the
> single caller (apart from plain pwm_get_state_hw()) could just continue
> to use pwm_get_state_hw().

Hmm... it seems like I thought there was a good reason for it at the
time, but looking at it again, I agree with your assessment.

> 
> In principle I'm open to such a patch and wonder if there is already a
> merge plan for this series. If you send a simpler patch soon with the
> same objective, I'll make sure it goes into v6.13-rc1 in the assumption
> that it's to late for the whole series to go in then. Or do you still
> target 6.13-rc1 for the spi bits? Then it would probably better to let
> this patch go in with the rest via the spi tree.

The SPI offload stuff is not likely to be merged soon. But there is
ad7606 + AXI ADC support from Guillaume that was just merged that
could make use of this. So I can send this as a stand-alone patch
so that it can be made available for that too.


