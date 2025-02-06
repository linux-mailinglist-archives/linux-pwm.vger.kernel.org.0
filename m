Return-Path: <linux-pwm+bounces-4807-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C6AA2AD9D
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Feb 2025 17:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82433A508E
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Feb 2025 16:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE4B232384;
	Thu,  6 Feb 2025 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qSAURHyB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B21D22F391
	for <linux-pwm@vger.kernel.org>; Thu,  6 Feb 2025 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858984; cv=none; b=snuYv4/wo7/GLqjdR4cmvVWBNSkcihsgdo//IE0g8fVwmKvEZhv33uJ7brTR+e5Oot2B5bPELh1RxAqA+srNFatZ8t+IqSTsHzGJYX2fShi96VW+SuFnO8Jg1bRCb2DowBIYW45vHCK26NNl2tcXbNlczWa5Wo1WGPThI04FTd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858984; c=relaxed/simple;
	bh=yQ/cMahOawtP4PxuyH9DWGJ4UyQFQnjW962HmXPyWh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ipxVLj1sRpIg9DFtQWQCO08RW1psoska3QO4ugIFhkGyt1qtn7xB+DNZHJ0kJcaG4OPqxYT/o1JAvAZU7b9QHDNpnobYVqt+soaQP/ldQavGOVEVsk80h567xA6XqxUTj1xAxPEMttqgY4FaLw/puLn1KOnrvJKgovzLIopMgFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qSAURHyB; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2a88c7fabdeso575494fac.1
        for <linux-pwm@vger.kernel.org>; Thu, 06 Feb 2025 08:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738858981; x=1739463781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cnC7VSfBG0ihPKxEu9pr9kDMCXHaSfGWdCeIs/YUaPw=;
        b=qSAURHyB0MucZBOyEyuVQmqRltfrCih2RlPxOwn+Ccknf2jFEAE58Ngyb0outSC9Xc
         gxYs5jitYNLO3Y62/z7/jEs2KgAEnlkm8yixp3TLREuWkvLO2xdeWxZ1WY2oOsHxzfsk
         9nqq5v60hQNzykMqZTpAVkY2SZnEJzw0uuWnz+UFxSYOCPW4KAm7sMoCgLkSSI9TVZFJ
         +CQMwBSNeEVeeF6H1/sYqsVkxaCzqR4s4fgiuK4jRY+3dA/VGgovuYOWSY+qnESOxFla
         +l+MdyA1YQGlYJDrWEUmb4IHqoR7irDNIYDNRXIcwXxIDBQ3cr1NwGakxMUgxrx7ae5e
         HzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738858981; x=1739463781;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnC7VSfBG0ihPKxEu9pr9kDMCXHaSfGWdCeIs/YUaPw=;
        b=JwK7bP+ltRUMC1dGQAwoWvUrQHk4/5m95Twv/D+Vf+Su6eomI8RJWLAJinlh0V81p7
         /xXxF2Ph/V83tEuZf1UMtO7RXW2lDgQksFHDKFoVxAe22Ids1osBj9cyey0dxGhBWR9P
         Sd2sek6xZk1oK+q1AQGLL2yQv4wnfT4I+3g/qH0mW1oHq4y7sKk85LYOUSwi9h3orjC+
         lMU5Vp3wd5jA29bR+rcuRe94LeTZf/31Zf1iwMkcNtQ1k//devN4NtkgnZ3sYGCn5tn4
         QtZRlsTasJdN/IwJwcGgHOK28BlkH3elUffXymeliZp3ktrKr6wiJE6BWT4eJzxcJFht
         EkdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOKzUXxQnc5vkhV8Vk/uQiVUx7bEWUQJOp/8LIiZaolp77Fb2dvyOvJ9HD45m5jD/svN+/C+wd7GM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPK+UrJs5deeo5vySqVzE6WT3ENy0/qdiCK3h/38ay7shZrdKL
	WPydRWOXJvwtuX6rzmRKUxQWABfGpZAGyCikl7177zBAW5CrKvmIcWVht8GKexc=
X-Gm-Gg: ASbGncsyQHHcDW9Pd1PcZsg5Bjb57iu0rFUvNAxfkhOqZVdeZZ4O1piY3bA/iukxo7E
	J8InFveRT+pQqoFqsLu0SlmF5eQNPAqRj6XGH8fyOO/sAV7ZSKUQnRvAZED4yqLSO3F4iVUhIgy
	hZFYW0loElWbI68uxvYu/Rv5PuyJCAe3JGOfQWbtQqPz12XCjC4v9nCEQMLcXh23i23Vpp+eEY4
	NuzdFZs8kr6Vaj6PjR0NtAm62Yz4Dqa9G4m1IGnR9kB53jqaHlAAVg5IKLcUPoBiq53lCeeeIRm
	uGQ2p6jYGnQ2MuoKLZy4FEhHOdsUZiwxFHPBLvVMNF7MUg6JSvdN
X-Google-Smtp-Source: AGHT+IGrVh/v5vcStALrqpNGUOb3jAVtv3FbIdsyoVlK6kALxIyavVWIb5C4oJiOS9AS6CkGcYPmgw==
X-Received: by 2002:a05:6870:7e07:b0:2a3:8331:717c with SMTP id 586e51a60fabf-2b804f44ca7mr5095585fac.10.1738858981173;
        Thu, 06 Feb 2025 08:23:01 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b8262622cesm348477fac.33.2025.02.06.08.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 08:23:00 -0800 (PST)
Message-ID: <b06f6457-4be3-4404-8c41-618bad0c7099@baylibre.com>
Date: Thu, 6 Feb 2025 10:22:58 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/8] iio: adc: ad4851: add ad485x driver
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
 "jic23@kernel.org" <jic23@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
References: <20250127105726.6314-1-antoniu.miclaus@analog.com>
 <20250127105726.6314-9-antoniu.miclaus@analog.com>
 <c5722215-b720-49ab-9f0e-00b01eb4679d@baylibre.com>
 <CY4PR03MB3399B389972E92742EA3060D9BF62@CY4PR03MB3399.namprd03.prod.outlook.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <CY4PR03MB3399B389972E92742EA3060D9BF62@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/25 4:00 AM, Miclaus, Antoniu wrote:
>> On 1/27/25 4:57 AM, Antoniu Miclaus wrote:
>>> Add support for the AD485X a fully buffered, 8-channel simultaneous
>>> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
>>> differential, wide common-mode range inputs.
>>>
>>> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>>> ---
>>
>> I think we have the important bits sorted now (i.e. userspace-facing stuff).
>> Just noticed a few minor things in the latest revision.
>>
>>
>>> +static int ad4851_setup(struct ad4851_state *st)
>>> +{
>>> +	unsigned int product_id;
>>> +	int ret;
>>> +
>>> +	if (st->pd_gpio) {
>>> +		/* To initiate a global reset, bring the PD pin high twice */
>>> +		gpiod_set_value(st->pd_gpio, 1);
>>> +		fsleep(1);
>>> +		gpiod_set_value(st->pd_gpio, 0);
>>> +		fsleep(1);
>>> +		gpiod_set_value(st->pd_gpio, 1);
>>> +		fsleep(1);
>>> +		gpiod_set_value(st->pd_gpio, 0);
>>> +		fsleep(1000);
>>> +	} else {
>>> +		ret = regmap_set_bits(st->regmap,
>> AD4851_REG_INTERFACE_CONFIG_A,
>>> +				      AD4851_SW_RESET);
>>> +		if (ret)
>>> +			return ret;
>>
>> Do we also need fsleep() after software reset?
> The datasheet doesn't mention any delay required after performing Software Reset.
> Should I add something just as a safety measure?

I guess it is probably OK if the datasheet doesn't say it needs a delay.

