Return-Path: <linux-pwm+bounces-3327-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0DD97E8E5
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 11:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10A91F219E8
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 09:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BDD194A70;
	Mon, 23 Sep 2024 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ct30iPyJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9C3194A65
	for <linux-pwm@vger.kernel.org>; Mon, 23 Sep 2024 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727084430; cv=none; b=cZ53TJx1WqVtbEfz+Bj1YRsD2bqUtoeXgMmCLTNmOGMBopfXdYYVW52Rx/8dQyvgTaCq8AiLZkBj6Bmeq3+8PSvbXZWZ9Pb+HU8Xvv9mJI48FbmloLgUPpavQa5Wr24uVNjqRAXOSiW+Bt8C3qjY6vscg07fBg6HNyyV5UPoMhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727084430; c=relaxed/simple;
	bh=K7gYqpOdu86p0YAq0PAz0SunG1Wnt4nFKzstqYEdl6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAYduH2/b3UT9W8ujj3lymC+d4lZPE+BrWhhNituNXUu/wBXwywkTb0hZ2UGiX7m/OpiN4PP/F2dW3FRcZXsPhlQpu87/1Cab8DI5hVc2tPdFhPdm9+vXZxEAtMPw51sFd7VhQyjK4kEEa4LfmmozZRBSJqNDlUPDGDJZhnlHgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ct30iPyJ; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f762de00e5so42206141fa.3
        for <linux-pwm@vger.kernel.org>; Mon, 23 Sep 2024 02:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727084425; x=1727689225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BIFSWAh9BHN4VRAGH5ZmERVjoR+BTdeLvledqUTR/s=;
        b=ct30iPyJaOK2tGYZjkoWaMjNQ2qWxIkI3xztRkSqkB128YtQNkjjwaOYnXrKdL04F6
         tQm+R7sYp2Ar+Or33wDUL4jL05f08h5G+y47hET2bJvhgJydCNVMHVKX+eWJAaz6J3sf
         XTfKCRKOgSx7ERuhHj83+Gq6mhmbgXRnJ1b3TBnrW0r08QqJCZe3PcEv3hnj8ruZdEY/
         IWFhUjohvYeYNT+nqO9FmizxEWYI+XYKLg9Qi/0nCKcYIYUt6hA0kUGhxtxksY/9Uzkk
         BFrCPGi5GHq2/LG3zN7/sN+4srhMzLv84jwwQ6dziS5eiVFajPJWAezHfEHeiv/Ob/aJ
         6pXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727084425; x=1727689225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BIFSWAh9BHN4VRAGH5ZmERVjoR+BTdeLvledqUTR/s=;
        b=DLnuQ2Dbl86WS12ubB/XNaHEc8Aj0kdY4y4wgX5ZLGYkjbYFGaY2kfFx8xHduCsMz7
         RLdlAYtGrRC0yXJruBRMajonDrWrXZRZLsghPjRFQ0cn0h7jLrXo2beizfNO/EIoV+JM
         xM622ZnFq2brovsvtVES8nOy2NcEFxbrGsV5Fgh4V+zVGGtNl6vQdMS0tu/PpWb0IEYS
         5FhPBHzHF+RJLX0sHG50uiphf/D4YHLozmh0Xgd2KoBgchXhKJ+gxU9bJ19pz/2Sc4T/
         s1Ny/aGEzOXnIlsNq06B23aIOGlSQB40zJddm33rnfnYTX8sPJQilswY1B2j53UawiT2
         I/Xw==
X-Forwarded-Encrypted: i=1; AJvYcCV4xtLUwySlLUvRNYH6vcde4V1Qu9N+/xGVtKZuMJKXOQIGpUBRyRmxVi5xVanCnS+e69ZqAbgeiLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3wUFQ8255k/PxZKiiyKUWyo7wMqRCaDxyArBy+Uiiwp0indzF
	0wZl4FKoM2aXIdHUI/eWgZ7GeGhgLBOwoa2TMMfibUswfB8Q6QTKVRU5/pImhOGppzm7XEynpYy
	6rwQ4p/1DAd1dgBrzn/G2eL47GDdlPcsoR796Ow==
X-Google-Smtp-Source: AGHT+IElQHvlRkq48cnX8DzhA4UzbfGapr8aSqkqfRIPPwejqMZX+8ECof58f5lS6wVZ2zJ1Ia8StGFcvbFBMC0a/gs=
X-Received: by 2002:a05:651c:2122:b0:2f6:6202:bfd5 with SMTP id
 38308e7fff4ca-2f7cb335da1mr56862321fa.34.1727084425001; Mon, 23 Sep 2024
 02:40:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
 <20240920-ad7606_add_iio_backend_support-v2-9-0e78782ae7d0@baylibre.com>
In-Reply-To: <20240920-ad7606_add_iio_backend_support-v2-9-0e78782ae7d0@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 23 Sep 2024 11:40:14 +0200
Message-ID: <CAMknhBEErfs7LhyyjW=tAPbfz1B1SBEABAziU+xOC_6rE-e2jw@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] iio: adc: ad7606: Add iio-backend support
To: Guillaume Stols <gstols@baylibre.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Michal Marek <mmarek@suse.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, aardelean@baylibre.com, jstephan@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 7:33=E2=80=AFPM Guillaume Stols <gstols@baylibre.co=
m> wrote:
>
> - Basic support for iio backend.
> - Supports IIO_CHAN_INFO_SAMP_FREQ R/W.
> - Only hardware mode is available, and that IIO_CHAN_INFO_RAW is not
>   supported if iio-backend mode is selected.
>
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  drivers/iio/adc/Kconfig      |  2 +
>  drivers/iio/adc/ad7606.c     | 94 +++++++++++++++++++++++++++++++++++++-=
------
>  drivers/iio/adc/ad7606.h     | 15 +++++++
>  drivers/iio/adc/ad7606_par.c | 91 ++++++++++++++++++++++++++++++++++++++=
++++
>  4 files changed, 187 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 4ab1a3092d88..9b52d5b2c592 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -224,9 +224,11 @@ config AD7606_IFACE_PARALLEL
>         tristate "Analog Devices AD7606 ADC driver with parallel interfac=
e support"
>         depends on HAS_IOPORT
>         select AD7606
> +       select IIO_BACKEND
>         help
>           Say yes here to build parallel interface support for Analog Dev=
ices:
>           ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converte=
rs (ADC).
> +         It also support iio_backended devices for AD7606B.
>
>           To compile this driver as a module, choose M here: the
>           module will be called ad7606_par.
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 7f2ff1674638..f710445bdc22 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -21,6 +21,7 @@
>  #include <linux/util_macros.h>
>  #include <linux/units.h>
>
> +#include <linux/iio/backend.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/sysfs.h>
> @@ -271,7 +272,15 @@ static int ad7606_set_sampling_freq(struct ad7606_st=
ate *st, unsigned long freq)
>
>  static int ad7606_read_samples(struct ad7606_state *st)
>  {
> -       unsigned int num =3D st->chip_info->num_channels - 1;
> +       unsigned int num =3D st->chip_info->num_channels;

Probably better to introduce a new num_voltage_channels field to
chip_info instead of trying to reverse engineer if there is a
timestamp channel or not.

> +
> +       /*
> +        * Timestamp channel does not contain sample, and no timestamp ch=
annel if
> +        * backend is used.
> +        */
> +       if (!st->back)
> +               num--;
> +
>         u16 *data =3D st->data;
>
>         return st->bops->read_block(st->dev, num, data);
> @@ -319,11 +328,14 @@ static int ad7606_scan_direct(struct iio_dev *indio=
_dev, unsigned int ch)
>                 if (!ret)
>                         return ret;
>         }
> -       ret =3D wait_for_completion_timeout(&st->completion,
> -                                         msecs_to_jiffies(1000));
> -       if (!ret) {
> -               ret =3D -ETIMEDOUT;
> -               goto error_ret;
> +
> +       if (!st->back) {
> +               ret =3D wait_for_completion_timeout(&st->completion,
> +                                                 msecs_to_jiffies(1000))=
;
> +               if (!ret) {
> +                       ret =3D -ETIMEDOUT;
> +                       goto error_ret;
> +               }
>         }

Would it be better to just make a different scan_direct function for
the case when we don't have the BUSY interrtup?

>
>         ret =3D ad7606_read_samples(st);
> @@ -349,6 +361,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
>  {
>         int ret, ch =3D 0;
>         struct ad7606_state *st =3D iio_priv(indio_dev);
> +       struct pwm_state cnvst_pwm_state;
>
>         switch (m) {
>         case IIO_CHAN_INFO_RAW:
> @@ -369,6 +382,10 @@ static int ad7606_read_raw(struct iio_dev *indio_dev=
,
>         case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>                 *val =3D st->oversampling;
>                 return IIO_VAL_INT;
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
> +               *val =3D DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, cnvst_pwm_st=
ate.period);
> +               return IIO_VAL_INT;
>         }
>         return -EINVAL;
>  }
> @@ -458,6 +475,8 @@ static int ad7606_write_raw(struct iio_dev *indio_dev=
,
>                         return ret;
>
>                 return 0;
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               return ad7606_set_sampling_freq(st, val);
>         default:
>                 return -EINVAL;
>         }
> @@ -595,14 +614,49 @@ static int ad7606_buffer_predisable(struct iio_dev =
*indio_dev)
>         return 0;
>  }
>
> +static int ad7606_pwm_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +       struct ad7606_state *st =3D iio_priv(indio_dev);
> +
> +       return ad7606_pwm_set_swing(st);
> +}
> +
> +static int ad7606_pwm_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +       struct ad7606_state *st =3D iio_priv(indio_dev);
> +
> +       return ad7606_pwm_set_low(st);
> +}
> +
> +static int ad7606_update_scan_mode(struct iio_dev *indio_dev,
> +                                  const unsigned long *scan_mask)
> +{
> +       struct ad7606_state *st =3D iio_priv(indio_dev);
> +
> +       /* The update scan mode is only for iio backend compatible driver=
s.
> +        * If the specific update_scan_mode is not defined in the bus ops=
,
> +        * just do nothing and return 0.
> +        */
> +       if (st->bops->update_scan_mode)
> +               return st->bops->update_scan_mode(indio_dev, scan_mask);
> +       else
> +               return 0;
> +}

Usually, we try to avoid else after return.

So perhaps simpler:

if (!st->bops->update_scan_mode)
        return 0;

return st->bops->update_scan_mode(indio_dev, scan_mask);

> +
>  static const struct iio_buffer_setup_ops ad7606_buffer_ops =3D {
>         .postenable =3D &ad7606_buffer_postenable,
>         .predisable =3D &ad7606_buffer_predisable,
>  };
>
> +static const struct iio_buffer_setup_ops ad7606_pwm_buffer_ops =3D {
> +       .postenable =3D &ad7606_pwm_buffer_postenable,
> +       .predisable =3D &ad7606_pwm_buffer_predisable,
> +};
> +
>  static const struct iio_info ad7606_info_no_os_or_range =3D {
>         .read_raw =3D &ad7606_read_raw,
>         .validate_trigger =3D &ad7606_validate_trigger,
> +       .update_scan_mode =3D &ad7606_update_scan_mode,
>  };
>
>  static const struct iio_info ad7606_info_os_and_range =3D {
> @@ -610,6 +664,7 @@ static const struct iio_info ad7606_info_os_and_range=
 =3D {
>         .write_raw =3D &ad7606_write_raw,
>         .attrs =3D &ad7606_attribute_group_os_and_range,
>         .validate_trigger =3D &ad7606_validate_trigger,
> +       .update_scan_mode =3D &ad7606_update_scan_mode,
>  };
>
>  static const struct iio_info ad7606_info_os_range_and_debug =3D {
> @@ -618,6 +673,7 @@ static const struct iio_info ad7606_info_os_range_and=
_debug =3D {
>         .debugfs_reg_access =3D &ad7606_reg_access,
>         .attrs =3D &ad7606_attribute_group_os_and_range,
>         .validate_trigger =3D &ad7606_validate_trigger,
> +       .update_scan_mode =3D &ad7606_update_scan_mode,
>  };
>
>  static const struct iio_info ad7606_info_os =3D {
> @@ -625,6 +681,7 @@ static const struct iio_info ad7606_info_os =3D {
>         .write_raw =3D &ad7606_write_raw,
>         .attrs =3D &ad7606_attribute_group_os,
>         .validate_trigger =3D &ad7606_validate_trigger,
> +       .update_scan_mode =3D &ad7606_update_scan_mode,
>  };
>
>  static const struct iio_info ad7606_info_range =3D {
> @@ -632,6 +689,7 @@ static const struct iio_info ad7606_info_range =3D {
>         .write_raw =3D &ad7606_write_raw,
>         .attrs =3D &ad7606_attribute_group_range,
>         .validate_trigger =3D &ad7606_validate_trigger,
> +       .update_scan_mode =3D &ad7606_update_scan_mode,
>  };
>
>  static const struct iio_trigger_ops ad7606_trigger_ops =3D {
> @@ -700,8 +758,6 @@ int ad7606_probe(struct device *dev, int irq, void __=
iomem *base_address,
>         indio_dev->channels =3D st->chip_info->channels;
>         indio_dev->num_channels =3D st->chip_info->num_channels;
>
> -       init_completion(&st->completion);
> -
>         ret =3D ad7606_reset(st);
>         if (ret)
>                 dev_warn(st->dev, "failed to RESET: no RESET GPIO specifi=
ed\n");
> @@ -774,14 +830,22 @@ int ad7606_probe(struct device *dev, int irq, void =
__iomem *base_address,
>                 if (ret)
>                         return ret;
>         }
> -       ret =3D devm_request_threaded_irq(dev, irq,
> -                                       NULL,
> -                                       &ad7606_interrupt,
> -                                       IRQF_TRIGGER_FALLING | IRQF_ONESH=
OT,
> -                                       chip_info->name, indio_dev);
> -       if (ret)
> -               return ret;
>
> +       if (st->bops->iio_backend_config) {
> +               ret =3D st->bops->iio_backend_config(dev, indio_dev);
> +               if (ret)
> +                       return ret;
> +               indio_dev->setup_ops =3D &ad7606_pwm_buffer_ops;
> +       } else {
> +               init_completion(&st->completion);
> +               ret =3D devm_request_threaded_irq(dev, irq,
> +                                               NULL,
> +                                               &ad7606_interrupt,
> +                                               IRQF_TRIGGER_FALLING | IR=
QF_ONESHOT,
> +                                               chip_info->name, indio_de=
v);
> +               if (ret)
> +                       return ret;
> +       }
>         return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(ad7606_probe, IIO_AD7606);
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index 18c87fe9a41a..53cd8eb4898e 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -34,6 +34,12 @@
>                 BIT(IIO_CHAN_INFO_SCALE),               \
>                 BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
>
> +#define AD7606_BI_CHANNEL(num)                         \
> +       AD760X_CHANNEL(num, 0,                          \
> +               BIT(IIO_CHAN_INFO_SCALE),               \
> +               BIT(IIO_CHAN_INFO_SAMP_FREQ) |          \
> +               BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> +
>  #define AD7616_CHANNEL(num)    \
>         AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SC=
ALE),\
>                 0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> @@ -59,6 +65,7 @@ enum ad7606_supported_device_ids {
>   * @os_req_reset       some devices require a reset to update oversampli=
ng
>   * @init_delay_ms      required delay in miliseconds for initialization
>   *                     after a restart
> + * @has_backend                defines if a backend is available for the=
 given chip
>   */
>  struct ad7606_chip_info {
>         enum ad7606_supported_device_ids id;
> @@ -69,6 +76,7 @@ struct ad7606_chip_info {
>         unsigned int                    oversampling_num;
>         bool                            os_req_reset;
>         unsigned long                   init_delay_ms;
> +       bool                            has_backend;

It isn't clear to me what this flag is for. If the flag is true, does
it mean that the chip requires to use the IIO backend and not the
older parallel interface? What if there is some chip that need to
support both?

>  };
>
>  /**
> @@ -115,6 +123,7 @@ struct ad7606_state {
>         unsigned int                    num_scales;
>         const unsigned int              *oversampling_avail;
>         unsigned int                    num_os_ratios;
> +       struct iio_backend              *back;
>         int (*write_scale)(struct iio_dev *indio_dev, int ch, int val);
>         int (*write_os)(struct iio_dev *indio_dev, int val);
>
> @@ -139,16 +148,21 @@ struct ad7606_state {
>
>  /**
>   * struct ad7606_bus_ops - driver bus operations
> + * @iio_backend_config function pointer for configuring the iio_backend =
for
> + *                     the compatibles that use it
>   * @read_block         function pointer for reading blocks of data
>   * @sw_mode_config:    pointer to a function which configured the device
>   *                     for software mode
>   * @reg_read   function pointer for reading spi register
>   * @reg_write  function pointer for writing spi register
>   * @write_mask function pointer for write spi register with mask
> + * @update_scan_mode   function pointer for handling the calls to iio_in=
fo's update_scan
> + *                     mode when enabling/disabling channels.
>   * @rd_wr_cmd  pointer to the function which calculates the spi address
>   */
>  struct ad7606_bus_ops {
>         /* more methods added in future? */
> +       int (*iio_backend_config)(struct device *dev, struct iio_dev *ind=
io_dev);
>         int (*read_block)(struct device *dev, int num, void *data);
>         int (*sw_mode_config)(struct iio_dev *indio_dev);
>         int (*reg_read)(struct ad7606_state *st, unsigned int addr);
> @@ -159,6 +173,7 @@ struct ad7606_bus_ops {
>                                  unsigned int addr,
>                                  unsigned long mask,
>                                  unsigned int val);
> +       int (*update_scan_mode)(struct iio_dev *indio_dev, const unsigned=
 long *scan_mask);
>         u16 (*rd_wr_cmd)(int addr, char isWriteOp);
>  };
>
> diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
> index 7bac39033955..564284ede997 100644
> --- a/drivers/iio/adc/ad7606_par.c
> +++ b/drivers/iio/adc/ad7606_par.c
> @@ -3,6 +3,8 @@
>   * AD7606 Parallel Interface ADC driver
>   *
>   * Copyright 2011 Analog Devices Inc.
> + * Copyright 2024 Analog Devices Inc.

Can just add year to existing copyright line.

> + * Copyright 2024 BayLibre SAS.
>   */
>
>  #include <linux/err.h>
> @@ -15,8 +17,80 @@
>  #include <linux/types.h>
>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/backend.h>

Alphabetical order?

> +
>  #include "ad7606.h"
>
> +static const struct iio_chan_spec ad7606b_bi_channels[] =3D {
> +       AD7606_BI_CHANNEL(0),
> +       AD7606_BI_CHANNEL(1),
> +       AD7606_BI_CHANNEL(2),
> +       AD7606_BI_CHANNEL(3),
> +       AD7606_BI_CHANNEL(4),
> +       AD7606_BI_CHANNEL(5),
> +       AD7606_BI_CHANNEL(6),
> +       AD7606_BI_CHANNEL(7),
> +};
> +
> +static int ad7606_bi_update_scan_mode(struct iio_dev *indio_dev, const u=
nsigned long *scan_mask)
> +{
> +       struct ad7606_state *st =3D iio_priv(indio_dev);
> +       unsigned int c, ret;
> +
> +       for (c =3D 0; c < indio_dev->num_channels; c++) {
> +               if (test_bit(c, scan_mask))
> +                       ret =3D iio_backend_chan_enable(st->back, c);
> +               else
> +                       ret =3D iio_backend_chan_disable(st->back, c);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int ad7606_bi_setup_iio_backend(struct device *dev, struct iio_de=
v *indio_dev)
> +{
> +       struct ad7606_state *st =3D iio_priv(indio_dev);
> +       unsigned int ret, c;
> +       struct iio_backend_data_fmt data =3D {
> +               .sign_extend =3D true,
> +               .enable =3D true,
> +       };
> +
> +       st->back =3D devm_iio_backend_get(dev, NULL);
> +       if (IS_ERR(st->back))
> +               return PTR_ERR(st->back);
> +
> +       /* If the device is iio_backend powered the PWM is mandatory */
> +       if (!st->cnvst_pwm)
> +               return -EINVAL;

Probably useful to print an error message here since EINVAL can be a
lot of things.

> +
> +       ret =3D devm_iio_backend_request_buffer(dev, st->back, indio_dev)=
;
> +       if (ret)
> +               return ret;
> +
> +       ret =3D devm_iio_backend_enable(dev, st->back);
> +       if (ret)
> +               return ret;
> +
> +       for (c =3D 0; c < indio_dev->num_channels; c++) {
> +               ret =3D iio_backend_data_format_set(st->back, c, &data);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       indio_dev->channels =3D ad7606b_bi_channels;
> +       indio_dev->num_channels =3D 8;

Can use ARRAY_SIZE(ad7606b_bi_channels) instead of hard-coding 8.

> +
> +       return 0;
> +}
> +
> +static const struct ad7606_bus_ops ad7606_bi_bops =3D {
> +       .iio_backend_config =3D ad7606_bi_setup_iio_backend,
> +       .update_scan_mode =3D ad7606_bi_update_scan_mode,
> +};
> +
>  static int ad7606_par16_read_block(struct device *dev,
>                                    int count, void *buf)
>  {
> @@ -96,9 +170,23 @@ static int ad7606_par_probe(struct platform_device *p=
dev)
>         void __iomem *addr;
>         resource_size_t remap_size;
>         int irq;
> +       struct iio_backend *back;
>
> +       /*
> +        * If a firmware node is available (ACPI or DT), platform_device_=
id is null
> +        * and we must use get_match_data.
> +        */
>         if (dev_fwnode(&pdev->dev)) {
>                 chip_info =3D device_get_match_data(&pdev->dev);
> +               back =3D devm_iio_backend_get(&pdev->dev, NULL);
> +               if (!IS_ERR(back))
> +                       /*
> +                        * If a backend is available in the device tree, =
call the core
> +                        * probe with backend bops, otherwise use the for=
mer bops.
> +                        */
> +                       return ad7606_probe(&pdev->dev, 0, NULL,
> +                                           chip_info,
> +                                           &ad7606_bi_bops);

It seems strange to be this adding inside the if statement for the DT
case. It would be more future proof to have it after instead, e.g. if
you bring back the patch for ad7606b_bi_channels().

>         } else {
>                 id =3D platform_get_device_id(pdev);
>                 chip_info =3D (const struct ad7606_chip_info *)id->driver=
_data;
> @@ -125,6 +213,7 @@ static const struct platform_device_id ad7606_driver_=
ids[] =3D {
>         { .name =3D "ad7606-4", .driver_data =3D (kernel_ulong_t)&ad7606_=
4_info, },
>         { .name =3D "ad7606-6", .driver_data =3D (kernel_ulong_t)&ad7606_=
6_info, },
>         { .name =3D "ad7606-8", .driver_data =3D (kernel_ulong_t)&ad7606_=
8_info, },
> +       { .name =3D "ad7606b", .driver_data =3D (kernel_ulong_t)&ad7606b_=
info, },
>         { }
>  };
>  MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
> @@ -134,6 +223,7 @@ static const struct of_device_id ad7606_of_match[] =
=3D {
>         { .compatible =3D "adi,ad7606-4", .data =3D &ad7606_4_info },
>         { .compatible =3D "adi,ad7606-6", .data =3D &ad7606_6_info },
>         { .compatible =3D "adi,ad7606-8", .data =3D &ad7606_8_info },
> +       { .compatible =3D "adi,ad7606b", .data =3D &ad7606b_info },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, ad7606_of_match);
> @@ -153,3 +243,4 @@ MODULE_AUTHOR("Michael Hennerich <michael.hennerich@a=
nalog.com>");
>  MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(IIO_AD7606);
> +MODULE_IMPORT_NS(IIO_BACKEND);
>
> --
> 2.34.1
>ad7606b_bi_channels

