Return-Path: <linux-pwm+bounces-4370-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9449F4AB6
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 13:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACB1189103B
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 12:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DB21F1309;
	Tue, 17 Dec 2024 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVaaqhuj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7348B1F03DF;
	Tue, 17 Dec 2024 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734437491; cv=none; b=AyOCCAFi0cs+MsmaQfDUpg1LQIvEvNZi8yIdh5TuRMzIs25RRc4sYQBcrFsZ6w6SLpVEN8kest9vro5YTNDMaQh7OSgV8P/yj+ES2d+QFXcSkOipLKNLH01ZeMz6oI80MihhekpgGl6qenN8+UI73xedU+7ey9SuaLUbK70a1UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734437491; c=relaxed/simple;
	bh=92hiuZoDJVVqkg6GS6ptwsHQDbEARb7eXo/A7Bik7VY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cenl0JhG63kNaVqBYFpknbhGqhs7av7JongZFJLmS7nHOYrA3x/Ks7n1HeKtCRHpEMWHRHpIp5GWebFTooaXdHabZaZfmI/t7c+pJKBqq5UPhiNLZr+DCHK+ccSU5a0AWpbi6w6ZlVb2RaEZnK4kB46GnxjrgEZvEa4mDTo2bec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVaaqhuj; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3ea065b79so265049a12.3;
        Tue, 17 Dec 2024 04:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734437487; x=1735042287; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rss0gcMEDxi1uFXZhs0hLyP66dPbA4O8zghIZurhz9U=;
        b=nVaaqhujmB572ehC86byoDYNTsTwfNujvtUCR6MQzITVJl84a7nkk3vw7DlsI2vGjb
         xfjxw8EDs0vPBlxTs8N9LTbM2w/lSL+f/WJO9NTCvR/HY6XPssCr0Emi9f3D3eYPzxjQ
         XydQ2rrc6Rh8JHjcIKczeREpY2RiRKQcJYXofvOp1/Usb6uJZDRi5It2DIr5+WOun48E
         SEATQlmdJplZRmIotx2546jlWLNB2S2/fJV+UMItkIrtXhIiNwwBR1yBVa5kUR67aNKo
         tj6PmswUSWftmT9s7p/rt85Aev2aZ8fhySLXZpe9w1GgllwPAOnluJ/L6DUatr0W1l3D
         cL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734437487; x=1735042287;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rss0gcMEDxi1uFXZhs0hLyP66dPbA4O8zghIZurhz9U=;
        b=dCWcs/5yiZm+TozMHaMNyGYP3eduNQKDZb0usYwzND6gCe4+6zNOcjllqqkEweq9JI
         enWL1wEjmUYtXblcbcDoBBUUCALBQknPCexWyhnP8JvxyIm84747w2fnByhmK+YFv8dQ
         6pGE98/GYU7iPOJdM8fxZLkHGqA5jMXVVCoYh1d3vfFPsNoV/Fgc0TrFbvXfihzl21lJ
         rtsgqQ5lux9YEA69I6J/rAsiMLoT6ws9GEq3mEwGrnCKQxqpJdZVUN3C5javEDyM31ws
         j0ArAz7hILc9b1v6artoSJUb0mxBu0Ob2fcmC+kW3mTnWx7cRI9wTkfWnglpYMsul4JU
         BYhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5Jq/Ap1/v2UE1cBD9ZFPqV3XTtQDGGk2RU8G5x1BHCSExpJ1YPII2YZ7bwT68GGXqhWnvNzfE7wtL@vger.kernel.org, AJvYcCWLCLE2+8pvCQjn5l7uCa9zLRATCotarlHEj81WsgS56RMYAhLx3Fzj5D8drTo3gTHgE07ICEGUTtYh@vger.kernel.org, AJvYcCWseJZ/Vz96VP2X2C9NKNn4AU1ZV13ZFnDyGo1iWTm8DWAqfQNdoC9LfrRkDNrYlAlzYkGHypAinkVvvcg0@vger.kernel.org, AJvYcCXMYofRTuqPaLIT9tga4WBi+TIEmshjlTP5tK0gMbTCcyF+RQmUO35P2mag9memP/1G/7E39PZkbwlY@vger.kernel.org, AJvYcCXMghi3Rm8pK0K6RDBKpJxBfl40vGV/dpXV+pLDOKius0H9vrrpeoRBm4g+H8HyvLN0AvxgRIpeJAKi@vger.kernel.org
X-Gm-Message-State: AOJu0YyyWwRYsbbv8idk3CmQrHjUP2hM28SIXw+qXIRVlEE3N/LDAIAO
	A2FfSGk1hZwfcnLOIxRoet44XwAzUqTkvrvf0SpmySYviIMkcJ5/
X-Gm-Gg: ASbGncs99RUUmGG9IssuBByKG5KG4PVsgXZUQGvuN+hsWKwa97FLXSO2je+Dx5vpM1K
	za58Imj1+0aNgGTSSIKIWIjy8dMruJb+XGFRQIgIDdmx1vP57edrV8Q849A1c3UJREx9xvHW4UX
	CyiY79q9cR0l3oNZK4SHqXllPyjntJnkl3xfxxxB32bUXDPOT6p95lbDXlkNSRaZmND5zlhpthZ
	NcwiCOC34N4jZuBkMX4w7URMJpCUsVydrVuVYJbaSZGHevT6++MlWbksAFqyUd76fRp5OTS4Lcw
	B65KNsNPfvO5+zkWtaxjK0FA6imPEOEc6jC23004LMQithD6SbAfooG1p4vo2hWIdshEgUH82by
	U8Y7DWr89J2Y6hQ==
X-Google-Smtp-Source: AGHT+IFkpZz/013bL7nBOw87XIZBCdkZbOacL9nal3qYFLpyP8kvn9P2VuvSyXQK2N2n2g9Cy3qrmA==
X-Received: by 2002:a17:906:7304:b0:aa6:94c0:f755 with SMTP id a640c23a62f3a-aab778c1eaemr1752086566b.1.1734437486483;
        Tue, 17 Dec 2024 04:11:26 -0800 (PST)
Received: from ?IPv6:2003:f6:ef10:f100:a045:a7a7:11d0:8676? (p200300f6ef10f100a045a7a711d08676.dip0.t-ipconnect.de. [2003:f6:ef10:f100:a045:a7a7:11d0:8676])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96359fdfsm439453166b.93.2024.12.17.04.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 04:11:26 -0800 (PST)
Message-ID: <f5ff7ac7016a10824062caf3cd2eccce05e3dc82.camel@gmail.com>
Subject: Re: [PATCH v6 16/17] iio: dac: ad5791: sort include directives
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, David Jander	 <david@protonic.nl>, Martin Sperl
 <kernel@martin.sperl.org>, 	linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, 	linux-pwm@vger.kernel.org
Date: Tue, 17 Dec 2024 13:15:57 +0100
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-16-88ee574d5d03@baylibre.com>
References: 
	<20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
	 <20241211-dlech-mainline-spi-engine-offload-2-v6-16-88ee574d5d03@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-12-11 at 14:54 -0600, David Lechner wrote:
> Sort includes alphabetically before we add more in a later patch.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

>=20
> v6 changes: new patch in v6
> ---
> =C2=A0drivers/iio/dac/ad5791.c | 16 ++++++++--------
> =C2=A01 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
> index
> 57374f78f6b885e1d4f2fb452ac0563b85fc222e..24462cb020e19e8e2c6faa13109ac04=
7cf42
> 3c37 100644
> --- a/drivers/iio/dac/ad5791.c
> +++ b/drivers/iio/dac/ad5791.c
> @@ -6,21 +6,21 @@
> =C2=A0 * Copyright 2011 Analog Devices Inc.
> =C2=A0 */
> =C2=A0
> -#include <linux/interrupt.h>
> -#include <linux/fs.h>
> -#include <linux/device.h>
> +#include <linux/bitops.h>
> =C2=A0#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/interrupt.h>
> =C2=A0#include <linux/kernel.h>
> -#include <linux/spi/spi.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> =C2=A0#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> =C2=A0#include <linux/sysfs.h>
> -#include <linux/regulator/consumer.h>
> -#include <linux/module.h>
> -#include <linux/bitops.h>
> =C2=A0
> +#include <linux/iio/dac/ad5791.h>
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0#include <linux/iio/sysfs.h>
> -#include <linux/iio/dac/ad5791.h>
> =C2=A0
> =C2=A0#define AD5791_DAC_MASK			GENMASK(19, 0)
> =C2=A0
>=20


