Return-Path: <linux-pwm+bounces-8278-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFCQOXUouGnhZgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8278-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 16:57:41 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A1129CD9F
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 16:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D9EF30247C3
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 15:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC73E3B636D;
	Mon, 16 Mar 2026 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DsgGvvyP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2306C3B5856
	for <linux-pwm@vger.kernel.org>; Mon, 16 Mar 2026 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676296; cv=none; b=evmZh4L84zRZDLhO0r70WWAJdv3Czp1MfoVemCPluHTUZm6p+1h/DW3GlTQw9pW+qMnrFLS/Y8TovzmycnepCptJyXjgzs8Di88/JOQxEffVwRWucK1t3gwey1VJjapfEYK/z4Ic+N/8PX7RyuOYby7fpFSPJtX6iwpv/dmJOVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676296; c=relaxed/simple;
	bh=WmA/mQ/FtUJiMLUjvX4M1ZltuhP28hpRwCRYbc+ykds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lh8yxCvDYh8eUxCzdRm4udtOXxKrjtss5dkwnC7ipK+15Bzr9uR0143hX28duh9+qm3qnVNdczPGxHyJiOrFZeZWvv51ZEIPwGSVyEupNe0uQl2TWddtRVl+S9UGlFPBcWXAkJ1TCBtrYZTYA0Kr+6lkrB1WaSMRd+Z5dlhOf4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DsgGvvyP; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d743ba241aso2487955a34.1
        for <linux-pwm@vger.kernel.org>; Mon, 16 Mar 2026 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773676290; x=1774281090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wrf1e/4chWRk/7lC1qMCkY49QaRNAQGjpYanWNmT+Gk=;
        b=DsgGvvyP0BPT7s5GssDXAFdQW1cm0KNby50MIvMCdKos2Gi0CeosXJfOmkJjbcil+d
         BmYU0V2BVHRzubOzfARESvbziCDmBSlR8Iz2K1965iOgIb3fQYbb3KSDwsV+z2cmmx9j
         s6/FpEGOj2mjOVzUb/01+p+RRZYGZGUI52Y4mBKrBmilBPguosVN2d5XCFxyE7JFI2Qw
         K7396MkB9XBEsM1Sh9vgdXuZgThBh+QTSydul1cKWiR98FQdvHOM0My4szs/jds4yUcA
         R8K3wWlFgTEC/3yXmjyLKdVH63G/j+0JtyJHvY0TfTo8nYbCV8lZ6ggeHRGlMXzyH7yd
         M6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773676290; x=1774281090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wrf1e/4chWRk/7lC1qMCkY49QaRNAQGjpYanWNmT+Gk=;
        b=qMSP1gsjeeYDmbF6Mbkh9vNQrHYT+aQLvul5ezFbmdbWQ2ItXSl8D3WlgDZsB+M7vp
         K9VH0oeA1hMO2mFOWZI8KQP57x7FppUvYUOBAbhe8EvoPVG2CfaABYpDYn0iBlx9GocP
         MFriAiViAGPp16kkdrFlrrfd5xwN/xsvAB34VObmLcTGLIsJwcx+ZOZ8n29kIeljqyri
         ZF6OrohtcsnkZFI4J2HBuhsi2IlJYyn4iosqToIZ8rAJxtI9wjoercEcRhezv6iKhMDf
         jJlmzP1wacJUamEdqobxHy4kZMhnr4vT0r3UU0Zez7siri6eJt2j5bbR33HBn0G7Pfr4
         42Sw==
X-Forwarded-Encrypted: i=1; AJvYcCV/omMKvY0PhMbY3yqrZR34yTXYphk5Q0Lc4sO4ABjFshg3fa9tA7JO/Y9KgfTMAZEW/du++D7aZAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYS+eRgKh08HRLOA0sJTo/Q7dA/SyN3Ej3rQbrKJcCLMHD01FG
	otiVOoVru0bcw5tkR4jFo6sHFmWogbTH3RBe4F2qpbg/NHhinrJuDZEruMydMhtQn2w=
X-Gm-Gg: ATEYQzw3jV0fMmo09GEBtI6UV8xsJSnP6e0nvaRbC5NknzdGRXz74N9WjTJ0VhgOpvx
	fRyT+fjzOAumFGlL1tApDpu0agt8vgl1iHws/P4rl6Hw71yv+f0R7U8HelY3vL0jX6Q/wzQkeY6
	8KhW0Bw3nfLhIHVHqvZdCPqd27yzudSlkvuo6Q5tt94V3VMoq43ZcYhk503DqFb0qDvIDDg5gkn
	wrk5EWLsEq8qtYZ3Zdq+116S0VdOMmohI9zM5+fNqv8o48R1tgZl3lk1OPWI5Tos+I77nzJiH/O
	Ai7BG1zXk3UYloJcA0ynR4PdLfQ1f9KP7r82x7xiE00uog9mrRr3m2EEc+o7IRCxQbEHhTFAhbi
	+zYmKoS4d/CigBRAoMEfgUoir22wcV4YdUAKQaZ/EFSlE1mGIbpBHO3A8cpIgnKOyElZYBXtY4e
	GxzM+ySX86Ym4HWyjZYgQLgEWLUB1fkXqi9Kqk0z9rJ+50zdLYOBzwW8Fi10/s6sUl9PtxQjfyB
	w==
X-Received: by 2002:a05:6830:67ca:b0:7d7:b85f:36c6 with SMTP id 46e09a7af769-7d7b85f3daamr721606a34.28.1773676289823;
        Mon, 16 Mar 2026 08:51:29 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e504:a034:1152:a664? ([2600:8803:e7e4:500:e504:a034:1152:a664])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aeccd73sm12749664a34.27.2026.03.16.08.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 08:51:29 -0700 (PDT)
Message-ID: <e33b0096-c7b6-45e5-a9d1-8da11714ac8e@baylibre.com>
Date: Mon, 16 Mar 2026 10:51:28 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-2-b4d14d81a181@analog.com>
 <abPtv0Y_QWYoMuAO@ashevche-desk.local>
 <LV9PR03MB84148A9A0A7F6544CF370B7DF740A@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB84148A9A0A7F6544CF370B7DF740A@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[baylibre.com];
	TAGGED_FROM(0.00)[bounces-8278-lists,linux-pwm=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre-com.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre.com:mid,intel.com:email,analog.com:email]
X-Rspamd-Queue-Id: 50A1129CD9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 10:29 AM, Sabau, Radu bogdan wrote:
> 
> 
>> -----Original Message-----
>> From: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Sent: Friday, March 13, 2026 12:58 PM
>> To: Sabau, Radu bogdan <Radu.Sabau@analog.com>
>>
>>> +	u32 acc_mask[2] = { mask & 0xFF, mask >> 8 };
>>
>> This looks quite wrong. Is it for sure like two 32-bit stances per each mask
>> byte? If not, this should be __le16 acc_mask = cpu_to_le16(~BIT(...));
>>
> 
> Hi Andy,
> 
> Each acc_mask has its own register, therefore the u32 acc_mask[2] is
> intentional - since the regmap is configured with val_bits=32 - the 4-byte
> stride matches what regmap reads. However, I understand how this
> can be confusing for anyone reading the code, therefore I propose
> two ways for this :
> 
> 1. Keep regmap_bulk_write and add a comment above acc_mask explaining
> why u32 is used, although these register values are 8 bits.
> 2. Switch to regmap_multi_reg_write, which takes explicit (reg, value) pairs
> and sidesteps the ambiguity entirely.
> 
> Do you have a preference?

Since we already have a custom read/write functions to handle different
register sizes and the chip can read more than one consecutive register
at once, can we just call this a single register and add a special case
to ad4691_reg_read/write() to handle it? Then we can just do a regular
regmap_read/write() functions to access it as a single 16-bit value.


