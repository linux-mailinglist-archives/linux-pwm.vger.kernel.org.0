Return-Path: <linux-pwm+bounces-7878-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EA9D03E05
	for <lists+linux-pwm@lfdr.de>; Thu, 08 Jan 2026 16:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00658304D548
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Jan 2026 15:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAD24A50C9;
	Thu,  8 Jan 2026 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="M4oCYYR0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94DD4A1A9E
	for <linux-pwm@vger.kernel.org>; Thu,  8 Jan 2026 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767874240; cv=none; b=VUQlXjT5kOU8bMeGDgAcDVRuH0qbYBQxZ1wytMIcTvl1UGFfZLm2D5/OZGtMJNxaNnmM5CRl8oWpgK0iSn+jjkHwpxihy15qpq6PK/scM31RZuThYlUX/LU901doo/minfk41uye71H7lrtZuZ2p/mzwhPKZBAiFpciGPVS2u9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767874240; c=relaxed/simple;
	bh=FE5f+QneiLfkB+gsfq9DOycQ8EkGDZ8mWOYLDEug3U8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7Boa/SVfzN2X9VhRl1jz4/U2b99kWGBgs6/NcU+WJROyqzaJupmnVmRrJx1wdd01+HCkiInVTynhJZk46RD6Ms6B/jfiVjVS21n48KDvhdQjXLzYy1HvWQxwHultu8/C7sGhKeX+nVL4fxNUfVh6h1j5PMVHigN3PaLbDgnq8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=M4oCYYR0; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1767874226; x=1768133426;
	bh=e9Gn14IpojzvUVrHWdXmzVkyL12/O34BYkSCNxkLXBk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=M4oCYYR05LjR1zuWmGDLY2NUDmgqoA0Gs7RIIA+jsPfvKLSztQWtPWNrCFHINJfCA
	 HFXOvt9td6Rtbae2jI34iZADjK26DfHt8wMZYngw2WqA3QgjgtfA19ixm0AiMX/5nA
	 GspzkdlI2oqkssw84nB6a2pxOpT2syKFjRd0aJl9DbkXW7oyDKLBpLkG6GSnJQdLvd
	 msN4snaag7B79uKVpGOK3aKfLCmTgMGoX7I7FpmPlQQkcc6S9udkPEMDy/cBtMjrhQ
	 1mg2gUajN4kAVQonHK1UpGoTOzGMTbko1kMlPnvL+3RYZaFymnmkO+XYQJ9Sr1ye5u
	 Mtj7TEkdLVBMA==
Date: Thu, 08 Jan 2026 12:10:22 +0000
To: =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pwm: stm32: handle polarity change when PWM is enabled
Message-ID: <scu6yj7say5bnhbgyns4xrjbrzdayckk2ghn2a4xsgg4dswakv@6ushlcfw4dju>
In-Reply-To: <r2jq72u3hfxrl4slgvuei2eobke37apebf67naxrvuabtcvaxe@pamwe3nejqge>
References: <20260106-stm32-pwm-v1-1-33e9e8a9fc33@geanix.com> <kemjjoyrhqglqq4p2j6kygspevq2mdbiujtnksw4rkdapoqcfy@zte2c7fhqvn3> <2e2iahbzcepbzwgk7xeta2afxmycfjgv2zofzngqjvp4on46r2@mzpi4bz4uqie> <nwhixocvhii27jvcyg7ex5emewntgfhyxa4ds5vo2dphe7xfe4@ibjsjdd5fgmn> <fwaodg2ovh7j47ifwjhgeppxs3oiqht5ecbs7bmfbi7j6djejs@shwokpcmutr3> <zj2vpruzoeyvyyzxiqcffajyhpmem4q75l6gzgxd4jgaizhrdq@bxuudn4kyvr3> <paj3uf6apunonvfz2w2anqmddivjrofmfo5wktygz4r6l7diqf@7gen7gjgyuar> <r2jq72u3hfxrl4slgvuei2eobke37apebf67naxrvuabtcvaxe@pamwe3nejqge>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 65182a408632275be51d6c5397e4a1b9201fdc8e
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,
On Thu, Jan 08, 2026 at 12:33:10PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Jan 08, 2026 at 06:44:06AM +0000, Sean Nyekjaer wrote:
> > I hope that clarifies things :)
>=20
> It does. I'm convinced the following patch implements a simpler fix:
>=20
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index eb24054f9729..86e6eb7396f6 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -458,8 +458,7 @@ static int stm32_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  =09=09return 0;
>  =09}
> =20
> -=09if (state->polarity !=3D pwm->state.polarity)
> -=09=09stm32_pwm_set_polarity(priv, pwm->hwpwm, state->polarity);
> +=09stm32_pwm_set_polarity(priv, pwm->hwpwm, state->polarity);
> =20
>  =09ret =3D stm32_pwm_config(priv, pwm->hwpwm,
>  =09=09=09       state->duty_cycle, state->period);
>=20
> While is isn't optimal as it might write the polarity into hardware when
> it's not necessary, the same holds true for the values for duty_cycle
> and period. Compared to your patch this is simple enough to make me ok
> with applying it to 6.12.x (and older stable kernels) without an
> equivalent commit in mainline. (Backporting the waveform stuff is out of
> the question IMNSHO.)

The above does work, I have also checked that it doesn't write the
polarity if the PWM is active.
Agree, with the backporting part :)

>=20
> Also I'm still convinced that 7edf7369205b isn't the correct commit to
> blame. This one changes the preconditions for the problem to occur (and
> thus it's plausible that it's the result of your bisection), but even
> before 7edf7369205b the problem can happen with:
>=20
> =09pwm_apply(mypwm, &(struct pwm_state){ .enabled =3D true, .polarity =3D=
 PWM_POLARITY_NORMAL, .period =3D DC, .duty_cycle =3D DC });
> =09pwm_apply(mypwm, &(struct pwm_state){ .enabled =3D false, .polarity =
=3D PWM_POLARITY_INVERSED, .period =3D DC, .duty_cycle =3D DC });
> =09pwm_apply(mypwm, &(struct pwm_state){ .enabled =3D true, .polarity =3D=
 PWM_POLARITY_INVERSED, .period =3D DC, .duty_cycle =3D DC });
>=20
> After the 1st call polarity is configured to normal (unless the bug
> happens already earlier :-), the 2nd disables the hardware without
> configuration of the polarity (before and after 7edf7369205b), and the
> third skips setting of the polarity because state->polarity already
> matches pwm->state.polarity. The original problem exists since=20
> 7edf7369205b ("pwm: Add driver for STM32 plaftorm").
>=20
I will move the fixes tag.

> Are you able to create an improved patch with these insights in a timely
> manner? (Grab authorship for yourself and honoring my part with a
> Co-developed-by is fine for me.)
I'll do it now and add the Co-developd-by tag

/Sean


