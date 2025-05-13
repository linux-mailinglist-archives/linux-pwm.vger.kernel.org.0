Return-Path: <linux-pwm+bounces-5938-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D6DAB4F0B
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 11:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855691B43900
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8237D214A7B;
	Tue, 13 May 2025 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zak2lECe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59648214A74;
	Tue, 13 May 2025 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747127890; cv=none; b=KovkKF9cCmERpSvfzru1osuGsGRSF5kFSHcRiupF4XvS3atLHF162naVk7D0YjeHdUwLOEIqN1Y1TGdwr6lJ4ZbjPSQvwEDtzxwseosHktWWNDbBIQQu838ChKz1h+HuSOngrlun5KOIypT1ZUVGwXjQXY9niM/ET7q8kUtlGOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747127890; c=relaxed/simple;
	bh=j9p80guUWqHcJqXTGyyqkthHzHDx1SMl+e8oy8QM1oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULHaJcdS1WI2CFooh1p4oze+k2g1cFsJ7G/y34+CevVp/CAPT2Z5qqzcortAgYKDsm+4xucVIObI2KkYOEEKDcqoPWZTN8jtxClUcCmbdEefkHOqpbX2NSL5j30lMinkJxBTdOLuu7sde87uiJ9IcxqdwTdfcs6enj3Ogv8pSmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zak2lECe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7722EC4CEE4;
	Tue, 13 May 2025 09:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747127889;
	bh=j9p80guUWqHcJqXTGyyqkthHzHDx1SMl+e8oy8QM1oI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zak2lECerb9o2rKVpWs3+2GCjcK96rIvifyEb7Utxbe/Sm1iklSawNXcumoB3TeEg
	 ScsRB4UGLMAyjJU7HRGz0oHevumIkSkwovdOQV1Ui8eABPqR/cJ1cuNcxAW2fgbp0r
	 U+s8wBByLGrZJlmQRuq/mW6FRnII8gFqxNuYG7T+TkqiAwj+JIr3cvMY9mJPhK1btu
	 yHg0jONBaWwpjk6QFNI/McdEtoTBKORjI8VQiRJutk8JphzDBhkKPTYecwG5iSZsds
	 gWBaQ1Hna6CuZCnEYmFs3RGaRqkgndO1xGjZaev85GUhF4iSe6JeJFZhwi5OHGMFMC
	 yYFTzQP3a92fw==
Date: Tue, 13 May 2025 11:18:07 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 1/4] pwm: tiehrpwm: replace manual bit definitions
 with bitfield.h macros
Message-ID: <ydvitggvp63thed3gs3svktgyxfzzh44tcdejcqro7pl6t6trt@7xo6krgii44o>
References: <lhqi2eqfj5eyc67yriezvwwiyusenyohvqzbfrwjkjfjvxxb7a@xwvhrgmer4a7>
 <20250419194835.77860-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ipbdsbyraimrpin"
Content-Disposition: inline
In-Reply-To: <20250419194835.77860-1-rafael.v.volkmer@gmail.com>


--4ipbdsbyraimrpin
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/4] pwm: tiehrpwm: replace manual bit definitions
 with bitfield.h macros
MIME-Version: 1.0

On Sat, Apr 19, 2025 at 04:48:35PM -0300, Rafael V. Volkmer wrote:
> Simplify bit manipulation by replacing manual BIT(x) definitions with
> GENMASK() and FIELD_PREP() from <linux/bitfield.h>. This improves
> readability, consistency, and aligns with modern kernel practices
> while preserving existing functionality.
>=20
> Additionally, update set_prescale_div() to use FIELD_PREP() for
> TBCTL_CLKDIV_MASK and TBCTL_HSPCLKDIV_MASK instead of manually
> shifting bits. This makes the code more maintainable and avoids
> potential errors in bit field assignments.
>=20
> Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
> ---
>  drivers/pwm/pwm-tiehrpwm.c | 191 ++++++++++++++++++++++---------------
>  1 file changed, 114 insertions(+), 77 deletions(-)

I reorder the patch a bit with the intend to not change semantics but to
make my points a bit clearer.

> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index 0125e73b98df..1ead1aa91a1a 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -13,85 +13,122 @@
>  #include <linux/clk.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> +#include <linux/bitfield.h>
> =20
>  /* EHRPWM registers and bits definitions */
> =20
>  /* Time base module registers */
> -#define TBCTL			0x00
> -#define TBPRD			0x0A
> +#define TBCTL	0x00
> +#define TBPRD	0x0A

It's unclear to me why you changed the indention here. While you might
consider that inconsistent as I hate indenting struct initializers, for
#defines I think it greatly improves readability. I'd also keep the
whitespace changes to a minimum to make the patch better readable.

> -#define TBCTL_PRDLD_MASK	BIT(3)
> -#define TBCTL_PRDLD_SHDW	0
> -#define TBCTL_PRDLD_IMDT	BIT(3)
> -#define TBCTL_CLKDIV_MASK	(BIT(12) | BIT(11) | BIT(10) | BIT(9) | \
> -				BIT(8) | BIT(7))
> -#define TBCTL_CTRMODE_MASK	(BIT(1) | BIT(0))
> -#define TBCTL_CTRMODE_UP	0
> -#define TBCTL_CTRMODE_DOWN	BIT(0)
> -#define TBCTL_CTRMODE_UPDOWN	BIT(1)
> -#define TBCTL_CTRMODE_FREEZE	(BIT(1) | BIT(0))

Huh, you reordered these?

> -#define TBCTL_HSPCLKDIV_SHIFT	7
> -#define TBCTL_CLKDIV_SHIFT	10
> -
> -#define CLKDIV_MAX		7
> -#define HSPCLKDIV_MAX		7
> -#define PERIOD_MAX		0xFFFF
> -
> -/* compare module registers */
> -#define CMPA			0x12
> -#define CMPB			0x14
> -
> -/* Action qualifier module registers */
> -#define AQCTLA			0x16
> -#define AQCTLB			0x18
> -#define AQSFRC			0x1A
> -#define AQCSFRC			0x1C
> -
> -#define AQCTL_CBU_MASK		(BIT(9) | BIT(8))
> -#define AQCTL_CBU_FRCLOW	BIT(8)
> -#define AQCTL_CBU_FRCHIGH	BIT(9)
> -#define AQCTL_CBU_FRCTOGGLE	(BIT(9) | BIT(8))
> -#define AQCTL_CAU_MASK		(BIT(5) | BIT(4))
> -#define AQCTL_CAU_FRCLOW	BIT(4)
> -#define AQCTL_CAU_FRCHIGH	BIT(5)
> -#define AQCTL_CAU_FRCTOGGLE	(BIT(5) | BIT(4))
> -#define AQCTL_PRD_MASK		(BIT(3) | BIT(2))
> -#define AQCTL_PRD_FRCLOW	BIT(2)
> -#define AQCTL_PRD_FRCHIGH	BIT(3)
> -#define AQCTL_PRD_FRCTOGGLE	(BIT(3) | BIT(2))
> -#define AQCTL_ZRO_MASK		(BIT(1) | BIT(0))
> -#define AQCTL_ZRO_FRCLOW	BIT(0)
> -#define AQCTL_ZRO_FRCHIGH	BIT(1)
> -#define AQCTL_ZRO_FRCTOGGLE	(BIT(1) | BIT(0))
> -
> -#define AQCTL_CHANA_POLNORMAL	(AQCTL_CAU_FRCLOW | AQCTL_PRD_FRCHIGH | \
> -				AQCTL_ZRO_FRCHIGH)
> -#define AQCTL_CHANA_POLINVERSED	(AQCTL_CAU_FRCHIGH | AQCTL_PRD_FRCLOW | \
> -				AQCTL_ZRO_FRCLOW)
> -#define AQCTL_CHANB_POLNORMAL	(AQCTL_CBU_FRCLOW | AQCTL_PRD_FRCHIGH | \
> -				AQCTL_ZRO_FRCHIGH)
> -#define AQCTL_CHANB_POLINVERSED	(AQCTL_CBU_FRCHIGH | AQCTL_PRD_FRCLOW | \
> -				AQCTL_ZRO_FRCLOW)
> -
> -#define AQSFRC_RLDCSF_MASK	(BIT(7) | BIT(6))
> -#define AQSFRC_RLDCSF_ZRO	0
> -#define AQSFRC_RLDCSF_PRD	BIT(6)
> -#define AQSFRC_RLDCSF_ZROPRD	BIT(7)
> -#define AQSFRC_RLDCSF_IMDT	(BIT(7) | BIT(6))
> -
> -#define AQCSFRC_CSFB_MASK	(BIT(3) | BIT(2))
> -#define AQCSFRC_CSFB_FRCDIS	0
> -#define AQCSFRC_CSFB_FRCLOW	BIT(2)
> -#define AQCSFRC_CSFB_FRCHIGH	BIT(3)
> -#define AQCSFRC_CSFB_DISSWFRC	(BIT(3) | BIT(2))
> -#define AQCSFRC_CSFA_MASK	(BIT(1) | BIT(0))
> -#define AQCSFRC_CSFA_FRCDIS	0
> -#define AQCSFRC_CSFA_FRCLOW	BIT(0)
> -#define AQCSFRC_CSFA_FRCHIGH	BIT(1)
> -#define AQCSFRC_CSFA_DISSWFRC	(BIT(1) | BIT(0))
> -
> -#define NUM_PWM_CHANNEL		2	/* EHRPWM channels */
> +/* TBCTL: CTRMODE field (bits [1:0]) */
> +#define TBCTL_CTRMODE_MASK	GENMASK(1, 0)
> +#define TBCTL_CTRMODE_UP	FIELD_PREP(TBCTL_CTRMODE_MASK, 0)
> +#define TBCTL_CTRMODE_DOWN	FIELD_PREP(TBCTL_CTRMODE_MASK, 1)
> +#define TBCTL_CTRMODE_UPDOWN	FIELD_PREP(TBCTL_CTRMODE_MASK, 2)
> +#define TBCTL_CTRMODE_FREEZE	FIELD_PREP(TBCTL_CTRMODE_MASK, 3)
> +
> +/* TBCTL: PRDLD bit (bit [3]) */
> +#define TBCTL_PRDLD_MASK	GENMASK(3, 3)
> +#define TBCTL_PRDLD_SHDW	FIELD_PREP(TBCTL_PRDLD_MASK, 0)  /* shadow load=
 */
> +#define TBCTL_PRDLD_IMDT	FIELD_PREP(TBCTL_PRDLD_MASK, 1)  /* immediate */
> +
> +/* TBCTL: high=E2=80=91speed prescale (bits [9:7]) */
> +#define TBCTL_HSPCLKDIV_MASK	GENMASK(9, 7)
> +/* TBCTL: clock prescale (bits [12:10]) */
> +#define TBCTL_CLKDIV_MASK	GENMASK(12, 10)

This is different than before. Please only change the way the constants
are defined and not their values.

> +
> +#define CLKDIV_MAX	7
> +#define HSPCLKDIV_MAX	7
> +#define PERIOD_MAX	0xFFFF
> +
> +/*
> + * ----------------------------------------------------------------
> + * Compare module registers
> + * ----------------------------------------------------------------
> + */
> +#define CMPA	0x12
> +#define CMPB	0x14
> +
> +/*
> + * ----------------------------------------------------------------
> + * Action Qualifier (AQ) module registers
> + * ----------------------------------------------------------------
> + */
> +#define AQCTLA	0x16
> +#define AQCTLB	0x18
> +#define AQSFRC	0x1A
> +#define AQCSFRC	0x1
> +
> +/* AQCTL: event-action fields */
> +/*   ZRO  =3D bits [1:0] */
> +/*   PRD  =3D bits [3:2] */
> +/*   CAU  =3D bits [5:4] */
> +/*   CBU  =3D bits [9:8] */
> +#define AQCTL_ZRO_MASK	GENMASK(1, 0)
> +#define AQCTL_PRD_MASK	GENMASK(3, 2)
> +#define AQCTL_CAU_MASK	GENMASK(5, 4)
> +#define AQCTL_CBU_MASK	GENMASK(9, 8)
> +
> +/* common action codes (2=E2=80=91bit) */
> +#define AQCTL_FRCLOW	1
> +#define AQCTL_FRCHIGH	2
> +#define AQCTL_FRCTOGGLE	3
> +
> +/* ZRO actions */
> +#define AQCTL_ZRO_FRCLOW	FIELD_PREP(AQCTL_ZRO_MASK, AQCTL_FRCLOW)
> +#define AQCTL_ZRO_FRCHIGH	FIELD_PREP(AQCTL_ZRO_MASK, AQCTL_FRCHIGH)
> +#define AQCTL_ZRO_FRCTOGGLE	FIELD_PREP(AQCTL_ZRO_MASK, AQCTL_FRCTOGGLE)
> +
> +/* PRD actions */
> +#define AQCTL_PRD_FRCLOW	FIELD_PREP(AQCTL_PRD_MASK, AQCTL_FRCLOW)
> +#define AQCTL_PRD_FRCHIGH	FIELD_PREP(AQCTL_PRD_MASK, AQCTL_FRCHIGH)
> +#define AQCTL_PRD_FRCTOGGLE	FIELD_PREP(AQCTL_PRD_MASK, AQCTL_FRCTOGGLE)
> +
> +/* CAU actions */
> +#define AQCTL_CAU_FRCLOW	FIELD_PREP(AQCTL_CAU_MASK, AQCTL_FRCLOW)
> +#define AQCTL_CAU_FRCHIGH	FIELD_PREP(AQCTL_CAU_MASK, AQCTL_FRCHIGH)
> +#define AQCTL_CAU_FRCTOGGLE	FIELD_PREP(AQCTL_CAU_MASK, AQCTL_FRCTOGGLE)
> +
> +/* CBU actions */
> +#define AQCTL_CBU_FRCLOW	FIELD_PREP(AQCTL_CBU_MASK, AQCTL_FRCLOW)
> +#define AQCTL_CBU_FRCHIGH	FIELD_PREP(AQCTL_CBU_MASK, AQCTL_FRCHIGH)
> +#define AQCTL_CBU_FRCTOGGLE	FIELD_PREP(AQCTL_CBU_MASK, AQCTL_FRCTOGGLE)
> +
> +/* predefined channel=E2=80=91polarity combos */
> +#define AQCTL_CHANA_POLNORMAL	\
> +	(AQCTL_CAU_FRCLOW  | AQCTL_PRD_FRCHIGH | AQCTL_ZRO_FRCHIGH)
> +#define AQCTL_CHANA_POLINVERSED	\
> +	(AQCTL_CAU_FRCHIGH | AQCTL_PRD_FRCLOW  | AQCTL_ZRO_FRCLOW)
> +
> +#define AQCTL_CHANB_POLNORMAL	\
> +	(AQCTL_CBU_FRCLOW  | AQCTL_PRD_FRCHIGH | AQCTL_ZRO_FRCHIGH)
> +#define AQCTL_CHANB_POLINVERSED	\
> +	(AQCTL_CBU_FRCHIGH | AQCTL_PRD_FRCLOW  | AQCTL_ZRO_FRCLOW)
> +
> +/* AQSFRC: RLDCSF (bits [7:6]) */
> +#define AQSFRC_RLDCSF_MASK	GENMASK(7, 6)
> +#define AQSFRC_RLDCSF_ZRO	FIELD_PREP(AQSFRC_RLDCSF_MASK, 0)
> +#define AQSFRC_RLDCSF_PRD	FIELD_PREP(AQSFRC_RLDCSF_MASK, 1)
> +#define AQSFRC_RLDCSF_ZROPRD	FIELD_PREP(AQSFRC_RLDCSF_MASK, 2)
> +#define AQSFRC_RLDCSF_IMDT	FIELD_PREP(AQSFRC_RLDCSF_MASK, 3)
> +
> +/* AQCSFRC: CSFB (bits [3:2]), CSFA (bits [1:0]) */
> +#define AQCSFRC_CSFB_MASK	GENMASK(3, 2)
> +#define AQCSFRC_CSFA_MASK	GENMASK(1, 0)
> +
> +#define AQCSFRC_CSFB_FRCDIS	FIELD_PREP(AQCSFRC_CSFB_MASK, 0)
> +#define AQCSFRC_CSFB_FRCLOW	FIELD_PREP(AQCSFRC_CSFB_MASK, 1)
> +#define AQCSFRC_CSFB_FRCHIGH	FIELD_PREP(AQCSFRC_CSFB_MASK, 2)
> +#define AQCSFRC_CSFB_DISSWFRC	FIELD_PREP(AQCSFRC_CSFB_MASK, 3)
> +
> +#define AQCSFRC_CSFA_FRCDIS	FIELD_PREP(AQCSFRC_CSFA_MASK, 0)
> +#define AQCSFRC_CSFA_FRCLOW	FIELD_PREP(AQCSFRC_CSFA_MASK, 1)
> +#define AQCSFRC_CSFA_FRCHIGH	FIELD_PREP(AQCSFRC_CSFA_MASK, 2)
> +#define AQCSFRC_CSFA_DISSWFRC	FIELD_PREP(AQCSFRC_CSFA_MASK, 3)
> +
> +/* Number of EHRPWM channels */
> +#define NUM_PWM_CHANNEL	2U

That U is quite useless, a plain 2 does well.
=20
>  struct ehrpwm_context {
>  	u16 tbctl;
> @@ -167,8 +204,8 @@ static int set_prescale_div(unsigned long rqst_presca=
ler, u16 *prescale_div,
>  			*prescale_div =3D (1 << clkdiv) *
>  					(hspclkdiv ? (hspclkdiv * 2) : 1);
>  			if (*prescale_div > rqst_prescaler) {
> -				*tb_clk_div =3D (clkdiv << TBCTL_CLKDIV_SHIFT) |
> -					(hspclkdiv << TBCTL_HSPCLKDIV_SHIFT);
> +				*tb_clk_div =3D FIELD_PREP(TBCTL_CLKDIV_MASK, clkdiv) |
> +							FIELD_PREP(TBCTL_HSPCLKDIV_MASK, hspclkdiv);

I'd like to have this change in a separate patch. Is it obvious that the
new variant has the same semantic as the old? Or does this introduce
changes for some inputs?

Best regards
Uwe

--4ipbdsbyraimrpin
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgjDkwACgkQj4D7WH0S
/k4EzQf+PVpaqxyZxHFOxNNfX6dS7UlTNhZ6bCsXxmI1HEzuZt/0f8QGevTscyW7
sg7RwXFgTlUyIZyyz6VsUfUfEMVV6yPL1+8YY3nG4WDMwflG5/X88endGBnx2Ot1
0HPUP4jHDHqr7xEwBBVDbxNlwc6Sq9hTKIsJYIOPnihc51lPBPgpv88PrOk7mX0K
Dam40u1bg0pzAi0L9jOdy7uFUD7nEmrjqBxB+TvEwYvF33/jDzDFeB4/7x6MFPuW
OxTrNhXf6VLK0pClaoVCAQTC8iAU815O5vmimQU6FAlX1l3S2+NSuMlfCT5wL9Lh
Oz8cntp+beybMZbIAhxJmVLtyUWayA==
=yUDw
-----END PGP SIGNATURE-----

--4ipbdsbyraimrpin--

