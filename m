Return-Path: <linux-pwm+bounces-8934-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DMzMC3ZCWossQQAu9opvQ
	(envelope-from <linux-pwm+bounces-8934-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 17:05:17 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B18561E09
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 17:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52029300737D
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 15:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BEF2FE59C;
	Sun, 17 May 2026 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OacEpg0B"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4008258CD7;
	Sun, 17 May 2026 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779030314; cv=none; b=NuGzSvpNPnCIG4ngs+w3Ch6a9OH7px4uqu5sLN5pu1PNWY/vKDVkOXCaUsj9fhxvRWXJ/92uetNmXHltdpTzpK7ggA+VNCEUWV347PAPiMY7HcBAS1Xi+764HCnBL19x3hB3wihnUZHtPdhcFm4nansUgq3oERy7e1BiHKwPzps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779030314; c=relaxed/simple;
	bh=HTf0CYA7N9N3ycOlSsH2RN9JpiCBHmSJID9/ns/WmqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bx2O+lm3E7/0nyGNAp04vvrRXB0dO3pfRmYiJY8HTaDAeyAA52Nlo23lBukIzDabvtiZN/3MhqvA3RMSqOL3Ja7I7EwxyIzGwZGLjTzNMdJrC6YfSqSAubkV2+pj/+21I7EgsQwvhJxlXigVk18v3uAj1VB6qPjp2SMf0exHZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OacEpg0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980A7C2BCB0;
	Sun, 17 May 2026 15:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779030314;
	bh=HTf0CYA7N9N3ycOlSsH2RN9JpiCBHmSJID9/ns/WmqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OacEpg0BHllVT5dCFHETKkOb/zz7Q6gsVg68LmodwakwJs7TUwK+px4dfd2w1SItX
	 SroQwxfa2dxebFsbEq5TJ+CIIfKootwvJE9alpoAqCLALsL/IFibntmjImIo6CCP9v
	 hMhNc4WPIc2JRIvnEXCUpq8tzXLQEO89zHHz4GPzfn02Vy2WD/KGtkONSGloh3TuKG
	 zTh3oKtNfwX62moIN6h5K6pGVWelBPzdZq+/n9ZViXSd32bbfLO71eeE5RMVQpiDN3
	 nGkQ2RavjezKKqbnCJeZNZfRh96kfFQH5fC75f0aVKPwNl95uHNFBR4qHOR3oJIKut
	 ULi35LN7GpmSA==
Date: Sun, 17 May 2026 17:05:10 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Manish Baing <manishbaing2789@gmail.com>
Cc: lee@kernel.org, linusw@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: mfd: st,stmpe: fix PWM schema and drop
 legacy binding
Message-ID: <agnY16I4sYAdRd9T@monoceros>
References: <20260509193928.19030-1-manishbaing2789@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mjp4gispirhzowi5"
Content-Disposition: inline
In-Reply-To: <20260509193928.19030-1-manishbaing2789@gmail.com>
X-Rspamd-Queue-Id: 29B18561E09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8934-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--mjp4gispirhzowi5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] dt-bindings: mfd: st,stmpe: fix PWM schema and drop
 legacy binding
MIME-Version: 1.0

Hello,

On Sat, May 09, 2026 at 07:39:28PM +0000, Manish Baing wrote:
> The st,stmpe-pwm binding is already covered by the MFD schema in
> Documentation/devicetree/bindings/mfd/st,stmpe.yaml. However, the
> PWM subnode was missing a 'required' properties block. This allowed
> Device Tree nodes to pass validation even if the 'compatible'
> string was omitted. This omission could lead to probe failures
> at runtime.
>=20
> Fix the schema by adding the missing 'required' block and
> remove the obsolete and redundant text binding file.
>=20
> Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
> ---
> Changes in v3:
> - Added 'required' properties to the pwm subnode in st,stmpe.yaml
>   to close a validation gap identified by the Sashiko.
> - Updated commit message and description to reflect MFD subsystem changes.
>=20
> Changes in v2:
>  - Droppped the TXT file instead of converting to YAML, as the
>    functionality is already covered by st,stmpe.yaml.
>   =20
>  .../devicetree/bindings/mfd/st,stmpe.yaml      |  4 ++++
>  .../devicetree/bindings/pwm/st,stmpe-pwm.txt   | 18 ------------------

If the patch was split into two, each touching just one of the files,
there would be no need for merge coordination. Also logically it's two
patches. Would you mind splitting?

Best regards
Uwe

--mjp4gispirhzowi5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoJ2SQACgkQj4D7WH0S
/k7qMgf9F8VgNDKxylmZdIj4jJug5gFq8NLuFrwgb2rwAp26Bz+awUtEStzEzWKd
YpjTwUDqoiOqAam42pv06UN8+mKhBH9BVfekX4xbfyJ3WtQVCvea1hPgVXfWv7Ed
ADiMCiIY/8grsyCNp5IFeCgnhYBjn7gh4u+aCdhebcKWUnmTSZjcLAsncqe2WhWI
PLxxYjvuQyZ32cYE5w0TZ99ak4QNLT4kjaanPA92nxbT7RXSWs2d0OZOPdKAE0i9
s3Bu31dCoJ9u7XgQxtrlZGHxKMhuv6MBZdf+L73abLabw7tMi+nLe2V8p/nOv9AI
XTZoWFflGQwfAyG8uEGHOxvzIgCRyw==
=LQj8
-----END PGP SIGNATURE-----

--mjp4gispirhzowi5--

