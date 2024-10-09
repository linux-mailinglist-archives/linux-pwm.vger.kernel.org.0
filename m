Return-Path: <linux-pwm+bounces-3573-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EB4996EDF
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 16:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22B8281D45
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 14:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A9C126C18;
	Wed,  9 Oct 2024 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXnNrSNj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8655C1925BB;
	Wed,  9 Oct 2024 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485739; cv=none; b=D+6Y9o9UOggejdKj3tDsFm972jc3g8JgVjElh9HgYRJ+g9keZKA/wqjX0nxm/4toshHEo8eTGtRkpcZxsBBkns0+sNik+thtMh0ljIU76LI0mg0uThXx19yva6MExbKAOyU4awuf1dfkRyt1rIuzKdK4t9se6xXoxraC5FXaLkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485739; c=relaxed/simple;
	bh=WKqDfBMt2+San1ujEiAobO6HQc511/f7GYD5jNvUNt8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jJzux231ZToc/aMwpJGyeshs+dHgj9CwLvvJpz6Oktb11Wq7mHYegteehbau8KMSLAJNksZKOxLwGrqsd++f87R/Dqz9cF1MRwCix0I5VcwB+ylthSDCuR9ZPwPqCvMbWceraEehyez/XyHF2UHIiLxqArmGSx+Bkd5zVr6yYCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXnNrSNj; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fad100dd9eso70032501fa.3;
        Wed, 09 Oct 2024 07:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728485736; x=1729090536; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ib9pTBarNRQuNCwz+qBm/wz+0ti+ak4vscLv1XgOMQg=;
        b=dXnNrSNjqdzSmmITLNUsCfUMhUKm5y+FVgHggvJslbz1jY/pAwXzakwCV3jr4VfvSG
         +GmWKeRbnQuqvjEtwkJuxRsxEAaefh24vHFVGzPDdOPXEdR4Psj0xdfTujZl34+3PzY/
         FQ7Jt3XnPofD2h6h3/7Qh7qfkR+J3WJ1+DjbUEvs73LcYjp27Blm/DpwbwZJFbjcsWxz
         YbVEVI7YmMRL5Y7mJIWwi4jXgcVLc0a1eQRCJtJVBDWO4TMPyD1py5T/MIiNnK3BtJ+Y
         uaiLwFpV7O6ZeZcVoHztDqysIfjUHxoOqV6bL4ONpVagPlICdZ330Co6trImsqP1+0js
         wZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728485736; x=1729090536;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ib9pTBarNRQuNCwz+qBm/wz+0ti+ak4vscLv1XgOMQg=;
        b=D3WRq1wy4McWMxpH/c+yzXnkFjfzsmMxg+V9ltapVroHlQamaIOEz343JhABmI38BD
         JB/X7MDvpMrT9AsF0MzNPxB9qgn6iKMzDUzsM3U1728LjpHfYUadumDue24VJbaiFC3m
         ijrznSDNLyZQp0fcorkXJMElllPZZqXXXdxnvOufqp7B9OssfPG67VhBYmc44irBbnAA
         QNHbld8iGN/uB6MCSZIxxvwJYNfBfHQaTsWokAwKOeAHzIAG8fbulgcEFvRzZ2/9KyMQ
         J1pV5+OoGseQb1t9DAks7oMEawm07wd+m4AZx2jlm+Hye3vXAeR5tlFPYA4mtFPup/0V
         VU1w==
X-Forwarded-Encrypted: i=1; AJvYcCUOwXzxcLhkZ2ZfgCqftKQTgo6zR0X2/n3/w1eZpBlOuDKq4UkFlhSDMZCan6lURh1ZZoL/d+H9afAA@vger.kernel.org, AJvYcCV+SIS1uO00aPORM5SQW51rQK+xSJvNWRWeOC3UDd/fQ8brNlMe61fTAm4DqVggHclpJi9t2dvQx9Q691yq@vger.kernel.org, AJvYcCVcnnL7JVvdfRurNgzw5NCYNRItIussJ3OwpdSzFm8AX7I8hstJ1YEFHXxYHfZfAZcXraBWH9PS1rj2@vger.kernel.org, AJvYcCVzSscGQmo+dQmzFkBL7UlXtWja7/jGMcQXhpCRMmi/DctvUAYq9nEZsLj55JaaddtHd4IpdEbr0NTuCgI=@vger.kernel.org, AJvYcCWgrXhPyYNVUu7NxAZVWjPMA5SBQU1/DI6aHK1lPSi+fGKbghbiiqrpk7Sn23WafOnX1jS0JbPcSZw0@vger.kernel.org
X-Gm-Message-State: AOJu0YzqoBwmcad5A5VX4SqtnI0jws5vIpfHyVn47LWZ12OylUQWbaQZ
	edWQpfPUHJ7DXgSqDDwZYLtGSL/60fnm0QBeZnkULBcRC+zJIWBn
X-Google-Smtp-Source: AGHT+IELRKbRjHccAAmXS1Grd+rb5wmXwLUO+kxGpjzcE5qfCHJPhxFU6mlM6e/UKadHfK2GZPlKjA==
X-Received: by 2002:a05:651c:2222:b0:2fa:e52f:446e with SMTP id 38308e7fff4ca-2fb187212f1mr18024161fa.3.1728485735231;
        Wed, 09 Oct 2024 07:55:35 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05f22bbsm5579853a12.80.2024.10.09.07.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 07:55:34 -0700 (PDT)
Message-ID: <66a4daad65dc8dbb319af38e26ee4290b08c7bff.camel@gmail.com>
Subject: Re: [PATCH v4 7/8] iio: adc: ad7606: Add iio-backend support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Guillaume Stols <gstols@baylibre.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com,  dlechner@baylibre.com, jstephan@baylibre.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Wed, 09 Oct 2024 16:55:33 +0200
In-Reply-To: <20241009-ad7606_add_iio_backend_support-v4-7-6971a8c0f1d5@baylibre.com>
References: 
	<20241009-ad7606_add_iio_backend_support-v4-0-6971a8c0f1d5@baylibre.com>
	 <20241009-ad7606_add_iio_backend_support-v4-7-6971a8c0f1d5@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 09:19 +0000, Guillaume Stols wrote:
> - Basic support for iio backend.
> - Supports IIO_CHAN_INFO_SAMP_FREQ R/W.
> - Only hardware mode is available, and that IIO_CHAN_INFO_RAW is not
> =C2=A0 supported if iio-backend mode is selected.
>=20
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---

Just minor stuff...

> =C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 2 +
> =C2=A0drivers/iio/adc/ad7606.c=C2=A0=C2=A0=C2=A0=C2=A0 | 156 ++++++++++++=
++++++++++++++++++++++---------
> =C2=A0drivers/iio/adc/ad7606.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 15 +++++
> =C2=A0drivers/iio/adc/ad7606_par.c |=C2=A0 93 +++++++++++++++++++++++++-
> =C2=A04 files changed, 234 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 85b82a708c36..9f7e9fc4b1fe 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -224,9 +224,11 @@ config AD7606_IFACE_PARALLEL
> =C2=A0	tristate "Analog Devices AD7606 ADC driver with parallel interface
> support"
> =C2=A0	depends on HAS_IOPORT
> =C2=A0	select AD7606
> +	select IIO_BACKEND
> =C2=A0	help
> =C2=A0	=C2=A0 Say yes here to build parallel interface support for Analog=
 Devices:
> =C2=A0	=C2=A0 ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital conv=
erters (ADC).
> +	=C2=A0 It also support iio_backended devices for AD7606B.
> =C2=A0
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the
> =C2=A0	=C2=A0 module will be called ad7606_par.
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index ec902b268388..1313b5cbb0aa 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <linux/units.h>
> =C2=A0#include <linux/util_macros.h>
> =C2=A0
> +#include <linux/iio/backend.h>
> =C2=A0#include <linux/iio/buffer.h>
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0#include <linux/iio/sysfs.h>
> @@ -191,6 +192,7 @@ EXPORT_SYMBOL_NS_GPL(ad7606_4_info, IIO_AD7606);

> =C2=A0const struct ad7606_chip_info ad7606b_info =3D {
> =C2=A0	.channels =3D ad7606_channels_16bit,
> +	.max_samplerate =3D 800 * KILO,
> =C2=A0	.name =3D "ad7606b",
> =C2=A0	.num_adc_channels =3D 8,
> =C2=A0	.num_channels =3D 9,
> @@ -496,6 +498,20 @@ static int ad7606_pwm_set_low(struct ad7606_state *s=
t)
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> +static int ad7606_pwm_set_swing(struct ad7606_state *st)
> +{
> +	struct pwm_state cnvst_pwm_state;
> +
> +	if (!st->cnvst_pwm)
> +		return -EINVAL;
> +

Can we get into this function without knowing cnvst_pwm must be present? IO=
W, do we
really need the above check?

...

> @@ -96,9 +170,23 @@ static int ad7606_par_probe(struct platform_device *p=
dev)
> =C2=A0	void __iomem *addr;
> =C2=A0	resource_size_t remap_size;
> =C2=A0	int irq;
> +	struct iio_backend *back;
> =C2=A0
> +	/*
> +	 * If a firmware node is available (ACPI or DT), platform_device_id is
> null
> +	 * and we must use get_match_data.
> +	 */
> =C2=A0	if (dev_fwnode(&pdev->dev)) {
> =C2=A0		chip_info =3D device_get_match_data(&pdev->dev);
> +		back =3D devm_iio_backend_get(&pdev->dev, NULL);

Can't we use device_property_present()?=20

- Nuno S=C3=A1


