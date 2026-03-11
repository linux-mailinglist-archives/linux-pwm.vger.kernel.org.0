Return-Path: <linux-pwm+bounces-8234-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGcCJ8GRsWnkDAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8234-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 17:01:05 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97273266E43
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 17:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F42D30DB497
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 15:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8D33CEB98;
	Wed, 11 Mar 2026 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4usjLSb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8512A379EED;
	Wed, 11 Mar 2026 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773244706; cv=none; b=HPbGmUCRVcDhlQPHb0KI2WcYPk4cbvDawV6FgaRhDSDQDWdtdh6jlXo5pnAJAyYWTfwFg2FHx1I/3ViygKUmVYQ8ZIKwxFKMwvTPGAzWrYrW834XyHwbndIKn1kHPg/lrmoh1qFhVvzj2/CjEUkmLgrcOvAmGdUh+1aQP3ZYIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773244706; c=relaxed/simple;
	bh=ED7NNKBzNmG/FXhJsQ/WT85kkqplmyBGp4L6pYcJxWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHTs2e+w2YC+VD3018UElofkJeOT4Vz8MFSdT4AP9g81RMvAQY0TuMyDreNFUnhTilBZzZScI/Wcaga/6a8V2mE1boN3nNSDVGojDQaMUgGtYvobR2ZmRgqxspS6UaTskhopSl6EYKyOIJPA8cJDHM0CiDjNKMhQe7s7g5fSZNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4usjLSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDED1C19421;
	Wed, 11 Mar 2026 15:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773244706;
	bh=ED7NNKBzNmG/FXhJsQ/WT85kkqplmyBGp4L6pYcJxWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R4usjLSbxt9x7w+rF1mAiUbrGRKXZ4a9efW4SfQpg2jvTFMb2CpxXLOLPDDLUsldG
	 lA4/yXx0bYL3oLaaCcIVe4GgULw1+JdVdrZmxDaA4alQsU5cJFvOiuJ3qGZ1oKMSZO
	 yeCQ69vjIpknZ4PsNOL1vK7aDw7o/Fj120JIU0Bz++zvVdxS9mt81VRUXAgIPOOJVd
	 z4Jjr2YvFKJ6k8XeOLHyeKa98WPujC6Yx8pOETzt8atyVlUUOjRPZn8C1Wq4euQ/YY
	 fTBnw3KpN3QM804+x+7PrSze26z9VD4BO7jP6fswdqMLZoyngvQ1x9xZW/APXieaVi
	 j66NpL9xpoe0Q==
Date: Wed, 11 Mar 2026 16:58:23 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-pwm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pwm: imx-tpm: count the number of enabled channels in
 probe
Message-ID: <abGQ3VxC0o9obnLk@monoceros>
References: <20260311123309.348904-1-viorel.suman@oss.nxp.com>
 <abGLriw_VJ0MadPB@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="epwke632gsn772f2"
Content-Disposition: inline
In-Reply-To: <abGLriw_VJ0MadPB@lizhi-Precision-Tower-5810>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-8234-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97273266E43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--epwke632gsn772f2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] pwm: imx-tpm: count the number of enabled channels in
 probe
MIME-Version: 1.0

On Wed, Mar 11, 2026 at 11:35:10AM -0400, Frank Li wrote:
> On Wed, Mar 11, 2026 at 02:33:09PM +0200, Viorel Suman (OSS) wrote:
> > On a soft reset TPM PWM IP may preserve its internal state from
> > previous runtime, therefore on a subsequent OS boot and driver
> > probe "enable_count" value and TPM PWM IP internal channels
> > "enabled" states may get unaligned. In consequence on a suspend/resume
> > cycle the call "if (--tpm->enable_count =3D=3D 0)" may lead to
> > "enable_count" overflow the system being blocked from entering
> > suspend due to:
> >
> >    if (tpm->enable_count > 0)
> >        return -EBUSY;
> >
> > Fix the problem by counting the enabled channels in probe function.
>=20
> Fix tag here

No need to resend just for that. I'll add

Fixes: 738a1cfec2ed ("pwm: Add i.MX TPM PWM driver support")
Cc: stable@vger.kernel.org

when committing.

Thanks
Uwe

--epwke632gsn772f2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmxkRwACgkQj4D7WH0S
/k49dwf+Kodx+Y+g4n26ScgW6Ze48U9EgGiR9yxq7dz2goKKDxa4YJG+NDsYOGua
uy0Lq6MKoO+hX03g4UVHmfIUCCC8wCwdF9wKIsh3iIn7wszC6rFIdbLUiF2RB93x
Spp2nTDM+UXeJd/WxCK3qoUMtouBNbN39Dh1+RY9b7VO4Bt2ZNX2eZ41Ydq7aQmi
mvIEVimmqa0Qg6OJ5kWJF4Pzwua7Hrsi44izn0J0NfkdxyDJ7UgMmH4TwiwbXk5s
X205KND+T5CmHjJlh39wXHuWWA2UtEEBHgWAmtAaTvpY/ChPTYrLilbXV/gd1s23
dFpStRPsKRRlXHv+AbFbZ1VvevPB3Q==
=+vB+
-----END PGP SIGNATURE-----

--epwke632gsn772f2--

