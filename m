Return-Path: <linux-pwm+bounces-3569-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6B6996E4B
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 16:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C5D281497
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 14:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611E314A0AB;
	Wed,  9 Oct 2024 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1mjMCoJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66093BBEB;
	Wed,  9 Oct 2024 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484803; cv=none; b=nVIlDR3ZI3ajDeVxxephkIMEU0kHQ9aJrYJl/9xxsnsGWg30+09bh8lekKNF5d7lAS4tUAQS+kryUdmQd2QyW/Iu0DT/9j0SQBAcEJfJaMn/xUcHjCmZnaUojL8uZJ4UuMeqLM1h6Th/kOW0ghdWNeXSP6cpgpcDf85rAQ4OO0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484803; c=relaxed/simple;
	bh=WIxVQAkTWICRZjnmzg7/+ehtFeF1lYh/jn7EQ5extqY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZwWanaR3Er+wCZpqcRHxZO2XKfuiFlQYHbZ51rQ9rs7Uu+ct/kT0rtY4xZFvjjyeAxs4j+bV+lx3e5zhYMAQlM1SuMPOuwqGqTgupXeWj1joiQ90j4/3ACKM2qkV8wEFjGcQQgX9hZr243jMxx6DPMLBZyReQ2rVKJ75CvGdrBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1mjMCoJ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9943897c07so609913766b.3;
        Wed, 09 Oct 2024 07:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728484800; x=1729089600; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fQH4Rjgx8wyc4kWG1BHXE6ckcwQoBaKiq9RmNTLAvtQ=;
        b=Z1mjMCoJEOh00FmiAQvJgxQDC3okeyhKdytIMP3GJBqZXQ6Jad1fM/Mxs42tWdR1mz
         s7J5bM7/72JZGDioxnz94K2D4VFGvz1OaH8uNqMIO/oW7zuxGa+hm2xaSy/J1UEl9S9n
         6vsHQOS/aYxftUWONwbpnK/2SpzbN4gBghgZhZrXft6cEjbN8uUcfLb6Fz97Bfn6b/zg
         MoZqD/DsxuUMbns/6dr8MNoTbhrXJa4TUwA34U8ptDUwEObrLcTPYlOFaII/sOkcshG+
         bgu+anzcPWQMqr+InHWNfrg70yKBY4XC+3Thdh5UaNcciFUcfapWP5pYwF4DJ6sinG+Q
         PilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728484800; x=1729089600;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQH4Rjgx8wyc4kWG1BHXE6ckcwQoBaKiq9RmNTLAvtQ=;
        b=tctQWVQLVRK97Qm8hz5hhyOYocmjFx9MP4QE/eXtSwnnOWV9PcyYjDdNBXgRktHZRu
         nivLH+X5Tp2S61k4/wR/MhePvdUFH5XG7Yhczphh3VKOmygyfLQ0dbdyGWiDPBl4TBVk
         2KKTAxiiC5M9NaT+tL5inHsZhEYKubemEpeBdhjiCmYUMnfZd6xyAGJ0Ek0P5JrRS5SA
         Ro1yLfSRK72jjXACB5W0DVpkoX4QM0Dkp1ulVEIIJ0KqncAh1HtJSMvGElNep8MCQnBJ
         o93S9/7I4iwGc0h/GbIRPmJFSwUv06Q8RzasC5xIw/Pc+CQRUc0EkwZn2hzugB4V7Ia/
         9Z3A==
X-Forwarded-Encrypted: i=1; AJvYcCUZYnxZLevoA+O0Uq5+cGe6if2s699Oyzde2B5k46sLij3VnKw5nmiskltly59fylsA/YjhmJpAPjpk@vger.kernel.org, AJvYcCUd20exIu2I3r8LqPt7eY1dbiT9NTUmnAMwRxQbJrhhUy8sl67Nx/Q4f6Ywpqcd1KfaVbEwmyQgcvaoEzX2@vger.kernel.org, AJvYcCVrA3r3gl8O6FjAsb6lGIe7yqRBxj7g641eLcaSadvve7/RAU99IUUx29rmzUxmJ0m3kECXBWkbhuMYkCo=@vger.kernel.org, AJvYcCXZc1U0hR9cPbynGWSS0MrCZwcS3tgXugfjnajB8SJLhegivr1qoztDUviNYgFHufeaULOT11Rn1RhC@vger.kernel.org, AJvYcCXfMiEGZ3b6+lOhOXbW7cY0hbggSwe3rwZPdAvyUb4Y/ICkTcb2XtRiNfWIbpGfGOhuokaxd0Qqvksj@vger.kernel.org
X-Gm-Message-State: AOJu0YwRy/irq1d36ykPGtYSJYjXBeNrbcW1BKcyl4Hc8iLXCzDr8LbY
	ggKwaF/I6mHHvfqXDB0YbJXUS3uLqtJedcd05rTotPuyffLwMfet
X-Google-Smtp-Source: AGHT+IGf82so3ncJqcp1r2jhONc3QpN1q4ZExW5+Xw94byLu7PFFtYP9NN/erIT9QH3fFHdER/oNEQ==
X-Received: by 2002:a17:907:7d9f:b0:a99:8abf:3610 with SMTP id a640c23a62f3a-a998d197392mr214942866b.14.1728484799774;
        Wed, 09 Oct 2024 07:39:59 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994610bccdsm532582766b.1.2024.10.09.07.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 07:39:59 -0700 (PDT)
Message-ID: <facfe06f51a815f4ff5604aeacd8bd6ed0629be4.camel@gmail.com>
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
Date: Wed, 09 Oct 2024 16:39:58 +0200
In-Reply-To: <20241009-ad7606_add_iio_backend_support-v4-5-6971a8c0f1d5@baylibre.com>
References: 
	<20241009-ad7606_add_iio_backend_support-v4-0-6971a8c0f1d5@baylibre.com>
	 <20241009-ad7606_add_iio_backend_support-v4-5-6971a8c0f1d5@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 09:19 +0000, Guillaume Stols wrote:
> On the parallel version, the current implementation is only compatible
> with id tables and won't work with fw_nodes, this commit intends to fix
> it.
>=20
> Doing so required to declare ad7606_chip_info structures in the .h file
> so to make them accessible to all the driver files that can set a
> pointer to the corresponding chip as the driver data.
>=20
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
> =C2=A0drivers/iio/adc/ad7606.c=C2=A0=C2=A0=C2=A0=C2=A0 | 283 ++++++++++++=
++++++++++++-------------------
> =C2=A0drivers/iio/adc/ad7606.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 32 +++--
> =C2=A0drivers/iio/adc/ad7606_par.c |=C2=A0 30 +++--
> =C2=A0drivers/iio/adc/ad7606_spi.c |=C2=A0 96 +++++++++------
> =C2=A04 files changed, 254 insertions(+), 187 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 5b276d087ec3..dfbdea8c28ba 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -78,6 +78,155 @@ static const unsigned int ad7616_oversampling_avail[8=
] =3D {
>=20
...

> +const struct ad7606_chip_info ad7616_info =3D {
> +	.channels =3D ad7616_channels,
> +	.init_delay_ms =3D 15,
> +	.name =3D "ad7616",
> +	.num_channels =3D 17,
> +	.oversampling_avail =3D ad7616_oversampling_avail,
> +	.oversampling_num =3D ARRAY_SIZE(ad7616_oversampling_avail),
> +	.os_req_reset =3D true,
> +	.scale_setup_cb =3D ad7606_16bit_chan_scale_setup,
> +};
> +EXPORT_SYMBOL_NS_GPL(ad7616_info, IIO_AD7606);
>=20

Maybe my eyes are tricking me but I'm not seeing any MODULE_IMPORT_NS() in =
the
drivers?

- Nuno S=C3=A1



