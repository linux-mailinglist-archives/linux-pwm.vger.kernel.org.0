Return-Path: <linux-pwm+bounces-3574-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72605996F07
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 17:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33225282FAA
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 15:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39321DF249;
	Wed,  9 Oct 2024 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hh5/x0LT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE81E1A0B06;
	Wed,  9 Oct 2024 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485976; cv=none; b=j3pkHI9w9QPG3jxfvxsYGwVgpjZy4g6KqqkiX7qUbRC0ZwmEBDV79nHcI2ntsyagLH4gy9WosEjQwpeO/R62hWa2CWjZYn+LPJ66EhyhTqbtxehCsPu7PPhukFGiKQpgT/iJlgqdMnaZR1IBUeE6rEZadTrEUkhT6WMGQ4VgiIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485976; c=relaxed/simple;
	bh=bMAvKTxqdqHiwcL4OB2FVzz4YshB8ALhlNR8QDtvW/A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FiBO5o6JDmogXGIOFury+BH7Ek3eR8ebEbGRL1qWjOUiKSycF3d0t3yU94MCwii9cAsvFDyCRRb8gmt3gt3Eq9ZcZHpwws1TyD67s+xWqjxmAdk9/zTiZek//qmLQDGYIiAQ1EiQkiHdU4GJe/lLF2SD2z1i0R9QRAVohngBixA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hh5/x0LT; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9977360f9fso249048066b.0;
        Wed, 09 Oct 2024 07:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728485972; x=1729090772; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E3WtsCpgNIXHaF0APsCrNftN5SWrqWtnB+nbBJCHGk8=;
        b=hh5/x0LT8DCbBth308ip/feOXF6YVINilmYR77o41XwrCzTbpatozF5eUMSNBcO2Le
         zecY7fJeUgQ6Y5sX9stq5jHs52gbFOsnPmI0R6z6HB9DY7cCjpeWoR4JlBjHUWEfUmJc
         DicdZbXPVQRV6VZjEWDtzWDgnCXajZKYiYeAkFdXdjVuefB9xTIbiqXPIqriK3BxtcSu
         dbkFphNtLMOwfo2We28A/vYMwZOIesncbqyUotQBbHFNjJGmFinjohod2kfof5vWkA05
         PK2caf+/ijRT+TTpUKSOGc5s+MWz874TB+ooRS7tCteDvvJHUsKNAm8aNL2BQTQ4JZ7k
         fZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728485972; x=1729090772;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E3WtsCpgNIXHaF0APsCrNftN5SWrqWtnB+nbBJCHGk8=;
        b=EjI3GUdmpsE5LrzyzLXUDIGlUlyPY53oRK4EPrMCpJhe09iQe5d3pkgc5h3lJmZQQx
         K2frWQBFfKqMurZpE2bMreLzr0Ht++hv3D174U/96MSWW49t6DqIqkUDdKXOQhDSWQLg
         2xjEwkQNBOea4dWbZ33uOp+ClV0DN2/HjJ4Ssv4gRlFtPrrOLjPqna900hEAxoeVmUEV
         z+OUUBsW/G+xyDNbaH6PgYQUhv9SookLcsMTF6Vv0HOC27yrNdZ5d7BlyLlbE2Z0t7cw
         beedNn0a+GIckKxYzI+HtaZnVtvBQ/xKP66NhZ1Zoi+SmcqzPz8ez+vmiWyRitsAWjD9
         tvcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA+pyzzXQq8jj49Yre1R2cme706hcepKT2LaVq4AUO8jPoa2L5obw8vw+OQdGxaquB+CuXlW6Y55p9@vger.kernel.org, AJvYcCW+yQuVY0vkLuLrCJjXOVKgcTfo8/pBzPqRawnaLm7sH1T02QG6lj5PYTSLlUaxADbmtRMQ9/Cob71t@vger.kernel.org, AJvYcCWx39NxT9lPkUyqV0CUHB/Gyfu7VLzQCOYdyvmlJ8mZ4OizhLQgvlQEL4rjCvY53qP0YRnPHrJ90zvuvTs=@vger.kernel.org, AJvYcCXj3Ks1spsbtOKk5Gvzej1MCcey6yfhui9dGzZvoAmVsgpWoKALsZ2Ylth4mtaDdDIvGSyqS6vg2eTt@vger.kernel.org, AJvYcCXxPyOpidVu2VJipBIjrAWd7utDOMy8np+qs/GAOTQ04bCpHJ/1MPpIN+CiYT5U9qwQjOGENNY5CP+2HTnM@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvmyy1lMgroXHt1SQxM5Fc46p0XHzER2dxEB9T41U4g6NlELpG
	sln3AIrl29YxgkbNP6pfOlg7/L8vdPSV7m6Z8KYhd/JRbxxrFXcCNfGR9P1ENBY=
X-Google-Smtp-Source: AGHT+IEJKBcrFnVSMldqrFkSB32VcoGZJx7VO9bzRb/opmzn+IGK9ULEl7e4QRixKBFGGfKcFRB8IA==
X-Received: by 2002:a17:907:c7dd:b0:a99:446e:3b5f with SMTP id a640c23a62f3a-a998d3158c1mr250285466b.50.1728485971918;
        Wed, 09 Oct 2024 07:59:31 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e787eecsm661220066b.125.2024.10.09.07.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 07:59:31 -0700 (PDT)
Message-ID: <bb0874600cb0c74f1a3ff8d41a0c3f9e76829009.camel@gmail.com>
Subject: Re: [PATCH v4 5/8] iio: adc: ad7606: Add compatibility to fw_nodes
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
Date: Wed, 09 Oct 2024 16:59:30 +0200
In-Reply-To: <d1229162-b97b-4261-9c4a-e1f83ef14378@baylibre.com>
References: 
	<20241009-ad7606_add_iio_backend_support-v4-0-6971a8c0f1d5@baylibre.com>
	 <20241009-ad7606_add_iio_backend_support-v4-5-6971a8c0f1d5@baylibre.com>
	 <facfe06f51a815f4ff5604aeacd8bd6ed0629be4.camel@gmail.com>
	 <d1229162-b97b-4261-9c4a-e1f83ef14378@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 16:53 +0200, Guillaume Stols wrote:
>=20
> On 10/9/24 16:39, Nuno S=C3=A1 wrote:
> > On Wed, 2024-10-09 at 09:19 +0000, Guillaume Stols wrote:
> > > On the parallel version, the current implementation is only compatibl=
e
> > > with id tables and won't work with fw_nodes, this commit intends to f=
ix
> > > it.
> > >=20
> > > Doing so required to declare ad7606_chip_info structures in the .h fi=
le
> > > so to make them accessible to all the driver files that can set a
> > > pointer to the corresponding chip as the driver data.
> > >=20
> > > Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> > > ---
> > > =C2=A0=C2=A0drivers/iio/adc/ad7606.c=C2=A0=C2=A0=C2=A0=C2=A0 | 283 ++=
++++++++++++++++++++++------------------
> > > -
> > > =C2=A0=C2=A0drivers/iio/adc/ad7606.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
32 +++--
> > > =C2=A0=C2=A0drivers/iio/adc/ad7606_par.c |=C2=A0 30 +++--
> > > =C2=A0=C2=A0drivers/iio/adc/ad7606_spi.c |=C2=A0 96 +++++++++------
> > > =C2=A0=C2=A04 files changed, 254 insertions(+), 187 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> > > index 5b276d087ec3..dfbdea8c28ba 100644
> > > --- a/drivers/iio/adc/ad7606.c
> > > +++ b/drivers/iio/adc/ad7606.c
> > > @@ -78,6 +78,155 @@ static const unsigned int ad7616_oversampling_ava=
il[8] =3D {
> > >=20
> > ...
> >=20
> > > +const struct ad7606_chip_info ad7616_info =3D {
> > > +	.channels =3D ad7616_channels,
> > > +	.init_delay_ms =3D 15,
> > > +	.name =3D "ad7616",
> > > +	.num_channels =3D 17,
> > > +	.oversampling_avail =3D ad7616_oversampling_avail,
> > > +	.oversampling_num =3D ARRAY_SIZE(ad7616_oversampling_avail),
> > > +	.os_req_reset =3D true,
> > > +	.scale_setup_cb =3D ad7606_16bit_chan_scale_setup,
> > > +};
> > > +EXPORT_SYMBOL_NS_GPL(ad7616_info, IIO_AD7606);
> > >=20
> > Maybe my eyes are tricking me but I'm not seeing any MODULE_IMPORT_NS()=
 in the
> > drivers?
>=20
> Hi Nuno,
>=20
> The ad7606_spi.c and ad7606_par.c use MODULE_IMPORT_NS(IIO_AD7606).
>=20
> Chip infos are used in the "coupling" structures, e.g:
>=20
> =C2=A0=C2=A0static const struct ad7606_bus_info ad7616_bus_info =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .chip_info =3D &ad7616_info,=C2=AC
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bops =3D &ad7616_spi_bops,=C2=AC
> =C2=A0=C2=A0};=C2=AC
>=20

You were faster than me. I just realized that code is only in the testing b=
ranch of
IIO and was going to reply to disregard my comment :).

- Nuno S=C3=A1

