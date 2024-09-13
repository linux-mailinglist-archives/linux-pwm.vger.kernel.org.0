Return-Path: <linux-pwm+bounces-3229-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E3C977AC5
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 10:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBFC1C215C2
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 08:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285011D58AA;
	Fri, 13 Sep 2024 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpCbTRbn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182F31D54CC;
	Fri, 13 Sep 2024 08:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726215253; cv=none; b=p8IWIONbQTW2fqBVzOdc2OEoVGBeKvTS504Qc1BpAWY/Hkiu/N70a3zKu5TqwdkkS4rr2AVFHrqp8f0PcgANhQp8Wag3/8s9XzpI0ZUeQtKd6a9L0TsLTlPEZIosN3wdr5RgcO0Z8MRa+d69BptYWnC4M0n9dvKCi6Ekeb/uSoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726215253; c=relaxed/simple;
	bh=eVz5Oq/QKf8lAddR0QlaGyYVcSvIMN+rucM08tf506I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jMR8kR9HTtoMi0ydmkKjxlSqY6kRKXeZ9K1nfsLuOyFrkHjQfmdUCuYow3lA+Ga31YnW7NHc7QVK2OvinR1/pmPwmjoVpp8Ai9qyU7mwwQ6FIUTHk684kwHL2a5T0ctv8wIyH+it7FrDqkMS5lqRR/dNhSBQv8NK9WVYrxJKHvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpCbTRbn; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3780c8d689aso1292642f8f.0;
        Fri, 13 Sep 2024 01:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726215249; x=1726820049; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OUpZYWJHNms3nGNITBFXq/IMDKxt7l067rR2xQ4gtBY=;
        b=hpCbTRbnhzz46jw9Y46fDWKr/+GBCvPe/d87ed27MJnZir8KgkqyuEMflRik0z5jur
         nmrH3pi2Nq/GObBXDIt1c74puVW16Gaebqsh6c9w/lb9NZZxfH24b9ye1cL5tCdH2RV6
         TZZ573IJuU2vRNuxsW1+OjQnG3bpQVjmqIVMMuUo2ivU0zIM5zoiKlFg6rd5uwU9ygF+
         5HkESfFBp76zXx6L90j2SA3CPb+B9MHe7C7c3O8ud9cv+zNBdSC9l+tRMm5T9erfcMsL
         K6JIFXDmUHBxZzEfd0v8lKbje671d2njBDtUcubrQbuQuJtyQkcuqg3A2N//3oClMHBC
         BXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726215249; x=1726820049;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OUpZYWJHNms3nGNITBFXq/IMDKxt7l067rR2xQ4gtBY=;
        b=ayQjod3cziKheHHJzvxQW8Xj3RLLGS9heb+9qylAXYbt/9rBXV6/QGabM4PkybpCRd
         +R9c4z3QxqKboTSn1MKfpHbkZ9R2EfYnO8srhkATKIwD5sHY3O1ZA5B3YbPMy3uPeo56
         cdpa7CtiMAe+x120GnUGuGFMJ1vT79WOpUTz61edb0em0xXmVRaIVfkhvwR3VQSfY0Ro
         H+MOCPM7KLeMFcVcvPFCoThIEKlNgo90rj1TSUM5k/6f8Yu7aZ/EkFok9PzFM8HbR1WD
         3ebZAlB8pwYjJiydMIPgx6HL4BKUtZ/wnfFfkyQIkYQ1siAdYWa7VnEw8nVXzOo5Y6j8
         TUDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCPOodVlfZldhMP4lSHoNX+sg/POQuiQtDmugh5TgoQI9ciIIrIpdeE9ti9/kzwoE9isUMfAEDIvaxiJ4=@vger.kernel.org, AJvYcCUf/7DeKy7nq/2TvpDGapM1xAoqF2YkbBzRAeK0QkbHH1+0wI2qD5NEkFXSgmygn9Ske6DULSzyEa0E@vger.kernel.org, AJvYcCVJk8lqXvXnrF2XmZcnz5YbtWZ38GifSoMqgQOGQQykJ/tJi+LR6vyhonkiGNDkuXiLp8PSwdbfr/5V@vger.kernel.org, AJvYcCWM96+tFEQZHfFFBdgkREzLadZcWipsmCOT9gwnHoEvH2AT+lT1DXkiJNmldokBdPub5VhZNIBkRkoC@vger.kernel.org, AJvYcCXL9tsP0mxO03eyDPs0t3pNp8wKCPspThFRy5uvMCYd0JKi/twG0aqxkqltyDblNVJHkvhaOp6BSqZ+e5jU@vger.kernel.org
X-Gm-Message-State: AOJu0YwJOUD8o4invB9HU4Av29zQ5XfvI/+hb0wZDAPYs9HJkKuojF7V
	O2DH219i4D1YbAXn2IkQ2w9ZFuT+Q790KhGV3igsK94zsnQtDvIK
X-Google-Smtp-Source: AGHT+IH0nsJjNKBUR7RoSFEOwZT35nsdpzzT6hlUcPSM/kdZ1H3tgfife+989nbabMsrd4jW4iSnPA==
X-Received: by 2002:a5d:5ccd:0:b0:374:c35e:de72 with SMTP id ffacd0b85a97d-378c2cfee06mr2918355f8f.2.1726215248416;
        Fri, 13 Sep 2024 01:14:08 -0700 (PDT)
Received: from ?IPv6:2001:a61:341e:1201:c434:b5b1:98a6:efed? ([2001:a61:341e:1201:c434:b5b1:98a6:efed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b1947e2sm15348145e9.44.2024.09.13.01.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 01:14:07 -0700 (PDT)
Message-ID: <9c90286c366d064aa08dc001df0619b6bc49b427.camel@gmail.com>
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
Date: Fri, 13 Sep 2024 10:14:07 +0200
In-Reply-To: <31a1dfeb-2d72-44bc-b3ca-36b4115c3010@baylibre.com>
References: 
	<20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
	 <20240815-ad7606_add_iio_backend_support-v1-8-cea3e11b1aa4@baylibre.com>
	 <5dedf51d8ec19b7b3bd0c6cb136048344f1c1007.camel@gmail.com>
	 <31a1dfeb-2d72-44bc-b3ca-36b4115c3010@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-12 at 12:13 +0200, Guillaume Stols wrote:
> On 9/5/24 10:40, Nuno S=C3=A1 wrote:
> > On Thu, 2024-08-15 at 12:12 +0000, Guillaume Stols wrote:
> > > - Basic support for iio backend.
> > > - Supports IIO_CHAN_INFO_SAMP_FREQ R/W.
> > > - Only hardware mode is available, and that IIO_CHAN_INFO_RAW is not
> > > =C2=A0=C2=A0 supported if iio-backend mode is selected.
> > >=20
> > > A small correction was added to the driver's file name in the Kconfig
> > > file's description.
> > >=20
> > > Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> > > ---
> > Hi Guillaume,
> >=20
> > Some initial feedback from me...
> >=20
> > > =C2=A0=C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 3 +-
> > > =C2=A0=C2=A0drivers/iio/adc/ad7606.c=C2=A0=C2=A0=C2=A0=C2=A0 | 103 ++=
+++++++++++++++++++++++++++++++++-------
> > > -
> > > =C2=A0=C2=A0drivers/iio/adc/ad7606.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
16 +++++++
> > > =C2=A0=C2=A0drivers/iio/adc/ad7606_par.c |=C2=A0 98 +++++++++++++++++=
++++++++++++++++++++++-
> > > =C2=A0=C2=A04 files changed, 200 insertions(+), 20 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > index 88e8ce2e78b3..01248b6df868 100644
> > > --- a/drivers/iio/adc/Kconfig
> > > +++ b/drivers/iio/adc/Kconfig
> > > @@ -227,9 +227,10 @@ config AD7606_IFACE_PARALLEL
> > > =C2=A0=C2=A0	help
> > > =C2=A0=C2=A0	=C2=A0 Say yes here to build parallel interface support =
for Analog
> > > Devices:
> > > =C2=A0=C2=A0	=C2=A0 ad7605-4, ad7606, ad7606-6, ad7606-4 analog to di=
gital converters
> > > (ADC).
> > > +	=C2=A0 It also support iio_backended devices for AD7606B.
> > > =C2=A0=20
> > > =C2=A0=C2=A0	=C2=A0 To compile this driver as a module, choose M here=
: the
> > > -	=C2=A0 module will be called ad7606_parallel.
> > > +	=C2=A0 module will be called ad7606_par.
> > > =C2=A0=20
> > > =C2=A0=C2=A0config AD7606_IFACE_SPI
> > > =C2=A0=C2=A0	tristate "Analog Devices AD7606 ADC driver with spi inte=
rface
> > > support"
> > > diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> > > index 99d5ca5c2348..a753d5caa9f8 100644
> > > --- a/drivers/iio/adc/ad7606.c
> > > +++ b/drivers/iio/adc/ad7606.c
> > > @@ -21,6 +21,7 @@
> > > =C2=A0=C2=A0#include <linux/util_macros.h>
> > > =C2=A0=C2=A0#include <linux/units.h>
> > > +
> > > +	/* backend manages interruptions by itself.*/
> > missing space before closing the comment (also not sure the comments ad=
ds much)
>=20
>=20
> thx, will check again
>=20
>=20
> >=20
> > > +	if (!st->back) {
> > > +		ret =3D wait_for_completion_timeout(&st->completion,
> > > +						=C2=A0 msecs_to_jiffies(1000));
> > > +		if (!ret) {
> > > +			ret =3D -ETIMEDOUT;
> > > +			goto error_ret;
> > > +		}
> > > =C2=A0=C2=A0	}
> > > =C2=A0=20
> > > =C2=A0=C2=A0	ret =3D ad7606_read_samples(st);
> > > @@ -271,6 +284,12 @@ static int ad7606_read_raw(struct iio_dev *indio=
_dev,
> > > =C2=A0=C2=A0	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > > =C2=A0=C2=A0		*val =3D st->oversampling;
> > > =C2=A0=C2=A0		return IIO_VAL_INT;
> > > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > > +		pwm_get_state_hw(st->cnvst_pwm, &cnvst_pwm_state);
> > > +		/* If the PWM is swinging, return the real frequency,
> > > otherwise 0 */
> > > +		*val =3D ad7606_pwm_is_swinging(st) ?
> > > +			DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC,
> > > cnvst_pwm_state.period) : 0;
> > > +		return IIO_VAL_INT;
> > > =C2=A0=C2=A0	}
> > > =C2=A0=C2=A0	return -EINVAL;
> > > =C2=A0=C2=A0}
> > > @@ -360,6 +379,8 @@ static int ad7606_write_raw(struct iio_dev *indio=
_dev,
> > > =C2=A0=C2=A0			return ret;
> > > =C2=A0=20
> > > =C2=A0=C2=A0		return 0;
> > > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > > +		return ad7606_set_sampling_freq(st, val);
> > > =C2=A0=C2=A0	default:
> > > =C2=A0=C2=A0		return -EINVAL;
> > > =C2=A0=C2=A0	}
> > > @@ -482,7 +503,6 @@ static int ad7606_buffer_postenable(struct iio_de=
v
> > > *indio_dev)
> > > =C2=A0=C2=A0	struct ad7606_state *st =3D iio_priv(indio_dev);
> > > =C2=A0=20
> > > =C2=A0=C2=A0	gpiod_set_value(st->gpio_convst, 1);
> > > -	ad7606_pwm_set_swing(st);
> > > =C2=A0=20
> > > =C2=A0=C2=A0	return 0;
> > > =C2=A0=C2=A0}
> > > @@ -492,19 +512,53 @@ static int ad7606_buffer_predisable(struct iio_=
dev
> > > *indio_dev)
> > > =C2=A0=C2=A0	struct ad7606_state *st =3D iio_priv(indio_dev);
> > > =C2=A0=20
> > > =C2=A0=C2=A0	gpiod_set_value(st->gpio_convst, 0);
> > > -	ad7606_pwm_set_low(st);
> > > =C2=A0=20
> > > =C2=A0=C2=A0	return 0;
> > > =C2=A0=C2=A0}
> > > =C2=A0=20
> > > +static int ad7606_pwm_buffer_postenable(struct iio_dev *indio_dev)
> > > +{
> > > +	struct ad7606_state *st =3D iio_priv(indio_dev);
> > > +
> > > +	return ad7606_pwm_set_swing(st);
> > > +}
> > > +
> > > +static int ad7606_pwm_buffer_predisable(struct iio_dev *indio_dev)
> > > +{
> > > +	struct ad7606_state *st =3D iio_priv(indio_dev);
> > > +
> > > +	return ad7606_pwm_set_low(st);
> > > +}
> > Maybe I'm missing something but are we removing the gpiod calls?
>=20
>=20
> Well actually the pwm is meant to be used only with backend. Though it=
=20
> could be used without it, I dont think it is a very good idea because=20
> interrupt handling + transmission init takes quite some time, and a new=
=20
> rising edge could happen before the current samples are effectively=20
> transferred. However, since PWM and backend are two separate things, I=
=20
> wanted to show an usage for the PWM when introducing it, and one way to=
=20
> do it was to use it to emulate a GPIO by setting the duty cycle 100% for=
=20
> having a 1 (set_high) and 0% for having a 0 (set_low). Then on this=20
> patch, since we introduce iio-backend, I removed this 'mock' usage of it.
>=20
> But I think that I should separate the removal into an additional patch=
=20
> to avoid confusions. Or shall I just remove the mock usage from the PWM=
=20
> patch ?
>=20
>=20

Yeah, probably better (with a proper commit message explaining the reasonin=
g)

> > > +
> > > +static int ad7606_update_scan_mode(struct iio_dev *indio_dev,
> > > +				=C2=A0=C2=A0 const unsigned long *scan_mask)
> > > +{
> > > +	struct ad7606_state *st =3D iio_priv(indio_dev);
> > > +
> > > +	/* The update scan mode is only for iio backend compatible drivers.
> > > +	 * If the specific update_scan_mode is not defined in the bus ops,
> > > +	 * just do nothing and return 0.
> > > +	 */
> > > +	if (st->bops->update_scan_mode)
> > > +		return st->bops->update_scan_mode(indio_dev, scan_mask);
> > > +	else
> > > +		return 0;
> > Redundant else
>=20
>=20
> ack
>=20
> > > -	if (ret)
> > > -		return ret;
> > > =C2=A0=20
> > > +	if (st->bops->iio_backend_config) {
> > > +		st->bops->iio_backend_config(dev, indio_dev);
> > > +		indio_dev->setup_ops =3D &ad7606_pwm_buffer_ops;
> > Ignoring error code
>=20
>=20
> will handle
>=20
>=20
> >=20
> > > +	} else {
> > > +		/* Reserve the PWM use only for backend (force gpio_convst
> > > definition)*/
> > > +		if (!st->gpio_convst)
> > > +			return dev_err_probe(dev, -EINVAL,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0 "Convst pin must be defined when
> > > not in backend mode");
> > > +
> > > +		init_completion(&st->completion);
> > > +		ret =3D devm_request_threaded_irq(dev, irq,
> > > +						NULL,
> > > +						&ad7606_interrupt,
> > > +						IRQF_TRIGGER_FALLING |
> > > IRQF_ONESHOT,
> > > +						chip_info->name, indio_dev);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > Are we still calling devm_iio_triggered_buffer_setup() in case we have =
a backend
> > device?
>=20
>=20
> No, this portion of code is only executed if convst is defined=20
> (conversion trigger GPIO), which is not the case if there is a backend.
>=20
>=20
> >=20
> > > =C2=A0=C2=A0	return devm_iio_device_register(dev, indio_dev);
> > > =C2=A0=C2=A0}
> > ...
> >=20
> > > +#ifdef CONFIG_IIO_BACKEND
> > Not a fan of this #ifef... It's not that much code so I would just sele=
ct
> > IIO_BACKEND for this driver. In fact, I don't think we can separately e=
nable
> > IIO_BACKEND in the menuconfig menu?
>=20
>=20
> OK I can do it that way.
>=20
> > > +static int ad7606_bi_setup_iio_backend(struct device *dev, struct ii=
o_dev
> > > *indio_dev)
> > > +{
> > > +		struct ad7606_state *st =3D iio_priv(indio_dev);
> > > +		unsigned int ret, c;
> > > +
> > > +		st->back =3D devm_iio_backend_get(dev, NULL);
> > > +		if (IS_ERR(st->back))
> > > +			return PTR_ERR(st->back);
> > > +
> > > +		/* If the device is iio_backend powered the PWM is mandatory
> > > */
> > > +		if (!st->cnvst_pwm)
> > > +			return -EINVAL;
> > > +
> > > +		ret =3D devm_iio_backend_request_buffer(dev, st->back,
> > > indio_dev);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		ret =3D devm_iio_backend_enable(dev, st->back);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		struct iio_backend_data_fmt data =3D {
> > > +			.sign_extend =3D true,
> > > +			.enable =3D true,
> > > +		};
> > I would follow typical kernel coding style and have this declared at th=
e
> > beginning of the function.
>=20
>=20
> aouch, yes !
>=20
>=20
> > > -
> > > +#ifdef CONFIG_IIO_BACKEND
> > > +	struct iio_backend *back;
> > > +
> > > +	/*For now, only the AD7606B is backend compatible.*/
> > > +	if (chip_info->has_backend) {
> > > +		back =3D devm_iio_backend_get(&pdev->dev, NULL);
> > > +		if (IS_ERR(back))
> > > +			return PTR_ERR(back);
> > > +
> > > +		return ad7606_probe(&pdev->dev, 0, NULL,
> > > +				=C2=A0=C2=A0=C2=A0 chip_info,
> > > +				=C2=A0=C2=A0=C2=A0 &ad7606_bi_bops);
> > > +	}
> > > +#endif
> > Not sure I follow the above? You also get the backend in
> > ad7606_bi_setup_iio_backend()? So it seems to be that the has_backend f=
lag is
> > not really needed?
>=20
>=20
> The first call to devm_iio_backend_get checks if there is a backend=20
> available, and if so the backend bops (ad7606_bi_bops)are passed to the=
=20
> generic probe function.
>=20

Why not checking for the presence of the DT property? We should only get th=
e backend
when ready for that.

- Nuno S=C3=A1
>=20

