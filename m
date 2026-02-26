Return-Path: <linux-pwm+bounces-8167-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKeKJqrLoGmlmgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8167-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Feb 2026 23:39:38 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E10001B0779
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Feb 2026 23:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46B75305DD6A
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Feb 2026 22:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AF93A1D0C;
	Thu, 26 Feb 2026 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFB3zBH9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D35C39E186
	for <linux-pwm@vger.kernel.org>; Thu, 26 Feb 2026 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772145510; cv=none; b=KSljpEaQs6KEh8k/oLvB1plGlYm32YhksZwAIFzSaBU3uKg+/3yWmEO9GRVZ19MmbTkaXc+NO9og9/+4YeZs7k5w+T6rvcUGLONy7waBreS3cEt/VHpZmcAOtMw6b7WmnTVWnVt+AH/sL6GhkUcwXXGRY7wn9Z9vNLvrV8L1lLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772145510; c=relaxed/simple;
	bh=T/wDQ2iMi0vXLDT1EzlM4qZzSytYxtK6USzhQ5vl0fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqgqNdcPw82iTH2bV23/o3wVYCC+6JKdCu7yA05Leo7mPec+Epfe6KGAS01XOfdcNexJ9b7CcbbvB6jmN0oi3zj+xet3G2V1Xi+/J/vMkluErpE8M0cT4YbF6cL5nSn1C5DRC59x3EH7uLdUv2f/iGj0wi/DZIieanmThGQIOmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFB3zBH9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ade574f05eso9734995ad.3
        for <linux-pwm@vger.kernel.org>; Thu, 26 Feb 2026 14:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772145509; x=1772750309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=15sIrA1WeByRKFhSIpDX14/vR1M9GDJaSXD4pcCTCFI=;
        b=UFB3zBH9tSto4xIK/qbSEjV8ZItR+iVAAdywCeShT4xdn547cSQC09RARFCb0EoRP6
         loL6nAswd07QNTB1mtv8E9PM7+VwyHxJ7eIrrvFuTrJjbWOPCjxZ7iYpTmPzuJgiyyS4
         6wzuBtfqYBu4KWvtz1gsBzKS8lpJb1Hiwv+0uaUcHTNK/dDQIeNZ3mwHB8bczGC0zlVY
         g/UrTYXRAF47rkdTWbUs+RxH1iSk0dH9lvmZz+3FiQ6kL4++U6b+BySc0dJz2Vnh4Dqr
         iCyX0K3Of/ujICdqdIe5/cmsiLDLbdcacmrdpvZ5e5wNVxGsxaYvTmZ3QSR+8g4hZunh
         5Gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772145509; x=1772750309;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15sIrA1WeByRKFhSIpDX14/vR1M9GDJaSXD4pcCTCFI=;
        b=hh11LQLJ0p/sKegZzKMkUyiy9IGEcSVpS4MqgghMWSzz3IiKrtX2kzHTokR+kfgx7O
         POIPtpZCYZk3N0Ho3zNiyOfTXuMh3APeyxTfEfkKVxS7yBqiXB9v4TIPMlWkakf9CYVF
         TNiCcVDIUhSksiUCHRTX/2qD6v2sLM1D4CMzws936b2eHvrgvpJ0GxOqN29tre/qvNvn
         dbMgcYdkEaLpsngXdQQy5Seyh7w9bGWuU6lQ6DrMWQKKBa6gsxSSFcCpbkl9bhEcuZRC
         TZbi+1vcGvwZObG05P2S4s7muZXvcpmuD69czGpNVoOx82lkxLAjXFSc6spu5UdVTEIj
         Tk7A==
X-Gm-Message-State: AOJu0YzyJakL5MRY0Hhnvqg8stJDX3mVM26xLowrw7fzNJBl7CgVHVGu
	lPEB4Oqip0yKjHnTNYjipHSuDLxaq5mgs7JPCOUf+r3uBxAfc4+l48Kt
X-Gm-Gg: ATEYQzzecesrzAgwg5fiHWBYsnYfQ4bKqe1if1C7gtq8MqxYvib4m1o105k1vhzk5vq
	mOrKxkbr0A5hOTMFKvdDqE42ZPEiGP/gC+CUSqSj8AfYDUsozAdBW7AUWG33xBoe4iWle9y//mY
	pbnNo4EtgB+ylCNjcv12MXa1yEebjF0YFU6iNhUg+YXbz3f3ny3VQvk+Eqvf2PKuh2UGl0P8U/0
	XIJQzeyzfAfvReJ5iB2myqBC6s3XnE+RuPMK7GjW1S4rUsEJOuknodYjsk0Qg5J59sILtOtS66N
	MHSyRcWS+t++qkBiWmyeHkwR8EN93SD4UtvkEUHrXveITWBoqWnpI5b2Iga1B6/JTLVKEJea92G
	SadRW8w5vlXBjpV/ysiuooxGa68PGPD99T4hQ2+xizVpV2OcWVRiVOZVw/WWN8wGbURQTFSVTaE
	dBbEk46afHz39qz2aW5exaFLtvlE0YEarzU4H9vQWxHs11pxMsbBfyQjbGwKXc2MhuvVUyE0yf
X-Received: by 2002:a17:903:32c5:b0:2a0:c942:8adf with SMTP id d9443c01a7336-2ae2e3e0f59mr4324455ad.8.1772145509003;
        Thu, 26 Feb 2026 14:38:29 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69f9c2sm36880365ad.51.2026.02.26.14.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 14:38:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9c733024-8ad6-459d-ae5a-a9825f85c506@roeck-us.net>
Date: Thu, 26 Feb 2026 14:38:27 -0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] hwmon: nct6775: Register fan PWMs as PWM chip
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
Cc: linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org,
 ukleinek@kernel.org, julian.friedrich@frequentis.com
References: <20260225125159.20822-1-richard@nod.at>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260225125159.20822-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8167-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E10001B0779
X-Rspamd-Action: no action

On 2/25/26 04:51, Richard Weinberger wrote:
> The Nuvoton 6775 chip family also offers PWM functionality to control
> various fans. Depending on the hardware design, the PWM can also be
> used for other purposes, such as controlling a display backlight.
> 
> Historically, the driver implemented its own sysfs-based interface to
> control the PWMs. This made it impossible to use the PWM as a backend
> for other drivers, such as pwm-backlight.
> 
> This patch registers the PWM functionality as a PWM chip within the
> PWM subsystem. Since the Nuvoton chip has non-trivial control logic,
> the following constraints exist:
> 
>   - Exporting a PWM for external use is only allowed when the fan mode
>     is set to manual or off.
>   - As soon as a PWM is exported, changing its configuration is no
>     longer possible through the hwmon sysfs interface, reading is
>     still allowed.
>   - Changing the PWM period is not supported. IMHO, it is too risky
>     since the PWMs usually control system fans and similar components.
>   - Reading and decoding the current PWM period is only supported for
>     one chip variant so far, for all other chips, a fixed period of
>     100ms is assumed.
> 

This is a good start, but I'll want to see stronger safeguards.
- Creating a pwmchip entry for a pwm channel must be triggered by
   device property data, obtained either from devicetree or through
   DMI or through device properties embedded in ACPI data. For each
   channel, this must be confirmed by checking that the channel is
   not associated with a fan control channel.
- If a pwm channel is configured as pwmchip, it must not be used for fan
   control, meaning the hwmon properties associated with that channel
   must not be created.

This will retain current functionality while enabling support for using
pwm channels for purposes other than fan control.

Thanks,
Guenter


