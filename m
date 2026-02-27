Return-Path: <linux-pwm+bounces-8170-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPgwKFxUoWk+sQQAu9opvQ
	(envelope-from <linux-pwm+bounces-8170-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Feb 2026 09:22:52 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 185401B4774
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Feb 2026 09:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 673CC3102588
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Feb 2026 08:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3726D38BF7B;
	Fri, 27 Feb 2026 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJIq7ZKu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA073806B3
	for <linux-pwm@vger.kernel.org>; Fri, 27 Feb 2026 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180226; cv=none; b=GKmJiC8RnHyw05tE27UO8kv9NpeOSMq4CYN0xvGpyUL9x/dG0MXowPfaL1U61ROLFP+LDdNaT7MRlAJ3Ju/boNPgCXKdKztQ0ODZlM6pG4vK6mawhu4xzHixnaxIvn2w3bfFJlsP1d20ZVpBJPNi6rjC/UmslUwQ+SG+zbOxwus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180226; c=relaxed/simple;
	bh=NsnXR732HR9l2oml/8CObM0jr3+sZuVFltQ6q3u+bbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pndh3CFqDCLqi0GGxkfMCI3xq7AnfytFo385Hkat6tj3cbThg9RA9caMHqxRdO6dgFUUTc4F2PsKObcuox4k8qEOhhWKU7Mozzjxfft36l9Ki7ltqE1qPIERIH6RRn00x3p9r92ArEzPJbGXTJNUj6yG9dIiMZ68Tijg/7yHAFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJIq7ZKu; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2aaf5d53eaaso12473685ad.0
        for <linux-pwm@vger.kernel.org>; Fri, 27 Feb 2026 00:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772180224; x=1772785024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LuyVLLrSQcNLZs9Zxojz4eiomlcsRYNEFiNRapTyc2o=;
        b=iJIq7ZKu2axQ58MqA3zpNuViuXI+tEu1Sp0d8U7Os3YcPfcOLtvyW/y24azzYRNVHn
         QQEKVTbwVPd45LW//WSz/iWV5LSaVmpjTXlr7USGf3k5WVx2V25g3o6GeOz1KAYHNIzW
         nKQoMz5rP5HCmf2r4JwnC4TL3XtENon8UXBvZK83V67YYgqYprrVtNUtlyHmkeOrmBWj
         OKYO7kBBuVqUaqaApCB1Tua36M4tIg/1b2n3d8e3WfNI4NWENlwYY17OEtzlfHiHwcUG
         kbX7y7zzKDlEL5cmwgBGbxhiRm9liitiP4s8x017XMXIocksp7w9jBJUGCWZQq4TS3nd
         WaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772180224; x=1772785024;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuyVLLrSQcNLZs9Zxojz4eiomlcsRYNEFiNRapTyc2o=;
        b=V4tYTfQgGVX4vI6nzkgcHshpkDtBK+YbFq94ecEmNcTQTqdExFhrckz2Tvvk2Bp0TJ
         nP8N8fcgFLOKYAKkCGOdyKATIXR2ZJ8izxcdXPJnccOzNS/06ioXilO8LJ1UAEKRkKAe
         PNxhqkvE606NGXgzteP7vijjBzzAHseoVxZDYNd5mZbHyCYo+hjo/Ju5o5i15IU7iCCZ
         nl7BbmDFXqvGIAWhHd2Dx91hye2SUZf126/LW49JbG2hvFJEo5/3KdaYpbXjxN9jvK4q
         OPPrx/2XY2nuMDSkjro01LQ7E3n/fpW33OaCCVyKr+x9dbKDWM9yUY8Vd9ZmrltsYXCY
         zghw==
X-Forwarded-Encrypted: i=1; AJvYcCVxW4zb2X6Ad1hDKQgI9Z59I/uG8VsjZIqAGe1bdbkqJb6wSRGe18/YKX64ZmIb8HwK7sGzuNxOR2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb33/HG4AXIfc2vTzONSG05DNk+Df64+Iz5wTRNGviTnXoXPIJ
	dHvZTukfAL8uazpquw/C49NI70R03Cf4j6N3yGoDJT6s1kT2B487FHYR
X-Gm-Gg: ATEYQzwL0G8/XSioyS0WKAThjmLAzNaOG2QfKM57DEepdYAqav32UBsZpxrd88THH70
	FkqIrPdVcd+ftPgS9gxN7kxYnC2vEI+S/rMJi5FZHd8RscFrHKqpBMgRS3SQZdBciEbk22JbvCU
	2Y48M2U2ad0eDYE21bu8TLjLtqcRr2JVrHkrwBfyelIMLosc+kLT/ikxUBn+7FiKFYYPOBjv3DN
	SzIHUvPJ6cdYaNf8Wvayd50uiOl4fSwsqdfCo+NqW9166mdjxuNAKnAfyIkMHqdScHRPAj/XW7R
	uc40FSwKAERp3STc6zaibyOoyyiExTGr+tEt04CKkAadYLA2jVoqJMrKm/DuXZUDWhGUMMyh0Vg
	xp/qKnMnpfdhZsygoqTmG6V7NNfJFZ+drJ9BGc6S9KA8c82NsUgRKRBrYWDZ6B5e5Z0Vf8JebAQ
	wYytER6WJ/ETS0ZPGO/QzFWxeSbba/kMG0G9pICAgDT0tNHtHOiWF35UEiA7sMEgBaXHa3/282
X-Received: by 2002:a17:902:cec2:b0:2ad:c66d:ad02 with SMTP id d9443c01a7336-2ae2e4d9735mr18263295ad.49.1772180224124;
        Fri, 27 Feb 2026 00:17:04 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c244asm55369655ad.30.2026.02.27.00.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 00:17:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <163f68da-c31b-4ee6-a187-a81d14202311@roeck-us.net>
Date: Fri, 27 Feb 2026 00:17:00 -0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] hwmon: nct6775: Register fan PWMs as PWM chip
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 linux-pwm <linux-pwm@vger.kernel.org>,
 linux-hwmon <linux-hwmon@vger.kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 julian friedrich <julian.friedrich@frequentis.com>
References: <20260225125159.20822-1-richard@nod.at>
 <9c733024-8ad6-459d-ae5a-a9825f85c506@roeck-us.net>
 <1892064865.155.1772178411224.JavaMail.zimbra@nod.at>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <1892064865.155.1772178411224.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-8170-lists,linux-pwm=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 185401B4774
X-Rspamd-Action: no action

Hi Richard,

On 2/26/26 23:46, Richard Weinberger wrote:
> Hello Guenter,
> 
> ----- Ursprüngliche Mail -----
>> Von: "Guenter Roeck" <linux@roeck-us.net>
>>>    - Exporting a PWM for external use is only allowed when the fan mode
>>>      is set to manual or off.
>>>    - As soon as a PWM is exported, changing its configuration is no
>>>      longer possible through the hwmon sysfs interface, reading is
>>>      still allowed.
>>>    - Changing the PWM period is not supported. IMHO, it is too risky
>>>      since the PWMs usually control system fans and similar components.
>>>    - Reading and decoding the current PWM period is only supported for
>>>      one chip variant so far, for all other chips, a fixed period of
>>>      100ms is assumed.
>>>
>>
>> This is a good start, but I'll want to see stronger safeguards.
>> - Creating a pwmchip entry for a pwm channel must be triggered by
>>    device property data, obtained either from devicetree or through
>>    DMI or through device properties embedded in ACPI data. For each
>>    channel, this must be confirmed by checking that the channel is
>>    not associated with a fan control channel.
> 
> In my case it's a x86 based industrial PC with direct access.
> What safeguard do you suggest in this case? A module parameter?
> 

Presumably it has DMI information or some other means to identify the system.
That information can be used to set device properties, which would then be used
in the probe function to determine if a channel is modeled as pwm channel.
See device_add_software_node() and friends to get an idea how that works.

How exactly those properties would look like needs to be documented in
nuvoton,nct6775.yaml. I'd assume that the pwm channels would be described
in there just like for any other pwm chips.

> Also for ACPI data, what exactly do you have in mind?
> 
ACPI can be used to provide devicetree properties. The information is embedded
in the DSDT table. Conceptually that is identical to devicetree data. That is
not something you need to be concerned about unless you are responsible for that
system and in control of the firmware. Technically the company selling that
industrial PC should provide the information in the DSDT table, but of course
that needs to be standardized first (and then they would have to actually use it).

Hope this helps,

Guenter


