Return-Path: <linux-pwm+bounces-3613-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD9299B30D
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Oct 2024 12:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE051C2157B
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Oct 2024 10:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBA71531D2;
	Sat, 12 Oct 2024 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkKv+OVS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F21A13B58A;
	Sat, 12 Oct 2024 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728729083; cv=none; b=uyJUrKTbQQ46HZ1kbThHRMmYS3Cjr1uluslcMVDarKlU4DqVIelim4j8acQN4fMb/YwHYEDDW1pWkOjjvpE8W1D8eFi1bfIsInLxe1nGNfbyTapMciAYv2cbX7WUSPigSmj8wZo1UIf1DHKF9Gug/yNzoehl3ym6/S8gG7tQ/10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728729083; c=relaxed/simple;
	bh=smzZH4GgUaoNZk5BI4jkWg5/JcIDUWy67eVjqZiM9MU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRuZTPiB+t8x/ith9o9kShOkM75nd4GnajVWCdRBhue3CiHqAP+DZvENZdV4DdWXPJc9KPQ7g2skQrXHYTLu9NQotcxIkh5CwXXNOhgx59sPK45QamAqwtQbnS1uyQ8j6AxXCCahUYBATV9NFGqqzPnhhdo/a7pPB2ZimNReHAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkKv+OVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB1DC4CECE;
	Sat, 12 Oct 2024 10:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728729083;
	bh=smzZH4GgUaoNZk5BI4jkWg5/JcIDUWy67eVjqZiM9MU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YkKv+OVSA3tGjfiFOv6wVNhGVt2KZxF8nLCUucTH58jfj35PKuL9EQEIKnKU1LUs2
	 F6x6MWA8zDy/XEXtPGXSPPWs9Mbs1HvKsqsGCpoSxa3SnHpLZRLVcMEThFew4FasPb
	 njHb9FzIsnYYTHFNV2Lq8DDNPNxLE0seUk0WNndDZ0uQ+1Cu/DKgagjWGHHt+glFcw
	 ELKXGlgShLEwSFrm88wddnjmliUhNSXEzr7zED3zOBF1nrZX0MV+VZ3SSi7J4NVvFR
	 KrpHOel/TBeQlhmAUcEw0m8n5Iy124qKDAquDLLCBLP9U3jZzYZizl/rmI4mQw1qdU
	 bE5HqTk/CcfGw==
Date: Sat, 12 Oct 2024 11:31:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Antoniu Miclaus	
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa	 <nuno.sa@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=	
 <ukleinek@kernel.org>, Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt	
 <marcelo.schmitt@analog.com>, =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29u?=
 =?UTF-8?B?w6dhbHZlcw==?=	 <joao.goncalves@toradex.com>, Mike Looijmans
 <mike.looijmans@topic.nl>, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, Dragos Bogdan	 <dragos.bogdan@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 6/7] iio: adc: ad485x: add ad485x driver
Message-ID: <20241012113110.7fdd01c7@jic23-huawei>
In-Reply-To: <13800d4f04e1302488d357144b2e51e914951d67.camel@gmail.com>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
	<20240923101206.3753-7-antoniu.miclaus@analog.com>
	<CAMknhBHRfj7d8Uea8vX=t+y+9dqoPABQSzsgNhBMTK-8-f6L7w@mail.gmail.com>
	<20240928183044.0b5ea2e0@jic23-huawei>
	<35944d57af0ed62124e1e7cea544ef357fad1659.camel@gmail.com>
	<20241005182608.2be20d3a@jic23-huawei>
	<13800d4f04e1302488d357144b2e51e914951d67.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Oct 2024 12:23:49 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sat, 2024-10-05 at 18:26 +0100, Jonathan Cameron wrote:
> > On Mon, 30 Sep 2024 09:05:04 +0200
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >  =20
> > > On Sat, 2024-09-28 at 18:30 +0100, Jonathan Cameron wrote: =20
> > > > =C2=A0  =20
> > > > > =C2=A0  =20
> > > > > > +static struct iio_chan_spec_ext_info ad4858_ext_info[] =3D {
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_ENUM("packet_format",=
 IIO_SHARED_BY_ALL,
> > > > > > &ad4858_packet_fmt),
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_ENUM_AVAILABLE("packe=
t_format",
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 IIO_SHARED_BY_ALL, &ad4858_packet_fmt),
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {},
> > > > > > +};
> > > > > > +
> > > > > > +static struct iio_chan_spec_ext_info ad4857_ext_info[] =3D {
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_ENUM("packet_format",=
 IIO_SHARED_BY_ALL,
> > > > > > &ad4857_packet_fmt),
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_ENUM_AVAILABLE("packe=
t_format",
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 IIO_SHARED_BY_ALL, &ad4857_packet_fmt),
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {},
> > > > > > +};=C2=A0=C2=A0=C2=A0  =20
> > > > >=20
> > > > > Usually, something like this packet format would be automatically
> > > > > selected when buffered reads are enabled based on what other feat=
ures
> > > > > it provides are needed, i.e only enable the status bits when even=
ts
> > > > > are enabled.
> > > > >=20
> > > > > (For those that didn't read the datasheet, the different packet
> > > > > formats basically enable extra status bits per sample. And in the=
 case
> > > > > of oversampling, one of the formats also selects a reduced number=
 of
> > > > > sample bits.)
> > > > >=20
> > > > > We have quite a few parts in the pipline right like this one that=
 have
> > > > > per-sample status bits. In the past, these were generally handled=
 with
> > > > > IIO events, but this doesn't really work for these high-speed bac=
kends
> > > > > since the data is being piped directly to DMA and we don't look at
> > > > > each sample in the ADC driver. So it would be worthwhile to try to
> > > > > find some general solution here for handling this sort of thing.=
=C2=A0  =20
> > >=20
> > > I did not read the datasheet that extensively but here it goes my 2 c=
ents
> > > (basically my internal feedback on this one):
> > >=20
> > > So this packet format thingy may be a very "funny" discussion if we r=
eally
> > > need
> > > to support it. I'm not sure how useful it is the 32 bits format rathe=
r than
> > > being used in test pattern. I'm not seeing too much benefit on the ch=
annel
> > > id or
> > > span id information (we can already get that info with other attribut=
es).
> > > The
> > > OR/UR is the one that could be more useful but is there someone using=
 it? Do
> > > we
> > > really need to have it close to the sample? If not, there's the status
> > > register
> > > and... Also, I think this can be implemented using IIO events (likely=
 what
> > > we
> > > will be asked). So what comes to mind could be: =20
> >=20
> > Definite preference for using events, but for a device doing DMA I'm no=
t sure
> > how we can do that without requiring parsing all the data.
> >=20
> > So we would need some metadata description to know it is there.
> >  =20
> > >=20
> > > For test_pattern (could be implemented as ext_info or an additional c=
hannel
> > > I
> > > think - not for now I guess) we can easily look at our word side and
> > > dynamically
> > > set the proper packet size. So, to me, this is effectively the only p=
lace
> > > where
> > > 32bits would make sense (assuming we don't implement OR/UR for now).
> > > For oversampling we can have both 20/24 bit averaged data. But from t=
he
> > > datasheet:
> > >=20
> > > "Oversampling is useful in applications requiring lower noise and hig=
her
> > > dynamic
> > > range per output data-word, which the AD4858 supports with 24-bit out=
put
> > > resolution and reduced average output data rates"
> > >=20
> > > So from the above it looks like it could make sense to default to 24b=
it
> > > packets
> > > if oversampling is enabled. =20
> >=20
> > That sounds like what we do for the DMA oversampling cases that change
> > the resolutions.
> >  =20
> > >=20
> > > Now the question is OR/UR. If that is something we can support with e=
vents,
> > > we
> > > could see when one of OR/UR is being requested to either enable 24 pa=
ckets
> > > (no
> > > oversampling) or 32 bit packets (oversampling on).
> > >=20
> > >=20
> > >  =20
> > > >=20
> > > > We have previously talked about schemes to describe metadata
> > > > alongside channels. I guess maybe it's time to actually look at how
> > > > that works.=C2=A0 I'm not sure dynamic control of that metadata
> > > > is going to be easy to do though or if we even want to
> > > > (as opposed to always on or off for a particular device).
> > > > =C2=A0  =20
> > >=20
> > > Indeed this is something we have been discussing and the ability to h=
ave
> > > status
> > > alongside a buffered samples is starting to be requested more and mor=
e. Some
> > > parts do have the status bit alongside the sample (meaning in the same
> > > register
> > > read) which means it basically goes with the sample as part of it's
> > > storage_bits. While not ideal, an application caring about those bits=
 still
> > > has
> > > access to the complete raw sample and can access them.  =20
> >=20
> > This has the advantage that if we come along later and define a metadata
> > in storage bits description it is backwards compatible.=C2=A0 We've bee=
n doing
> > this for years with some devices.
> >  =20
> > > It gets more complicated
> > > where the status (sometimes a per device status register) is located =
in
> > > another
> > > register. I guess we can have two case:
> > >=20
> > > 1) A device status which applies for all channels being sampled;
> > > 2) A per channel status (where the .metada approach could make sense)=
. =20
> >=20
> > If it's a separate register per channel and optional, we'd have to trea=
t it as
> > a metadata
> > channel as no guarantee it would be packed next to the main channel.
> >=20
> > If we have a description of metadata additions in main channel storage,=
 I'm
> > not
> > against having a IIO_METADATA channel type.=20
> >  =20
>=20
> I guess you mean that a complete solution would never only be a IIO_METAD=
ATA but
> also extending 'struct iio_scan_type'?

Yes we needs a way to refer to an existing scan element then we could add a=
dditional
channels and refer into them as needed.

>=20
> > If it's a single channel I'm not sure how we'd make as channel descript=
ion
> > general enough easily as we end up with every field possibly needed an
> > association
> > with a different channel. =20
>=20
> Not sure I followed the above... You mean having a single channel (like o=
ne
> register) pointing to different channels?=20

Both way's around occur.  Multiple channels, some normal, some metadata some
separate pointing to a single storage location and per channel meta data
for different 'signals' shoved in one register.

>=20
> What I mean with 1) is for example what happens with IMUs (eg: adis16475)=
. They
> have a DIAG_STAT register (which is pretty much device wide status/error
> information) that's also part of burst transfers (where we get our sample=
s) and
> while some bits might not be meaningful for the sampling "session", other=
s might
> make sense to reason about data integrity or correctness.=20
>=20
> For the above case, I think the IIO_METADATA channel type would fit.
That one is easy. Fiddly case is where we have say overflow bits for
multiple signals (i.e. pins) in a single dmabuffer element.
To make that work cleanly we need a way to not only describe the contents
but cross reference it to the related data.

We've discussed ways to group actual channel (i.e. current and power on sam=
e pin)
in the past but doing this for metadata that is packed in multiple channels
is going to be a real pain.

Basically it all needs to be very flexible and any attempt to support a sub=
set
is likely to wall us into an inflexible ABI.

Jonathan

>=20
> - Nuno S=C3=A1


