Return-Path: <linux-pwm+bounces-3466-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069E39905FA
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 16:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1608C1C20D2C
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 14:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17288217304;
	Fri,  4 Oct 2024 14:25:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EAD20FAB3;
	Fri,  4 Oct 2024 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051958; cv=none; b=GWrJpfU4vjH3J+YGcpO+L+LsgYxnlnZ5byvLKKRU7mEubMw7e6zhBjmS1nlBJQhXslZs0S00Xy5FKODp2wHLqTSwGPwInB/yLcUXQVQu0mtSBv/jBugeXFXf9EJ7m+iLHHKRQNr403m5OssnBmZemt/U3psg7p6o9eC1vSphQF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051958; c=relaxed/simple;
	bh=VLd66Cbz9muKF7Etf6eUjwWYZzDeImjqSXpDNbBE3Cg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKxoOIT/lJKy1tQ7T9LZmBqHWmohd5FQzbZtYLCekdQ8yqfb5H0r9pZR3q28YWxf0SygruPnyV89oCxGjhWsHM8cbCcHleo/Gq7XN9UlwwvOvq7Osij6MeY6AZQTbCKwoATP3WjwmvnAa4zgzTyeJi6osahP5ymc3pwyJp47w60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XKrSG1qyFz6HJc8;
	Fri,  4 Oct 2024 22:25:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E13691400CA;
	Fri,  4 Oct 2024 22:25:53 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Oct
 2024 16:25:53 +0200
Date: Fri, 4 Oct 2024 15:25:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Guillaume Stols <gstols@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<ukleinek@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "Michael
 Hennerich" <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Michal Marek
	<mmarek@suse.com>, <linux-pwm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fbdev@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <aardelean@baylibre.com>,
	<dlechner@baylibre.com>, <jstephan@baylibre.com>
Subject: Re: [PATCH v2 07/10] iio: adc: ad7606: Add compatibility to
 fw_nodes
Message-ID: <20241004152551.00000813@Huawei.com>
In-Reply-To: <57c5d8b1-295a-492f-b17c-b44caf8aeb2d@baylibre.com>
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
	<20240920-ad7606_add_iio_backend_support-v2-7-0e78782ae7d0@baylibre.com>
	<20240929134412.506998db@jic23-huawei>
	<57c5d8b1-295a-492f-b17c-b44caf8aeb2d@baylibre.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
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

On Wed, 2 Oct 2024 02:12:28 +0200
Guillaume Stols <gstols@baylibre.com> wrote:

> On 9/29/24 14:44, Jonathan Cameron wrote:
> > On Fri, 20 Sep 2024 17:33:27 +0000
> > Guillaume Stols <gstols@baylibre.com> wrote:
> > =20
> >> On the parallel version, the current implementation is only compatible
> >> with id tables and won't work with fw_nodes, this commit intends to fix
> >> it.
> >>
> >> Also, chip info is moved in the .h file so to be accessible to all the=
 =20
> > chip info is not moved (I was going to say no to that) but an
> > extern is used to make it available. So say that rather than moved here.
> > =20
> >> driver files that can set a pointer to the corresponding chip as the
> >> driver data.
> >>
> >>  =20
> >> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> >> index c13dda444526..18c87fe9a41a 100644
> >> --- a/drivers/iio/adc/ad7606.h
> >> +++ b/drivers/iio/adc/ad7606.h
> >> @@ -38,8 +38,19 @@
> >>   	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCAL=
E),\
> >>   		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> >>  =20
> >> +enum ad7606_supported_device_ids {
> >> +	ID_AD7605_4,
> >> +	ID_AD7606_8,
> >> +	ID_AD7606_6,
> >> +	ID_AD7606_4,
> >> +	ID_AD7606B,
> >> +	ID_AD7616,
> >> +};
> >> +
> >>   /**
> >>    * struct ad7606_chip_info - chip specific information
> >> + * @name		device name
> >> + * @id			device id =20
> > ID in chip info normally indicates something bad in the design. In that=
 somewhere
> > we have code that is ID dependent rather than all such code / data being
> > found directly in this structure (or callbacks found from here).
> > Can we avoid it here? =20
>=20
> Hi Jonathan,
>=20
> chip_info has to describe the chip hardwarewise, but there are different=
=20
> bops depending on the wiring (interface used, and backend/no backend).

Normal solution to this is multiple chip specific structures so they
become specific to a chip + some wiring option. Then you just
pick between static const structures.

Does that work here?

You will need them exposed (extern) from your header but that's
not too bad.

Aim is to pick just one structure that describes all the 'specific'
stuff for the driver.  That brings all that stuff into one place and
provides an easy way to extend to new combinations of options for
other devices.

Jonathan


>=20
> The easiest way I found was to use the ID in a switch/case to=20
> determinate which bops I should take (well it was only needed in the spi=
=20
> version since it is the one supporting almost all the chips while the=20
> other ones still support only one). For instance, the ad7606B will use=20
> ad7606_bi_bops if it has a backend and ad7606B_spi_bops for spi version.
>=20
> If I can't use the ID, the only way I see is creating 3 fields in=20
> chip_info (spi_ops, par_ops, backend_ops) and to initialize every=20
> chip_info structure with its associated op(s) for the associated=20
> interface. This would also lead to declare the different instances of=20
> ad7606_bus_ops directly in ad7606.h=A0 (I dont like it very much but see=
=20
> no other option).
>=20
> Do you think it's better that way ? Or do you have any other idea ?
>=20
> Regards,
>=20
> Guillaume
>=20
> > =20
> >>    * @channels:		channel specification
> >>    * @num_channels:	number of channels
> >>    * @oversampling_avail	pointer to the array which stores the availab=
le
> >> @@ -50,6 +61,8 @@ =20
> > ...
> > =20
> >> diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par=
.c
> >> index d651639c45eb..7bac39033955 100644
> >> --- a/drivers/iio/adc/ad7606_par.c
> >> +++ b/drivers/iio/adc/ad7606_par.c
> >> @@ -11,6 +11,7 @@
> >>   #include <linux/mod_devicetable.h>
> >>   #include <linux/module.h>
> >>   #include <linux/platform_device.h>
> >> +#include <linux/property.h>
> >>   #include <linux/types.h>
> >>  =20
> >>   #include <linux/iio/iio.h>
> >> @@ -89,12 +90,20 @@ static const struct ad7606_bus_ops ad7606_par8_bop=
s =3D {
> >>  =20
> >>   static int ad7606_par_probe(struct platform_device *pdev)
> >>   {
> >> -	const struct platform_device_id *id =3D platform_get_device_id(pdev);
> >> +	const struct ad7606_chip_info *chip_info;
> >> +	const struct platform_device_id *id;
> >>   	struct resource *res;
> >>   	void __iomem *addr;
> >>   	resource_size_t remap_size;
> >>   	int irq;
> >>  =20
> >> +	if (dev_fwnode(&pdev->dev)) {
> >> +		chip_info =3D device_get_match_data(&pdev->dev);
> >> +	} else {
> >> +		id =3D platform_get_device_id(pdev);
> >> +		chip_info =3D (const struct ad7606_chip_info *)id->driver_data;
> >> +	}
> >> +
> >>   	irq =3D platform_get_irq(pdev, 0);
> >>   	if (irq < 0)
> >>   		return irq;
> >> @@ -106,25 +115,25 @@ static int ad7606_par_probe(struct platform_devi=
ce *pdev)
> >>   	remap_size =3D resource_size(res);
> >>  =20
> >>   	return ad7606_probe(&pdev->dev, irq, addr,
> >> -			    id->name, id->driver_data, =20
> > Rewrap to move chip_info up a line perhaps.
> > =20
> >> +			    chip_info,
> >>   			    remap_size > 1 ? &ad7606_par16_bops :
> >>   			    &ad7606_par8_bops); =20
>=20


