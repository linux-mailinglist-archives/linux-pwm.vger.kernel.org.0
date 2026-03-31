Return-Path: <linux-pwm+bounces-8442-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNFaIRF6y2k3HwYAu9opvQ
	(envelope-from <linux-pwm+bounces-8442-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 09:38:57 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D9A365575
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 09:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C0E730996BE
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 07:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4133BE164;
	Tue, 31 Mar 2026 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wm0A+i7p"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CDE3BADB6;
	Tue, 31 Mar 2026 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942199; cv=none; b=HYG39+ad8z+WzSzZFulgVFm8cQ9Uw5aJZITOcx+gc6mZ2JzedWiBjl/YRxBB1SjIOu5hJpQPCh1YgDGxbrr75Vyb4Qlv9i6eO+p3PQ0QlfXtP6piq5676Fe9+vbLBdPjrS+FMojWTVNQA896HJnMSJowCze3U8H1BuH9oeDcWVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942199; c=relaxed/simple;
	bh=18Cxyy8htZfALZQmdF2QS9bAa1Fvx8TFelLqqWslQLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q99Wka2WZVzAMeO2ubouYD60KR36+CxK7DEVGiMpF3WgVy21LSBfPOx6eYXU5A0WWHSUFpBMacABR70GoWACwGwqXns+S6lrnvbsPp+kpEu43yh83JoXGVCzfMLvyIpWmZ+fIhFHtwRBpdf4v88lD8ZxB66Y6wxm1+VuEHa2s84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wm0A+i7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4367C19423;
	Tue, 31 Mar 2026 07:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774942199;
	bh=18Cxyy8htZfALZQmdF2QS9bAa1Fvx8TFelLqqWslQLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wm0A+i7p3Au42pgTzwYUiS+LtvKND9k/SLZig9x2wvqtq6yizh9FddmeGXxH5Q24V
	 i7YSiK7Ts6/u1dJtBQM2DoMg9AZ0pQdsr+BioB4PUBQ3+6qW1Lj2oNomPoSqN4FxLL
	 iyreFxJWdIv0jKw4dsYBD54hqhY1SJP2PimnGn93AZ3GYuJVlVJ3jhj4h+QQ5nPOlr
	 1/nb71RIutBruFOW/ybD3ZiqJLPQ0wbR1LnwyspsJ3W4Fxcufxcc5c0kW2qyvzCyVI
	 ziQfLByv+64TuLgDA+SJuJo5ka7eZJa/iyQnSRHhGoZRgKxau9SCxgDHoA3iT352Fy
	 /ps/rK49qxilw==
Date: Tue, 31 Mar 2026 09:29:56 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>
Subject: Re: [PATCH v4 2/7] pwm: tegra: Avoid hard-coded max clock frequency
Message-ID: <act37F08rdGGIcrY@orome>
References: <20260331-t264-pwm-v4-0-c041659677cf@nvidia.com>
 <20260331-t264-pwm-v4-2-c041659677cf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ereuadoeeuso5gbv"
Content-Disposition: inline
In-Reply-To: <20260331-t264-pwm-v4-2-c041659677cf@nvidia.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8442-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,nvidia.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thierry.reding@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37D9A365575
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--ereuadoeeuso5gbv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/7] pwm: tegra: Avoid hard-coded max clock frequency
MIME-Version: 1.0

On Tue, Mar 31, 2026 at 11:12:14AM +0900, Mikko Perttunen wrote:
> From: Yi-Wei Wang <yiweiw@nvidia.com>
>=20
> The clock driving the Tegra PWM IP can be sourced from different parent
> clocks. Hence, let dev_pm_opp_set_rate() set the max clock rate based
> upon the current parent clock that can be specified via device-tree.
>=20
> After this, the Tegra194 SoC data becomes redundant, so get rid of it.
>=20
> Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
> Co-developed-by: Mikko Perttunen <mperttunen@nvidia.com>
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/pwm/pwm-tegra.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--ereuadoeeuso5gbv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnLd/QACgkQ3SOs138+
s6GF8A//alO5iwg+X2ddOuKkJUElSJZGt2yoTij70qr0CBRXgxyNuyOztjKW7sYi
x4G2P/SQuyfVLDw/N9jb9lDjnaKqM/CveacQlH37afmKjN4J+kq8KaT2Yy+05oXs
EFRK9XvtGsHU5l6ktqHttfeefKNw6Hy5WTCTMetMa9ByOliHxyYQV8TTR1cVr0L2
dj2EKd8Xvlu/ZDBXM9iiyiM2ftX+UbHcLAcjfXF0oKmxB6EMuG8k3LaSEjzYhsSE
yp4cOVxcJiPuHiTg1CfD1O9KwdGRrhhpou8+3dWXfmaK6HAfcPCXFBg3KamcdK0x
qRaxYlxEk6V+SGZ9w7PM+IXoevdfGIvTBrhLyWEEpxSoX9IHpzLef8Nmkf5jyzPq
nG7xwbTZdlHUz/IWrpHdBrkEuopbetHNsqMJ6mqZp9IHhevjIJuPOoyNx5NfPb8w
L9e62reoiCg0pjH4c8x8FN3Kv/P94BMhXcWmjSlB/iJ+Pq52bMlxtZ8BVNCiJ2pS
emu2u1ePpflwKKR0y52EVZXhnB6aT41G0ntQuImKs2uNVRbM5izPpmj997eonSqm
HYdmF4y66MxF3IcYrud3hr3RChABfvckQU7cYzuhqWrakIgMlb+ZPRN43vV4orrN
W0PzqXcreWGwDSuWoD0yuMrv9GiMSgigxYclHj65rHIXe1tSQpk=
=afX7
-----END PGP SIGNATURE-----

--ereuadoeeuso5gbv--

