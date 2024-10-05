Return-Path: <linux-pwm+bounces-3496-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662DC9918D0
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 19:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AA61C2103E
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 17:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F17158D80;
	Sat,  5 Oct 2024 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltaew/mo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F971E489;
	Sat,  5 Oct 2024 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728149196; cv=none; b=ppk4PmRhBL066eEnMXOPwn4lycxkqDuGM8lDohfJFYQMfhFy2zifAG6/vsRb6OQXlDPLX8sdSofC7HOfigqDrFSDCibPeRZGVicSmNnQXGWurdUQ8xwMS67KxfwzImu45yHy3MGrSNiLFUhb9ZzpE/XfdD9QAv+T6eK9NjosUN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728149196; c=relaxed/simple;
	bh=2/dHtnHTj+SFCgQFOL82HRwYwubtz/lmbyuwAYLv5Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XiPV8Hkz9gKGPdX6btNa+vxt80kozmTzNKuuCMmuigQUA1jRhpdJcbZi4beN4POEg14RMOKkzeYtFnfobYA+nSw8Ae7+Zo+OfHL1gFf5GeqnnTRlNAuB4REBxIwZtoqILHjs/USz/ryp1folmUsA3ijIAa5fFZFFk6goISkqVz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltaew/mo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CE9C4CEC2;
	Sat,  5 Oct 2024 17:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728149196;
	bh=2/dHtnHTj+SFCgQFOL82HRwYwubtz/lmbyuwAYLv5Rk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ltaew/mopk2fDLDPtsI2MgAj0AcbDvH8mLV/RDKS4pAsJ8JZsvwSmoXldXOUUherL
	 KHrVp5cfP3Kuoy52ElFMpKM0pIerpkAThLFt3/j9OhYTcmONHJ24rVjIXj48P+Qti9
	 xxfR72KwdOGFDmI2qtBRVjYYrOXaSZd708X4FgsmdhyvD8eGGzhuMrR/CnjLly7tnN
	 JOFuIhywvpG60IsLENOnF4vOjDgNIom8fA3k6LxsIyHfeOQ2xSg+ZJyCXI5+ZVJTYB
	 d2dhS89MkuYcup1pWP2T4DZrkhQ2U1taltmGm6Wyj/XxCkNnxU5g+EWFE98Qh8nbzP
	 Zpwpgbk+2DOJQ==
Date: Sat, 5 Oct 2024 18:26:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen	 <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Olivier Moysan 
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
Message-ID: <20241005182608.2be20d3a@jic23-huawei>
In-Reply-To: <35944d57af0ed62124e1e7cea544ef357fad1659.camel@gmail.com>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
	<20240923101206.3753-7-antoniu.miclaus@analog.com>
	<CAMknhBHRfj7d8Uea8vX=t+y+9dqoPABQSzsgNhBMTK-8-f6L7w@mail.gmail.com>
	<20240928183044.0b5ea2e0@jic23-huawei>
	<35944d57af0ed62124e1e7cea544ef357fad1659.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Sep 2024 09:05:04 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sat, 2024-09-28 at 18:30 +0100, Jonathan Cameron wrote:
> >  =20
> > >  =20
> > > > +static struct iio_chan_spec_ext_info ad4858_ext_info[] =3D {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_ENUM("packet_format", IIO=
_SHARED_BY_ALL, &ad4858_packet_fmt),
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_ENUM_AVAILABLE("packet_fo=
rmat",
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 IIO_SHARED_BY_ALL, &ad4858_packet_fmt),
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {},
> > > > +};
> > > > +
> > > > +static struct iio_chan_spec_ext_info ad4857_ext_info[] =3D {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_ENUM("packet_format", IIO=
_SHARED_BY_ALL, &ad4857_packet_fmt),
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_ENUM_AVAILABLE("packet_fo=
rmat",
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 IIO_SHARED_BY_ALL, &ad4857_packet_fmt),
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {},
> > > > +};=C2=A0  =20
> > >=20
> > > Usually, something like this packet format would be automatically
> > > selected when buffered reads are enabled based on what other features
> > > it provides are needed, i.e only enable the status bits when events
> > > are enabled.
> > >=20
> > > (For those that didn't read the datasheet, the different packet
> > > formats basically enable extra status bits per sample. And in the case
> > > of oversampling, one of the formats also selects a reduced number of
> > > sample bits.)
> > >=20
> > > We have quite a few parts in the pipline right like this one that have
> > > per-sample status bits. In the past, these were generally handled with
> > > IIO events, but this doesn't really work for these high-speed backends
> > > since the data is being piped directly to DMA and we don't look at
> > > each sample in the ADC driver. So it would be worthwhile to try to
> > > find some general solution here for handling this sort of thing. =20
>=20
> I did not read the datasheet that extensively but here it goes my 2 cents
> (basically my internal feedback on this one):
>=20
> So this packet format thingy may be a very "funny" discussion if we reall=
y need
> to support it. I'm not sure how useful it is the 32 bits format rather th=
an
> being used in test pattern. I'm not seeing too much benefit on the channe=
l id or
> span id information (we can already get that info with other attributes).=
 The
> OR/UR is the one that could be more useful but is there someone using it?=
 Do we
> really need to have it close to the sample? If not, there's the status re=
gister
> and... Also, I think this can be implemented using IIO events (likely wha=
t we
> will be asked). So what comes to mind could be:

Definite preference for using events, but for a device doing DMA I'm not su=
re
how we can do that without requiring parsing all the data.

So we would need some metadata description to know it is there.

>=20
> For test_pattern (could be implemented as ext_info or an additional chann=
el I
> think - not for now I guess) we can easily look at our word side and dyna=
mically
> set the proper packet size. So, to me, this is effectively the only place=
 where
> 32bits would make sense (assuming we don't implement OR/UR for now).
> For oversampling we can have both 20/24 bit averaged data. But from the
> datasheet:
>=20
> "Oversampling is useful in applications requiring lower noise and higher =
dynamic
> range per output data-word, which the AD4858 supports with 24-bit output
> resolution and reduced average output data rates"
>=20
> So from the above it looks like it could make sense to default to 24bit p=
ackets
> if oversampling is enabled.

That sounds like what we do for the DMA oversampling cases that change
the resolutions.

>=20
> Now the question is OR/UR. If that is something we can support with event=
s, we
> could see when one of OR/UR is being requested to either enable 24 packet=
s (no
> oversampling) or 32 bit packets (oversampling on).
>=20
>=20
>=20
> >=20
> > We have previously talked about schemes to describe metadata
> > alongside channels. I guess maybe it's time to actually look at how
> > that works.=C2=A0 I'm not sure dynamic control of that metadata
> > is going to be easy to do though or if we even want to
> > (as opposed to always on or off for a particular device).
> >  =20
>=20
> Indeed this is something we have been discussing and the ability to have =
status
> alongside a buffered samples is starting to be requested more and more. S=
ome
> parts do have the status bit alongside the sample (meaning in the same re=
gister
> read) which means it basically goes with the sample as part of it's
> storage_bits. While not ideal, an application caring about those bits sti=
ll has
> access to the complete raw sample and can access them.=20

This has the advantage that if we come along later and define a metadata
in storage bits description it is backwards compatible.  We've been doing
this for years with some devices.

> It gets more complicated
> where the status (sometimes a per device status register) is located in a=
nother
> register. I guess we can have two case:
>=20
> 1) A device status which applies for all channels being sampled;
> 2) A per channel status (where the .metada approach could make sense).

If it's a separate register per channel and optional, we'd have to treat it=
 as a metadata
channel as no guarantee it would be packed next to the main channel.

If we have a description of metadata additions in main channel storage, I'm=
 not
against having a IIO_METADATA channel type.=20

If it's a single channel I'm not sure how we'd make as channel description
general enough easily as we end up with every field possibly needed an asso=
ciation
with a different channel.

>=20
> But I'm not sure how we could define something like this other than assum=
ing
> that raw status data is being sent to userspace (given that every device =
has
> it's own custom status bits and quirks).
That is always fine.

Jonathan
>=20
> - Nuno S=C3=A1 =20


