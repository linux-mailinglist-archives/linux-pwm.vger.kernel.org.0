Return-Path: <linux-pwm+bounces-8537-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEVXNjnO12mrTAgAu9opvQ
	(envelope-from <linux-pwm+bounces-8537-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Apr 2026 18:05:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCAC3CD583
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Apr 2026 18:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B63F8307BA7D
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Apr 2026 15:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB6D3DEFE3;
	Thu,  9 Apr 2026 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnZdWYrL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB30322A;
	Thu,  9 Apr 2026 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749882; cv=none; b=am+ybxoOXdQ64NYcyorCu3Pwx5L7iZIp4pjpdPbXDEzLOL+kZJWbAOvX9+Xg0nVEUD/7mBr0scRtC+Rg7nX4khYw7QaUElzU2OH+9IINiC8+OtP2vHhOs99e54t2nABdGX/DSM1gtXPCaOQNuGpJhN3AzR3hmlPMpzlnW7cmh9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749882; c=relaxed/simple;
	bh=hB0eWWESHHTJR+dU00r4L7DsK/AgrZD+1lM9AWRiaOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1IRW1uDtb9ydWJj2jDc1nSCfMG0gLpQrnP9K8U6p4ddWOUUb0h02MaRt/m7AgbdfrEBA0wuULY5ziVZ24o20ARW3DV8AUOSHIe/PKjYNRj429Ot+B4Bb5O+hY8fbW8YXfXAgJr4b68ZjsP3vKujsJ+GLI+PzriWqa3hN2zCmU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnZdWYrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE03C4CEF7;
	Thu,  9 Apr 2026 15:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775749881;
	bh=hB0eWWESHHTJR+dU00r4L7DsK/AgrZD+1lM9AWRiaOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HnZdWYrLyuo5Vu7I8Lb4+H9UxgMVIODfowMSezczofLBmciAEKlEvGBI2GD1/BY/S
	 Lc9bPzXyUMGQNC3m0LNtyP83I0jgNNBqwmNNVaJfHG2i+0ya8LP+jLhs0sVUgGQnpe
	 IllaXyA7M1alX6ZBI6nYaqzIwloJ8qJF1dqCmstEc/Z/UcC/JdC9EFa1bRVZZv9G4t
	 ubwC9NseG/pP7sq1i5cpqaCCICjV0IhrqBUkWuvvHEwJsnImMvh0jZPsjEv3bR6Cc3
	 Cy75PT7kJQ1tL/hIRinUwV3R14HzNOTfAxmm4f2h80R6md/lwOv8VB25JZ/Gdnhsju
	 4AyUh3sv55GPw==
Date: Thu, 9 Apr 2026 16:51:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Xilin Wu <sophon@radxa.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: clk-pwm: add optional GPIO and
 pinctrl properties
Message-ID: <20260409-delicate-simile-aeb987caa126@spud>
References: <20260406-clk-pwm-gpio-v1-0-40d2f3a20aff@radxa.com>
 <20260406-clk-pwm-gpio-v1-1-40d2f3a20aff@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vqaEmz6ZUNR8yPit"
Content-Disposition: inline
In-Reply-To: <20260406-clk-pwm-gpio-v1-1-40d2f3a20aff@radxa.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8537-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 7CCAC3CD583
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--vqaEmz6ZUNR8yPit
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2026 at 11:50:01PM +0800, Xilin Wu wrote:
> The clk-pwm driver cannot produce constant output levels (0% or 100%
> duty cycle, or disabled state) through the clock hardware alone - the
> actual pin level when the clock is off is undefined and
> hardware-dependent.
>=20
> Document optional gpios, pinctrl-names, pinctrl-0, and pinctrl-1
> properties that allow the driver to switch the pin between clock
> function mux (for normal PWM output) and GPIO mode (to drive a
> deterministic constant level).
>=20
> Signed-off-by: Xilin Wu <sophon@radxa.com>

This seems reasonable enough to me, but the PWM maintainers should
defintely make sure this fits the ideology of the device.
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> ---
>  Documentation/devicetree/bindings/pwm/clk-pwm.yaml | 36 ++++++++++++++++=
+++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/clk-pwm.yaml b/Documen=
tation/devicetree/bindings/pwm/clk-pwm.yaml
> index ec1768291503..2a0e3e02d27b 100644
> --- a/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
> @@ -15,6 +15,11 @@ description: |
>    It's often possible to control duty-cycle of such clocks which makes t=
hem
>    suitable for generating PWM signal.
> =20
> +  Optionally, a GPIO and pinctrl states can be provided. When a constant
> +  output level is needed (0%, 100%, or disabled), the pin is switched to
> +  GPIO mode to drive the level directly. For normal PWM output the pin is
> +  switched back to its clock function mux.
> +
>  allOf:
>    - $ref: pwm.yaml#
> =20
> @@ -29,6 +34,26 @@ properties:
>    "#pwm-cells":
>      const: 2
> =20
> +  gpios:
> +    description:
> +      Optional GPIO used to drive a constant level when the PWM output is
> +      disabled or set to 0% / 100% duty cycle. When provided, pinctrl st=
ates
> +      "default" (clock mux) and "gpio" must also be defined.
> +    maxItems: 1
> +
> +  pinctrl-names: true
> +
> +  pinctrl-0:
> +    description: Pin configuration for clock function mux (normal PWM).
> +    maxItems: 1
> +
> +  pinctrl-1:
> +    description: Pin configuration for GPIO mode (constant level output).
> +    maxItems: 1
> +
> +dependencies:
> +  gpios: [ pinctrl-0, pinctrl-1 ]
> +
>  unevaluatedProperties: false
> =20
>  required:
> @@ -41,6 +66,15 @@ examples:
>        compatible =3D "clk-pwm";
>        #pwm-cells =3D <2>;
>        clocks =3D <&gcc 0>;
> -      pinctrl-names =3D "default";
> +    };
> +
> +  - |
> +    pwm {
> +      compatible =3D "clk-pwm";
> +      #pwm-cells =3D <2>;
> +      clocks =3D <&gcc 0>;
> +      pinctrl-names =3D "default", "gpio";
>        pinctrl-0 =3D <&pwm_clk_flash_default>;
> +      pinctrl-1 =3D <&pwm_clk_flash_gpio>;
> +      gpios =3D <&tlmm 32 0>;
>      };
>=20
> --=20
> 2.53.0
>=20

--vqaEmz6ZUNR8yPit
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCadfK9QAKCRB4tDGHoIJi
0sSaAP9vvdqzucIMwzCAvF0iTFADxj0er61PAqFEmTSuCEkk7AEAqHP8OlNVB4yF
HnZfU4XNEA1EfWbYNkaSaB5ziBgzXAg=
=dw+x
-----END PGP SIGNATURE-----

--vqaEmz6ZUNR8yPit--

