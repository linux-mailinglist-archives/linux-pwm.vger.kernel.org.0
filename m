Return-Path: <linux-pwm+bounces-8970-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cACVDn0wC2rzEQUAu9opvQ
	(envelope-from <linux-pwm+bounces-8970-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:30:05 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 612AF56FFDC
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C50F43001188
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 15:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FF437755A;
	Mon, 18 May 2026 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="fx/mFa8o"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1DC374E4E
	for <linux-pwm@vger.kernel.org>; Mon, 18 May 2026 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117402; cv=none; b=raVAjLJyE4GChXYZwrNRdrckwSkJ+G9EiM4Qn/tcxyPL0Q9tapBt9BdXxmpFRynSTegDRjEP+6Shr3pEKjMR9cMb3k3tF8IJwjlIrxeDHpVrQl8eicwCTYiBXt6QbYPcZ1hMnLALeWCuviJzNlXkn+wY6BTQ3U/ZBYmtUtrXeyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117402; c=relaxed/simple;
	bh=WIuBIRVBEY5UXNn0IA/SjRUP6qFVmbXEj3WzcJbGoMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YsUSLsdyJuhcx3Np+9nJgBrqzVwKglVPo0QOplSJ+IfOs4JjMUp1RylFP9N02WfXgJLo6XU+JlqdZ0KMUnaB8fa67jlzXi85nNG0nlL8ukJKBufFLvZou0tgXljjQJG/oTwRvZxuKE71MIAA4ArvaK93nsTisqhczGoIwiSDa3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=fx/mFa8o; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-47c6f914617so1144010b6e.1
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2026 08:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779117400; x=1779722200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HnVPqvj+TB5ocpICaZUeUZprZClJ7W/n+a216rMOu9M=;
        b=fx/mFa8oJCpZrYpv/yxn9pTqx3cTqQQ1BTSB5AfnFgQDxZGKK3TFfV5NES+7elzVUc
         9MIuAl+HxR1Az3RAdp9BI0w9s5uDlXxoQ8NfYpHfU1rMTAPfHNg7kcWqYvV4vBKAEn9I
         bsvtzjhpmaWkx48dIv62huk811hak3h4JRv49YiZNIPFS+q9nZVIY3rOVMnDPS6i5Et0
         gjbPUiKq92AakMhTyXByaKrBBMqBi0TziWoayMzXkp3dzlzQzgRVbSyv/PwMy4fFGhym
         Z3hFESLMH9B/bZcxVD9JJixqKn8OJTOMjylkysqk4hzhRuPCK4gRIFiLb2OY4LF/Kra8
         mjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779117400; x=1779722200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnVPqvj+TB5ocpICaZUeUZprZClJ7W/n+a216rMOu9M=;
        b=MbBBb5V5Ja2aB8j7XCltCVuJmHTFvT5qw1gbTsExsoeLyL9JRPnjTRhWErOAX+N2AN
         BiWytasme8Wf/LdIUWO3KF+qgVzNxog7gwDnw5lD2xoAyfnl1ofOc6PeIXdJ139/yygR
         iOUCtqquSFlYOZSjMMndJci9kO3il/JL5TOGE4O8ezzFqh3EQfzqXTNql3ONTaaYY2Yh
         GKW0NyPi0DBlXbSnw5FxMB4GaT3Fo+qeTNooftZWYQADzcSgZYkY3p0AzmZ+LhLka/Q0
         cN7wk5W4dnZK/3EPv+fbhjQ/hlyWAIbdMTN7bZR1heMC3qwK3TAhAcyhVPqXnqkTuoI4
         yfqw==
X-Forwarded-Encrypted: i=1; AFNElJ+yEXU+Jc99pd4lLnb9nt4PpwmDOAYbvMQBHrjyrzYG3CaT+n8BLkte+Ea7INRwlSN6cYWJJNHmyuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7vDcvHxukXEKOHW8G3y4PlBwGQOdsIlFv9Ory7rX7rTklFEkY
	v8DlIEthTBOekbrfFxz0xkuFE0VuOsbAIBChzb/ncniiB787C3A1/e90+9CSJltifjM=
X-Gm-Gg: Acq92OHGoz34zwqg8tpKVQPbOF2wHTVUafCMfAfmzgGS6sjL3lxXuBHYbNTSSlVXF7q
	1GBEyN2WZKLuy3Sofalni644Ntz4KlDcL2dwaXN4AVp4Rg6zLulUbgebWtnfHh62/qBRmJvzT6J
	WtjqtV1m01xKSIhMguUPFh0FVsObBCbDqpoDIluQzzaBUtcZA+tuv+1+WsnDxSp8l+mKiXiR0YJ
	U8cgqmiPwA/PvxS/4/3hMt8yNWletw0RhHNW3Tac7c9j/uTCrUEFVyMebThQAa7yMHUnZ4pjgS3
	gSQvUDnVky44Hn6crcalbI5rjXtftlehy660S5xVoXw83IdZYOKeR8FheBLeXAfvuJkeDNOKnWS
	rNirULPBAhO9ZTW7rtTwod3n3CYZ5/45TltDIY2k5n1e1T+tzpjRZJlP/LyhJMl4Xurlw+V0LqA
	GMPY6VpZ9bLMxeZ4hEPAA386GgDjx6xTfZBsS3BehoEl/GfR9sdrLRyCrSxWj2ZmNB7agj5k40X
	w==
X-Received: by 2002:a05:6808:11c1:b0:467:2652:b29d with SMTP id 5614622812f47-482e55e64damr9452991b6e.8.1779117399487;
        Mon, 18 May 2026 08:16:39 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3be6:1187:fed4:378b? ([2600:8803:e7e4:500:3be6:1187:fed4:378b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482ee0999f3sm5028432b6e.0.2026.05.18.08.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 08:16:39 -0700 (PDT)
Message-ID: <60d66897-41cc-4f3f-afd2-64e49f0bb55e@baylibre.com>
Date: Mon, 18 May 2026 10:16:38 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/6] iio: adc: ad4691: add SPI offload support
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
References: <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
 <20260515-ad4692-multichannel-sar-adc-driver-v11-4-eab27d852ac2@analog.com>
 <80f61c0b-1f36-4fee-9f76-b93f63b87abe@baylibre.com>
 <LV9PR03MB841418AEF0059E802F7A69B2F7032@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB841418AEF0059E802F7A69B2F7032@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8970-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,baylibre.com:mid,baylibre.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 612AF56FFDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 10:14 AM, Sabau, Radu bogdan wrote:
>> -----Original Message-----
>> From: David Lechner <dlechner@baylibre.com>
>> Sent: Saturday, May 16, 2026 8:53 PM
> 
> ...
> 
>>>  static ssize_t sampling_frequency_show(struct device *dev,
>>>  				       struct device_attribute *attr,
>>>  				       char *buf)
>>> @@ -880,6 +1229,9 @@ static ssize_t sampling_frequency_show(struct
>> device *dev,
>>>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>>  	struct ad4691_state *st = iio_priv(indio_dev);
>>>
>>> +	if (st->manual_mode && st->offload)
>>> +		return sysfs_emit(buf, "%llu\n", READ_ONCE(st->offload-
>>> trigger_hz));
>>
>> Why do we need READ_ONCE?
>>
> 
> trigger_hz is u64 and if the target is 32-bit, a 64-bit access compiles to two 32-bit
> instructions, so show() reading it without a lock and store() writing it concurrently
> can produce a torn value at the compiler level. READ_ONCE/WRITE_ONCE suppress
> the compiler transformations that would allow that splitting or caching. We could
> have st->lock in show() instead, but that felt heavier than necessary for a single
> scalar where a transiently stale-but-whole read is fine.
> 

I would go with the mutex. It will be easier for people to understand.

