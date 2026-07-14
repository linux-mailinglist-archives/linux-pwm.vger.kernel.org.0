Return-Path: <linux-pwm+bounces-9710-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KyaOOfcCVmrIxwAAu9opvQ
	(envelope-from <linux-pwm+bounces-9710-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 11:35:51 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67560752EB0
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 11:35:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jqmPN9RC;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9710-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9710-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABB8630166C1
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D748C40BCBB;
	Tue, 14 Jul 2026 09:35:24 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC95235F615;
	Tue, 14 Jul 2026 09:35:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021724; cv=none; b=hUBpeYLxKPO9w+UwO+mytd5SxcAONVvQmud6fbbUYXt3+gtyvH1T6kcEmmzDWp3F91MpFQWkxrQruUVQNFo5ZaIlLjPKmfDY9VlLpU5XYhNnHmS+XVFgPXfndsecSxsa7xmmiZqVmkttMcoEeRMLqKRMIkoHUtjoGVTMyYYnxCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021724; c=relaxed/simple;
	bh=E/nQtjla1+FP4M2wXMpEPkc0YYBfciq3q3/VHapvxH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQfnXh/BY6ZKhmz1c93OTtFn+Fbr2KtKNa/t9MARovb5OGTb+NqLGJBBEuiSpRrGbV7rsKPTdwuGEk1X2rtGO3UCsKkyVvPK+z4FX3g9WD3srdsWkiNp2Zyr4E5gJjGizvlkkdeEU0SlPya8kPUcBQaMELOguzv0wXOQHzfdEro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqmPN9RC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 056D81F000E9;
	Tue, 14 Jul 2026 09:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784021723;
	bh=1xtYT4SHNv3MRdcjQhk/z3uq7LbE1WIXNc0p3FyHpmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jqmPN9RCkNsrZxGpyjCK/uUFyGS6gzEsCHULQk7KC+chWYUtY9Kd9q5kgKjn7JSlS
	 BDVtMO9dVCnW6AINC/I9g9BuvfxK0IFMd+kzIGcatOXPqbuatdvRxWNCS1jYH54+Ii
	 Htn0q6nYfBczJzGVd9rCSsxizkFdBs5NW8rgCDMuejzEFP0Kg6FKEwsUchn1N7jLxw
	 xjvK1rilb+E9T6NqRK0hxZeTc5EVKU5Avs0/yq1XhgQmIOB6EaLj27VUQCFZIZFSm6
	 baUP1z9l8LFbaUFak4lyPGM2GMoA/xnX2SN+7k78RHg91Rl9b66YqFlcOLY5B8uUBc
	 n9txmbn8IhOGA==
Date: Tue, 14 Jul 2026 11:35:20 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Thierry Reding <treding@nvidia.com>, Yi-Wei Wang <yiweiw@nvidia.com>
Subject: Re: [PATCH v6 0/7] Tegra264 PWM support
Message-ID: <alYBz2PVs7hCsR91@monoceros>
References: <20260701-t264-pwm-v6-0-2718f61f411f@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nxfyz46qk4c4j522"
Content-Disposition: inline
In-Reply-To: <20260701-t264-pwm-v6-0-2718f61f411f@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mperttunen@nvidia.com,m:thierry.reding@gmail.com,m:jonathanh@nvidia.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:treding@nvidia.com,m:yiweiw@nvidia.com,m:thierryreding@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9710-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,kernel.org,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67560752EB0


--nxfyz46qk4c4j522
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 0/7] Tegra264 PWM support
MIME-Version: 1.0

Hello,

On Wed, Jul 01, 2026 at 12:20:29PM +0900, Mikko Perttunen wrote:
> this adds support for the PWM controller on Tegra264. The controller
> is similar to previous generations, but the register fields are
> widened, the depth is made configurable, and the enable bit moves
> to a different spot.
>=20
> This series adds only basic support with fixed depth -- configurable
> depth will come later.
>=20
> Patch 1 adds device tree bindings for Tegra264 PWM (compatible
>   string).
>=20
> Patch 2 prefixes driver-local macros and static helpers with
>   tegra_/TEGRA_ to make their scoping clear.
>=20
> Patches 3 to 6 contain the PWM driver changes for Tegra264.
>=20
> Patch 7 adds device tree nodes for the PWM controllers on Tegra264.

I'm not entirely happy with the driver (as already pointed out during
review of earlier revisions of this series), but it's an improvement.

I'll take a look to improve the things that annoy me in this driver and
I didn't want to do that on the current state which would make it
necessary to respin your changes.

So I applied patches #1 to #6 to
	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next
=2E

I assume patch #7 will go via armsoc? If I should take this, too, please
tell me.

Best regards
Uwe

--nxfyz46qk4c4j522
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpWAtUACgkQj4D7WH0S
/k6Gogf9GwP5KDRsQb+Bwe19ewFAAWQ1OCpmktiMyGBHOdpADiiRidR5m/wrvPzR
8BvH9ujBo1dCZopHkTrGgtjmnVI7QEaIQam1ZKF3ItG812jIb5A5JvRhuO49qKWS
eCah/8ew/l1qsoAKE9yuCPoSbnfg6+/dok+gSfotfkhAhHRpLL3uHK7CYPZ10pN5
Bn1WKP3SxMoXTf61VZXlQO82ZsrCATEbxR/vbu3lN83M/8keHELIi+0FYTjzlMi6
KRRIA/Gs2RJg2ooTWWBj2IL1FV2h0S/q7GwPkOUTFi6BumUWfFUtaKM8pBBsUxXG
p74imsrjqs8hIfu9jxAKwi24dwbG0w==
=XUku
-----END PGP SIGNATURE-----

--nxfyz46qk4c4j522--

