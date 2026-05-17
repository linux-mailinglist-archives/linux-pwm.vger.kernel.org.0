Return-Path: <linux-pwm+bounces-8940-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDG6Nk8VCmrgwgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8940-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 21:21:51 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAE0563826
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 21:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01943300598D
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 19:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D7A331A7E;
	Sun, 17 May 2026 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="WNgLu7g9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53430305660
	for <linux-pwm@vger.kernel.org>; Sun, 17 May 2026 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779045698; cv=none; b=GzYOxhxE3uBIdc/OnEEq2YSppmA7mLqU/TBzPPaloiqAoFHjoexc+Dr0K2t/hwq+FOSE9R8KKEg8x/DvbjDZKywoX2P212Sdav2SWsdJnMa/4pVaonDsaq78M9lgWtIl2TQhqHnKH0eMN7+R8C3a3mnDll6HsXETQlMYSmQOcu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779045698; c=relaxed/simple;
	bh=lH1GgG6AZ3p8TFNccFcpJy8FScpxCDQooWelGA+EHCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ni3ixQli4UVCTALYwXsmG8ioRzysE3llU5ImfvyNEig+jX0UQBX3q+2ez0KSQFxv2lEyssijbdpGqkw6CaM906Ps96FSSWHecqZD3AHaNdVLYLif4/p57W5simgLns+qSj9JtohnW8G7c8pj4NdswUdNpp6LfU+uacxAONSiI5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=WNgLu7g9; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-69d2e3b45a1so163739eaf.0
        for <linux-pwm@vger.kernel.org>; Sun, 17 May 2026 12:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779045694; x=1779650494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=avFUFeQjZc5s2Fh1Gw+bXzbv6Nmu8tEYY1j2IJydQzo=;
        b=WNgLu7g9882rZjfblRCA0f7R+Si3jCbcL1IoVyJ8xem5nV0o4D+3VgpV6BfeA4DypW
         7Vo0DDNEbaIeGQq9qpNKAXpZ3JbsRUKtkXXyQbd7LYp+UzlHtbWugKcwH9IYl6v+zreR
         KhBLKDwI1nosZXqI7ZfeE+rJ1YwQVs/CmhQpEBtyQpi5ukocCLV7/wsBXGELBKHDcbGB
         jQUO0U0mVjc2XXiatiROYmSGkeYuWtLX3PIGK25sItq8Y0yZxQKl3Yr3clEDHEZwTrzK
         o/JNEU0loLdHQ2z5VhS0G0B/wYf0i1l9qJZLFJlBmossgWlMzZJb73d4iQJ+pXbLR2yZ
         db8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779045694; x=1779650494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avFUFeQjZc5s2Fh1Gw+bXzbv6Nmu8tEYY1j2IJydQzo=;
        b=PeJoh6u8xkvTaAg2NXg94aHLM0yGdkzGGkN+cL2Ui2WKfdhWhKoo+3smkP4be3X2NH
         ATa5W1K04A1+2mI/xBo+YvfqduFe6cHyGKudTBFBPEM9VS5TsgfyEleF35vUh9QJPOp6
         0Key5jIbIK60kuKR37mZusQ2GWSuer7A9DN2MOKPqwEBNfDojIkSz71pajQLZQNyBl2b
         ZqVVyXsfejAWZjbsTaLmBHRDSInZxf7MWyFqQflbD730jL6dRz5mkZjAQHQG18FxvLo/
         DrxiTx2rQIXItoVy/iiIfyj+UE9sTpwheJBdzxg9nYCx8KOb9q/u8o6oJWPfaTr+v1+I
         BsNQ==
X-Forwarded-Encrypted: i=1; AFNElJ+3f3iWRkiKKGhOO7M6/6ij7ZFvUFWzQXQtrN3oEuTu7bVhC63QThjvDiBwUzILsWzPBnYNLdzJWAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrJ94qa5yDrAVtAxKlaD1gbFmj1nQS1MGzLaUvbGclRyUBpfYq
	XTf8QtYh+EGA6QByaxQo+AXSC2H10h+xX5yJaGvpK1QhPJSAQaDtWFNrNST9z0BQl/Y=
X-Gm-Gg: Acq92OF4boRAAychUsud/WyuOiOrEEwJE2K9H4+X7aUJUJCjr8cdiXoX4KBMA2f10K0
	SX823p/1eNEgzSbMwS3TryzQSh1uxeD34FAaJHp/zKc94tUk+QhMjzZr3DZKHSegSihfxeOyuYk
	47rKwXSblb0pAPkFE7h7rX14GSB91QxfI+41eDuxM3ggUtaxKtzQ7F2BVyPn7pZv3bU3945/Nr5
	xcyuJ62pQtzyLUYTChcREz6JRijivv541tIVkcgYPi3ScoV3i7N32nFiKb6B1nT1BXBs2+VDAWn
	KBmHaPM033ROG2QbJlSg8A1r5IjbZzbeIKmQD9hqMPc5GfTNgrYUi0XDATUgs+p7d/m14b2hbc8
	/GK1oPZV20pXGj85MsUWkEbUaM0K45MfNQ/Oth4ABX7bTdKALwP84LVb7VBAzvv1a93Wvpcc7w5
	UwMy8HIyby2sT4HQ4QLZWh3r9ALklbv0ZI5wmEp+lZVgAvmnD+Xg6mcwsCnOkCgYSHeuaCzN5M5
	x4aWPPSMg==
X-Received: by 2002:a05:6820:4c0b:b0:694:8e6e:2e1c with SMTP id 006d021491bc7-69c9bfc92a9mr7692055eaf.60.1779045694287;
        Sun, 17 May 2026 12:21:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7a4b:ddf0:f61:f58d? ([2600:8803:e7e4:500:7a4b:ddf0:f61:f58d])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d045e6567sm4530406eaf.3.2026.05.17.12.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 12:21:32 -0700 (PDT)
Message-ID: <58a66855-9fb3-48ca-8cae-ff9277f745df@baylibre.com>
Date: Sun, 17 May 2026 14:21:30 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/6] iio: adc: ad4691: add triggered buffer support
To: Jonathan Cameron <jic23@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
 <20260515-ad4692-multichannel-sar-adc-driver-v11-3-eab27d852ac2@analog.com>
 <9b7986e1-6550-415d-b301-33089ba10177@baylibre.com>
 <20260517132526.27c71b70@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260517132526.27c71b70@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7FAE0563826
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8940-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,baylibre.com:mid,baylibre-com.20251104.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Action: no action

On 5/17/26 7:25 AM, Jonathan Cameron wrote:
> On Sat, 16 May 2026 12:32:51 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 5/15/26 8:31 AM, Radu Sabau via B4 Relay wrote:
>>> From: Radu Sabau <radu.sabau@analog.com>
>>>
>>> Add buffered capture support using the IIO triggered buffer framework.
>>>
>>> CNV Burst Mode: the GP pin identified by interrupt-names in the device
>>> tree is configured as DATA_READY output. The IRQ handler stops
>>> conversions and fires the IIO trigger; the trigger handler executes a
>>> pre-built SPI message that reads all active channels from the AVG_IN
>>> accumulator registers and then resets accumulator state and restarts
>>> conversions for the next cycle.
>>>
>>> Manual Mode: CNV is tied to SPI CS so each transfer simultaneously
>>> reads the previous result and starts the next conversion (pipelined
>>> N+1 scheme). At preenable time a pre-built, optimised SPI message of
>>> N+1 transfers is constructed (N channel reads plus one NOOP to drain
>>> the pipeline). The trigger handler executes the message in a single
>>> spi_sync() call and collects the results. An external trigger (e.g.
>>> iio-trig-hrtimer) is required to drive the trigger at the desired
>>> sample rate.
>>>
>>> Both modes share the same trigger handler and push a complete scan —
>>> one big-endian 16-bit (__be16) slot per active channel, densely packed
>>> in scan_index order, followed by a timestamp.
>>>
>>> The CNV Burst Mode sampling frequency (PWM period) is exposed as a
>>> buffer-level attribute via IIO_DEVICE_ATTR.
>>>
>>> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> 
>>> +
>>> +static int ad4691_manual_buffer_preenable(struct iio_dev *indio_dev)
>>> +{
>>> +	struct ad4691_state *st = iio_priv(indio_dev);
>>> +	unsigned int k, i;
>>> +	int ret;
>>> +
>>> +	memset(st->scan_xfers, 0, sizeof(st->scan_xfers));
>>> +	memset(st->scan_tx, 0, sizeof(st->scan_tx));
>>> +
>>> +	spi_message_init(&st->scan_msg);
>>> +
>>> +	k = 0;
>>> +	iio_for_each_active_channel(indio_dev, i) {
>>> +		if (i >= indio_dev->num_channels - 1)
>>> +			break; /* skip soft timestamp */  
>>
>> I don't think timestamp gets set in the scan mask. It is handled separately.
> 
> FWIW that is a sashiko false postive (I believe anyway!)
> If we do hit this please shout as we have a core bug.
> 
> If anyone has time to look at how hard it would be to tweak
> iio_for_each_active_channel to skip a last element timestamp that
> would be great.
> 
> I think that iterates one too far which is what sashiko is tripping over.
> 
> I'm only keen to fix that if we can make it low cost and hid it entirely
> from drivers.
> 
> Jonathan
> 
This is what I came up with (totally untested).

Since timestamp can never be set in scan_mask/active_scan_mask, it should
be safe to exclude it from masklength without breaking existing code.

I didn't check all callers of masklength/iio_get_masklength() though.

---
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 9d66510a1d49..17f539fc23e2 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -2300,8 +2300,10 @@ int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	if (channels) {
 		int ml = 0;
 
-		for (i = 0; i < indio_dev->num_channels; i++)
-			ml = max(ml, channels[i].scan_index + 1);
+		for (i = 0; i < indio_dev->num_channels; i++) {
+			if (channels[i].type != IIO_TIMESTAMP)
+				ml = max(ml, channels[i].scan_index + 1);
+		}
 		ACCESS_PRIVATE(indio_dev, masklength) = ml;
 	}
 



