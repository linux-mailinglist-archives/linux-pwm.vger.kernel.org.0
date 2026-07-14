Return-Path: <linux-pwm+bounces-9720-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e81ROZ5EVmoe2gAAu9opvQ
	(envelope-from <linux-pwm+bounces-9720-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 16:15:58 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F279755A47
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 16:15:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FTIYMNa7;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9720-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9720-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD67C322B708
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 14:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F13D480974;
	Tue, 14 Jul 2026 14:07:33 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B5E480967;
	Tue, 14 Jul 2026 14:07:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038052; cv=none; b=V28RVHYvsMgJDUUcAbrjPstqm1BYVNlD1FcnF6sWnhqkxlPnul8fSYP6VaisR4dxQED4dBVH+bm3ReJnoiF4hzDFSz31fOtbyRvfJlwURrgUWJIy2GBppbEJjFUOIqzUqJ6jNblO5UiIrovof7e+hvS1Ms520MCOEjrh9gxvtAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038052; c=relaxed/simple;
	bh=E3G5xNEKDTz0OrN3bzAq6Wy0YXH79M66kWpp4gvTbpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oy0Se2QektuvXpShLoNH1LJ9eKsW0/hUeAVeIkuD5cm1Fyoc24i1TS/F9PjI86RqnAwT1KfFnPQwVGYH6MCEQssRavyiQ2M02Tzfe0PKzybxz0aSb9/KtwN8JHNmtkWW/ITUIMrUhONb+qNEF8JlbTW4dN7QsWQ3bhHys/KtMTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTIYMNa7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 894061F000E9;
	Tue, 14 Jul 2026 14:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784038046;
	bh=nxc7WBXciEQorazQv2JDOTT5n2+bXoePoUOXsR4EZI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FTIYMNa7zy+yRYvkzvz39xtBUahWMijuS0IbfQLIIfwlXmRkHZz879R1CY6S9VZLl
	 QTBpEgXTNtfjNRTmi5RCZtF/P6eo/lpZ+4xICh1mM/pwVuHo3B053T9ishAwbrzhu5
	 Ts/p91T2OPkKMSjE6Y0oEo9sfSfKG6n7hJXjqDKKzlgq7frwe+ql7g6M7Ny+1ix9WM
	 Jahu4rcc+ljl1MLy4VhhIhjt3CSQ33sVYanTdBJKTIuEZCyD2AFRQaUU1FuwrR3A7Z
	 OIl2OiShyllFQeycpCxDwWKjNVKObTNDXN8+TA7Ox9x7G2wSx6bZMpAJvGtShTeyHT
	 7s4SA/BTLmnXw==
Date: Tue, 14 Jul 2026 16:07:23 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 4/6] pwm: tegra: Simplify using
 devm_reset_control_get_exclusive_deasserted()
Message-ID: <alZAzcG-2uuTsxxk@monoceros>
References: <cover.1784030076.git.ukleinek@kernel.org>
 <1f12ae7f9479aa910fcaf066fae82c7b7cb89073.1784030076.git.ukleinek@kernel.org>
 <cf1bd92a11661c99802867581b599617ef69f503.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l42umjqts7ahp2rv"
Content-Disposition: inline
In-Reply-To: <cf1bd92a11661c99802867581b599617ef69f503.camel@pengutronix.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:p.zabel@pengutronix.de,m:thierry.reding@kernel.org,m:jonathanh@nvidia.com,m:mperttunen@nvidia.com,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9720-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_FIVE(0.00)[6];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F279755A47


--l42umjqts7ahp2rv
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 4/6] pwm: tegra: Simplify using
 devm_reset_control_get_exclusive_deasserted()
MIME-Version: 1.0

On Tue, Jul 14, 2026 at 02:12:38PM +0200, Philipp Zabel wrote:
> On Di, 2026-07-14 at 14:02 +0200, Uwe Kleine-K=F6nig wrote:
> > This function ensures the reset is already deasserted at probe time and
> > asserted at unbind. So the remove function and the error paths in the
> > probe function can be simplified accordingly.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> > ---
> >  drivers/pwm/pwm-tegra.c | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > index e99e1c5b18c3..d7f4baa4cd9b 100644
> > --- a/drivers/pwm/pwm-tegra.c
> > +++ b/drivers/pwm/pwm-tegra.c
> > @@ -108,7 +108,6 @@ struct tegra_pwm_soc {
> > =20
> >  struct tegra_pwm_chip {
> >  	struct clk *clk;
> > -	struct reset_control*rst;
> > =20
> >  	unsigned long clk_rate;
> >  	unsigned long min_period_ns;
> > @@ -319,6 +318,7 @@ static int tegra_pwm_probe(struct platform_device *=
pdev)
> >  	struct device *dev =3D &pdev->dev;
> >  	struct pwm_chip *chip;
> >  	struct tegra_pwm_chip *pc;
> > +	struct reset_control*rst;
>=20
> You could use this opportunity to add a space between reset_control and
> *rst.

Oh indeed. I thought I called checkpatch, but there are two more
warnings in this series that I'm not aware of, so it seems I didn't
check before sending :-o

> >  	const struct tegra_pwm_soc *soc;
> >  	int ret;
> > =20
> > @@ -391,20 +391,17 @@ static int tegra_pwm_probe(struct platform_device=
 *pdev)
> >  	pc->min_period_ns =3D
> >  	    (NSEC_PER_SEC / (pc->clk_rate / TEGRA_PWM_DEPTH)) + 1;
> > =20
> > -	pc->rst =3D devm_reset_control_get_exclusive(dev, "pwm");
> > -	if (IS_ERR(pc->rst)) {
> > -		ret =3D dev_err_probe(dev, PTR_ERR(pc->rst), "Failed to get reset co=
ntrol\n");
> > +	rst =3D devm_reset_control_get_exclusive_deasserted(dev, "pwm");
> > +	if (IS_ERR(rst)) {
> > +		ret =3D dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset contro=
l\n");
> >  		goto put_pm;
> >  	}
> > =20
> > -	reset_control_deassert(pc->rst);
> > -
> >  	chip->ops =3D &tegra_pwm_ops;
> > =20
> >  	ret =3D pwmchip_add(chip);
> >  	if (ret < 0) {
> >  		dev_err_probe(dev, ret, "Adding pwmchip failed\n");
> > -		reset_control_assert(pc->rst);
>=20
> With this change, pm_runtime_put_sync_suspend() and
> pm_runtime_force_suspend() are called before the reset control is
> asserted again in the error case. Is this safe?

Ah, this is true for pm_runtime_put_sync_suspend(). Too bad this isn't
easily fixable :-\ I would expect this not to be a problem, but given
that I don't have the hardware, I guess being conservative here is
needed.

Thanks for catching this.

Uwe

--l42umjqts7ahp2rv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpWQpkACgkQj4D7WH0S
/k4IaggApNtCtObSgmCp33qZAYG4ljuOGbY+ElTdtZYDd4LA2P8X7M3CodebGbND
BrFlastkoqvc/1dTPy8DmKFZvlxAwtNNqz/HInW+HaaDYUhGoG6Ks5FnuIDcIcR4
jybTXmW2JikqiVOsyg4dgOyBwSaouFqEE3gXTG2wTQppNMY6E2fdael65DtGvnjs
jNig9auoiPZm2JzUkWnPVwi7JEMki+kslNYwEJt1Z8QuETv9EsNPvFI//XgNSXjz
ZSH5UeCmBnsOZ1RP4MGpY2lKactyuVrN8VgbCd+HvCfjK+WOid/UKWcVYMwG7HXw
WzTKEGk4ArHMgYTIPY9WzbZ405Ns8g==
=8zwh
-----END PGP SIGNATURE-----

--l42umjqts7ahp2rv--

