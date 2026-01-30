Return-Path: <linux-pwm+bounces-8015-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFoTFliEfGmINgIAu9opvQ
	(envelope-from <linux-pwm+bounces-8015-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 11:13:44 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BE6B9401
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 11:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 260D43004604
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 10:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7641732E733;
	Fri, 30 Jan 2026 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tr6IkeE1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A6E3168EF;
	Fri, 30 Jan 2026 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769768021; cv=none; b=NM3vBTe51YcDP71Fs653IfnV+kA387pb9aFI+1o4pQRwHXVrCElekn9HikRV9cywb6P8DrqfM2e7nwx3ERjHbRrFM+Om/6bCBYafOydZ3sD2DddHVtoV+q+T59KJahntpQ7ft20bllxCi/MPHvoTpnwJTe7cp+ZNaDkazdAdw/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769768021; c=relaxed/simple;
	bh=qxTwcF/RKUxSlx0NpzW9q/qr4hHP06KPsn1qOzxicQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEvaitYU5H9iFD+sZl/2YyPnaPmOmFHmlMguD4jnAgJqNYhDjJeqoMJ47ctGnvmZnIs4RE/ziawdd9S9kthkUHVAukNSxYOumuLanc8yqv3+5fO+CmOKnb1+oGl0yXX67s9C4BraYwDdB3EyWefZtZAnyWAkhRMCBW87tXD13Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tr6IkeE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE4BC116D0;
	Fri, 30 Jan 2026 10:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769768020;
	bh=qxTwcF/RKUxSlx0NpzW9q/qr4hHP06KPsn1qOzxicQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tr6IkeE1UNPeu7vgRDjv46zF2YF65GjoA4phPm+zvju2ZBUckxqjwmrej6pRiLeFj
	 Xl6vTBPp8hSf7Y+wTIpj+x0hjxhK/vG97hrXvimWXqcEUxs86qq9C9uCtnrABLKimX
	 +byKRJrHbfE/aNrpLNKOov+v6sBScLlUODQYqdoeytNxZaKwu1x32rOfdAKCu2AVVn
	 KfQd3wJJw6Dx6MGWA3/fLKYJqUA/EpO/ViBlflyjsSJROo6/YJt0cXjtZRRh1WOXY9
	 woYHWXB5MOYO8Ksy6wR/X5hsFEAd6wNNw3oItf827gEbhbqpGT6Y5atqjraHLh1UoQ
	 Iup/vqU6XuHaw==
Date: Fri, 30 Jan 2026 11:12:18 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Ben Zong-You Xie <ben717@andestech.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: pwm: remove redundant check in pwm_ops_check()
Message-ID: <lfxvek7ms2p5fehr6qibx2awc2m6shazlqvavrdea6t2nips46@mcayd6h3sepc>
References: <20260129-fix-pwm-ops-check-v1-1-6f0b7952c875@andestech.com>
 <jxzeyujbaj6s2j3woj7lyuilwi7tzlhenamlih2q23khxw4d3f@dpbnhlxzsjmr>
 <aXw9jY5kpPNAiyxR@swlinux02>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="62bwmerseozplaeh"
Content-Disposition: inline
In-Reply-To: <aXw9jY5kpPNAiyxR@swlinux02>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8015-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1BE6B9401
X-Rspamd-Action: no action


--62bwmerseozplaeh
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drivers: pwm: remove redundant check in pwm_ops_check()
MIME-Version: 1.0

hello Ben,

On Fri, Jan 30, 2026 at 01:11:41PM +0800, Ben Zong-You Xie wrote:
> On Thu, Jan 29, 2026 at 08:19:00AM +0100, Uwe Kleine-K=F6nig wrote:
> > I would rewrite the commit log to:
> >=20
> > [...]
> >=20
> > to make the change more clear and also to not bother the stable team
> > with backporting the commit to stable.
> >=20
> > Please confirm if you're ok with this change, then I cope for the update
> > while applying your change.
>
> I'm ok with the change, and thank you for the review.

Thanks for confirming, I applied to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

=2E With the merge window opening in more than a week from now I will
include it in my MR for 6.20-rc1.

Best regards
Uwe

--62bwmerseozplaeh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAml8g/8ACgkQj4D7WH0S
/k5wKAf/R+uv3siYpHtcqcdvSD78fKqYdchp2ssz8h4aR3AhYnMradWh1k4U2kSy
lpTHG8n9mdrhpWxXbPNBUCuvUa0Ncij/zoRu/3b9ryqXf0tDN6NIPJzQfB1Xf9BK
1b5Tiun32HCw3ZyQ4yYJxsn7N4v4jSlrIii0wLTT7Ot/qJCfMSAM7QbEpZuu/4f7
1o2gO8/gt3ZO21ztPtxjfMfEGEdezFmz3zPUpOqRYaxwFnDP1wdkrP8Y0odE4dMC
TCWtNZUaZCecFDUhgQUqby6mdJXUzkSbt/mvpD7ajs1QROoyiEZHnn7pfoJ27RE/
7EEDZUzjk0QhOMtQl2lY1LZL5nCd7A==
=iEtf
-----END PGP SIGNATURE-----

--62bwmerseozplaeh--

