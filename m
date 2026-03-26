Return-Path: <linux-pwm+bounces-8377-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MXhLUkAxWlC5gQAu9opvQ
	(envelope-from <linux-pwm+bounces-8377-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 10:45:45 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5A4332905
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 10:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A426C3020FCB
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 09:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F7F33D512;
	Thu, 26 Mar 2026 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oH8Um9n/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E42D948D;
	Thu, 26 Mar 2026 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774517756; cv=none; b=PxZwv4Q+4ZM2P06Jlb3kjtYXh/XRaMv1ffkLOBn0v0eJRvhKKJbj7QMj+8WqjbW8Ni/m4RZ8gwBJ4AZPD/akeEb/OIqlsiFlxgKDX3BUi9BCy09a0pvvHMLiJxi6NGLGrZC6Iw0QaXaCOCGUKYlG8Q7pv5LiIsRGLx+/cFtP9zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774517756; c=relaxed/simple;
	bh=Ysu//SzXdYM6Ja+X6GEXyxKMAawC5e8zz4sEbazP0d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeW7XaO9XrzQZ9BMMB/X94RcH7Yw+NAxp+rn7GmBfOxgkeCJ1ovQFaqvnpKcKJR6RZ16ZYzDydxa6h+3j6K0jw2fujdFwAFTJToA0JPrNalOlYgfzCNq+PsKQe+8o/K7x5U+Kf5FrCfmKGj7WM4DRtVSdbXP9RbYk2njF3+e6+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oH8Um9n/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12869C116C6;
	Thu, 26 Mar 2026 09:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774517755;
	bh=Ysu//SzXdYM6Ja+X6GEXyxKMAawC5e8zz4sEbazP0d4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oH8Um9n/IJfBZbg973mfuAr9z2kYsZMM/BnlOSikR66gxhSLZf4n1lzFXGyMM9UfA
	 ymFvLZuTftEjpFlHHzZc2Jv9VB9ls5q0DiKt0bgktR5VMumPeasdXaO4mEf9sSUQe/
	 NaJDrY/mACV6K1Zeh51karwpyzkrl8OHHODXEDC3V3klyZP1+e2lbpKm8cFsa+Xarf
	 C0sYoQC02o54ubEXk7hoca/GXtX2Ab5viJEPQpTpGQcuxYkGq0D/18gLOwZ2dkGMKy
	 9K+iDAunkdWXD2NtX3etjbg3hZweJGGqnelkB1yFkA82p7GKvzE7nVJtvA01QwyIAZ
	 cjce83tWRd+cw==
Date: Thu, 26 Mar 2026 10:35:52 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>
Subject: Re: [PATCH v2 2/7] pwm: tegra: Avoid hard-coded max clock frequency
Message-ID: <acT96Qh85krc6Hr_@orome>
References: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
 <20260325-t264-pwm-v2-2-998d885984b3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cusgvpbw2bgo3jwv"
Content-Disposition: inline
In-Reply-To: <20260325-t264-pwm-v2-2-998d885984b3@nvidia.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8377-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 2D5A4332905
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--cusgvpbw2bgo3jwv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/7] pwm: tegra: Avoid hard-coded max clock frequency
MIME-Version: 1.0

On Wed, Mar 25, 2026 at 07:17:00PM +0900, Mikko Perttunen wrote:
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

--cusgvpbw2bgo3jwv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnE/fUACgkQ3SOs138+
s6Ghaw/+MbnUxA9M8tV/mJdakaUIG3E26YQsPu2+2Ut0xwE6KWdQwuyQ9dnVN5c0
OgeVcWy3jW2kfogbfJ/X852hxp8YXAUTRLK8bKQxAdQUVtgNr64k29GXR28k6rpI
xCWZbrUUqYusjQPrb9bkoJh4LK9RmlaTbFZg2Jvs1HlQ60KXQHGxY4CoGGyJpIOW
AAMfTgV9kBsm1iBu0sIUxPHTyVJP++0JnfDFCDLlbAXApwSIjc/l6zCwbW99Z0FQ
3Xw4dQLVEqP3SiuExdkApNgHW9ABQpG3rBophOdTXehGyw7oYdJqDOIliOonv92a
ZdAI9ceYfDOlDypGKj5MoKTBZbx2rUon4/gprPxotKLzRTgY0WywWDX6M61uDn8Y
lxKk1a/a0m3mqYcYumfxBPRvPBh/JaaiM/w7qzNp7oo+oasopMAn607sgNdVvS3D
T4szrFHc8OMWf33ghWP4PCE0+UPCBLpeVnQoMbgF01Es78ZQBMhyga5AODEggTaV
K7QWewaQpK7Xdae2wjbuU4n3sQ4KFtkP5dCKVp5CO1eXnE47cbLdjEyjIGFSVDNu
7EcK8Mc1HwHr2XhSnqMQAHpV3xQ0zUAuf8BYmokkEyMWUa3CoplEs317Vos6lSzS
V/sp0lZsr5qNK4UyUMhykZaFW1QF58qYj1BC/3LLYVpyq4AHObQ=
=ZLda
-----END PGP SIGNATURE-----

--cusgvpbw2bgo3jwv--

