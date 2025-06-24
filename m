Return-Path: <linux-pwm+bounces-6498-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D75AE5CEA
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 08:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF6EB7A446E
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 06:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E1A239E7E;
	Tue, 24 Jun 2025 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjNzOhTa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9F619F115;
	Tue, 24 Jun 2025 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750747088; cv=none; b=ST+fRU7l8QshVfmmV8Lcxp0gosdvIjutoCLjw1mja2BC532el1IeYFpDPmCh+hUWwV6F3F6jQq4IGrRqcrRUtUkd1MhIfIavce/y/452U7CFViQLUXSJgmWcY7lajA0CMnt3npsx/N19Um+vHnWTz6JXK1NN6dLLgyiDh8tuG8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750747088; c=relaxed/simple;
	bh=5x5FW0Qq9N9d+at8SLAilz34PMml4iUz2EDfTXqS8uQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4CDmVGqb77297aq4ZuaJrV+II2hGmX9HKXXpPTbBlslY8hhvSYYtON+duej21PZgK/fhVvve0pBRk/F3Po1r1Z25cHCAh/QZ3Z5R9kxHCWMetuVANQDjX8DTczgn/rmINihUCEQKQUIffvI2+/1zmGgT2X9SHB4Tn/v9UD2e8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjNzOhTa; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad89333d603so14054166b.2;
        Mon, 23 Jun 2025 23:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750747084; x=1751351884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLEdmaevXKlpstylI3v9fqqDkjjrdSsqzNCci0X+AgQ=;
        b=DjNzOhTaUi/QJp+z+ThYQKIMB8BWSWc7s1qMzVgRAPyHyrp12yJCcpClsQjLkhOujz
         tgxOxqTgKJp+tTjaYtfTAbC4clu7+GQ/Fec33jHMR/gzs87wWM72Dcaryc7fDscvTGXC
         G4XnceujzRFCmaZSfSV816wbJ6z7VHcan+HS7XYF4RHQj2Di6aYEY5YnkJ+ZJkaVfa6Z
         4shsphBtqRKPd5DVAECnLeE5z9gCRRazK1FLuls0rpIhKrSnk7o0j2hUhsiTos4ZX7zd
         O3meNjn/ztrjrb2biQD8aqX+8KY8X2mW6huvBNA2wWSYp/lhNjFb8dUa752yJMU4LDyz
         XqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750747084; x=1751351884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLEdmaevXKlpstylI3v9fqqDkjjrdSsqzNCci0X+AgQ=;
        b=l2amCgHgKccoXZ1Ptai8iln1JHLhyOS2csdF+drmOoVQ+5V8ztbkxQf4wu/WsFY4sq
         ns3w82nCZo8BnBHumTyVtqN27iiWspbcaZAmsKPWloktJuAV9ephqjYg/sM+WW463rrx
         JrzHD97xws0sVYu3obHKzEHbsfnHGdyKBf3k9h8Xtipur3lPnVryFXjMBGoxAk+kcrey
         I+qyw4PvYKh69Qp7E/CWlA/UHPebqph3LkLKqClbYpTgdNjcPHrj6WQeSchI08A/0dHP
         THUlpY5Lt7UcG2g9yOGRXuLH4kUELNFbVMxHXkPeFbsiI8cVsf9KwUDMiOt2SHkuwmRA
         5KIA==
X-Forwarded-Encrypted: i=1; AJvYcCW6ZRmW5p3LIntH4FofyITy3KlMljh5K2LDsJ5ivjYs+QzEp+lJ3PflH1KJ5P2grxKCC54AZw9wfde3bw4=@vger.kernel.org, AJvYcCWXU+DLg9A+YuFrimSBwe+H/bd7+UV/y/Q0IzyKkPVHTLz/Rj0KTkAw0yuAfQ1/4rwYB8HcUMu0IDiU@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu2oXB7DDMeN+8ylZune7CQYecmXpC7aOX/8S/ni8lo+DFkafd
	D6XcUdZ6ofJDr5Avrb/KUI+WV4+10YvjNz4JgSkbft858ScmJDgXx/1w6izR/Hrbn1IDuR9PqSJ
	QVVjmu5XH7GNmaRxk2Di8+TwLRov/WZ3nNMpU
X-Gm-Gg: ASbGncuQNBdYB1VyUqmhCqlH4rG6tGhckBBrk0NK4rvfr1YuuMKJPCOK6Fa0nPyV4VW
	1KbQxgmhlkhPu1yV2MgmRoO5PaF5cwTbt6DenocucMR70Ur7C3mBJUxokQ7rh0e0kiOIvrvI7EK
	l//WHrKxF46yk24gWf/mS/vqS4fVsbggbF8gZS+/06NGXQXA==
X-Google-Smtp-Source: AGHT+IEEo4TKDfk7Hph8qZoL7R/FkjEAOb0QkojD9TuDsjTCWjjcDxl+iDMRG8n+i14HR22x17Nsvzl2cbw0allxFYk=
X-Received: by 2002:a17:907:7f1f:b0:ad8:9257:5740 with SMTP id
 a640c23a62f3a-ae057990e95mr1430167966b.13.1750747083519; Mon, 23 Jun 2025
 23:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623211116.1395-1-ansuelsmth@gmail.com> <20250623211116.1395-2-ansuelsmth@gmail.com>
In-Reply-To: <20250623211116.1395-2-ansuelsmth@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 24 Jun 2025 09:37:26 +0300
X-Gm-Features: Ac12FXxOE60iYX210lDUTRaCP39OJWqhtoY5axx7J2zWDRaCoTTP1rmnjE36su8
Message-ID: <CAHp75VcEJ0w5rcyq_DSHHunYanU5S9OgnRz1t8XervXqGQCX4w@mail.gmail.com>
Subject: Re: [PATCH v15 2/2] pwm: airoha: Add support for EN7581 SoC
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Lukas Wunner <lukas@wunner.de>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Andy Shevchenko <andy@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, Benjamin Larsson <benjamin.larsson@genexis.eu>, 
	Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 12:11=E2=80=AFAM Christian Marangi <ansuelsmth@gmai=
l.com> wrote:
>
> Introduce driver for PWM module available on EN7581 SoC.

...

> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v15:
> - Fix compilation error for 64bit division on 32bit (patch 01)
> - Add prefer async probe

Wow, I am impressed!

...

> +config PWM_AIROHA
> +       tristate "Airoha PWM support"
> +       depends on ARCH_AIROHA || COMPILE_TEST

> +       depends on OF

There is nothing dependent on this. If you want to enable run-time,
why not using this in conjunction with the COMPILE_TEST?

> +       select REGMAP_MMIO

...

> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/err.h>

> +#include <linux/gpio.h>

Have you had a chance to read the top of that header file?
No, just no. This header must not be used in the new code.

> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/math64.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>

> +#include <linux/of.h>

Nothing is used from this header. You actually missed mod_devicetable.h.

> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>

Missing headers, such as types.h.
Please, follow the IWYU principle.

...

> +struct airoha_pwm {
> +       struct regmap *regmap;

> +       u64 initialized;

Is it bitmap? This looks really weird, at least a comment is a must to
explain why 64-bit for the variable that suggests (by naming) only a
single bit.

> +       struct airoha_pwm_bucket buckets[AIROHA_PWM_NUM_BUCKETS];
> +
> +       /* Cache bucket used by each pwm channel */
> +       u8 channel_bucket[AIROHA_PWM_MAX_CHANNELS];
> +};

...

> +static u32 airoha_pwm_get_duty_ticks_from_ns(u64 period_ns, u64 duty_ns)
> +{
> +       return mul_u64_u64_div_u64(duty_ns, AIROHA_PWM_DUTY_FULL,
> +                                  period_ns);

For readability this can be one line.

> +}

...

> +       regmap_read(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset)=
,
> +                   &val);

Ditto.

Btw, no error checks for regmap_*() calls?


> +static int airoha_pwm_get_generator(struct airoha_pwm *pc, u64 duty_ns,
> +                                   u64 period_ns)
> +{
> +       int i, best =3D -ENOENT, unused =3D -ENOENT;

Why is 'i' signed?

> +       u64 best_period_ns =3D 0;
> +       u64 best_duty_ns =3D 0;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(pc->buckets); i++) {
> +               struct airoha_pwm_bucket *bucket =3D &pc->buckets[i];
> +               u64 bucket_period_ns =3D bucket->period_ns;
> +               u64 bucket_duty_ns =3D bucket->duty_ns;
> +               u32 duty_ticks, duty_ticks_bucket;
> +
> +               /* If found, save an unused bucket to return it later */
> +               if (!bucket->used) {
> +                       unused =3D i;
> +                       continue;
> +               }
> +
> +               /* We found a matching bucket, exit early */
> +               if (duty_ns =3D=3D bucket_duty_ns &&
> +                   period_ns =3D=3D bucket_period_ns)
> +                       return i;
> +
> +               /*
> +                * Unlike duty cycle zero, which can be handled by
> +                * disabling PWM, a generator is needed for full duty
> +                * cycle but it can be reused regardless of period
> +                */
> +               duty_ticks =3D airoha_pwm_get_duty_ticks_from_ns(period_n=
s, duty_ns);
> +               duty_ticks_bucket =3D airoha_pwm_get_duty_ticks_from_ns(b=
ucket_period_ns,
> +                                                                     buc=
ket_duty_ns);
> +               if (duty_ticks =3D=3D AIROHA_PWM_DUTY_FULL &&
> +                   duty_ticks_bucket =3D=3D AIROHA_PWM_DUTY_FULL)
> +                       return i;
> +
> +               /*
> +                * With an unused bucket available, skip searching for
> +                * a bucket to recycle (closer to the requested period/du=
ty)
> +                */
> +               if (unused !=3D -ENOENT)
> +                       continue;
> +
> +               /* Ignore bucket with invalid configs */
> +               if (bucket_period_ns > period_ns ||
> +                   bucket_duty_ns > duty_ns)
> +                       continue;
> +
> +               /*
> +                * Search for a bucket closer to the requested period/dut=
y
> +                * that has the maximal possible period that isn't bigger
> +                * than the requested period. For that period pick the ma=
ximal
> +                * duty_cycle that isn't bigger than the requested duty_c=
ycle.
> +                */
> +               if (bucket_period_ns > best_period_ns ||
> +                   (bucket_period_ns =3D=3D best_period_ns &&
> +                    bucket_duty_ns > best_duty_ns)) {
> +                       best_period_ns =3D bucket_period_ns;
> +                       best_duty_ns =3D bucket_duty_ns;
> +                       best =3D i;
> +               }
> +       }
> +
> +       /* With no unused bucket, return the best one found (if ever) */
> +       return unused =3D=3D -ENOENT ? best : unused;
> +}

This entire function reminds me of something from util_macros.h or
bsearch.h or similar. Can you double check that you really can't
utilise one of those?

...

> +       /* Nothing to clear, PWM channel never used */
> +       if (!(pc->initialized & BIT_ULL(hwpwm)))
> +               return;

So, it's a bitmap, why not use bitmap types and APIs?

> +       bucket =3D pc->channel_bucket[hwpwm];
> +       pc->buckets[bucket].used &=3D ~BIT_ULL(hwpwm);

Oh, why do you need 'used' to be also 64-bit?

> +}

...

> +       /*
> +        * Search for a bucket that already satisfy duty and period

satisfies

> +        * or an unused one.
> +        * If not found, -ENOENT is returned.
> +        */

...

> +static int airoha_pwm_sipo_init(struct airoha_pwm *pc)
> +{
> +       u32 val;
> +
> +       if (!(pc->initialized >> AIROHA_PWM_NUM_GPIO))
> +               return 0;

It will be clearer if you use bitmap APIs here to show how many bits
are indeed being used in "initialized" for this check.
Basically it's something like find_first_set_from() or so (I don't
remember names by heart). It will show the starting point
and the limit.

...

> +       regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
> +                         AIROHA_PWM_SERIAL_GPIO_MODE_74HC164);

This is interesting. Can the gpio-74x164 be used as a whole?

...

> +       regmap_write(pc->regmap, AIROHA_PWM_REG_SGPIO_CLK_DLY, 0x0);

'0x' is not needed.

...

> +       if (regmap_read_poll_timeout(pc->regmap, AIROHA_PWM_REG_SGPIO_LED=
_DATA, val,
> +                                    !(val & AIROHA_PWM_SGPIO_LED_DATA_SH=
IFT_FLAG),
> +                                    10, 200 * USEC_PER_MSEC))
> +               return -ETIMEDOUT;

Why is the error code shadowed?
ret =3D regmap...
if (ret)
  return ret;

...

> +       if (regmap_read_poll_timeout(pc->regmap, AIROHA_PWM_REG_SGPIO_LED=
_DATA, val,
> +                                    !(val & AIROHA_PWM_SGPIO_LED_DATA_SH=
IFT_FLAG),
> +                                    10, 200 * USEC_PER_MSEC))
> +               return -ETIMEDOUT;

Ditto.

...

> +       /* index -1 means disable PWM channel */

Negative index means

> +       if (index < 0) {

> +       }

...

> +static int airoha_pwm_config(struct airoha_pwm *pc, struct pwm_device *p=
wm,
> +                            u64 duty_ns, u64 period_ns)
> +{
> +       unsigned int hwpwm =3D pwm->hwpwm;
> +       int bucket;
> +
> +       bucket =3D airoha_pwm_consume_generator(pc, duty_ns, period_ns,
> +                                             hwpwm);
> +       if (bucket < 0)
> +               return -EBUSY;

Why is the error code shadowed?

> +
> +       airoha_pwm_config_flash_map(pc, hwpwm, bucket);
> +
> +       pc->initialized |=3D BIT_ULL(hwpwm);
> +       pc->channel_bucket[hwpwm] =3D bucket;
> +
> +       /*
> +        * SIPO are special GPIO attached to a shift register chip. The h=
andling
> +        * of this chip is internal to the SoC that takes care of applyin=
g the
> +        * values based on the flash map. To apply a new flash map, it's =
needed
> +        * to trigger a refresh on the shift register chip.
> +        * If we are configuring a SIPO, always reinit the shift register=
 chip
> +        * to make sure the correct flash map is applied.
> +        * We skip reconfiguring the shift register if we related hwpwm

s/we/the/ ?

> +        * is disabled (as it doesn't need to be mapped).
> +        */
> +       if (!(pc->initialized & BIT_ULL(hwpwm)) && hwpwm >=3D AIROHA_PWM_=
NUM_GPIO)
> +               airoha_pwm_sipo_init(pc);
> +
> +       return 0;
> +}

...

> +       if (!(pc->initialized >> AIROHA_PWM_NUM_GPIO))
> +               regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_M=
ODE_CFG,
> +                                 AIROHA_PWM_SERIAL_GPIO_FLASH_MODE);

If you use regmap cache the "initialized" might be not needed at all.
It might be possible to read back (from the cache) the current state
of some registers. Have you checked if this is a feasible approach?

...

> +       /*
> +        * Duty goes at 255 step, normalize it to check if we can

"in steps of 255 ns" ?
The original comment is confusing as step in singular form may mislead.

> +        * share a generator.
> +        */

--=20
With Best Regards,
Andy Shevchenko

