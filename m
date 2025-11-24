Return-Path: <linux-pwm+bounces-7685-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27967C7FEF2
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Nov 2025 11:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AA8B4E26D4
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Nov 2025 10:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6B5271447;
	Mon, 24 Nov 2025 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfHlpqvJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3426C258CD7;
	Mon, 24 Nov 2025 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763980583; cv=none; b=mBedKdM01mBRQiwu1QsG5/e/8CLMwU02PsOdco+zCh5qtUQQM2wO+Xu8jKwqiSggOjPB6bKvyKHvgLO3gRChwcpdhfw/jheoWa8aMxTNyqSOsisYJaIjwk0spW4axVMA/FogzRP3V6WH4siu0UhsEs9rfpLaM49DbLsdNzHkM4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763980583; c=relaxed/simple;
	bh=cQrFC8dNimw0mGakIDcUacd4QRdlFBHrPpxgxQFTuZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqukrbcsspaUwyrY02MFeP6CK0agdMoWxgjLaJepLXFyv4SHWOMQEZUhi+CrbGENY2viQmflGMB2ajlEdnyhIYfSCi/jongZi3nxyqFS174CHQz0tHxrwC+8M6WiinWneWOIFQXE3ESG0Nd3lVk3uSC8CYR8nMnum/NNzvD/ZlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfHlpqvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B20C4CEF1;
	Mon, 24 Nov 2025 10:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763980582;
	bh=cQrFC8dNimw0mGakIDcUacd4QRdlFBHrPpxgxQFTuZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FfHlpqvJDmPjVnToGzblo2CDsEZNk+w85DcWgrgi8AIYHK1eqNi58JEJ6k7grrYqt
	 JKy4hZx/6G7lF3mPy6HuvW5C5vp+Fe4cupnOB1l7/0gljChJjVnmQ1wPrMGebJrVkB
	 q2QYEAjUhgA4AGKQ/KG7DjyuzccjHikP2gFMLcQ0TyffmBZbNxpQ13VTHO/fmgZXkv
	 frs+o3vFEmwzC+lX+TNBY7HdgX0cuxFl62UXwSOQT2ih8L1hFcNtItI0xpDu2/8h5T
	 EdaAkcJiTqOwI7VLD6rZ9jl+93hfkRTNFUHcIjlgwEPebGxhedIFgN22cyNl1+EhiJ
	 KLK0Uk0FgG2xw==
Date: Mon, 24 Nov 2025 11:36:20 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 1/6] pwm: tiehrpwm: use GENMASK() and FIELD_PREP() for
 register fields
Message-ID: <wzb7dggrrbehqilrnj2kb2ngopxocf34cz6c3zp446jvbzuhv5@tf72gdpuslfz>
References: <20251123232029.1956-1-rafael.v.volkmer@gmail.com>
 <20251123232521.2039-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vhkiucl3ql657rjm"
Content-Disposition: inline
In-Reply-To: <20251123232521.2039-1-rafael.v.volkmer@gmail.com>


--vhkiucl3ql657rjm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 1/6] pwm: tiehrpwm: use GENMASK() and FIELD_PREP() for
 register fields
MIME-Version: 1.0

On Sun, Nov 23, 2025 at 08:25:21PM -0300, Rafael V. Volkmer wrote:
> Convert register field definitions in AQCTL, AQCSFRC and TBCTL to use
> GENMASK() and FIELD_PREP(). This clarifies the bit layout, reduces
> hand-rolled shift logic and aligns the driver with common kernel patterns.
>=20
> No functional change.
>=20
> Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
> ---
>  drivers/pwm/pwm-tiehrpwm.c | 91 ++++++++++++++++++++------------------
>  1 file changed, 49 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index 7a86cb090f76..d2151065083b 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -13,6 +13,7 @@
>  #include <linux/clk.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> +#include <linux/bitfield.h>
> =20
>  /* EHRPWM registers and bits definitions */
> =20
> @@ -21,22 +22,24 @@
>  #define TBPRD			0x0A
> =20
>  #define TBCTL_PRDLD_MASK	BIT(3)

I'd prefer s/TBCTL_PRDLD_MASK/TBCTL_PRDLD/ here. This way _MASK isn't
special compared to _SHOW (and others).

As you touch the register defines it would also be great to give them a
common prefix (e.g. TIEHRPWM_).

> -#define TBCTL_PRDLD_SHDW	0
> -#define TBCTL_PRDLD_IMDT	BIT(3)
> -#define TBCTL_CLKDIV_MASK	(BIT(12) | BIT(11) | BIT(10) | BIT(9) | \
> -				BIT(8) | BIT(7))
> -#define TBCTL_CTRMODE_MASK	(BIT(1) | BIT(0))
> -#define TBCTL_CTRMODE_UP	0
> -#define TBCTL_CTRMODE_DOWN	BIT(0)
> -#define TBCTL_CTRMODE_UPDOWN	BIT(1)
> -#define TBCTL_CTRMODE_FREEZE	(BIT(1) | BIT(0))
> +#define TBCTL_PRDLD_SHDW	FIELD_PREP(TBCTL_PRDLD_MASK, 0)
> +#define TBCTL_PRDLD_IMDT	FIELD_PREP(TBCTL_PRDLD_MASK, 1)
> +
> +#define TBCTL_CLKDIV_MASK	GENMASK(12, 7)
> +
> +#define TBCTL_CTRMODE_MASK	GENMASK(1, 0)
> +#define TBCTL_CTRMODE_UP	FIELD_PREP(TBCTL_CTRMODE_MASK, 0)
> +#define TBCTL_CTRMODE_DOWN	FIELD_PREP(TBCTL_CTRMODE_MASK, 1)
> +#define TBCTL_CTRMODE_UPDOWN	FIELD_PREP(TBCTL_CTRMODE_MASK, 2)
> +#define TBCTL_CTRMODE_FREEZE	FIELD_PREP(TBCTL_CTRMODE_MASK, 3)
> =20
>  #define TBCTL_HSPCLKDIV_SHIFT	7
>  #define TBCTL_CLKDIV_SHIFT	10
> =20
>  #define CLKDIV_MAX		7
>  #define HSPCLKDIV_MAX		7
> -#define PERIOD_MAX		0x10000
> +#define TBPRD_BITS		16
> +#define PERIOD_MAX		BIT(TBPRD_BITS)

If you do something like:

	#define TIEHRPWM_TBPRD		0xa
	#define TIEHRPWM_TBPRD_TBPRD		GENMASK(15, 0)

(which I admit looks a bit redundant, but still represents the
register layout properly) you can use

	FIELD_MAX(TIEHRPWM_TBPRD_TBPRD)

to define the maximal period.

Best regards
Uwe

--vhkiucl3ql657rjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkkNSEACgkQj4D7WH0S
/k7hKQf/YefEIEa0W6LUpveohUSKvv947k5rv8T+wEPYIn3DzQMZPSeUTQl2Mt40
XSM3cN0S2OiyaPwxScmQyTavDb0CiK0uMOptsNOjXCoLzAGNxdMMwkico0LyA0E6
ByIraod+5wvHylFJ1cSvArsnlLC0AxclfHvC+MyxfUPyLdGQ2E3NlEbLFNwqelii
hAE3eYWaBeSeJWJBnxQEaEcMEN5Pmp1lWrb5181oCDxLKQTEFty/k7dgHwWr7w43
Bfu4rViYh/V5jO7yzreL3vaCHHofl6D+9zV9eTjUilkH4wSXMIgbfExqRQLCPx0X
M3td+ZDrTeQv96/uE3alI04rxux86g==
=sANP
-----END PGP SIGNATURE-----

--vhkiucl3ql657rjm--

