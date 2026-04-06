Return-Path: <linux-pwm+bounces-8494-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNgjFg3L02nomAcAu9opvQ
	(envelope-from <linux-pwm+bounces-8494-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 17:02:37 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A885F3A47A9
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 17:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F5023004636
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Apr 2026 15:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B423859CD;
	Mon,  6 Apr 2026 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="crzihiZK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D6022D7B5
	for <linux-pwm@vger.kernel.org>; Mon,  6 Apr 2026 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775487754; cv=none; b=f5UZSlBOh6z/AWXV3kE8lTf2GtbvdqZb+K0KeUtRKTE/L6iwzVpKerH79SeeK5PhoE5feVOOp+eD+JKJabVRFbXqXYrN12lfz9g9tJQ9UAGdKB9GpSPGXCIBf1sc8XkJWFcqp4ro4A8kCtZwIVqhLcT/Fpd/23mgzoUnfCXHvoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775487754; c=relaxed/simple;
	bh=Vx0S0OEPsMTxWc2pbFyYxITTLhXEIs8IJVVZZBki8hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEoMAOPIqHixODq7ZZ7CPEAapOtk0lQNk39Q5Y97GzW/raaAFR+sbMJ3PRJomqUzW/25fqKhRIyBupHbpXT/7jIteV6nmep6tmwwOIw6+fIV4JNDDADcwl0IOCDj9DZms218HRSfntr9BeOWFfHoJJhy9D3UJO70CoeafNfjciU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=crzihiZK; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-67f9209185dso2148263eaf.2
        for <linux-pwm@vger.kernel.org>; Mon, 06 Apr 2026 08:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775487751; x=1776092551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zOYm5VbuAYu3Ygkfd4vye3tA8nAqOV5PzA2/v5FO7a0=;
        b=crzihiZK3iznSPHdTQNFCTyY9tRwubZfyHEDspKG2XK2CWhL5Yqbd+Fmg/GdZGmMK4
         uFtPptj5BZY8Jq2do2wLwLQAdNRr3wePMLbJoMzXTwfRVUUJ7m3YRACdiJ8A7WQH5cG+
         L4wnVXckvLC/av90wdZ6+L+ItetoVONB2UbRlH+YYsSYvJgFyc5FwiJGYERwGKqYqOw6
         HqEg7pQckRKHVKVIGKAnVO4AzWTD3mylSaPKk0rlmwEs5QfeH84KW0jywgWxIJpY/p+s
         8DC+UNxI3ko2UftMUYUaRNWTjdeXMTxD+A1m4+LtagnAOZqq5oHVloCKwyfqcTPhgvMg
         4nPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775487751; x=1776092551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOYm5VbuAYu3Ygkfd4vye3tA8nAqOV5PzA2/v5FO7a0=;
        b=WyqZixaXoflXKl0+X0px7LRT2ezDgv+mKut4yqV6LNf9UM+uFmRIGEAkdi/t0qn8Tz
         RnRMpAOnriIDUrZVy+x0FSRkcW0LiJPznfRzAZnYZOmxt9L/RWLbzcK8BYbx2+SW3zWi
         SaOG1o4qgL2YJis/5HWpR/ra5oLtUbBR5X/6j5hw4JZxUQMPYuDVaR3IbWSP4rtvpUaN
         BTPjjId9tCo/MsWXfttIA1U+I3rKPyJGuWCy4XAoBdJFt0Zq9m/nFgIXbKS693rFspby
         sEgZMcmzjS0Uj2w/60/q0Y1oqiyJRavDuv89XydOnbwbkUZ9LmOVp6DHq9BqnTT/aHXG
         xuOg==
X-Forwarded-Encrypted: i=1; AJvYcCUbgqwR7/rtCOot17y9AZK8ZH3xqvJZorX86Q3ojVpI+jCD0FO/8me8F2llQuOk3mjX9mzOrHuUVPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEpItc4kpst7lk0l3t15zaOVVeMCuXuyYy9g0M/EBGXdazEpAM
	uaH3h3v0RqyArPJ5UMNZrfdfYUuM6XZkog3eaqFNGv9/Aa79oEn5PYxixbcdJueexSQ=
X-Gm-Gg: AeBDieua1rmv2MgowtU6axF5eX8Eq7bQLjTec0WEH/t7OGfl06aJL5zo1jBNvrywdRN
	xLQKx1rQUqI0eRo3CUhrPWJleFVncPfh9YLL5EIlJHmHnvIOjiJX6dhgydhi8KuwjxeRKBG3gjv
	pnwWU1DcvofrW6yFblkRdPnr4u7YnmqTVG/vI1tnZB+fqJILWNFnrG6sOGp6jURDOIH7xgZED7p
	TBoVSSTksszh6UWJSSoLCEzbTxFbPZGhe0q7NitqICdxI3H9JBzcJVsTrIJ5UFXBvIkp9+srV8s
	RyOSgoXf5QWnqzMn793xcy39/j5wV1i2cT5jAZWdwLkfHGv9jzzSOt6/Yc0deK5xabERCuiOSc+
	DACJ1VofEFfV6NbNFD49ETFaiqb9MvuwnY8SLjajyXXzBcFBJgCqxw7bSHDqdGmfF+ba4WJsgMl
	DC+ue9ibEbg3Mn1JK5kchBIY87svae2iW6o6p3wsGw9TpSo7eLqZLxJQ4FRxARaMHDJzDDXLM=
X-Received: by 2002:a05:6820:2905:b0:682:ecb8:c38 with SMTP id 006d021491bc7-682ecb811c6mr6352466eaf.42.1775487751272;
        Mon, 06 Apr 2026 08:02:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:90d7:b13f:c53:8ca3? ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68448c1c15dsm3873975eaf.0.2026.04.06.08.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 08:02:30 -0700 (PDT)
Message-ID: <b2d4ae51-f827-44d0-94a6-2a3db6d681d9@baylibre.com>
Date: Mon, 6 Apr 2026 10:02:29 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] iio: adc: ad4691: add SPI offload support
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com>
 <20260403-ad4692-multichannel-sar-adc-driver-v6-4-fa2a01a57c4e@analog.com>
 <1d0d41c8-7867-4459-a91a-a2c6774b1885@baylibre.com>
 <LV9PR03MB84145906CC191F6AB8D2D3DAF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
 <420dba4a-0c31-47bc-b84a-5d29702b115e@baylibre.com>
 <LV9PR03MB8414CB15DEC3EBBDB8F5FDD0F75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB8414CB15DEC3EBBDB8F5FDD0F75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8494-lists,linux-pwm=lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	RCPT_COUNT_TWELVE(0.00)[23];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,209.85.161.52:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A885F3A47A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/26 9:16 AM, Sabau, Radu bogdan wrote:
> 
> 
>> -----Original Message-----
>> From: David Lechner <dlechner@baylibre.com>
>> Sent: Monday, April 6, 2026 4:44 PM
> 
> ...
> 
>>>
>>> This is bad documentation on my part. "channel byte" isn't used anymore,
>>> this is previous version behaviour. Right now, only 16-bits worth of actual
>>> channel data are used.
>>>
>> Then why do we need the shift if there is no other data? Can't we rework
>> the SPI message so that there is no shift?
> 
> I thought the shift is needed since DMA size is 32 bits, and value comes on the
> upper word 16 bits, not on the lower ones as for CNV Burst.

That should only happen if we are reading 32-bits instead of 16 bits.
We should be able to set up the SPI xfers so that we only read 16 bits.

> 
> Manual Mode layout: TX [CMD_HI CMD_LO DUMMY DUMMY], RX [DATA_HI DATA_LO DUMMY DUMMY]

> CNV Burst layout: TX [REG_HI REG_LO DUMMY DUMMY], RX [DUMMY DUMMY DATA_HI DATA_LO]

This can be split in two xfers.

CNV Burst layout:
	TX [REG_HI REG_LO]
	RX [DATA_HI DATA_LO]

And we could even set bits_per_word to 16 so that the data is CPU
endian instead of big endian when doing SPI offloading.


