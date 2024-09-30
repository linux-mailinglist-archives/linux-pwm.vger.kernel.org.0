Return-Path: <linux-pwm+bounces-3401-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C899989AE4
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Sep 2024 09:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53E11F21B71
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Sep 2024 07:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA8A3B192;
	Mon, 30 Sep 2024 07:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DT1b5XR9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4869429CE8;
	Mon, 30 Sep 2024 07:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727679656; cv=none; b=a3S57UVWklKbIdO3rOIVplRbrAgr+gUNrEqgbM1BFCQkJISPkoYmCTRenkcCoxyBa3BejUbpG1cJDf1b/Rb3otofkg04KHBU+RFS2+ouS9j/fL8N9ObPjdrkgim9M8aRhrZO4t85skwc6WtnjtGc+T0IXzM7nlBf1TfCoChlKSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727679656; c=relaxed/simple;
	bh=CZtDJUpV3Zlj/Gxot2w0D/1EE/JiWAoo8UUMcKsOETs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g5d7SV1O7Yq1EBFL0MIaBSa5Yx1/azSx+BD6D+qxWR9EIggbEp/9rXxF4uZbO+Ca6oBJoLABtL2NujWgClHp5MYEjgKI9ghsfjumhcOLWH5YvK2yD2xDEoxIfYWqfXo5X6IphM6tChxPu5JrZ/hNEoIBdBGPf1Mg8ZP3Wv/FtW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DT1b5XR9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso49776985e9.2;
        Mon, 30 Sep 2024 00:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727679652; x=1728284452; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CZtDJUpV3Zlj/Gxot2w0D/1EE/JiWAoo8UUMcKsOETs=;
        b=DT1b5XR9WMbtjZ/WfSVtsiI9dKiEH0/pz08QyfX7sDeJXxnxMmFF/CL8FSufW/vcHa
         ZOjsONkMkup5ovb2udpqFOG0q2aZ5jYKkGwp/VLnBRy2UQyuO4I0MvKNN/rMT3IxF8Pm
         k4ztEynWd61KK07dDwmyQ2g2GqYvvWpdGqtnbd3dqGc1/Rk5l1P8zL7nDCTMGeVroeRf
         U61K6RErIRh9oT6eA/TEmhDkR27g9jYGzClxNmQQBCtXgwBB3YZcExtrdj78A1isfN2J
         KikHGq+55hkfFYU4pcKTUSN4yra+ZHvX9apYwmhvqkrqo2U2vt1/qJUaDzhtP0quFMvM
         e4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727679652; x=1728284452;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZtDJUpV3Zlj/Gxot2w0D/1EE/JiWAoo8UUMcKsOETs=;
        b=XHYRfa0uIhSsuB2mHk6wKKTP03TK+vXhLzeH5Wdn8ru7fXjB52wv8IvlS8hnmmErN7
         KFWt/E/rQeW/UvZlZvRib42j7vbJB/L4EP2OKr2zpzJz6qjCbn1QThbzooa2g0qIqcpT
         ddQiY0oaCo/b4Q6GrfRiGc/qegGbGpSp2lI9Zo4MXjxpuUdRe2oS0A2YlALI3jsBnCNK
         Lqh88nVqPUI7uPbpHiCNbQcHVoi2xJnTPR40RQLcgBXq9u8UaqPg7Mt8V2LA++HlsZYK
         IrmqNWfchE9eyYM2oVpyDOw4xt6VLXnHNrcDSWp+9b/PoiK4lmu6jjInsK9OZzyuT0Rf
         W+HA==
X-Forwarded-Encrypted: i=1; AJvYcCVLGjMENqlED8wn4YnYJ339udZ3TqV+e1vIp828SQ6mXOWHJYFtCdK8/OjTurOc8hioz9klvTzutSBPgNKg@vger.kernel.org, AJvYcCVlWuhwvDWblblZhwluBoZsHGgI7rpyqpgWf41ACiNlIQDPGLbLSQehy3XXpuzB2J7LwHDsipdELAm9@vger.kernel.org, AJvYcCW6AhbwNEmbqb/Xi+1aDCIYSfPkAtiMV4inVA/KTNZVJQlnRVODzf7uZt0F141DERh91R0h6fjzGstB@vger.kernel.org, AJvYcCWzQPQ550uduU9kxtpPuAdq96SP24aCvX46yBAhW81jagbSQwXGXcvpdaCVartVLVgpQBsxCrU5CxBO@vger.kernel.org
X-Gm-Message-State: AOJu0YzFYOrFZZpseBRtryoj1kTHJ6MBGuAUdOHZxxa7Mx5eJlkd7hkb
	D8wUhgK7pjwAuLtW5O3mw5uKK4MUk5TpIga82TwzFJt41OZTi02p
X-Google-Smtp-Source: AGHT+IGPBSoC7SSSxJw5e1nyBbrWBM2ilTkscMj069g3k/+Z/G9YCUVLCocBeeSY1t4O10x8CUBIeA==
X-Received: by 2002:a05:600c:1c85:b0:42c:bd4d:e8ab with SMTP id 5b1f17b1804b1-42f584340f8mr122860235e9.10.1727679652271;
        Mon, 30 Sep 2024 00:00:52 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef02:2700:7684:3ff1:6790:3866? (p200300f6ef02270076843ff167903866.dip0.t-ipconnect.de. [2003:f6:ef02:2700:7684:3ff1:6790:3866])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57dec1c7sm94026255e9.27.2024.09.30.00.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 00:00:52 -0700 (PDT)
Message-ID: <35944d57af0ed62124e1e7cea544ef357fad1659.camel@gmail.com>
Subject: Re: [PATCH 6/7] iio: adc: ad485x: add ad485x driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Olivier Moysan
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
Date: Mon, 30 Sep 2024 09:05:04 +0200
In-Reply-To: <20240928183044.0b5ea2e0@jic23-huawei>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
		<20240923101206.3753-7-antoniu.miclaus@analog.com>
		<CAMknhBHRfj7d8Uea8vX=t+y+9dqoPABQSzsgNhBMTK-8-f6L7w@mail.gmail.com>
	 <20240928183044.0b5ea2e0@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-09-28 at 18:30 +0100, Jonathan Cameron wrote:
>=20
> >=20
> > > +static struct iio_chan_spec_ext_info ad4858_ext_info[] =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_ENUM("packet_format", IIO_S=
HARED_BY_ALL, &ad4858_packet_fmt),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_ENUM_AVAILABLE("packet_form=
at",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 IIO_SHARED_BY_ALL, &ad4858_packet_fmt),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {},
> > > +};
> > > +
> > > +static struct iio_chan_spec_ext_info ad4857_ext_info[] =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_ENUM("packet_format", IIO_S=
HARED_BY_ALL, &ad4857_packet_fmt),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_ENUM_AVAILABLE("packet_form=
at",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 IIO_SHARED_BY_ALL, &ad4857_packet_fmt),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {},
> > > +};=C2=A0=20
> >=20
> > Usually, something like this packet format would be automatically
> > selected when buffered reads are enabled based on what other features
> > it provides are needed, i.e only enable the status bits when events
> > are enabled.
> >=20
> > (For those that didn't read the datasheet, the different packet
> > formats basically enable extra status bits per sample. And in the case
> > of oversampling, one of the formats also selects a reduced number of
> > sample bits.)
> >=20
> > We have quite a few parts in the pipline right like this one that have
> > per-sample status bits. In the past, these were generally handled with
> > IIO events, but this doesn't really work for these high-speed backends
> > since the data is being piped directly to DMA and we don't look at
> > each sample in the ADC driver. So it would be worthwhile to try to
> > find some general solution here for handling this sort of thing.

I did not read the datasheet that extensively but here it goes my 2 cents
(basically my internal feedback on this one):

So this packet format thingy may be a very "funny" discussion if we really =
need
to support it. I'm not sure how useful it is the 32 bits format rather than
being used in test pattern. I'm not seeing too much benefit on the channel =
id or
span id information (we can already get that info with other attributes). T=
he
OR/UR is the one that could be more useful but is there someone using it? D=
o we
really need to have it close to the sample? If not, there's the status regi=
ster
and... Also, I think this can be implemented using IIO events (likely what =
we
will be asked). So what comes to mind could be:

For test_pattern (could be implemented as ext_info or an additional channel=
 I
think - not for now I guess) we can easily look at our word side and dynami=
cally
set the proper packet size. So, to me, this is effectively the only place w=
here
32bits would make sense (assuming we don't implement OR/UR for now).
For oversampling we can have both 20/24 bit averaged data. But from the
datasheet:

"Oversampling is useful in applications requiring lower noise and higher dy=
namic
range per output data-word, which the AD4858 supports with 24-bit output
resolution and reduced average output data rates"

So from the above it looks like it could make sense to default to 24bit pac=
kets
if oversampling is enabled.

Now the question is OR/UR. If that is something we can support with events,=
 we
could see when one of OR/UR is being requested to either enable 24 packets =
(no
oversampling) or 32 bit packets (oversampling on).



>=20
> We have previously talked about schemes to describe metadata
> alongside channels. I guess maybe it's time to actually look at how
> that works.=C2=A0 I'm not sure dynamic control of that metadata
> is going to be easy to do though or if we even want to
> (as opposed to always on or off for a particular device).
>=20

Indeed this is something we have been discussing and the ability to have st=
atus
alongside a buffered samples is starting to be requested more and more. Som=
e
parts do have the status bit alongside the sample (meaning in the same regi=
ster
read) which means it basically goes with the sample as part of it's
storage_bits. While not ideal, an application caring about those bits still=
 has
access to the complete raw sample and can access them. It gets more complic=
ated
where the status (sometimes a per device status register) is located in ano=
ther
register. I guess we can have two case:

1) A device status which applies for all channels being sampled;
2) A per channel status (where the .metada approach could make sense).

But I'm not sure how we could define something like this other than assumin=
g
that raw status data is being sent to userspace (given that every device ha=
s
it's own custom status bits and quirks).

- Nuno S=C3=A1 =20

