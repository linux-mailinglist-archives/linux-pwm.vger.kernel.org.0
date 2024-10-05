Return-Path: <linux-pwm+bounces-3497-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D5B9918D3
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 19:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D79A282651
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 17:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419C8158D8D;
	Sat,  5 Oct 2024 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxjvdikD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC1A158A13;
	Sat,  5 Oct 2024 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728149286; cv=none; b=ECTW1J2qWP/k1swTfGdS3oIO78glk0izXSI/wp4xxFFVSmVAlmFku7rjh/BOoekuF1RWm1RiAuSFW8Ht//E5U3tOeXdY6qBoJUlH8Rm2UtzpgQayIMzjCwELpde4ipzsmH1wisHV+fvCJ0Mr2M6IJB4WqqwGU71FwDiOHCOksDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728149286; c=relaxed/simple;
	bh=2Vswsad+KPTveGlS2+T0u1QhZ+Ub2DCQjZ9NKPLrF4I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SVdatOcFx9vkLsZagl2WNooAtfSrSKpI+vlOQipbQOuWJAzSEaxNRnYvN9VBHCOeiq5QSoBRV4ZugegEpRdc4DOY1GN2tHSoIvANkWDHdSWoEpHcUty8PLdT4lIe3KWOxuwuHVV+up8dQHaM1pk3ABVrE1wMDsJsc6QXvaSGX0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxjvdikD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24661C4CEC2;
	Sat,  5 Oct 2024 17:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728149285;
	bh=2Vswsad+KPTveGlS2+T0u1QhZ+Ub2DCQjZ9NKPLrF4I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MxjvdikDXVZbgr24c/LQt4Q8/kUvpR+nvPx/EkG9xxnXFx+HAl2fQf4OVFOK87gRa
	 fqxfmRK1M3t+H8YB8FDjh0n48Wst1T9ABretXEMeR57gMNqas+efolOL2IagpVwL4C
	 L3yxT+fF0X9uHUGtQbFnoZ3ls81mBYMz7QjVXq+waFLWLOdrHngM9y0Uy7ONm8vXAo
	 NQ/ZZqwHzcgB6cf0r5Hxr/qw+6DYCINlHFukunogqisukVGD1ihFY8RXORKouLC81h
	 d3k8c6jRYVVrL75S5dSghETOH1xXObgpZMt/NGTQt27JFtYcKdZgcRO62HWI/J6uPO
	 CrPNMjLA7oJDw==
Date: Sat, 5 Oct 2024 18:27:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "Hennerich,
 Michael" <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, Mike Looijmans <mike.looijmans@topic.nl>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Alisa-Dariana Roman
 <alisadariana@gmail.com>, "Cuciurean, Sergiu"
 <Sergiu.Cuciurean@analog.com>, "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 6/7] iio: adc: ad485x: add ad485x driver
Message-ID: <20241005182729.014819df@jic23-huawei>
In-Reply-To: <CY4PR03MB33996A380953651B290EC3839B722@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
	<20240923101206.3753-7-antoniu.miclaus@analog.com>
	<20240928184722.314b329b@jic23-huawei>
	<CY4PR03MB33991208029C4877760B528D9B772@CY4PR03MB3399.namprd03.prod.outlook.com>
	<Zvvw7ah4wGsl2vjw@smile.fi.intel.com>
	<CY4PR03MB3399D90F2A3C7AE3505B60A29B772@CY4PR03MB3399.namprd03.prod.outlook.com>
	<4ee001d2-67d0-45ab-ae62-ce5b8dd7553e@baylibre.com>
	<CY4PR03MB3399D9B9C5B4952E7A7F40F39B712@CY4PR03MB3399.namprd03.prod.outlook.com>
	<42165d2b-1103-4316-841c-45514a626be7@baylibre.com>
	<CY4PR03MB33996A380953651B290EC3839B722@CY4PR03MB3399.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Oct 2024 14:07:37 +0000
"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:

> > On 10/3/24 5:14 AM, Miclaus, Antoniu wrote: =20
> > >> On 10/1/24 8:51 AM, Miclaus, Antoniu wrote: =20
> > >>>>> Regarding the bulk writes/reads, the msb/mid/lsb registers need t=
o be
> > >>>>> read/write in a specific order and the addresses are not incremen=
tal, =20
> > >>>>
> > >>>> We have _noinc() variants of regmap accessors. =20
> > >>> [Miclaus, Antoniu]
> > >>> I think _noinc() functions read from the same register address so i=
t doesn't
> > >>> apply.
> > >>> I am reading values from multiple register addresses that are not r=
eg_addr,
> > >>> reg_addr+1, reg_addr+2. =20
> > >>
> > >> I'm confused by the statement that the registers are not incremental.
> > >>
> > >> For example, this patch defines...
> > >>
> > >> +#define AD485X_REG_CHX_OFFSET_LSB(ch)
> > >> 	AD485X_REG_CHX_OFFSET(ch)
> > >> +#define AD485X_REG_CHX_OFFSET_MID(ch)
> > >> 	(AD485X_REG_CHX_OFFSET_LSB(ch) + 0x01)
> > >> +#define AD485X_REG_CHX_OFFSET_MSB(ch)
> > >> 	(AD485X_REG_CHX_OFFSET_MID(ch) + 0x01)
> > >>
> > >> This looks exactly like reg_addr, reg_addr+1, reg_addr+2 to me. =20
> > > Yes you are right. Although I tested with hardware and it seems that =
the =20
> > registers =20
> > > are not properly written when using bulk operations. My guess is that=
 =20
> > holding CS low during =20
> > > the entire transaction might be a possible issue. Any suggestions are=
 =20
> > appreciated.
> >=20
> > Is ADDR_DIR in SPI_CONFIG_A set to the correct value to match how
> > the regmap is configured for bulk writes?
> >=20
> > I had to set this bit for AD4695 which has a similar register map
> > (although on that one I used two regmaps, an 8-bit one and a 16-bit
> > one, instead of doing bulk operations on the 8-bit one).
> >  =20
> Thanks for the input! I tried your suggested approach: set the ADDR_DIR
> to 1 during probe. Unfortunately, this did not fix the issue. I am still =
not able
> to perform bulk writes properly to the device.
>=20
> For now I will keep the only working version in v2, since there will be
> most probably  other iterations of the this patch series =F0=9F=98=8A.
I'd definitely like to know what is going on here if you can dig into it.
But if we really get stuck then the code at least needs a comment saying
it is necessary and we aren't sure why.  If we know why and can't change
it then the comment should give that reasoning.

Jonathan

>=20
> > > =20
> > >>> =20
> > >>>>> so I am not sure how the bulk functions fit. On this matter, we w=
ill need
> > >>>>> unsigned int (not u8) to store the values read via regmap_read, a=
nd in =20
> > this =20
> > >>>>> case we will need extra casts and assignments to use get_unaligne=
d. =20
> > >>>>
> > >>>> --
> > >>>> With Best Regards,
> > >>>> Andy Shevchenko
> > >>>> =20
> > >>> =20
> > > =20
>=20


