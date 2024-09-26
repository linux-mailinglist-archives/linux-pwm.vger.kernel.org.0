Return-Path: <linux-pwm+bounces-3374-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 747C5986FA3
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Sep 2024 11:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39BF1282140
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Sep 2024 09:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F9D1537A5;
	Thu, 26 Sep 2024 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aU57QyCA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C01F1509B3
	for <linux-pwm@vger.kernel.org>; Thu, 26 Sep 2024 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341818; cv=none; b=jVH6rKeputc1AIQX9wq1j0e6hdf0FS2jaV8++fCv90oPJeHUmGmKQbTPXIfXdCBq6qKxX6ViQfVKWRNPiTftNo5KtfngeJN+d/DgoY1k3w5O/a1344y/la7e7fkMiomRxxqNV+vkQk/37cJW864Ek0bZCQW7vI5t6x6d+WrVOFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341818; c=relaxed/simple;
	bh=2GGzbBOZzMalzfQuVIFstcxqsDH6UHQRgJ518ClGRvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOvXTEMXgGAQ1aiLecjL5KhN9twhFhJ/YZfDLreP8mUw+KMW46ToC6deujXI5PLgM92EA9ua3P5qY8rbg34JSPoLxZP/MZT4yFFwPlzgbM/6sSnocKobhdQ0bD6OjSvTS3aldTXtdv7jQiKDA3kDuygGKbepOveGrQq5s7neIRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aU57QyCA; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f6580c2bbfso15421681fa.1
        for <linux-pwm@vger.kernel.org>; Thu, 26 Sep 2024 02:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727341815; x=1727946615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nwh2O4COiSTp2jISjGLzQlyIogx86g9K0lfDOU1b2Qc=;
        b=aU57QyCAQyWNse3uraCdSS8HASfDFceGfxuVu9CuJ90/ToHfTW29ULdTIX4SSUqoQi
         YIsNHCMa4+8JS5rda0+JTzHEA5PMD/LwHTwyDXOv8HWQHtKpBvoJsMfKQv47cXK9Tnp0
         voDieSgY2a5cPc34vipd4uZp5Y1AcLkJ0cbiRsrHjKxAt/JijapI7RHHJQik+5bWd+TY
         2i9gt1amGIUApA9gxHlZiOdIHZmdn7mCsrVe1lkTUoB0vUTen++Zw9jEdeVVgCh/bI97
         pOAv8K+XIPJfsr3WEV95JIBHEVN0R8exYpveLOi4fMe/TmHF7vAEG3JfW77idSuTsNX+
         ZxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727341815; x=1727946615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nwh2O4COiSTp2jISjGLzQlyIogx86g9K0lfDOU1b2Qc=;
        b=Om8sl8fOPATX6/CEd6CkuDxm+/iscPZORIsVdkGZrbqPexY9JlcJ2WHC2NIffRkmDP
         z/CJjvMT5Okoqnd3VKH3b6a5HYCxwho5P94AHcOSLRHBUgWeDNeXhKOxxKuRpKGZZD8h
         nhTiVFwKRG+KQmoBqQd2alGmGfTy+AhDlXujMYYQcbvyhWkaz/IQIG4iOVtWqtqw47mt
         +q3Kl4RFvtFT83qZvAJ4Uq4N+ri9oqBo3YdSc8vD4sarM4vDuXJ/bZgRkoMtnJV2C4Bi
         b3da+hebRjKrfJr3U/HapW4Y261o1DyI/bDWrxZcJshwO9nmixZDG6cvxqp24obmZl/w
         KtJg==
X-Forwarded-Encrypted: i=1; AJvYcCUnCUkkI1Cz90eE4c+N2gSYeA3rZQ0JqgYdwWrcMGRdZ9swLM8VGD1mGByiBj0ZTzXpr9D2wCrfTCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0rihL17Zh+3Xm0RxynrqOUghHJ14UNrI6C95D1Vu5PjC7wPtJ
	grGvDy89Mo1GaySzQNCJWAnN87SmOmxeiGFc5yxnSBAfOznznNR+jWvQ3zpdTclMBBsROUjukR6
	kQeMONZdskHeTPD9462RavnoA57A9WnGjzoqsdBZtk/6RsjPi7t4=
X-Google-Smtp-Source: AGHT+IEffVwqOiWH1hm4Kg4Qry51yeVEtAnmunyG4DBFSMVAq4X/LjJCgqD44Gbtme3TRPo5Fe1cXvksBoGdctM3PwE=
X-Received: by 2002:a2e:e0a:0:b0:2f7:5bf9:117c with SMTP id
 38308e7fff4ca-2f9c6d5b8c5mr5881681fa.21.1727341814639; Thu, 26 Sep 2024
 02:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923101206.3753-1-antoniu.miclaus@analog.com> <20240923101206.3753-3-antoniu.miclaus@analog.com>
In-Reply-To: <20240923101206.3753-3-antoniu.miclaus@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 26 Sep 2024 11:10:03 +0200
Message-ID: <CAMknhBFS3To1X4BBmaxLJPid5M=tjFv-9cQqG7Z0g0ndF24MpA@mail.gmail.com>
Subject: Re: [PATCH 2/7] iio: backend: add support for data size set
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
	Dumitru Ceclan <mitrutzceclan@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alisa-Dariana Roman <alisadariana@gmail.com>, Marius Cristea <marius.cristea@microchip.com>, 
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, Dragos Bogdan <dragos.bogdan@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 12:16=E2=80=AFPM Antoniu Miclaus
<antoniu.miclaus@analog.com> wrote:
>
> Add backend support for setting the data size used.
>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/industrialio-backend.c | 21 +++++++++++++++++++++
>  include/linux/iio/backend.h        |  3 +++
>  2 files changed, 24 insertions(+)
>
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-backend.c
> index 53ab6bc86a50..a6a6bedce7f1 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -473,6 +473,27 @@ int iio_backend_interface_type_get(struct iio_backen=
d *back,
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, IIO_BACKEND);
>
> +/**
> + * iio_backend_data_size_set - set the data width/size in the data bus.
> + * @back: Backend device
> + * @size: Size in bits
> + *
> + * Some frontend devices can dynamically control the word/data size on t=
he
> + * interface/data bus. Hence, the backend device needs to be aware of it=
 so
> + * data can be correctly transferred.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +ssize_t iio_backend_data_size_set(struct iio_backend *back, ssize_t size=
)

Why signed size? When will it be < 0?

> +{
> +       if (!size)
> +               return -EINVAL;
> +
> +       return iio_backend_op_call(back, data_size_set, size);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, IIO_BACKEND);
> +

