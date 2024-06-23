Return-Path: <linux-pwm+bounces-2591-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA71913E69
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Jun 2024 23:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7029C1C20A76
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Jun 2024 21:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824F41822DB;
	Sun, 23 Jun 2024 21:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ESQBUZsr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D844EB5C;
	Sun, 23 Jun 2024 21:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719176962; cv=none; b=WW66bhMRC4DCxih3CLlV1qeYuTyW87aaoQMEmDZFlLveIi6N07LPi+3AOAXauk8rjd/vp61fBFLUCGPtOW9GI0XbF37UXePBuH1yeVHCz1FfCxOOWU312sP1R+YMwJGVjkNcpkq9bdo/9ZWuz+RGWq1cGxoWqYnmuep2eTlFD/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719176962; c=relaxed/simple;
	bh=JUOWOJa2mEgHrtiKssXmPT3w1FNbH0T1/ltPYlsuKtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyeVJbbpSUTCrCy8g4L4L2dgGliglbOCUMTLKJU3U/iNwJATGV0tqCanf/trR1SzN3NSwuzdiJVwXPXxm1OYcKhm7vykykAMnP/kZQE9Qc5fIbxAm+oWwbimMMR+mMRkcBXd/t+IBqXIV3+NkNlwHvZyIYbgyyeLozFrmXeim10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ESQBUZsr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f9d9b57b90so24091875ad.0;
        Sun, 23 Jun 2024 14:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1719176960; x=1719781760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQoPXw9214oDzH3HcPE6mnrAqPcu+BY9GVtRBF/pzow=;
        b=ESQBUZsresG+ht6KEzmwH5f7y1osvW9WdIxvD0jNOy/jFQ4hee+tgvhHXkmMqe1y0V
         LLCOp7+2zzRlkxLs5B/Dgf+7SUL4Ib1TUVfKPBtUXvY6MXwvpURDEthkZvpB4AklwZUa
         a9KrKxc+69KcVVlh3KOrapXiZAWnHsv2ZDpo7CYiUmEyPYPYs9c65shyRzhnpl9aU87T
         bjRl1E+oihknFCGsyZeaynEevPah71TQ1Kc3bqm6SJS0/SriIjnGCytpCnao0td1AwaJ
         /7DXqnaWAqLLmckmMcPljc4Gk3kVkF1YyKhRXXlKWfv1Ifudseso5zZJaNVYqryg3cVg
         a5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719176960; x=1719781760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQoPXw9214oDzH3HcPE6mnrAqPcu+BY9GVtRBF/pzow=;
        b=PUn7NRHfy74bmbc+us94v8eHYhf7Knsj6IVvGYZECGARlrkBTXHLcWZS5hBfRjyvkx
         QcS9DywZ4aGxb+OWARSFrkB+XmLx9o/f7NaZXFC0VQgwa3zVDwg2mIjDTO9uOxyJ7GNO
         CtbQApPeBlbPujT/5K/YftPAltOwhvqwKF3eoREspR4HGMBz7yf6J+CqXwOlhMnOh9Xc
         i7DfbvvLo+45tIROUTJUn+NGVKzHrB7xFB7ln7qY3z1WgbSa2DzgTA5XJT/yXtfsnpDl
         fK7gOJTy1pB3DXdFcWm6lcuby2hQuVtCYLRnx6h5sZH5NYz6xtjFCAJsIZ4K8kq7JTeF
         HOSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVppLaZclRE0NPad0lwzFNJsGmUJrDgQR1k9H5b8K3HvlfoNOZ33rYKnJF7XaGWPGOPo0qT3JXa+JzpzwRK91lp8eF2bBJ8ItcqEptR
X-Gm-Message-State: AOJu0Yyqn0g3o0k+8aLn9+Kze4CUAdbkHARGO6ujiCN9iuligToxT4kb
	aMzCPjeuyR1QymR5O3p/Ht7L+tSzP1Ye4fwM4VAFxXuM8TdiXcGtrew+slSzY37GW/zvLzsTfo/
	IhVP1c4Jq1DwOV7oUDThqvbNmKyo=
X-Google-Smtp-Source: AGHT+IE8s6BajreEaFuCPHRn1ore5CgUZ1JlAxkrn4Mjw7Qr7ITHvhioA54RGTwslWybiZqYJykwBJZo2NFFwGMb0sE=
X-Received: by 2002:a17:902:dac5:b0:1f6:9181:47ac with SMTP id
 d9443c01a7336-1fa23bd1cf5mr47097765ad.1.1719176959895; Sun, 23 Jun 2024
 14:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622191504.38374-1-martin.blumenstingl@googlemail.com> <s6lapsx6dukr4ebknbbalbhi7232ivxl2apaqtardfi6f2ybbf@zvlhxlngbgx3>
In-Reply-To: <s6lapsx6dukr4ebknbbalbhi7232ivxl2apaqtardfi6f2ybbf@zvlhxlngbgx3>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 23 Jun 2024 23:09:08 +0200
Message-ID: <CAFBinCANKBcttSEhc_0-+D0G3fO0CV67R41y-C7xEwhAXtA+LA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] regulator: pwm-regulator: Make assumptions about
 disabled PWM consistent
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	broonie@kernel.org, lgirdwood@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Uwe,

On Sun, Jun 23, 2024 at 11:32=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello Martin,
>
> On Sat, Jun 22, 2024 at 09:15:04PM +0200, Martin Blumenstingl wrote:
> > Generally it's not known how a disabled PWM behaves. However if the
> > bootloader hands over a disabled PWM that drives a regulator and it's
> > claimed the regulator is enabled, then the most likely assumption is
> > that the PWM emits the inactive level. This is represented by duty_cycl=
e
> > =3D 0 even for .polarity =3D=3D PWM_POLARITY_INVERSED.
>
> I'd write: "This is represented by duty_cycle =3D 0 independent of the
> polarity."
That makes things easier - I'll apply this, thank you!

> > Change the implementation to always use duty_cycle =3D 0, regardless of
> > the polarity. Also update the code so it keeps a copy of the pwm_state
> > around. Both of these changes result in the fact that the logic from
> > pwm_regulator_init_boot_on() is much less complex and can be simplified
> > to a point where the whole function is not needed anymore.
>
> In my (German) ear the following sounds a bit nicer:
>
>         Both of these changes reduce the complexity of
>         pwm_regulator_init_boot_on() to a point where the whole function
>         is not needed anymore.
Sounds fine to my (German) ear as well - thanks!

> > Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> > Changes from v1 [0] (which was sent by Uwe):
> > - keep the struct pwm_state around to prevent a regression on Meson8b
> >   Odroid-C1 boards where just calling pwm_enable() without adjusting
> >   the duty_cycle to 0 would hang the board
> > - I'm actively looking for input on the commit description and
> >   suggestions whether/why Fixes tags should be applied
>
> Apart of the nitpicking above, I like the commit description.
>
> Regarding a Fixes tag: I'm unsure if without this patch, the
> pwm-regulator driver is broken for your Odroid-C1 board. It's not,
> right?
> I think I wouldn't add a Fixes tag and just consider this patch a
> cleanup then.
My Odroid-C1 works fine with and without this patch.
Only the patch that you found previously which you wanted to improve
is required (and reverting it breaks boot).

[...]
> > -     ret =3D pwm_apply_might_sleep(drvdata->pwm, &pstate);
> > -     if (ret) {
> > -             dev_err(&rdev->dev, "Failed to configure PWM: %d\n", ret)=
;
> > +     ret =3D pwm_regulator_apply_state(rdev, &pstate);
> > +     if (ret)
> >               return ret;
> > -     }
>
> If you drop the local variable pstate and just do
>
>         pwm_set_relative_duty_cycle(drvdata->pwm_state,
>                                 drvdata->duty_cycle_table[selector].dutyc=
ycle, 100);
>
> you might get a mismatch between actual configuration and
> drvdata->pwm_state if pwm_regulator_apply_state() fails, but I think
> that doesn't matter and simplifies the code a bit. (Drop the assignment
> in pwm_regulator_apply_state() then.)
If you're fine with this potential mismatch (I am - I just was unsure
about potential side-effects) then you're right: this is an
improvement!

> >       drvdata->state =3D selector;
> >
> > @@ -115,17 +129,26 @@ static int pwm_regulator_list_voltage(struct regu=
lator_dev *rdev,
> >  static int pwm_regulator_enable(struct regulator_dev *dev)
> >  {
> >       struct pwm_regulator_data *drvdata =3D rdev_get_drvdata(dev);
> > +     struct pwm_state pstate =3D drvdata->pwm_state;
> >
> >       gpiod_set_value_cansleep(drvdata->enb_gpio, 1);
> >
> > -     return pwm_enable(drvdata->pwm);
> > +     pstate.enabled =3D true;
> > +
> > +     return pwm_regulator_apply_state(dev, &pstate);
> >  }
> >
> >  static int pwm_regulator_disable(struct regulator_dev *dev)
> >  {
> >       struct pwm_regulator_data *drvdata =3D rdev_get_drvdata(dev);
> > +     struct pwm_state pstate =3D drvdata->pwm_state;
> > +     int ret;
> > +
> > +     pstate.enabled =3D false;
> >
> > -     pwm_disable(drvdata->pwm);
> > +     ret =3D pwm_regulator_apply_state(dev, &pstate);
> > +     if (ret)
> > +             return ret;
>
> With that part I'm a bit unhappy. You don't know what the pwm does when
> disabled (it might yield a 100% relative duty cycle). So the safe bet is
> to use .enabled=3Dtrue, .duty_cycle=3D0 here.
>
> The only code that "knows" if it's safe to disable the PWM is the
> lowlevel pwm driver.
Here I don't know the regulator framework enough. Let's make two assumption=
s:
1. the optimization you suggest is implemented (I'm not against it,
it's just different from what pwm_disable() does)
2. regulator core does not expect the set voltage to change in a
.disable() callback

In that case disabling the PWM output is fine. Since we're now
updating the cached pwm_state with duty_cycle =3D 0 the next time the
regulator core calls the .enable() callback (without calling
.set_voltage() between disabling and enabling) we end up enabling the
PWM output with duty_cycle =3D 0 (and thus likely changing the voltage
output).
I see three options here:
- my assumption about the regulator core is incorrect, then your
optimization works just fine
- we only write enabled =3D false to the cached pwm_state but not duty_cycl=
e =3D 0
- we drop the suggested optimization here (and maybe let PWM core handle th=
is)

What do you think?


Best regards,
Martin

