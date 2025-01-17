Return-Path: <linux-pwm+bounces-4665-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB98A15414
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 17:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE421630F4
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6AB19ABB6;
	Fri, 17 Jan 2025 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQmJH+pt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAFC9443;
	Fri, 17 Jan 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737130803; cv=none; b=rnzXcKoHwdD/KT4mDY9JS97R63I0fvoRVWOZ0Q/pBxQPj00DUNP2Donc8Y4teSsr8inmT4aTjlMFISryW2fGhuv7e9vBkI430Hcs2coPAz4pEOjMIz/vEGEQfLPgXU9dmQJC80AAqJbytTaOau5TDQ7Zw0hPYg7me3t27dQEnGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737130803; c=relaxed/simple;
	bh=D1rAN0mkYim+aAuN/sww6LeSFhULo1gUOOmNtyNhWTU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tWNuE/9yJe7aj1JR8OPzLRlFn17A+rEQa/ETWW3E3Om7LS7J2o7tQDBOUm+AQKl1Te4+pfdrj6dmLsELsoQL0wwgzyjiz+kcg5x2PlNa9PIXVFsPs60MerLv77ELe+rkr7jJlU1322Hfl1W1Rl/fYxcPr/5Ul0Q7icu9r52Rv1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQmJH+pt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so1257262f8f.0;
        Fri, 17 Jan 2025 08:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737130800; x=1737735600; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLfMBtT/nLMoQ9qsyaJyfj0flnwCsw9iLqzQ/rxcKUY=;
        b=kQmJH+ptWQpelcst4KHkhpEGstj8IIwXBCWg696Z6G4SgH8ggvysQMEcC3POx70VuP
         9RI7mOtjD1862tovuQf65piMs0A7fanXoqhsb9RK4OUxzcOx58tB8x3eFBbfkGdABM+z
         BA2pv66U6KnIDoRvvxh1E+ILXTTFubIytD3B0mvTU/IeeLaWWcWkSPY70CzPznZTrUMU
         1/Afy8nBsVTiiD5EihcFnW5EzBRWCsSdYjrZCXw9+g6hHePEefxwgq12Eosub+Jn7vbF
         RXsnriWeX1HhAz5kEODunIgACKs1XImc/1uFFnFfFSg4Hejwd8WBjOzQ+FV94ETTGYnF
         Zwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737130800; x=1737735600;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jLfMBtT/nLMoQ9qsyaJyfj0flnwCsw9iLqzQ/rxcKUY=;
        b=ZFAz2JKUrGutpOGeUGiUtR1gIbHKkKoio8BFfwxp+RB7PayJseqFePZnipt79WMmfO
         Jr3yT9Rkyx3qnEVw+gmGSrpOWcOWPEiAz9skahemMI7Aph8pICMSpdiavPT3QGH1qQFa
         aUJ4NxGWy6AXs523addbmXSlCw2+c7tvAoXZL/bTgewlrIO57tctU26rU0pBpUfZZGDh
         Ic73owSbBJZlYuIKcYKQUvhGo1lS27IzVoZ70vrWepqJqOtMO9UU0ZChpTvy4cE5CI0j
         kLNYomD5tMJfmAJi9dZWQmqQNswB8e8/ifu1vz23+DH3MuukQWPubaK/SbJ0lWyBGqKX
         MP3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6SloXrRVf6QjV1riYfcXRUEUQAqmw+0oBIrJcA7qxD15aqDpc2o3Jgc/UJ4R2J/AfmfyWAf3He6ek@vger.kernel.org, AJvYcCVeUG/9uX+WtyHXqnbhqW0akXmTs2IfAm1h5Zk7Av1gvbwln8JlJd68/w+dRXwq4zW39EeJ/rPqWV6K@vger.kernel.org, AJvYcCXN/qSDEywS0PFUWHwgIjoCbN5j17TwQ8kxNo3J+q6qQoC2LPOIyrHi9Ny/LRfBpG305iAYr1oGKA+IzIJE@vger.kernel.org, AJvYcCXaH2iHGwaA1a7rZzFmwYKuZHq0Ku3Z1R0F4hafSxJzPc71BlqEj1rUY2R66IPBzhyYlHdJEwQXDPau@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc2J6C/WULcC8XTe7gB6BmUijFJDM5EpapAfJTFIv0FDoHIIwb
	pepwT7irb7QSZ+5jTOLeqJc4Afs9ngCSn06gyMEEy63m7GWO+hWy
X-Gm-Gg: ASbGncslxIUNB+7vjA2HDFD9OFMl4z14aYMreqeh3hXwOJhYvTEbl5iSS+0CnbeFSV+
	RzFCccc8FUCt08OyVz7Ahj2uM6ODiojI9NSjimeUcOIPzZoy8egtvihzNLiy0U7At/bXxgLZnj9
	/eDlVCIXHuN8jMvKSckTbbatvnnswsnHYhy8ZC/9k7NNYEvesPV/Q19wcx2X+bi9B6FpEpR2kQK
	ET/hTG0oaXFK+EQBh+bNoLn1lEDDK7LX8EFfmcD7PCrYHDmQwe0HpBG9iXEqlGDpoAmqSOlAXXC
	Y0SbhPZyObAPnn5aCXVWyAJInIkN
X-Google-Smtp-Source: AGHT+IH5bQ/6EdsPwAt0n8RK3vofgEVjomOUWYlaDH2nvojR0fIsSijo3n5ZPic9qk1DWEfoqg2VvQ==
X-Received: by 2002:a5d:47ac:0:b0:38b:e919:4053 with SMTP id ffacd0b85a97d-38bf57a993dmr3831145f8f.44.1737130800452;
        Fri, 17 Jan 2025 08:20:00 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3275562sm2932859f8f.66.2025.01.17.08.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 08:20:00 -0800 (PST)
Message-ID: <87a7f003f3b53c6b8fe762dbaa542111e57538fe.camel@gmail.com>
Subject: Re: [PATCH v10 5/8] iio: adc: adi-axi-adc: set data format
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Date: Fri, 17 Jan 2025 16:20:00 +0000
In-Reply-To: <20250117130702.22588-6-antoniu.miclaus@analog.com>
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
	 <20250117130702.22588-6-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-17 at 15:06 +0200, Antoniu Miclaus wrote:
> Add support for selecting the data format within the AXI ADC ip.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> no changes in v10.
> =C2=A0drivers/iio/adc/adi-axi-adc.c | 46 ++++++++++++++++++++++++++++++++=
+++
> =C2=A01 file changed, 46 insertions(+)
>=20
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.=
c
> index d2e1dc63775c..3c213ca5ff8e 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -45,6 +45,12 @@
> =C2=A0#define ADI_AXI_ADC_REG_CTRL			0x0044
> =C2=A0#define=C2=A0=C2=A0=C2=A0 ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
> =C2=A0
> +#define ADI_AXI_ADC_REG_CNTRL_3			0x004c
> +#define=C2=A0=C2=A0 AD485X_CNTRL_3_PACKET_FORMAT_MSK	GENMASK(1, 0)
> +#define=C2=A0=C2=A0 AD485X_PACKET_FORMAT_20BIT		0x0
> +#define=C2=A0=C2=A0 AD485X_PACKET_FORMAT_24BIT		0x1
> +#define=C2=A0=C2=A0 AD485X_PACKET_FORMAT_32BIT		0x2
> +
> =C2=A0#define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
> =C2=A0#define=C2=A0=C2=A0 ADI_AXI_ADC_DRP_LOCKED		BIT(17)
> =C2=A0
> @@ -312,6 +318,45 @@ static int axi_adc_interface_type_get(struct iio_bac=
kend
> *back,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static int axi_adc_data_size_set(struct iio_backend *back, unsigned int =
size)
> +{
> +	struct adi_axi_adc_state *st =3D iio_backend_get_priv(back);
> +	unsigned int val;
> +
> +	switch (size) {
> +	/*
> +	 * There are two different variants of the AXI AD485X IP block, a 16-
> bit
> +	 * and a 20-bit variant.
> +	 * The 0x0 value (AD485X_PACKET_FORMAT_20BIT) is corresponding also
> to
> +	 * the 16-bit variant of the IP block.
> +	 */
> +	case 16:
> +	case 20:
> +		val =3D AD485X_PACKET_FORMAT_20BIT;
> +		break;
> +	case 24:
> +		val =3D AD485X_PACKET_FORMAT_24BIT;
> +		break;
> +	/*
> +	 * The 0x2 (AD485X_PACKET_FORMAT_32BIT) corresponds only to the 20-
> bit
> +	 * variant of the IP block. Setting this value properly is ensured by
> +	 * the upper layers of the drivers calling the axi-adc functions.
> +	 * Also, for 16-bit IP block, the 0x2 (AD485X_PACKET_FORMAT_32BIT)
> +	 * value is handled as maximum size available which is 24-bit for
> this
> +	 * configuration.
> +	 */
> +	case 32:
> +		val =3D AD485X_PACKET_FORMAT_32BIT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
> +				=C2=A0 AD485X_CNTRL_3_PACKET_FORMAT_MSK,
> +				=C2=A0
> FIELD_PREP(AD485X_CNTRL_3_PACKET_FORMAT_MSK, val));
> +}
> +
> =C2=A0static struct iio_buffer *axi_adc_request_buffer(struct iio_backend=
 *back,
> =C2=A0						 struct iio_dev *indio_dev)
> =C2=A0{
> @@ -360,6 +405,7 @@ static const struct iio_backend_ops adi_axi_adc_ops =
=3D {
> =C2=A0	.test_pattern_set =3D axi_adc_test_pattern_set,
> =C2=A0	.chan_status =3D axi_adc_chan_status,
> =C2=A0	.interface_type_get =3D axi_adc_interface_type_get,
> +	.data_size_set =3D axi_adc_data_size_set,
> =C2=A0	.debugfs_reg_access =3D iio_backend_debugfs_ptr(axi_adc_reg_access=
),
> =C2=A0	.debugfs_print_chan_status =3D
> iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
> =C2=A0};


