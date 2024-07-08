Return-Path: <linux-pwm+bounces-2719-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA26E929DEB
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 10:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3231C220CE
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 08:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8354647A7C;
	Mon,  8 Jul 2024 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsrMJJtl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AFD42077;
	Mon,  8 Jul 2024 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425756; cv=none; b=I3ynW4wiyXoGqNBAMzJ5uxKdeCSLGhPYAyhLxbwrswoiOeXWzpBWHftL+4W+5AEev4VW33XwmV/9s2LYj1oTP35GGtH/daodjCgYQTw0HBrr8UURfOpGsJzcz33Q3zUo3tc30GCYbBUQTi2fs0nfjPQc2Qnu65Pzm/Q+K6HzYg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425756; c=relaxed/simple;
	bh=Smn35D3Urq1dL6eArlH9BksmlutF3HaujZCbhRCwPYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IeIn+DH3j/KRPTAmVpd/hXOxHW7UszGxomnl3ehW/LFko+H74AjmkxmZPzl1RUEp2uq8qxfRCc6WQ2xv3fNUMRW8CHusAr4ZuMKlbrREdm6H3cjRK/dpGjJNUFXDjprWI/59bgrgZTwjNqXTp5UNBAw/PuwjXaLzBmXt5LjRhgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsrMJJtl; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-651815069f8so37912847b3.1;
        Mon, 08 Jul 2024 01:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720425754; x=1721030554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnUJXLI7onPeWNT8Sri44kaKBGSVFl++mRtuBP0oMGc=;
        b=KsrMJJtlfdSGQ0vmLMJhHSbVE+Wp8Z1jwkJtMx4taOO/gS26g0NM2K18+fsaFVCrQF
         WSrHa6RLlfqoP9a+UDfoFqTSRJHsGMj/N1WDMdiwL6/fBZFcpSLVitM7ujjYxGf4QvLO
         juCMldahhKufCtvmYOnMeUzOEBb8OGDZRIRmLQ+9ObDlLQC6VHtRkqPPof6bxJZQUEk7
         NspfQOjybUj+PGoyeH3wr1w5Fa6i0nnB7cbcnnESFaAM2FmseiUrojZFshBUBtRogiXY
         d8SDCNserMU0LY/UkzMNmB+jFfD45ReFBSwGvo7/Y88st6VBKqTfaVgMyl1ENuyR5dBC
         tqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720425754; x=1721030554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnUJXLI7onPeWNT8Sri44kaKBGSVFl++mRtuBP0oMGc=;
        b=M+Abb4/T2rN+rcjhodDOCLPIVwMRRYeak9HwhDoG6dMghCbxV7YZ+qb0tnrtRKMv3f
         v3Ycvlo4Wi9WqlwC06EvVG4ysFFt4nLB9br/Rz8umuYG8Mw3j02pYpSk4FSPUYfqukLy
         3v+U1DyN2XjiSMll6UVZhbZvKGhwnc/c0vhN3OwwARtwbMAGFpGPnUcTfiYN5Mksi2Jd
         9T3PZMPgch/IGwDLZIJXRyYxhiUHq70PxeNNQ+zG1IuNZrwHPqrazZgwIIg1+FuaRnrJ
         Sujf2sxVkg77nYBJCOuMxXv5leBQzrT4JcJpsqyzwzqr6E2WmnINt+y6TNyN1TgtJnuS
         CD3g==
X-Forwarded-Encrypted: i=1; AJvYcCWao7BIkdpMkBvMzpA1U5Je0GNP1rfRFN981rFWxgrUmPZcxhAe78RTmXO4MxC/2Lxwe93w5iqdCqgOxohuO//ffpSLCjmwsKH0nKZo+PRWgiNPSWS4jmU7HJFN4grw+8Ma2lEdxg==
X-Gm-Message-State: AOJu0YxqlR+L1+W4y2rG67gAdZRpfjgMJDTswKvZ8Tksw/UjMW6G+E7P
	ray7vL8WpLSK0JVIEQnlgmhAcSJP0jtgWPZslfdpK5nKwPkW3P2Eyc001FYHFVFoA8wfJ7n++pU
	scoKHg0mFXj7CZejQQqtyGRd8AAU=
X-Google-Smtp-Source: AGHT+IHfSZZgZbF8fKQiw2cru844TM/1c4izl/IQt3n/HD30lRfRxTDxWk1M0trVUDtLTmcxkIh8/Vg/yzKTFU9oU8s=
X-Received: by 2002:a81:b65d:0:b0:61a:e979:427e with SMTP id
 00721157ae682-652f6317d13mr67350957b3.11.1720425753615; Mon, 08 Jul 2024
 01:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716795485.git.zhoubinbin@loongson.cn> <23d08fa45237efd83cb9dd51a259e2c980f01b3f.1716795485.git.zhoubinbin@loongson.cn>
 <b2lyte7dtrdxxoj4rwwrxbt5myc3td7v3psus7h36qc7dp3thh@czfp25bferl4>
 <CAMpQs4Lo55VhFCNKFxjdA2zMt8GdMTo4sn4BXdy8Nr+kq2OfvQ@mail.gmail.com> <2mrfd5qe742zxz4mxd64jiwiebuvqnlxo5ezbikk77f6eh6rnw@ebc3uxneij5m>
In-Reply-To: <2mrfd5qe742zxz4mxd64jiwiebuvqnlxo5ezbikk77f6eh6rnw@ebc3uxneij5m>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Mon, 8 Jul 2024 14:02:20 +0600
Message-ID: <CAMpQs4JXy4dP6O3cnYmuSq+cb0BazfoncDOxUBe09qY-XB0Qjw@mail.gmail.com>
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

On Sat, Jul 6, 2024 at 9:25=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello Binbin,
>
> On Sat, Jul 06, 2024 at 03:08:30PM +0600, Binbin Zhou wrote:
> > Hi Uwe:
> >
> > Thanks for your reply.
> >
> > On Sat, Jul 6, 2024 at 5:26=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@baylibre.com> wrote:
> > >
> > > Hello,
> > >
> > > On Mon, May 27, 2024 at 03:51:12PM +0800, Binbin Zhou wrote:
> > > > +static int pwm_loongson_apply(struct pwm_chip *chip, struct pwm_de=
vice *pwm,
> > > > +                           const struct pwm_state *state)
> > > > +{
> > > > +     int ret;
> > > > +     u64 period, duty_cycle;
> > > > +     bool enabled =3D pwm->state.enabled;
> > > > +
> > > > +     period =3D min(state->period, NANOHZ_PER_HZ);
> > > > +     duty_cycle =3D min(state->duty_cycle, NANOHZ_PER_HZ);
> > > > +
> > > > +     if (state->polarity !=3D pwm->state.polarity) {
> > > > +             if (enabled) {
> > > > +                     pwm_loongson_disable(chip, pwm);
> > > > +                     enabled =3D false;
> > > > +             }
> > > > +
> > > > +             ret =3D pwm_loongson_set_polarity(chip, pwm, state->p=
olarity);
> > > > +             if (ret)
> > > > +                     return ret;
> > > > +     }
> > > > +
> > > > +     if (!state->enabled) {
> > > > +             if (enabled)
> > > > +                     pwm_loongson_disable(chip, pwm);
> > > > +             return 0;
> > > > +     }
> > >
> > > Given that the configured polarity isn't relevant for a disabled PWM,=
 I
> > > suggest to swap these two if blocks. However then you have to be a bi=
t
> > > more careful for the polarity check because otherwise the following
> > > series of commands yields wrong results:
> > >
> > >         pwm_apply_might_sleep(pwm, {.duty_cycle =3D D, .period =3D P,=
 .polarity =3D PWM_POLARITY_NORMAL, .enabled =3D true});
> > >         pwm_apply_might_sleep(pwm, {.duty_cycle =3D D, .period =3D P,=
 .polarity =3D PWM_POLARITY_INVERSED, .enabled =3D false});
> > >         pwm_apply_might_sleep(pwm, {.duty_cycle =3D D, .period =3D P,=
 .polarity =3D PWM_POLARITY_INVERSED, .enabled =3D true});
> > >
> >
> > Yes, we'd better make sure pwm is enabled first.
> > I will swap the two if blocks.
> >
> > > > +     ret =3D pwm_loongson_config(chip, pwm, duty_cycle, period);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     if (!enabled)
> > > > +             ret =3D pwm_loongson_enable(chip, pwm);
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static int pwm_loongson_get_state(struct pwm_chip *chip, struct pw=
m_device *pwm,
> > > > +                               struct pwm_state *state)
> > > > +{
> > > > +     u32 duty, period, ctrl;
> > > > +     struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(ch=
ip);
> > > > +
> > > > +     /* duty_cycle =3D ddata->duty * NSEC_PER_SEC / ddata->clk_rat=
e */
> > > > +     duty =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_DUTY);
> > > > +     state->duty_cycle =3D mul_u64_u64_div_u64(duty, NSEC_PER_SEC,=
 ddata->clk_rate);
> > > > +
> > > > +     /* period =3D ddata->period * NSEC_PER_SEC / ddata->clk_rate =
*/
> > > > +     period =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_PERIOD)=
;
> > > > +     state->period =3D mul_u64_u64_div_u64(period, NSEC_PER_SEC, d=
data->clk_rate);
> > > > +
> > > > +     ctrl =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
> > > > +     state->polarity =3D (ctrl & LOONGSON_PWM_CTRL_INVERT) ? PWM_P=
OLARITY_INVERSED :
> > > > +                       PWM_POLARITY_NORMAL;
> > > > +     state->enabled =3D (ctrl & LOONGSON_PWM_CTRL_EN) ? true : fal=
se;
> > > > +
> > > > +     return 0;
> > >
> > > You didn't test extensively with PWM_DEBUG enabled, right? You need t=
o
> > > round up the divisions here otherwise you get strange rounding result=
s:
> > >
> > > Consider ddata->clk_rate =3D 1594323. When a state with .period =3D 2=
0000 is
> > > applied, LOONGSON_PWM_REG_PERIOD is assigned 31.
> > > Calling .get_state() in this situation gives .period =3D 19443. Reapp=
lying
> > > .period =3D 19443 results in LOONGSON_PWM_REG_PERIOD :=3D 30. Iterati=
ng this
> > > further yields:
> > >
> > >  - .period =3D 18816
> > >  - LOONGSON_PWM_REG_PERIOD :=3D 29
> > >  - .period =3D 18189
> > >  - LOONGSON_PWM_REG_PERIOD :=3D 28
> > >  - ...
> > >
> > Yes, I'm very sorry I didn't do extensive testing with PWM_DEBUG enable=
d.
> > Here I do need to use DIV64_U64_ROUND_UP().
> >
> > Below:
> >
> >         /* duty_cycle =3D ddata->duty * NSEC_PER_SEC / ddata->clk_rate =
*/
> >         duty =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_DUTY);
> >         state->duty_cycle =3D DIV64_U64_ROUND_UP((u64)duty *
> > NSEC_PER_SEC, ddata->clk_rate);
> >
> >         /* period =3D ddata->period * NSEC_PER_SEC / ddata->clk_rate */
> >         period =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_PERIOD);
> >         state->period =3D DIV64_U64_ROUND_UP((u64)period * NSEC_PER_SEC=
,
> > ddata->clk_rate);
> >
> >
> > I'd also like to ask which tests I still need to do to make sure the
> > driver is more complete?
>
> There is no official lower limit on tests. But the goal is that your
> driver behaves correctly and some of the typical errors can be catched
> by enabling PWM_DEBUG and then doing the following tests for sensible
> values of A and B:
>
>         # Sequence of increasing periods
>         for period in A ... B:
>                 configure 0/period
>
>         # Sequence of decreasing periods
>         for period in A ... B:
>                 configure 0/(B + A - period)
>
>         for period in some set:
>                 # Sequence of increasing duty length
>                 for duty_cycle in 0 ... period:
>                         configure duty_cycle/period
>
>                 # Sequence of decreasing duty length
>                 for duty_cycle in 0 ... period:
>                         configure (period - duty_cycle)/period
>
> That should give you a good coverage.

Thanks for your advice.
I would use this approach to test extensively, trying to make sure
there are no typical errors.

Thanks.
Binbin
>
> The idea of extensive testing on your side is also: Review capacities
> are a scarce resource and you suffer from that because it takes some
> patience between you sending a patch and a maintainer coming around to
> review it. If your code is well tested, there is less for the
> maintainers to find and so I save time because there are less revisions
> and they mature quicker. The direct consequence for you and the others
> waiting for my attention should be obvious. (This also means: If you
> look into other's patch submissions and point out the things you already
> learned to them, you also save maintainer time and so might get their
> attention earlier yourself.)
>
> I'm working on a bigger change for the pwm subsystem. One of the results
> will be a new userspace API. I intend to create a test program that does
> the above tests, so in the foreseeable future testing should get easier.
> (In return writing a lowlevel driver will become a bit harder, as the
> requirements for precision increase.)
>
> Best regards
> Uwe

