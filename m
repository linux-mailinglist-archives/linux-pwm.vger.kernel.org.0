Return-Path: <linux-pwm+bounces-8112-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKTWAcOkjGlhrwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8112-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Feb 2026 16:48:19 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FF9125D65
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Feb 2026 16:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D28123002A06
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Feb 2026 15:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F91A2C237F;
	Wed, 11 Feb 2026 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJS8JYoN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27A3273D77
	for <linux-pwm@vger.kernel.org>; Wed, 11 Feb 2026 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770824861; cv=none; b=nxu3Kt8TGGa+WoY9YWepMQVFYPCrpFnYDorwyw7mQjUMic5iLYlIUK9bCxt3qJOPDVmoo7aBeDX/vJAro6Mb8feErgu+f0HPA/GXWKzgSRut0pB50kyFwIuTX5np8MxXDDySk0ULTJg2HilfVnMnItP3XIMos2jCoEqHAA21FT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770824861; c=relaxed/simple;
	bh=jaPtLpxoLQMf9lhHA8QnvCT2dM1u6RhVaQWKr8jWatI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OcQeCzUJDuhxmemesQf2ri76IVf0RXwYRV2LD0X9qHkKKqo9U6m3jkoRlIcrkPymu9Aid+1ciCxJ6+OqtCthfY25s3YKBriCoIRpq5jEuCX3iHu5khUQ8/FSLbNq+9POrmapXTUWivtiIOjCdJwDgdNfh3MqrwI7J4INKXpAPgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJS8JYoN; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-124a95e592fso2941924c88.0
        for <linux-pwm@vger.kernel.org>; Wed, 11 Feb 2026 07:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770824859; x=1771429659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KlFHu80yx1UAJ8ZWXa9GNpflS81fuBvY+gQcHfmBFoY=;
        b=aJS8JYoNU0r2mPqFY6ttFz6cqX1k1LvtvJkrxyZ/Q7HRCzb6+KzwBkubt433+7WRok
         Swyo69ELY6/b2YC/UmZ5jdzUJZMD2kFWG5PoCjf/vGBWz/2JErHG616GKWNjMjNTU19q
         tJDZD+s4NCfplw/vNxzsSDYGgxo1IP6tJj8j1QgZ/lIxZ1AwicgWy5ViSPLU4/NpsqCh
         kS41cPlxj+Yv5cU6uGU8W4FFGCaV759puMULUmXL11Mh4uGFj9CeIdrtbJ4YrmM+T+lK
         OlOSXt2cD3hiN7363urIN31UM7uOtNysNv7c2MKUO9jzVDJyHHSUy215DVhoM8wrEK4v
         ui0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770824859; x=1771429659;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlFHu80yx1UAJ8ZWXa9GNpflS81fuBvY+gQcHfmBFoY=;
        b=Jjur20eUViZ4OV7XabjmN5W53mBC8j+rfqkfXn7gKRC4TtXAa/oZMCcngpoNIwtvum
         RkPaybMfFWlibER2yoT2iXVgqm8qeE5cKndCF4YV/Hz/zsDQUdmeUky413QL7EBPao0o
         4uu2Nuff6ATG8MoCWvosbMBA+rBrZ9SCX5PdfLt7nxpTL48UPLpB+bO7dIPVyx0112b9
         NGM/eMoj92Fpck+X4ZSOc6g+/OIcL/NvVXIJnjH062Q4pyB3RP4sdDG6RBCfUEopDASB
         Zt7rwsFHHfxZzllJE+ZdpGf0+eeHVnKY6G8lP8BuLDYwHiruxtJXMCJSpaCWyISWKWSu
         OSTA==
X-Forwarded-Encrypted: i=1; AJvYcCX05JIWfhiXyXH25SvxvpMF1YErFLcJJ5rFkwl4tyOs/5QbMPRKP8rB2XUToIl+X+nUrhfGU+B8QU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfGectJhY2GRNaM/js/UMcYkkuxHITbKDMjC7T702F6mRzGMFw
	HZ8hURewXUVhI2sMT0ba7U6IIkUjSdf3EF9ki9r0TyDfrKYddXdfAaTY
X-Gm-Gg: AZuq6aIpcv3AMitwM5EYPmyKwYAuZMNUwmBa5XlLS3AQpGIMlW193N0jW+NQAtSnWb8
	3kHV/lmpmdvFzU6ndn0NYcJ+c1qDy7zgU9r9cDVN67T2OEJEsJ41vkm8Wv2A3PfAyig+bWyaEgI
	15xdoNzl1hbyIgUS59Hj6D+ih0Q4b8wEw49es2YSU7dPKmroKcT0nuY/BL3IPUu5/m0vkyKwSqD
	sm6oe1aey0jt2Img+nIsk3rNEhDIysGdXnhiVjGnVhUGQEs0zLTv1HYUYUoR4InGCvGyHF06imu
	GD++ALsFFNvDVlU5ytiNi0tIJyd8vFYerIoBzyTc/RyzU5vrrmFDRrk44MbG260Q0/glOJ6oiEk
	Hz9cBqIIlqGELXIi0ePcG+dlWfugHJ7jT2MJuKeOuMsU7KkmrOFEbaDAo1Zckzn/Xh/O8upd/aV
	o1zT0ZHa5PaOe5bLsRfm0D3mvRhn5BpehZDGpZl4oymo/E0XtTL0xcV0Op1MJbVQPfuv6mO8vz
X-Received: by 2002:a05:7022:101:b0:121:dea2:d54d with SMTP id a92af1059eb24-1272a78ba3dmr1125645c88.20.1770824858900;
        Wed, 11 Feb 2026 07:47:38 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a636095sm2349945c88.0.2026.02.11.07.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 07:47:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e5ccfd91-9c0c-45f1-bbc8-40e93bffca43@roeck-us.net>
Date: Wed, 11 Feb 2026 07:47:36 -0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PWM implementation in HWMON and backlight
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
 DRI mailing list <dri-devel@lists.freedesktop.org>, lee@kernel.org,
 danielt@kernel.org, jingoohan1@gmail.com,
 Richard Weinberger <richard.weinberger@gmail.com>
References: <CAFLxGvyhdpQMnW6VqyXjLPKyZSQvrV-+GFdUogV4JX7DiGePyg@mail.gmail.com>
 <aYxaXmguGRk1pWpT@monoceros>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <aYxaXmguGRk1pWpT@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-8112-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59FF9125D65
X-Rspamd-Action: no action


On 2/11/26 02:46, Uwe Kleine-König wrote:
> Hello Guenter,
> 
> On Wed, Feb 11, 2026 at 10:28:55AM +0100, Richard Weinberger wrote:
>> The backlight of a board I am working with is controlled via PWM.
>> Naturally, I thought this would be a straightforward task using the
>> pwm-backlight driver.
>>
>> However, the PWM in question is implemented using an NCT6106D chip.
>> The associated HWMON driver, nct6775-core.c, does not implement a
>> standard PWM device interface but rather its own custom one.
> 
> Looking around in drivers/hwmon made me a sad. There are four drivers
> that handle parsing #pwm-cells:
> 
> 	$ git grep pwm-cell drivers/hwmon/
> 	drivers/hwmon/adt7475.c:        ret = fwnode_property_get_reference_args(fwnode, "pwms", "#pwm-cells", 0, 0, &rargs);
> 	drivers/hwmon/amc6821.c:        if (of_parse_phandle_with_args(fan_np, "pwms", "#pwm-cells", 0, &args))
> 	drivers/hwmon/emc2305.c:        ret = of_parse_phandle_with_args(child, "pwms", "#pwm-cells", 0, &args);
> 	drivers/hwmon/nct7363.c:        ret = of_parse_phandle_with_args(child, "pwms", "#pwm-cells",
> 
> instead of using the pwm subsystem. Also the driver mentioned by Richard
> above has some self-made PWM handling including a set of driver specific
> sysfs files to control the PWMs. I stopped looking at the output of
> 
> 	git grep pwm drivers/hwmon/
> 
> after finding some more sad things. (My "favourite" so far was:
> 
> 	dev_dbg(dev, "chmod -w pwm%d failed\n", nr + 1);
>   

That code is from 2006. Are you serious ? Did you bother to read
the context ? Did you bother considering that this was possibly the
best means available at the time to control visibility of an
attribute file ?

If calls to sysfs_chmod_file() bother you, I would suggest to send
patches updating affected drivers and to drop the API function from
the kernel.

> .)
> 
>> I am a bit puzzled, is there a specific reason why HWMON does not
>> utilize the standard PWM framework in this case?
> 
> Yes please!
> 
> I think that the PWM waveform API that exists since v6.13-rc1 is
> flexible enough that hwmon chips should be able to both implement and
> use it properly.
> 
> Can you please make sure that the next hardware driver for a pwm capable
> chip uses a proper PWM chip? Feel free to send patch authors in my
> direction for that.
> 
> And if I'm wrong and using the pwm subsystem in these cases is a burden,
> I want to hear about that and discuss how this can be made better.
> 

For the most part the pwm implementation in hwmon chips is tied to supporting
pwm output for fans and isn't usable for anything else. This gets worse for
chips where pwm vs. voltage control on the output signal can be selected.

Unless there is an actual use case for utilizing the pwm subsystem for a
given chip, doing so would just create overhead. _If_ there is a proven
use case, I don't mind if people submit patches to add generic support
for the the pwm subsystem to such drivers. Keep in mind though that support
for the ability to switch between pwm and voltage control (as is very common
for fans) is mandatory for chips with that capability.

Talking about this specific driver, it has been in the upstream kernel since v3.10
(2013). Almost all hwmon drivers supporting pwm fan control are much older than
v6.13. While many of those would benefit from a modernization update, supporting
the pwm subsystem just because it exists would, from my perspective, be a waste
of time. I most certainly won't do it.

In my opinion calling it "sad" that drivers are not re-implemented to use a
newly available out-of-subsystem API is close to being an insult to those
who would have to do that work.

Sorry, you folks really got me on the wrong foot. If there is anything sad,
it is people complaining about 20 year old code without doing anything about
it themselves. I by now spent months if not years of my time modernizing hwmon
drivers. Did you ?

Guenter


