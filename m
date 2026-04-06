Return-Path: <linux-pwm+bounces-8488-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HzlrO5a302mqkwcAu9opvQ
	(envelope-from <linux-pwm+bounces-8488-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 15:39:34 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF053A39D9
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 15:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6DBC3003831
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Apr 2026 13:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2B62FA0C4;
	Mon,  6 Apr 2026 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="aD3K9pC7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE212EA172
	for <linux-pwm@vger.kernel.org>; Mon,  6 Apr 2026 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482769; cv=none; b=PFF5SpxT2bJjl7US0j8ZXICahjqGbsqRefFiKnZnUMTj9JroBfqnKjNHreqooiyy3aWwPRv22ioBTyT6cr1EbArQM0DBbZwSMrwFT2bCIc/xiLbKx5AJRo5Yl8yCf6nw+QRwHgAEq+WPnO5g2HjvuBzU3pRM8mcOz+AHgxFBzy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482769; c=relaxed/simple;
	bh=wkrJeNFWF2uMlRZnWrjqBwY2c14k9cP+d6D7rKAU8LI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pzLYKg+IlTdVEfUBerpDrmGRCXpfMWYExO6zYf3aWPwymC894+QhJJjEz3uz0PSCELDNZbG3yej4r0DnQWFINyEfgs8sYc4xCSx/A/r0eDeoidF9TB0F9pc6/+xEl9V6UKmIZcFpWV5sX25PccIGT3OH921kCJP5lax0Vdjgkww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=aD3K9pC7; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dbcd61429cso750998a34.2
        for <linux-pwm@vger.kernel.org>; Mon, 06 Apr 2026 06:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775482766; x=1776087566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1lorUh8imlkbzF1MrlVYRw6zvFFtCWMp5F11QdFDe9Y=;
        b=aD3K9pC7+rTAKV/iXTsVgBDse/4vpMthyb/KDFQgV63WpPiEnmyCldJO5vJ628jicF
         3WKrk3tArUltkrCCMjwlyCILDZxdyRHEIJ1T2R28pEXs6+LTU/GnaJELtrizwWZZlU9Q
         SPjLyu7ddgigIsKfds4wcIwDshAvMZFoXlB9Urc3Qk2y4frxfSFyr92qGtcLVNP6wys8
         WV2s5v29oBCfykNFmTDjLmofeNxwjXw2EXyIgbdndHEJEGyi09kbjg3YJIFqvHmjQVMM
         n1zRdgVrZ+OfNAUsCIOpTnHDzH0oFKV7rNwnicJ4rqISh3FcUtjWRPRy3u+meSjWUQeI
         Mstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775482766; x=1776087566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lorUh8imlkbzF1MrlVYRw6zvFFtCWMp5F11QdFDe9Y=;
        b=gFIp9ixQUVUC42xf4+MXMe1wkqjCnLzJUk4OmBugW6Q7iE91sZxdhiZ9qw9sNQ24TR
         i+TQZb4FcXUuUeSZ6E2JlmGJiOo9Bl0BsFzXthFtkl/L0gzzDCOUfraX4swh1m2WmRnl
         x3CkxVJWYhOTGJxNX94fNr5NjNMra5AKjjipHwWrB7XCQO5q/830Ubl/pxOvRCD4cz5e
         6mlWeQrCFg8Jx60g/mdNPQ4zLxUGWLjoSkAn/r1dljAc5sWgi1nLv1dk0DTKOB6AK6/Y
         ybyqD7XwPGRQZHkDzSeLdRPUiHaTIyMW647XMNdBdzyJU48GPcGa8l7a5Vus3UppQ9du
         IbDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOA5YfFYE+EzyKusEmduKJihgizR+OxE2s0G3KIY/Hp6omqwQ6YoWglT04XCl4XLdZ8hzN4bwDAEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuoewQDKT56ZcND9+lKsti9O3AiI8Eck7IjlF9upzj15F9lm3L
	N334omiIghYaemYSBoOtI+GvED/H2MXOZcgtaZ3YSqZhs5XbMGqKEKihO2HAiC2t2AQ=
X-Gm-Gg: AeBDievJEk0SWR22mO/jEGOA3BJBA63/QIdq5xEMmXIEHpPIqxulhxe2fsIV+EjK3rr
	MTXFIt8Hmr4OkBMoRnE7JP0OuOy5FONUIEdBVoduOJJRXyV1aUr7Fk5+TlYIheKsSzpeBLDsKun
	EsgB9WboFFcIRB+aBFetOiMb089H1Fm0fTmIu9+m9DyCEOK6fHOCIJZDa6S3/YE50W0tP7E4pYa
	LtXgeKJkHpq2OVWbmEllvCID+ZjGCmyXZBSAW16A899tW50+eeXS+PrYl6/SBPc+UtzO1hrLr0w
	sQF3Y3anmnrtrO+4xm07b1fsaMeW9R7UzuXtAEC15d+daOlpkJ+6hfwnYe0bcqmCwl7pFfk7xlF
	3vKeVyIxiGa0H/tonthAzjdKAwwl+U8zDFp+fH6SUakWTPm+K7dSsjdokoqtE5mGbB1TduF9FX/
	XkIsIdz80hRntvzYhgqsc/hrXpChyId6SisZKl+uhgbRAqWO+w7WvgOcoQgfqvMsqi7MHJ83Y=
X-Received: by 2002:a05:6830:3783:b0:7d7:b6b2:6352 with SMTP id 46e09a7af769-7dbb6f961eamr7766540a34.13.1775482766251;
        Mon, 06 Apr 2026 06:39:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:90d7:b13f:c53:8ca3? ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbb7c3a0c8sm7531599a34.12.2026.04.06.06.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 06:39:25 -0700 (PDT)
Message-ID: <18f79a5d-2f64-4984-9df0-40234f72646d@baylibre.com>
Date: Mon, 6 Apr 2026 08:39:24 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] iio: adc: ad4691: add triggered buffer support
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
 <20260403-ad4692-multichannel-sar-adc-driver-v6-3-fa2a01a57c4e@analog.com>
 <e38e5b97-e90f-4613-a15e-6c3d08cd77f7@baylibre.com>
 <LV9PR03MB84143905DD2E10BAC2151EEFF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB84143905DD2E10BAC2151EEFF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8488-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: DEF053A39D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/26 4:22 AM, Sabau, Radu bogdan wrote:
>> -----Original Message-----
>> From: David Lechner <dlechner@baylibre.com>
>> Sent: Saturday, April 4, 2026 6:12 PM
> 
> ...
> 
>>> +
>>> +/*
>>> + * Valid ACC_DEPTH values where the effective divisor equals the count.
>>> + * From Table 13: ACC_DEPTH = 2^N yields right-shift = N, divisor = 2^N.
>>> + */
>>> +static const int ad4691_oversampling_ratios[] = { 1, 2, 4, 8, 16, 32 };
>>
>> It would be nice to add oversampling in a separate commit as that is a
>> separate feature.
> 
> Do you think this would be suitable after the offload commit?
> 
Yes, I think that would be OK.

