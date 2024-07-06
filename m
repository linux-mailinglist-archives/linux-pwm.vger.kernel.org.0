Return-Path: <linux-pwm+bounces-2715-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160D6929225
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Jul 2024 11:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066AC1C20A67
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Jul 2024 09:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CF24C3D0;
	Sat,  6 Jul 2024 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hatvtp5e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3BC481DB;
	Sat,  6 Jul 2024 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720256925; cv=none; b=ca1C4NEA5pI8jzEDJ2KNpJ8FdI+NRQfLt3Q+ND75pQ2Z4sCMbcGM/s/uE4aQKqyMHTUl6BLiUNN407MNpGmbyxOhYvxca0sT1vtJFlGVZF00spIK0YTncjxpRMm2CSiRDMggw8s8SfNR0HtmItWIo1b3pl3MMznOFXdKxHZmllY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720256925; c=relaxed/simple;
	bh=fG6F3w5XsMlqbqQaRKmHuITZUAA7HSkYvoR9erwN8ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSNx9wrrxRSNg5G7+yHtwFJuiMGY33ug94bubYMunrr+aw02B+XMA2+bMmG0mHLsEFuUrntfsPyyaj7gB2km5ROSYAka+9mFVtdd0xD2SrORjYb/yzL6LiwSF6chzNa67J0wPGWTJj6S+MqnsIs/Z+U9zA5NgnK6uihDK9J8IS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hatvtp5e; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e03618fc78bso2258295276.2;
        Sat, 06 Jul 2024 02:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720256923; x=1720861723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvNcPTmqNxB21weQxooRmeGNUZ7Ly0Y/MJ1ArZkMpmU=;
        b=hatvtp5e5IuBFYo90EVklyxKOa9diqQfJwN28tHuqw84x4psONTlzhSaSIhIxTneu5
         QeYYsoSG09TZxEvn1Z6XB0MWNzOXye7/2kFaBu5tZ3qXealY6JtNBjFQdRFZEIUr8gZp
         VAMR8bjTfwBQfzXrMLNCEsUUQkVUqwB6vl6lGTheOPOsDg9QoFtSEo563Gg38AwNMoGZ
         +CEyZLDVKGOixZROgkkyoK5I3qPqBRfGY/g9t1zdNc+v/wLAmSnDUeDUlani52ZOmVB5
         FvAIDZe3nfuxZTo3yPQA4fwtvXJkd5UvqY2KnQ6iinm/YzzupbIlue22necpE0aXa3uD
         rk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720256923; x=1720861723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvNcPTmqNxB21weQxooRmeGNUZ7Ly0Y/MJ1ArZkMpmU=;
        b=wVyo7rpAhLdmhCjYlVVbkbN0T5/ArG7IceqOvaTplOZn1oa+1mgZIV5Ycqupi4hzix
         EFSyWVuFrqwWjewYrB+yJpaHf5jHpLiEeLhAqqkhosWs+jWPkO4Rw1he2OKAgwl9xJkW
         Kbr6NlE+UD/0x1WzjlbgzT3Ad0dZ2tuYNr48UJqtLxVpmNsu3lhjxDKmKuG0ARNzd/ML
         P5hQaMN5eigC8ugGUU0bFTIbPY2SEPXRIZLVBKzZi7VVWB7veQL7xejCoYOPNJbk2/W8
         yeH4FEBNUE1cjvdOYOgjcPJJDEtZpz0+HoN18CL8DGhS3kgSwuHVqRYpNGKaxvx3qrIU
         s3uw==
X-Forwarded-Encrypted: i=1; AJvYcCWvmJzpAA+f2c48To5heqTljn8D7A4hqOK9rhuPQvS3opKIDeSU7l32thZMV5jwn+bTLuwMOZw77TTg7wrodxEtBj/kuxbuwk+0MBMeo7G+ZOi/C4fUVy/3Dr9EYuRMnjKdpIUXIA==
X-Gm-Message-State: AOJu0Yz6VIm4272vVuBT6Nw4H2bA9GQoeUdALchwq7MyhhQztXaglXdf
	rIcbxSi+mzEIO9w1HLxPxPLtyugte/ZSYZX2BtKe5N/RmJsRCKy2AnHqUQCdgWTQ3MKJrcVTWDj
	VKi89SEkPk+z1iZzInNvI/oqrZCs=
X-Google-Smtp-Source: AGHT+IFE3DfCqBS0dBLUuf7e4wOAB+PSbhsnQbFKEqOsySRZmgtE3ogKqcORJbpXpQ7hTP37DJbqioZiEMx0ltxd/Eo=
X-Received: by 2002:a25:c70e:0:b0:e03:abdc:f2a0 with SMTP id
 3f1490d57ef6-e03c1a05b56mr6735108276.60.1720256922772; Sat, 06 Jul 2024
 02:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716795485.git.zhoubinbin@loongson.cn> <23d08fa45237efd83cb9dd51a259e2c980f01b3f.1716795485.git.zhoubinbin@loongson.cn>
 <b2lyte7dtrdxxoj4rwwrxbt5myc3td7v3psus7h36qc7dp3thh@czfp25bferl4>
In-Reply-To: <b2lyte7dtrdxxoj4rwwrxbt5myc3td7v3psus7h36qc7dp3thh@czfp25bferl4>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Sat, 6 Jul 2024 15:08:30 +0600
Message-ID: <CAMpQs4Lo55VhFCNKFxjdA2zMt8GdMTo4sn4BXdy8Nr+kq2OfvQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] pwm: Add Loongson PWM controller support
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	loongson-kernel@lists.loongnix.cn, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe:

Thanks for your reply.

On Sat, Jul 6, 2024 at 5:26=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Mon, May 27, 2024 at 03:51:12PM +0800, Binbin Zhou wrote:
> > +static int pwm_loongson_apply(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> > +                           const struct pwm_state *state)
> > +{
> > +     int ret;
> > +     u64 period, duty_cycle;
> > +     bool enabled =3D pwm->state.enabled;
> > +
> > +     period =3D min(state->period, NANOHZ_PER_HZ);
> > +     duty_cycle =3D min(state->duty_cycle, NANOHZ_PER_HZ);
> > +
> > +     if (state->polarity !=3D pwm->state.polarity) {
> > +             if (enabled) {
> > +                     pwm_loongson_disable(chip, pwm);
> > +                     enabled =3D false;
> > +             }
> > +
> > +             ret =3D pwm_loongson_set_polarity(chip, pwm, state->polar=
ity);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     if (!state->enabled) {
> > +             if (enabled)
> > +                     pwm_loongson_disable(chip, pwm);
> > +             return 0;
> > +     }
>
> Given that the configured polarity isn't relevant for a disabled PWM, I
> suggest to swap these two if blocks. However then you have to be a bit
> more careful for the polarity check because otherwise the following
> series of commands yields wrong results:
>
>         pwm_apply_might_sleep(pwm, {.duty_cycle =3D D, .period =3D P, .po=
larity =3D PWM_POLARITY_NORMAL, .enabled =3D true});
>         pwm_apply_might_sleep(pwm, {.duty_cycle =3D D, .period =3D P, .po=
larity =3D PWM_POLARITY_INVERSED, .enabled =3D false});
>         pwm_apply_might_sleep(pwm, {.duty_cycle =3D D, .period =3D P, .po=
larity =3D PWM_POLARITY_INVERSED, .enabled =3D true});
>

Yes, we'd better make sure pwm is enabled first.
I will swap the two if blocks.

> > +     ret =3D pwm_loongson_config(chip, pwm, duty_cycle, period);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (!enabled)
> > +             ret =3D pwm_loongson_enable(chip, pwm);
> > +
> > +     return ret;
> > +}
> > +
> > +static int pwm_loongson_get_state(struct pwm_chip *chip, struct pwm_de=
vice *pwm,
> > +                               struct pwm_state *state)
> > +{
> > +     u32 duty, period, ctrl;
> > +     struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> > +
> > +     /* duty_cycle =3D ddata->duty * NSEC_PER_SEC / ddata->clk_rate */
> > +     duty =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_DUTY);
> > +     state->duty_cycle =3D mul_u64_u64_div_u64(duty, NSEC_PER_SEC, dda=
ta->clk_rate);
> > +
> > +     /* period =3D ddata->period * NSEC_PER_SEC / ddata->clk_rate */
> > +     period =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_PERIOD);
> > +     state->period =3D mul_u64_u64_div_u64(period, NSEC_PER_SEC, ddata=
->clk_rate);
> > +
> > +     ctrl =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
> > +     state->polarity =3D (ctrl & LOONGSON_PWM_CTRL_INVERT) ? PWM_POLAR=
ITY_INVERSED :
> > +                       PWM_POLARITY_NORMAL;
> > +     state->enabled =3D (ctrl & LOONGSON_PWM_CTRL_EN) ? true : false;
> > +
> > +     return 0;
>
> You didn't test extensively with PWM_DEBUG enabled, right? You need to
> round up the divisions here otherwise you get strange rounding results:
>
> Consider ddata->clk_rate =3D 1594323. When a state with .period =3D 20000=
 is
> applied, LOONGSON_PWM_REG_PERIOD is assigned 31.
> Calling .get_state() in this situation gives .period =3D 19443. Reapplyin=
g
> .period =3D 19443 results in LOONGSON_PWM_REG_PERIOD :=3D 30. Iterating t=
his
> further yields:
>
>  - .period =3D 18816
>  - LOONGSON_PWM_REG_PERIOD :=3D 29
>  - .period =3D 18189
>  - LOONGSON_PWM_REG_PERIOD :=3D 28
>  - ...
>
Yes, I'm very sorry I didn't do extensive testing with PWM_DEBUG enabled.
Here I do need to use DIV64_U64_ROUND_UP().

Below:

        /* duty_cycle =3D ddata->duty * NSEC_PER_SEC / ddata->clk_rate */
        duty =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_DUTY);
        state->duty_cycle =3D DIV64_U64_ROUND_UP((u64)duty *
NSEC_PER_SEC, ddata->clk_rate);

        /* period =3D ddata->period * NSEC_PER_SEC / ddata->clk_rate */
        period =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_PERIOD);
        state->period =3D DIV64_U64_ROUND_UP((u64)period * NSEC_PER_SEC,
ddata->clk_rate);


I'd also like to ask which tests I still need to do to make sure the
driver is more complete?

> > +}
> > +
> > +static const struct pwm_ops pwm_loongson_ops =3D {
> > +     .apply =3D pwm_loongson_apply,
> > +     .get_state =3D pwm_loongson_get_state,
> > +};
> > +
> > +static int pwm_loongson_probe(struct platform_device *pdev)
> > +{
> > +     int ret;
> > +     struct pwm_chip *chip;
> > +     struct pwm_loongson_ddata *ddata;
> > +     struct device *dev =3D &pdev->dev;
> > +
> > +     chip =3D devm_pwmchip_alloc(dev, 1, sizeof(*ddata));
> > +     if (IS_ERR(chip))
> > +             return PTR_ERR(chip);
> > +     ddata =3D to_pwm_loongson_ddata(chip);
> > +
> > +     ddata->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(ddata->base))
> > +             return PTR_ERR(ddata->base);
> > +
> > +     if (!has_acpi_companion(dev)) {
> > +             ddata->clk =3D devm_clk_get_enabled(dev, NULL);
> > +             if (IS_ERR(ddata->clk))
> > +                     return dev_err_probe(dev, PTR_ERR(ddata->clk),
> > +                                          "failed to get pwm clock\n")=
;
> > +             ddata->clk_rate =3D clk_get_rate(ddata->clk);
> > +     } else {
> > +             ddata->clk_rate =3D LOONGSON_PWM_FREQ_STD;
> > +     }
> > +
> > +     chip->ops =3D &pwm_loongson_ops;
> > +     dev_set_drvdata(dev, chip);
> > +
> > +     ret =3D devm_pwmchip_add(dev, chip);
> > +     if (ret < 0) {
> > +             clk_disable_unprepare(ddata->clk);
>
> This is wrong. You aquired the clk using devm_clk_get_enabled(), so you
> don't need (and must not) care for disable.
>
Sorry, I had some misunderstanding about devm_clk_get_enabled(), I will fix=
 it.

Thanks.
Binbin
> > +             return dev_err_probe(dev, ret, "failed to add PWM chip\n"=
);
> > +     }
> > +
> > +     return 0;
> > +}
>
> Best regards
> Uwe

