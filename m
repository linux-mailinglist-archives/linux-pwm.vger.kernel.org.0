Return-Path: <linux-pwm+bounces-3541-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5849953DC
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 17:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A451C24CB1
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 15:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433E61E0B6B;
	Tue,  8 Oct 2024 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4w6GQXm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F843BBDE;
	Tue,  8 Oct 2024 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403112; cv=none; b=EMOxFzSp6lXudh2yc2SKbqoBGZc5U+x490ccXmBJ5kLAexEkHAOci0PSLcVOHj+tXX6/qgZr/RmXQTiLeBK32JbT1JzFmuJZn+GCuCqj378SdH04bJ29XncNG+Rb/JxUrciGmncHOprATczTLsQOLNlDAEqfGDj6VhWlz0MAr3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403112; c=relaxed/simple;
	bh=sH9uiodf3ll2ygxxP7Uj09Z2x3LWwCP4UOOpOfGJp0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxDHGrPKv9J1CrjpWGNquMwbScQdlP3IjytuaUktWKDy449RMuxtNmdThkIhExrWvdHioZqNv4kjd4QGx5WRQWHSO1INhGo72dlyOtD21Ir/0D+d5yA8vYFRF9BrfBArkVsjyzRGIJ/KquH7MjvpI/69zO5YIZDrnL92ZW7CUaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4w6GQXm; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c91756c9easo709469a12.1;
        Tue, 08 Oct 2024 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728403109; x=1729007909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+uw/9yJm4aXKyo0vT8ZtVF91J7VK8zigHeeYkTtdjg=;
        b=Y4w6GQXm9AZVZUqhfKfdvCx8kX8bBihrJ7I6xs78NcjNuRen0poGXjYXQCLyD3IeDF
         hns6B/UkH096+HbhbJhkoIPwRqGN39uf3jHoNe+nn8EDj0womoBMBviF++rvkWP5OjnP
         psBHwSLrtSqJ7JOaH0c03acmWsuyiUpPC6/eBWRP88UA4xUQ1TQka0zoVATvc3y1Vlzn
         p9GnZfp90+6HiivKZ9RolUAabF29zzWIgofzpByNLq2s7QqhBm4tfVKCaRpZFnHcHSAo
         RD6ruKTUT1yif7Ucs/QKrGTiSKHOcjN+ehEH+w58Au+sMjPf2QOn8XQCCF82+nroaueH
         WIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728403109; x=1729007909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+uw/9yJm4aXKyo0vT8ZtVF91J7VK8zigHeeYkTtdjg=;
        b=rBVCKCfKEhzZXG5DMqg/M7oVab2dc0g/mkMxbsgH/wtnrhG4ujqJ8rtdppkvmG3R2f
         wzqDup82+QlaO2T8F3hNCz7m2sLOdHixNXYPRCS93oVrvWY5CoPCVuf7+JPbliMXSEsF
         S/gmqG9B0LPcwo7jg2puaxdtLr9POqG3Paxx2LrpQdjn+GsPF3mM2qZiQVReyWMYniyw
         uK6WuASPCUUWZBe/z55EOHIshP2bb/amHXxAS9fibnpVD7ZFywAUdoEiotW/q9H2qYmr
         xGLTn/+AvdPsLLHR/S3qSsP196xoNje+7F32kC1tMxPjOlG/NfEP7nrYowbPxZ9YI0yz
         KnQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf8jjgMmbtB40GBdOKCsDgpqoO5ncL9/LRh+5M87Mho5rvLmk20WUr4VS4INfu0wnVSx7RgqnA1vGj@vger.kernel.org, AJvYcCWeZjLXERIzqFRdy0GA28Bz4jzPCYPcfja6QI7loSlDVZ22jsZtbvFj6/d4qqY5ZFP4Pisg9OlMRroE@vger.kernel.org, AJvYcCXHfUtX/vRiyGXFEuPUAA91YlVffunblo2qVMBkJr6xi+1YkuDc1xgnFcKZvfYsbZgRroA+OwvkiRYRUkjP@vger.kernel.org, AJvYcCXOlUdmQidIeqTi8VF9kbI6FmvfEtp5nyWFJVMmUL9QoIdsAHwswiADI2mzwqxScu8de4PZVEKD/GFm@vger.kernel.org
X-Gm-Message-State: AOJu0YxkKlbg2vOgMCpglW9ImUL3sFasETZZXm8Xme/avQKGHebb0b93
	sEJduHiKHNjkpIEcMiZyfWJeqJ0DdgjkXTb5EHMPTnk1UmV6MX3H0RY2bAXuQbUk+nGImsOnTar
	hTAScF6ysrj4JKqIdr93rckRYFT4=
X-Google-Smtp-Source: AGHT+IEDZdWn0JlY0pXoWm+tJIvgq3k9BEDE0G9kdqOh9K4OnrpODWUfV6F3Z1vfNrKVW9zKKQmQrPLQtr//VOzh/vU=
X-Received: by 2002:a17:907:2d8c:b0:a93:a664:a23f with SMTP id
 a640c23a62f3a-a998465ced7mr81958966b.5.1728403108689; Tue, 08 Oct 2024
 08:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004140922.233939-1-antoniu.miclaus@analog.com>
 <20241004140922.233939-6-antoniu.miclaus@analog.com> <CAHp75VeaYBGTA7sN7SefsyMj09kaJLBoMz4=hf0GpxiXtF65+Q@mail.gmail.com>
 <CY4PR03MB33992F19FF780FF86234426A9B7E2@CY4PR03MB3399.namprd03.prod.outlook.com>
In-Reply-To: <CY4PR03MB33992F19FF780FF86234426A9B7E2@CY4PR03MB3399.namprd03.prod.outlook.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 8 Oct 2024 18:57:47 +0300
Message-ID: <CAHp75VdPcLE6Dgi=itocv+JSjh+3ZiF2xQ6wOp8ZiT+miekmcg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] iio: adc: ad485x: add ad485x driver
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	"Hennerich, Michael" <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Sa, Nuno" <Nuno.Sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	"Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>, Mike Looijmans <mike.looijmans@topic.nl>, 
	Marius Cristea <marius.cristea@microchip.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alisa-Dariana Roman <alisadariana@gmail.com>, Ivan Mikhaylov <fr0st61te@gmail.com>, 
	"Cuciurean, Sergiu" <Sergiu.Cuciurean@analog.com>, "Bogdan, Dragos" <Dragos.Bogdan@analog.com>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 1:48=E2=80=AFPM Miclaus, Antoniu
<Antoniu.Miclaus@analog.com> wrote:

...

> > > +       int gain;
> >
> > Should be u8 gain[2] and...

I should have added "...independently of the use of bulk operations."

> As discussed in previous patch series, the bulk operations won't work for=
 these
> chips. The CS needs to be raised between each byte read/written.

And as it was put independently by two people, we should really know
the real issue on the wire with this. And if it's as described, try to
find an existing example in the kernel that uses a similar approach. I
think regmap SPI should have such a feature.

> Therefore using u8 gain[2]  here  and in other places will be just an ext=
ra populated
> array since  regmap_read requires `unsigned int` as input.

The problem here is open coded endianess conversion.

--=20
With Best Regards,
Andy Shevchenko

