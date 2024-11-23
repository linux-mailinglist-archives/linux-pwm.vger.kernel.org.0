Return-Path: <linux-pwm+bounces-4124-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 090EE9D69D8
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Nov 2024 17:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D41161792
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Nov 2024 16:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F2B41C92;
	Sat, 23 Nov 2024 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwjaODSX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38BA4A0A;
	Sat, 23 Nov 2024 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732377777; cv=none; b=ObtJQ8cGKmU/pjw1AyEXvVCOvIq+HeWHGSMR80IWLzyg9KhD1DtpXGt1SeqwnetD9oi1GCRN/19Pj6dmsbCAx5ADx9RYLKd9esEea84yULz0Cf6iMdi+UBLYirvzaHUNUCihNKo3ccuspyZxYRtPPZrroxGxfqAEcIN8MUcyBM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732377777; c=relaxed/simple;
	bh=gknFFIhuKFYyMcx3T6Eo9QJPAfJs1EKLFbqVVENxTPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rw0mFirrPm9jtI35oWp4q0GyHyA5selaPYQu0UIE9CudIdI3b/Gaad07CMYhjsHslbCMhRMEjB/EQTr382dXiPvtNeIHs7+ml38brNjbFm2NTj2PKbSvtOqhE2xxkk6F1/8M+bCghJRgPgrjtqAv7zNS5vivWccGdp63c+Li0pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwjaODSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739D9C4CECD;
	Sat, 23 Nov 2024 16:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732377776;
	bh=gknFFIhuKFYyMcx3T6Eo9QJPAfJs1EKLFbqVVENxTPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KwjaODSXSU/ZooDV/6sS8MdNwZwOndxsYulX6j5QPANGERlNozIlbyAhdoeYMG+D3
	 uoXLnRa16y2RNPoWwlccQKd/xotndUgTv0S6PBaY5oz4K1VkI1ILZ4kwJyuwfkiBvO
	 I4T05kIkj/csWJ1RG/xXc48d2JEXqSGJEAUJF8W0p8rrgpmAoQLQI+2Hlk9Y3SqA7E
	 yTp/IcKllFeifYcbcLbHA6hb+KhWX44J902Omdx+rlgTr+kcoeGdKVtNyVK3Pgf7nK
	 4Wj/roWV48I6/9aZTLID03VQFC+iyAqwOsEoZ0NTNhKp3XeSGVap4nRChnwjvqs4Yr
	 KdWTe67EeBK0A==
Date: Sat, 23 Nov 2024 16:02:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, robh@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 3/8] iio: backend: add API for oversampling
Message-ID: <20241123160249.219161d5@jic23-huawei>
In-Reply-To: <e683ce92267ec4cafa825cdf1767939d922b04ea.camel@gmail.com>
References: <20241111121203.3699-1-antoniu.miclaus@analog.com>
	<20241111121203.3699-4-antoniu.miclaus@analog.com>
	<e683ce92267ec4cafa825cdf1767939d922b04ea.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Nov 2024 16:41:02 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2024-11-11 at 14:11 +0200, Antoniu Miclaus wrote:
> > Add backend support for enabling/disabling oversampling.
> >=20
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> > changes in v6:
> > =C2=A0- add iio backend commit for oversampling enable/disable
> > =C2=A0drivers/iio/industrialio-backend.c | 14 ++++++++++++++
> > =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 3 +++
> > =C2=A02 files changed, 17 insertions(+)
> >=20
> > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industria=
lio-
> > backend.c
> > index ea184fc2c838..6ba445ba3dd0 100644
> > --- a/drivers/iio/industrialio-backend.c
> > +++ b/drivers/iio/industrialio-backend.c
> > @@ -681,6 +681,20 @@ int iio_backend_data_size_set(struct iio_backend *=
back,
> > unsigned int size)
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, IIO_BACKEND);
> > =C2=A0
> > +/**
> > + * iio_backend_oversampling_en - set the data width/size in the data b=
us. =20
>=20
> Seems unrelated?
>=20
> > + * @back: Backend device
> > + * @en: oversampling enabled/disabled.
> > + *
> > + * Return:
> > + * 0 on success, negative error number on failure.
> > + */
> > +int iio_backend_oversampling_en(struct iio_backend *back, bool en)
Odd to just be on or off vs a count of how much to oversample by
with 1 meaning don't oversample, 2,4,8 etc saying how much to oversample by.

> > +{
> > +	return iio_backend_op_call(back, oversampling_en, en);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(iio_backend_oversampling_en, IIO_BACKEND);
> > + =20
>=20
> There was some discussion around having APIs with a boolean parameter (ac=
tually
> even improving - in terms of callbacks - further with some generic
> getter/setter's) or having two callbacks:
>=20
> iio_backend_oversampling_enable()
> iio_backend_oversampling_disable()
>=20
> I'm guessing you don't really want to do any major conversion/refactoring=
 at
> this point in your series so I have a slight preference for just keeping =
the
> current style of dedicated enable and disable APIs (irrespective of being=
 the
> better approach or not). Please consider it, if you have to re-spin the s=
eries.
Agreed. Keep it consistent for now.  I don't mind a proposal to refactor
the lot (though not yet convinced either way on it being a good idea)
but I don't want to see it inconsistent.

>=20
> - Nuno S=C3=A1
>=20
>=20


