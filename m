Return-Path: <linux-pwm+bounces-3602-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F2599A3C2
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 14:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3FB0287CAD
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 12:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42293213EEB;
	Fri, 11 Oct 2024 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UURG80Ci"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E24A802;
	Fri, 11 Oct 2024 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649222; cv=none; b=iIZojGLDsqzBgQK/q8Fsrdoctmma5Ylm3suVAWtZAyPLwOjgqiqagLuOA0WF7JOkx48ZHhjr4WpVKwMsD/PYxVJTSMrYm0pU5tB872P0zE71pTGun9iYkqdE9bvvZOlvj73lseLc98WUkVjiDrh+NTcYqptuDU6PHUmbHIp3YOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649222; c=relaxed/simple;
	bh=FSVcya7AJzmLP8fH5k5lDNVInzXYZ9khIORtUZZH74I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UwEgsWGLCd8r/KK5+EZyFWeqKTfO77VrEUgN+daurbR0VgoJo1DfOZDnl+phWCbr6Y10cDl0KyKiM7EHBYd+cmCGxhuxxhFrMz5APodRWqPjIExMDK4b4M6iuHoqXlme60M8fFsxCCQwPa6s33eH/POiKMhbWRH6aoTez4eY6uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UURG80Ci; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9968114422so281885066b.2;
        Fri, 11 Oct 2024 05:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728649218; x=1729254018; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jlz12XyotTNNntibanQHl5R2spdT9YwbfoEX8IEOgkY=;
        b=UURG80CiOhj39W0FPiR/tvBN5BBf/c3yQkgF1zIIutkpOCCSXX2rhb88hUtj2K+UOa
         T3EEZ0PfhIhRh4UDHPyB08g9sWTa9iN/9OirML5QR1KNdD7b9fcauV+oVu69amlIuBa2
         ywEdL+AZY+8xj6nOsgqWhA6ZS9XuQsv7hKYYkfpmU+hnwfJeK43kBYB0KPb0LRn00ERv
         m4EbOVM5HRmRlaHn2l8WvjwaDgbvMRoHoWNaHx2BzTYPE5JsaGa9R2H038N8fsd+NJ4o
         bbOQB7BdRho5yUvn7RIDdxzQvQ1r1uUhE9ZSTArmPotBvJ5J2RxtKbrth1uHIXpsMb7X
         92RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728649218; x=1729254018;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jlz12XyotTNNntibanQHl5R2spdT9YwbfoEX8IEOgkY=;
        b=R7wyUls78m5XBxoyESpTFYSt+5u9s2Q4rD85MDK2xPDaJ9F6pFo/UBtCSqWQ2f0C8L
         3O+YnnAYtew/Xadb15RFeql4f2s8sVuzbgEwBxvCXO28djQz5B7lJAZEFfCC8vkRJ6ya
         V7BRkppriExHqnZzK/o2MbAApzvEZmDSCHUQMwi0SYLTIEhonEnskAbepBNb0UsDqeH5
         aY5MySfirt+4phphH3eo4lnUPJ3iCrqirNrcA8SlTVQL4uV6t/JUbFuMQ0MzIO+KGJal
         PRdK+txzs75Etxlc5iuTk24A45t7aGr69pZtRmjARMFyNa24cTAVv/ZjLhq5G34G6Hek
         WA2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtyVHhTI8iDdeAKo0uCo3jFJwx/ge9PA+ZPLEboANHf2k5ypxwIWs1KkNDyiHq/UPC2ARH9JjX7vMR@vger.kernel.org, AJvYcCV5tMq3+nej7eLvxpeRtPB1r66x591YJqHIy6ShJ4GWGh2fCir5p/9q0lalpOrL7t/e7lTSWU8Y7AODtw6v@vger.kernel.org, AJvYcCW6c2+7dtozRtalqCI+Yryaq8i9z54StKG7WE5w+OdLt3egFFyoVGEsres14mH/pTX8hxFU6KqZJEnV@vger.kernel.org, AJvYcCXI4EIYntJdTz0x7vsMNF0L1a+9ot9fIk823gB1KlvcWUvYVbm1j6Z3s+J+Wu392cXJ3fwTVYoDSXzP@vger.kernel.org
X-Gm-Message-State: AOJu0YyeRWdtLX5WaZ0iIYUudQzuc2J9FSoFvf5ehzTezpovtJfDtCpJ
	4u0thlYtlfjvqO4ijRJzPOh8a0XZ27QSnj0wHXQhURErr2iUvgR5
X-Google-Smtp-Source: AGHT+IGhTynSDPKMzHVc1xr4jVsPbryff/kx9+zBubOf6lnVucB5ML8xrhIU7Q6n8RWO/kmDj3GvQg==
X-Received: by 2002:a17:907:9806:b0:a99:497f:317 with SMTP id a640c23a62f3a-a99b95fb02bmr173285866b.62.1728649217375;
        Fri, 11 Oct 2024 05:20:17 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80c022dsm206038466b.126.2024.10.11.05.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 05:20:17 -0700 (PDT)
Message-ID: <e1979dbb5d79d18f84b6395d307a13734e7949b1.camel@gmail.com>
Subject: Re: [PATCH v2 7/7] Documentation: ABI: testing: ad485x: add ABI docs
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Antoniu Miclaus
	 <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>,  Olivier Moysan <olivier.moysan@foss.st.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Marcelo Schmitt	
 <marcelo.schmitt@analog.com>, AngeloGioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>, Mike Looijmans	
 <mike.looijmans@topic.nl>, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
 =?ISO-8859-1?Q?Jo=E3o?= Paulo =?ISO-8859-1?Q?Gon=E7alves?=	
 <joao.goncalves@toradex.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
  Sergiu Cuciurean <sergiu.cuciurean@analog.com>, Dragos Bogdan
 <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Date: Fri, 11 Oct 2024 14:24:32 +0200
In-Reply-To: <20241005183629.6a9cd4da@jic23-huawei>
References: <20241004140922.233939-1-antoniu.miclaus@analog.com>
		<20241004140922.233939-7-antoniu.miclaus@analog.com>
	 <20241005183629.6a9cd4da@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-10-05 at 18:36 +0100, Jonathan Cameron wrote:
> On Fri, 4 Oct 2024 17:07:56 +0300
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > Add documentation for the packet size.
> >=20
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> > changes in v2:
> > =C2=A0- improve description for packet_format
> > =C2=A0- add kernel version
> > =C2=A0.../ABI/testing/sysfs-bus-iio-adc-ad485x=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++++++++++++++
> > =C2=A01 file changed, 16 insertions(+)
> > =C2=A0create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad=
485x
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x
> > b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x
> > new file mode 100644
> > index 000000000000..5d69a8d30383
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x
> > @@ -0,0 +1,16 @@
> > +What:		/sys/bus/iio/devices/iio:deviceX/packet_format_available
> > +KernelVersion:	6.13
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Packet sizes on the CMOS or LVDS conversion data output
> > bus.
> > +		Reading this returns the valid values that can be written
> > to the
> > +		packet_format.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/packet_format
> > +KernelVersion:	6.13
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		This attribute configures the frame size on conversion data
> > +		output bus. See packet_format_available for available sizes
> > +		based on the device used.
> > +		Reading returns the actual size used.
> This needs to give some guidance to the user on 'why' they might pick a
> particular
> format.
>=20
> I'm also inclined to suggest that for now we pick a sensible default depe=
ndent
> on the other options enabled (oversampling etc) and don't expose it to th=
e
> user.=20
>=20

Just for documentations and if someone does not want to check the datasheet=
 :):

- Nonoversampling Packet Formats:

			  -------------------
20bit (packet_size =3D 0) - |20 bit conversion|
			  -------------------

                          -------------------------------------------
24bit (packet_size =3D 1) - |20 bit conversion| OR/UR | 3 bit chan_id |
			  -------------------------------------------

                          -------------------------------------------------=
-------------------
32bit (packet_size =3D 2) - |20 bit conversion| OR/UR | 3 bit chan_id | 4 b=
it softspan | 0s... |
			  --------------------------------------------------------------------

- Oversampling Packet Formats

			  -------------------
20bit (packet_size =3D 0) - |20 bit conversion|
			  -------------------

                          --------------------
24bit (packet_size =3D 1) - |24 bit conversion |
			  --------------------

                          -------------------------------------------------=
-----------
32bit (packet_size =3D 2) - |24 bit conversion| OR/UR | 3 bit chan_id | 4 b=
it softspan |
			  ------------------------------------------------------------

> Eventually it looks like we may have to figure out a solution to describe
> metadata packed alongside the channel readings but that may take a while
> and I don't want to stall this driver on that discussion.
>=20

There's something still not fully clear to me. So, oversampling would be ea=
sy to
deal with (for arguing about some packet size). OR/UR is the more tricky ca=
se
because of having metadata. But I'm trying to understand on how it could lo=
ok
because we still need a way to enable/disable OR/UR.=C2=A0

Do you have in mind to have a form of metadata description in 'struct
iio_scan_types' plus additional IIO_METADATA channels to enable/disable tho=
se
bits? For this usecase and as OR/UR actually depends on the packet format w=
e
could flip things with something like in_metadataX_enable and then argue ab=
out
the packet size settings.

But things get messier if we look closer to the packets as we can see that =
for
non oversampled samples, the softspan info is optional. Now, I'm not convin=
ced
about that information being useful in the sample as we already have the sc=
ale
attribute and I'm not expecting people to change it during buffering... But=
 for
the fun of things, how could we handle it if we cared (or if we actually ca=
re)
about it? Custom ABI like in_metadataX_scan_enable?

Other thing that came to mind and that might be a sneaky way of bypassing t=
he
metadata stuff (for now) is to use events. AFAIU, we have status registers =
were
we can check the OR/UR and push those as normal events. But we would need t=
o
rely on an external trigger as hrtimer or something like that. So we could =
have
this "slowpath" for checking the channel status but still use the events AB=
I
(and this is the sneaky part) to argue about the packet_size and whether or=
 not
that info will be available in the sample through DMA. Not sure if it's wor=
th it
though...

- Nuno S=C3=A1

