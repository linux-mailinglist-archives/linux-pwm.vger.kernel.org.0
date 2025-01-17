Return-Path: <linux-pwm+bounces-4664-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC9AA15409
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 17:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195D41887DC7
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC1719ABB6;
	Fri, 17 Jan 2025 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaJ5IdBU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EE013AA20;
	Fri, 17 Jan 2025 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737130685; cv=none; b=q/yJ7z7gjaOcIoDpbxNJIt6fi335O/nfdikR98vG2XRhjCuN5pFonhVK4z93tOzQ00agbYQ5EXMOy1tcvhjOB2YI5EyEk3x55PnxxlpCzcliyn+NB5LoB8IXembqgLYJM9zoj8qORdyYgcXyugLGliCSUFPJCVqnnBVE1rpaB30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737130685; c=relaxed/simple;
	bh=VpGg7mdEaE2gAluu9Tg+pFCta5P2AqSjJzokmrFO3J8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y7/QbHJnFObNgn5zO3Km23q9dtEIF8Sn1Oa+alqOMyc3+oIdhAKBeYQKA4ZzyxsGxRudHYoP0gJurdYB/U/TmysuHgbsIYjUGhVoLUUcpOl517iV2BdRAonrGom8XsfP/9Qz2Xuq+LZ+L56d7vbMUy2HwNMj6MUs2tFAPxKRkZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaJ5IdBU; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38637614567so1147810f8f.3;
        Fri, 17 Jan 2025 08:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737130682; x=1737735482; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gIFsJHdPF6rt42wWLHJObPGhx4gPTRmFgMgBHF+H9u8=;
        b=QaJ5IdBUeElxclEONXHzYtkAMzE7i6gitmI2UAY5vsVJvk9ZqhYJ9bgTpukeFxfs6O
         dV1UF3GQQ13q1yoFU803IELNM1xIPIwTtQuFUf/pNFsE0eKaLkbOCwbm9rgs/yAGxkGC
         /eQXiynX1kkZBHFf5mqrXUsvv5KxxjOnoW69RDhvxhAefrEruPj/4jr8DfLYK5gI5lwe
         l6gMBIYZNwRt1WupdEWXmMgcWZRpUkRYdX+Elgubttyys/Sq82sIfgErTqH9rNsUGk0L
         4T3zsES6SOhoKApwXsRJndOQWa4TVIPFj6Qd0QoPt+h4URNbd+04J3zXw50tB8eEgTIZ
         /Jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737130682; x=1737735482;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gIFsJHdPF6rt42wWLHJObPGhx4gPTRmFgMgBHF+H9u8=;
        b=ia9oZz30LC7dYChthsu8g4UtMTHzv920h10ZyrFKaTfOlZ/CRp/PxMid71gtZC5O6G
         XFuFL87h7J4fPwowzqYlpKGMpMgl3IkTikChALT4cC+YyjtsHSfEyMzqMXk3E+wdCsE2
         LpS5E0Dfk+0TmEm8QY8JjqhEOKlDSrh45Gp17zP6OkHtX7Vd/mdZlaw4B2ZZjw9hPXKl
         NG/dCcVEI3ZSkBkfj7227Gstr1Hr4JuJjzZA/8PFgYlocZzMJC0/6MdrAM1q4V7Sl4rG
         3U/lCwWOO7jwVqYghC5idiPs+s0JgNpZe0tFcvH8R1WIjSuEuTaI3U2nETLOJiF/7Lj/
         YPhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVynUrrpA4dCOV6+k0ytVUiM9E2gpSOzK1EF3QT2Vz4q+uePcYeopO6v7UCBP+A0nRUowe5LkQTLh70MJkD@vger.kernel.org, AJvYcCWGqvNu4EceSJc9Aqy7P4NQBrJvaMnuOzLtgRtgMPcqJmwbzc9fmonhIpAzaaXSKSW61nbk9cDHUQh7@vger.kernel.org, AJvYcCXRGOZnqneTsW5R3Vg23loNKXyH7lw06GQ9YX9S7v3mxvgVIAO46/PbvX/S4ZAZlAbk1ROer/1ds4M1@vger.kernel.org, AJvYcCXcozcNVG6Poor13CUQJDiwF1iwnOo3aAemN/Zo8Fi+zsnnfkvt/rzth5oNgsjl3Fp1ErhOdMMicpzj@vger.kernel.org
X-Gm-Message-State: AOJu0YxfvE8pFjl3sFybg1BsRuA7n0tXoK5QcmdzPWpAtyNR2/NDtvRs
	o9t9cuJWZyhvNIiHL0YohiUMicPWuuu4HBAPIfA93v4BvKi9Nd1EeCLlh+FWhKo=
X-Gm-Gg: ASbGncugV2rMfM1CHKGDAuOBZ4O3vbQgzGn/QwD41zuJ3ltb/pC9as75pnXkJzRhj0C
	qMD/M0hKyV/NG59ZIwrXxqDkgl/ajlDkLgrYznDsBoXQkRQGa9neWTvxul//OW+aGqGmpcn+w10
	+QMwV3RXP213lqAodLtiNa4mNp23tQh9GCA2KXXJ87+MstmUIvnK5zb7haiRU8UHn2azI4RjRnY
	DIQ9R/Q6ctjeasy5ba1V6853QRUG2okT8iJFyIv3iMYO2yiYM/9OT8ZR4GNyT2ePtLwDB2B/beU
	Rt7FRvV5XtspnADFTToRyP1GhGge
X-Google-Smtp-Source: AGHT+IE90R18kzDPcUDYrKZmtNA9Ji8cQGZIKHPvuKthQE95sgqPN3uvJc7j6Eoy2Oke9WqTgojrNw==
X-Received: by 2002:a5d:4207:0:b0:38b:ebcd:305c with SMTP id ffacd0b85a97d-38bf5675826mr2536069f8f.29.1737130681599;
        Fri, 17 Jan 2025 08:18:01 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438904136easm37343235e9.13.2025.01.17.08.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 08:18:01 -0800 (PST)
Message-ID: <847596a107c6ab0370d69a16deb3d9dfc6c04074.camel@gmail.com>
Subject: Re: [PATCH v10 4/8] iio: adc: adi-axi-adc: add interface type
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>
Date: Fri, 17 Jan 2025 16:18:01 +0000
In-Reply-To: <20250117130702.22588-5-antoniu.miclaus@analog.com>
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
	 <20250117130702.22588-5-antoniu.miclaus@analog.com>
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
> Add support for getting the interface (CMOS or LVDS) used by the AXI ADC
> IP.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> no changes in v10.
> =C2=A0drivers/iio/adc/adi-axi-adc.c | 23 +++++++++++++++++++++++
> =C2=A01 file changed, 23 insertions(+)
>=20
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.=
c
> index c7357601f0f8..d2e1dc63775c 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -39,6 +39,9 @@
> =C2=A0#define=C2=A0=C2=A0 ADI_AXI_REG_RSTN_MMCM_RSTN		BIT(1)
> =C2=A0#define=C2=A0=C2=A0 ADI_AXI_REG_RSTN_RSTN			BIT(0)
> =C2=A0
> +#define ADI_AXI_ADC_REG_CONFIG			0x000c
> +#define=C2=A0=C2=A0 ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N	BIT(7)
> +
> =C2=A0#define ADI_AXI_ADC_REG_CTRL			0x0044
> =C2=A0#define=C2=A0=C2=A0=C2=A0 ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
> =C2=A0
> @@ -290,6 +293,25 @@ static int axi_adc_chan_disable(struct iio_backend *=
back,
> unsigned int chan)
> =C2=A0				 ADI_AXI_REG_CHAN_CTRL_ENABLE);
> =C2=A0}
> =C2=A0
> +static int axi_adc_interface_type_get(struct iio_backend *back,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum iio_backend_interface_type *type=
)
> +{
> +	struct adi_axi_adc_state *st =3D iio_backend_get_priv(back);
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D regmap_read(st->regmap, ADI_AXI_ADC_REG_CONFIG, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N)
> +		*type =3D IIO_BACKEND_INTERFACE_SERIAL_CMOS;
> +	else
> +		*type =3D IIO_BACKEND_INTERFACE_SERIAL_LVDS;
> +
> +	return 0;
> +}
> +
> =C2=A0static struct iio_buffer *axi_adc_request_buffer(struct iio_backend=
 *back,
> =C2=A0						 struct iio_dev *indio_dev)
> =C2=A0{
> @@ -337,6 +359,7 @@ static const struct iio_backend_ops adi_axi_adc_ops =
=3D {
> =C2=A0	.iodelay_set =3D axi_adc_iodelays_set,
> =C2=A0	.test_pattern_set =3D axi_adc_test_pattern_set,
> =C2=A0	.chan_status =3D axi_adc_chan_status,
> +	.interface_type_get =3D axi_adc_interface_type_get,
> =C2=A0	.debugfs_reg_access =3D iio_backend_debugfs_ptr(axi_adc_reg_access=
),
> =C2=A0	.debugfs_print_chan_status =3D
> iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
> =C2=A0};


