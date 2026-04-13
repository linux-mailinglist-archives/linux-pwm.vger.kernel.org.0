Return-Path: <linux-pwm+bounces-8564-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDt/Lees3GnfVAkAu9opvQ
	(envelope-from <linux-pwm+bounces-8564-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 10:44:23 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED883E93FE
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 10:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 803143007352
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 08:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D880F3AC0C6;
	Mon, 13 Apr 2026 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mo8j61F+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45E5358387;
	Mon, 13 Apr 2026 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776069698; cv=none; b=ESfCFYWGMW8q+zUmmMZglFeybGTTjaRTpOHfhGS+R+AnEjxUGUWAnrLd2mV/xYXtFWb/S416eJTp94pfXiiG67lg1MannOnPtGGzzZg2ExYp2jwSajx+ZuBEBtUo9p4Ir89H71D4AK6vLnwf7uRVbwYlyfrKb0bKU22TybrJl+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776069698; c=relaxed/simple;
	bh=CzscNGsaA+UhgjrPgG/+td4JzxeFauGxoMq3piF+TTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8WqRJtDt5w/B91rEfkFveKBGaWBY56xOdZTXPzmLH8mmovgQl/UVKLQ2sKkhxKd6Rn0wa/fq5s0xrceJ7oRdsHDdV581mVkItyY1kgs9Vie4YFAaiSjwvzeILA4Ul9HmUEi3CNtJlR2BwRtcRZHJZCXJkodIOfDyFo9n6qtLuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mo8j61F+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F43EC2BCAF;
	Mon, 13 Apr 2026 08:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776069698;
	bh=CzscNGsaA+UhgjrPgG/+td4JzxeFauGxoMq3piF+TTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mo8j61F+VqA8etchCMy3Xq8ARFe5SBn1hRjwAsAAcE3lMYqnryLBsgXhTw5226dmZ
	 4AHXwl7qSh+e9eMA3YQ0rB5pRTbHXUCCRckVxXx/o6TUWve2G+OtdfmISd9dWQmO+a
	 SkobmwwUmvNjqINhZ4eZUI2byliI6lQgw4aw/f2QtUpUAdh6nVE7koGLfqTEScwB8l
	 OJ7S5HKoXLaAUF7HO2w3tuxDvrkfhyhWMz20EW7iwPoeeR7stanHbUX2bJ30wW3wgN
	 V7WY0gDUP+5svP6vMlhHJF/ULNyU0bJTRRRDqZwmJEZ8nvSntBrkuv2XnFXr2mqVp5
	 Lin/pKAHRXaMw==
Date: Mon, 13 Apr 2026 10:41:36 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Xilin Wu <sophon@radxa.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nikita Travkin <nikita@trvn.ru>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: clk-pwm: add optional GPIO and
 pinctrl properties
Message-ID: <adyr_17yvFGkihU5@monoceros>
References: <20260406-clk-pwm-gpio-v1-0-40d2f3a20aff@radxa.com>
 <20260406-clk-pwm-gpio-v1-1-40d2f3a20aff@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="otu3p5uza5t3du76"
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8564-lists,linux-pwm=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,radxa.com:email]
X-Rspamd-Queue-Id: 1ED883E93FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--otu3p5uza5t3du76
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] dt-bindings: pwm: clk-pwm: add optional GPIO and
 pinctrl properties
MIME-Version: 1.0

Hello,

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

A constant output isn't needed when disabled. The state is undefined
then. A plain clk_disable() is fine then.

Best regards
Uwe

--otu3p5uza5t3du76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmncrD0ACgkQj4D7WH0S
/k59gwgAtI9LaFJ3xNOkXSrpmFikrs3B+lqtLZoFfo+w/dt6M0kUPzAkD9gAC3HO
3bGEfSiLxGQNDCGP0cIMsb0YMnbTvVF1YhmYNJTl2CTa6LRJSeu7Ap16zgmFoo3q
KSKtBcQUF7YpcMhvzlHvF8xW9geY7EjG3Ri71ddC8hWesn7kBGAp3Z3wmrWnhD1n
QJkECWSOD2g9M/KWceo0uj90c8FBkpEJ9oWQMiK49eXo1xAtdJrydQOSUJistys1
bAZ69hHgp5dCtHBp1hhdL7LAb4P1z/YdtODy4UvovlhY2OBjQwlg88WqoPhqxhbA
qKLdbQkDVS8WBQbL+SILKecKn6z4mw==
=21vy
-----END PGP SIGNATURE-----

--otu3p5uza5t3du76--

