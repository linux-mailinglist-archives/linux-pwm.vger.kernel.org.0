Return-Path: <linux-pwm+bounces-3881-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C84179B01E7
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 14:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F651F22EE5
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 12:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3662022E9;
	Fri, 25 Oct 2024 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQoxykPB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DFB18B48F;
	Fri, 25 Oct 2024 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858059; cv=none; b=NTcUFBBQ6Y8JGFs1Ch2dqWY7rYwZTHhXuU3wf04S8XVsafoF0VWLnfEJHnsUQp+19fdP1VxCiKd+70RuxPDizzZFKRJPZb7Ja03ACovHawZm1KRzkpKfVh3FUjeCQAk/3WHa7Kjb8C8hDEwUqFqO4r7BR1P+plswwOjzpEWoURo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858059; c=relaxed/simple;
	bh=Fi7dXG4uaynmJ0n9RLdhB8ZP1J0VU4wgRJkJG9JJODY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YdlMvDrrF81ycBObcJg9bkvqq2dlroisfddG9trrDM1Ui4xeqYfxNj4+pAjlhxCPQZVQ9tyU+DRIwxRwOd+Fd6GeGoaXFNTZQHnAfHy9CphelQfTFXtjLVAy/DixKH9pYObkMrhLEREoKl+4LCfazsYIcU/EmLuKEarQ+5k5I+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQoxykPB; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d4821e6b4so1236470f8f.3;
        Fri, 25 Oct 2024 05:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729858055; x=1730462855; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IWsuk5W4z0hys3FesjB0y6f/oYwGY3GGML7np/7ZRwk=;
        b=VQoxykPBaUf7IYMnRou0CAs6OoZtu8ixvs5eLEG2/HoQnlRuNlyU8QRe/OJUYKIHnI
         xm1FQaLX0osmtLBFiUWsvYhvBVwdlkSzQ89txif0cJzQOMLtZ/dTwnQg1P1PKU4mutKg
         VnqBkDYbC3jPQY87CRQ01F1FmOxk5hT6mElU1FYRW0l21pDp9SatHR4nknODHzz4q+Oj
         miK93fdCwYLPOatykyAwh4zf7CmMpcRgKvL9ifG3fOZqHfZ+t7jM6fa+2wsiGPz3nccH
         dxGB3fYYXK5cLuWiVq7ymNh64ZInPDP8LHoKj5/RQbr/obT0QhBjmeAI/YG09LFzDPcj
         1ymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729858055; x=1730462855;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IWsuk5W4z0hys3FesjB0y6f/oYwGY3GGML7np/7ZRwk=;
        b=VfvQEeSxbmnHJkt4k47fjynPSWzUT6pEoEJNfa0V23RFNwD0x7TbrvbZ0a7y4/AnoA
         TBFp/5ihpqmhhEWgwFbix1uoWJOcAiWx992kH4GEXRgYv8zPwV+cSWg9s/AGyQNeTI2s
         dWKksZiAWXhjwG4UbWBqioNeixI19hzgzE8im1/gEHhEmIUnxrP4aEpQh2peC5b9xz65
         z/CsPrXWuSZYCcQ89sl3bvZiIKNO7545Jr+Q8A1Uhg5DU5cnTGLGqDaMmQ0Ikb5i9K3c
         183hl7fOywcdtgjGO2FyrkpZ5PIZGKJbu5nbZYvg4Q9gTFMBe95L/Y2kl5ORbyvj1XHq
         V/ag==
X-Forwarded-Encrypted: i=1; AJvYcCUogBWz9mIiGvoy5AyOjPDdMnpVZg4fjjrfHpkc6Ej8cEEmFCaXbcLYdj3djx5K05nFu2kDXyoLli0K@vger.kernel.org, AJvYcCVPVm02/vHcXhPG6TOMYak3Lqnx9L/+TYGNtSv+tOhkCGLTwYkjJYGuN7RrpBAqK160ZYGFq9WkWDctVuS6@vger.kernel.org, AJvYcCXahqvyL/RGhd5E+TzZ6ddMoxR7T+zu/Csp8gmAOgM7OzQwOJXH5ZR4KYz1d/VViMEjg1ArUcBppbmY@vger.kernel.org, AJvYcCXciPtNUhgT1gizKOlPnhDnYhMrmCBApOICyChcdvJFVnMKQnAWcJmTin6a8E7R64z7g9DKd4mHwVNa@vger.kernel.org, AJvYcCXjQemDTJxkkoiB8EsNqlAl8ePVJMAwki9WI+Fvuq8QOoc+0567xXPYqYi9dyDLJqJhUTTbQb7ubzyE@vger.kernel.org
X-Gm-Message-State: AOJu0YzCQIpzFtbAkHdx7oC0bEVAQnj9DzdImqqaP6YaRHusD3sBvtlB
	BzgRUqLfoXwvzxHECLajeKx3hoa0Iig2OD+iDZxI4rl84NHnsEw6
X-Google-Smtp-Source: AGHT+IFG/s/9pjlSrOD62Ubm5oO46WanxGuXBtDDnHqRg1d+Of3RBLbBi99eFc2jv9DF84GZ0kT77Q==
X-Received: by 2002:adf:a79a:0:b0:37d:5405:817b with SMTP id ffacd0b85a97d-3803ac83979mr2993845f8f.7.1729858054728;
        Fri, 25 Oct 2024 05:07:34 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b9279esm1346939f8f.104.2024.10.25.05.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 05:07:34 -0700 (PDT)
Message-ID: <b47e7168a58e840f65c1ef150c914c077905fabf.camel@gmail.com>
Subject: Re: [PATCH RFC v4 06/15] spi: offload-trigger: add PWM trigger
 driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
	 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
Date: Fri, 25 Oct 2024 14:07:33 +0200
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-6-f8125b99f5a1@baylibre.com>
References: 
	<20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
	 <20241023-dlech-mainline-spi-engine-offload-2-v4-6-f8125b99f5a1@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi David,

Looks mostly good... Just one minor comments from me.

On Wed, 2024-10-23 at 15:59 -0500, David Lechner wrote:
> Add a new driver for a generic PWM trigger for SPI offloads.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20
> v4 changes: new patch in v4
> ---
> =C2=A0drivers/spi/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +++
> =C2=A0drivers/spi/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0drivers/spi/spi-offload-trigger-pwm.c | 169 +++++++++++++++++++++++=
+++++++++++
> =C2=A03 files changed, 184 insertions(+)
>=20
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index d65074b85f62..50d04fa317b7 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -1286,4 +1286,16 @@ endif # SPI_SLAVE
> =C2=A0config SPI_DYNAMIC
> =C2=A0	def_bool ACPI || OF_DYNAMIC || SPI_SLAVE
> =C2=A0
> +if SPI_OFFLOAD
> +
> +comment "SPI Offload triggers"
> +
> +config SPI_OFFLOAD_TRIGGER_PWM
> +	tristate "SPI offload trigger using PWM"
> +	depends on PWM
> +	help
> +	=C2=A0 Generic SPI offload trigger implemented using PWM output.
> +
> +endif # SPI_OFFLOAD
> +
> =C2=A0endif # SPI
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 6a470eb475a2..3a76b9c61486 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -161,3 +161,6 @@ obj-$(CONFIG_SPI_AMD)			+=3D spi-amd.o
> =C2=A0# SPI slave protocol handlers
> =C2=A0obj-$(CONFIG_SPI_SLAVE_TIME)		+=3D spi-slave-time.o
> =C2=A0obj-$(CONFIG_SPI_SLAVE_SYSTEM_CONTROL)	+=3D spi-slave-system-contro=
l.o
> +
> +# SPI offload triggers
> +obj-$(CONFIG_SPI_OFFLOAD_TRIGGER_PWM)	+=3D spi-offload-trigger-pwm.o
> diff --git a/drivers/spi/spi-offload-trigger-pwm.c b/drivers/spi/spi-offl=
oad-
> trigger-pwm.c
> new file mode 100644
> index 000000000000..ffb0bf75cace
> --- /dev/null
> +++ b/drivers/spi/spi-offload-trigger-pwm.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 Analog Devices Inc.
> + * Copyright (C) 2024 BayLibre, SAS
> + *
> + * Generic PWM trigger for SPI offload.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/spi/spi-offload.h>
> +#include <linux/types.h>
> +
> +struct spi_offload_trigger_pwm_state {
> +	struct device *dev;
> +	struct pwm_device *pwm;
> +};
> +
> +static bool spi_offload_trigger_pwm_match(void *priv,
> +					=C2=A0 enum spi_offload_trigger_type type,
> +					=C2=A0 u64 *args, u32 nargs)
> +{
> +	if (nargs)
> +		return false;
> +
> +	return type =3D=3D SPI_OFFLOAD_TRIGGER_PERIODIC;

Hmm will we ever be in a place where a trigger provide might have multiple =
types? If
so, then I'm mostly fine with this match() callback. But we could still avo=
id it if
we use a bitmask for trigger types and having any trigger provider to give =
the
supported types. Then the core could pretty much do the match between the r=
equested
trigger type and what the provider supports.

> +}
> +
> +static int spi_offload_trigger_pwm_validate(void *priv,
> +					=C2=A0=C2=A0=C2=A0 struct spi_offload_trigger_config
> *config)
> +{
> +	struct spi_offload_trigger_pwm_state *st =3D priv;
> +	struct spi_offload_trigger_periodic *periodic =3D &config->periodic;
> +	struct pwm_waveform wf =3D { };
> +	int ret;
> +
> +	if (config->type !=3D SPI_OFFLOAD_TRIGGER_PERIODIC)
> +		return -EINVAL;

Checking the above every time seems redundant to me. We should match it onc=
e during
the trigger request and then just use that trigger type. Otherwise I'm not =
seeing the
point of the match() callback.

> +
> +	if (!periodic->frequency_hz)
> +		return -EINVAL;
> +
> +	wf.period_length_ns =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic-
> >frequency_hz);
> +	/* REVISIT: 50% duty-cycle for now - may add config parameter later */
> +	wf.duty_length_ns =3D wf.period_length_ns / 2;
> +
> +	ret =3D pwm_round_waveform_might_sleep(st->pwm, &wf);
> +	if (ret < 0)
> +		return ret;
> +
> +	periodic->frequency_hz =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC,
> wf.period_length_ns);
> +
> +	return 0;
> +}
> +
> +static int spi_offload_trigger_pwm_enable(void *priv,
> +					=C2=A0 struct spi_offload_trigger_config
> *config)
> +{
> +	struct spi_offload_trigger_pwm_state *st =3D priv;
> +	struct spi_offload_trigger_periodic *periodic =3D &config->periodic;
> +	struct pwm_waveform wf =3D { };
> +
> +	if (config->type !=3D SPI_OFFLOAD_TRIGGER_PERIODIC)
> +		return -EINVAL;
> +
> +	if (!periodic->frequency_hz)
> +		return -EINVAL;
> +
> +	wf.period_length_ns =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic-
> >frequency_hz);
> +	/* REVISIT: 50% duty-cycle for now - may add config parameter later */
> +	wf.duty_length_ns =3D wf.period_length_ns / 2;
> +
> +	return pwm_set_waveform_might_sleep(st->pwm, &wf, false);
> +}
> +
> +static void spi_offload_trigger_pwm_disable(void *priv)
> +{
> +	struct spi_offload_trigger_pwm_state *st =3D priv;
> +	struct pwm_waveform wf;
> +	int ret;
> +
> +	ret =3D pwm_get_waveform_might_sleep(st->pwm, &wf);
> +	if (ret < 0) {
> +		dev_err(st->dev, "failed to get waveform: %d\n", ret);
> +		return;
> +	}
> +
> +	wf.duty_length_ns =3D 0;
> +
> +	ret =3D pwm_set_waveform_might_sleep(st->pwm, &wf, false);
> +	if (ret < 0)
> +		dev_err(st->dev, "failed to disable PWM: %d\n", ret);
> +}
> +
> +static const struct spi_offload_trigger_ops spi_offload_trigger_pwm_ops =
=3D {
> +	.match =3D spi_offload_trigger_pwm_match,
> +	.validate =3D spi_offload_trigger_pwm_validate,
> +	.enable =3D spi_offload_trigger_pwm_enable,
> +	.disable =3D spi_offload_trigger_pwm_disable,
> +};
> +
> +static void spi_offload_trigger_pwm_release(void *data)
> +{
> +	pwm_disable(data);
> +}
> +
> +static int spi_offload_trigger_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct spi_offload_trigger_info info =3D {
> +		.name =3D "trigger",

pwm-trigger or trigger-pwm?

> +		.id =3D 0,

nit: Not really needed

- Nuno S=C3=A1



