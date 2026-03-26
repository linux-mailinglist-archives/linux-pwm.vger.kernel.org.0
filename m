Return-Path: <linux-pwm+bounces-8378-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD1MOqcAxWkz5gQAu9opvQ
	(envelope-from <linux-pwm+bounces-8378-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 10:47:19 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80341332983
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 10:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42138304F083
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 09:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DC233F8B4;
	Thu, 26 Mar 2026 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjJ1yeg/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D352D948D;
	Thu, 26 Mar 2026 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774517834; cv=none; b=iCQIUk7eor1wi9msMVm1Zb0VFUhRFZniHFS4d3SPXc3G9PKIA/Mahr1UFgLJeZyVQgpx3MMBbbCutQvOoOX6LYjKPwKN606vek9RsrOdqF028B/8W9g3/IO/3XXF/rXwwc8LL46x0pVXRmYpZURWoj2GgtrOhjfbmT+xkDq4czQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774517834; c=relaxed/simple;
	bh=WPzA71zM6El021U0QwiRy2QqNDBMxQE+GytSBn3TSe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tO0U/5s1vCbHNFPSdcvUX8vFqGmhFRdgJF1q61Eq1Yqd+HoRLkt/EHTGUORoE2i5vtKmzGTd/RGaji66HVQsyHqE0KRh47aSYfGs7wymErTVK5vrm9mmrH6T3xFW0zEiCLxPTcctyHRBdjUmBqiUnD9vDFLXZzvRajWmxALK9RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjJ1yeg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6697AC116C6;
	Thu, 26 Mar 2026 09:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774517834;
	bh=WPzA71zM6El021U0QwiRy2QqNDBMxQE+GytSBn3TSe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cjJ1yeg/aJXWscBf+XAhj/sr2ABGhGpZ8AJwATmehfMhyNZmcPCtLYoSDm5+RaOZl
	 alHSgBotc2AnPX0Rw7w6FVKNEkrLT6CswMzB3/+G0/kwMTq7qGAdI3lqAeCZU1U6fy
	 GrRyqqSyo6og/XPqPx+puZOQHHrqwi4dXGpO8btVpqXy3lhWcOnghsSGX/yiXherF2
	 sFJsiQjBwjyJrpGW25wf/jqED6sJXBdwLWFuusoisJaYK14/OcWgArex8GRRcB2JAy
	 YqxIA7gTw/Zw1XTkcu7AUYbwUHr4gma/ElK+dFHcQ92hP3NhWpmji+Mapxvlot6JVK
	 GBAHWTcFFxqsg==
Date: Thu, 26 Mar 2026 10:37:11 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/7] pwm: tegra: Modify read/write accessors for
 multi-register channel
Message-ID: <acT-OXOF8VPyOZyZ@orome>
References: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
 <20260325-t264-pwm-v2-3-998d885984b3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="euf4mk6lravh2zzx"
Content-Disposition: inline
In-Reply-To: <20260325-t264-pwm-v2-3-998d885984b3@nvidia.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,nvidia.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8378-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thierry.reding@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 80341332983
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--euf4mk6lravh2zzx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/7] pwm: tegra: Modify read/write accessors for
 multi-register channel
MIME-Version: 1.0

On Wed, Mar 25, 2026 at 07:17:01PM +0900, Mikko Perttunen wrote:
> On Tegra264, each PWM instance has two registers (per channel, of which
> there is one). Update the pwm_readl/pwm_writel helper functions to
> take channel (as struct pwm_device *) and offset separately.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/pwm/pwm-tegra.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)

Makes sense:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--euf4mk6lravh2zzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnE/kcACgkQ3SOs138+
s6FEAhAAwmmUwwWVbWBXXsZ2aWRh0smL7wT/vbpzsLWQmwv5AN3bmOGeQ8VgqlJj
tBeCnNti6h08JjNZYrdrpBY9WTibnSyTqdP8wIkObf3oTfBuSCUwzqxIACxpoOgT
KriuYG5yfHf+bKDTIFeWZPKBQfvYuGuTtNVH8rWylyfNg/HWNjjZJcTREuCPZ6B3
1HjOjFvoZ5foelY73HzhcqiV1IweB3a3u77QpXbPhshiwT/JuTb1ETsil6OelCZh
Z4Q4GT7Ei0AZxvwI+broR/DTKvhyqsC2Ik49OHFC6z1DkEwfTlHkuwEGPUMl1486
X9gppcmTlUdowMjXCO7nY4FlPvlqUI5QtvrodLpiD0hlSVThms6MPGvxM+nGwtAx
ovMYieE5oOTMmS/uGUH/9qzrD4wm97I3DxiRi6Sdobc3MyG0aMgxbbNvoxj0f/tf
RNi4w+zSBytMPoiWNbSUTINB/0TUWvPXsVrmEMd92DsS3KR1uq0KCp6Nw42lBFIM
lmqGZI6FvcR0yfkReB9lDt2iin7nqdpCeAQUg3UQaHH/NzsuXmVYKx2gJIu3WIxE
O2SSgNyINDkhQ+t/PeCveaEAbcfauT4Ec3m7axQja9SzTkZHOmfQ2ojv9K3Mhbsn
HrTgPKbdz1YkPvWqhz76icyZEEGnwceHV0woXCrO8q6Kq0mhEcY=
=GZTD
-----END PGP SIGNATURE-----

--euf4mk6lravh2zzx--

