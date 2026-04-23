Return-Path: <linux-pwm+bounces-8680-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAGqHhtY6mkhxgIAu9opvQ
	(envelope-from <linux-pwm+bounces-8680-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2026 19:34:19 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 537F94558D2
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2026 19:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B044330011B2
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2026 17:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD79735F161;
	Thu, 23 Apr 2026 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8bIPJCu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0AA1D6DB5;
	Thu, 23 Apr 2026 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965452; cv=none; b=cCjPSpm1BqmNrpP0M52xM1Vzp1bDkhwXdMey18RM1S4ebb3izmiZ7RpnBcXduNt5qLXSTJiBbzem1XVftTsKyF/YQaRxChi9gkrEYnTHzTjUaVNCHKrrwwSEfWc1EX6GSSNUUdAejgYOcEITdebo4ncwDLatuJWLmW1Dkjzos/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965452; c=relaxed/simple;
	bh=GTND1Ycvcov57U/LCP6zxwu5n+6TXmKmS7CxyVPvXW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oy14baHcjCdcj8Kn/+E4p6zP6jvp9vjx5vIuOal17D8wQ9xuYtAjTQinP5xadtKLPwccOQxTj9TE5TSctnHnfBgM7BSZe8OL1/l2uw0IOmXxIxUFeWHCgqzL2PHgiFBHMKrjHeBlRjieDEZDeJN4ItC2saL3V36n0dEj5eI4em0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8bIPJCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48497C2BCAF;
	Thu, 23 Apr 2026 17:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776965452;
	bh=GTND1Ycvcov57U/LCP6zxwu5n+6TXmKmS7CxyVPvXW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M8bIPJCu4NO+rJckavr78vqTxV23Se6NSBzU1JZFMlHgshRVDRmU9jqMYwaE7Jb5o
	 z8KhIFGWK8gBUyxr44pzM0mLUfXkLDEUOdGsUXZIqgDSNXciPu5/ZHve/OBMeuE7rf
	 ZfhSdm4skqb+HMwMzxj1674F2morgEJFDwh/IdAnxa5uC9sd7tUypDNfJrRc+AdsH+
	 o3JD7A5yCBSuSowC6ZralfQ9BIZaY8tu8vc8mrvnHKlA+GnBTqXazSf+bDKkOquUrD
	 tm+EqOp9M2JJZqgv79qInO54l6g4BR24WS1WMwx+JN1l3h8wb6aARDlEXWaYNXqxQx
	 qeAJp5LWcHv5w==
Date: Thu, 23 Apr 2026 18:30:46 +0100
From: Conor Dooley <conor@kernel.org>
To: dongxuyang@eswincomputing.com
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v5 1/2] dt-bindings: pwm: dwc: add optional reset
Message-ID: <20260423-reformist-humpback-38a087567cb2@spud>
References: <20260423083644.1168-1-dongxuyang@eswincomputing.com>
 <20260423083731.1226-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UfISgeyQ1QZtmGZk"
Content-Disposition: inline
In-Reply-To: <20260423083731.1226-1-dongxuyang@eswincomputing.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8680-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,eswincomputing.com:email]
X-Rspamd-Queue-Id: 537F94558D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--UfISgeyQ1QZtmGZk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 04:37:31PM +0800, dongxuyang@eswincomputing.com wro=
te:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
>=20
> The DesignWare PWM includes separate reset signals dedicated to each clock
> domain:
> The presetn signal resets logic in pclk domain.
> The timer_N_resetn signal resets logic in the timer_N_clk domain.
> The resets are active-low.
>=20
> EIC7700 use DesignWare IP for PWM controllers. Add ESWIN EIC7700 support
>  in snps,dw-apb-timers-pwm2.yaml
>=20
> Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
> ---
>  .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml | 29 ++++++++++++++++---
>  1 file changed, 25 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm=
2.yaml b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
> index 7523a89a1773..d9685fdd72a7 100644
> --- a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
> +++ b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
> @@ -20,12 +20,11 @@ description:
>    instead of having to encode the IP version number in the device tree
>    compatible.
> =20
> -allOf:
> -  - $ref: pwm.yaml#
> -
>  properties:
>    compatible:
> -    const: snps,dw-apb-timers-pwm2
> +    enum:
> +      - snps,dw-apb-timers-pwm2
> +      - eswin,eic7700-pwm
> =20
>    reg:
>      maxItems: 1
> @@ -43,6 +42,12 @@ properties:
>        - const: bus
>        - const: timer
> =20
> +  resets:
> +    minItems: 1
> +    items:
> +      - description: Interface bus reset
> +      - description: PWM timer logic reset
> +
>    snps,pwm-number:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: The number of PWM channels configured for this instance
> @@ -54,6 +59,22 @@ required:
>    - clocks
>    - clock-names
> =20
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: eswin,eic7700-pwm
> +    then:

> +      properties:
> +        resets:
> +          items:
> +            - description: Interface bus reset

This doesn't do anything, I don't think.
Drop it, and just keep the required.

pw-bot: changes-requested

Thanks,
Conor.

> +      required:
> +        - resets
> +
>  additionalProperties: false
> =20
>  examples:
> --=20
> 2.34.1
>=20

--UfISgeyQ1QZtmGZk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaepXQwAKCRB4tDGHoIJi
0l63AP4ycP0afs7TwMLUo++yGtNXvxVBFX6hdfYmANqipvFjwwEA/eV6zaED8sb+
JdySiKyDQORTMKWdoWMaBYxuJiJlEgM=
=+1Of
-----END PGP SIGNATURE-----

--UfISgeyQ1QZtmGZk--

