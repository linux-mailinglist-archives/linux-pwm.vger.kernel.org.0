Return-Path: <linux-pwm+bounces-8473-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGeIDHIf0WmmFgcAu9opvQ
	(envelope-from <linux-pwm+bounces-8473-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 04 Apr 2026 16:25:54 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB71339B5C4
	for <lists+linux-pwm@lfdr.de>; Sat, 04 Apr 2026 16:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 983B9300D687
	for <lists+linux-pwm@lfdr.de>; Sat,  4 Apr 2026 14:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2135296BDC;
	Sat,  4 Apr 2026 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="T+tHPtq/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBB6291864
	for <linux-pwm@vger.kernel.org>; Sat,  4 Apr 2026 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775312748; cv=none; b=j/sXFk4bcXdtbKfsn+Dpv8TWe8JMIDB6okXyAV15U8W2W0hDslB6t2Q7ShR6goYAVciUdLnmfJYWoI0f4YAyDpq4+zDw8h/Ah6yXqVrdGk335HzedJ8rwIB4PY4WpFZUMuz1XPpXsTJmDYUyx0mh5G1+iNkQjSIk5DCHy5qcX/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775312748; c=relaxed/simple;
	bh=YDHQQIkUtIMA5RuVXX+SK+ZopnAIz0IH3aZAqaHI9pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awrcqZbuehkfW16guhD5w5k9MlRie7ysVimswv2mpZTLXk5YrmPzz2y4Vai+FTJ6Fsu2rtsMCvs/q2IUjAitoIMWGREe+honJQuPXdoHIdk3ZOXjhTIV4kiBXc4bRv/osVaZJ17emp0RWWN0KeaZ9x25xLDLGx4ikwyfg95gMrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=T+tHPtq/; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-46fb6d65c28so338366b6e.0
        for <linux-pwm@vger.kernel.org>; Sat, 04 Apr 2026 07:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775312745; x=1775917545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DG8ZLzSkLL5KxGbpBt+cYKmm52XpYZesZWRmcIu235A=;
        b=T+tHPtq/ZJmrz/x0hon6ubvef3dyaaHhk1GRRXgW8y8HepFtZGYjfJcUQczd3MEkSt
         2Agviun9Cf5EYKtk9j0IqUraHya5+cWg7jpTqs6odctBlL2Zz+DNQ/uNqQMe9wgH193o
         z3zeYYVklZaMQki3yiMddob47zunpO6AWKU8n5PWDQ6LxULv6X3f1wcyghb+It/+xjWX
         z9PNVkRx7eWxmjJNLwRnRuJlliHjZbQNuYTor2Ij+hbvfTGn47XIa2O2GDia9HEi0TFp
         QBOE28LuVqSi18lbs2VxGAN1lYamyOifHSPJ/JYonO7K4FYFJ/G3E8jlIr/y0xjtfZ+C
         UNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775312745; x=1775917545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DG8ZLzSkLL5KxGbpBt+cYKmm52XpYZesZWRmcIu235A=;
        b=nDoiG8fdhzP9n88Xa0W09e6N6ZgnkoUfcnR+uG4WHa8g8cnHeBYru5ytg50v14lx6U
         GAZKMJW5+h6gQbrviwdqORIuQZy1YiO9tiHScNarj5J1RiNTdeEYHw2T7fcIgTITaAr8
         qB9GyPt8fVARQteyIuav0Sl1HguawhgAcR8G+aDkDl79O5VUB81AclIFLbQkz92Lc/oJ
         CQI9mmtofE+xeHuHPQcQuPwp1FGHhWTfjxJI2ljsYz9ms3/cfZP40itX+tBXAEEVeXFo
         fPYC66eFwXwxI5nJiON+Vy8zBWeDLdKVVGOwSp8Puq+wb4I8hkWfMYwYW0aPqzJEj01N
         Gnug==
X-Forwarded-Encrypted: i=1; AJvYcCVrShlEBSwKrHRZ7TnoXQBJ/VJWGXwZGkfAf9D+WnSGCLUEhqGCMQmztTahxX/a3iJufFXCJPjcEI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtm7wSK+yBjwz1B0Xk5Dzy390v5hqUseZRmJJ9MtGmhVePcOkN
	mvqiSnmnieUdoaFuqVPOaaQoZ0T3Z34q3y+xbMoNbcWOR9HiKFhXRsxOhQmCMahHSyY=
X-Gm-Gg: AeBDietbTPWspmvBLUDr4z6s7EskzK5h3ODNzD9O+MaJGt53DHla5mG3WCvFnmC49lo
	mg/wWYDWziz+sc6r+BzRkJS7J3XU+c/V18tP08UuhuOBwlbjmUZulxLVEwYLyqQDEpJrYpIBXJU
	Ijj5GSRlVfIX2zStEGr6/55GvixygEXquNnXmvV3jrvLFH+ED23WOf8IudRMxhSgt9pER75cXR0
	tkLVoX0EbesGIa0RHTqh1Ay8NmsD6Blxdz32pv4KNPyx5mWXdRzTs80YfdksOUsdbX4TEKa7jwG
	n4rr3om+HGD17qMhFpGDTno3gcu7gR21Sue0n9swvIr72sLp97LTBe7u6jqyQXS8u+Ypr3dbnob
	SHTeaS5RuBWgUqZNZWLJf+I20KEWwceARgm6YbsYJUiG1bSGV+sfFvqiFaAJZLV7n/Ma5AiWtO4
	OobEWWnLYhY3MpYreU2I1Zdfp3/IgdmFo34E5zIGL5hWqRgOe13Rt3W1jg5ggMIqOQCb9YXdhk4
	g==
X-Received: by 2002:a05:6808:1206:b0:46a:8dd5:3a4f with SMTP id 5614622812f47-46ef5002b8dmr3010289b6e.5.1775312744846;
        Sat, 04 Apr 2026 07:25:44 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e14e:bcc6:3f95:26eb? ([2600:8803:e7e4:500:e14e:bcc6:3f95:26eb])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46f0f4e16a9sm2936944b6e.4.2026.04.04.07.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 07:25:43 -0700 (PDT)
Message-ID: <e4ddf44e-3189-4d4a-9184-13b0560195dd@baylibre.com>
Date: Sat, 4 Apr 2026 09:25:41 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
To: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com>
 <20260403-ad4692-multichannel-sar-adc-driver-v6-2-fa2a01a57c4e@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260403-ad4692-multichannel-sar-adc-driver-v6-2-fa2a01a57c4e@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8473-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB71339B5C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 6:03 AM, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add support for the Analog Devices AD4691 family of high-speed,
> low-power multichannel SAR ADCs: AD4691 (16-ch, 500 kSPS),
> AD4692 (16-ch, 1 MSPS), AD4693 (8-ch, 500 kSPS) and
> AD4694 (8-ch, 1 MSPS).
> 
> The driver implements a custom regmap layer over raw SPI to handle the
> device's mixed 1/2/3/4-byte register widths and uses the standard IIO
> read_raw/write_raw interface for single-channel reads.
> 
> The chip idles in Autonomous Mode so that single-shot read_raw can use
> the internal oscillator without disturbing the hardware configuration.
> 
> Three voltage supply domains are managed: avdd (required), vio, and a
> reference supply on either the REF pin (ref-supply, external buffer)
> or the REFIN pin (refin-supply, uses the on-chip reference buffer;
> REFBUF_EN is set accordingly). Hardware reset is performed via
> the reset controller framework; a software reset through SPI_CONFIG_A
> is used as fallback when no hardware reset is available.
> 
> Accumulator channel masking for single-shot reads uses ACC_MASK_REG via
> an ADDR_DESCENDING SPI write, which covers both mask bytes in a single
> 16-bit transfer.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
This patch looks in good shape. Although I wouldn't mind using
MEGA/MICRO, etc. more in numbers with more than 3 or 4 zeros.

Reviewed-by: David Lechner <dlechner@baylibre.com>



