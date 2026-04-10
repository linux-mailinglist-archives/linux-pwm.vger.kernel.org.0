Return-Path: <linux-pwm+bounces-8554-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFuuCxFv2WnGpggAu9opvQ
	(envelope-from <linux-pwm+bounces-8554-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 23:43:45 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CEF3DD01A
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 23:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C4E630048FF
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 21:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537A03A7853;
	Fri, 10 Apr 2026 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="rowVptpZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280243DBD4D
	for <linux-pwm@vger.kernel.org>; Fri, 10 Apr 2026 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775857133; cv=none; b=sV04+i7i88QBH4v7/pLheUPL35oAPKgJR+sFe3rwv86EE95mwU/FC+PjwABhOuqbtgPgXmcg0/Aruz+zopYFRbHhr/piEhFe/E5kxVJa7GIcSjMpGUV8QPcVQHA90e05/zbIDPx2ZiEz7c0bk3jZzKZBqKi61rES9eesaoA6N8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775857133; c=relaxed/simple;
	bh=AfxJCGuDwawedT7P4I/1sW7q39LqQw75gWL8s0+dAh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ed9AIadkgdiV3YHKVhFiKIiGxZ+QL+/zqmRytN2dlo9g6HJLIb5rzPb39uAQ4MsJvBXkO1rrZ6NPWN5p+Xm6jrlYwaLuONXRE+ieDgyyMzQePODapzgSVJNS6xVx/6kYT/NdQxBSwQy3/JNcaKc2ntFDzs+HsNDRUeBgW/h7qdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=rowVptpZ; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7dbd08144deso2156940a34.0
        for <linux-pwm@vger.kernel.org>; Fri, 10 Apr 2026 14:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775857130; x=1776461930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eaFyqgC3R1GXm84D3GWzj8iqNT7a1oUcf/2QMWQlMeg=;
        b=rowVptpZ9UsLOgQik7lVyrdF6+0eY2gPqRnhkmcgu/6QsD99GYfkanNJsi2AKSIXD7
         88VqicmttTOrzlAWUidS213yc6pY8yVX8IksXXJQ3MYkEiGEiZxWpWQQecHNXXjq9/8C
         XZBGam90Cs62hlon1Ih5+sHpbdvigOtZMFLQXkSKX5xAlW7TuzoCZrozGYqMXrQCviuS
         79MPxY9ZkNpiu+PCEM6l4cEMO7buD0M6ZhQAqacUbbm57Nm5P50QuZBouVuGBMjAthKW
         eXNJ8GQEDbGefxYshH/1nBwLSFEoxuM+api7VjUBUmFZOgZdYjmBL9UPCFLvTpfkGy6T
         ctRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775857130; x=1776461930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eaFyqgC3R1GXm84D3GWzj8iqNT7a1oUcf/2QMWQlMeg=;
        b=IJtqHTPGiWOMMGdXxLuBD2t+ZuN/8GkTCKgWZQE8MgNH//xhDodmlqtKTIiREFznki
         iRvt3m70Gq51O+y01HNDiZgQwmhJy7voKZAOU3iitk7KZrSXkUnH0ZEIxDcqcar+P3wJ
         KKyD6g1IRjNEEDwZoxsA8t+m5SV94yWQMsWXKcz9x8Q6tfecqwWbGWsIQk8q8tY6qaZN
         oskTZL+rdL2lXhBuRv4RiVAb9IrlZkFwz52oVR839fEIe1bn9eUdepYIoGkxBJFsY/Ww
         0nrlLn/5YM/IfYVfi5UYxqAkUwbirBRO0D5AVRl+Sn3Q6r7l1+S+tc35x4t4YoKy2YH0
         NqOw==
X-Forwarded-Encrypted: i=1; AJvYcCUjF9b+25IVOgzlKQmyxk3qr1UH7WvXCaeCxdojNGF9rBiLeZ7qaBOH0DU3Nqsuwl4bkHqh/SPoi+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKNqcSZ9FjurYiskCPvxgp4cWtIk4nEt9zJYVrZCzX7CqLGgTQ
	A111k9bPEhTo/3mAKISLnIUZboyz01Lm76+KirGXnN0yx8KxwVxkNzHKHnE6nD9gDe4=
X-Gm-Gg: AeBDiesj84oQ95hONu1+gEIuMw03s6B1f7U0Qpzz7aCkc2qmHVd29+1KDmJ3zQjcWiH
	UyrXubLey0IdGDITnOkPCSUwG9g7jsu3eNGOUUHqq5qlXwrNyaWQ5hN4J7D3GqMckuFEhueOYac
	3tJM+Hbx+2BLSmU3kMqyDE3Nd8+fqCb2AE/GZhF67bs4hLb72Nnv+1waNXEXHSXdMHO4cM2zcVD
	VRu3QnPY+RtTNQzMV9InVybz4vIz1okF8AEH8OMaWF8/rlj9uws77JCo+ZBDnjqgGKL9XQq2zzz
	E4PJ+2u7ueE4eWqaYItueBodDBEFptK98hCuiN9pqyvWXpbp3p7p5E2hYCcvkxES0Vzzm6uOeQH
	yf8LStZENJmw4jtDsiN/VL/x/ynIAnaRVMky7Wk8yOkJXo3Yp334nwQaRunam1taXn1Cq7cDXpE
	UmlcsDtuO8l3gKDALNj9QZ7O7VcwycxD22fkD0i53oQtGgADuNbdG1BpzrnWuh78n5qTBENHhss
	Q==
X-Received: by 2002:a05:6830:498b:b0:7d7:f617:3573 with SMTP id 46e09a7af769-7dc27cbf49bmr3103286a34.10.1775857130046;
        Fri, 10 Apr 2026 14:38:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b75d:2440:dc10:808b? ([2600:8803:e7e4:500:b75d:2440:dc10:808b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc26941b7esm2736484a34.19.2026.04.10.14.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 14:38:49 -0700 (PDT)
Message-ID: <9c36ee85-12da-41e8-b9ab-e32b7ec29e75@baylibre.com>
Date: Fri, 10 Apr 2026 16:38:48 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/6] docs: iio: adc: ad4691: add driver documentation
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
References: <20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com>
 <20260409-ad4692-multichannel-sar-adc-driver-v7-6-be375d4df2c5@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260409-ad4692-multichannel-sar-adc-driver-v7-6-be375d4df2c5@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8554-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim,baylibre.com:mid]
X-Rspamd-Queue-Id: 83CEF3DD01A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/9/26 10:28 AM, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add RST documentation for the AD4691 family ADC driver covering
> supported devices, IIO channels, operating modes, oversampling,
> reference voltage, LDO supply, reset, GP pins, SPI offload support,
> and buffer data format.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  Documentation/iio/ad4691.rst | 283 +++++++++++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst  |   1 +
>  MAINTAINERS                  |   1 +
>  3 files changed, 285 insertions(+)
> 
> diff --git a/Documentation/iio/ad4691.rst b/Documentation/iio/ad4691.rst
> new file mode 100644
> index 000000000000..a1012c8b78a3
> --- /dev/null
> +++ b/Documentation/iio/ad4691.rst
> @@ -0,0 +1,283 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=============
> +AD4691 driver
> +=============


One overall comment. This goes into driver implementation details quite a bit.
I think that is really better done as comments in the driver itself. And this
document should just focus on how to use the driver from the userspace point
of view.


> +Buffer data format
> +==================
> +
> +The IIO buffer data format (``in_voltageN_type``) is the same across all
> +paths: 16-bit unsigned big-endian samples with no shift.
> +
> ++-------------------------+-------------+----------+-------+
> +| Path                    | storagebits | realbits | shift |
> ++=========================+=============+==========+=======+
> +| Triggered buffer        | 16          | 16       | 0     |
> ++-------------------------+-------------+----------+-------+
> +| CNV Burst offload (DMA) | 16          | 16       | 0     |
> ++-------------------------+-------------+----------+-------+
> +| Manual offload (DMA)    | 16          | 16       | 0     |
> ++-------------------------+-------------+----------+-------+

Not sure this table is helpful since all values are the same everywhere.

Also, doesn't SPI offload have storagebits == 32?

> +
> +In the triggered-buffer path the SPI rx_buf for each transfer points directly
> +into the scan buffer, so the 16-bit big-endian result is written in place with
> +no additional copying.
> +


