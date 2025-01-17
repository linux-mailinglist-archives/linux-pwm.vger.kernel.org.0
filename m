Return-Path: <linux-pwm+bounces-4666-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F9CA15424
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 17:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371C51883235
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 16:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303A519CD16;
	Fri, 17 Jan 2025 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHFTsbKw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F11C166F29;
	Fri, 17 Jan 2025 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737130953; cv=none; b=X1HQy+qcxiingVP8570Az5EE4VItXftfAISE/GWlxyeaBCL2tR/Va93UzEe6V/WTv5F0e9j+VXzJDBiIxGWXlK6DqwtoAYc3JoElPQG1N7zqYoMGOrS+YwHRdeWjs+UzzCY8EOkERhKL3iNIDji9brJJc2w8nVEbRDrWUES/JoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737130953; c=relaxed/simple;
	bh=50mwomwuxkCUC+ojeg4uORuPtD5HzzIVm4LChTczHek=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jLdB7WoKktwpZxH3Wwu8emuHD3xHv5G9xf5ak7/QyvsOKrHdUsyz33SupyVdXgQuEDx+ZyvG+3JhDsiUhPaF+eevDo/tuNIutvl0AKZ6pSy5UHfT3vJtOF5APhsvY1iSMrOQvdWxGyxoZHAw8Pej6XMDp37yjaSjgQZsV0bSkCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHFTsbKw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436281c8a38so15913235e9.3;
        Fri, 17 Jan 2025 08:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737130950; x=1737735750; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHadK7EAQ59IUYEPtnj1ZqgvfVMVc2kKIJlw/Tkswl4=;
        b=PHFTsbKwWPAPpodmqVRswHFsTG4YPcraorpoJC+N2gzWSpHAFz+btpyE8Rhq1ja81J
         YQuFKXbKy5kV9/y2oumZjWtT35Exd60rC1G9YZe/kVYNsMaQ9hba+ry2ec8pMRGXuOhd
         No9liUtsb8pJU6tNgIX23UAT/TF1lbhCubNYn0LDnCP2JLt451rBcbqWhC8Be3NmqUvW
         guoQC1SIOt6Ld7DkAUNDU+WxlMJzGpY5pUpJrrUmA/3ajNaVD4/JK36EDztSjssWj6gx
         zGlVFoIHH49GStSAVwGqxF58VnYc9smHxy29rqVpjtthfyZxtBALLnx70QQ5IMNWhr5b
         1q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737130950; x=1737735750;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kHadK7EAQ59IUYEPtnj1ZqgvfVMVc2kKIJlw/Tkswl4=;
        b=Hg7U5RmxqJyKRODeVSHtGKCXtf3jplJ87lCo7WthOx1ibzW8qGVmY3McCCLuyWi1uB
         u8pyeik9Vg5fUjCRD9EAprAvVigtWh/Z7+adVtpD0h/QjkCAztfbpJsb3DQIs2aHwjHd
         xQwKzBA2lTcxd48MTxN9XBBBOlxZFxBnr70J2t5//EL168uqJ0EdKLtNVXMFNrP3LNl4
         0zwoQAb8Q7GKdsULcCrtvhB6vuGJaqYEnn+6Pah8EcdpeHrGXfPKpx+wqC08AMBMjoql
         2gfJwkIpnMAQstqMTnn+e/TxzmWCQiOJtr50E9HqKXS6srejMqeqD7LGSw57+9/GbJn5
         Xl+A==
X-Forwarded-Encrypted: i=1; AJvYcCW4DCZZB939DSEafI7jlaHiVKqe8GgBPF4tj2BmCefKteYzi4KGLahAtqAIkwJBBTkxgHrjGjjy0RR3yuS3@vger.kernel.org, AJvYcCWJNKRmIMl7ZREunXiOnjHhCwdvVl3hPheKZmuCIKu2Creub2/mKyNaIltIgoDrH9XL4oujBVXU11Wi@vger.kernel.org, AJvYcCWl0XBOKZJAcjKe5Fy6cGyUOBu4YBpprV/n58Z3PMAsAbMc7/UKYBL+EUJgo4yoIL7gnYSqKF7Yumyg@vger.kernel.org, AJvYcCWlNCU6JO6MAeIXuoNg/RJ408h1veItYltY7sR7G1NhyE65/sn73uwpNacWXX1caLkZ5v6iUImTr4w6@vger.kernel.org
X-Gm-Message-State: AOJu0YyHw79jto6AYurdnZT6lOt/8UrqwwqkT27Kw24pEKDCLE8Vmz/K
	FCFFR4gn4COD8q/S8WlQJmVkb1nM1pP35u2S4KfInVSRFz0Rs9V6
X-Gm-Gg: ASbGncs2khboUK7NHep9oz5xH0pG2Nlx3eEe+xOdcLl0jHmr8rzfLr3k6BiLuoLhax/
	kK10ZqGq4pfimtW3PDvF+rheY0IPVw/1nYAPyX/GuoKIgwJc5al9bke+nTrkCHYF5VZyFI1PYbv
	1i16Jjgwk+sB8ZmFB7nneNZQL/xuRiBpYo5Az9fMIS/5O32BVGzzPaatdxmFBduE6fyswrY99PU
	hb7W09nSzlXdOyBqyqvuH0o0P8aE/EeC82ryJD38jMkd5ltd4Uoo6n1UbtJNRV1MOjNIfrB7MjR
	2NvOR+3O5mmkFbgJDpQ1lZiS4xGa
X-Google-Smtp-Source: AGHT+IF19g4QRqpmTkbAY0jupgeE3DaoWBuGu+3PyL+HZEHgPT308vzkgJQTqMEYlPel+869CXRopQ==
X-Received: by 2002:a5d:5f4d:0:b0:38a:614b:8632 with SMTP id ffacd0b85a97d-38bf57a6969mr3629906f8f.39.1737130949634;
        Fri, 17 Jan 2025 08:22:29 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf32845e8sm2903508f8f.97.2025.01.17.08.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 08:22:29 -0800 (PST)
Message-ID: <1d629a0b3ad6236a19ac52822ce11ba574c43ec1.camel@gmail.com>
Subject: Re: [PATCH v10 6/8] iio: adc: adi-axi-adc: add oversampling
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Date: Fri, 17 Jan 2025 16:22:30 +0000
In-Reply-To: <20250117130702.22588-7-antoniu.miclaus@analog.com>
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
	 <20250117130702.22588-7-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-17 at 15:07 +0200, Antoniu Miclaus wrote:
> Add support for enabling/disabling oversampling.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> no changes in v10.
> =C2=A0drivers/iio/adc/adi-axi-adc.c | 19 +++++++++++++++++++
> =C2=A01 file changed, 19 insertions(+)
>=20
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.=
c
> index 3c213ca5ff8e..ce88650bbb62 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -46,6 +46,7 @@
> =C2=A0#define=C2=A0=C2=A0=C2=A0 ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
> =C2=A0
> =C2=A0#define ADI_AXI_ADC_REG_CNTRL_3			0x004c
> +#define=C2=A0=C2=A0 AD485X_CNTRL_3_OS_EN_MSK		BIT(2)
> =C2=A0#define=C2=A0=C2=A0 AD485X_CNTRL_3_PACKET_FORMAT_MSK	GENMASK(1, 0)
> =C2=A0#define=C2=A0=C2=A0 AD485X_PACKET_FORMAT_20BIT		0x0
> =C2=A0#define=C2=A0=C2=A0 AD485X_PACKET_FORMAT_24BIT		0x1
> @@ -357,6 +358,23 @@ static int axi_adc_data_size_set(struct iio_backend
> *back, unsigned int size)
> =C2=A0				=C2=A0
> FIELD_PREP(AD485X_CNTRL_3_PACKET_FORMAT_MSK, val));
> =C2=A0}
> =C2=A0
> +static int axi_adc_oversampling_ratio_set(struct iio_backend *back,
> +					=C2=A0 unsigned int ratio)
> +{
> +	struct adi_axi_adc_state *st =3D iio_backend_get_priv(back);
> +
> +	switch (ratio) {
> +	case 0:
> +		return -EINVAL;
> +	case 1:
> +		return regmap_clear_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
> +					 AD485X_CNTRL_3_OS_EN_MSK);
> +	default:
> +		return regmap_set_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD485X_CNTRL_3_OS_EN_MSK);
> +	}
> +}
> +

So whatever the ration we just set the bits? This is odd enough that deserv=
es a
comment IMO... (did not looked at the datasheet/wiki tbh :))

- Nuno S=C3=A1
>=20


