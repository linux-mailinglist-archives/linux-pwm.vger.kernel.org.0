Return-Path: <linux-pwm+bounces-6505-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3AFAE5FA9
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 10:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59151920C1E
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 08:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77D526A1C1;
	Tue, 24 Jun 2025 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4JpJTl7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5AC26A0BF;
	Tue, 24 Jun 2025 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754521; cv=none; b=B0yK0HYAJ+G737vawawc7NlPof5K3S+8sKpr+kMzZQa5iS3SeAOL6prOwlcwd0NvpWlszSDsI7HJGO79RtllyVOrWPSxN6xWfGsDsIuq/6J66HR1svVfBxjjzSeYVKFHcdHTiqq2k7UicR4+cE/1ZhPLbE37VjwN1p1p79MkX9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754521; c=relaxed/simple;
	bh=/oX38kqzbWaqU0n0Fh7iSo5ky4dqr7yhrYhJ9+iljwg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zwn6WJ7YeQyqckeLfbjTaubKzvLiJwLpXHVGqeJCqj9bRpZjDHOKcLLQgJ+aWqaydTqFF3J+EU8uS/EFUTGl57Baavbkso0BqyjFVUeYjZpYhO5zkm5+pwZVjEDwmBqEaLe5xkLwuES2efJI7mcVAw8JguXaTcOKpDpLtGjEeb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4JpJTl7; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a6cdc27438so4302986f8f.2;
        Tue, 24 Jun 2025 01:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750754518; x=1751359318; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gxJVjiTDlOeg2EkZyZ6FBY+d8DTxhC71gq9697gn2mc=;
        b=K4JpJTl75KHPXtfNHXxa8n85BcdSfhkzmjOtNyMV2btjxiqWWYDLej6rSDEW5tlnA7
         12rQs0WaEoVmys/MOqzlR3EVSLGfncFddUPO+aTwiifRGh5ojQAvuBx1omHluccSqDTF
         5bPFNulCQywj3+hy/NIlfg37W6SNynx4dh27dKW6gFJJfZUBdN2dC3kz4UHxYfTa+yvq
         Gx0uUYmkBuDsXSfrgQ5/mqjspmRQ5Tiif4G2twqBWba0c0mbyNhO34bqpsodaQcaHOlA
         VKU/wme7pe/A/fE1lshAqtjo9kya+PLhpYVFTlsAWwf0Ay7hf6DEw6k3or/c9jTgeZTw
         K4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750754518; x=1751359318;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gxJVjiTDlOeg2EkZyZ6FBY+d8DTxhC71gq9697gn2mc=;
        b=BM6hkxSnW+MyNGZ0wuzLE8TVFY6oVyfMfhjaWtNpl1lnk/sEk/1dyKBN6WphJt8kZN
         q1YQ8vq0frqm6HriTd5b+W1EKCXWOqB/RLQ/2I4iu7F057TlbSDGJf/YUPrA5wfFj+zI
         /1FAF/RPhLgBs+O4hCBZXa33CNn02izTry5fBEcUuwnCfqpQZRJb9hLA51+jzdwL1yXR
         9vIwqK+qvGzTI8GwzN1ib9EALRUqHOeMba34kUMSTyGuYwRtaRKzk1WZJwSkAs/0GqqL
         NHnMtLrgCYWphnfsF61TwNDuUyivVpnC8QCGwnIgMChRifY1jiMFmXMclRG6ep3ynC10
         0/yg==
X-Forwarded-Encrypted: i=1; AJvYcCUl8FOaLHb/NAtZTgn4yZEFiqV5xsnQaYqKoEPWYd1pYBmxMLsVLNeGLlVMY5GNExeVogrjXStaCqHn@vger.kernel.org, AJvYcCXoQRhApZowbOdXxeXtwxzNawK6B2Jc+vbktxzJu4SJRWWabqtXSy5Wxozr/CaWqMvVEBPKycfZnMLBb8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/dwcGAvCTUlbWR8iU2x1+ZJ+Lz+EcLXLMhfQi/6kjHhZhDofe
	OSK32UF3ryN8f7qQfaeayzoR5ucuxrBblT840WRA9I6WViBw1DSMNlnS
X-Gm-Gg: ASbGncvXoUr2wqmiu6vGVfksFULzQU7JMSZO8tAsy9pWh+nhHcHFeYFqbErd9IS1qMK
	4+KSXmvQ67yKF5egta0r9aSGVCSyPGDJf7r3ylWCfrJlk0jFzir/5KRrNtE0u04uiECJXYvTO8M
	JysJfCu48SqUQ47jC47kDWHsh3ZNjyFlSPYqD6ppyoLwtVlkblJ63ZWDRctgRuC1KdMlVUuWg8I
	M81XXDlZLE1KDI/NqafNt5RHHuBBjJFlFmJJMo6ql4cvhtoSQD0+ogYLgCauzrzoRdrXM2D9jJu
	qq8qmJjoZlaELU6Fox8VmC/wwwmKJ3RYjfp1Usl2NBw2viVkv/eLPX1I9DNK2JF1v/bkfNIUnZU
	6M/kqHSJ2ZpKSMaL0T8KUtyEgA30i
X-Google-Smtp-Source: AGHT+IEX5roKgsJa1cioFILElZUGIDcZwVbz+KW8neuAL1u3GRVjQn1ZjhaJLEDqe1fLATzPuXrxVQ==
X-Received: by 2002:a05:6000:1acf:b0:3a6:d7e9:4309 with SMTP id ffacd0b85a97d-3a6d7e94339mr8846503f8f.29.1750754517664;
        Tue, 24 Jun 2025 01:41:57 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8050e09sm1382668f8f.19.2025.06.24.01.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 01:41:57 -0700 (PDT)
Message-ID: <685a64d5.df0a0220.1f9a42.38b0@mx.google.com>
X-Google-Original-Message-ID: <aFpk0lOZPEluJ5kx@Ansuel-XPS.>
Date: Tue, 24 Jun 2025 10:41:54 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v15 2/2] pwm: airoha: Add support for EN7581 SoC
References: <20250623211116.1395-1-ansuelsmth@gmail.com>
 <20250623211116.1395-2-ansuelsmth@gmail.com>
 <CAHp75VcEJ0w5rcyq_DSHHunYanU5S9OgnRz1t8XervXqGQCX4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcEJ0w5rcyq_DSHHunYanU5S9OgnRz1t8XervXqGQCX4w@mail.gmail.com>

On Tue, Jun 24, 2025 at 09:37:26AM +0300, Andy Shevchenko wrote:
> On Tue, Jun 24, 2025 at 12:11 AM Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > Introduce driver for PWM module available on EN7581 SoC.
> 
> ...
> 
> > Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > Changes v15:
> > - Fix compilation error for 64bit division on 32bit (patch 01)
> > - Add prefer async probe
> 
> Wow, I am impressed!
> 
> ...
> 
> > +config PWM_AIROHA
> > +       tristate "Airoha PWM support"
> > +       depends on ARCH_AIROHA || COMPILE_TEST
> 
> > +       depends on OF
> 
> There is nothing dependent on this. If you want to enable run-time,
> why not using this in conjunction with the COMPILE_TEST?
> 
> > +       select REGMAP_MMIO
> 
> ...
> 
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/err.h>
> 
> > +#include <linux/gpio.h>
> 
> Have you had a chance to read the top of that header file?
> No, just no. This header must not be used in the new code.
>

As you can see by the changelog this is very old code so I wasn't
aware.

> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/math64.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> 
> > +#include <linux/of.h>
> 
> Nothing is used from this header. You actually missed mod_devicetable.h.
> 
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> 
> Missing headers, such as types.h.
> Please, follow the IWYU principle.
> 

Aside from types do you have hint of other missing header? Do you have a
tool to identify the missing header?

> ...
> 
> > +struct airoha_pwm {
> > +       struct regmap *regmap;
> 
> > +       u64 initialized;
> 
> Is it bitmap? This looks really weird, at least a comment is a must to
> explain why 64-bit for the variable that suggests (by naming) only a
> single bit.
> 

There could be 33 PWM channel so it doesn't fit a u32. This is why u64.
I feel bitmap might be overkill for the task but if requested, I will
change it.

> > +       struct airoha_pwm_bucket buckets[AIROHA_PWM_NUM_BUCKETS];
> > +
> > +       /* Cache bucket used by each pwm channel */
> > +       u8 channel_bucket[AIROHA_PWM_MAX_CHANNELS];
> > +};
> 
> ...
> 
> > +static u32 airoha_pwm_get_duty_ticks_from_ns(u64 period_ns, u64 duty_ns)
> > +{
> > +       return mul_u64_u64_div_u64(duty_ns, AIROHA_PWM_DUTY_FULL,
> > +                                  period_ns);
> 
> For readability this can be one line.
> 

Mhhh I try to limit code to 80 column where possible.

> > +}
> 
> ...
> 
> > +       regmap_read(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
> > +                   &val);
> 
> Ditto.
> 
> Btw, no error checks for regmap_*() calls?
> 
> 
> > +static int airoha_pwm_get_generator(struct airoha_pwm *pc, u64 duty_ns,
> > +                                   u64 period_ns)
> > +{
> > +       int i, best = -ENOENT, unused = -ENOENT;
> 
> Why is 'i' signed?
> 
> > +       u64 best_period_ns = 0;
> > +       u64 best_duty_ns = 0;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(pc->buckets); i++) {
> > +               struct airoha_pwm_bucket *bucket = &pc->buckets[i];
> > +               u64 bucket_period_ns = bucket->period_ns;
> > +               u64 bucket_duty_ns = bucket->duty_ns;
> > +               u32 duty_ticks, duty_ticks_bucket;
> > +
> > +               /* If found, save an unused bucket to return it later */
> > +               if (!bucket->used) {
> > +                       unused = i;
> > +                       continue;
> > +               }
> > +
> > +               /* We found a matching bucket, exit early */
> > +               if (duty_ns == bucket_duty_ns &&
> > +                   period_ns == bucket_period_ns)
> > +                       return i;
> > +
> > +               /*
> > +                * Unlike duty cycle zero, which can be handled by
> > +                * disabling PWM, a generator is needed for full duty
> > +                * cycle but it can be reused regardless of period
> > +                */
> > +               duty_ticks = airoha_pwm_get_duty_ticks_from_ns(period_ns, duty_ns);
> > +               duty_ticks_bucket = airoha_pwm_get_duty_ticks_from_ns(bucket_period_ns,
> > +                                                                     bucket_duty_ns);
> > +               if (duty_ticks == AIROHA_PWM_DUTY_FULL &&
> > +                   duty_ticks_bucket == AIROHA_PWM_DUTY_FULL)
> > +                       return i;
> > +
> > +               /*
> > +                * With an unused bucket available, skip searching for
> > +                * a bucket to recycle (closer to the requested period/duty)
> > +                */
> > +               if (unused != -ENOENT)
> > +                       continue;
> > +
> > +               /* Ignore bucket with invalid configs */
> > +               if (bucket_period_ns > period_ns ||
> > +                   bucket_duty_ns > duty_ns)
> > +                       continue;
> > +
> > +               /*
> > +                * Search for a bucket closer to the requested period/duty
> > +                * that has the maximal possible period that isn't bigger
> > +                * than the requested period. For that period pick the maximal
> > +                * duty_cycle that isn't bigger than the requested duty_cycle.
> > +                */
> > +               if (bucket_period_ns > best_period_ns ||
> > +                   (bucket_period_ns == best_period_ns &&
> > +                    bucket_duty_ns > best_duty_ns)) {
> > +                       best_period_ns = bucket_period_ns;
> > +                       best_duty_ns = bucket_duty_ns;
> > +                       best = i;
> > +               }
> > +       }
> > +
> > +       /* With no unused bucket, return the best one found (if ever) */
> > +       return unused == -ENOENT ? best : unused;
> > +}
> 
> This entire function reminds me of something from util_macros.h or
> bsearch.h or similar. Can you double check that you really can't
> utilise one of those?
> 

I checked and bsearch can't be used and and for util_macros the closest
can't be used. As explained in previous revision, it's not simply a
matter of finding the closest value but it's about finding a value that
is closest to the period_ns and only with that condition satisfied one
closest to the duty. We can't mix them as search for the closest of
both.

> ...
> 
> > +       /* Nothing to clear, PWM channel never used */
> > +       if (!(pc->initialized & BIT_ULL(hwpwm)))
> > +               return;
> 
> So, it's a bitmap, why not use bitmap types and APIs?
> 
> > +       bucket = pc->channel_bucket[hwpwm];
> > +       pc->buckets[bucket].used &= ~BIT_ULL(hwpwm);
> 
> Oh, why do you need 'used' to be also 64-bit?
> 

In the extreme case, a bucket can be used by all 33 PWM channel.

> > +}
> 
> ...
> 
> > +       /*
> > +        * Search for a bucket that already satisfy duty and period
> 
> satisfies
> 
> > +        * or an unused one.
> > +        * If not found, -ENOENT is returned.
> > +        */
> 
> ...
> 
> > +static int airoha_pwm_sipo_init(struct airoha_pwm *pc)
> > +{
> > +       u32 val;
> > +
> > +       if (!(pc->initialized >> AIROHA_PWM_NUM_GPIO))
> > +               return 0;
> 
> It will be clearer if you use bitmap APIs here to show how many bits
> are indeed being used in "initialized" for this check.
> Basically it's something like find_first_set_from() or so (I don't
> remember names by heart). It will show the starting point
> and the limit.
> 
> ...
> 
> > +       regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
> > +                         AIROHA_PWM_SERIAL_GPIO_MODE_74HC164);
> 
> This is interesting. Can the gpio-74x164 be used as a whole?
> 

It's sad but the shift register chip is entirely handled by the SoC. We
can't access to it's registers so the dedicated gpio driver can't be
used.

> ...
> 
> > +       regmap_write(pc->regmap, AIROHA_PWM_REG_SGPIO_CLK_DLY, 0x0);
> 
> '0x' is not needed.
> 
> ...
> 
> > +       if (regmap_read_poll_timeout(pc->regmap, AIROHA_PWM_REG_SGPIO_LED_DATA, val,
> > +                                    !(val & AIROHA_PWM_SGPIO_LED_DATA_SHIFT_FLAG),
> > +                                    10, 200 * USEC_PER_MSEC))
> > +               return -ETIMEDOUT;
> 
> Why is the error code shadowed?
> ret = regmap...
> if (ret)
>   return ret;
> 
> ...
> 
> > +       if (regmap_read_poll_timeout(pc->regmap, AIROHA_PWM_REG_SGPIO_LED_DATA, val,
> > +                                    !(val & AIROHA_PWM_SGPIO_LED_DATA_SHIFT_FLAG),
> > +                                    10, 200 * USEC_PER_MSEC))
> > +               return -ETIMEDOUT;
> 
> Ditto.
> 
> ...
> 
> > +       /* index -1 means disable PWM channel */
> 
> Negative index means
> 
> > +       if (index < 0) {
> 
> > +       }
> 
> ...
> 
> > +static int airoha_pwm_config(struct airoha_pwm *pc, struct pwm_device *pwm,
> > +                            u64 duty_ns, u64 period_ns)
> > +{
> > +       unsigned int hwpwm = pwm->hwpwm;
> > +       int bucket;
> > +
> > +       bucket = airoha_pwm_consume_generator(pc, duty_ns, period_ns,
> > +                                             hwpwm);
> > +       if (bucket < 0)
> > +               return -EBUSY;
> 
> Why is the error code shadowed?
> 
> > +
> > +       airoha_pwm_config_flash_map(pc, hwpwm, bucket);
> > +
> > +       pc->initialized |= BIT_ULL(hwpwm);
> > +       pc->channel_bucket[hwpwm] = bucket;
> > +
> > +       /*
> > +        * SIPO are special GPIO attached to a shift register chip. The handling
> > +        * of this chip is internal to the SoC that takes care of applying the
> > +        * values based on the flash map. To apply a new flash map, it's needed
> > +        * to trigger a refresh on the shift register chip.
> > +        * If we are configuring a SIPO, always reinit the shift register chip
> > +        * to make sure the correct flash map is applied.
> > +        * We skip reconfiguring the shift register if we related hwpwm
> 
> s/we/the/ ?
> 
> > +        * is disabled (as it doesn't need to be mapped).
> > +        */
> > +       if (!(pc->initialized & BIT_ULL(hwpwm)) && hwpwm >= AIROHA_PWM_NUM_GPIO)
> > +               airoha_pwm_sipo_init(pc);
> > +
> > +       return 0;
> > +}
> 
> ...
> 
> > +       if (!(pc->initialized >> AIROHA_PWM_NUM_GPIO))
> > +               regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
> > +                                 AIROHA_PWM_SERIAL_GPIO_FLASH_MODE);
> 
> If you use regmap cache the "initialized" might be not needed at all.
> It might be possible to read back (from the cache) the current state
> of some registers. Have you checked if this is a feasible approach?
> 

The initialized is still needed to understand if a PWM channel has been
provisioned or it's still "dirty" and assigned to a bucket externally to
the kernel (for example by a bootloader)

Also the documentation is not very clear on what is really considered a
volatile register or not so maybe skipping some write might introduce
some unintended regression.

> ...
> 
> > +       /*
> > +        * Duty goes at 255 step, normalize it to check if we can
> 
> "in steps of 255 ns" ?
> The original comment is confusing as step in singular form may mislead.
>

I think you are confused duty is divided in 255 segment so I chencged
this to Duty is divided in 255 segment, normalize it t...

> > +        * share a generator.
> > +        */
> 
> -- 
> With Best Regards,
> Andy Shevchenko

-- 
	Ansuel

