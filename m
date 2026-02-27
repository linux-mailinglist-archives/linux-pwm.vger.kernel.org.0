Return-Path: <linux-pwm+bounces-8172-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id J6chASb3oWnJxwQAu9opvQ
	(envelope-from <linux-pwm+bounces-8172-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Feb 2026 20:57:26 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A40F1BD257
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Feb 2026 20:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 308683009B1A
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Feb 2026 19:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2876536D507;
	Fri, 27 Feb 2026 19:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlXl1QBB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D376846AEF6;
	Fri, 27 Feb 2026 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772222239; cv=none; b=Tg6CtjnkWsWmPhCA+ccr1e3dM0AqkfFTwNznxgUQQoGK5CINZo+4O3+QaS7urri2hUYpRc6H4b+IW0OPrVgT7eIC3n+PPj3VOj5lJz3NxBxYKRv0c542TV5avlNHIdoow+a7IS4BU0SgF8uJaj+aqyFKPaKw7vBisigYWRnt7gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772222239; c=relaxed/simple;
	bh=2ruQAFOgBovPWdodoeXFj5bxQhgqvYFQ+SokpXEUl4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/80iW7BlGTfluGtFN0dd3pLwc0qAra35nhNRRdAp2wmUn6DpphK85cV4abM6efZEYLfEen5/mbkDEPhBI74I4A57IebUyXfCcgV2DqzVE0jzNfYo8kfOhUyhkpP81fOO5MqNu3b5fqUPDphvvWgu2P/1yFJ0ohkgoWUuFb4cw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlXl1QBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13C4C116C6;
	Fri, 27 Feb 2026 19:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772222239;
	bh=2ruQAFOgBovPWdodoeXFj5bxQhgqvYFQ+SokpXEUl4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qlXl1QBBiH6/fF2StILfhzLdn89EAktO9YeETlELweQPy0atq6peNcP9jG3+Xs0Kc
	 pv4tGUqfeCBHcz1KIEpEm/kbWjyxWqz+XTsSTVf+dk2+9Gji8xNfAfuFU2VegSNNHO
	 oLdb0NGPzCfitJ9bpqsYm6WpeRcTfgACxrtVl0I31DHAf0HfnH+DP43YBjea/FO3ux
	 L0XvfvMTS0xyr9g/iz16xsLmizdIVO55XxBYA8IHBOJSaBf7PbpQa+1fV054hu4Ujw
	 lzEH6nxsTwHiyFjta14t23Ouz3uxV43pw6E5DTF/0W49rw5/kZjJ1c+xrZNbhl1qP4
	 Jm5DaCO7bRpVw==
Date: Fri, 27 Feb 2026 20:57:16 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org, 
	linux-hwmon <linux-hwmon@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	julian friedrich <julian.friedrich@frequentis.com>
Subject: Re: [PATCH] [RFC] hwmon: nct6775: Register fan PWMs as PWM chip
Message-ID: <aaH1g7Bi_rJkN_aG@monoceros>
References: <20260225125159.20822-1-richard@nod.at>
 <aaCHc4q0I8Az7hpx@monoceros>
 <1212284023.1388.1772131004601.JavaMail.zimbra@nod.at>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uwamhgjhiitpzuzf"
Content-Disposition: inline
In-Reply-To: <1212284023.1388.1772131004601.JavaMail.zimbra@nod.at>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8172-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A40F1BD257
X-Rspamd-Action: no action


--uwamhgjhiitpzuzf
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] [RFC] hwmon: nct6775: Register fan PWMs as PWM chip
MIME-Version: 1.0

Hello Richard,

On Thu, Feb 26, 2026 at 07:36:44PM +0100, Richard Weinberger wrote:
> ----- Urspr=FCngliche Mail -----
> > Von: "Uwe Kleine-K=F6nig" <ukleinek@kernel.org>
> >> +	struct nct6775_data *data =3D pwmchip_get_drvdata(chip);
> >> +	const u8 *wfhw =3D _wfhw;
> >> +
> >> +	if (get_pwm_period(data, pwm->hwpwm, &wf->period_length_ns))
> >> +		return 1;
> >=20
> > That looks wrong. In principle nct6775_pwm_round_waveform_fromhw()
> > doesn't depend on hardware state. It's supposed to just convert the
> > settings stored in _wfhw to wf. If you know that some things are
> > constant during the lifetime of the PWM and you read those from
> > hardware, return a proper error code, not 1.
>=20
> I see. Since the frequency is never changed by the driver we could
> read it while probing and use here the cached value.

I don't care much why the period length is constant. With the idiom from
this patch a comment would be nice, reading once is also fine.

> > Rounding down wf->period_length_ns is fine, so this must be:
> >=20
> >	if (wf->period_length_ns < cur_period)
> >		return 1;
>=20
> But then the period is no longer fixed and something larger than supported
> can get configured. Smaller values get caught, though.

that's wrong. The period is still fixed.

> e.g.
> root@fedora:/sys/class/pwm/pwmchip0/pwm2# cat period=20
> 43243
> root@fedora:/sys/class/pwm/pwmchip0/pwm2# echo 43200 > period=20
> bash: echo: write error: Invalid argument
> root@fedora:/sys/class/pwm/pwmchip0/pwm2# echo 50000 > period=20
> root@fedora:/sys/class/pwm/pwmchip0/pwm2# echo $?
> 0

Yes, you can request 50000, but the driver will round that down to
43243. If you have commit aa12c7e70319c9746e55e5b00a215119ba838dad, a
look into /sys/kernel/debug/pwm should confirm that.

(That's a weakness of the sysfs API, you cannot get feedback about how
far the driver has to modify your request to adapt it to the hardware.
Did I mention that you should better use libpwm tools for such tests?
pwm_round will tell you what the driver does with a certain request.)

Best regards
Uwe

--uwamhgjhiitpzuzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmh9xkACgkQj4D7WH0S
/k53hAf+J3H1z9B3ilP0nmQuUlkfOeQRJyXLyjJQ8lftmwwNTeEB3+WBCQ5EgwNW
DyFTRPk6Mw5IT2T0ygqXzYM5XR6eomCD045Uej0jjdOf61y0WuVaGdapybXNmdaA
9wqIB8O7SEjKgFYqKbeScq5sHi98yRdfBeoKTmnNGcbbYQYv3KyRVXFlEsS4kHza
SSrMXhj5HGJPIkIkk1D3iS/dfg3NK9FY4s5LPtfGZVbhNqanMifuvIvRRKbLHLqv
Rd3ylkMohoVC2Ndbemdxsa3yDfc6aL9GPFmjUzQxJGRxGeqfrD3qRy9HOKQMHSTd
ILGjos9hyU4OG4lnMEGBXWjn430aoQ==
=hPbo
-----END PGP SIGNATURE-----

--uwamhgjhiitpzuzf--

