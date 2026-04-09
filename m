Return-Path: <linux-pwm+bounces-8536-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAqMNJnJ12k/TAgAu9opvQ
	(envelope-from <linux-pwm+bounces-8536-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Apr 2026 17:45:29 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D1C3CCF2A
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Apr 2026 17:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D59423015CAF
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Apr 2026 15:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AE53DD524;
	Thu,  9 Apr 2026 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPF2pvnr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64A32F549C;
	Thu,  9 Apr 2026 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749310; cv=none; b=n8t+zN7GHIqz1yC/wPutAVBQUoMnjEzjC+PMsBD0BWn051cFLbfPGcWxJnDAQ7zjwLmicg2yqmTsPb8+G26kk7LR4+dN5fhIR2cAn8ITI7r0+tNIha39cWMAAG13gCplxYxYhyPUFrwgxsbxgx6j59osomre1uD0lGrOGQawQOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749310; c=relaxed/simple;
	bh=osskFND0gD7NhmG8a1qgihTn2NK1itGDCwQVH1cu8EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuuW08isTEvAu8upkkZxpqy0zuFPxLQrEYRk2JNZ2WBTPDAApt+AbYMTQmhaZdt2JRrWqN8fvEpUNfVtyKoxxfjG6Bd5UoS6M9XMkFdguCB4v39dSRBydpMqU08AAcBhHl0Dqk0UBz355sZWmpyzcIhFbM7fCIdQK2fRxzeMBDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPF2pvnr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEF9C4CEF7;
	Thu,  9 Apr 2026 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775749309;
	bh=osskFND0gD7NhmG8a1qgihTn2NK1itGDCwQVH1cu8EI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPF2pvnr2fSjiJLAMO6Bh4704uS8IM2kd4jIdmqJh9Kp3mr8aIgS9maEMa8S/y78v
	 LH7IIjy3xqgecHDnFGGUBj5+8PdSyfnTJvpQnVPN0Yqab+yKL4ViF/ouT35Mnv2jDS
	 5G5shg0YpHicJ2REZOgP7eWyN65ODI2QFSzA9/UqGx0UP6XL3S3Aix4UM/JbUR0Ya9
	 V/xFtEYPlTi/gjz9++HViNAHO7mkBxGDfCqr1Wezl8ooJcvEZpPlCP0TCT0UkJQ9S+
	 8wxkIcx0c/Ddt48BXco7b+FNdDtY5H7/7/FDtPBANKFLGu97Y7cUjN34VCWpdXQ9QT
	 AWYXRwY8V2TBw==
Date: Thu, 9 Apr 2026 16:41:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Yixun Lan <dlan@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: Re: [PATCH 1/2] dt-bindings: pwm: marvell,pxa-pwm: Add SpacemiT K3
 PWM support
Message-ID: <20260409-laboring-announcer-4a0f9ca152a1@spud>
References: <20260409-03-k3-pwm-drv-v1-0-1307a06fba38@kernel.org>
 <20260409-03-k3-pwm-drv-v1-1-1307a06fba38@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5LSQ/VAQK69bVtgG"
Content-Disposition: inline
In-Reply-To: <20260409-03-k3-pwm-drv-v1-1-1307a06fba38@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8536-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75D1C3CCF2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--5LSQ/VAQK69bVtgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2026 at 12:45:11AM +0000, Yixun Lan wrote:
> The PWM controller in SpacemiT K3 SoC reuse the same IP as previous K1
> generation, while the difference is that one additional bus clock is
> added.
>=20
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  .../devicetree/bindings/pwm/marvell,pxa-pwm.yaml   | 53 ++++++++++++++++=
++++--
>  1 file changed, 50 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml b=
/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> index 8df327e52810..3427c8ef3945 100644
> --- a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> @@ -15,7 +15,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: spacemit,k1-pwm
> +            enum:
> +              - spacemit,k1-pwm
> +              - spacemit,k3-pwm
>      then:
>        properties:
>          "#pwm-cells":
> @@ -26,6 +28,38 @@ allOf:
>            const: 1
>            description: |
>              Used for specifying the period length in nanoseconds.
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - spacemit,k3-pwm
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: func
> +            - const: bus

This condition here doesn't appear to do anything? It just repeats
what's already done unconditonally below?

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - spacemit,k3-pwm
> +    then:
> +      required:
> +        - clock-names
> +      properties:
> +        clocks:
> +          minItems: 2
> +        clock-names:
> +          minItems: 2
> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +        clock-names:
> +          maxItems: 1
> =20
>  properties:
>    compatible:
> @@ -36,7 +70,9 @@ properties:
>            - marvell,pxa168-pwm
>            - marvell,pxa910-pwm
>        - items:
> -          - const: spacemit,k1-pwm
> +          - enum:
> +              - spacemit,k1-pwm
> +              - spacemit,k3-pwm
>            - const: marvell,pxa910-pwm
> =20
>    reg:
> @@ -47,7 +83,18 @@ properties:
>      description: Number of cells in a pwm specifier.
> =20
>    clocks:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description: The function clock
> +      - description: An optional bus clock
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2
> +    oneOf:
> +      - items:
> +          - const: func
> +          - const: bus
> =20
>    resets:
>      maxItems: 1
>=20
> --=20
> 2.53.0
>=20

--5LSQ/VAQK69bVtgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCadfIuQAKCRB4tDGHoIJi
0vTwAQD8Zicv16Y94gH/9FvNtIYLGGbQLZjiTxnKjtWIjHV5kAEAkqvgTcnemFRq
wbBFrWGiCKv5Hfvy64V1KtjG8qjk+AE=
=qWVE
-----END PGP SIGNATURE-----

--5LSQ/VAQK69bVtgG--

