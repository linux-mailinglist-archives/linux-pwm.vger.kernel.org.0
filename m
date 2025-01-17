Return-Path: <linux-pwm+bounces-4658-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB54A15300
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 16:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC1F1889D24
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 15:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAAE198851;
	Fri, 17 Jan 2025 15:43:23 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0C91422A8;
	Fri, 17 Jan 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737128603; cv=none; b=IfT1hGLRMv3C+kCSE6MDv/c1vCojV8kSfy14BlCU8kBkjwNpij85sUjrvvjQNhCccQ4qD1uvsDn8kXenIvR6jF2V+fOOluFCYZKbaRFOiXb9DKJJBgoLlkz5L+bOImYAtKp9xbP+5whQSfGSah8joeZtRQ3lCjEL+zHaoeUJEqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737128603; c=relaxed/simple;
	bh=Fu33ef61hPSSqgux2gyLm9fZc9PqlU2iN9Ow1HQJRc8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+c9SMpalT/6yc6PLpTUFdzalWUlR8Rr0vXTD5EHpXANL3aoMNnWnI0hG52KFjn9Jb0XLZoCFWxXh1/wVMOuOnWS9GQd3YC1sUHhbjdFHah1+b34qbaMdsddDnEJBvCIp5CJkbNlWRd4vbb/GMrlt7icq61f9k/bBOpJD8vBRRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YZPC15YSzz6K9Ct;
	Fri, 17 Jan 2025 23:43:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A02891402CB;
	Fri, 17 Jan 2025 23:43:11 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 17 Jan
 2025 16:43:11 +0100
Date: Fri, 17 Jan 2025 15:43:09 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>, <jic23@kernel.org>,
	<robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v9 8/8] iio: adc: ad4851: add ad485x driver
Message-ID: <20250117154309.000003e1@huawei.com>
In-Reply-To: <d4ur7trhknm7jtjvsyms4aewypl75uuvgtccgwc7dfycheh4qo@jqmpv5t3lip6>
References: <20241220120134.42760-1-antoniu.miclaus@analog.com>
	<20241220120134.42760-8-antoniu.miclaus@analog.com>
	<d4ur7trhknm7jtjvsyms4aewypl75uuvgtccgwc7dfycheh4qo@jqmpv5t3lip6>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 17 Jan 2025 10:59:04 +0100
Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello,
>=20
> On Fri, Dec 20, 2024 at 02:01:34PM +0200, Antoniu Miclaus wrote:
> > +static const int ad4851_oversampling_ratios[] =3D {
> > +	1, 2, 4, 8, 16,	32, 64, 128,
> > +	256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
> > +	65536,
> > +};
> > +
> > +static int ad4851_osr_to_regval(unsigned int ratio)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 1; i < ARRAY_SIZE(ad4851_oversampling_ratios); i++)
> > +		if (ratio =3D=3D ad4851_oversampling_ratios[i])
> > +			return i - 1;
> > +
> > +	return -EINVAL;
> > +} =20
>=20
> This can be simplified (I guess) using something like:
>=20
> 	if (ratio >=3D 2 && ratio <=3D 65536 && is_power_of_2(ratio))
> 		return ilog2(ratio) - 1;
>=20
> 	return -EINVAL;
Hi Uwe,

Only at the cost of providing custom handling to compute the above
array in order to provide it to userspace via the read_avail() callback.

We could do what you have here and provide the array but that would
be less clear than just looking it up.

>=20
> > +static void __ad4851_get_scale(struct iio_dev *indio_dev, int scale_tb=
l,
> > +			       unsigned int *val, unsigned int *val2)
> > +{
> > [...]
> > +}
> > +
> > +static int ad4851_scale_fill(struct iio_dev *indio_dev)
> > +{
> > [...]
> > +}
> > +
> > +static int ad4851_set_oversampling_ratio(struct iio_dev *indio_dev,
> > +					 const struct iio_chan_spec *chan,
> > +					 unsigned int osr)
> > +{
> > [...]
> > +}
> > +
> > +static int ad4851_get_oversampling_ratio(struct ad4851_state *st, unsi=
gned int *val)
> > +{
> > +	unsigned int osr;
> > +	int ret;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	ret =3D regmap_read(st->regmap, AD4851_REG_OVERSAMPLE, &osr);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!FIELD_GET(AD4851_OS_EN_MSK, osr))
> > +		*val =3D 1;
> > +	else
> > +		*val =3D ad4851_oversampling_ratios[FIELD_GET(AD4851_OS_RATIO_MSK, o=
sr) + 1]; =20
>=20
> With the suggestion above this gets:
>=20
> 	*val =3D 2 << FIELD_GET(AD4851_OS_RATIO_MSK, osr);
>=20
> (or=20
> 	*val =3D 1 << (FIELD_GET(AD4851_OS_RATIO_MSK, osr) + 1);
>=20
> ). Then you can drop ad4851_oversampling_ratios[].
You missed the usage in as4851_read_avail() which is the reason it exists.
These others are just convenient given that it already exists.

Jonathan


>=20
> > +
> > +	st->osr =3D *val;
> > +
> > +	return IIO_VAL_INT;
> > +} =20
>=20
> Best regards
> Uwe
>=20


