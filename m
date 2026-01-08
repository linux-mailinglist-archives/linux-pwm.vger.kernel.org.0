Return-Path: <linux-pwm+bounces-7877-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1ABD03A77
	for <lists+linux-pwm@lfdr.de>; Thu, 08 Jan 2026 16:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9541A30650BE
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Jan 2026 14:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15D23FB6BE;
	Thu,  8 Jan 2026 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7SrnItk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE7D3FB6B1;
	Thu,  8 Jan 2026 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767871994; cv=none; b=py5f+C6MNOaWWG+NUNYMoQs24TVgWldZp8fs4ZTGGVhUnxABhtOrD+Be9EWY2KIztIGhp43ZmYYHw70X79NgaZVCcdD0xplP7lcj8Z//9Wa1OuWPOqGxJzga9gqM0SpdF68Q+sYAGozAq4Lnw6FwUG0p0ajIMKePkpVfuO9/7f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767871994; c=relaxed/simple;
	bh=eN+QfHQIO7Pse9zFJrI5udW/vP/pjvyOhr608oKx/xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1efUls6Ekkf8tmTJZ+Ljc+ZzdntuMSP+PCrslCPMf+pFwKxWv5gla9uMEMtPHxRWbNnxfigjx+PmpQCatYjyxHaiOSlaSeZp+MHGIRaa1zchPVKngyC5qtXs6iWOn1gk9xIQ7b57NE3wzxR65RqBUjEqOds5q0iny9DzSSC4l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7SrnItk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314D1C116C6;
	Thu,  8 Jan 2026 11:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767871993;
	bh=eN+QfHQIO7Pse9zFJrI5udW/vP/pjvyOhr608oKx/xE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S7SrnItkrXMW/9y7kgKPBTdzC3zvrTpBlT+uGAUUqkdczSAZtVWZDNYG+HFEjN1hC
	 i6yasWk5CBt7/D7lXRUzRnpKnVS1QY9xThGc6+2MRr1+cCxOImMlevNXp+Bdv1LJ8l
	 VrBhumfkttUS27cxjIm4SUBaXqdw8tORe3AEtYRxJ46tFH19SG4RLAaWp9vgyANBBE
	 8dRZ59FLmfrpDoswZz2Fiy3mr4Q+y6a8QouPbuCMjfRMqLJHCcdih2LVEYvy0sRhIQ
	 o3sjRJUi4s6wHL1WL0Ydozt3QqEg1wgZqeXMOZLqjfgGs3zn+yIv6RxxD93cLBTKCQ
	 Bj/UTHltTnI4Q==
Date: Thu, 8 Jan 2026 12:33:10 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pwm: stm32: handle polarity change when PWM is enabled
Message-ID: <r2jq72u3hfxrl4slgvuei2eobke37apebf67naxrvuabtcvaxe@pamwe3nejqge>
References: <20260106-stm32-pwm-v1-1-33e9e8a9fc33@geanix.com>
 <kemjjoyrhqglqq4p2j6kygspevq2mdbiujtnksw4rkdapoqcfy@zte2c7fhqvn3>
 <2e2iahbzcepbzwgk7xeta2afxmycfjgv2zofzngqjvp4on46r2@mzpi4bz4uqie>
 <nwhixocvhii27jvcyg7ex5emewntgfhyxa4ds5vo2dphe7xfe4@ibjsjdd5fgmn>
 <fwaodg2ovh7j47ifwjhgeppxs3oiqht5ecbs7bmfbi7j6djejs@shwokpcmutr3>
 <zj2vpruzoeyvyyzxiqcffajyhpmem4q75l6gzgxd4jgaizhrdq@bxuudn4kyvr3>
 <paj3uf6apunonvfz2w2anqmddivjrofmfo5wktygz4r6l7diqf@7gen7gjgyuar>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ljhznkytnrzlaroq"
Content-Disposition: inline
In-Reply-To: <paj3uf6apunonvfz2w2anqmddivjrofmfo5wktygz4r6l7diqf@7gen7gjgyuar>


--ljhznkytnrzlaroq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: stm32: handle polarity change when PWM is enabled
MIME-Version: 1.0

Hello Sean,

On Thu, Jan 08, 2026 at 06:44:06AM +0000, Sean Nyekjaer wrote:
> I hope that clarifies things :)

It does. I'm convinced the following patch implements a simpler fix:

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index eb24054f9729..86e6eb7396f6 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -458,8 +458,7 @@ static int stm32_pwm_apply(struct pwm_chip *chip, struc=
t pwm_device *pwm,
 		return 0;
 	}
=20
-	if (state->polarity !=3D pwm->state.polarity)
-		stm32_pwm_set_polarity(priv, pwm->hwpwm, state->polarity);
+	stm32_pwm_set_polarity(priv, pwm->hwpwm, state->polarity);
=20
 	ret =3D stm32_pwm_config(priv, pwm->hwpwm,
 			       state->duty_cycle, state->period);

While is isn't optimal as it might write the polarity into hardware when
it's not necessary, the same holds true for the values for duty_cycle
and period. Compared to your patch this is simple enough to make me ok
with applying it to 6.12.x (and older stable kernels) without an
equivalent commit in mainline. (Backporting the waveform stuff is out of
the question IMNSHO.)

Also I'm still convinced that 7edf7369205b isn't the correct commit to
blame. This one changes the preconditions for the problem to occur (and
thus it's plausible that it's the result of your bisection), but even
before 7edf7369205b the problem can happen with:

	pwm_apply(mypwm, &(struct pwm_state){ .enabled =3D true, .polarity =3D PWM=
_POLARITY_NORMAL, .period =3D DC, .duty_cycle =3D DC });
	pwm_apply(mypwm, &(struct pwm_state){ .enabled =3D false, .polarity =3D PW=
M_POLARITY_INVERSED, .period =3D DC, .duty_cycle =3D DC });
	pwm_apply(mypwm, &(struct pwm_state){ .enabled =3D true, .polarity =3D PWM=
_POLARITY_INVERSED, .period =3D DC, .duty_cycle =3D DC });

After the 1st call polarity is configured to normal (unless the bug
happens already earlier :-), the 2nd disables the hardware without
configuration of the polarity (before and after 7edf7369205b), and the
third skips setting of the polarity because state->polarity already
matches pwm->state.polarity. The original problem exists since=20
7edf7369205b ("pwm: Add driver for STM32 plaftorm").

Are you able to create an improved patch with these insights in a timely
manner? (Grab authorship for yourself and honoring my part with a
Co-developed-by is fine for me.)

Best regards
Uwe

--ljhznkytnrzlaroq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlflfQACgkQj4D7WH0S
/k4B2gf+PoC8z8k72vsHufO9Z7qQK5OMzg07sEh4DjJoeiewN8LS7MctFtQ7J7Ks
zt9/t+w7ZAqegx3cgW46IDW661WTZ8OJujP6dTP/O/AYf/FoCdp1K626zZyzHlti
bue/YEiVrIcoG5H4ZzOdPukpcYnSUymzaOfbN/+LaBfCVZXnc5y1jbzvHX/7lyMs
s3+O6tnUw0f1IK4wIvmT49+IJLG727SJwE0isdneut6AERJSumdOM3JnGkciS7yW
49EZ23jWg+FwM+N68mtMXU4EN75utI2oV9N0aKapEUFv7cCSLVC5H6v5Mwpt9pPx
mSZNakd34IxbYeawv5NZ96J/OmAPcg==
=Gl20
-----END PGP SIGNATURE-----

--ljhznkytnrzlaroq--

