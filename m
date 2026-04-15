Return-Path: <linux-pwm+bounces-8592-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JFnJ86r32mOXgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8592-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 17:16:30 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49375405C48
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 17:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2733D312A609
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 15:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46A83DBD4D;
	Wed, 15 Apr 2026 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oh15y+Iq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903112F1FFC;
	Wed, 15 Apr 2026 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265794; cv=none; b=iwhSNi4Bmr1Q5gnytnRfbU/saAic+ZEvh1ImZmfC5bzUk6ZT+9ZgZJl1v7GGBkRWTv+LiV2eKfJnDyprjnh5iFOALSIP4or1KSW4ElGrrt3b5d6/iNl79ln1v2uqal+HWtcib0IBGYOAOQAAds/FxacnFe/jE/j0PQPXcKqyDGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265794; c=relaxed/simple;
	bh=KCG8cdPVc9jRDsdzNql7/57RznYdhKNf91J2Z2mqsh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLn+DiCy0Jb8IKwmeeZA+ywQtPp1nmn5dFgnrVMDnxA6qnbTXy+o+mtrlLg5FPWjkmvjl2Sn3cisz9kwMbqm27PPOnWCFrPxxl5Cvinpcdi+8zEdOKg5zLLTHySPo0Jzr/dXNY2KCkM+uDm3EFdx+lN0uhA06wa64ClbvK5TvUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oh15y+Iq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B31AC2BCB4;
	Wed, 15 Apr 2026 15:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776265794;
	bh=KCG8cdPVc9jRDsdzNql7/57RznYdhKNf91J2Z2mqsh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oh15y+Iq+fXE/Fa3dXgFXNh21sPDrUGip6cCiu2raR12q2phTTC+sT8cvj8W/CDJv
	 IXmfgmuJF5fyf40Y37ng8nO8lpggv4maxk9JWDx/poECPuzsxf5uC4vVryl0ESm0A8
	 uBRLnR5uosqFiPxV2VTzE9R0r+6ipmITo2u2REU6skbRbRQQGi2UtyJU+lPYKNx/yW
	 ziWxyyCcOv22ak6bInHEeamVDAxzaERIK+iuk240UWAFAkuT3yPeafWU0jczxxXybA
	 K9Hg5j0an5ct1WqgF6nEVuWLDiN8fKKsgfUOBaZ41LoEVTK1lrYIjoILxKHcZGYE0n
	 zKPj45SSx86Lg==
Date: Wed, 15 Apr 2026 16:09:49 +0100
From: Conor Dooley <conor@kernel.org>
To: dongxuyang@eswincomputing.com
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v4 1/2] dt-bindings: pwm: dwc: add reset optional
Message-ID: <20260415-reacquire-handstand-d1923af82c9d@spud>
References: <20260415094908.1539-1-dongxuyang@eswincomputing.com>
 <20260415095020.1597-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PLShwbF4Er3TfYyf"
Content-Disposition: inline
In-Reply-To: <20260415095020.1597-1-dongxuyang@eswincomputing.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8592-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[eswincomputing.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49375405C48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--PLShwbF4Er3TfYyf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 05:50:20PM +0800, dongxuyang@eswincomputing.com wro=
te:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
>=20
> The DesignWare PWM includes separate reset signals dedicated to each clock
> domain:
> The presetn signal resets logic in pclk domain.
> The timer_N_resetn signal resets logic in the timer_N_clk domain.
> The resets are active-low.
>=20
> Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>

This commit implies that your hardware differs from existing devices,
I think you should add a device-specific compatible.

> ---
>  .../devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml       | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm=
2.yaml b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
> index 7523a89a1773..a8bbad0360f8 100644
> --- a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
> +++ b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
> @@ -43,6 +43,9 @@ properties:
>        - const: bus
>        - const: timer
> =20
> +  resets:
> +    maxItems: 2
> +
>    snps,pwm-number:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: The number of PWM channels configured for this instance
> --=20
> 2.34.1
>=20

--PLShwbF4Er3TfYyf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCad+qPAAKCRB4tDGHoIJi
0ifKAQC2Qc9/PX+2nsoGaciKkiI2QG1DN1VGhdlrzM4rBOQSBQEApmJ24kx2JyYT
qA4Rx+0R2WrsJpKZevK7o5CAlD12xgQ=
=swXi
-----END PGP SIGNATURE-----

--PLShwbF4Er3TfYyf--

