Return-Path: <linux-pwm+bounces-5718-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133AFA9D464
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Apr 2025 23:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A69817B23EC
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Apr 2025 21:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783D42253F9;
	Fri, 25 Apr 2025 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ecdIgtzW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F272253BA
	for <linux-pwm@vger.kernel.org>; Fri, 25 Apr 2025 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617467; cv=none; b=J28VCxXwPFX4fTZCdAMRHhCdK4u/ynOJsFccIpsl4Pvi8wRsCBGDXdYxNPjNIK/+TkKQ7ZAFbEbMmLQk2b5O69RWY+6knNuEtQe8pWTnUP+rLmzs42jJLAChC512XOCJGrcLuQJ0L+wroM9Po0XfwBuu1ylzrF8gui141EPXF3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617467; c=relaxed/simple;
	bh=0PGOU404WR3ZZT5UO5ZutPGEui+7NlIYTJrsKba4mAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0HyjNOZztrZV5PMWRwdaL65O+u6uZ/P4bxdkBRKUrrIhpNNQ2WGrdqo0AJgMWDA9TBtcyZrBJbBCbEbzPvDnluM5PFs9AF6au45JQ9TdG73uwW2jAjB88VI8C6GRzp5GAUnfYHeMwqQ07tcEihBNbkAwNSJfn9cZ1iwDz5ogrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ecdIgtzW; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3fea0363284so1854867b6e.1
        for <linux-pwm@vger.kernel.org>; Fri, 25 Apr 2025 14:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745617463; x=1746222263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vetl9XpldH8JvL8GlwOYXmdLs3vxDNII55h0sSj3lYc=;
        b=ecdIgtzWNSzsQn2U0k23mm0eBPvHL1C1TcUx5drufKdFJWPjIQ7GsvtCZNtt5PLkrQ
         WnTYAnIngoJxMKPjvGQiafQHc11uLmi+6WacfOsAoF51wtpj5OD1KLHbuqOxW9MJ+gqu
         5dnK7M15p2Ba7STyIzHw8yQ2C07rw8o15cRsmQMj8XCNaYuV4Xz4PUCW26zxhpCC1VG5
         46kunNXqj5N6793pab6hLib2fv9d4od8dWNR/iV2yFkzw4n8YTPKs+UFmFcwE9gaYloe
         CVGYnFNqsC2iAGruFEhIv3ZuPkZEJxVIArXn+geM9L4Mb+yzI1VWxaB1nUXsqcfJTKI3
         kjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617463; x=1746222263;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vetl9XpldH8JvL8GlwOYXmdLs3vxDNII55h0sSj3lYc=;
        b=HgQSe2phZev9Uh9hXee4ZFB+TK5Gf4QeFs4RHMwG3yvmhtk4SEv6WidsjktQuxDgL8
         xKnVbZIqGrteoVFu9O5NEv6X1OtetwlNw7W58C1MQ/Dj1PVimt5JLJiRMG/01pDD1TOj
         CYD8oHYBxtNmEGAUYSRFzqUK9pdqvhy7GCbP2xjyIDs4V82qagpcjIwtcAeSL9zXbDLK
         KxTlWHyXctzFaddHBygoHxu+v51rou/7PRbAlfDXrocXD+ZhKFNJ2HxlCiPQ86LjoFvy
         HWFo8EWUG0qVH5pIcPK5oANW5BnJsYkI77ch4EF4ZYUu73ARrdQKUFyqA93FB65GFp/Q
         svKA==
X-Forwarded-Encrypted: i=1; AJvYcCWQD67EGVvZ7CGPjg/gJE8//rAI0jNBBvGZcAx6SyC9odYZnVF9oOvtnNgaUArWYoPUGL0uOEcecIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm1tfOjeDYCmq304FMpxv7981tZkSF3VYJyO4BGbdcctraW+TJ
	FWfgpTIYOXdQfPiXeodzArs5gLw2hwVnolXjw6fskFcotIRNyRuwBPtEvTZmMX8=
X-Gm-Gg: ASbGncvSJPHx/plyKuMFjqrRe491moYreSAmLorXRdliKcapUjK87IPrja/attgWrAU
	s8QTUMUfm60j+Sk1VvZ+tHtbqVs0pBPxTNop3LdBLng7r7sN6C5lrF9eO173NHxGnlRcap/YL8V
	kpmE+fc/QWrQK+ikrK93SIRR7scncGLYrYRPB4JX4zwkAdeL+Z1CfHJTOESAxMljjbWv2Iy9/Jx
	zg/D+O0Of7l3Ylvm7DoAxcXDSqRJuEIscigUQ9YKSo9HSiOvkUtPjucjO/jxP+sJNZijnWKTsSf
	KaHvoaU89N8XEaKBUajU4a/1lyE9gNR6ky+0Ozlh7JbNWpKFSbzjjYJRnE50JOqtQcPyEJBlZyN
	GuhjrB3Gg4wLd
X-Google-Smtp-Source: AGHT+IGYSYK/NgbfRtntiLX0fyD882sY0Y9kI7JKZ0e9QJqEQnnrOLa7rFd/SxmE01a29TeJbZfoUg==
X-Received: by 2002:a05:6808:178e:b0:400:fa6b:94bf with SMTP id 5614622812f47-401ec44c715mr4767354b6e.4.1745617462686;
        Fri, 25 Apr 2025 14:44:22 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:96a3:e28:3f6:dbac? ([2600:8803:e7e4:1d00:96a3:e28:3f6:dbac])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401ec8afb1esm939069b6e.10.2025.04.25.14.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 14:44:21 -0700 (PDT)
Message-ID: <9f5b0709-f795-44c5-aa64-aaed81a459bf@baylibre.com>
Date: Fri, 25 Apr 2025 16:44:20 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] docs: iio: new docs for ad4052 driver
To: Jorge Marques <jorge.marques@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-4-638af47e9eb3@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250422-iio-driver-ad4052-v2-4-638af47e9eb3@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 6:34 AM, Jorge Marques wrote:
> This adds a new page to document how to use the ad4052 ADC driver.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---
>  Documentation/iio/ad4052.rst | 95 ++++++++++++++++++++++++++++++++++++++++++++

Also need to update the table of contents in Documentation/iio/index.rst,
otherwise this page won't be build (and will cause a build error).

You can run `make htmldocs SPHINXDIRS=iio` to speed things up and only build
the iio directory to make sure you have it right.

More info: https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html

>  MAINTAINERS                  |  1 +
>  2 files changed, 96 insertions(+)
> 
> diff --git a/Documentation/iio/ad4052.rst b/Documentation/iio/ad4052.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..410aaa437ed5fea6a2924d374fa5f816f5754e22
> --- /dev/null
> +++ b/Documentation/iio/ad4052.rst
> @@ -0,0 +1,95 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=============
> +AD4052 driver
> +=============
> +
> +ADC driver for Analog Devices Inc. AD4052 and similar devices.

Please don't put newline after every period. Here and throughout the document.
It makes it harder to read.

> +The module name is ``ad4052``.
> +
> +Supported devices
> +=================
> +
> +The following chips are supported by this driver:
> +
> +* `AD4050 <https://www.analog.com/AD4050>`_
> +* `AD4052 <https://www.analog.com/AD4052>`_
> +* `AD4056 <https://www.analog.com/AD4056>`_
> +* `AD4058 <https://www.analog.com/AD4058>`_
> +
> +Wiring modes
> +============
> +
> +The ADC uses SPI 4-wire mode, and contain two programmable GPIOs and
> +a CNV pin.
> +
> +The CNV pin is exposed as the ``cnv-gpios`` and triggers a ADC conversion.
> +GP1 is ADC conversion ready signal and GP0 Threshold event interrupt, both
> +exposed as interrupts.
> +
> +Omit ``cnv-gpios`` and tie CNV and CS together to use the rising edge
> +of the CS as the CNV signal.
> +
> +Device attributes
> +=================
> +
> +The ADC contain only one channels, and the following attributes:
> +
> +.. list-table:: Driver attributes
> +   :header-rows: 1
> +
> +   * - Attribute
> +     - Description
> +   * - ``in_voltage0_raw``
> +     - Raw ADC voltage value

No scale attribute? How do we convert raw to millivolts?

> +   * - ``in_voltage0_oversampling_ratio``
> +     - Enable the device's burst averaging mode to over sample using
> +       the internal sample rate.
> +   * - ``in_voltage0_oversampling_ratio_available``
> +     - List of available oversampling values. Value 0 disable the burst
> +       averaging mode.

Typically 1 means no oversampling, not zero. (It is a ratio, divide by 1 is the
same as doing nothing, but divide by 0 is undefined.)

> +   * - ``conversion_frequency``

Needs to be updated to ``oversampling_frequency``.

> +     - Device internal sample rate used in the burst averaging mode.
> +   * - ``conversion_frequency_available``
> +     - List of available sample rates.
> +
> +Threshold events
> +================
> +
> +The ADC supports a monitoring mode to raise threshold events.
> +The driver supports a single interrupt for both rising and falling
> +readings.
> +
> +The feature is enabled/disabled by setting ``thresh_either_en``.
> +During monitor mode, the device continuously operates in autonomous mode until
> +put back in configuration mode, due to this, the device returns busy until the
> +feature is disabled.

Probably worth mentioning the ``events/sampling_frequency`` and
``sampling_frequency_available`` attributes since we've mentioned all of the
other attributes.

> +
> +Low-power mode
> +==============
> +
> +The device enters low-power mode on idle to save power.
> +Enabling an event puts the device out of the low-power since the ADC
> +autonomously samples to assert the event condition.
> +
> +SPI offload support
> +===================
> +
> +To be able to achieve the maximum sample rate, the driver can be used with the
> +`AXI SPI Engine`_ to provide SPI offload support.
> +
> +.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/ad4052_ardz/index.html
> +
> +When SPI offload is being used, additional attributes are present:
> +
> +.. list-table:: Additional attributes
> +   :header-rows: 1
> +
> +   * - Attribute
> +     - Description
> +   * - ``in_voltage0_sampling_frequency``
> +     - Set the sampling frequency.
> +   * - ``in_voltage0_sampling_frequency_available``
> +     - Get the sampling frequency range.

In the driver, this is currently info_mask_shared_by_type, so would be
``in_voltage_sampling_frequency``. And there currently isn't 
``in_voltage_sampling_frequency_available`` in the driver, so it needs to be
added in the driver (or removed here).

> +
> +The scan type is different when the buffer with offload support is enabled.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 81fbe7176475c48eae03ab04115d4ef5b6299fac..04aa8db44bee418382a2e74cb6b1d03a810bd781 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1334,6 +1334,7 @@ M:	Jorge Marques <jorge.marques@analog.com>
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
> +F:	Documentation/iio/ad4052.rst
>  
>  ANALOG DEVICES INC AD4130 DRIVER
>  M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> 


