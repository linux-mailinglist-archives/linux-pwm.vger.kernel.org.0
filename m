Return-Path: <linux-pwm+bounces-8326-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBaKFC7DvmkKawMAu9opvQ
	(envelope-from <linux-pwm+bounces-8326-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Mar 2026 17:11:26 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0CA2E6444
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Mar 2026 17:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3460C300EFA5
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Mar 2026 16:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465573090CD;
	Sat, 21 Mar 2026 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t7FfDnxv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B22FFDDE
	for <linux-pwm@vger.kernel.org>; Sat, 21 Mar 2026 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774109482; cv=none; b=BDmA4uGS3Z+ng/DF+eNPmHWvMKes/xLlRKVLt91++ppKB+TjvzadU2dz5CGVVT5LioLFYRobvXo1w2ybXS2CA74zK0P8aVytO61Dio7ykryx0ZGgX3bMDGZ3xy1kNOaXBCctrB9o8irQy+6hdrWzCk0XVlnUABA0hKUgs9BE8Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774109482; c=relaxed/simple;
	bh=Rf5h3AQOLeWbNsSTZIKH+4HXwvmOWLUEZ4Elupi7TOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcN6jM1XUNjjVMFFvJQ71oDCycjVqjdP5OU8sSXSu5wyHhi8vBQUDdIM7FaPkv9+/MV8fddCE4IwDz46eTaxu1e9guMSRNrKK/HxCBgEg470bWT2BXu5PQeoU/nOV5BxpnhYt0lJBV4ZZSS/CqgRqkAiINz5+Svn/NoUF9bD0ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t7FfDnxv; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40946982a78so900890fac.2
        for <linux-pwm@vger.kernel.org>; Sat, 21 Mar 2026 09:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774109479; x=1774714279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePBnLY2HsewubhlIjuJ77dk8XdKtMQwZQ4cBTDjuGuM=;
        b=t7FfDnxv18XmM8nw3xqghoKvm7duSLaIJdcSHDcs5SVo2t5CzdnoABMUmhdUE1gp/N
         tSL0SU55VVq1YUwl8mqbtYjAyDJMiHeuTMTuBDCyf0jy8cv5BvWOeXwWL7Nr+bp/RIYc
         lu/mNg6i4GLVXCQ6LGmh3GD5cvnb15Zh779RX260mGhPTR/fN1hCb1nWOXUyNRBFC+X9
         rx483XCPDzt119oiZoY6xfdyDzmm4T4KGuJ+wt3wUiWoEank+s01xFp+CY5vaAqCQSex
         SdlCV35eYe7csjL49IakP0Fh52qs3b0F4lFjhIEBI+G2ak7gEJyuXaEP+/5imoogQXKj
         i5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774109479; x=1774714279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePBnLY2HsewubhlIjuJ77dk8XdKtMQwZQ4cBTDjuGuM=;
        b=EteVCONoFwc+CqfxUwWzC/zbPCz6P/rdvJ0uaos4mSF1ltmuxgUtSQut/qzdC5HaZ5
         2efeE5lLKmvJ+0tZeegO2u1GwujXZg93hDXfs2dzd9fpvll1fTHsJzhPrU5ZDk7TFW0v
         Z6Ow5EhFzyyTwFRCKdnzZfFH1xskhI30SV5kZugS46zMYIeC5LAH6kXntT+EIo+CYL79
         2r65n6dwjXiMqAMinRd7lTIy74/VdjS4Ege0RcW5nfgpUwNBzKiZ7A+QYgFu8+HweBck
         Yv305AZcW/wY4ozyPks1Jffs3t0Onjg/15i7aZRAxzjm7IkWDiHZOO/4VYA0s6UhEkaN
         HvFw==
X-Forwarded-Encrypted: i=1; AJvYcCVJuCAYfjicRqIfKRlm1gc3ngkA0lyCppQpGo3BEoobHjF1/SBCffjqPJ8nfxjAgJ5ak+lChddggGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiCP8AjMRTPUwfXmKEx6CEj1HTlKIYXwAeuMC1camdG/EAr7F5
	bATb7cxNqUQ+Lz/Ks7PNQGm8AGPRXyxagCC/Lb2SNXP0/K0gLmzOkZeh5GJ711bkNaQ=
X-Gm-Gg: ATEYQzymS9xrqE5Yj6GsIRECk1s1aFMfl7aDP1DL11E58U2HwAgupwxx6KKWA/iRe7c
	XHkOlhV6kVTeXF7jrycuDgcz4qhLoh0PjaH0a4f4PIT/dbWNMnPLdvzgLubwLQFxKb4s2YXKNDy
	3uW7YLX/3cNeUXCbgUKUiQkpBld8AgoYLgSM8RB9L5L4caTGVURLA4g1MM4ahyna2nO+2jOByy/
	lRYUn75ieIIApTJWGmn9Wc3vV3rxpFas6cfxFXaNQFJfctKp9DItOco47XT9fynO5PfnRDK7MI+
	YTh4S/Rn+XeRsJmRnTSuXlBmob3Hvk3VAJsX2Xs4KsgN3xbDO2507MRHL0D2tuZ757JLDxuiBcG
	kp6tF8LWp/bV9XKxAHd0Qy7UtJcF3rOuVup4jiCRlhJc7M+PyBMs5WD8r71PeVO8+n3LBfaim7C
	zFoSJM3tAIybgSJkcvWUwJ7f6k41BaMIbz8xIg9kq8lYAPKaBGAl/vn7SqQe6GXqSl3TdAQaxYy
	w==
X-Received: by 2002:a05:6871:80d:b0:41c:1036:84b with SMTP id 586e51a60fabf-41c112440femr4336750fac.39.1774109479055;
        Sat, 21 Mar 2026 09:11:19 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:8e89:f58e:e4e6:5567? ([2600:8803:e7e4:500:8e89:f58e:e4e6:5567])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c149103b0sm4635730fac.5.2026.03.21.09.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 09:11:17 -0700 (PDT)
Message-ID: <486fe1c2-3734-43ea-b7cd-7bbba2eeb891@baylibre.com>
Date: Sat, 21 Mar 2026 11:11:16 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] dt-bindings: iio: adc: add AD4691 family
To: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260320-ad4692-multichannel-sar-adc-driver-v4-0-052c1050507a@analog.com>
 <20260320-ad4692-multichannel-sar-adc-driver-v4-1-052c1050507a@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260320-ad4692-multichannel-sar-adc-driver-v4-1-052c1050507a@analog.com>
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
	TAGGED_FROM(0.00)[bounces-8326-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre-com.20230601.gappssmtp.com:dkim,analog.com:email]
X-Rspamd-Queue-Id: AB0CA2E6444
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 6:03 AM, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add DT bindings for the Analog Devices AD4691 family of multichannel
> SAR ADCs (AD4691, AD4692, AD4693, AD4694).
> 

...

> +allOf:
> +  # ref-supply and refin-supply are mutually exclusive, one is required
> +  - oneOf:
> +      - required:
> +          - ref-supply
> +      - required:
> +          - refin-supply
> +
> +  # CNV Burst Mode (pwms present) without SPI offload requires a DRDY interrupt.
> +  # Offload configurations expose '#trigger-source-cells' instead.

This sounds like a current driver limitation, not a wiring limitation.
So doesn't belong in the devicetree.

A driver could use e.g. timer wait for the conversion instead of an interrupt.

> +  - if:
> +      required:
> +        - pwms
> +      not:
> +        required:
> +          - '#trigger-source-cells'
> +    then:
> +      required:
> +        - interrupts
> +

