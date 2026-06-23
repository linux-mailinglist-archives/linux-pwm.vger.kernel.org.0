Return-Path: <linux-pwm+bounces-9353-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 61vJNANfOmqA7QcAu9opvQ
	(envelope-from <linux-pwm+bounces-9353-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 12:25:07 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6258A6B6411
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 12:25:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="qsW1dk0/";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9353-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9353-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37D533133EA2
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 10:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FF23749F0;
	Tue, 23 Jun 2026 10:19:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D1E375ADD
	for <linux-pwm@vger.kernel.org>; Tue, 23 Jun 2026 10:19:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209972; cv=pass; b=uGSfqyns9BCWRFWZlne+7LcFQcnJQoLqkD3yn5fIrtI2iMWHpNYw3pRFa0Kclv8QX0eVsYPXmkkLF30g9FL7asg6QH0jRkA45WvVndsOlFZttlxnRtO3EcRto/Kjpn59btHkiprdpU5vNChn7zvrcE7u4d95ltnsWmcA3sSHoYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209972; c=relaxed/simple;
	bh=1R1IDe3PUAvZGG3dZakpHALPWHQ9f9I1bDY3du0JMHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixI5TIBCDF/NzBxruaEgsPML5Xuk/pX+V3+Zo6kZ7xRKHc/dFcOOI9u70Be9V+nkmnvZ4PAEFhe9ZkEKTS1286+r0fYllOU4KF9wNLTCE3DchfqN88maRUsJURXXiwhe9Qv++nQ+sYmg/3G6MMY+fA9tS0r9smVx0+PcEslxcqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qsW1dk0/; arc=pass smtp.client-ip=209.85.167.51
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5ad54546171so3390793e87.0
        for <linux-pwm@vger.kernel.org>; Tue, 23 Jun 2026 03:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782209969; cv=none;
        d=google.com; s=arc-20240605;
        b=TNtMFP7j6XCm6pw7axAZn87q0r8UN7Aum4Y4SBsFa7wx0dhfnLaDnnMs5y42DeQ28a
         bW0LQKB4r0LL6drdKhjvWOsw39RCWAF3vcLd02Q9iCZ0FM2WkvGlbd/adZtXUJ1C3tAx
         oV2FAvDn0yafy/McWw94lly1znbq+48jL72QkDhIbo9kKVBKEWTW1qeqUDm5nQlw3qP+
         Ny5VfHDYf9AlCFgwuSuZRZRNR/Sc4g6SLgVw8k1Tz4DURHHlC2SkVkmtVCF5jWPZ+DHh
         LcVBY6JHo06DhTI0oklMuZjWdh/FGuIXPk/G7cDpn2OYhlY8Z04LJwKnwY4lAU+nb124
         jwGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=74GxEW4IZvkDVKoBmrXqwai9WaLDGuhdE5RS+lA2LUE=;
        fh=0/WJvI+1Ze7qG9zNr5AUeaY5wxX8BNQDpIStJQnkgfk=;
        b=NntHGWOB+YovUXxUqIzGoFqK39OXDcuSghqJYlyaB6Wl2OqUj8Q5F2Mbnv4gwsUOnx
         TA2iIFeqW1Z6j9YQW8APjnFGXJzaz3Nv6E/3dCIM8kHnHB4QDFCmx4ttrVQ8kWShNyPF
         UtvpYkFrs2B3KZtS/qQwQvRAxTQqgmv/9UoVSIQMchoa8Brey5QbCu/sUxpEfUwNjIyp
         /VErW8NdEerHUFOzFQXwwmENUd0HnBHGJmXZ9hOJStUD8sY2c5CqCh2PsoIONBKKJhd2
         /GsCumJvnfMxae/bxjNZlVtnCKGj0sHvtfLxujzXkgA2dsjyzn4STBze/HZWhURQCAt8
         Y5KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782209969; x=1782814769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74GxEW4IZvkDVKoBmrXqwai9WaLDGuhdE5RS+lA2LUE=;
        b=qsW1dk0/jY1rObRKNHtEl0BSyUXYtMtqnQEZOWFxyzetLSooY7kBhOr5BWtuvqZYOH
         qn/cRPtEJ7JoWH0UyiRIW/8h5Xe2hDykYWNUakNpCF9bXjSHOU9NqCQxHI2oQTGPn3fn
         3HyL8fIrvkQL4dEkfkUbSQS7pANqKIn+/drfcL5d26elMnH13VB7AGIoVxsYI7feQAsv
         0DGfh8QnfYwU8gK1kLt+xBB7Cld2w7BkvQFPM+yV4328OotYYQJ0BW2xtgUCzHdQhN6k
         NM8aK/VyJWtr0v1rM9f3zHKRyU1gK4DYEx23K1TE0LfdPLgC4U3KF/pEMuADcGqFYbcC
         a/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782209969; x=1782814769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=74GxEW4IZvkDVKoBmrXqwai9WaLDGuhdE5RS+lA2LUE=;
        b=jCsjSK+sd8ZggM9BgXPSrPmaQfiWQrYtfrB2zq59d0+MWQckvMSUmUowfEQYTIGUga
         p6zACP9QYhZm6CmV0oqNRvQQUpkvwfByc8YBbpiC36+X/hOZDT00qj3wboregc5+zvUt
         jU6mHEvwSIA/osTGJZUHibdXrn7jyrvwdGWjpURdC+cMln8OJWLOxGqHJepFoL31nqi7
         hS/SjTyUm0uqPFrHeGXfj8hfEOgDikb/mQ0lUwG+vvgH29wwHXl6dPop9ruQQXYxRc4P
         Om67eilOy7gYuPiCSrcDjI5lsz82M+BNEIQj1qtRyguMtNiT/wVY+n1gbT7FKDR5hMBG
         UaEA==
X-Forwarded-Encrypted: i=1; AFNElJ+WcWxpYfH2ykv86cQujIv7oDrwVtrzgk4yJa+Y38Yv+tDWUuM9CIMTIGimdLKSb9i1mnyPFoJHqi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvFSE0QQGVaGNgFpRwlEWidju9kA2ARB4MqL/ga9EvZpK2DRyf
	Nt1Wb0quJiZ9XDFufXAE+ns7F16MBg3h6lnOlveq7fW4c7JelFtzk5q4MwSAbBORe0dsCQOlYD1
	VETBVegVxOjnOUv4ILmjZZFPqlQK099k=
X-Gm-Gg: AfdE7ck67QqPbPQKP5MKzR6p1Ego0aIRDU//RleGKkNBNvSDrjmag2GYZywZsf64r3T
	KPNVYwUMiXkYm3PXrxQFEd3lvr1oGOtY0Ew814ocYpOqYjtOO4wLlet0VdVvh0u9PexHnJsb8Jf
	tQ+vVUWHgT10XvrEzq1e23q8shuqWeV2LPiJExgwH97SYEdnU6eafvIbUEpDC0PY8vTD2NIDEtQ
	DBrRb6YNmo+HF+GvkoUyPGjRMYkoGfX1EKOm6DNBWH+RELBWi8LSnp6B913B1eEyjkvPL09k2oi
	Ib1I0uZ24myx9O9DWbqPGe2znAVeTs/fcEm65zKslg0nv3ZwhzvmkPF21NRwd14gWUDO5A==
X-Received: by 2002:ac2:4bd3:0:b0:5a8:8db6:b3d with SMTP id
 2adb3069b0e04-5ae3510c66fmr564655e87.24.1782209968981; Tue, 23 Jun 2026
 03:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616-pwm-loongson-fix-v1-0-491dbf260a7f@gmail.com>
 <20260616-pwm-loongson-fix-v1-1-491dbf260a7f@gmail.com> <ajLDoiFEO_8Y5_1S@monoceros>
 <CAJhJPsWZptQobeTOORjhMvpX_BWVs8xzh3+L2mr5mZbSbdXYeg@mail.gmail.com> <ajk5jfEGCAj9QXGO@monoceros>
In-Reply-To: <ajk5jfEGCAj9QXGO@monoceros>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Tue, 23 Jun 2026 18:18:50 +0800
X-Gm-Features: AVVi8CcylutOQL_M6XPKwjiwRmfGPo1kPy5zhyQKBcnjk-FjkAuruIKatWiqU84
Message-ID: <CAJhJPsV3FNWF3ksOZAa=cWTD_3W8HeoxoeGxiN5h5P1w9Yi28g@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-9353-lists,linux-pwm=lfdr.de];
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
X-Rspamd-Queue-Id: 6258A6B6411

On Mon, Jun 22, 2026 at 9:58=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@ker=
nel.org> wrote:
>
> On Sat, Jun 20, 2026 at 04:22:55PM +0800, Keguang Zhang wrote:
> > On Thu, Jun 18, 2026 at 12:04=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleine=
k@kernel.org> wrote:
> > >
> > > On Tue, Jun 16, 2026 at 07:13:17PM +0800, Keguang Zhang via B4 Relay =
wrote:
> > > > From: Keguang Zhang <keguang.zhang@gmail.com>
> > > >
> > > > The Loongson PWM register at offset 0x4 is documented as the Low
> > > > Pulse Buffer Register, which stores the low pulse width rather than
> > > > the duty cycle.
> > > >
> > > > However, this register was incorrectly defined and treated as a
> > > > duty-cycle register. As a result, the duty cycle and low pulse cycl=
e
> > > > are swapped in the generated PWM waveform.
> > > >
> > > > Program the low pulse (period - duty) into the register and
> > > > adjust pwm_loongson_get_state() accordingly when reconstructing the
> > > > duty cycle.
> > > >
> > > > Also return -ERANGE when the requested period exceeds the hardware
> > > > 32-bit limit instead of silently truncating the value.
> > >
> > > This is the intended behaviour.
> > >
> > > > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > > > ---
> > > >  drivers/pwm/pwm-loongson.c | 29 ++++++++++++++---------------
> > > >  1 file changed, 14 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.=
c
> > > > index 31a57edecfd0..dc77f82fd888 100644
> > > > --- a/drivers/pwm/pwm-loongson.c
> > > > +++ b/drivers/pwm/pwm-loongson.c
> > > > @@ -22,6 +22,7 @@
> > > >   */
> > > >
> > > >  #include <linux/acpi.h>
> > > > +#include <linux/bitfield.h>
> > > >  #include <linux/clk.h>
> > > >  #include <linux/device.h>
> > > >  #include <linux/init.h>
> > > > @@ -33,10 +34,12 @@
> > > >  #include <linux/units.h>
> > > >
> > > >  /* Loongson PWM registers */
> > > > -#define LOONGSON_PWM_REG_DUTY                0x4 /* Low Pulse Buff=
er Register */
> > > > +#define LOONGSON_PWM_REG_LOW         0x4 /* Low Pulse Buffer Regis=
ter */
> > > >  #define LOONGSON_PWM_REG_PERIOD              0x8 /* Pulse Period B=
uffer Register */
> > > >  #define LOONGSON_PWM_REG_CTRL                0xc /* Control Regist=
er */
> > > >
> > > > +#define LOONGSON_PWM_MAX_PERIOD              GENMASK(31, 0)
> > > > +
> > > >  /* Control register bits */
> > > >  #define LOONGSON_PWM_CTRL_REG_EN     BIT(0)  /* Counter Enable Bit=
 */
> > > >  #define LOONGSON_PWM_CTRL_REG_OE     BIT(3)  /* Pulse Output Enabl=
e Control Bit, Valid Low */
> > > > @@ -118,20 +121,16 @@ static int pwm_loongson_enable(struct pwm_chi=
p *chip, struct pwm_device *pwm)
> > > >  static int pwm_loongson_config(struct pwm_chip *chip, struct pwm_d=
evice *pwm,
> > > >                              u64 duty_ns, u64 period_ns)
> > > >  {
> > > > -     u64 duty, period;
> > > > +     u64 low, period;
> > > >       struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(ch=
ip);
> > > >
> > > > -     /* duty =3D duty_ns * ddata->clk_rate / NSEC_PER_SEC */
> > > > -     duty =3D mul_u64_u64_div_u64(duty_ns, ddata->clk_rate, NSEC_P=
ER_SEC);
> > > > -     if (duty > U32_MAX)
> > > > -             duty =3D U32_MAX;
> > > > -
> > > > -     /* period =3D period_ns * ddata->clk_rate / NSEC_PER_SEC */
> > > >       period =3D mul_u64_u64_div_u64(period_ns, ddata->clk_rate, NS=
EC_PER_SEC);
> > > > -     if (period > U32_MAX)
> > > > -             period =3D U32_MAX;
> > > > +     if ((!FIELD_FIT(LOONGSON_PWM_MAX_PERIOD, period)))
> > > > +             return -ERANGE;
> > >
> > > As noted above, this is wrong. If period is too big, you're supposed =
to
> > > pick the biggest possible period and not return an error.
> > >
> >
> > Understood. However, in this case the difference between the requested
> > and actual
> > period can become quite significant. Returning success means userspace
> > may assume the requested configuration was applied while the generated
> > waveform is substantially different.
> >
> > Wouldn't returning an error be preferable in such cases, as it makes th=
e
> > hardware limitation visible to userspace instead of silently applying a
> > different configuration?
>
> That sounds good, but doesn't work consistently and without surprises.
>
> Assuming a clk_rate of 24 MHz the maximal period is
>
>         0xffffffff / (24000000 Hz) =3D 178956970625 ns
>
> .
>
> Then with your suggestion implemented (as I understand it) the mapping
> from requested period to actual period looks as follows::
>
>         178956970624 ns -> 178956970583.33334 ns
>         178956970625 ns -> 178956970625 ns
>         ...
>         178956970666 ns -> 178956970625 ns
>         178956970667 ns -> -ERANGE
>
> From the consumer's point of view, how do you motivate that 178956970666
> still works while 178956970667 doesn't? IMHO the only consequent
> implementation then is to let 178956970626 already return an error.
> But then it's surprising again, that when requesting 178956970624 ns
> you get 178956970583.33334 ns on loongson, while for a hardware that has
> 178956970583.33334 ns as its maximal period, it's an error.
>
> That consideration convinced me back then to not return an error for too
> high values, which is the only sane option left then (unless I missed
> something?)
>
> With the waveform API you can query the capabilities and thus prevent
> consumer surprises.
>
Thanks for the detailed explanation.

I will drop the `-ERANGE` change and restore the original behavior
in the next version.

> Best regards
> Uwe



--=20
Best regards,

Keguang Zhang

