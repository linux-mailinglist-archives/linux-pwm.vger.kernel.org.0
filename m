Return-Path: <linux-pwm+bounces-4362-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CBF9F49F3
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 12:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A1EC7A314A
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 11:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363FA1F03C8;
	Tue, 17 Dec 2024 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asaOGZ8N"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147341F03C7;
	Tue, 17 Dec 2024 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734435121; cv=none; b=f7jih4IejA1pARUn4LxF4IefKWklV38BamXI8GMJGMIkHKcrmBsJk+79EQC34TMx7dWFyHNZgtTvI2WrMoyq1z+GJf81xyMLS8DH4SPlJc5MTQZR3NoX6A5qGZYAw0wjQwvCMpHzzi2UMPYhlSxsZ6F+vdu5l4wnDMY/RzFeFek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734435121; c=relaxed/simple;
	bh=pFhHw9TiwsKQJTlbvS9U5XLcZZ5zByvjoUTCSVDUH/k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s4T6wcwwWOaDVRZ9ScZ0s4aJrY18T0YEu2blQ+a/7ly5D0pXlcKbv3oBOzkXaMPxLfdRb2k69c1EfxNbQnDsBvos2xEsFa1c1em49ifzAsbjtykc4aoxpbYtcPpBzAvliMcEOCgmM7on3yoLI7VAGD9ct0RhCTuWNw6T9mpRubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asaOGZ8N; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso9662984a12.1;
        Tue, 17 Dec 2024 03:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734435117; x=1735039917; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fjIE9d1f0BtVKw2eM2yKIJI7JQ6q6MDNmTA49O7o8fQ=;
        b=asaOGZ8NIDts6u9MKQlG6Uy5ZP3l6s/HYuEh5VHUdJxpFuPrpHJxdXFn/2tXhXRbLf
         Dh5rbxUZN3vyeorQEyRYpFFnPm64xsWyZeh61mrHDhxJo5URcUg4Bx7eI8R/42iyPunE
         HrekAxL+W5sI1z31hXwRpftFyVc4c6i3E8EhonLH1wsMTkO4sEmAcotEzIZuH4TsWCnd
         zFgsGuvK+aHlNGXX8+v1LsRJaTYg0qGWSUQWIcuoM/BGsY6vsiENmrDtQiuObz2+moNU
         GvEOyKoDX1xuBb4r01BHDqv9+wUPyjyCMjrhk5TG5j+F2oEc1yDCATxvbx2yyJdcKFvk
         BPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734435117; x=1735039917;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fjIE9d1f0BtVKw2eM2yKIJI7JQ6q6MDNmTA49O7o8fQ=;
        b=iLDmDqGyCRz/ZCxGLFIpj3+i+go/C79OMf3EWye0/uxZp2wI77sR2kTvUBnPn6Mwr4
         JI0h/BGw1z0D4npg+vTvt4DufVunuwiU1jTB6HUeRtqgiNmixkSQ4S4J7YY68AVTM8JL
         QByllUpy/pALAk0irV1a+ZnizWrPEm5nmILXTZD92QX+yi2fSJSg+HeMgVThHkc7cWSQ
         mUFlTJ+8h9BOUDYV7jWUngbd7in0vGZb5cXcm9SEQUMnN5HN9vZHWfxU/nwCSYPiOzm/
         Bxu9/Zy3adN2CteXwabzH+Okjwu+he0jfzRiEilzshuBQg82l+x9gkhCoVOKeeEst1Ak
         79oA==
X-Forwarded-Encrypted: i=1; AJvYcCU8g+AXdW7on7g/EeNs5dyLH7WH2lSdJgOBXv1YLH/kPbt7EB4qmYW5vmd8JClhXvNNfHRmM5qGp451@vger.kernel.org, AJvYcCUGv7BIDUvmsppEvLHqXaTm2vtfB0gdLuq3AmNYJu/YNjuKL101ilgfXOLgFn8qCz+LM2vCi11O3qbC@vger.kernel.org, AJvYcCVBpYXd6Rm/VzvkWTJdaVprc/OhSBwg+6f5f2Hh9iwIa3uesRDBUEJex+0VBsPvPGbzvJAo70by8EUV@vger.kernel.org, AJvYcCVN2iJlSTXUEQ5OLVl5kkl8kqjIIKHmk/MXnI0RK/y1rwQ7q0fJ5Mbp0CLlI/Xr4b2IQujpH3Np8oEHK6CS@vger.kernel.org, AJvYcCXokTpUVJs580UaSbhR5QBYPktY4ECKEBW8RlOuN8yEm7RZVujJnqxhWNf6KjdDeCg/dRjoOCQtGyCv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4WNuQEwM3+boGaCJJwTvAmM7cgqvhDIioKudXmkpnIbt45yBK
	wd8itGtM0yShv+o2IS81tf9dzfzaS55yoy5F0hNlNmrrwMOwYpupt+/H35VeLdo=
X-Gm-Gg: ASbGncuzNKHP5gyk7U+bRksNRHspFRoAhp4hdLAvWUdi1zKGFz6hNuU9i3GBfp8AkiM
	4v/8LCLcICLb1VnWDjMkfaDGpYN5a58Rx1UASNbM03pquSSGMuLxHn1PIFNugPjwg4gJ71qTv8D
	0bvNmhOCYLbcoB1ZISKQeF6Sj6h1Fa7wnUtFeriZREWqqD+ZyogAb7wtYY9ThZ/tYeBTaklMgrJ
	cKpKtdVoHM1i24FPOUIh91QS3YcFVomPIMcQ+txfDgwHkiBWYP5HDuhNJIadJhncGlCkcFqTLmn
	qoUkC4dg7PksDbL7sDVn8P3S8LuC82m4rvZeBW0e/dADe40LHaRVeqX1pnXRr8k1LUmGSMjmIZY
	iG0JFyukLDXwUfQ==
X-Google-Smtp-Source: AGHT+IF15DfoymSo9ONl90SbVJppooe4TNTzkzNmP0y64abBk93He1PG7Ap5ZfuLJG7giGy1hTJhLQ==
X-Received: by 2002:a05:6402:27d1:b0:5d0:d0c5:f259 with SMTP id 4fb4d7f45d1cf-5d7d556c7femr2664125a12.3.1734435117012;
        Tue, 17 Dec 2024 03:31:57 -0800 (PST)
Received: from ?IPv6:2003:f6:ef10:f100:a045:a7a7:11d0:8676? (p200300f6ef10f100a045a7a711d08676.dip0.t-ipconnect.de. [2003:f6:ef10:f100:a045:a7a7:11d0:8676])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652f351c8sm4371003a12.79.2024.12.17.03.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:31:56 -0800 (PST)
Message-ID: <d329ec5e035ec89944a73457bf14111a7318b6e9.camel@gmail.com>
Subject: Re: [PATCH v6 04/17] spi: offload-trigger: add PWM trigger driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, David Jander	 <david@protonic.nl>, Martin Sperl
 <kernel@martin.sperl.org>, 	linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, 	linux-pwm@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Date: Tue, 17 Dec 2024 12:36:27 +0100
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-4-88ee574d5d03@baylibre.com>
References: 
	<20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
	 <20241211-dlech-mainline-spi-engine-offload-2-v6-4-88ee574d5d03@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-12-11 at 14:54 -0600, David Lechner wrote:
> Add a new driver for a generic PWM trigger for SPI offloads.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Still don't really agree with always checking against
SPI_OFFLOAD_TRIGGER_PERIODIC. But yeah...

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

>=20
> v6 changes:
> * Use dev instead of &pdev->dev
> * Swap order of "pwm" and "trigger" in name to follow "pwm-clock"
> =C2=A0 precedent.
>=20
> v5 changes:
> * Updated to accommodate changes in other patches in this series.
> * Add MAINTAINERS entry.
>=20
> v4 changes: new patch in v4
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/spi/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +++
> =C2=A0drivers/spi/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0drivers/spi/spi-offload-trigger-pwm.c | 162
> ++++++++++++++++++++++++++++++++++
> =C2=A04 files changed, 178 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index
> b2aa6f37743e48353c60e5973ea8126590c7f6d5..d8d72da5ac4bcab817a515774eb8db3=
7a7e9
> 4f25 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22131,6 +22131,7 @@ F:	include/linux/mtd/spi-nor.h
> =C2=A0
> =C2=A0SPI OFFLOAD
> =C2=A0R:	David Lechner <dlechner@baylibre.com>
> +F:	drivers/spi/spi-offload-trigger-pwm.c
> =C2=A0F:	drivers/spi/spi-offload.c
> =C2=A0F:	include/linux/spi/spi-offload.h
> =C2=A0K:	spi_offload
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index
> 02064a4e292815ec0213e2e446b4f90ed8855a52..2cfc14be869790f5226130428bb7cb4=
0aadf
> b031 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -1320,4 +1320,16 @@ endif # SPI_SLAVE
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
> index
> bb5fc20df21332232533c2e70c0cc230f6bcf27f..0068d170bc99c750c13376c4013991d=
927bb
> ac63 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -164,3 +164,6 @@ obj-$(CONFIG_SPI_AMD)			+=3D spi-amd.o
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
> index
> 0000000000000000000000000000000000000000..b26d4437c589052709a8206f8314ffd=
08355
> 870e
> --- /dev/null
> +++ b/drivers/spi/spi-offload-trigger-pwm.c
> @@ -0,0 +1,162 @@
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
> +#include <linux/spi/offload/provider.h>
> +#include <linux/types.h>
> +
> +struct spi_offload_trigger_pwm_state {
> +	struct device *dev;
> +	struct pwm_device *pwm;
> +};
> +
> +static bool spi_offload_trigger_pwm_match(struct spi_offload_trigger
> *trigger,
> +					=C2=A0 enum spi_offload_trigger_type type,
> +					=C2=A0 u64 *args, u32 nargs)
> +{
> +	if (nargs)
> +		return false;
> +
> +	return type =3D=3D SPI_OFFLOAD_TRIGGER_PERIODIC;
> +}
> +
> +static int spi_offload_trigger_pwm_validate(struct spi_offload_trigger
> *trigger,
> +					=C2=A0=C2=A0=C2=A0 struct spi_offload_trigger_config
> *config)
> +{
> +	struct spi_offload_trigger_pwm_state *st =3D
> spi_offload_trigger_get_priv(trigger);
> +	struct spi_offload_trigger_periodic *periodic =3D &config->periodic;
> +	struct pwm_waveform wf =3D { };
> +	int ret;
> +
> +	if (config->type !=3D SPI_OFFLOAD_TRIGGER_PERIODIC)
> +		return -EINVAL;
> +
> +	if (!periodic->frequency_hz)
> +		return -EINVAL;
> +
> +	wf.period_length_ns =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic-
> >frequency_hz);
> +	/* REVISIT: 50% duty-cycle for now - may add config parameter later
> */
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
> +static int spi_offload_trigger_pwm_enable(struct spi_offload_trigger
> *trigger,
> +					=C2=A0 struct spi_offload_trigger_config
> *config)
> +{
> +	struct spi_offload_trigger_pwm_state *st =3D
> spi_offload_trigger_get_priv(trigger);
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
> +	/* REVISIT: 50% duty-cycle for now - may add config parameter later
> */
> +	wf.duty_length_ns =3D wf.period_length_ns / 2;
> +
> +	return pwm_set_waveform_might_sleep(st->pwm, &wf, false);
> +}
> +
> +static void spi_offload_trigger_pwm_disable(struct spi_offload_trigger
> *trigger)
> +{
> +	struct spi_offload_trigger_pwm_state *st =3D
> spi_offload_trigger_get_priv(trigger);
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
> +		.fwnode =3D dev_fwnode(dev),
> +		.ops =3D &spi_offload_trigger_pwm_ops,
> +	};
> +	struct spi_offload_trigger_pwm_state *st;
> +	struct pwm_state state;
> +	int ret;
> +
> +	st =3D devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
> +	if (!st)
> +		return -ENOMEM;
> +
> +	info.priv =3D st;
> +	st->dev =3D dev;
> +
> +	st->pwm =3D devm_pwm_get(dev, NULL);
> +	if (IS_ERR(st->pwm))
> +		return dev_err_probe(dev, PTR_ERR(st->pwm), "failed to get
> PWM\n");
> +
> +	/* init with duty_cycle =3D 0, output enabled to ensure trigger off */
> +	pwm_init_state(st->pwm, &state);
> +	state.enabled =3D true;
> +
> +	ret =3D pwm_apply_might_sleep(st->pwm, &state);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to apply PWM
> state\n");
> +
> +	ret =3D devm_add_action_or_reset(dev, spi_offload_trigger_pwm_release,
> st->pwm);
> +	if (ret)
> +		return ret;
> +
> +	return devm_spi_offload_trigger_register(dev, &info);
> +}
> +
> +static const struct of_device_id spi_offload_trigger_pwm_of_match_table[=
] =3D {
> +	{ .compatible =3D "pwm-trigger" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, spi_offload_trigger_pwm_of_match_table);
> +
> +static struct platform_driver spi_offload_trigger_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "pwm-trigger",
> +		.of_match_table =3D spi_offload_trigger_pwm_of_match_table,
> +	},
> +	.probe =3D spi_offload_trigger_pwm_probe,
> +};
> +module_platform_driver(spi_offload_trigger_pwm_driver);
> +
> +MODULE_AUTHOR("David Lechner <dlechner@baylibre.com>");
> +MODULE_DESCRIPTION("Generic PWM trigger");
> +MODULE_LICENSE("GPL");
>=20


