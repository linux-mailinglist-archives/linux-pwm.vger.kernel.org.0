Return-Path: <linux-pwm+bounces-7956-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D0249D3C23B
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 09:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D6C124A6C07
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 08:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8B7362127;
	Tue, 20 Jan 2026 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bh6c965q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B6C265CDD;
	Tue, 20 Jan 2026 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897424; cv=none; b=XCfrrKD6XwUNgdIy9j+nrfFmcbfBlT7S6zUoyCzA6p8n8DXwvLSoe6Kug7BzwD6c0KI4l1wpLU4hIo6AqQ02WHtxbVTfu/ZYStr7TxAayetYjt4xVmdDIE0sbzq+0EzaQ+SRVb6Z22ifSgIreiCuuKvrb8NW2SewQ8U6bo4kF0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897424; c=relaxed/simple;
	bh=hr0lPmnuadTKLpZYy/UxlSAi8W+IlNQyEnI8GVmekw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mb+wPfatfheg6OKpLjG0QPsQG9v78DvAhEYWCcKBYdH83qSd2diXceHdVsAbNSM4ZkDnAjDaXL/OUxBRtM03jlbRhQwjyxqwraIiuce5P2jjC5NHiNNlS41dJBku0ja7W6ZRjZUntu0Rko05WC1IzhKQNRpoZ0P27NggxHNUWXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bh6c965q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D36FC16AAE;
	Tue, 20 Jan 2026 08:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768897423;
	bh=hr0lPmnuadTKLpZYy/UxlSAi8W+IlNQyEnI8GVmekw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bh6c965qDuYeciIkYgqHr6o1z2D1neykGNaNVld5Tq4TAgLNi+hkGORfM5ZGpEJ+F
	 jDTqFvQ14QLe+hyY9ofENGMhQt9hqCyB3knM5gZHakrvdXnuD5NJgEziZcLGQcUcTg
	 RtnN05++jq+dXrpcNu5CcbSb1tSm0J9e5ExykMxBvhsYQj4A/N4JjdIwnjewOW/ovo
	 JRqDGhGsXwwFSygokQdAT2wLrndl1sPM2Yf4M6FJ5amdokw97HBBZm5wykXIY4qYM4
	 3bh80v20dM7vk6zNCdIjmVmQgzDsyGevBnDOZUwgDgslz5+HxJcErXXfLmPXGM59mx
	 Dyx9BGv8gtyTQ==
Date: Tue, 20 Jan 2026 09:23:40 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Gokul Praveen <g-praveen@ti.com>
Cc: "Kumar, Udit" <u-kumar1@ti.com>, 
	"Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>, j-keerthy@ti.com, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, n-francis@ti.com
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before
 setting configuration
Message-ID: <5ncoro6nmu4yoqniijjah3hernt7rigmmz6sjjzxcbbyzzpz5a@2einaw7lox32>
References: <60da27d5-5d85-4fbe-9b18-b7e74f9ab893@ti.com>
 <hjiyxkzimydqjrtte6r5kemfthwdmhtkysplsptm3npgwqiv4b@d6vlu2fhks37>
 <575bfd8e-9246-4acf-ba76-8d5a84689643@ti.com>
 <xdj2ceubkss3ingkxdvc64zqrcd3wzz2uxa6wqwgvilu2ykukc@hbn6tt2gnxj5>
 <741ec8db-7804-4f31-969b-10724ec06823@ti.com>
 <hvz5lw4xvujmdruoi2h2wk4dvanyg7y5xp5tp2rs4dygmza3s3@idcjbz6wbxh4>
 <29dc86d5-080c-4af2-8e19-99a137c55f2f@ti.com>
 <xkhyvqemt7ox6s3kcwjx2qktwlrvdo2dbn2azlk6tdimjvclky@g3btsovrn5am>
 <80a2c59a-fe7a-4244-a374-bfc70dc46978@ti.com>
 <77e5712b-e1f9-4fb7-85df-45e1ade6a8eb@ti.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pfq2qpuuldhwa7ms"
Content-Disposition: inline
In-Reply-To: <77e5712b-e1f9-4fb7-85df-45e1ade6a8eb@ti.com>


--pfq2qpuuldhwa7ms
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before
 setting configuration
MIME-Version: 1.0

Hello,

On Tue, Jan 20, 2026 at 11:23:54AM +0530, Gokul Praveen wrote:
> On 20/01/26 10:10, Kumar, Udit wrote:
> > On 1/20/2026 3:03 AM, Uwe Kleine-K=F6nig wrote:
> > > I doesn't look good to me, it's way to complicated. Unless I still
> > > misunderstand something, I think
> > >=20
> > > diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> > > index 7a86cb090f76..4942689105f3 100644
> > > --- a/drivers/pwm/pwm-tiehrpwm.c
> > > +++ b/drivers/pwm/pwm-tiehrpwm.c
> > > @@ -378,6 +378,8 @@ static int ehrpwm_pwm_apply(struct pwm_chip
> > > *chip, struct pwm_device *pwm,
> > > =A0=A0=A0=A0=A0 int err;
> > > =A0=A0=A0=A0=A0 bool enabled =3D pwm->state.enabled;
> > > +=A0=A0=A0 guard(pm_runtime_active)(pwmchip_parent(chip));
> > > +
> >=20
> >=20
> > Fair point,=A0 only need i see to keep in hardware active state after
> > dropping count at
> >=20
> > https://elixir.bootlin.com/linux/v6.18.6/source/drivers/pwm/pwm-
> > tiehrpwm.c#L293

Yes, with my suggested change you can drop ehrpwm_pwm_config() grabbing
and releasing the pm_runtime reference making the whole change:

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 7a86cb090f76..2533c95b0ba9 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -237,8 +237,6 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, str=
uct pwm_device *pwm,
 	if (period_cycles < 1)
 		period_cycles =3D 1;
=20
-	pm_runtime_get_sync(pwmchip_parent(chip));
-
 	/* Update clock prescaler values */
 	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CLKDIV_MASK, tb_divval);
=20
@@ -290,8 +288,6 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, str=
uct pwm_device *pwm,
 	if (!(duty_cycles > period_cycles))
 		ehrpwm_write(pc->mmio_base, cmp_reg, duty_cycles);
=20
-	pm_runtime_put_sync(pwmchip_parent(chip));
-
 	return 0;
 }
=20
@@ -378,6 +374,8 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
 	int err;
 	bool enabled =3D pwm->state.enabled;
=20
+	guard(pm_runtime_active)(pwmchip_parent(chip));
+
 	if (state->polarity !=3D pwm->state.polarity) {
 		if (enabled) {
 			ehrpwm_pwm_disable(chip, pwm);

> The above changes looks simpler than the one I had sent earlier.
> Shall I send a v3 patch with these updated changes, if it is okay for you,
> Uwe.

I guess that's the only thing that brings us forward, and as I cannot
reproduce the issue but you can, yes please.

Best regards
Uwe

--pfq2qpuuldhwa7ms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlvO4MACgkQj4D7WH0S
/k7jUwf+Lu+4imtAUqw8GuHgjCB6xS5SL+bJ0fmZ88k/z+Z4Raugc/SCclNBeCwp
5l6C3bHYgGvuKzNJjMGOcP3an7vKy6LWRRxamY4Q6SEN4eCq82xiLnQRzU3vwLhT
JuGrvvsf+HmoO/Ig7l8vTNhbjI65YclP54IKsDnrog8ZLlSSjOZ1lrX2B3A1of7P
p6OKn9TMRfvnr8IkXH/nXx3dP/usTAOHvtPzc7+Ta8eGLGtpC4jCyRAgzKSBK4L9
clDGm5j+1xcpuVDs/qP/M40I4HQu7jgTd80H4K3V6SyYED8I1LIhRXJEhQoJQXPT
GSTD2bpkfty/03sN2gKXVP2x4btwKg==
=JEyK
-----END PGP SIGNATURE-----

--pfq2qpuuldhwa7ms--

