Return-Path: <linux-pwm+bounces-3385-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 537A79890BF
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Sep 2024 19:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81EA1F211B6
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Sep 2024 17:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF62140E5F;
	Sat, 28 Sep 2024 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTFwQpOM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684101E531;
	Sat, 28 Sep 2024 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727544194; cv=none; b=YZu8t1cAA1vuRvvke1aPwRSof3CzZXK0u3ZXlh+Y88wINjywOgbwzIIPfJqOQ7eRaA8wQYj1ymk1eTQjlYDx8NxgZ4sB6GckVfR/9W4XeQTG0s3dOq+vVhs2juNZWwVfmSp+4vCA9jMME5YsDSwvkigxhThK5+YiaaBI9AM+bdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727544194; c=relaxed/simple;
	bh=wd/Emuxjg9/zfO5SPUVqf/dFDYAu1S36dkWeltTNXUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmMdd/8Mdp6UycSpESk2XGgBCaV6azYI2tSVhQRR4HZEP3bwMt0wyd4/IqGVG4zhKhVeXN3x/FPSGz7AZhBU1/FVEiiHSvgq4d04eF9HJdTpNxFL5pmH3hylQI7FZdt8fKCefkc5lTdz/iNIgPMine4mFplGf8zQWfuO3kYr3/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTFwQpOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7667C4CEC3;
	Sat, 28 Sep 2024 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727544193;
	bh=wd/Emuxjg9/zfO5SPUVqf/dFDYAu1S36dkWeltTNXUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sTFwQpOMyyOFFEYGSu6JfEqLrn9WOtqSDuuiEyYE1LGC03I9qVhfH8jTMhdMG0Oex
	 ZYYfcvaNT//8TIrgX7mzFSwzLwHFsaWdp2zgzd8DAVxmtvCDcZnhtMpDbiEgOeSVP9
	 BRCBy34W6Vp9zbHG0qBJSD48+OezpiYt6iuNWPwHXvzljEuzPVDOK++aAI8LyL3TMV
	 3OcsvwpXSCWnA0JUkdKD0UU33W33siXl42IHofSvmhQ+EOokmEqssbmGI3W/FyaKsG
	 JgNNCEf4fvVZW3WJtx802yH2i07YpCrmVeeA6roelpmGJxGfTb+1DqfjIBNOW+EBJ/
	 SOfaPnym7puog==
Date: Sat, 28 Sep 2024 18:23:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Antoniu Miclaus 
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>, =?UTF-8?B?Sm/Do28=?= Paulo
 =?UTF-8?B?R29uw6dhbHZlcw==?= <joao.goncalves@toradex.com>, Marius Cristea
 <marius.cristea@microchip.com>, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, Dragos Bogdan <dragos.bogdan@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/7] iio: backend: add API for interface get
Message-ID: <20240928182302.767953f1@jic23-huawei>
In-Reply-To: <83cf3c3eb1cc5fcc06ce72cab14cc0da3bd817b6.camel@gmail.com>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
	<20240923101206.3753-2-antoniu.miclaus@analog.com>
	<CAMknhBHmtpnX-nXxReF-rUW1ks1=iw3m_BmiRUTkf5XckPsvPw@mail.gmail.com>
	<83cf3c3eb1cc5fcc06ce72cab14cc0da3bd817b6.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Sep 2024 12:52:39 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2024-09-26 at 10:40 +0200, David Lechner wrote:
> > On Mon, Sep 23, 2024 at 12:15=E2=80=AFPM Antoniu Miclaus
> > <antoniu.miclaus@analog.com> wrote: =20
> > >=20
> > > Add backend support for obtaining the interface type used.
> > >=20
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > ---
> > > =C2=A0drivers/iio/industrialio-backend.c | 24 ++++++++++++++++++++++++
> > > =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 10 ++++++++++
> > > =C2=A02 files changed, 34 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industr=
ialio-
> > > backend.c
> > > index efe05be284b6..53ab6bc86a50 100644
> > > --- a/drivers/iio/industrialio-backend.c
> > > +++ b/drivers/iio/industrialio-backend.c
> > > @@ -449,6 +449,30 @@ ssize_t iio_backend_ext_info_set(struct iio_dev =
*indio_dev,
> > > uintptr_t private,
> > > =C2=A0}
> > > =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, IIO_BACKEND);
> > >=20
> > > +/**
> > > + * iio_backend_interface_type_get - get the interace type used.
> > > + * @back: Backend device
> > > + * @type: Interface type
> > > + *
> > > + * RETURNS:
> > > + * 0 on success, negative error number on failure.
> > > + */
> > > +int iio_backend_interface_type_get(struct iio_backend *back,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_backend_=
interface_type *type)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D iio_backend_op_call(bac=
k, interface_type_get, type);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (*type > IIO_BACKEND_INTERFA=
CE_CMOS)
Put a COUNT entry or similar on the end of the enum so this doesn't need
updating for more types.

> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, IIO_BACKEND);
> > > +
> > > =C2=A0/**
> > > =C2=A0 * iio_backend_extend_chan_spec - Extend an IIO channel
> > > =C2=A0 * @indio_dev: IIO device
> > > diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> > > index 8099759d7242..ba8ad30ac9ba 100644
> > > --- a/include/linux/iio/backend.h
> > > +++ b/include/linux/iio/backend.h
> > > @@ -63,6 +63,11 @@ enum iio_backend_sample_trigger {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_BACKEND_SAMPLE_TRIGGER=
_MAX
> > > =C2=A0};
> > >=20
> > > +enum iio_backend_interface_type {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_BACKEND_INTERFACE_LVDS,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_BACKEND_INTERFACE_CMOS

trailing comma.

This is going to get bigger!

> > > +};
> > > +
> > > =C2=A0/**
> > > =C2=A0 * struct iio_backend_ops - operations structure for an iio_bac=
kend
> > > =C2=A0 * @enable: Enable backend.
> > > @@ -81,6 +86,7 @@ enum iio_backend_sample_trigger {
> > > =C2=A0 * @extend_chan_spec: Extend an IIO channel.
> > > =C2=A0 * @ext_info_set: Extended info setter.
> > > =C2=A0 * @ext_info_get: Extended info getter.
> > > + * @interface_type_get: Interface type.
> > > =C2=A0 **/
> > > =C2=A0struct iio_backend_ops {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*enable)(struct iio_b=
ackend *back);
> > > @@ -113,6 +119,8 @@ struct iio_backend_ops {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 const char *buf, size_t len);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*ext_info_get)(struct=
 iio_backend *back, uintptr_t private,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan, char *buf);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*interface_type_get)(struc=
t iio_backend *back,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_backend_interf=
ace_type *type);
> > > =C2=A0};
> > >=20
> > > =C2=A0int iio_backend_chan_enable(struct iio_backend *back, unsigned =
int chan);
> > > @@ -142,6 +150,8 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *=
indio_dev,
> > > uintptr_t private,
> > > =C2=A0ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uin=
tptr_t private,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec=
 *chan, char *buf);
> > >=20
> > > +int iio_backend_interface_type_get(struct iio_backend *back,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_backend_=
interface_type *type);
> > > =C2=A0int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_backend *back,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec *chan=
);
> > > --
> > > 2.46.0
> > >  =20
> >=20
> > This seems very specific to the AD485x chips and the AXI ADC backend.
> > Since it is describing how the chip is wired to the AXI DAC IP block,
> > I would be tempted to use the devicetree for this info instead of
> > adding a new backend function. =20
>=20
> Not sure If I'm following your point but I think this is the typical case=
 where the
> chip (being it a DAC or ADC) supports both CMOS and LVDS interfaces. Natu=
rally you
> only use one on your system and this is a synthesis parameter on the FPGA=
 IP core.
> Therefore, it makes sense for the frontend to have way to ask for this in=
formation to
> the backend.
>=20
> That said, we could also have a DT parameter but, ideally, we would then =
need a way
> to match the parameter with the backend otherwise we could have DT statin=
g LVDS and
> the backend built with CMOS.

That would be a DTS bug that you should fix :)  For this to make sense you =
are
relying on an FPGA that also has pins flexible enough to support LVDS and C=
MOS
so it's only a firmware thing. Been a while since I last messed with FPGAs,
but that seems unlikely to be true in general.

So far I'm with David on this, feels like something we shouldn't be discove=
ring
at runtime though maybe that's a convenience that we do want to enable.

>=20
> Other thing that we could think about is a new devm_iio_backend_get_with_=
info() where
> the frontend would get some constant and static info about the backend (t=
he interface
> type would an ideal match for something like this). But I feel it's still=
 early days
> for something like this :)
>=20
> - Nuno S=C3=A1


