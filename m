Return-Path: <linux-pwm+bounces-8580-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sB7YMNJa3mk0CQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8580-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 17:18:42 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 567543FBA3B
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 17:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36DB4301F306
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 15:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FFA34253B;
	Tue, 14 Apr 2026 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="S8CGAeVo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F90429D264
	for <linux-pwm@vger.kernel.org>; Tue, 14 Apr 2026 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776178956; cv=none; b=EuBm0D8jxTT+LFRxRMmD5SuVtAPpNBAMKH/rcsxH/FX+7FltJsiaS0CvIr6pk35tCC7bk7ZHNP/JcDTOgixqdf3a68htgQ6q8C/+UHFpElPwuMeOb8Q4VsIc7dZGVOPbDsMuOiHPQALNOqH8/3sUnn8i92y9cEBMVSWATGzt6wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776178956; c=relaxed/simple;
	bh=pR7yMGzINuh7Tg+rgoLYT2relUB3Xn6nd5b/yiBK3yM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfW1JBcwon5JF5hvy54P3/TfHqEfYVptAV1o77Jne3sLEq1JBdYD0T3juXnOiMOrSeXAGj27VwN0YvbWnhVf6imUgGrzmkx7DSv23tIpquaDw0f/krjRCDxb/L4CFKDrOEHNBuzrUeWUxS4+yaOfp/7j2YGw0iKvyq7c5m8F3Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=S8CGAeVo; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4232323a7daso3022389fac.1
        for <linux-pwm@vger.kernel.org>; Tue, 14 Apr 2026 08:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776178953; x=1776783753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72WPnVzQjKjXI3MDfuIkyAD5bPg/rh8SgDqYgiN/6GI=;
        b=S8CGAeVoEi+deFP4+cHQ1txTffIqNW6G9nX1e01JQNJHNZB/ZnqtcLbbYWBWHhXGq1
         tDwzquR9RSDI9i31D8xsyu0fZN6gWJkBMOZYYJRNYJJm9gyMMiOqj33J/0RjpOl5UWrL
         vtPZyol8xPer1B2f4j57bGNFXeuYqpaYINmzV/M2adxr7mKp+oyh41CKw5jel2OhBbqz
         +FWCRmHuDSXcw3VIbFoaiYpleVDx+/dt8xgBqO19/x3/GYWaBuCEmUbXxKG2haEcfnPL
         236bnvcTkdt7QACNHmy91TeMPzz8ygzvOG4lOVviJiLyXI+zwfm/2kDw15kwsP8RR6p+
         1ASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776178953; x=1776783753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72WPnVzQjKjXI3MDfuIkyAD5bPg/rh8SgDqYgiN/6GI=;
        b=Urqlm0sCfwcF1dfrnXMpko0PUW4tcVuWjOMegVNylHZLfcvzXvQzHnt/SWPCpdsmFr
         rEJWyfPajBE/9mCZx54VRvYafRLqnSceurJkXJ9eMyfF9mn7nUZGiEnjBgw21RKgA+ww
         TLswECEl31I6whmnfJPggxYivUi7EE/crphf2zTtq2Tuh7ObejsypDyoBNInqw+quEf+
         j51eGWV0hQoFq5e4KALfhcMhzmTH1VG+OjvSRj1tUfva/M2Nwof54z4E1NFbt5rrlFb6
         rjgl1mUwvkMxu+N9knN6b0ChwGOgwEFGqzz/2bUrhk3x0TN75YXCryDCMrCKI1k9AN8Q
         zNpg==
X-Forwarded-Encrypted: i=1; AFNElJ8Yfl/DBPGhPnb2iSqzJteSMrT15i349N6YnMtTVVPczozdCR3xBPDsHsupqWOTbThnP+m+WJTyLVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrXbm9uC0BvaIKTwo0udvO+/Qwj10sVAvq655yJmwzGQ10N/cg
	HuNj7BstzFHuL7OY5JfNEirFRPjcOmhwqgstZFS1FSxmKqXFhBgqKFDqgrR+dwm1aYU=
X-Gm-Gg: AeBDieusY6w86MMAhuWrpN9LcGY2lCsXOpUhpzmsZxB2ujd1VyfogYCfkLZ9SJVjgZz
	JLnXX33MiyFsVviydcjvWKS+Pu7f8zckmOR5OohY/+eEJW0VBg71YExrd4WHv6Tc6fpsXQFVZ1u
	NOijAFX2nKTuKRjj66n21tj6TXyarz8XM17Nhj1Au4Z0M4oGacnuoon78E2h3eB4odzWkyrX5dO
	kPu2CXZne4PzGHDcc9ZdRi9zz+sBnzGN2Jw/p4KHiFMa78Zo749htXpGYR+1yBTuV/BwwLHqkh3
	ZX3QEzW9UfH/e6UOpr1vDum2FIVmFk1ahFdt3KGQRIh31f1Ua1r9nmC+8yBxW3NgD/klsHciRnK
	4TIVpZuGPnFQ0ikfGXK8lZM00vQ6VK10xeE2BbE9vL+3UY4Mezm8QH07mhuxsRh+WaZbKA6X7mA
	NVr0w3VTCXfSLSRMDz3pevBjeyTSG6FdAc+rX5X/iezok3DLWZx+SnjIvjGPYH6oQsBs3nv/xpx
	rebaIwhKX3y
X-Received: by 2002:a05:6870:a093:b0:417:f38:f54d with SMTP id 586e51a60fabf-423e1081b4bmr10571548fac.29.1776178953139;
        Tue, 14 Apr 2026 08:02:33 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5bfd:a817:5527:c417? ([2600:8803:e7e4:500:5bfd:a817:5527:c417])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423dd3960bbsm11211900fac.4.2026.04.14.08.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 08:02:32 -0700 (PDT)
Message-ID: <b352b76c-8047-4a1f-8b83-db8144466c36@baylibre.com>
Date: Tue, 14 Apr 2026 10:02:31 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/6] iio: adc: ad4691: add oversampling support
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 "Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com>
 <20260409-ad4692-multichannel-sar-adc-driver-v7-5-be375d4df2c5@analog.com>
 <742b1821-9103-414e-a860-c2e8d5406e35@baylibre.com>
 <20260412185821.739e477f@jic23-huawei>
 <LV9PR03MB8414E0A68C5676302909E220F7252@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB8414E0A68C5676302909E220F7252@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[baylibre.com];
	TAGGED_FROM(0.00)[bounces-8580-lists,linux-pwm=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,metafoo.de:email,analog.com:email,lwn.net:email,baylibre.com:mid,baylibre.com:email,pengutronix.de:email]
X-Rspamd-Queue-Id: 567543FBA3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 9:25 AM, Sabau, Radu bogdan wrote:
> 
> 
>> -----Original Message-----
>> From: Jonathan Cameron <jic23@kernel.org>
>> Sent: Sunday, April 12, 2026 8:58 PM
>> To: David Lechner <dlechner@baylibre.com>
>> Cc: Sabau, Radu bogdan <Radu.Sabau@analog.com>; Lars-Peter Clausen
>> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
>> Sa, Nuno <Nuno.Sa@analog.com>; Andy Shevchenko <andy@kernel.org>;
>> Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
>> Conor Dooley <conor+dt@kernel.org>; Uwe Kleine-König
>> <ukleinek@kernel.org>; Liam Girdwood <lgirdwood@gmail.com>; Mark Brown
>> <broonie@kernel.org>; Linus Walleij <linusw@kernel.org>; Bartosz
>> Golaszewski <brgl@kernel.org>; Philipp Zabel <p.zabel@pengutronix.de>;
>> Jonathan Corbet <corbet@lwn.net>; Shuah Khan
>> <skhan@linuxfoundation.org>; linux-iio@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>> pwm@vger.kernel.org; linux-gpio@vger.kernel.org; linux-doc@vger.kernel.org
>> Subject: Re: [PATCH v7 5/6] iio: adc: ad4691: add oversampling support
>>
>> [External]
>>
>> On Fri, 10 Apr 2026 16:15:20 -0500
>> David Lechner <dlechner@baylibre.com> wrote:
>>
>>> On 4/9/26 10:28 AM, Radu Sabau via B4 Relay wrote:
>>>> From: Radu Sabau <radu.sabau@analog.com>
>>>>
>>>> Add per-channel oversampling ratio (OSR) support for CNV burst mode.
>>>> The accumulator depth register (ACC_DEPTH_IN) is programmed with the
>>>> selected OSR at buffer enable time and before each single-shot read.
>>>>
>>>> Supported OSR values: 1, 2, 4, 8, 16, 32.
>>>>
>>>> Introduce AD4691_MANUAL_CHANNEL() for manual mode channels,
>> which do
>>>> not expose the oversampling ratio attribute since OSR is not applicable
>>>> in that mode. A separate manual_channels array is added to
>>>> struct ad4691_channel_info and selected at probe time; offload paths
>>>> reuse the same arrays with num_channels capping access before the soft
>>>> timestamp entry.
>>>>
>>>> The reported sampling frequency accounts for the active OSR:
>>>> effective_freq = oscillator_freq / osr
>>>
>>> Technically, the way this is implemented is fine according to IIO ABI
>>> rules. Writing any attribute can cause others to change. It does
>>> introduce a potential pitfall though. Currently, changing the OSR will
>>> change the sampling frequency, so you have to always write
>> oversampling_ratio
>>> first, then write sampling_frequency to get what you asked for. If you want
>>> to change the OSR and keep the same sample rate, you still have to write
>> both
>>> attributes again.
>>>
>>> In other drivers, I've implemented it so that the requested sampling
>> frequency
>>> is stored any you always get the closest sampling frequency available based
>> on
>>> the oversampling ratio. This way, it doesn't matter which order you write
>>> the attributes. In that case, the actual periodic trigger source isn't set up
>>> until we actually start sampling.
>>>
>> Agreed. This is more intuitive. Now generally the userspace should
>> be sanity checking the value anyway as limitations may mean the new
>> sampling frequency is not particularly close to the original one but
>> at least it increases the chances of getting the expected value somewhat!
>>
>> So to me this is a nice useability improvement given the code to implement
>> it tends not to be too complex.
>>
> 
> Hi David, Jonathan,
> 
> What I understand from this is that the osr should be taken into account when writing
> the sampling frequency as well, right? Here's what I understand:
> 
> If the user wants a 125kHz freq with 4 OSR, then when internal osc will be written
> to 500kHz before single-shot read, buffer preenable/postenable.
> However, if the user wants a 500kHz frequency with 4 OSR, that would mean a 2MHz
> Internal osc freq, which is impossible.

It is up to the user to request something that is legal. They should know this
from reading the datasheet.

> 
> More than this, if the OSR is 32 the maximum effective rate would be 31250, so 25kHz
> would make it the closes available one. If the user would select 1MHz from the available
> list it would be weird I would say. So perhaps a solution for this is to display the avail list
> depending on the set OSR value.

Yes, the available list should reflect the current state of any other attributes
that affect it.

> 
> Linking the two together is perhaps wrong to begin with from my end, since in this
> driver's case, the per-channel sampling frequency is controlled by the internal oscillator
> which has static available values. So perhaps sampling frequency should be separate, and
> OSR separate as well, which would make everything cleaner.
> 
> Indeed, the effective rate is changed by OSR, but perhaps that is something the user
> should be aware of, since the sampling frequency is the rate at which the channel samples
> (1 sample per period) and OSR is how many times the channel samples upon a final sample
> is to be read. The user already has to take this into account when setting the buffer
> sampling frequency, so it would make sense to take this into account here too.

We can't change the definition of the IIO ABI just to make one driver simpler
to implement. The OSR and sample rate can't be completely independent.

If you want to leave it the way it is currently implemented though, that is fine.

> 
> Please let me know you thoughts on this,
> Radu


