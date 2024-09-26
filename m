Return-Path: <linux-pwm+bounces-3376-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8545098720C
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Sep 2024 12:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051D61F21800
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Sep 2024 10:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A5A1AD9FC;
	Thu, 26 Sep 2024 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8Frapnu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5082F1AD9E3;
	Thu, 26 Sep 2024 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347965; cv=none; b=jYhkv85CvkzGcIPLUVausrby7xH8uCIjSuz5PSFa2cVhYl//OPwYeuuBt1WVGER/pS4dPDNEbbWAkk1NAYrBkV4gNEtQ8BKlKK1Vf6m15Ww5iXFtpGIRMDm1YiWMrLHMBU257ymdBmILmP3FDVMxXmyf8s2fRZgp/1IOhBD7mpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347965; c=relaxed/simple;
	bh=rNLSkaEd7oDUKlk8fUcvYr/AJfk6k2J1D0qkHx1VVI8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eQ+ZW2KcbDGRxmqA87vGsm22vtkXEvwgnDMKpZYpVXFScoymHRCisOTPmFmvPuTfWFZZTjdKvUK9Mb3M8cdXkjGgM/b302yvMPRzusC5/7An9iph7v4rEBArsOQIBuc1xP/YvmrdKISkAXJlbrVrl8Pqt6/CqVNBXdbAKLk/EEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8Frapnu; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so137162666b.1;
        Thu, 26 Sep 2024 03:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727347961; x=1727952761; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rNLSkaEd7oDUKlk8fUcvYr/AJfk6k2J1D0qkHx1VVI8=;
        b=B8FrapnuhKSSh8TS3j1PiqLveNu2BD9Kpsa4hg37bXNzaZQI7FAFUfDOUSrf2YYwHH
         MhcV8M1fz7Vzo95idRdo9xeTM866UwupCUkJ6Zl9jGXb3Y5kTyFQNpsDRCPPGKg999Bw
         6e9+f3Fwovc26Caia4uEX50Jrpz4eJSxC7/CBsLsuVjDHMZun6aOdmJdpo7KISLwdzd6
         2VKqC5SbDgbcsfsP72DYL1raX6tcRhDC/s/FYxIDR4QMSG2kFNAflcDluiWwjBXYEiR6
         oLX+qXbEnTMvn5UayHCMlSH5kw8mSM3ysbfo5aoYPKwOitk4xDrHZfdO0CikPlGitQKn
         eV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727347961; x=1727952761;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rNLSkaEd7oDUKlk8fUcvYr/AJfk6k2J1D0qkHx1VVI8=;
        b=GJQnqUBhekHd4MjpqHSt4WCJJ+tatKqTPZ7n3AreBYUeVCJuoyCu13YiF1X52TMNxF
         24qRCyoTDd2EFn8CzR5S39P8w9kDxJE+X6uWqMku/c/fUAxFF9KunTkzMnSq/4cvQxgg
         /Xu++ZPQa2gIgD+ZikfBBJ0K+UBdkF7H8pqSkd5NmGV7LjqGtlMIGyDAc3xYgI5iPA3V
         XmLJGBe6WM1Uv//axMCv5xwcvRB7ox1Ickn2aXLnRFZS/B42SgASK3ogSj0lRYqNS/Z6
         1CBwY7hbB9fjhDx+lQgLVODTI+qiG4dZLOguTDChzYSgfjM5Yox4BdiwHcny0LklhXKT
         6akQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSdG7uUR8FAz9jp/Se/jbwX3cuQXACkTejubAocZXxWTPWuEl7g4XoyA2BSTveAJ9tLOMDJSGmGj9MNAW1@vger.kernel.org, AJvYcCW9wQCHIMf2QIB9BVZ2GU0egMyOQkCWfyPud1ftbpp5+QkhNE9H4OfWvnuVdfEVEWBb2l631N3CpMt4@vger.kernel.org, AJvYcCXen2r7H7oO/tivAVX4GBjJwE/zLqH8V4/z5F0x4aoncgO0KeVS/rbr05jtD0bVtM86/rI6EwPLAsqq@vger.kernel.org, AJvYcCXnMPgiatLKU6gu+gv/d4EEaHeGsTvKN9YDAcQ0sIegmknp3G0JLI57DUPkBRhGdydPlzMLQo+xnAJn@vger.kernel.org
X-Gm-Message-State: AOJu0YxJpWsTVJxx1Qb3mX5z6IIU/EfY2YzbdEP4wHbZq5XqObXpIiS8
	IAcCHzo4etGR1OsXHTSXUTpYDQTK1kwidtaMXx5sWR/ITrnEp7Y1
X-Google-Smtp-Source: AGHT+IFEqLjZ85oYoyLQbtQFM71BDt+U30LBxiyP+dOTJVzn/sVZoFDhT1nJPJ4DAiUCLcjVwrOm0w==
X-Received: by 2002:a17:907:2cc4:b0:a8a:913e:418b with SMTP id a640c23a62f3a-a93a0369e7bmr538221366b.20.1727347961226;
        Thu, 26 Sep 2024 03:52:41 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:341e:1201:c434:b5b1:98a6:efed])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93a1a8c71csm221130666b.87.2024.09.26.03.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 03:52:40 -0700 (PDT)
Message-ID: <83cf3c3eb1cc5fcc06ce72cab14cc0da3bd817b6.camel@gmail.com>
Subject: Re: [PATCH 1/7] iio: backend: add API for interface get
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Antoniu Miclaus
	 <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@kernel.org>, Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
  AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,  =?ISO-8859-1?Q?Jo=E3o?= Paulo
 =?ISO-8859-1?Q?Gon=E7alves?= <joao.goncalves@toradex.com>, Marius Cristea
 <marius.cristea@microchip.com>,  Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, Dragos Bogdan <dragos.bogdan@analog.com>,
 linux-iio@vger.kernel.org,  linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-pwm@vger.kernel.org
Date: Thu, 26 Sep 2024 12:52:39 +0200
In-Reply-To: <CAMknhBHmtpnX-nXxReF-rUW1ks1=iw3m_BmiRUTkf5XckPsvPw@mail.gmail.com>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
	 <20240923101206.3753-2-antoniu.miclaus@analog.com>
	 <CAMknhBHmtpnX-nXxReF-rUW1ks1=iw3m_BmiRUTkf5XckPsvPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-26 at 10:40 +0200, David Lechner wrote:
> On Mon, Sep 23, 2024 at 12:15=E2=80=AFPM Antoniu Miclaus
> <antoniu.miclaus@analog.com> wrote:
> >=20
> > Add backend support for obtaining the interface type used.
> >=20
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> > =C2=A0drivers/iio/industrialio-backend.c | 24 ++++++++++++++++++++++++
> > =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 10 ++++++++++
> > =C2=A02 files changed, 34 insertions(+)
> >=20
> > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industria=
lio-
> > backend.c
> > index efe05be284b6..53ab6bc86a50 100644
> > --- a/drivers/iio/industrialio-backend.c
> > +++ b/drivers/iio/industrialio-backend.c
> > @@ -449,6 +449,30 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *i=
ndio_dev,
> > uintptr_t private,
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, IIO_BACKEND);
> >=20
> > +/**
> > + * iio_backend_interface_type_get - get the interace type used.
> > + * @back: Backend device
> > + * @type: Interface type
> > + *
> > + * RETURNS:
> > + * 0 on success, negative error number on failure.
> > + */
> > +int iio_backend_interface_type_get(struct iio_backend *back,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_backend_int=
erface_type *type)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D iio_backend_op_call(back,=
 interface_type_get, type);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (*type > IIO_BACKEND_INTERFACE=
_CMOS)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return -EINVAL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, IIO_BACKEND);
> > +
> > =C2=A0/**
> > =C2=A0 * iio_backend_extend_chan_spec - Extend an IIO channel
> > =C2=A0 * @indio_dev: IIO device
> > diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> > index 8099759d7242..ba8ad30ac9ba 100644
> > --- a/include/linux/iio/backend.h
> > +++ b/include/linux/iio/backend.h
> > @@ -63,6 +63,11 @@ enum iio_backend_sample_trigger {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_BACKEND_SAMPLE_TRIGGER_M=
AX
> > =C2=A0};
> >=20
> > +enum iio_backend_interface_type {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_BACKEND_INTERFACE_LVDS,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_BACKEND_INTERFACE_CMOS
> > +};
> > +
> > =C2=A0/**
> > =C2=A0 * struct iio_backend_ops - operations structure for an iio_backe=
nd
> > =C2=A0 * @enable: Enable backend.
> > @@ -81,6 +86,7 @@ enum iio_backend_sample_trigger {
> > =C2=A0 * @extend_chan_spec: Extend an IIO channel.
> > =C2=A0 * @ext_info_set: Extended info setter.
> > =C2=A0 * @ext_info_get: Extended info getter.
> > + * @interface_type_get: Interface type.
> > =C2=A0 **/
> > =C2=A0struct iio_backend_ops {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*enable)(struct iio_bac=
kend *back);
> > @@ -113,6 +119,8 @@ struct iio_backend_ops {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 const char *buf, size_t len);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*ext_info_get)(struct i=
io_backend *back, uintptr_t private,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan, char *buf);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*interface_type_get)(struct =
iio_backend *back,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_backend_interface=
_type *type);
> > =C2=A0};
> >=20
> > =C2=A0int iio_backend_chan_enable(struct iio_backend *back, unsigned in=
t chan);
> > @@ -142,6 +150,8 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *in=
dio_dev,
> > uintptr_t private,
> > =C2=A0ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintp=
tr_t private,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec=
 *chan, char *buf);
> >=20
> > +int iio_backend_interface_type_get(struct iio_backend *back,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_backend_int=
erface_type *type);
> > =C2=A0int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_backend *back,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec *chan=
);
> > --
> > 2.46.0
> >=20
>=20
> This seems very specific to the AD485x chips and the AXI ADC backend.
> Since it is describing how the chip is wired to the AXI DAC IP block,
> I would be tempted to use the devicetree for this info instead of
> adding a new backend function.

Not sure If I'm following your point but I think this is the typical case w=
here the
chip (being it a DAC or ADC) supports both CMOS and LVDS interfaces. Natura=
lly you
only use one on your system and this is a synthesis parameter on the FPGA I=
P core.
Therefore, it makes sense for the frontend to have way to ask for this info=
rmation to
the backend.

That said, we could also have a DT parameter but, ideally, we would then ne=
ed a way
to match the parameter with the backend otherwise we could have DT stating =
LVDS and
the backend built with CMOS.

Other thing that we could think about is a new devm_iio_backend_get_with_in=
fo() where
the frontend would get some constant and static info about the backend (the=
 interface
type would an ideal match for something like this). But I feel it's still e=
arly days
for something like this :)

- Nuno S=C3=A1

