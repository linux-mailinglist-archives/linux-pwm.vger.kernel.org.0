Return-Path: <linux-pwm+bounces-4672-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCCEA15D70
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jan 2025 15:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B50FF7A05A0
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jan 2025 14:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDBF190497;
	Sat, 18 Jan 2025 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyklqSAu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EB72B9A8;
	Sat, 18 Jan 2025 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737211631; cv=none; b=OJ1sLAlgNiRaQ84Is6M3cKIB5NzR/xICiqf9iiOCVwkcJU42nDKyr+Y2a83rotlIGMtSPQXh+nQlaHq2wTR0YsOzVH7ZzDownukxwjJW1ZKFFIOm9sS3KjzH3hIhciw+y5/HW1Gyv6ySh6QjY/gBjD8MCKC8V2vu9K82e4AnYvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737211631; c=relaxed/simple;
	bh=lCWLVqfo+jynjoP8cgLDSXMIC8FB0L7QDiH4vbbYbMw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cxpqe8rMSRb1hVXDl0EKuLWJb8M4f1FpkFFROsdXz0EG3pADmjUSUmT7+gX35/t1qgBmSLDdNPvYz/6bamltC5mkwBSFLj9HWo4umChVTGcAu8umT/6oViW7heiZ6HsF7Vx2WtpZWiiMzjtKd3ynp6J7besNKnVuQLdxi+dg2RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyklqSAu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so30022905e9.1;
        Sat, 18 Jan 2025 06:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737211628; x=1737816428; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mxyvXwUJTsmHG1vm1zQ1imkOlPMKalWalIPkmTdRhw=;
        b=ZyklqSAuT3AERTK4ZSzhvlv02W0NyIiAxHM26VGwHEA5c3WV2QR9Vp43hKcU6AxX+4
         184STdj89YIEBDZLz3PJItTUdDcHvKg9cF6N41+gSVyQOt/ys5IhS/ofSXAbYcMNuCM5
         ra2zjCaWNHC9mVt8cPON5MWmJ7UVsDnxOrJrK6AXOVWGMmvvFENZ48eCmdCTVNHCth9x
         8zPe6C8gX3DrplaS0OecxqYAkgWKEyPZVcrrXbZFxwQkCaBx3IwJwhcsAuLbM9zpHaT0
         gu5IamfMQxNoujl/pUmpjsPEMhhvx7ThWkPVc102n1Pfjwe9ExjYEWmEM8UHe1HccHQn
         8Xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737211628; x=1737816428;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9mxyvXwUJTsmHG1vm1zQ1imkOlPMKalWalIPkmTdRhw=;
        b=cOGlPYvmesp8Sw/Qm9/spSXCh2eAme/Kc31i3xyOR4o+++XItw6gdNaujK0xKkEvmQ
         72E6LSELro2qlfSLa4VwKuF4gmmyUnJvGyS3vGORS70ZaD18+NnAL1O8/BDSvvEwIPKc
         O9nxs+6V+vLE4N1hqzgRsW+Wfky48SsY5XuwpyS/PNhAUY/pm8eVPcM9n2tT/7lpe/JE
         tF/VoEe+f47WRmVwj70b/gZLg6ua+LhGn4tN47CfX7DPHqhqIhSzu/0M3ghb15dQNeX4
         PrffGswbNubgu4N59xCYMl8ftG3Z2nKzOCipSyJ69bTi/ikjNV84/3yT/cFR3v1RTvQk
         cfPA==
X-Forwarded-Encrypted: i=1; AJvYcCU2Muj53ArlFkp0avm9kF3p8+yjQur5nWx9Ij+Pvv3O7uorQ3y8fMHyO1zAZTipl94hLMytRS/aEDH6@vger.kernel.org, AJvYcCVhz0+8ImlgGXw5eZKp388E0Hgaxi2W+uF8XOxj0C0bBAk/8hHZCq75xLgnZLlkd1CoA5IIFlJxPhRZQNTi@vger.kernel.org, AJvYcCVzjumsfcQcXs1BGccAcjhnylDR5yydeB9atKbfVsllmGDHVW17kZpdvehk0sejDH/43LmP3xOFzILv@vger.kernel.org, AJvYcCXtj0pJuP9lNebP4BMdxkZevC6mx/jDxmb7uWQyfDThDpIfFvYRuCzGWsj0UstNQShnfMBiQ68XX9xO@vger.kernel.org
X-Gm-Message-State: AOJu0YzzLaan6/KVJ8XniRT7jIIsw916piLjWcyj5TrDnvWgvEb72moA
	qeBJBSQ1YUvuj7rBsl1BCAz5ekitHo37h0/ZQ609X8+YuqROGKAj6VUf1Y5CtT4=
X-Gm-Gg: ASbGncuvPLm0VfCfHYCNFUZgr6caEVeriE8qMElTX4UvKf5nJreLxfiZ5feQ5mJX6IA
	dXeSUjVE8b4/RZTESBsihK47XAsEo7D7xWl2kUAARAD4fmQskaKtGqXxkepiEUhIV6em4mzDODs
	XrwMAP0LAg/J93DZYP3oUBHf5Bxbb1Vb/PYkJfrLx9C6c2D32EbYx05WmpCOaFTm9nMvC/I0jpV
	cx+JJYXWTo5PiLko0fxoy/i6uL8Ow0Fl4MwXD3gG1Yw7CMhUhA+I5CGa0dHqLpa/iRDy/2MC6Cy
	TqtkpbKmlvdpg2/DjxMYRGl/7KLWYG920g6MeALLnA==
X-Google-Smtp-Source: AGHT+IFCNDujm3HvbgfRMnBs+wV5c38oBUsUrsHUk4AWlx/k51RWwH8TX4tI2X5fPwWsPHAiIu5uGw==
X-Received: by 2002:a05:600c:1f8f:b0:431:93d8:e1a1 with SMTP id 5b1f17b1804b1-43891430defmr55287405e9.27.1737211627565;
        Sat, 18 Jan 2025 06:47:07 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438904084e7sm70479315e9.6.2025.01.18.06.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 06:47:07 -0800 (PST)
Message-ID: <9c262f599fb9b42feac99cfb541723a0a6f50e6b.camel@gmail.com>
Subject: Re: [PATCH v10 5/8] iio: adc: adi-axi-adc: set data format
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, jic23@kernel.org, robh@kernel.org, 
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Date: Sat, 18 Jan 2025 14:47:17 +0000
In-Reply-To: <c7778b8d-abaa-47b7-834b-e62c30f6b8d9@baylibre.com>
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
	 <20250117130702.22588-6-antoniu.miclaus@analog.com>
	 <87a7f003f3b53c6b8fe762dbaa542111e57538fe.camel@gmail.com>
	 <c7778b8d-abaa-47b7-834b-e62c30f6b8d9@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-17 at 11:50 -0600, David Lechner wrote:
> On 1/17/25 10:20 AM, Nuno S=C3=A1 wrote:
> > On Fri, 2025-01-17 at 15:06 +0200, Antoniu Miclaus wrote:
> > > Add support for selecting the data format within the AXI ADC ip.
> > >=20
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > ---
> >=20
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> >=20
> > > no changes in v10.
> > > =C2=A0drivers/iio/adc/adi-axi-adc.c | 46 ++++++++++++++++++++++++++++=
+++++++
> > > =C2=A01 file changed, 46 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-=
adc.c
> > > index d2e1dc63775c..3c213ca5ff8e 100644
> > > --- a/drivers/iio/adc/adi-axi-adc.c
> > > +++ b/drivers/iio/adc/adi-axi-adc.c
> > > @@ -45,6 +45,12 @@
> > > =C2=A0#define ADI_AXI_ADC_REG_CTRL			0x0044
> > > =C2=A0#define=C2=A0=C2=A0=C2=A0 ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT=
(1)
> > > =C2=A0
> > > +#define ADI_AXI_ADC_REG_CNTRL_3			0x004c
> > > +#define=C2=A0=C2=A0 AD485X_CNTRL_3_PACKET_FORMAT_MSK	GENMASK(1, 0)
> > > +#define=C2=A0=C2=A0 AD485X_PACKET_FORMAT_20BIT		0x0
> > > +#define=C2=A0=C2=A0 AD485X_PACKET_FORMAT_24BIT		0x1
> > > +#define=C2=A0=C2=A0 AD485X_PACKET_FORMAT_32BIT		0x2
> > > +
> > > =C2=A0#define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
> > > =C2=A0#define=C2=A0=C2=A0 ADI_AXI_ADC_DRP_LOCKED		BIT(17)
> > > =C2=A0
> > > @@ -312,6 +318,45 @@ static int axi_adc_interface_type_get(struct iio=
_backend
> > > *back,
> > > =C2=A0	return 0;
> > > =C2=A0}
> > > =C2=A0
> > > +static int axi_adc_data_size_set(struct iio_backend *back, unsigned =
int size)
> > > +{
> > > +	struct adi_axi_adc_state *st =3D iio_backend_get_priv(back);
> > > +	unsigned int val;
> > > +
> > > +	switch (size) {
> > > +	/*
> > > +	 * There are two different variants of the AXI AD485X IP block, a 1=
6-
> > > bit
> > > +	 * and a 20-bit variant.
> > > +	 * The 0x0 value (AD485X_PACKET_FORMAT_20BIT) is corresponding also
> > > to
> > > +	 * the 16-bit variant of the IP block.
> > > +	 */
> > > +	case 16:
> > > +	case 20:
> > > +		val =3D AD485X_PACKET_FORMAT_20BIT;
> > > +		break;
> > > +	case 24:
> > > +		val =3D AD485X_PACKET_FORMAT_24BIT;
> > > +		break;
> > > +	/*
> > > +	 * The 0x2 (AD485X_PACKET_FORMAT_32BIT) corresponds only to the 20-
> > > bit
> > > +	 * variant of the IP block. Setting this value properly is ensured =
by
> > > +	 * the upper layers of the drivers calling the axi-adc functions.
> > > +	 * Also, for 16-bit IP block, the 0x2 (AD485X_PACKET_FORMAT_32BIT)
> > > +	 * value is handled as maximum size available which is 24-bit for
> > > this
> > > +	 * configuration.
> > > +	 */
> > > +	case 32:
> > > +		val =3D AD485X_PACKET_FORMAT_32BIT;
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
> > > +				=C2=A0 AD485X_CNTRL_3_PACKET_FORMAT_MSK,
> > > +				=C2=A0
> > > FIELD_PREP(AD485X_CNTRL_3_PACKET_FORMAT_MSK, val));
> > > +}
> > > +
> > > =C2=A0static struct iio_buffer *axi_adc_request_buffer(struct iio_bac=
kend *back,
> > > =C2=A0						 struct iio_dev *indio_dev)
> > > =C2=A0{
> > > @@ -360,6 +405,7 @@ static const struct iio_backend_ops adi_axi_adc_o=
ps =3D {
> > > =C2=A0	.test_pattern_set =3D axi_adc_test_pattern_set,
> > > =C2=A0	.chan_status =3D axi_adc_chan_status,
> > > =C2=A0	.interface_type_get =3D axi_adc_interface_type_get,
> > > +	.data_size_set =3D axi_adc_data_size_set,
> > > =C2=A0	.debugfs_reg_access =3D iio_backend_debugfs_ptr(axi_adc_reg_ac=
cess),
> > > =C2=A0	.debugfs_print_chan_status =3D
> > > iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
> > > =C2=A0};
> >=20
> >=20
>=20
> Since these register values are specific to the AD485X variant of the AXI=
 ADC,
> I still feel like it would be better if we added a new compatible string =
like
> we did for AD355X on the AXI DAC.
>=20

Yeah, my first intent was to avoid new compatibles on the backend side (as =
it can
grow pretty wildly). But obviously that if you have two different IPs with =
different
meanings for the same registers, there's nothing we can do. At some point, =
I thought
about havng the backend provide a set of custom registers and then each fro=
ntend
would now what to do with them. But different compatibles has the clear adv=
antage to
make differences between IPs clear and to actually control what a frontend =
can or
cannot do. Anyways, I hope that for simple enough cases we can "live" with =
the
generic compatible or asking HDL for more registers identifying/exposing ca=
pabilities
of the core.
> These functions accessing the CNTRL_3 register aren't applicable to the g=
eneric
> AXI ADC IP block, but only to the AXI AD485X IP core [1]. The AXI AD7606X=
 IP
> core [2] that we are working on also uses this same register for other pu=
rposes,
> so we will on have a conflict. We are planning on adding a new AXI ADC co=
mpatible
> string for AD7606X [3], so I think we should do the same here.

Given that we'll have another device messing with the same registers, I thi=
nk it's
clear we also need a new compatible here (so we are consistent at the very =
least).


- Nuno S=C3=A1

