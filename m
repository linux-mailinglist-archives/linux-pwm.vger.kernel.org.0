Return-Path: <linux-pwm+bounces-4859-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C99A31335
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 18:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0362318820A3
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 17:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C704F261571;
	Tue, 11 Feb 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQlZOWgk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B95626156B;
	Tue, 11 Feb 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295397; cv=none; b=FmnMHOwiYvrrUR27OLo8G8kwk9mhTkhOBdynKgyFEhDsq1FI7ufHA4WB8Ez4NR4HGuApyc3fb26QAKvnoMTGLf5x105iYzUCss6WLmveFqedeJlTfkw89pEdMxoiUYY9Uo5Bwl55cHCh0QPJStKHSAIkVDpgx+fbo/C2zpbmNVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295397; c=relaxed/simple;
	bh=Z8cAlzmQ1FTJmGopWB95RkiWwb0zduDpc5Os2YBQPZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExQOf91Vc2CYwkBPbSs+fdl5VrRaEcxj6FOBJEz0polK/UcHhwtOwy0L7recCUA0ItgFEF7dS+uoMKWDnEeLAoygYwm3x9sbs0SCDpXvuw/dsksa/Qyn3G20zGupol+U+QXbVk879pwhvDNaW1oVRLtOQy9kDZosllST2xjmpOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQlZOWgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62637C4CEE5;
	Tue, 11 Feb 2025 17:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739295397;
	bh=Z8cAlzmQ1FTJmGopWB95RkiWwb0zduDpc5Os2YBQPZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQlZOWgktTHln7uPuJ6cl+fwkOsl5KKL5vv8GzrWKDRF9NvEF1rGpDVEBHtMUfJcl
	 1Uo+CpaUnz5/VMRBUQcjcuvvbPx5WOf8EnrxfIJrvHx/HrwskJKLNs8mcy0w62IvLG
	 mPVSYxAiwj4oAXIolUPR51qCcYTkiSeN2MM/Lxh7ydk2ADb1Pfnufu8MNnyrhfwLa3
	 ZD4lv3ZBJ8P/pDdPn0udRD0UMzIQ90YP2/cqH/wNCeYlg44u4VUUVhnk9wuGTWwgex
	 iErRELOSktWMgQJ1iJxw2wvRdl/wopG4PE9cYXtfKMb+D2jwqbrxUQO00/JbXYxIF2
	 lo9qC9VQoKZyg==
Date: Tue, 11 Feb 2025 18:36:34 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, 
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [PATCH v8 2/2] pwm: Add Loongson PWM controller support
Message-ID: <vyth3k4smtsp4qvbkugi7vkhaqii3gysgjmenzhl27iy74fy6w@rleajhaork2j>
References: <cover.1733823417.git.zhoubinbin@loongson.cn>
 <be76165d1ab09ec41cdfd4e5fbdae1b415f516b9.1733823417.git.zhoubinbin@loongson.cn>
 <obegtfup7f6w6erh4arubk2fkk2wrcum5frs5kbqa4uniexmr5@6uti3d3hv7np>
 <CAMpQs4+nVSorAeR92F22T5dnzyh1h4BDR6UqrZbTSUhEyWbGyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qdnv7nwtvr5bumy6"
Content-Disposition: inline
In-Reply-To: <CAMpQs4+nVSorAeR92F22T5dnzyh1h4BDR6UqrZbTSUhEyWbGyA@mail.gmail.com>


--qdnv7nwtvr5bumy6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 2/2] pwm: Add Loongson PWM controller support
MIME-Version: 1.0

Hello,

On Tue, Feb 11, 2025 at 02:02:03PM +0600, Binbin Zhou wrote:
> On Tue, Feb 11, 2025 at 12:26=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@=
kernel.org> wrote:
> > On Tue, Dec 10, 2024 at 08:37:06PM +0800, Binbin Zhou wrote:
> > > +static int pwm_loongson_suspend(struct device *dev)
> > > +{
> > > +     struct pwm_chip *chip =3D dev_get_drvdata(dev);
> > > +     struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip=
);
> > > +
> > > +     ddata->lss.ctrl =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_=
CTRL);
> > > +     ddata->lss.duty =3D pwm_loongson_readl(ddata, LOONGSON_PWM_REG_=
DUTY);
> > > +     ddata->lss.period =3D pwm_loongson_readl(ddata, LOONGSON_PWM_RE=
G_PERIOD);
> > > +
> > > +     clk_disable_unprepare(ddata->clk);
> > > +
> > > +     return 0;
> >
> > Is this needed assuming that before suspend the consumer stopped the
> > PWM?
>=20
> Actually, I don't quite understand the problem you're pointing out. It
> seems to me that the register and clk operations are required
> regardless of the state of the pwm.
> At least from the experimental results, the logic is now as expected.
> Of course, I may be missing some critical information.

When a PWM goes into suspend it's expected that its consumer already
disabled it.

Until I come around to do that properly in the core for all drivers, I
think the right approach in a driver is:

	for (i =3D 0; i < chip->npwm; ++i) {
		if (chip->pwms[i].state.enabled)
			return -EBUSY;
	}

and if you then know that all PWMs are disabled, maybe you don't need to
store all the registers you did in pwm_loongson_suspend()?

Best regards
Uwe

--qdnv7nwtvr5bumy6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmerip8ACgkQj4D7WH0S
/k5c6wgAlB03Ww2DaE0f/GhgIEQK0amvkBzFmTSH1rolSm/RhX6cECAt1ysGO97P
N8bzQvvODFcWNGcQ40B6bdwDfDE9WNKICyWjuJsKlszXQD+OvdhtlxHwVGeCAucr
7IjcHzguUM4oyZTRemyA6+ocNV0nzf/+LCqX4pBbq11ogTdo2taWH2iZltFGCQ0B
c/9CMmRtJ74goG4G8OMGdcoLdzZbZq792FKiNZgxPyapxoIiEtiPxHSIrKsT4wHh
h6CVRy4B/gdSN3X9RBoMt89beGeXoLX8f8AouFeU63MwHJWFtkQffyZIwGlKkyyP
DXsh9hp7m5V4Boamj/0v9lFXGwNi6g==
=tLNJ
-----END PGP SIGNATURE-----

--qdnv7nwtvr5bumy6--

