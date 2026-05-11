Return-Path: <linux-pwm+bounces-8866-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEOCOGwqAmp0ogEAu9opvQ
	(envelope-from <linux-pwm+bounces-8866-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 21:13:48 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 934AF514E2E
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 21:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E0FE30238F0
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 19:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FB04C9576;
	Mon, 11 May 2026 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW11rcba"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF624C956E;
	Mon, 11 May 2026 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526788; cv=none; b=JODx6pN5ClZ1CiL5hvziJBjrph76BI5dqV4aHnkmeQTuXFdMYPV07u41yQTOcIZAws5Qe/jWSZEwQACSsbngPG1voqBEyxsuZHlHIilQIl2PrnrsXCK/TNJvnzEcfHm+o6N5THdrLqV92Rh3ZYiu8n+xen4N5o7xehk2SGXAa4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526788; c=relaxed/simple;
	bh=X12OJNlVrW0M7yx3AAq/R0gndQECFEYKmSvs2udKSlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeoW28t3auxMsyVVM6dAbLy0Vi/Cj9Ii/2eZlRg5aDBVcl71liV5+L0us7WGyI8WLpDU+nWzAvymiBFlzEUj6se/hh6I85gzGtPUai7mfmOxRaT4mpTFxgBuVQZ2V860/uS8GjE3A2GIOq2sUGyL/fx7AcPC707qlPjkpSrv4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW11rcba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7717DC2BCB0;
	Mon, 11 May 2026 19:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778526788;
	bh=X12OJNlVrW0M7yx3AAq/R0gndQECFEYKmSvs2udKSlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NW11rcbanvSH3mYPfsfnY5FskXYqRF81nyAFznyqOu+Tj9fS9Fn2UP2Uger7MH+xX
	 OIPltO+ignTcczF/De/23UMbQbAvZYWi0wiq9qGlWRO3TcQ/us/2Y0jggFmxj1RASE
	 d7uy5V1i4kkTehiSes1hCgz/kMkxqxwq98/hBwWLyoBbuHCTtnpQBoeBgLg5JqRTc+
	 QeQbjbCU9IHFabdjgefF0t7Vw8f4uDvx9GsYBnLqq1h3VgVq0tL+4SLZjVRyGkU9Te
	 kAJOvGdNaIR8oN+JbZk9uAncauxpHUbngHEA4A0XNKWEqk/mzyj4SmSH7VF3LFYfXX
	 NuWwV+XnIg/ZA==
Date: Mon, 11 May 2026 21:13:04 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Manish Baing <manishbaing2789@gmail.com>
Cc: lee@kernel.org, linusw@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: mfd: st,stmpe: fix PWM schema and drop
 legacy binding
Message-ID: <agIp2LODsGzHdPzw@monoceros>
References: <20260509193928.19030-1-manishbaing2789@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ojcn2z3s6bmijsju"
Content-Disposition: inline
In-Reply-To: <20260509193928.19030-1-manishbaing2789@gmail.com>
X-Rspamd-Queue-Id: 934AF514E2E
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
	TAGGED_FROM(0.00)[bounces-8866-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
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


--ojcn2z3s6bmijsju
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] dt-bindings: mfd: st,stmpe: fix PWM schema and drop
 legacy binding
MIME-Version: 1.0

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

Reviewed-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Lee: If you want to apply that patch, that's fine for me (take my

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

for that). If I should take it, I'm happily taking your's :-)

Best regards
Uwe

--ojcn2z3s6bmijsju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoCKjoACgkQj4D7WH0S
/k5puQf9FNIJGXHuObG07U1AYJ6EVJK43xAHsxWJ4826SymtYp2+r0Pt005bbShx
QWVyaUgwmznt5j81FetFONeelX5eyASciJicMUOrDSeRZSyE64cdqaACaZgpgoOu
CxS2URF2uTN2fr01n7pHoX1mCp3VHeMHu7SpoBkc6Enh0X96tGRYJXVSQR57Sy2R
1muyW41Ijpfckw+5DOPPgV8wgnXdPcv9zWOpHRpO3WOl8maOaTkZ3beZkzdnkqcJ
lYPtb8UJG55q5ZPw5k/ja3GegXWpzCHmGwCl77TQufhudnwcVyMcxP72WQSXh9Js
BIdwoNz1fMDKIOuqS32bnxRqdtrMUw==
=9yEQ
-----END PGP SIGNATURE-----

--ojcn2z3s6bmijsju--

