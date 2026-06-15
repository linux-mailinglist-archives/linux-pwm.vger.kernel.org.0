Return-Path: <linux-pwm+bounces-9294-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bxdmMV0oMGrFPAUAu9opvQ
	(envelope-from <linux-pwm+bounces-9294-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 18:29:17 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 449DB6885FA
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 18:29:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Jy+Ozi8P;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9294-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9294-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC3053030E81
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 16:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C07409621;
	Mon, 15 Jun 2026 16:21:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD9326A08F;
	Mon, 15 Jun 2026 16:21:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540508; cv=none; b=qYgfPNmBd/RTXaOQ3khjUAocoKcL//BTXS4HWGDYQMPI7YjOmrr9sBpElhKEjaFyFuGcVr5Xr++SZaZs8JEM+9wnP0hnsq7w91+cZeoCOZQqKSkFOCVCNdJP5B5HjbnTtC7En0wmj23v3Bm8HjYub++cL4n+UgIZGOQvw0XOwSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540508; c=relaxed/simple;
	bh=+vCt8wTM9Npm4U8YerLAns+3stHN72VODCcpHupT8ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSWbnCELpxzDeCqOhy4Jz1LSdxJz2tee4J4zHdtmIRjHbQjQxsL5Ancu15U8H3SnmS4UyhVmrC6pnPr7UK9yAKcLRBNYjxmlkCNVvtya9krRkdqfK7MyNNfnZLz2/+d590dPkoEUH2fUcOY6AKnPDnMbQ9sAGz1eD2EHEF2Zt9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jy+Ozi8P; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9B11F00A3A;
	Mon, 15 Jun 2026 16:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781540507;
	bh=KVQGn0OT9TN5mU4TSLj+eoo/72aHXUhKV8j0BCeT7bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jy+Ozi8Pcj9d7ElLFtaOP/dMljwKLHonFWLotwyx+wwU/gxWxXJJ91rM+yV1l6q12
	 srerybYO7mu2RGAtbJ9gzP4y+QGkQ3X7LjYYIQ3h2nGnQnlVyihOCM87QhVtjxRIyX
	 FWipXHW4NN5GJvninCinVxC0OFNMlw7mQXgPKKgCJAoXt6cd2oeXonz9XtuIXrkpxK
	 hJa4kCZX+i3fX3jriSCqx9qTD+ShyDwQzrncjySPBerK0022eNdk6viGA6ewhgJD6C
	 0xTa9g8tmwXBHrEOeL/bREvCVeTztiqP37JDqMdhaJGDKdWhj543V/JRzU7ztdM07U
	 xblxrT2jX8i8g==
Date: Mon, 15 Jun 2026 17:21:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v19 1/3] dt-bindings: pwm: opencores: Update compatibles,
 examples and maintainers
Message-ID: <20260615-crescent-equation-d948fcc46cd1@spud>
References: <20260615155759.129210-1-hal.feng@starfivetech.com>
 <20260615155759.129210-2-hal.feng@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H8PfMBgNawoYkmL4"
Content-Disposition: inline
In-Reply-To: <20260615155759.129210-2-hal.feng@starfivetech.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:hal.feng@starfivetech.com,m:ukleinek@kernel.org,m:p.zabel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:emil.renner.berthing@canonical.com,m:palmer@dabbelt.com,m:pjw@kernel.org,m:aou@eecs.berkeley.edu,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9294-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,spud:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,devicetree.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 449DB6885FA


--H8PfMBgNawoYkmL4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 11:57:57PM +0800, Hal Feng wrote:
> Remove the jh8100 compatible since the JH8100 SoC has been canceled and
> will not be released. Add the jhb100 compatible to replace it.

> Use a oneOf construct to support the single-string opencores,pwm-v1
> compatible.

No thanks. Simple as this IP might be, I still want soc-specific
compatibles to be a requirement.
pw-bot: changes-requested

Thanks,
Conor.

>=20
> Change the register size in examples to 0x10, since an OpenCores PTC IP
> has only 4 32-bit registers: CNTR, HRC, LRC and CTRL.
>=20
> I will maintain this pwm module in place of William.
>=20
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../devicetree/bindings/pwm/opencores,pwm.yaml   | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml b/D=
ocumentation/devicetree/bindings/pwm/opencores,pwm.yaml
> index 52a59d245cdb..5f05606a2d3d 100644
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
> @@ -19,12 +19,14 @@ allOf:
> =20
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - starfive,jh7100-pwm
> -          - starfive,jh7110-pwm
> -          - starfive,jh8100-pwm
> +    oneOf:
>        - const: opencores,pwm-v1
> +      - items:
> +        - enum:
> +            - starfive,jh7100-pwm
> +            - starfive,jh7110-pwm
> +            - starfive,jhb100-pwm
> +        - const: opencores,pwm-v1
> =20
>    reg:
>      maxItems: 1
> @@ -49,7 +51,7 @@ examples:
>    - |
>      pwm@12490000 {
>          compatible =3D "starfive,jh7110-pwm", "opencores,pwm-v1";
> -        reg =3D <0x12490000 0x10000>;
> +        reg =3D <0x12490000 0x10>;
>          clocks =3D <&clkgen 181>;
>          resets =3D <&rstgen 109>;
>          #pwm-cells =3D <3>;
> --=20
> 2.43.2
>=20

--H8PfMBgNawoYkmL4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajAmkwAKCRB4tDGHoIJi
0sH2AQCoyaF1bRjxjw2x0+m09ZjoTIXK1KvTYBZNxYnjdxzABQD/Xh/8foQ3B44U
/lzPJaQXkyivFCdzq9zNipew1n9JpQI=
=+lHT
-----END PGP SIGNATURE-----

--H8PfMBgNawoYkmL4--

