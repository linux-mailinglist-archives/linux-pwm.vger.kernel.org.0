Return-Path: <linux-pwm+bounces-4687-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3125FA1720C
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2025 18:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B993618833FE
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2025 17:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EEE1E3DFC;
	Mon, 20 Jan 2025 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1iviO6H5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70124182BC
	for <linux-pwm@vger.kernel.org>; Mon, 20 Jan 2025 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394638; cv=none; b=ZLqNnYK161GmbJ7JPV/A5AREqCRvqnd11yVPXQ0ZpKLBMvwKHmSMdV/cmGTZSq8FRYzREv26HFIWZTz6bf46CCKH/ByF3pQEysOIrlXrXb///FH2liPVn92+T+1ydhZJRO9qeHp0P0ulfGmJGF25rtlGbgnUhCVnMqWyJmeOXkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394638; c=relaxed/simple;
	bh=QpwTrKzQBAEvGMXPO40eDha01s8ELCbnbLBDZ4sjGdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o8eizcK0EjyMUScmOEkOUhu9mJXZmYOgMCJ+ecWzyVaH6JRT3kDx/MP+BDYNL2Hqs8sClN9p6UAw5IKJDpiqEa29WMqKMN7LXO/B9kkY+UNIgp8ll5VK1XXWr67iwRhfMipMZRFEojj6z1rORv+RcyOszuWBTip+aIF9UQdvrIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1iviO6H5; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3eb880e5ac2so2841712b6e.2
        for <linux-pwm@vger.kernel.org>; Mon, 20 Jan 2025 09:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737394635; x=1737999435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lfT4rN6OvTBsIG9x5a9+mxXs/tzHh45iRbVAfdvcFm4=;
        b=1iviO6H5QwLpL79Hxdys4VBTR/ppu9p+1kccXpmkMRA0CdxmxK2t5H7Gad7M8XqjNG
         0h4bJMuEFsSF93J7HNyuT2ouwSelRI7HxkLMnBI4cCj8DTJI3xQf3NqIyJuvDPAU/LSg
         3TvbUx/0cZURseHOmhZaD0H4CL8SsLkV5yTjzGvFa6DVb9O6jkKoawn2E+XhE+/0+O3G
         uF5G0svJm8zWRSBisTqLfaOIv/MlBzjddyCuRN9cr4BU3gRNm5xfbgUWDtVigcl8NvRm
         hfsbGrhVeAB8TJnZLOxIWynouGLdvhs0BdnWr2xdwxsKpSqQjraSfEAN6UT6PBflnHbM
         7/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737394635; x=1737999435;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lfT4rN6OvTBsIG9x5a9+mxXs/tzHh45iRbVAfdvcFm4=;
        b=a3ChZMaM/VWTIKatRpNxprVwq+Zr4DYFBOhg9nkOM0lFYY1G4KiWqgikYPUUjY/MWg
         fu+TWSuIqnC388lJ0YlXaTGPYv2EF1EobLb7QO5Nm2SpCAhQQXEXC+PwEJZp7kizsdOn
         SOw4KejXF4RuwtQ7kf0iF9SGC84f1oi4/OUeKMS/aQuTaymO1sm+/Mt+KVMtgyY8w6yl
         k+J5fJgoSYH3QnQlDw8ELxva4uNkHZDFAKkJTyblucdWQ40sq7vrfnCKFSOK989tKz2O
         0lrprBkQaPUQ3RxSil1w92lDxU+tRu0WG+ZCARwuB5Z5JwMzJKVxFK8MhtReEcDSPLN1
         aG7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4uHazV9XRO5vJQ8hRRkd5FMToW0bi/1mgcuNMIgSlUH5rDt4mx43xPbnr4Q2nMYudMKUtJ2mH20M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSKgfhuDbZrLZbIa+lwsN6ak4ZP4l/Pek2cMJpXHW1Hs+YUCfD
	9AjjoJJkbDTyv4tbHvzyO1LvJ5EoAMsmOlu6kKIuqkTpAXQUBp0P8eU4tWvMwhg=
X-Gm-Gg: ASbGnctZlmPGEE+VIbSJrOXHzyr2vM+rppLRgI6+agPCyk9I224EhNVEUyaqznKyJbq
	X6CtG6y7ZVP0qEmzr/2IHVi6H9mCD7W5alJIUQC1fsdUT60cGXpGRf3/YGjRf6RVCY9QcQYdbrq
	wQCsTeZTRxjkoUOt3XQo4O9ert6mQfUbEYgTfq/AhB7d56f7dygNv4o3n9Xn401vnFFpEkmRccd
	nRxxeYWZdBPFYaW5usVh5Kz4MeV+kDkHt+BX4SQdfbQVHFq15I1yu021On/x4a/KEncldX+pVAH
	JuU57+0PtROg1u2GHigZDO/id2lU+ow=
X-Google-Smtp-Source: AGHT+IH1nrkzxGSioxg3Pk04SSKoUCKqQj95yrTm9nW9uBQqIvSRaw18pxDZP0Ip0yKAj1frniReXA==
X-Received: by 2002:a05:6808:8515:b0:3ea:404b:34ec with SMTP id 5614622812f47-3f19fdd1e61mr7056489b6e.28.1737394635489;
        Mon, 20 Jan 2025 09:37:15 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f19da85a80sm2498563b6e.28.2025.01.20.09.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 09:37:13 -0800 (PST)
Message-ID: <c424cedb-5b45-43c0-897b-dec83918d658@baylibre.com>
Date: Mon, 20 Jan 2025 11:37:12 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 8/8] iio: adc: ad4851: add ad485x driver
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
 "jic23@kernel.org" <jic23@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
 <20250117130702.22588-9-antoniu.miclaus@analog.com>
 <d4b9d6e9-745c-4c35-a62d-18e0a36f30c4@baylibre.com>
 <BN6PR03MB33953EC70A02D0031373C2BD9BE72@BN6PR03MB3395.namprd03.prod.outlook.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <BN6PR03MB33953EC70A02D0031373C2BD9BE72@BN6PR03MB3395.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/20/25 6:37 AM, Miclaus, Antoniu wrote:
>>> +		}
>>> +		channels++;
>>> +
>>> +		st->bipolar_ch[reg] = fwnode_property_read_bool(child,
>> "bipolar");
>>> +
>>> +		if (st->bipolar_ch[reg]) {
>>> +			channels->scan_type.sign = 's';
>>> +		} else {
>>> +			ret = regmap_write(st->regmap,
>> AD4851_REG_CHX_SOFTSPAN(reg),
>>> +					   AD4851_SOFTSPAN_0V_40V);
>>> +			if (ret)
>>> +				return ret;
>>> +		}
>>> +	}
>>> +
>>> +	*ad4851_channels = channels;
>>
>> At this point, channels is pointing to memory we didn't allocate (because of
>> channels++). As in the previous review, I suggest we just get rid of the output
>> parameter since indio_dev->channels already has the correct pointer.
>>
>> It's less chance for mistakes like this and avoids needing to provide an unused
>> arg in ad4857_parse_channels().
> 
> Hmm, how can I then do the assignments in `ad4858_parse_channels` ?
> 
> drivers/iio/adc/ad4851.c:1055:42: error: assignment of member ‘has_ext_scan_type’ in read-only object
>  1055 |   indio_dev->channels->has_ext_scan_type = 1;
>       |                                          ^
> drivers/iio/adc/ad4851.c:1057:39: error: assignment of member ‘ext_scan_type’ in read-only object
>  1057 |    indio_dev->channels->ext_scan_type = ad4851_scan_type_20_b;
>       |                                       ^
> drivers/iio/adc/ad4851.c:1058:43: error: assignment of member ‘num_ext_scan_type’ in read-only object
>  1058 |    indio_dev->channels->num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_b);
>       |                                           ^
> drivers/iio/adc/ad4851.c:1061:39: error: assignment of member ‘ext_scan_type’ in read-only object
>  1061 |    indio_dev->channels->ext_scan_type = ad4851_scan_type_20_u;
>       |                                       ^
> drivers/iio/adc/ad4851.c:1062:43: error: assignment of member ‘num_ext_scan_type’ in read-only object
>  1062 |    indio_dev->channels->num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_u);
>       |                                           ^

I would be tempted to just not have a second loop of

	device_for_each_child_node_scoped(dev, child)

in ad4858_parse_channels() and instead do everything in ad4851_parse_channels()
and just pass a boolean parameter to conditionally handle the difference
between the two types of chips.

Or you use a cast to remove the const qualifier.

	ad4851_channels = (struct iio_chan_spec *)indio_dev->channels;

