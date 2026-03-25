Return-Path: <linux-pwm+bounces-8354-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG15Add8w2mbrAQAu9opvQ
	(envelope-from <linux-pwm+bounces-8354-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 07:12:39 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 555B5320164
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 07:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 151443006B16
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 06:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99E83382FC;
	Wed, 25 Mar 2026 06:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4YsX9Nt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947128248B;
	Wed, 25 Mar 2026 06:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774419156; cv=none; b=e5Osprhfjk/suFMulXqlMyh9MdZ7okGMmCQ9UYkafIrzxrGtt9XrsbapfkadIVYqe2t8bEI4Xj4qTB60Na21mnQ76HJxDHmipLflXOKjVIoK8fRN/lylJcz7ppJQYifgx7YKzXrfXEM2kEthkUawwHdSJB+FYtdCVTFIjrOpu10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774419156; c=relaxed/simple;
	bh=xstdmZOTq1U4oAsFj5MoDcInVoa2Da6Y31f2uchmnUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZH7/KufVXj5TuG8G9VdQHtOqagO3fWIl2e3DllhE0xnWfN/QnR0wtFetYO0x4k8qAzaiT1OfM+QHnCmYunoAqz2ZvmAvhxnRD+utUCKON4oBGsct3DgLzXxrBh16VmtpmPfjNNfFltiydXr3U/MOYGJXTpgfgpzls1ddqkZVtGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4YsX9Nt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83EAC4CEF7;
	Wed, 25 Mar 2026 06:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774419156;
	bh=xstdmZOTq1U4oAsFj5MoDcInVoa2Da6Y31f2uchmnUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y4YsX9NtZ+XW73B8QkeYanPZi5D7ng6ZzeOA1yc9e5lQ/b7GWVTmTVY+0+/4UWtOr
	 TFQiKdY0j2j9/FDUdtI+xjdTHvfDT1HCOQDRHzvI/HwTHAMRUnzjp8mACieo84eyjv
	 I6mug3p8FzWnzIpN5r58dXxCpb6gIV46DquxGUb6HzUXDHQKgQAtStnVX3KtXYL2p0
	 Vrxg5Kxl/7irHCtA7weMyRxhamZUsLsH50RSTE8FIPTuo7xzrNp8CmxCwUN9S8H64T
	 AVFFJ6wckeU/fhMfC5Qf2RxyUi5kbT/Uff0wiBuAWSSjzFcOc+qPRzILXRUe7T/LYd
	 CAHYILChH5C+A==
Date: Wed, 25 Mar 2026 07:12:33 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/5] pwm: tegra: Avoid hard-coded max clock frequency
Message-ID: <acN7pSjuMkZl2yhV@monoceros>
References: <20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com>
 <20260323-t264-pwm-v1-1-4c4ff743050f@nvidia.com>
 <acKggw9F7oULLEuJ@monoceros>
 <4405239.kQq0lBPeGt@senjougahara>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jyx2ilssaabpedyx"
Content-Disposition: inline
In-Reply-To: <4405239.kQq0lBPeGt@senjougahara>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,vger.kernel.org,kernel.org,ti.com];
	TAGGED_FROM(0.00)[bounces-8354-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,chromium.org:email]
X-Rspamd-Queue-Id: 555B5320164
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--jyx2ilssaabpedyx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] pwm: tegra: Avoid hard-coded max clock frequency
MIME-Version: 1.0

[ Adding OPP maintainers to Cc: ]

Helle Mikko,

On Wed, Mar 25, 2026 at 09:34:55AM +0900, Mikko Perttunen wrote:
> On Wednesday, March 25, 2026 1:45=E2=80=AFAM Uwe Kleine-K=C3=B6nig wrote:
> > On Mon, Mar 23, 2026 at 11:36:37AM +0900, Mikko Perttunen wrote:
> > > @@ -303,7 +300,7 @@ static int tegra_pwm_probe(struct platform_device
> > > *pdev)>=20
> > >  		return ret;
> > >  =09
> > >  	/* Set maximum frequency of the IP */
> > >=20
> > > -	ret =3D dev_pm_opp_set_rate(&pdev->dev, pc->soc->max_frequency);
> > > +	ret =3D dev_pm_opp_set_rate(&pdev->dev, S64_MAX);
> >=20
> > The documentation comment for dev_pm_opp_set_rate() reads:
> >=20
> > 	Device wanting to run at fmax provided by the opp, should have
> > 	already rounded to the target OPP's frequency.
> >=20
> > I think using S64_MAX is technically fine (assuming there are no issues
> > with big numbers in that function), but still it feels wrong to use
> > something simpler than the comment suggests. Am I missing something?
>=20
> Looking at the history of the function, the comment was added in the comm=
it=20
> below. It seems like it used to be that the opp framework always used the=
 fmax=20
> of each OPP even if a lower rate was specified, but after the change, the=
=20
> caller has to specify the fmax rate if they want that rate specifically. =
As=20
> such I don't think it should be an issue in our case, as we're just using=
 the=20
> rate to find an OPP and don't have a specific one in mind.
>=20
> commit b3e3759ee4abd72bedbf4b109ff1749d3aea6f21
> Author: Stephen Boyd <swboyd@chromium.org>
> Date:   Wed Mar 20 15:19:08 2019 +0530
>=20
>     opp: Don't overwrite rounded clk rate
>    =20
>     The OPP table normally contains 'fmax' values corresponding to the
>     voltage or performance levels of each OPP, but we don't necessarily w=
ant
>     all the devices to run at fmax all the time. Running at fmax makes se=
nse
>     for devices like CPU/GPU, which have a finite amount of work to do and
>     since a specific amount of energy is consumed at an OPP, its better to
>     run at the highest possible frequency for that voltage value.
>    =20
>     On the other hand, we have IO devices which need to run at specific
>     frequencies only for their proper functioning, instead of maximum
>     possible frequency.
>    =20
>     The OPP core currently roundup to the next possible OPP for a frequen=
cy
>     and select the fmax value. To support the IO devices by the OPP core,
>     lets do the roundup to fetch the voltage or performance state values,
>     but not use the OPP frequency value. Rather use the value returned by
>     clk_round_rate().
>    =20
>     The current user, cpufreq, of dev_pm_opp_set_rate() already does the
>     rounding to the next OPP before calling this routine and it won't
>     have any side affects because of this change.
>    =20
>     Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>     Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>     [ Viresh: Massaged changelog, added comment and use temp_opp variable
>               instead ]
>     Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

So the comment describing dev_pm_opp_set_rate() needs an update, right?

> > >  	if (ret < 0) {
> > >  =09
> > >  		dev_err(&pdev->dev, "Failed to set max frequency: %d\n",=20
> ret);
> > >  		goto put_pm;
> > >=20
> > > @@ -318,7 +315,7 @@ static int tegra_pwm_probe(struct platform_device
> > > *pdev)>=20
> > >  	/* Set minimum limit of PWM period for the IP */
> > >  	pc->min_period_ns =3D
> > >=20
> > > -	    (NSEC_PER_SEC / (pc->soc->max_frequency >> PWM_DUTY_WIDTH)) + 1;
> > > +	    (NSEC_PER_SEC / (pc->clk_rate >> PWM_DUTY_WIDTH)) + 1;
> >=20
> > Orthogonal to this patch: Should this be
> >=20
> > 	DIV_ROUND_UP(NSEC_PER_SEC, pc->clk_rate >> PWM_DUTY_WIDTH)
> >=20
> > ? Or even
> >=20
> > 	DIV_ROUND_UP(NSEC_PER_SEC < PWM_DUTY_WIDTH, pc->clk_rate);
> >=20
> > ? (Note, the latter doesn't work as is, as the first parameter has an
> > overflow, I guess you're still getting my question.)
>=20
> Indeed, it would be overestimating the minimum period right now. It's not=
=20
> quite part of Tegra264 support but I can include a patch in the next revi=
sion=20
> if you'd like. Otherwise I could include it in the followup series or as =
a=20
> separate patch.

If you know it and feel responsible to address it at some point that's
fine. We lived with that issue for some time now, so a separate and if
you prefer later series is fine for me.

Best regards
Uwe

--jyx2ilssaabpedyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnDfM8ACgkQj4D7WH0S
/k4zMAgAjph1fJZQ6bWy1sM5PS4v3zGs0q2noKdGcU6DIQZgUo+IhR0zBkmdshVI
Ano2T1XghQl2W6LPOfqveYYjvgArLa6RaioSzr3AnCpOiJ0YWVkTC2a62rOdArZQ
M05owpfMLvGotITwbgMZCEoC65PcXnqIqsfPuFblg/IaKSQkm/o5lxMuScldFe/m
PnMm46JAaf7NbC7RVz/DxHCCwcV4hEP2Qj11AQQepsuk0Yd/V6HSAK6hQfxKF+8J
ESInJIj2C9T7fx2l1VpMXTfNu2oRqSg0dzCkZsJYpGCcKM1ei8IGoNJ4A3vdWsSf
lbv3YWcMpsaOjqnx7qkWzZ/DukjfyA==
=Ogg3
-----END PGP SIGNATURE-----

--jyx2ilssaabpedyx--

