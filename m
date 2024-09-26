Return-Path: <linux-pwm+bounces-3372-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4208F986F15
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Sep 2024 10:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCEB028B18B
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Sep 2024 08:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF201A76C3;
	Thu, 26 Sep 2024 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W5ewfJad"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC9518FC7C
	for <linux-pwm@vger.kernel.org>; Thu, 26 Sep 2024 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340040; cv=none; b=Qz9nloKkp9rnr6zmcQKMfXblGNOysVYpjVjs+TcBGIwo8pOna6osf0YSzlNjss9ywuW4rbGstGSyxHvgoKLFWmyUk4/ZNdV6RPOckZ3MuVJ4s5QCQ3Gd1aaz0ugOpMh07satqz+BnRCp6a3A4PrBByNfGEjb0TwF6uN92aMvgF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340040; c=relaxed/simple;
	bh=IUAscQfAPWcGfG5KWz3sDO7VY8+Fmjh5TSIrOr5dzxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mc+8AOyilzju0yQQ4aJslHHz3FwvhXYsUQ8VN8y5LuZNFxzNfBi0OsrodufTbY/wUSjL6FJAHl9luoxxNjZZqjwinQJasiy6ckZkXAHEnSfXxKHDDKteefG1K29fLx+Yk2KS5X2JewFQmvcxugt0z14iRNICWSVNsR+Uymf2wLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W5ewfJad; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f8ca33ef19so9453731fa.2
        for <linux-pwm@vger.kernel.org>; Thu, 26 Sep 2024 01:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727340036; x=1727944836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0MwdR2iQxztDvYXUCkuzrSSEMztnbTW3zli76Rbrj4=;
        b=W5ewfJadFVuHrLGU5U67j73/k4OSSM/PVpT9JG/89v0YL9M2q6uYkauDY2tmFToih2
         GFm/948fND6HL7YE0l5/YKqcYYuFJRy+0b4MctVoVlLrvf43GQcY8OZpDL4GFZtrfHIQ
         Hgu854NNnRFvBMyRWcS6Q0Hf1MEoba6iKptc4ZV5UEmzp5KEu24dV5LthEnsICNWB8Bs
         CuV824Hyu72Tbs32ZR+yR+DrA0MVxeqLgLyRC6D2X98hlO6NtS/IugENXIZSL6w3KIlt
         m+1kGl1Mc4Ql1E0FRVAXDI2apbQMMRxZiFXvGX5enTbCkqHtRyTn5dMo30dBKK1j1oeE
         HqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727340036; x=1727944836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0MwdR2iQxztDvYXUCkuzrSSEMztnbTW3zli76Rbrj4=;
        b=CtCTb/RhYAznqUvjEbIOteaCGaePFXPUxgZInbMMHd3Ku52ze2lD0iJVMlq5layF3b
         quT7f43pib41Ah5O2MkotdjHM33g7JX2C2njsfNEOi1frRvqH0OXyE5b16aRAWYjUU6T
         3DUiANIghrLDFkiFy3FJRVxdgeF03H2rcFogdJ7woPPIWGt/VtIYMZwFUSR2+mYMQdxC
         0hDzkBrCr3nVku61XCwSrYaezfB4dPOA0bmknvrPfClqztuIIuPkXqcka7wFxVI7Lk0u
         hnQ6D9cR8la8beot0nW/aieS0V1MTkpo9NMb+epb0wdFu6vTwyMQ82JmSgSg34pvvSOd
         fiLg==
X-Forwarded-Encrypted: i=1; AJvYcCW/+69IVMLQobQJSF/bebNudaZsHbugZ6G8TXuTrxJYGOkgjCiDrqLYKOWCECfdMlhpY6/ixDSqkOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrqgmrMA0fKQOxE5XK28tsV5c0658d+4aFPSaYGiiWhdzGA1ld
	w9JAXJuFYr++HEYfJ6DlCxuhaajdHO7hdcv27g3Vp7PGkqrAOHL/hVMiKcBeGuUBfzphy3itujj
	7kN3a0Pr0s69PWk6GtKaBQ8/UgG6siQvEbiG0/A==
X-Google-Smtp-Source: AGHT+IFSr9JkTwhWfLTZdtSxdCUGQdOwjvJTW9XCc1/LTklMn5Fnfo9IeD+hjurOMKjLb+ULnmN5lGQI4m06ZMeZCDU=
X-Received: by 2002:a05:651c:54c:b0:2ef:2905:f36d with SMTP id
 38308e7fff4ca-2f915fde153mr45484221fa.16.1727340036226; Thu, 26 Sep 2024
 01:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923101206.3753-1-antoniu.miclaus@analog.com> <20240923101206.3753-2-antoniu.miclaus@analog.com>
In-Reply-To: <20240923101206.3753-2-antoniu.miclaus@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 26 Sep 2024 10:40:25 +0200
Message-ID: <CAMknhBHmtpnX-nXxReF-rUW1ks1=iw3m_BmiRUTkf5XckPsvPw@mail.gmail.com>
Subject: Re: [PATCH 1/7] iio: backend: add API for interface get
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Alisa-Dariana Roman <alisadariana@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Dumitru Ceclan <mitrutzceclan@gmail.com>, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
	Marius Cristea <marius.cristea@microchip.com>, 
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, Dragos Bogdan <dragos.bogdan@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 12:15=E2=80=AFPM Antoniu Miclaus
<antoniu.miclaus@analog.com> wrote:
>
> Add backend support for obtaining the interface type used.
>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/industrialio-backend.c | 24 ++++++++++++++++++++++++
>  include/linux/iio/backend.h        | 10 ++++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-backend.c
> index efe05be284b6..53ab6bc86a50 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -449,6 +449,30 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *ind=
io_dev, uintptr_t private,
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, IIO_BACKEND);
>
> +/**
> + * iio_backend_interface_type_get - get the interace type used.
> + * @back: Backend device
> + * @type: Interface type
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_interface_type_get(struct iio_backend *back,
> +                                  enum iio_backend_interface_type *type)
> +{
> +       int ret;
> +
> +       ret =3D iio_backend_op_call(back, interface_type_get, type);
> +       if (ret)
> +               return ret;
> +
> +       if (*type > IIO_BACKEND_INTERFACE_CMOS)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, IIO_BACKEND);
> +
>  /**
>   * iio_backend_extend_chan_spec - Extend an IIO channel
>   * @indio_dev: IIO device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 8099759d7242..ba8ad30ac9ba 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -63,6 +63,11 @@ enum iio_backend_sample_trigger {
>         IIO_BACKEND_SAMPLE_TRIGGER_MAX
>  };
>
> +enum iio_backend_interface_type {
> +       IIO_BACKEND_INTERFACE_LVDS,
> +       IIO_BACKEND_INTERFACE_CMOS
> +};
> +
>  /**
>   * struct iio_backend_ops - operations structure for an iio_backend
>   * @enable: Enable backend.
> @@ -81,6 +86,7 @@ enum iio_backend_sample_trigger {
>   * @extend_chan_spec: Extend an IIO channel.
>   * @ext_info_set: Extended info setter.
>   * @ext_info_get: Extended info getter.
> + * @interface_type_get: Interface type.
>   **/
>  struct iio_backend_ops {
>         int (*enable)(struct iio_backend *back);
> @@ -113,6 +119,8 @@ struct iio_backend_ops {
>                             const char *buf, size_t len);
>         int (*ext_info_get)(struct iio_backend *back, uintptr_t private,
>                             const struct iio_chan_spec *chan, char *buf);
> +       int (*interface_type_get)(struct iio_backend *back,
> +                                 enum iio_backend_interface_type *type);
>  };
>
>  int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan)=
;
> @@ -142,6 +150,8 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indi=
o_dev, uintptr_t private,
>  ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t pr=
ivate,
>                                  const struct iio_chan_spec *chan, char *=
buf);
>
> +int iio_backend_interface_type_get(struct iio_backend *back,
> +                                  enum iio_backend_interface_type *type)=
;
>  int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
>                                  struct iio_backend *back,
>                                  struct iio_chan_spec *chan);
> --
> 2.46.0
>

This seems very specific to the AD485x chips and the AXI ADC backend.
Since it is describing how the chip is wired to the AXI DAC IP block,
I would be tempted to use the devicetree for this info instead of
adding a new backend function.

