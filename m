Return-Path: <linux-pwm+bounces-8734-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yII6ArWB8Gn6UAEAu9opvQ
	(envelope-from <linux-pwm+bounces-8734-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 11:45:25 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC91F481C44
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 11:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BBE330364CA
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 09:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449DA3A9D9F;
	Tue, 28 Apr 2026 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLxgCfyy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5F73A6B7F;
	Tue, 28 Apr 2026 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777369043; cv=none; b=Go0B44gr4NJ5TZxbTy3h37JZZbQ1Pg030hED3BjtRlmEhDCqxO11GeaG5qltjQLUTNsnVLAaQweUJXkZ/b5inY/RhFeVQuu2WEJO4M6CMQZ3q8zOPM1CBUofAVojnj8I0I5+GjWo/FrbYDenuXlrLZhJzHKPrS10pptChC/A4GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777369043; c=relaxed/simple;
	bh=HM9evInCFYKy8es/TsKXHh8GLiXdJjs/TZ6Xikd1hus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzteoljkgiEaO2dLDVHO1nVWSrtqOUMgyL3z8SR2REpBQ3XU/CImifiigGA7njDe5H7rBY7UqLAcy6p0cevrOHVxyhYQ5CZCi7V8lyxM/Hc0YGY5krPMrRHNu5gf33H7tVW1+imlb/28HARIzzyhZ0v3u/8vqugPZS3lnZhV/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLxgCfyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FBBC2BCAF;
	Tue, 28 Apr 2026 09:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777369042;
	bh=HM9evInCFYKy8es/TsKXHh8GLiXdJjs/TZ6Xikd1hus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NLxgCfyywn0V6zY4za6ewhWgPGQ5lWDL/2Pa2I4YpZflmGrJW7S27qnAOo2AlEKqM
	 a0uc2KNAXUvyDs4nom2XXsustejAYuVoAsdyjftRdcaBHwx87GgB80fnqqcgeYrfU/
	 qIeZFx0t9z0iqOwkaOYS3RfWY4uZUSPZ592PJsP9INsFTUcfPYzx7QwwD13BIUtKyg
	 z8uQF16K+0bEWjK9JUNjl34AUQ/nGBuun0c4ojbzGjep+h+EhJudTHXgD+3InX8cCW
	 KP7qOtqSQ5NzWn2KzqB3cs6s8W44lH+VVXyey+CIUh1Fgs+7Iskd4aSTKCL9cu6cNR
	 XA1JWIDp9YG5w==
Date: Tue, 28 Apr 2026 11:37:18 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, m.wilczynski@samsung.com
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
	aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org, 
	viresh.kumar@linaro.org, bhelgaas@google.com, kwilczynski@kernel.org, 
	abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 00/24] rust: device: Higher-Ranked Lifetime Types for
 device drivers
Message-ID: <afB-p7vhyVYlcTn6@monoceros>
References: <20260427221155.2144848-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rqxumekpprrd4q5v"
Content-Disposition: inline
In-Reply-To: <20260427221155.2144848-1-dakr@kernel.org>
X-Rspamd-Queue-Id: AC91F481C44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8734-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]


--rqxumekpprrd4q5v
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/24] rust: device: Higher-Ranked Lifetime Types for
 device drivers
MIME-Version: 1.0

Hello,

On Tue, Apr 28, 2026 at 12:10:58AM +0200, Danilo Krummrich wrote:
>  drivers/pwm/pwm_th1520.rs             |  14 +-

I didn't try to understand what you do here, but there is nothing
scheduled so far for the pwm_th1520 driver in my tree, so

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

for patches #12 and #19 touching this driver for merging through (I
guess) the rust tree. Maybe Michal wants to say something about the
actual change.

Best regards
Uwe

--rqxumekpprrd4q5v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnwf8MACgkQj4D7WH0S
/k7NPgf/WyrJVOG8I34GH5+Ktz8BA9Pxs9vvwKn2Dor40alOMKdMZe9E1/NeIjk4
rRXtLa+EdYtq9IaNCEAbMBviP+iT93opuA2k3RqR/hJoIvYQBokftNexPO9U3Rn6
p33A51jyrZ7rMaijj0caWsANCuPQDj3uYYvgQ+jPtSRx9kDZtBI+XqMAoSkGhRxA
wD0/q4kZHaW1p2W3+wPWQfd3F++cs2cjxqZ1VVVs+BsA3LdZWJ29RI5kqIY1+Z/g
kb2nv/HyhMRzaUfnHuvVi2/OlxnWn+Wt0WfDWaPPqOwNm+vKCuYBhvmhxs6iHfnG
awPuxSiYzaxPXaCkO5cFlKMH2bnmeg==
=08q4
-----END PGP SIGNATURE-----

--rqxumekpprrd4q5v--

