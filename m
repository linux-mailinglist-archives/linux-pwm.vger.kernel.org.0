Return-Path: <linux-pwm+bounces-4126-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8434E9D69E0
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Nov 2024 17:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7B2281B9B
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Nov 2024 16:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B96413635B;
	Sat, 23 Nov 2024 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJ7tXGjg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351CC2EB1F;
	Sat, 23 Nov 2024 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732377967; cv=none; b=LxNS3uVP449Rsz28SsEfFUuJ5Vgrg2IgdPTvOKWgVgriZp//LlUB2+ErUpqbSuXgwPqX3CUo8YHhjaDbxpK1Wo1eEPuBI5/UZYfbGUuiqKbnZcMjPCrIGoJ1BELZ5mCqsJQmm17at6iLso/nQiEgeTYazXP7nQGttcPNBW3c4as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732377967; c=relaxed/simple;
	bh=1R2RKn5kMMmM8wcrkQlUoDdW3Es+C/PmCrNQMvC3nwk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmu9sXk9C7WB/f3kT3T0mzarJNLAG4agtabmkYs8ozwDImfJOUThwA6zhE6zQHdZiC5TrsC5mBs6P6ysqaPBT9nMX9XtBRugQ9vkarswfqqZHezJ1bEJMIheO4uxgTk5eJxZXm0KINZWRCXfB5AU425xkFZgXRFDS7cCSANp/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJ7tXGjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CED7C4CECF;
	Sat, 23 Nov 2024 16:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732377966;
	bh=1R2RKn5kMMmM8wcrkQlUoDdW3Es+C/PmCrNQMvC3nwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VJ7tXGjgxn3iGvM+nfuRcPgGbCb7oleGsa7LJP/I0FmTYS4h7ej5FpAW9Pies4JUt
	 NqaX5XcSZ6FDSCN6n0bWBg7GLsJoU1oC+qTo1nRK3J1GmG3iT7VL46+A17QXeiJiaR
	 XzghJWPRDuQ7zphCkFg04JySY8FrnWj00DafHm8MKGSQSdDM4xTzUjhMdQDCk43+Ym
	 iCt115kkXQhZO7Q9blCjI07j2Z1nAtFsQnSFDqKARQicqL5PjrevSK432Ag5iEueBg
	 LDBBAYRzB7rTygAXblhaSt7J3MYlp+Y+ZXGmMrTIU8HQNjuYGHYxxYby3w2giVdLsb
	 a1fo8jU7w+w6A==
Date: Sat, 23 Nov 2024 16:05:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, robh@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 3/8] iio: backend: add API for oversampling
Message-ID: <20241123160559.56c57fc7@jic23-huawei>
In-Reply-To: <20241123160249.219161d5@jic23-huawei>
References: <20241111121203.3699-1-antoniu.miclaus@analog.com>
	<20241111121203.3699-4-antoniu.miclaus@analog.com>
	<e683ce92267ec4cafa825cdf1767939d922b04ea.camel@gmail.com>
	<20241123160249.219161d5@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 23 Nov 2024 16:02:49 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 11 Nov 2024 16:41:02 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Mon, 2024-11-11 at 14:11 +0200, Antoniu Miclaus wrote: =20
> > > Add backend support for enabling/disabling oversampling.
> > >=20
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > ---
> > > changes in v6:
> > > =C2=A0- add iio backend commit for oversampling enable/disable
> > > =C2=A0drivers/iio/industrialio-backend.c | 14 ++++++++++++++
> > > =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 3 +++
> > > =C2=A02 files changed, 17 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industr=
ialio-
> > > backend.c
> > > index ea184fc2c838..6ba445ba3dd0 100644
> > > --- a/drivers/iio/industrialio-backend.c
> > > +++ b/drivers/iio/industrialio-backend.c
> > > @@ -681,6 +681,20 @@ int iio_backend_data_size_set(struct iio_backend=
 *back,
> > > unsigned int size)
> > > =C2=A0}
> > > =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, IIO_BACKEND);
> > > =C2=A0
> > > +/**
> > > + * iio_backend_oversampling_en - set the data width/size in the data=
 bus.   =20
> >=20
> > Seems unrelated?
> >  =20
> > > + * @back: Backend device
> > > + * @en: oversampling enabled/disabled.
> > > + *
> > > + * Return:
> > > + * 0 on success, negative error number on failure.
> > > + */
> > > +int iio_backend_oversampling_en(struct iio_backend *back, bool en) =
=20
> Odd to just be on or off vs a count of how much to oversample by
> with 1 meaning don't oversample, 2,4,8 etc saying how much to oversample =
by.

Looking at the code, why does the backend care?  Seems you only set the rat=
io
on the ADC, not the in the FPGA IP. So I don't follow how that is useful

Jonathan


>=20
> > > +{
> > > +	return iio_backend_op_call(back, oversampling_en, en);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(iio_backend_oversampling_en, IIO_BACKEND);
> > > +   =20
> >=20
> > There was some discussion around having APIs with a boolean parameter (=
actually
> > even improving - in terms of callbacks - further with some generic
> > getter/setter's) or having two callbacks:
> >=20
> > iio_backend_oversampling_enable()
> > iio_backend_oversampling_disable()
> >=20
> > I'm guessing you don't really want to do any major conversion/refactori=
ng at
> > this point in your series so I have a slight preference for just keepin=
g the
> > current style of dedicated enable and disable APIs (irrespective of bei=
ng the
> > better approach or not). Please consider it, if you have to re-spin the=
 series. =20
> Agreed. Keep it consistent for now.  I don't mind a proposal to refactor
> the lot (though not yet convinced either way on it being a good idea)
> but I don't want to see it inconsistent.
>=20
> >=20
> > - Nuno S=C3=A1
> >=20
> >  =20
>=20
>=20


