Return-Path: <linux-pwm+bounces-3596-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0284199A12B
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 12:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A8828683F
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 10:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9F420FA8A;
	Fri, 11 Oct 2024 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQZ7E1d/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D28828EB;
	Fri, 11 Oct 2024 10:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641978; cv=none; b=IchuJ3UxUcbEh6gxKf2gd229VfCNaX+N9hSYEG9FJeEytweoO7dtTl82XWry9dQfGEcQ1zcN/grKEf9HZgys5IyX8cNjBffM9FFc/j9+PydiZopHvp1F3dZB/5KdZMd7ls2iz3g+2RjdZ7JE/JDHESBDgfsp1RSR1v/j1jPS+Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641978; c=relaxed/simple;
	bh=BzjUC2WdUuGsR2SFi0W1LmPuVrcKnpzELb0ehppyCaw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KToZfDC/S0o20iulkGFrnHj6+NQwqxKVP+TbwMOblDJGwILEC9ulhvrO3zQdGmROk9dgefdCA9vTdlpjIiOkyDnmRtKyR+Tq0F8apIgpVK1oiQyq/3R6RYs7wVaBI3M+5yGexg21Tgl+ny64RHd3HlB1UruEYwpxVl2Sp8Heyp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQZ7E1d/; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c920611a86so2454814a12.0;
        Fri, 11 Oct 2024 03:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728641975; x=1729246775; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BzjUC2WdUuGsR2SFi0W1LmPuVrcKnpzELb0ehppyCaw=;
        b=VQZ7E1d/ih8IHEaDfHpmVr9ud8+0f/ZFiKck6eY/FhnaXWpcjdoCrrA3QD3wgSpn1T
         sAJ34KPinyxozFO4cFZKWs4fIYzbw+cJpZKvN+hPe9/0qTGZiCF+/cWq2kDfXQ7BGkx/
         2jbH+mAxWrb6yUt5XyssjepvXCHhSECgUNX0DI9aL8+/a86KRv/sovL/MBnU+rDD+eT1
         scECyrakKmzftCVSeQJi7zA9TOcGb962h/QLeCPeRe4ogZeZ+K8ZffA48h1gFA18AS56
         DSWgPO5HtpP5GEQgzqmE8xX7ksnAvv7p89iV4rvGQdoYjPmNubC/vqpUcD/NaZZbg1hK
         628Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728641975; x=1729246775;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BzjUC2WdUuGsR2SFi0W1LmPuVrcKnpzELb0ehppyCaw=;
        b=j7MKCrn47Z5rYKX9yY5k2UHp9YkJkM/VTTP57aVJ3Rx8p3P5mySWMZ7/e3v4s4fkJL
         XUSYfpkKxLFecXU/hTJ5WQlf3uId990v90fBqaEOpJOROSAgHZce2yiZrrv7yYIJstZK
         UNnFZbNNDKEJBtBZmDFwwKk/ZAawOyArZ1YxMEXs9X05tMuBJeBTnJO4t0eE2MK69KCz
         jhphCzVbWT361yCL1z9wazkhxXxFaMZFIDshB/KsGmZW86aJTAxDrfilUzwB9KgX6eUA
         cBIR0TTr3HQ04sEbLGqVW/qSnDWHTTGKy8AVhxCWuKDfDpVbHUWiHmY+6ceM66j8CebB
         w00w==
X-Forwarded-Encrypted: i=1; AJvYcCUe2dQnSxyIIQJ9QAXUwjp5GZuS3lW9S3mpPxH2Jd8oiGQ+RvAVfKzjzfeaBoniFoN3J0hLDvtog8cN@vger.kernel.org, AJvYcCWVP2Wq0Iuti2n4Mec34eLDhCZ06qW7k1V2Dvm2eKONrAEm72T8EW72wqwCnqcxoSczjf0HVq4ARYe9d7t0@vger.kernel.org, AJvYcCXHp38gbmzHohEGM9VNdFBGgqgx7g+887P9xEypWApQYPFP751+hxCUXLOiUbtZDAABuFbpbOXBTW8s@vger.kernel.org, AJvYcCXUdB1bqmY7Faw+C27j9igrKHjzkFy0CtU6kJWsB2lRDxbVPs8h8KDBh86TNS7QH77GpIR8NTSdKFwZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7bfBZDSRj/3TgjH3hCz20GepFV6C7n+dx/Nogme9QqaQCzhs8
	GAq9gSHn5efp7zjOT8ea2sjl4P9D3Yw8bWj3h+aZ9Yh6CFPmExYM
X-Google-Smtp-Source: AGHT+IFmZh07eDuGU/glT9pd5yl9UegdvZu4wewUDe7IZyXiAbdOhObnRH6fhxBvbIRyNjDiLE18/w==
X-Received: by 2002:a05:6402:84c:b0:5c9:3451:498 with SMTP id 4fb4d7f45d1cf-5c948d4817dmr1368905a12.25.1728641974441;
        Fri, 11 Oct 2024 03:19:34 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c93729a8cfsm1757460a12.95.2024.10.11.03.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:19:34 -0700 (PDT)
Message-ID: <13800d4f04e1302488d357144b2e51e914951d67.camel@gmail.com>
Subject: Re: [PATCH 6/7] iio: adc: ad485x: add ad485x driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Antoniu Miclaus	
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa	 <nuno.sa@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=	
 <ukleinek@kernel.org>, Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt	
 <marcelo.schmitt@analog.com>, =?ISO-8859-1?Q?Jo=E3o?= Paulo
 =?ISO-8859-1?Q?Gon=E7alves?=	 <joao.goncalves@toradex.com>, Mike Looijmans
 <mike.looijmans@topic.nl>,  Dumitru Ceclan <mitrutzceclan@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alisa-Dariana Roman <alisadariana@gmail.com>, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, Dragos Bogdan	 <dragos.bogdan@analog.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-pwm@vger.kernel.org
Date: Fri, 11 Oct 2024 12:23:49 +0200
In-Reply-To: <20241005182608.2be20d3a@jic23-huawei>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
		<20240923101206.3753-7-antoniu.miclaus@analog.com>
		<CAMknhBHRfj7d8Uea8vX=t+y+9dqoPABQSzsgNhBMTK-8-f6L7w@mail.gmail.com>
		<20240928183044.0b5ea2e0@jic23-huawei>
		<35944d57af0ed62124e1e7cea544ef357fad1659.camel@gmail.com>
	 <20241005182608.2be20d3a@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-10-05 at 18:26 +0100, Jonathan Cameron wrote:
> On Mon, 30 Sep 2024 09:05:04 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Sat, 2024-09-28 at 18:30 +0100, Jonathan Cameron wrote:
> > > =C2=A0=20
> > > > =C2=A0=20
> > > > > +static struct iio_chan_spec_ext_info ad4858_ext_info[] =3D {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_ENUM("packet_format", I=
IO_SHARED_BY_ALL,
> > > > > &ad4858_packet_fmt),
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_ENUM_AVAILABLE("packet_=
format",
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 IIO_SHARED_BY_ALL, &ad4858_packet_fmt),
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {},
> > > > > +};
> > > > > +
> > > > > +static struct iio_chan_spec_ext_info ad4857_ext_info[] =3D {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_ENUM("packet_format", I=
IO_SHARED_BY_ALL,
> > > > > &ad4857_packet_fmt),
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_ENUM_AVAILABLE("packet_=
format",
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 IIO_SHARED_BY_ALL, &ad4857_packet_fmt),
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {},
> > > > > +};=C2=A0=C2=A0=C2=A0=20
> > > >=20
> > > > Usually, something like this packet format would be automatically
> > > > selected when buffered reads are enabled based on what other featur=
es
> > > > it provides are needed, i.e only enable the status bits when events
> > > > are enabled.
> > > >=20
> > > > (For those that didn't read the datasheet, the different packet
> > > > formats basically enable extra status bits per sample. And in the c=
ase
> > > > of oversampling, one of the formats also selects a reduced number o=
f
> > > > sample bits.)
> > > >=20
> > > > We have quite a few parts in the pipline right like this one that h=
ave
> > > > per-sample status bits. In the past, these were generally handled w=
ith
> > > > IIO events, but this doesn't really work for these high-speed backe=
nds
> > > > since the data is being piped directly to DMA and we don't look at
> > > > each sample in the ADC driver. So it would be worthwhile to try to
> > > > find some general solution here for handling this sort of thing.=C2=
=A0=20
> >=20
> > I did not read the datasheet that extensively but here it goes my 2 cen=
ts
> > (basically my internal feedback on this one):
> >=20
> > So this packet format thingy may be a very "funny" discussion if we rea=
lly
> > need
> > to support it. I'm not sure how useful it is the 32 bits format rather =
than
> > being used in test pattern. I'm not seeing too much benefit on the chan=
nel
> > id or
> > span id information (we can already get that info with other attributes=
).
> > The
> > OR/UR is the one that could be more useful but is there someone using i=
t? Do
> > we
> > really need to have it close to the sample? If not, there's the status
> > register
> > and... Also, I think this can be implemented using IIO events (likely w=
hat
> > we
> > will be asked). So what comes to mind could be:
>=20
> Definite preference for using events, but for a device doing DMA I'm not =
sure
> how we can do that without requiring parsing all the data.
>=20
> So we would need some metadata description to know it is there.
>=20
> >=20
> > For test_pattern (could be implemented as ext_info or an additional cha=
nnel
> > I
> > think - not for now I guess) we can easily look at our word side and
> > dynamically
> > set the proper packet size. So, to me, this is effectively the only pla=
ce
> > where
> > 32bits would make sense (assuming we don't implement OR/UR for now).
> > For oversampling we can have both 20/24 bit averaged data. But from the
> > datasheet:
> >=20
> > "Oversampling is useful in applications requiring lower noise and highe=
r
> > dynamic
> > range per output data-word, which the AD4858 supports with 24-bit outpu=
t
> > resolution and reduced average output data rates"
> >=20
> > So from the above it looks like it could make sense to default to 24bit
> > packets
> > if oversampling is enabled.
>=20
> That sounds like what we do for the DMA oversampling cases that change
> the resolutions.
>=20
> >=20
> > Now the question is OR/UR. If that is something we can support with eve=
nts,
> > we
> > could see when one of OR/UR is being requested to either enable 24 pack=
ets
> > (no
> > oversampling) or 32 bit packets (oversampling on).
> >=20
> >=20
> >=20
> > >=20
> > > We have previously talked about schemes to describe metadata
> > > alongside channels. I guess maybe it's time to actually look at how
> > > that works.=C2=A0 I'm not sure dynamic control of that metadata
> > > is going to be easy to do though or if we even want to
> > > (as opposed to always on or off for a particular device).
> > > =C2=A0=20
> >=20
> > Indeed this is something we have been discussing and the ability to hav=
e
> > status
> > alongside a buffered samples is starting to be requested more and more.=
 Some
> > parts do have the status bit alongside the sample (meaning in the same
> > register
> > read) which means it basically goes with the sample as part of it's
> > storage_bits. While not ideal, an application caring about those bits s=
till
> > has
> > access to the complete raw sample and can access them.=20
>=20
> This has the advantage that if we come along later and define a metadata
> in storage bits description it is backwards compatible.=C2=A0 We've been =
doing
> this for years with some devices.
>=20
> > It gets more complicated
> > where the status (sometimes a per device status register) is located in
> > another
> > register. I guess we can have two case:
> >=20
> > 1) A device status which applies for all channels being sampled;
> > 2) A per channel status (where the .metada approach could make sense).
>=20
> If it's a separate register per channel and optional, we'd have to treat =
it as
> a metadata
> channel as no guarantee it would be packed next to the main channel.
>=20
> If we have a description of metadata additions in main channel storage, I=
'm
> not
> against having a IIO_METADATA channel type.=20
>=20

I guess you mean that a complete solution would never only be a IIO_METADAT=
A but
also extending 'struct iio_scan_type'?

> If it's a single channel I'm not sure how we'd make as channel descriptio=
n
> general enough easily as we end up with every field possibly needed an
> association
> with a different channel.

Not sure I followed the above... You mean having a single channel (like one
register) pointing to different channels?=20

What I mean with 1) is for example what happens with IMUs (eg: adis16475). =
They
have a DIAG_STAT register (which is pretty much device wide status/error
information) that's also part of burst transfers (where we get our samples)=
 and
while some bits might not be meaningful for the sampling "session", others =
might
make sense to reason about data integrity or correctness.=20

For the above case, I think the IIO_METADATA channel type would fit.

- Nuno S=C3=A1

