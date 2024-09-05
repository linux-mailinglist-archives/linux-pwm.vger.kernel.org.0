Return-Path: <linux-pwm+bounces-3093-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0500996D24C
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 10:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DD4282A87
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 08:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F62198827;
	Thu,  5 Sep 2024 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EADYfIRh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1611197A9A;
	Thu,  5 Sep 2024 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525397; cv=none; b=uiq9kG6KOP64Qi0bLP620OCOO7T80NxwYd4IQD8kfwIUuwC9MNw0ayTx2WvwUCMCe/OWKJ6IhCVXuJuF8Dux5/uyMT7sYGTnzOUl5A+FWCgRXLRD0+sR+pjiXmmMAFWoHLUEhIhCMoH3eGyqaFc+SC5ioE2ZRhibUIFNJbSG77c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525397; c=relaxed/simple;
	bh=WzEuX3vQGbI31XP/Pgmc0D/42g4+WkEP4I/ZhLzs5jc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CYDsOo/lCLV9RSC/gYtFSfdW40JFSJtzxRZCprmUTd1MaL+7YSr8MjpD8Oor1DvIPqDLGFwugCUO/n3acyN736W6wzc6wM9n8nH0sD7hvRr8UcKOAF3hdkKFk0WUcKKY8tmkA0rFMzADvAbCpWb9pk2o/oKehbomvLufKf+07oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EADYfIRh; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8a789c4fc5so30588066b.0;
        Thu, 05 Sep 2024 01:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725525394; x=1726130194; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GNo548ch3fMsBiEBoYqhfsQlquYX57OIfPYq4yu+mu8=;
        b=EADYfIRhQlZX9HkySUjBbOY1yIMnRs3Z9SqZdqns/7XkEHpxOWLpHbtCw5PNLS+QZ3
         6YBbiEcDWIWBKCOSUx5dSTgGG7XqyEw+7OCYJmJ1WTPUjh35AxwM2FIhBHg0rnvppMdv
         8FIoJK6j+dtcQ7rWgNHp7f+EDyfSbiAymp/g8cYhM68HFN9DnZyvyK5iR+WImHzABIw5
         dITi86AxYEvVHe7yVUgHzOkhb6Qc5ncCKk6uYx+LCi7LL8loo8Y2ybQGFo7qm6XIrETe
         Ke9uxDiNDGYB1sT6RMJvdDwRvGY3BNAbf192I20/OrTubffZc56GxiwHNR8uEXGm40r3
         W4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725525394; x=1726130194;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GNo548ch3fMsBiEBoYqhfsQlquYX57OIfPYq4yu+mu8=;
        b=twZa+WUSMZT0a/v2r1RsrsuMy13/rhZUWvo0s/7DTtqOqvcc6XRoOSYdo+SQwkqlVh
         lfDyKmly1HVW/RizqG5FjXTQVB6TMfZOkl+/P2zI4xOGeeqRXy65qk87cqFRksXSgiKs
         d3NvdUc8hCzpmkQKXwwFQxNmGpQ6bvYRYH/6m1Fj7FT+ZDkZe90yioT8BqExRaCzPfWu
         2Jgv3svBwi2iFbTg8U2ozzZ5yVOX2U7PD3vFpNm961xdEzu8J57ViBDuxQuD6yEsdVwr
         tyPDG0qjO1txDQYHVXHfZLhAtlhrVXaZod8puJlFn2jx0S3+Y0KkZidrwxD9H4pHusTK
         SXmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv3E6NtFzSSrlKHL+h2nNVKK7aulGUZwwDFdUfw+d+L8hfQade7x/+yyaFQuv800tKrWceCwYkDzUn@vger.kernel.org, AJvYcCVICjBwWVBEyo3dQJZ0zDq3eC/xkauh3EXKXsc2NmK5UpV2vRcdqpqt7tISrMZxoL1EaIjMno48F7vN@vger.kernel.org, AJvYcCVZTFOEBQMkBZjdwGiCbpf5+n/ZxUYcgtXJHrGq2zcuijtpLtTDbaQjb67XjOB6MxXrKsjyFQg1KGiYXjvo@vger.kernel.org, AJvYcCWAe5FTwKX8Us2awovxMkZDqb6KkFOoc3lfNeXRsCULrCP5BQtXOhD5/tQc30Po4e9VdITemCZN1LR40Nk=@vger.kernel.org, AJvYcCXWt0FIRM85eVpsKBmC5+AA5E9k0zECHno/PLGVbZk+0KYC/rJLKywC4TFd1J0dHferJpdeyicpJz76@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/jU2l32jGNt+s8u4EwsO0Am4zOWvbhHKJSKoYFiF558GBS74+
	KeMAkFcg8Y13fHScL0CnNbaWcXdddBZ36ZyhlC5JyrFH+m0vSCyY
X-Google-Smtp-Source: AGHT+IFAvvhp6ZrEk0A1ZDYx0Rvx0OzTdGJexYufV0kM4m96zzGLmjP2MaR+GPEWZml7L+0MNY/cEg==
X-Received: by 2002:a17:907:7205:b0:a72:7ede:4d12 with SMTP id a640c23a62f3a-a8a42fb12acmr485286166b.5.1725525393205;
        Thu, 05 Sep 2024 01:36:33 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6236d164sm101437866b.111.2024.09.05.01.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 01:36:32 -0700 (PDT)
Message-ID: <5dedf51d8ec19b7b3bd0c6cb136048344f1c1007.camel@gmail.com>
Subject: Re: [PATCH 8/8] iio:adc:ad7606: Add iio-backend support
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
	20240705211452.1157967-2-u.kleine-koenig@baylibre.com, 
	20240712171821.1470833-2-u.kleine-koenig@baylibre.com, 
	cover.1721040875.git.u.kleine-koenig@baylibre.com, aardelean@baylibre.com
Date: Thu, 05 Sep 2024 10:40:39 +0200
In-Reply-To: <20240815-ad7606_add_iio_backend_support-v1-8-cea3e11b1aa4@baylibre.com>
References: 
	<20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
	 <20240815-ad7606_add_iio_backend_support-v1-8-cea3e11b1aa4@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-15 at 12:12 +0000, Guillaume Stols wrote:
> - Basic support for iio backend.
> - Supports IIO_CHAN_INFO_SAMP_FREQ R/W.
> - Only hardware mode is available, and that IIO_CHAN_INFO_RAW is not
> =C2=A0 supported if iio-backend mode is selected.
>=20
> A small correction was added to the driver's file name in the Kconfig
> file's description.
>=20
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---

Hi Guillaume,

Some initial feedback from me...

> =C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 3 +-
> =C2=A0drivers/iio/adc/ad7606.c=C2=A0=C2=A0=C2=A0=C2=A0 | 103 ++++++++++++=
+++++++++++++++++++++++-------
> -
> =C2=A0drivers/iio/adc/ad7606.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 16 +++++++
> =C2=A0drivers/iio/adc/ad7606_par.c |=C2=A0 98 +++++++++++++++++++++++++++=
++++++++++++-
> =C2=A04 files changed, 200 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 88e8ce2e78b3..01248b6df868 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -227,9 +227,10 @@ config AD7606_IFACE_PARALLEL
> =C2=A0	help
> =C2=A0	=C2=A0 Say yes here to build parallel interface support for Analog
> Devices:
> =C2=A0	=C2=A0 ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital conv=
erters
> (ADC).
> +	=C2=A0 It also support iio_backended devices for AD7606B.
> =C2=A0
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the
> -	=C2=A0 module will be called ad7606_parallel.
> +	=C2=A0 module will be called ad7606_par.
> =C2=A0
> =C2=A0config AD7606_IFACE_SPI
> =C2=A0	tristate "Analog Devices AD7606 ADC driver with spi interface
> support"
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 99d5ca5c2348..a753d5caa9f8 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <linux/util_macros.h>
> =C2=A0#include <linux/units.h>
> =C2=A0
> +#include <linux/iio/backend.h>
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0#include <linux/iio/buffer.h>
> =C2=A0#include <linux/iio/sysfs.h>
> @@ -148,7 +149,15 @@ static int ad7606_set_sampling_freq(struct ad7606_st=
ate
> *st, unsigned long freq)
> =C2=A0
> =C2=A0static int ad7606_read_samples(struct ad7606_state *st)
> =C2=A0{
> -	unsigned int num =3D st->chip_info->num_channels - 1;
> +	unsigned int num =3D st->chip_info->num_channels;
> +
> +	/*
> +	 * Timestamp channel does not contain sample, and no timestamp
> channel if
> +	 * backend is used.
> +	 */
> +	if (!st->back)
> +		num--;
> +
> =C2=A0	u16 *data =3D st->data;
> =C2=A0	int ret;
> =C2=A0
> @@ -220,11 +229,15 @@ static int ad7606_scan_direct(struct iio_dev *indio=
_dev,
> unsigned int ch)
> =C2=A0		if (!ret)
> =C2=A0			return ret;
> =C2=A0	}
> -	ret =3D wait_for_completion_timeout(&st->completion,
> -					=C2=A0 msecs_to_jiffies(1000));
> -	if (!ret) {
> -		ret =3D -ETIMEDOUT;
> -		goto error_ret;
> +
> +	/* backend manages interruptions by itself.*/

missing space before closing the comment (also not sure the comments adds m=
uch)

> +	if (!st->back) {
> +		ret =3D wait_for_completion_timeout(&st->completion,
> +						=C2=A0 msecs_to_jiffies(1000));
> +		if (!ret) {
> +			ret =3D -ETIMEDOUT;
> +			goto error_ret;
> +		}
> =C2=A0	}
> =C2=A0
> =C2=A0	ret =3D ad7606_read_samples(st);
> @@ -271,6 +284,12 @@ static int ad7606_read_raw(struct iio_dev *indio_dev=
,
> =C2=A0	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> =C2=A0		*val =3D st->oversampling;
> =C2=A0		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		pwm_get_state_hw(st->cnvst_pwm, &cnvst_pwm_state);
> +		/* If the PWM is swinging, return the real frequency,
> otherwise 0 */
> +		*val =3D ad7606_pwm_is_swinging(st) ?
> +			DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC,
> cnvst_pwm_state.period) : 0;
> +		return IIO_VAL_INT;
> =C2=A0	}
> =C2=A0	return -EINVAL;
> =C2=A0}
> @@ -360,6 +379,8 @@ static int ad7606_write_raw(struct iio_dev *indio_dev=
,
> =C2=A0			return ret;
> =C2=A0
> =C2=A0		return 0;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad7606_set_sampling_freq(st, val);
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> @@ -482,7 +503,6 @@ static int ad7606_buffer_postenable(struct iio_dev
> *indio_dev)
> =C2=A0	struct ad7606_state *st =3D iio_priv(indio_dev);
> =C2=A0
> =C2=A0	gpiod_set_value(st->gpio_convst, 1);
> -	ad7606_pwm_set_swing(st);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> @@ -492,19 +512,53 @@ static int ad7606_buffer_predisable(struct iio_dev
> *indio_dev)
> =C2=A0	struct ad7606_state *st =3D iio_priv(indio_dev);
> =C2=A0
> =C2=A0	gpiod_set_value(st->gpio_convst, 0);
> -	ad7606_pwm_set_low(st);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static int ad7606_pwm_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad7606_state *st =3D iio_priv(indio_dev);
> +
> +	return ad7606_pwm_set_swing(st);
> +}
> +
> +static int ad7606_pwm_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad7606_state *st =3D iio_priv(indio_dev);
> +
> +	return ad7606_pwm_set_low(st);
> +}

Maybe I'm missing something but are we removing the gpiod calls?
> +
> +static int ad7606_update_scan_mode(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0 const unsigned long *scan_mask)
> +{
> +	struct ad7606_state *st =3D iio_priv(indio_dev);
> +
> +	/* The update scan mode is only for iio backend compatible drivers.
> +	 * If the specific update_scan_mode is not defined in the bus ops,
> +	 * just do nothing and return 0.
> +	 */
> +	if (st->bops->update_scan_mode)
> +		return st->bops->update_scan_mode(indio_dev, scan_mask);
> +	else
> +		return 0;

Redundant else

> +}
> +
> =C2=A0static const struct iio_buffer_setup_ops ad7606_buffer_ops =3D {
> =C2=A0	.postenable =3D &ad7606_buffer_postenable,
> =C2=A0	.predisable =3D &ad7606_buffer_predisable,
> =C2=A0};
> =C2=A0
> +static const struct iio_buffer_setup_ops ad7606_pwm_buffer_ops =3D {
> +	.postenable =3D &ad7606_pwm_buffer_postenable,
> +	.predisable =3D &ad7606_pwm_buffer_predisable,
> +};
> +
> =C2=A0static const struct iio_info ad7606_info_no_os_or_range =3D {
> =C2=A0	.read_raw =3D &ad7606_read_raw,
> =C2=A0	.validate_trigger =3D &ad7606_validate_trigger,
> +	.update_scan_mode =3D &ad7606_update_scan_mode,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct iio_info ad7606_info_os_and_range =3D {
> @@ -512,6 +566,7 @@ static const struct iio_info ad7606_info_os_and_range=
 =3D {
> =C2=A0	.write_raw =3D &ad7606_write_raw,
> =C2=A0	.attrs =3D &ad7606_attribute_group_os_and_range,
> =C2=A0	.validate_trigger =3D &ad7606_validate_trigger,
> +	.update_scan_mode =3D &ad7606_update_scan_mode,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct iio_info ad7606_info_os_range_and_debug =3D {
> @@ -520,6 +575,7 @@ static const struct iio_info
> ad7606_info_os_range_and_debug =3D {
> =C2=A0	.debugfs_reg_access =3D &ad7606_reg_access,
> =C2=A0	.attrs =3D &ad7606_attribute_group_os_and_range,
> =C2=A0	.validate_trigger =3D &ad7606_validate_trigger,
> +	.update_scan_mode =3D &ad7606_update_scan_mode,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct iio_info ad7606_info_os =3D {
> @@ -527,6 +583,7 @@ static const struct iio_info ad7606_info_os =3D {
> =C2=A0	.write_raw =3D &ad7606_write_raw,
> =C2=A0	.attrs =3D &ad7606_attribute_group_os,
> =C2=A0	.validate_trigger =3D &ad7606_validate_trigger,
> +	.update_scan_mode =3D &ad7606_update_scan_mode,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct iio_info ad7606_info_range =3D {
> @@ -534,6 +591,7 @@ static const struct iio_info ad7606_info_range =3D {
> =C2=A0	.write_raw =3D &ad7606_write_raw,
> =C2=A0	.attrs =3D &ad7606_attribute_group_range,
> =C2=A0	.validate_trigger =3D &ad7606_validate_trigger,
> +	.update_scan_mode =3D &ad7606_update_scan_mode,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct iio_trigger_ops ad7606_trigger_ops =3D {
> @@ -602,8 +660,6 @@ int ad7606_probe(struct device *dev, int irq, void __=
iomem
> *base_address,
> =C2=A0	indio_dev->channels =3D st->chip_info->channels;
> =C2=A0	indio_dev->num_channels =3D st->chip_info->num_channels;
> =C2=A0
> -	init_completion(&st->completion);
> -
> =C2=A0	ret =3D ad7606_reset(st);
> =C2=A0	if (ret)
> =C2=A0		dev_warn(st->dev, "failed to RESET: no RESET GPIO
> specified\n");
> @@ -635,7 +691,7 @@ int ad7606_probe(struct device *dev, int irq, void __=
iomem
> *base_address,
> =C2=A0			return ret;
> =C2=A0	}
> =C2=A0
> -	/* If convst pin is not defined, setup PWM*/
> +	/* If convst pin is not defined, setup PWM */
> =C2=A0	if (!st->gpio_convst) {
> =C2=A0		st->cnvst_pwm =3D devm_pwm_get(dev, NULL);
> =C2=A0		if (IS_ERR(st->cnvst_pwm))
> @@ -671,14 +727,25 @@ int ad7606_probe(struct device *dev, int irq, void
> __iomem *base_address,
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0	}
> -	ret =3D devm_request_threaded_irq(dev, irq,
> -					NULL,
> -					&ad7606_interrupt,
> -					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -					chip_info->name, indio_dev);
> -	if (ret)
> -		return ret;
> =C2=A0
> +	if (st->bops->iio_backend_config) {
> +		st->bops->iio_backend_config(dev, indio_dev);
> +		indio_dev->setup_ops =3D &ad7606_pwm_buffer_ops;

Ignoring error code

> +	} else {
> +		/* Reserve the PWM use only for backend (force gpio_convst
> definition)*/
> +		if (!st->gpio_convst)
> +			return dev_err_probe(dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Convst pin must be defined when
> not in backend mode");
> +
> +		init_completion(&st->completion);
> +		ret =3D devm_request_threaded_irq(dev, irq,
> +						NULL,
> +						&ad7606_interrupt,
> +						IRQF_TRIGGER_FALLING |
> IRQF_ONESHOT,
> +						chip_info->name, indio_dev);
> +		if (ret)
> +			return ret;
> +	}

Are we still calling devm_iio_triggered_buffer_setup() in case we have a ba=
ckend
device?

> =C2=A0	return devm_iio_device_register(dev, indio_dev);
> =C2=A0}

...

>=20
> +#ifdef CONFIG_IIO_BACKEND

Not a fan of this #ifef... It's not that much code so I would just select
IIO_BACKEND for this driver. In fact, I don't think we can separately enabl=
e
IIO_BACKEND in the menuconfig menu?

> +static const struct iio_chan_spec ad7606b_bi_channels[] =3D {
> +	AD7606_BI_CHANNEL(0),
> +	AD7606_BI_CHANNEL(1),
> +	AD7606_BI_CHANNEL(2),
> +	AD7606_BI_CHANNEL(3),
> +	AD7606_BI_CHANNEL(4),
> +	AD7606_BI_CHANNEL(5),
> +	AD7606_BI_CHANNEL(6),
> +	AD7606_BI_CHANNEL(7),
> +};
> +
> +static int ad7606_bi_update_scan_mode(struct iio_dev *indio_dev, const
> unsigned long *scan_mask)
> +{
> +	struct ad7606_state *st =3D iio_priv(indio_dev);
> +	unsigned int c, ret;
> +
> +	for (c =3D 0; c < indio_dev->num_channels; c++) {
> +		if (test_bit(c, scan_mask))
> +			ret =3D iio_backend_chan_enable(st->back, c);
> +		else
> +			ret =3D iio_backend_chan_disable(st->back, c);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad7606_bi_setup_iio_backend(struct device *dev, struct iio_de=
v
> *indio_dev)
> +{
> +		struct ad7606_state *st =3D iio_priv(indio_dev);
> +		unsigned int ret, c;
> +
> +		st->back =3D devm_iio_backend_get(dev, NULL);
> +		if (IS_ERR(st->back))
> +			return PTR_ERR(st->back);
> +
> +		/* If the device is iio_backend powered the PWM is mandatory
> */
> +		if (!st->cnvst_pwm)
> +			return -EINVAL;
> +
> +		ret =3D devm_iio_backend_request_buffer(dev, st->back,
> indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D devm_iio_backend_enable(dev, st->back);
> +		if (ret)
> +			return ret;
> +
> +		struct iio_backend_data_fmt data =3D {
> +			.sign_extend =3D true,
> +			.enable =3D true,
> +		};

I would follow typical kernel coding style and have this declared at the
beginning of the function.

> +		for (c =3D 0; c < indio_dev->num_channels; c++) {
> +			ret =3D iio_backend_data_format_set(st->back, c,
> &data);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		indio_dev->channels =3D ad7606b_bi_channels;
> +		indio_dev->num_channels =3D 8;
> +
> +		return 0;
> +}
> +
> +static const struct ad7606_bus_ops ad7606_bi_bops =3D {
> +	.iio_backend_config =3D ad7606_bi_setup_iio_backend,
> +	.update_scan_mode =3D ad7606_bi_update_scan_mode,
> +};
> +#endif
> +
> =C2=A0static int ad7606_par16_read_block(struct device *dev,
> =C2=A0				=C2=A0=C2=A0 int count, void *buf)
> =C2=A0{
> @@ -52,7 +130,20 @@ static int ad7606_par_probe(struct platform_device *p=
dev)
> =C2=A0	void __iomem *addr;
> =C2=A0	resource_size_t remap_size;
> =C2=A0	int irq;
> -
> +#ifdef CONFIG_IIO_BACKEND
> +	struct iio_backend *back;
> +
> +	/*For now, only the AD7606B is backend compatible.*/
> +	if (chip_info->has_backend) {
> +		back =3D devm_iio_backend_get(&pdev->dev, NULL);
> +		if (IS_ERR(back))
> +			return PTR_ERR(back);
> +
> +		return ad7606_probe(&pdev->dev, 0, NULL,
> +				=C2=A0=C2=A0=C2=A0 chip_info,
> +				=C2=A0=C2=A0=C2=A0 &ad7606_bi_bops);
> +	}
> +#endif

Not sure I follow the above? You also get the backend in
ad7606_bi_setup_iio_backend()? So it seems to be that the has_backend flag =
is
not really needed?

- Nuno S=C3=A1



