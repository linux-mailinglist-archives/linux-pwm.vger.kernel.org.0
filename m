Return-Path: <linux-pwm+bounces-9341-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JXxkLwpONmok9QYAu9opvQ
	(envelope-from <linux-pwm+bounces-9341-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 20 Jun 2026 10:23:38 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC0B6A8928
	for <lists+linux-pwm@lfdr.de>; Sat, 20 Jun 2026 10:23:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QhWzyPom;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9341-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9341-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BEC33011A40
	for <lists+linux-pwm@lfdr.de>; Sat, 20 Jun 2026 08:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFC6340411;
	Sat, 20 Jun 2026 08:23:35 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE251A7264
	for <linux-pwm@vger.kernel.org>; Sat, 20 Jun 2026 08:23:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781943815; cv=pass; b=CNfl4DpihHHM5UErEF0E25u/YRE9LBFlSlhkoZgDeDcD/p6JTDkPWFQ1i6xiejArriR5micHvjQBoODcI6BjK0XBxR5ifbVaWNOf90d77FV8YksF7WL6eV/NEmnn+JyGfm1LZyJNwxp6mDkj4heDI1xUma736TIBjC8KuM4Rbdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781943815; c=relaxed/simple;
	bh=LDovPSnQ3veV3h5328gLJi2Vuj/Qda4DzTBo9JSmBzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qh4Bbrf8UlurJpn67K4CblwT9SQifzWq3eV+lwMjoxsPEQ0P/5PyqhYf87/SNb1MED1hreq3MnYshrB+n461Ckll8b/GVdtdNviGTKwPmzZzydfz8CpX5HnCjnY2itBGMt0ZHMw261tQ/ZPNxE3cYfUzHnK/60TWDA3TFVAM7qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhWzyPom; arc=pass smtp.client-ip=209.85.208.169
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3997a6196c5so19074691fa.0
        for <linux-pwm@vger.kernel.org>; Sat, 20 Jun 2026 01:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781943813; cv=none;
        d=google.com; s=arc-20240605;
        b=DD+2XTqbpv+euUkCnp8LoY6T3um932f1hRrWjj69EHLgMNgDAzIoWyY5cVqmRXET6Y
         +lXNBbVRP/y/XBwvxRDOOapc6FOwUX/yjL/Dp6nKCnS7ifzReFBfY9AYp5+pdeXqwxC2
         fP/QpBhuvZQu28EznPt7NscRswQkkHAPWDeYpcqPdu4VXdVo8y5Zmlde/ynMphiSQO20
         s/RrUv/RO3N1YBNYKTKyNGpaOKxa5ddVbw9Vus1a+0Gr+5JAvQ/Wkf7pFnLaynWmNX7Q
         h3vEHZ58Kfgr8vPq4lJmn6dMwm+TH+mZH+2HBGk1eIPKtgfclam7Ov4xfRTDYIpd7Qnw
         vthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CjttK08oBaSdep52N/CBU9R1ZiQ7romedT5/Se1fBxY=;
        fh=PcD2UmJ88q0iUL5abrF7hrvUQkmwe0KF957HIUHLM+E=;
        b=H8tHzWJSJhQNpT7CwE5h/F2SlOzyV8oshvt1YuQ1OnBtbegnj2SnLve2W750Sj54Kn
         BDjF3eJHf/EbMYNXYhV/VgujE4jxMy6juCFC8xdu3V1/AUfAAX5G4ALxiUMTIsPQytcs
         6fGBTasfe+jXFk8mI/ujj+ntq8cY9VEst0X7GZJtxYaJcZ81sQLYyPlHyKQi2NtVt6Qh
         /+TmR/Ek1xLoU9E0mmVKLcEZ423sUduLoUxahr7mVTF8+SW2IHstPcZ8RX6tYaRjjZB+
         obSbkLxEMPYLixNgmtyJmaef95/JN8ugQDWk/BjlZyvdvGTbAOoIXVPuNiTGZgoBcNXo
         WWcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781943813; x=1782548613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjttK08oBaSdep52N/CBU9R1ZiQ7romedT5/Se1fBxY=;
        b=QhWzyPom+u1W5LZV2OyODnTeqM33Jhx4o2F+SRZV/zHthc7yHwPmazULGbmzZ2Xgl0
         RFjRyUx8KOZqXhwUPeA3diQUhT530QhCm2ckqkJdVl+2ic95Dm0K3+DPRfszjxJFEhr8
         3BuVEPsQ4PZHvxLkOxZ64BhGkip5fegoToDvgjzXPkAf1DAxQCIvE1fB0jupwrHdzwGu
         oUKagG2VBOjplTtotsQb7gauwTfl3H4eLJHxMWRkpxHLW2Sas1za1itSSYtntTTNNkK1
         MrRi5op2ozvpi+eOWkqAyBnkdGiYQwvJUzhJPQgLtjhH2OHLUfdxDsoF2NSKazYx7pr7
         hgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781943813; x=1782548613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CjttK08oBaSdep52N/CBU9R1ZiQ7romedT5/Se1fBxY=;
        b=dEG5F3jAbd84b48K9kv3DbPrykdJi97uiWosTVI1cpwtzNtHvV+dY3z+J2v+SgveA+
         pG0TjLBngMCOI6/zPiDB7P1R3c0ixKM6GbcrJo7d7VpAvkr/Pr4EWzAr9W9NG7gLau5k
         bK50HNVNrDFKEb2gPoQEt1Qr/G/R5rwNc0ECjK7tk1NWsPMz93RirUF6qc+5oOv7Ib7E
         xgTwKR2xKlJmZAv/dPdWjhH8ELkKHgDOs1zaI8WtGolrKLNS27+0grjSnW91/Anoze8X
         R43TI8XIxGWvraIbfBQ2hYLiLpWWxCu9glXEkgP7itKf6sGAeBBzNGmMPJjfGje66xsS
         HQew==
X-Forwarded-Encrypted: i=1; AFNElJ9pNzeiNnm0o5WyiLNozMJovSzXkmNGrTq1k53umAB5EubXqyuyETGA8OOxulul+YudVtxxeLlos64=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj/8vVDkcApFnEwk2vBHol6FlZ93RQq4aZWUxhuheUGmhTaWOW
	bShW/BVpy6F3FnnxWvdJ1uVX6Zy0Gh8Etp8udVbzJH9WI+GobXzXKndyGAfrwzGIi9Fd6E+Dd+I
	FPmasjrhwTvpatolm0p5fPZOheuPFo/mQPEoZZj0=
X-Gm-Gg: AfdE7ckK4MMZhVSFGWhh/xaQIJXTrJyEjmt8RefxMHnbCt06WZSeLZ/ZiwwZpEy85Lj
	UmjppWF/vNApl5C/CUcnTCH/PySYw2NNpgPYg1+1r9PYr9UiPBYsPKhl3+wP4YjgQc3Y8GvDhw2
	E6fdGJfhqiYRB5myy20dHyp/mZpgI+mUQJqshGqO2xA1PprJNDXzlNJ662d1/KHoYCophTyp4Bh
	tNGsa+4NFeu4ZX0457Hyx06286JwJk0kvhk6NkqGQMhfKAk1ryC1TZJhp/RXa31ECnDB6Hfjv96
	DWfgLvs8Ayuf0NYRc+yKis+UaOvHns2G5zZyUXk7ioe6iH10Ga9CxKoLrrIwAWQe2yv1CQ==
X-Received: by 2002:ac2:51d5:0:b0:5ad:49da:6744 with SMTP id
 2adb3069b0e04-5ad562d0e94mr2204603e87.49.1781943812349; Sat, 20 Jun 2026
 01:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616-pwm-loongson-fix-v1-0-491dbf260a7f@gmail.com>
 <20260616-pwm-loongson-fix-v1-1-491dbf260a7f@gmail.com> <ajLDoiFEO_8Y5_1S@monoceros>
In-Reply-To: <ajLDoiFEO_8Y5_1S@monoceros>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Sat, 20 Jun 2026 16:22:55 +0800
X-Gm-Features: AVVi8Cf78LRqrscf4eXrUZADEFoXUG9pvWuHmoZoV6AyWRWyE9YR9u9ii8mNLS4
Message-ID: <CAJhJPsWZptQobeTOORjhMvpX_BWVs8xzh3+L2mr5mZbSbdXYeg@mail.gmail.com>
Subject: Re: [PATCH 1/2] pwm: loongson: Fix low pulse buffer register handling
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9341-lists,linux-pwm=lfdr.de];
	FORGED_SENDER(0.00)[keguangzhang@gmail.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:zhoubinbin@loongson.cn,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[keguangzhang@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BC0B6A8928

On Thu, Jun 18, 2026 at 12:04=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@ke=
rnel.org> wrote:
>
> On Tue, Jun 16, 2026 at 07:13:17PM +0800, Keguang Zhang via B4 Relay wrot=
e:
> > From: Keguang Zhang <keguang.zhang@gmail.com>
> >
> > The Loongson PWM register at offset 0x4 is documented as the Low
> > Pulse Buffer Register, which stores the low pulse width rather than
> > the duty cycle.
> >
> > However, this register was incorrectly defined and treated as a
> > duty-cycle register. As a result, the duty cycle and low pulse cycle
> > are swapped in the generated PWM waveform.
> >
> > Program the low pulse (period - duty) into the register and
> > adjust pwm_loongson_get_state() accordingly when reconstructing the
> > duty cycle.
> >
> > Also return -ERANGE when the requested period exceeds the hardware
> > 32-bit limit instead of silently truncating the value.
>
> This is the intended behaviour.
>
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> >  drivers/pwm/pwm-loongson.c | 29 ++++++++++++++---------------
> >  1 file changed, 14 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
> > index 31a57edecfd0..dc77f82fd888 100644
> > --- a/drivers/pwm/pwm-loongson.c
> > +++ b/drivers/pwm/pwm-loongson.c
> > @@ -22,6 +22,7 @@
> >   */
> >
> >  #include <linux/acpi.h>
> > +#include <linux/bitfield.h>
> >  #include <linux/clk.h>
> >  #include <linux/device.h>
> >  #include <linux/init.h>
> > @@ -33,10 +34,12 @@
> >  #include <linux/units.h>
> >
> >  /* Loongson PWM registers */
> > -#define LOONGSON_PWM_REG_DUTY                0x4 /* Low Pulse Buffer R=
egister */
> > +#define LOONGSON_PWM_REG_LOW         0x4 /* Low Pulse Buffer Register =
*/
> >  #define LOONGSON_PWM_REG_PERIOD              0x8 /* Pulse Period Buffe=
r Register */
> >  #define LOONGSON_PWM_REG_CTRL                0xc /* Control Register *=
/
> >
> > +#define LOONGSON_PWM_MAX_PERIOD              GENMASK(31, 0)
> > +
> >  /* Control register bits */
> >  #define LOONGSON_PWM_CTRL_REG_EN     BIT(0)  /* Counter Enable Bit */
> >  #define LOONGSON_PWM_CTRL_REG_OE     BIT(3)  /* Pulse Output Enable Co=
ntrol Bit, Valid Low */
> > @@ -118,20 +121,16 @@ static int pwm_loongson_enable(struct pwm_chip *c=
hip, struct pwm_device *pwm)
> >  static int pwm_loongson_config(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> >                              u64 duty_ns, u64 period_ns)
> >  {
> > -     u64 duty, period;
> > +     u64 low, period;
> >       struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> >
> > -     /* duty =3D duty_ns * ddata->clk_rate / NSEC_PER_SEC */
> > -     duty =3D mul_u64_u64_div_u64(duty_ns, ddata->clk_rate, NSEC_PER_S=
EC);
> > -     if (duty > U32_MAX)
> > -             duty =3D U32_MAX;
> > -
> > -     /* period =3D period_ns * ddata->clk_rate / NSEC_PER_SEC */
> >       period =3D mul_u64_u64_div_u64(period_ns, ddata->clk_rate, NSEC_P=
ER_SEC);
> > -     if (period > U32_MAX)
> > -             period =3D U32_MAX;
> > +     if ((!FIELD_FIT(LOONGSON_PWM_MAX_PERIOD, period)))
> > +             return -ERANGE;
>
> As noted above, this is wrong. If period is too big, you're supposed to
> pick the biggest possible period and not return an error.
>

Understood. However, in this case the difference between the requested
and actual
period can become quite significant. Returning success means userspace
may assume the requested configuration was applied while the generated
waveform is substantially different.

Wouldn't returning an error be preferable in such cases, as it makes the
hardware limitation visible to userspace instead of silently applying a
different configuration?

> > +
> > +     low =3D mul_u64_u64_div_u64(period_ns - duty_ns, ddata->clk_rate,=
 NSEC_PER_SEC);
>
> this is also wrong. You're supposed to pick a configuration where the
> duty is the biggest not bigger than the requested value. However as
> mul_u64_u64_div_u64 rounds down, you're rounding in the wrong direction.
>
Thanks for pointing this out.
I'll change it to mul_u64_u64_div_u64_roundup().

> The register layout suggests that the period starts with the inactive
> part, did you reverify that?
>
Yes, I reverified it on hardware.

The PWM period indeed starts with the inactive (low) phase. However,
with the current driver implementation, configuring a duty_cycle
results in a low phase width of duty_cycle and an active phase width of
(period - duty_cycle), meaning the requested duty_cycle is interpreted
as the inactive phase width rather than the active phase width.

> Best regards
> Uwe



--
Best regards,

Keguang Zhang

