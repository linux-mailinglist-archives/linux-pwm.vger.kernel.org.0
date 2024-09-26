Return-Path: <linux-pwm+bounces-3378-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5629875C5
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Sep 2024 16:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22441F278A6
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Sep 2024 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57424149C42;
	Thu, 26 Sep 2024 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NahI+6fR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B1E13632B
	for <linux-pwm@vger.kernel.org>; Thu, 26 Sep 2024 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727361574; cv=none; b=heS9RqLPifY/pCpaoQ+VPiS1osKirtbAaO9VA6aRkJbn+587jaAYRs7Q/Kaq8+o7Z2EKBEWKTHvTB9T8xlX7a14xzF4Cc27apSv5t6XWj709FHztx/3pcGmhhCYxnRRYSjqE02JWtCq2SQ52F/kmssRtILfVbVCPhl2p/94E0kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727361574; c=relaxed/simple;
	bh=bOqgL0OkcJySRx4+iOLp6Imqy5HwyG708oO5/8lZs7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ts0Ff5n0clwucDJezqe4cN4AaIo5/WwAvjWiv7y6aEWIYpePw46mdzCjq0gsBC+X+kLHSVjSF/IZrn4jmcnjmuSLWBHmLZmS3sWxJrFWH++AFDlOaQeR2cTK7Q56Tyy476+BIiQbZL6/+/eyq+aYz5eqr0nKlsOCYDQQFOApAaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NahI+6fR; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f75b13c2a8so12105181fa.3
        for <linux-pwm@vger.kernel.org>; Thu, 26 Sep 2024 07:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727361570; x=1727966370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAtfhXeyVEQreG+8Gv1RrNd0/XsaAVUoNTBNgKuMa8o=;
        b=NahI+6fRtc9ePZ8pJKxhYa9XbSUtSyyTer7Zh9rs29qnGzL6K9xwR3JeNsBaxO4mF6
         Ap4YiWOoQ6hAjDLXujDWi8iS0OKnYLfdsgiLWR9RA65zhAWatd8QjZLqt8Yeqdc+jfOK
         uvq8rvYJnSsxKk9NzNKigcSO3UxDlO3DRmd6DJSxWaHGevaAju/9SqasZ+SAJkmiNZWD
         SWFpp+TQP4cjV6cEsCdqMX/deao8C2+AVwf0XdyKTI6oQvfMNQNAvUDi0ItD++3HUnWW
         48Ta37TczW0OrBoVPmcrPgYRCKW+GtUMU3IZMk6vcgXpG1DkCra6wDTTAKCWvYNQsf/c
         A3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727361570; x=1727966370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAtfhXeyVEQreG+8Gv1RrNd0/XsaAVUoNTBNgKuMa8o=;
        b=vrgjr+2J+FeMg5c6Xd2SGUk5Wv4YAsOFMZR4d9er3rdEJ488Pu5y9EAr2doBSCJNPn
         HtNRoeVU/nMYi/crcAGTUgxN1Ny+xq7TVZtFdJswqxK/6St5khcTfOwX7MyotuyqlJxk
         oqcYsFonceZRS06nxjJXZzSruzBA02uwX9uY9v4tiopx+8a2vnjQh/E7WeE4F6O6DPm4
         Ggzz9uzP62Pk9loFD3W3fi2b3bEo/6OsDR4PCkgOdm/aqUPUr6cmgn8poP2ZwFN9kkEF
         8sPrzoN6lsJ5ZvFmhetCDjdK8vewiutTWIuGXFGTWb/V3nEyJXZ3UE/Vm2nLzAseTmv5
         CfFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbneXern9vHhLqGfQIwbogwv2UFF5Uujwq6BehHsdVZ6BwdY2mdy9HshIDvkPbWa/SEllWG3hYSOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX+fLeFFzW79+zsY9f0JsKQc3ooDFw6NkBY0iwYVZKSwvOo/co
	Cn74qISGpPGYAC5QkoNgUZLIAvyPegUrmo6jgjNuS7azqAPl74ArOLpp1qAZm4gOYIMHUMyfRgV
	NCuKZrkfdyzvB/u5D0o5l5/jRYSV8aLXehkDL6g==
X-Google-Smtp-Source: AGHT+IH41GMrhkz6/W9m0C2gCSr9ypHAusHTpCTIetCCDoyaz1ekdYc1/FyLdWOZsteOSZqSjxEitH8VTE1bN1iNs4M=
X-Received: by 2002:a2e:b895:0:b0:2f7:4d86:5dcf with SMTP id
 38308e7fff4ca-2f91ca6ed08mr40088281fa.35.1727361569936; Thu, 26 Sep 2024
 07:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923101206.3753-1-antoniu.miclaus@analog.com> <20240923101206.3753-7-antoniu.miclaus@analog.com>
In-Reply-To: <20240923101206.3753-7-antoniu.miclaus@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 26 Sep 2024 16:39:18 +0200
Message-ID: <CAMknhBHRfj7d8Uea8vX=t+y+9dqoPABQSzsgNhBMTK-8-f6L7w@mail.gmail.com>
Subject: Re: [PATCH 6/7] iio: adc: ad485x: add ad485x driver
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
	Mike Looijmans <mike.looijmans@topic.nl>, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alisa-Dariana Roman <alisadariana@gmail.com>, Sergiu Cuciurean <sergiu.cuciurean@analog.com>, 
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 12:17=E2=80=AFPM Antoniu Miclaus
<antoniu.miclaus@analog.com> wrote:
>
> Add support for the AD485X DAS familiy.
>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...

> +static int ad485x_find_opt(bool *field, u32 size, u32 *ret_start)
> +{
> +       int i, cnt =3D 0, max_cnt =3D 0, start, max_start =3D 0;
> +
> +       for (i =3D 0, start =3D -1; i < size; i++) {
> +               if (field[i] =3D=3D 0) {
> +                       if (start =3D=3D -1)
> +                               start =3D i;
> +                       cnt++;
> +               } else {
> +                       if (cnt > max_cnt) {
> +                               max_cnt =3D cnt;
> +                               max_start =3D start;
> +                       }
> +                       start =3D -1;
> +                       cnt =3D 0;
> +               }
> +       }
> +
> +       if (cnt > max_cnt) {
> +               max_cnt =3D cnt;
> +               max_start =3D start;
> +       }
> +
> +       if (!max_cnt)
> +               return -EIO;

EIO seems an odd choice since this function doesn't actually do any
I/O. Maybe EINVAL would be better?

> +
> +       *ret_start =3D max_start;
> +
> +       return max_cnt;
> +}
> +

...

> +static int ad485x_set_calibscale(struct ad485x_state *st, int ch, int va=
l,
> +                                int val2)
> +{
> +       unsigned long long gain;
> +       unsigned int reg_val;
> +       int ret;
> +

Need to check both val and val2 for negative here before converting to unsi=
gned.

if (val < 0 || val2 < 0)
        return -EINVAL;

> +       gain =3D val * 1000000 + val2;
> +       gain =3D gain * 32768;
> +       gain =3D DIV_U64_ROUND_CLOSEST(gain, 1000000);
> +
> +       reg_val =3D gain;
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D regmap_write(st->regmap, AD485X_REG_CHX_GAIN_MSB(ch),
> +                          reg_val >> 8);
> +       if (ret)
> +               return ret;
> +
> +       return regmap_write(st->regmap, AD485X_REG_CHX_GAIN_LSB(ch),
> +                           reg_val & 0xFF);
> +}
> +
> +static int ad485x_get_calibbias(struct ad485x_state *st, int ch, int *va=
l,
> +                               int *val2)
> +{

val2 is unused and can be removed

> +       unsigned int lsb, mid, msb;
> +       int ret;
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D regmap_read(st->regmap, AD485X_REG_CHX_OFFSET_MSB(ch),
> +                         &msb);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_read(st->regmap, AD485X_REG_CHX_OFFSET_MID(ch),
> +                         &mid);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_read(st->regmap, AD485X_REG_CHX_OFFSET_LSB(ch),
> +                         &lsb);
> +       if (ret)
> +               return ret;
> +
> +       if (st->info->resolution =3D=3D 16) {
> +               *val =3D msb << 8;
> +               *val |=3D mid;
> +               *val =3D sign_extend32(*val, 15);
> +       } else {
> +               *val =3D msb << 12;
> +               *val |=3D mid << 4;
> +               *val |=3D lsb >> 4;
> +               *val =3D sign_extend32(*val, 19);
> +       }
> +
> +       return IIO_VAL_INT;
> +}
> +
> +static int ad485x_set_calibbias(struct ad485x_state *st, int ch, int val=
,
> +                               int val2)
> +{

val2 is unused here. It would also be a good idea to implement the
write_raw_get_fmt callback to select IIO_VAL_INT for this attribute to
avoid having to deal with negative val2.

> +       unsigned int lsb, mid, msb;
> +       int ret;

Should check for negative val here before converting to unsigned.

> +
> +       if (st->info->resolution =3D=3D 16) {
> +               lsb =3D 0;
> +               mid =3D val & 0xFF;
> +               msb =3D (val >> 8) & 0xFF;
> +       } else {
> +               lsb =3D (val << 4) & 0xFF;
> +               mid =3D (val >> 4) & 0xFF;
> +               msb =3D (val >> 12) & 0xFF;
> +       }
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D regmap_write(st->regmap, AD485X_REG_CHX_OFFSET_LSB(ch), l=
sb);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_write(st->regmap, AD485X_REG_CHX_OFFSET_MID(ch), m=
id);
> +       if (ret)
> +               return ret;
> +
> +       return regmap_write(st->regmap, AD485X_REG_CHX_OFFSET_MSB(ch), ms=
b);
> +}
> +

...

> +static int ad485x_set_offset(struct ad485x_state *st,
> +                            const struct iio_chan_spec *chan, int val)
> +{
> +       guard(mutex)(&st->lock);
> +
> +       if (st->offsets[chan->channel] !=3D val) {
> +               st->offsets[chan->channel] =3D val;
> +               /* Restore to the default range if offset changes */
> +               if (st->offsets[chan->channel])
> +                       return regmap_write(st->regmap,
> +                                               AD485X_REG_CHX_SOFTSPAN(c=
han->channel),
> +                                               AD485X_SOFTSPAN_N40V_40V)=
;
> +               return regmap_write(st->regmap,
> +                                       AD485X_REG_CHX_SOFTSPAN(chan->cha=
nnel),
> +                                       AD485X_SOFTSPAN_0V_40V);
> +       }
> +
> +       return 0;
> +}

I'm not sure I understand the relationship between softspan and the
offset. A raw value of 0 always means we measured 0V no matter what
the softspan setting is. So it seems like the offset should always be
0.

I'm guessing the intent was to handle bipolar vs. unipolar softspans,
but this doesn't actually work mathematically.

So far, I've only seen inputs that can be bipolar or unipolar
specified in the devicetree. I'm not aware of a way to select this at
runtime.

> +static struct iio_chan_spec_ext_info ad4858_ext_info[] =3D {
> +       IIO_ENUM("packet_format", IIO_SHARED_BY_ALL, &ad4858_packet_fmt),
> +       IIO_ENUM_AVAILABLE("packet_format",
> +                          IIO_SHARED_BY_ALL, &ad4858_packet_fmt),
> +       {},
> +};
> +
> +static struct iio_chan_spec_ext_info ad4857_ext_info[] =3D {
> +       IIO_ENUM("packet_format", IIO_SHARED_BY_ALL, &ad4857_packet_fmt),
> +       IIO_ENUM_AVAILABLE("packet_format",
> +                          IIO_SHARED_BY_ALL, &ad4857_packet_fmt),
> +       {},
> +};

Usually, something like this packet format would be automatically
selected when buffered reads are enabled based on what other features
it provides are needed, i.e only enable the status bits when events
are enabled.

(For those that didn't read the datasheet, the different packet
formats basically enable extra status bits per sample. And in the case
of oversampling, one of the formats also selects a reduced number of
sample bits.)

We have quite a few parts in the pipline right like this one that have
per-sample status bits. In the past, these were generally handled with
IIO events, but this doesn't really work for these high-speed backends
since the data is being piped directly to DMA and we don't look at
each sample in the ADC driver. So it would be worthwhile to try to
find some general solution here for handling this sort of thing.

> +
> +static const struct iio_chan_spec ad4858_channels[] =3D {
> +       AD485X_IIO_CHANNEL(0, 20, 32, ad4858_ext_info),
> +       AD485X_IIO_CHANNEL(1, 20, 32, ad4858_ext_info),
> +       AD485X_IIO_CHANNEL(2, 20, 32, ad4858_ext_info),
> +       AD485X_IIO_CHANNEL(3, 20, 32, ad4858_ext_info),
> +       AD485X_IIO_CHANNEL(4, 20, 32, ad4858_ext_info),
> +       AD485X_IIO_CHANNEL(5, 20, 32, ad4858_ext_info),
> +       AD485X_IIO_CHANNEL(6, 20, 32, ad4858_ext_info),
> +       AD485X_IIO_CHANNEL(7, 20, 32, ad4858_ext_info),
> +};
> +
> +static const struct iio_chan_spec ad4857_channels[] =3D {
> +       AD485X_IIO_CHANNEL(0, 16, 16, ad4857_ext_info),
> +       AD485X_IIO_CHANNEL(1, 16, 16, ad4857_ext_info),
> +       AD485X_IIO_CHANNEL(2, 16, 16, ad4857_ext_info),
> +       AD485X_IIO_CHANNEL(3, 16, 16, ad4857_ext_info),
> +       AD485X_IIO_CHANNEL(4, 16, 16, ad4857_ext_info),
> +       AD485X_IIO_CHANNEL(5, 16, 16, ad4857_ext_info),
> +       AD485X_IIO_CHANNEL(6, 16, 16, ad4857_ext_info),
> +       AD485X_IIO_CHANNEL(7, 16, 16, ad4857_ext_info),
> +};

How does 16-bit storage size work when packet format is 24-bit?

