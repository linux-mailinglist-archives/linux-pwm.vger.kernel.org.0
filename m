Return-Path: <linux-pwm+bounces-3502-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3118F9919BF
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 20:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACED01F22036
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 18:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D5515F308;
	Sat,  5 Oct 2024 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg/7GBid"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF93815AAD7;
	Sat,  5 Oct 2024 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728154472; cv=none; b=VMMhMC7StIH3b+f9eqrRgrGu48FCod5YNQHUBG7pzV9Ec5BwBB7/TF70rdoM4azJZcidQ+U0gC79YW9ERopvfqygy1rt7eXbFZmpXxhRTv47AW/Oni/0yYOv5XjgqFwaB742SMoFHcGfSny/FLH+08Cq5aw+6AryUuAA/cFKPd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728154472; c=relaxed/simple;
	bh=6IFKQhQLUJfPYXyVcfNJe2Hz4p82rNuBz6McE9ANNW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSuUJowzmsmgTeb/5tIh2FmJp9X5CLeFRirk9j3sS5RXSrxNSzxnut5Du3WlLyH2XxmEGb4zr7lwObSiVzYsnpwB2JllQUT5GyPt/eo5ZmNmGGAvnfdpYknoIeop7ILzlnlgvw1ArZa7KW3na+HlkB9SIRF7tZZjtKXei04dtZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eg/7GBid; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99422929b2so58430866b.0;
        Sat, 05 Oct 2024 11:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728154469; x=1728759269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMmSZeZIFzeYGmzKMn0nfeYr3NgLbMDWwRUaY8CIiEA=;
        b=eg/7GBidWy7Y3X9tSX367cx9U4SAxKmOcmlKnVFDkSJ95yAZInt7iPYCqLNrkHze0R
         bso5Wj2YXKhAeSjMCSAlyTlZLaMCPGFq5rUpRMtHPJ+/W7X0f3NWHLjBxuV2k6ohQDVe
         n8H6BPywwrq7XVmZtQXRXUUValTpMGIwemhgZ2/9EQr1UEu+ahExzEsHt2PqVUKatDxM
         dIo+VM+t9u6mQ+k5jTPLUhrA5ONCtX+i9tAUD8AEW9Q+clzm89CT89VmqtojX1ihY1dz
         Yt9f8l+Rtx6NFMbcJEi+Tm2V/CIRh4p82fRzrtlZ+mfvq2He1uglsnw6vMClJFLEtrrw
         gT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728154469; x=1728759269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMmSZeZIFzeYGmzKMn0nfeYr3NgLbMDWwRUaY8CIiEA=;
        b=Opb5erJz9zJNzMx7f0e3N8lhteKV/xv8ANMhwQHlNSo1rvvbw+NrXww1a+XLQaJjr6
         aYxsUUyOfJe6+80SRXY1tn3NjtRn6VDtuwFteIxEHkRozKsQYy8myHb06Hb5pUcL5Sei
         4HDg0tu+u7X7ypQxTNhDOaaMmmAISU+pl+laDPsoXmXdlt3XLaHGdggFCxsMgiZt2RYr
         /j5J0cMbh9DyVtiznYQFp60Bv6At7Cf1EJipL024pypUveqPlqlzXJMpk4iihXXtPK1Q
         g3XQEiGnNx9JcoGGcsSauzA97L4zSbpVeAHBlLIOi61mj+YcmZWnhTnKYteA8kq5CwQi
         i3sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSFsVHb4kH0OxmLG3lxW3zymsUmajNiVaOd4fkcwpin3B7UoHCLEKc2B/S47VG9gDSCo3gpJKc5/ga@vger.kernel.org, AJvYcCWOH4W0jyI0+gPkd7/ArsxcQ/GHUX8jkO5xlalixV8D1YtS7dgsaArlSJ1nyvw3NBlvBv4ka+ZSGjv2Rvqj@vger.kernel.org, AJvYcCXc7VmNHkuZk4rq/3yMk2KF10yS/0bUB42U85s1IFZOS3xeSeQa7YWgOAucStAyKGi5OJjMEKi75Jes@vger.kernel.org, AJvYcCXgbdb6Q/XRxK6OgYtjI+kk9Glb6nZyANtMR0OJf0k2z7QEqaN6FPxCoYq0THoLJ7Es4nI4/dB+vvdc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl06xONMUaSscm7mnRlUHnPrr8T9ENPNGKLoHRbXS54WqCpB/u
	fgb0Ra7iqt/GNCwl0iAtkeYhGR5+yzJpTATBQfltrFJ3MAzheaf7L1IBMqVn+3R1d6XoFZmBPyk
	6g9eLh9u+bnJJGP4XxZDqIuubBHE=
X-Google-Smtp-Source: AGHT+IHYkLpAuHJLyMbHAR8xpsUmUuC+S5mc4tx6KI1lkZAY0mtmYJlDZIzKtWmsUJ19UKuS6hQ4z69RqWjIAk2fdWw=
X-Received: by 2002:a17:907:6d10:b0:a99:4b63:f810 with SMTP id
 a640c23a62f3a-a994b6400d6mr14677566b.46.1728154469012; Sat, 05 Oct 2024
 11:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004140922.233939-1-antoniu.miclaus@analog.com> <20241004140922.233939-6-antoniu.miclaus@analog.com>
In-Reply-To: <20241004140922.233939-6-antoniu.miclaus@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 5 Oct 2024 21:53:51 +0300
Message-ID: <CAHp75VeaYBGTA7sN7SefsyMj09kaJLBoMz4=hf0GpxiXtF65+Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] iio: adc: ad485x: add ad485x driver
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, Mike Looijmans <mike.looijmans@topic.nl>, 
	Marius Cristea <marius.cristea@microchip.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alisa-Dariana Roman <alisadariana@gmail.com>, Ivan Mikhaylov <fr0st61te@gmail.com>, 
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, Dragos Bogdan <dragos.bogdan@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 5:12=E2=80=AFPM Antoniu Miclaus
<antoniu.miclaus@analog.com> wrote:
>
> Add support for the AD485X DAS familiy.

family.

...

> +#define AD485X_REG_PRODUCT_ID_L                0x04
> +#define AD485X_REG_PRODUCT_ID_H                0x05

Can this use bulk transfer with __le16 type?

...

> +#define AD485X_REG_CHX_OFFSET_LSB(ch)  AD485X_REG_CHX_OFFSET(ch)
> +#define AD485X_REG_CHX_OFFSET_MID(ch)  (AD485X_REG_CHX_OFFSET_LSB(ch) + =
0x01)
> +#define AD485X_REG_CHX_OFFSET_MSB(ch)  (AD485X_REG_CHX_OFFSET_MID(ch) + =
0x01)

But can you connect oscilloscope and actually see what's the difference?

...

> +#define AD485X_REG_CHX_GAIN_LSB(ch)    AD485X_REG_CHX_GAIN(ch)
> +#define AD485X_REG_CHX_GAIN_MSB(ch)    (AD485X_REG_CHX_GAIN(ch) + 0x01)

> +#define AD485X_REG_CHX_PHASE_LSB(ch)   AD485X_REG_CHX_PHASE(ch)
> +#define AD485X_REG_CHX_PHASE_MSB(ch)   (AD485X_REG_CHX_PHASE_LSB(ch) + 0=
x01)

__le16 + bulk transfers?

...

> +#define AD485X_SW_RESET                        (BIT(7) | BIT(0))

Is it really a bitfield? What then does each bit mean?

> +#define AD485X_SDO_ENABLE              BIT(4)
> +#define AD485X_SINGLE_INSTRUCTION      BIT(7)
> +#define AD485X_ECHO_CLOCK_MODE         BIT(0)

...

> +struct ad485x_chip_info {
> +       const char *name;
> +       unsigned int product_id;
> +       const unsigned int (*scale_table)[2];
> +       int num_scales;
> +       const int *offset_table;
> +       int num_offset;
> +       const struct iio_chan_spec *channels;
> +       unsigned int num_channels;
> +       unsigned long throughput;
> +       unsigned int resolution;

Have you run `pahole` for this and other data structures you
introduced? Is there any room for optimization?

> +};

...

> +static int ad485x_find_opt(bool *field, u32 size, u32 *ret_start)
> +{
> +       unsigned int i, cnt =3D 0, max_cnt =3D 0, max_start =3D 0;
> +       int start;
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
> +               return -ENOENT;
> +
> +       *ret_start =3D max_start;
> +
> +       return max_cnt;
> +}

Can you describe the search algorithm in the comment?

...

> +static int ad485x_calibrate(struct ad485x_state *st)
> +{
> +       unsigned int opt_delay, lane_num, delay, i, s, c;
> +       enum iio_backend_interface_type interface_type;

> +       bool pn_status[AD485X_MAX_LANES][AD485X_MAX_IODELAY];

Why bool and not bitmap? I think I already asked this, but I don't
remember what you answered.

> +       int ret;

...

> +static int ad485x_set_packet_format(struct iio_dev *indio_dev,
> +                                   const struct iio_chan_spec *chan,
> +                                   unsigned int format)
> +{
> +       struct ad485x_state *st =3D iio_priv(indio_dev);
> +       unsigned int val;
> +       int ret;
> +
> +       if (chan->scan_type.realbits =3D=3D 20)

Missing {}

> +               switch (format) {
> +               case 0:
> +                       val =3D 20;
> +                       break;
> +               case 1:
> +                       val =3D 24;
> +                       break;
> +               case 2:
> +                       val =3D 32;
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }
> +       else if (chan->scan_type.realbits =3D=3D 16)

Ditto.

> +               switch (format) {
> +               case 0:
> +                       val =3D 16;
> +                       break;
> +               case 1:
> +                       val =3D 24;
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }
> +       else

Ditto.

> +               return -EINVAL;
> +
> +       ret =3D iio_backend_data_size_set(st->back, val);
> +       if (ret)
> +               return ret;
> +
> +       return regmap_update_bits(st->regmap, AD485X_REG_PACKET,
> +                                 AD485X_PACKET_FORMAT_MASK, format);
> +}

...

> +static int ad485x_get_calibscale(struct ad485x_state *st, int ch, int *v=
al, int *val2)
> +{
> +       unsigned int reg_val;
> +       int gain;

Should be u8 gain[2] and...

> +       int ret;
> +
> +       guard(mutex)(&st->lock);
> +
> +       ret =3D regmap_read(st->regmap, AD485X_REG_CHX_GAIN_MSB(ch),
> +                         &reg_val);
> +       if (ret)
> +               return ret;
> +
> +       gain =3D (reg_val & 0xFF) << 8;
> +
> +       ret =3D regmap_read(st->regmap, AD485X_REG_CHX_GAIN_LSB(ch),
> +                         &reg_val);
> +       if (ret)
> +               return ret;
> +
> +       gain |=3D reg_val & 0xFF;

> +       *val =3D gain;

...get_unaligned_be/le16().

> +       *val2 =3D 32768;
> +
> +       return IIO_VAL_FRACTIONAL;
> +}

...

> +static int ad485x_set_calibscale(struct ad485x_state *st, int ch, int va=
l,
> +                                int val2)
> +{
> +       unsigned long long gain;
> +       unsigned int reg_val;
> +       int ret;

> +       gain =3D val * MICRO + val2;
> +       gain =3D DIV_U64_ROUND_CLOSEST(gain * 32768, MICRO);
> +
> +       reg_val =3D gain;

In the similar way, put_unaligned and use gain[0], gain[1];

> +       ret =3D regmap_write(st->regmap, AD485X_REG_CHX_GAIN_MSB(ch),
> +                          reg_val >> 8);
> +       if (ret)
> +               return ret;
> +
> +       return regmap_write(st->regmap, AD485X_REG_CHX_GAIN_LSB(ch),
> +                           reg_val & 0xFF);
> +}

...

> +static int ad485x_get_calibbias(struct ad485x_state *st, int ch, int *va=
l)
> +{

> +       if (st->info->resolution =3D=3D 16) {
> +               *val =3D msb << 8;
> +               *val |=3D mid;
> +               *val =3D sign_extend32(*val, 15);

get_unaligned_be16()

> +       } else {
> +               *val =3D msb << 12;
> +               *val |=3D mid << 4;
> +               *val |=3D lsb >> 4;

get_unaligned_be24()

> +               *val =3D sign_extend32(*val, 19);
> +       }

> +}

...

> +static int ad485x_set_calibbias(struct ad485x_state *st, int ch, int val=
)
> +{
> +       u8 buf[3] =3D { 0 };

0 is not needed.

> +       int ret;
> +
> +       if (val < 0)
> +               return -EINVAL;
> +
> +       if (st->info->resolution =3D=3D 16)
> +               put_unaligned_be16(val, buf);
> +       else
> +               put_unaligned_be24(val << 4, buf);

You see, you even did this! Why not in the above functions?

> +}

...

> +static const unsigned int ad485x_scale_avail[] =3D {
> +       2500, 5000, 10000, 6250, 12500, 20000, 25000, 40000, 50000, 80000=
,

It's better to have pow-of-2 of numbers on one line. So here each line up t=
o 8?

       2500, 5000, 10000, 6250, 12500, 20000, 25000, 40000, /* 0-7 */
       50000, 80000,     /* 8-9 */

> +};
> +
> +static void __ad485x_get_scale(struct ad485x_state *st, int scale_tbl,
> +                              unsigned int *val, unsigned int *val2)
> +{
> +       const struct ad485x_chip_info *info =3D st->info;
> +       const struct iio_chan_spec *chan =3D &info->channels[0];
> +       unsigned int tmp;
> +
> +       tmp =3D (scale_tbl * 1000000ULL) >> chan->scan_type.realbits;

MICRO? MEGA?

> +       *val =3D tmp / 1000000;
> +       *val2 =3D tmp % 1000000;

Ditto.


> +}

--
With Best Regards,
Andy Shevchenko

