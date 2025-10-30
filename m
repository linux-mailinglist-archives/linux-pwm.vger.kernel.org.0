Return-Path: <linux-pwm+bounces-7550-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0FBC216BC
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 18:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86DD94F0057
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 17:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872B7368382;
	Thu, 30 Oct 2025 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pof1RBvX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571EA3678B1;
	Thu, 30 Oct 2025 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844425; cv=none; b=LH4WFE658RqJf00rtiUq6Vt/hAImuLfPi9prMn841P79DajdPJfgQt8f0eIkJ/lJPuyRdvm7awtL7NIuz1EssWJtTZG+PBJL4PwP/1p34ORDomI091G+C4xz/gVqJ+no1+J83Bck8PAmvM34HnI07jClpZXpgT+Jm/81E3t+TJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844425; c=relaxed/simple;
	bh=Ga2UaOapRGo+y9uUOsUqRMoBHpskEFYaGzTydEs8NIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGyVlTDYxJLEIZulj8d/psg/1I4CuIKgCi1YSYi3SfXpUcTCjy3cjKuvGW6vpMu9efD4IqS03+dXMU1hGeZIVhkqRJOuQF6DHMPK4JxEvMmx+Jf/G4K4vVT8dmzwZduqduqj6RjGgBh0lx+ZpKJpsmOo8LFai6EKVfNiyF0thgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pof1RBvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BBCC4CEF8;
	Thu, 30 Oct 2025 17:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761844424;
	bh=Ga2UaOapRGo+y9uUOsUqRMoBHpskEFYaGzTydEs8NIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pof1RBvX5cRsFJAezLFcWBGDW7rsV1c4M1J99/r3DGwmimwg3GbksGk7NgCOg0FBk
	 iIjzXjj2IJqkdeh2yPQXViNw4vKw3zw5lR44jG429gASfmNYXq+TSE5znGPRdwy0YY
	 ddmqdSyr+vgV/cyHD1fNoSjy59FI9zxVlYyKL5146W0qonhiNsUFCRLS9l/JiJTsdu
	 /d4rzHomrmqMJY85laR34wIR4qKUP2WJ444aShGkavHd2HyGHCPs9YzvnXD3qcoztv
	 Cq2vtvl4aFD2escxUpJ8WYFVlQC9MwZG2UmwTd5GRN6cftyQ6ufd71f2QyDXhZKD7B
	 2meEhwL/lg2eQ==
Date: Thu, 30 Oct 2025 18:13:41 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Krebs, Olaf" <Olaf.Krebs@emh-metering.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	"open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix IMX PWM period setting
Message-ID: <qsc5hl22l4bxs6jzqbc43r4wxvmbwz6rpcfsiv4hcp2uzrsscy@ogjzgesvy2wl>
References: <20251030114641.4109598-1-user@jenkins>
 <548dfa909f984868a62e04efc0c51bdf@emh-metering.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="34swrrw2zoqfjyya"
Content-Disposition: inline
In-Reply-To: <548dfa909f984868a62e04efc0c51bdf@emh-metering.com>


--34swrrw2zoqfjyya
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Fix IMX PWM period setting
MIME-Version: 1.0

Hello,

please version your patch revision, i.e. you should have put "v2" in the
subject. The easiest way to achieve that is by passing -v2 to `git
format-patch` (or `git send-email` if you use that directly). So for the
next revision use -v3.

On Thu, Oct 30, 2025 at 11:53:27AM +0000, Krebs, Olaf wrote:
> From: Olaf Krebs <okr@smgw.emh-meter.de>
>=20
> We use 3 PWM channels to control an RGB LED. Without this patch, an BUSY-=
error message is generated during initialization.
>=20
> [    7.395326] leds_pwm_multicolor led-controller: error -EBUSY: failed t=
o set led PWM value for (null)
> [    7.405167] leds_pwm_multicolor led-controller: probe with driver leds=
_pwm_multicolor failed with error -16
>=20
> Our DTS-Config for an imx93-Board:
> 	...
> 	led-controller {
> 		compatible =3D "pwm-leds-multicolor";
> 		multi-led {
> 			label =3D "RGBled";
> 			color =3D <LED_COLOR_ID_RGB>;
> 			function =3D LED_FUNCTION_INDICATOR;
> 			max-brightness =3D <255>;
> 			led-red {
> 				pwms =3D <&tpm5 0 1000000 PWM_POLARITY_INVERTED>;
> 				color =3D <LED_COLOR_ID_RED>;
> 			};
> 			led-green {
> 				pwms =3D <&tpm6 2 1000000 PWM_POLARITY_INVERTED>;
> 				color =3D <LED_COLOR_ID_GREEN>;
> 			};
> 			led-blue {
> 				pwms =3D <&tpm5 1 1000000 PWM_POLARITY_INVERTED>;
> 				color =3D <LED_COLOR_ID_BLUE>;
> 			};
> 		};
> 	};
> 	...

I would prefer something like the following text here:

	If a second PWM is requested by a driver before the first is
	configured, trying to configure any of these results in
	.user_count > 1 and thus the configuration fails.=20
	Fix that by only erroring out by additionally checking if the
	period is actually configured.

> Signed-off-by: Olaf krebs <olaf.krebs@emh-metering.com>

S-o-b missmatch. Do you know checkpatch? That one also wails:
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit desc=
ription?)

> ---
>  drivers/pwm/pwm-imx-tpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c index =
5b399de16d60..411daa7711f1 100644
> --- a/drivers/pwm/pwm-imx-tpm.c
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -190,7 +190,7 @@ static int pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
>  		 * there are multiple channels in use with different
>  		 * period settings.
>  		 */
> -		if (tpm->user_count > 1)
> +		if ((tpm->user_count > 1) && (tpm->real_period !=3D 0))
>  			return -EBUSY;

Please drop the added parenthesis.

Thinking about the error here, I wonder if a saner check would involve
enable_count instead of user_count.

>  		val =3D readl(tpm->base + PWM_IMX_TPM_SC);

Best regards
Uwe

--34swrrw2zoqfjyya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkDnMMACgkQj4D7WH0S
/k75IwgApdc2XPIDEyp+ZQcUeA+W1RUlQqraSjno8l3UnToMwlCt+ChVq19ThmyM
EdsIvUZnM0/5QjS856KJzxLKsFHa+KCYEi2I8Y7El/rEUU1BZkH0/HXR/QZ/SLc5
+Sal0xhUXIfxtSPWVH2BU1BX/h4yXmuysgSqfgbyuhxjiLPd6BNq03rNVP0uQJd/
+DhPiRYWxtVJJf8uxLYFu55POjiLDzlHWaJLz6x+umtjlrX5I3wdvr7MxvYk4Gjp
dPkrAqdKCXHkc+cr9CceupLqqPShhTmd0njU2kdKkYsLccd1chdfTBS7UXF9Ydkb
JM68cr+6yiYfx/cbCPLXx+xsDk2idA==
=2+ej
-----END PGP SIGNATURE-----

--34swrrw2zoqfjyya--

