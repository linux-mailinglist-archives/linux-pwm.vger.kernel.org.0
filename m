Return-Path: <linux-pwm+bounces-9089-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFb2F5PcEWq+rQYAu9opvQ
	(envelope-from <linux-pwm+bounces-9089-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2026 18:57:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEF95BFEEE
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2026 18:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76263300B28E
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2026 16:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5352F531B;
	Sat, 23 May 2026 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzalX7S1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE962223DCE;
	Sat, 23 May 2026 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555451; cv=none; b=o264LBdCCd5ZPUpe0znUCay+H7Zcao7VnouvWVI0CE6RbYv+//oMPwg93xb+72s/k2Vn7K7HJL71iKYXh/h8hbVj9sfuQP6DOAR6EsLv4Qc88XrldljBu1zXzJa/BEPFZksvU8Z3txOAtotH4KTH+RrZ8lnOa26ON6WsIq9kcas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555451; c=relaxed/simple;
	bh=51WmkaTpoQy7JTlSmGFOduVIA7YtA+KZBmfdwn/BfZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQsaRbeays2JgOHhKZApaigqcUQFDLiGzYarUdQ1hvTEd4xYclI/7f5zhD3CGIabRANaOhWYhr5jJfvmaWjBEaGipHdckyCE6hdt66+zq1X1nFCGqviIyJokBtNyb5aAszuvxtoDGCdpSQwdT1ynj5uacO6ceZflJIYDQP81zhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzalX7S1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E84C31F00A3E;
	Sat, 23 May 2026 16:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779555450;
	bh=51WmkaTpoQy7JTlSmGFOduVIA7YtA+KZBmfdwn/BfZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JzalX7S1OQFj5tROKOpmcYv//3t5uHJY0f0PEwfyfcr+sGJa3oLpl6D82PQWvMRYz
	 qs9EtzBslP7tPKKSvWVGe6c0LsCdxZ8ibiLTWPAnnNWpGi9znJb7C1kkEocHYB49Ux
	 0bC+HcIVQ/4dHCJ2KItUnB0KVKpF2RruPAQjkLF7TYWsJODyQtKjXqYE0zV4YGxuw8
	 j+DFSrUcBhju9rm6L6Lfy+ziu436v6uTuO5zvfgmuYOgDEGDqrm4xWqPwq4nzwi7LV
	 nQyxyof0/EQ53AlLVRctTwPjZDmhn7btwhS1afKSt+IJEpaQX8hHDPA7KgmRgcvy14
	 5Y0HtACXl1PKg==
Date: Sat, 23 May 2026 18:57:27 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Shiji Yang <yangshiji66@outlook.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/2] pwm: mediatek: fix mt7628 register offset and clock
 source
Message-ID: <ahHcHJNv49ASIshG@monoceros>
References: <OS7PR01MB1360282ADC135931ECCAD9AF6BC74A@OS7PR01MB13602.jpnprd01.prod.outlook.com>
 <ac6OYRkiDt_OJVcp@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7oykrngwmuffi3h4"
Content-Disposition: inline
In-Reply-To: <ac6OYRkiDt_OJVcp@monoceros>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9089-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,gmail.com,collabora.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5EEF95BFEEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--7oykrngwmuffi3h4
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] pwm: mediatek: fix mt7628 register offset and clock
 source
MIME-Version: 1.0

hello,

On Thu, Apr 02, 2026 at 05:44:32PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Tue, Feb 24, 2026 at 04:51:00PM +0800, Shiji Yang wrote:
> > This patch series fixes support for mt7628.
>=20
> The series looks reasonable to me. It would be great to get some
> feedback from the Mediatek maintainers, though?!

I applied the two patches now without further feedback to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fixes

=2E Not sure yet if I send this branch to Linus before 7.1, but it will be
part of 7.2-rc1 for sure.

Best regards
Uwe

--7oykrngwmuffi3h4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoR3HQACgkQj4D7WH0S
/k68NAf+JYTK6hgKb3FaAZld7lR7pNXHtTQ4akG5pJ6JxE822aHEcUTeI56XneoG
cQDFIG2Hi1ToYH+GMeOXNYSNPNfMBQ4AlL1o40fdgb3ejbBWhYyNRw4sSUOQXRM7
ylidhcdkmUMfRNvHBz1wE0f9dQR4nr3FlD8HyegEKmGvim90J+8QEoWNsUh2XSwG
CFCm7ne9mEFZGoCZOqC8A0ndnhY+DHqfSL5+hoh6aGAIH/Bbu2OwtvdUiB1Q/1f4
xSGarP+7Nt5+Vbu8/nwvwPOKvOALq04d+hxYGaDr26FtThmHh+oBVd3yD8ZHBNLW
cE+RN/SiWGg3nJg1M49svWpJis2pyg==
=vHOi
-----END PGP SIGNATURE-----

--7oykrngwmuffi3h4--

