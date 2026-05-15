Return-Path: <linux-pwm+bounces-8883-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFnMBMYkB2oEsQIAu9opvQ
	(envelope-from <linux-pwm+bounces-8883-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 15:51:02 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E648550C50
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 15:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25F44306F8AD
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 13:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6FF30C62D;
	Fri, 15 May 2026 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ki6lpypO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F7F30BBB9;
	Fri, 15 May 2026 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850387; cv=none; b=kUx/uegm/TA/BTxcSKfQKQTydDn6AmjgNVbGnBb31vACmDJIVOwEsdnPDlJzybJUXRKCCEo+m2ljUo6VTBxwi8B6+Yf7YGKaxumbfn4Qk47U5eTtmbFK3KdXXHrv027fcytqsO5g/PB6lk9U7gaUvqBfrVu4ifn8l8BH+TEJs3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850387; c=relaxed/simple;
	bh=uUeWRpb6xVmmL+Lm7CLlmRxmdTh61MhPLeJ6UxoXK48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FW8JIKBNtWTFEi7sP7EKyj3axCTpL6LCR142oBKBeTniRT3pCXeHMl5l+2aQjj+k9qIm/DI3FMj9ZqFZhKRs3Lkq3oY+DUgOGbPdavxhI/qWQ9jtbmeju9wPMPJ79qHjuZphYldL4l1McdkE8/28Dpa7mgB1vElTKp8z67wcrks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ki6lpypO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C42C2BCB0;
	Fri, 15 May 2026 13:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778850386;
	bh=uUeWRpb6xVmmL+Lm7CLlmRxmdTh61MhPLeJ6UxoXK48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ki6lpypOzKMiHDITLyOYMf1T4BOaUqjbJKKxUd91YQRXBCpxXWYiJQzi7lEjX/VNk
	 GdGuMXvO6plYdYaEpO8DthgdPZXsYlO3nkMNEgPnyjDHj0+myWDE1FMHPtj9rmaPN1
	 Er++cWiIZIMdYHN/uFVIfdzylgJzHF3L22wa+B3NyiPJBxRJu/U4Pv1MCRkuKBNWjs
	 FGlz6skdhT2o1jxQwKBHUCYdotqPfQeQvEu1WY9Kw2VBeTmJ/Pb+WtTLZKi3H8u04D
	 c40CopEGAbuQtKljOUTRlz3genvU1aKhvRGujsSYZR8p4xEFzH/jLQ49uSYAwLeLTM
	 ioi2NqvjCplZQ==
Date: Fri, 15 May 2026 14:06:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v18 1/3] dt-bindings: pwm: opencores: Drop starfive
 compatibles and update maintainers
Message-ID: <20260515-blinked-gigabyte-d2882372b616@spud>
References: <20260515054723.25024-1-hal.feng@starfivetech.com>
 <20260515054723.25024-2-hal.feng@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bsBRJFDfWIlVk/Sa"
Content-Disposition: inline
In-Reply-To: <20260515054723.25024-2-hal.feng@starfivetech.com>
X-Rspamd-Queue-Id: 0E648550C50
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8883-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,0.190.149.16:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--bsBRJFDfWIlVk/Sa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 01:47:20PM +0800, Hal Feng wrote:
> Each of the StarFive JH7100/JH7110/JH8100 SoCs has 8 OpenCores PTC IP
> cores. One OpenCores PTC IP core can output one PWM channel. The only
> difference among them is the register base address. There is no need
> to add starfive compatibles to distinguish them.

NAK, that's not an acceptable reason to remove soc-specific compatibles.

pw-bot: changes-requested

>=20
> I will maintain the pwm module in place of William.
>=20
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../devicetree/bindings/pwm/opencores,pwm.yaml         | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml b/D=
ocumentation/devicetree/bindings/pwm/opencores,pwm.yaml
> index 52a59d245cdb..834fb17ec595 100644
> --- a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: OpenCores PWM controller
> =20
>  maintainers:
> -  - William Qiu <william.qiu@starfivetech.com>
> +  - Hal Feng <hal.feng@starfivetech.com>
> =20
>  description:
>    The OpenCores PTC ip core contains a PWM controller. When operating in=
 PWM
> @@ -20,10 +20,6 @@ allOf:
>  properties:
>    compatible:
>      items:
> -      - enum:
> -          - starfive,jh7100-pwm
> -          - starfive,jh7110-pwm
> -          - starfive,jh8100-pwm
>        - const: opencores,pwm-v1
> =20
>    reg:
> @@ -48,8 +44,8 @@ additionalProperties: false
>  examples:
>    - |
>      pwm@12490000 {
> -        compatible =3D "starfive,jh7110-pwm", "opencores,pwm-v1";
> -        reg =3D <0x12490000 0x10000>;
> +        compatible =3D "opencores,pwm-v1";
> +        reg =3D <0x12490000 0x10>;
>          clocks =3D <&clkgen 181>;
>          resets =3D <&rstgen 109>;
>          #pwm-cells =3D <3>;
> --=20
> 2.43.2
>=20

--bsBRJFDfWIlVk/Sa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagcaSgAKCRB4tDGHoIJi
0vz7AQDnchzrkgpD5wwGGsBP0yvNyXSvs8NxJBiUXVHJNmwg0wEAgZFhi1GnKqLB
ujHGBW3J5oDRwL4QP5p0t03/7ZjktQU=
=shV9
-----END PGP SIGNATURE-----

--bsBRJFDfWIlVk/Sa--

