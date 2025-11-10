Return-Path: <linux-pwm+bounces-7603-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 279D2C46327
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Nov 2025 12:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6501896F80
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Nov 2025 11:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569BE3074BA;
	Mon, 10 Nov 2025 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FC4kTTES"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A755242D60;
	Mon, 10 Nov 2025 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773481; cv=none; b=s9JqK5O26FnNBKd6Toz2L4DvJ/MxwYVKoRWdFCJA1WGtOzlsBkkZXSEbOVOXLHS4jlGdZeyBxgy+P2lkoXJEdBLtCYZe8RqA9G/AzmwdaZTKSiRBDuo4CivQ3AeS5b+BC99W7IN8ySzSwC6VHed6675by0TZy0gLgfGLjuOkNVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773481; c=relaxed/simple;
	bh=NIAAx4JunbkrPcpYLtzJRP0ejun2IKiSU8XUZ9l2/Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZIEjbhYLBpy9KfnfGndL5bEqc8RbPMHj0nw52r04opy7jGQ+0pQ/x8mUT3XP/aWCGo1DEmaQLNQnia8tCMjyMQ+y5OmAN1VAzDLGTVQgTcB0GVvQHm/baayS3/Sbkzci68WJwZcFnBa7Oe7migJHxWdnTF6ZS1xBOIvScA3eL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FC4kTTES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9DDC4AF09;
	Mon, 10 Nov 2025 11:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762773480;
	bh=NIAAx4JunbkrPcpYLtzJRP0ejun2IKiSU8XUZ9l2/Eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FC4kTTES4inuLVRkpM9Knzu/Vo8ICIwXu8gJws08E2DEeIakmSJ9OLrucvNnKu+d/
	 TEcsvUnsBQ8KoT4hJXsNteTaYKAMXCZAihELXRm90w35gav+O+H1fUQyvAH6/DW/0T
	 PdvhHwjK8TIwS1wnav0U2mv8Y4ZZv3Ehj7yq5emuOIDd3bvdzmM68MMIAMcixvtmTX
	 JNaeJfLt3XW0QSwSByZHq62hgT3q4Vfj24bUJcL6RzEiRQBhJF+wReRfrxKCTZnV5l
	 glUfYUzgQyFF0SNc5seTGv5pbzpohUBP1I/QKih+p0rh1hUkHfOxJv4BPFJ1hBoPi/
	 dpJN+8zU3jTZQ==
Date: Mon, 10 Nov 2025 12:17:57 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v24 4/4] pwm: rzg2l-gpt: Add support for gpt linking with
 poeg
Message-ID: <mipf6ogg45h5bsdekr27sf3nfllbbylkqjiowutg5cugbyosy4@r4glajhjcorn>
References: <20250226144531.176819-1-biju.das.jz@bp.renesas.com>
 <20250226144531.176819-5-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gj6zsmmzisxrp5zc"
Content-Disposition: inline
In-Reply-To: <20250226144531.176819-5-biju.das.jz@bp.renesas.com>


--gj6zsmmzisxrp5zc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v24 4/4] pwm: rzg2l-gpt: Add support for gpt linking with
 poeg
MIME-Version: 1.0

On Wed, Feb 26, 2025 at 02:45:23PM +0000, Biju Das wrote:
> The General PWM Timer (GPT) is capable of detecting "dead time error
> and short-circuits between output pins" and send Output disable
> request to poeg(Port Output Enable for GPT).
>=20
> Add support for linking poeg group with gpt, so that
> gpt can control the output disable function.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v23->v24:
>  * No change.
> v22>v23:
>  * No change
> v21>v22:
>  * No change
> v20->21:
>  * Dropped local variable offs for calculating RZG2L_GTINTAD channel regi=
ster
>    and instead using the macro RZG2L_GTINTAD(ch).
> v19->v20:
>  * No change
> v18->v19:
>  * No change
> v17->v18:
>  * Moved bitpos near to the user.
> v16->v17:
>  * No change
> v15->v16:
>  * No change.
> v14->v15:
>  * Updated commit description by replacing "This patch add"-> "Add".
> v3->v14:
>  * Removed the parenthesis for RZG2L_MAX_POEG_GROUPS.
>  * Renamed rzg2l_gpt_parse_properties()->rzg2l_gpt_poeg_init() as it not =
only parse
>    the properties but also implements the needed register writes.
>  * Added acomment here about the purpose of the function rzg2l_gpt_poeg_i=
nit()
>  * Removed magic numbers from rzg2l_gpt_poeg_init()
>  * Fixed resource leak in rzg2l_gpt_poeg_init().
>  * Moved the patch from series[1] to here
>  [1] https://lore.kernel.org/linux-renesas-soc/20221215205843.4074504-1-b=
iju.das.jz@bp.renesas.com/T/#t
> v2->v3:
>  * Updated commit header and description
>  * Added check for poeg group in rzg2l_gpt_parse_properties().
> v1->v2:
>  * Replaced id->poeg-id as per poeg bindings.
> This patch depend upon [1]
> [1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20221214=
132232.2835828-3-biju.das.jz@bp.renesas.com/
> ---
>  drivers/pwm/pwm-rzg2l-gpt.c | 83 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> index 2ddbb13f50aa..a551554aec77 100644
> --- a/drivers/pwm/pwm-rzg2l-gpt.c
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -39,6 +39,7 @@
>  #define RZG2L_GTCR(ch)		(0x2c + RZG2L_GET_CH_OFFS(ch))
>  #define RZG2L_GTUDDTYC(ch)	(0x30 + RZG2L_GET_CH_OFFS(ch))
>  #define RZG2L_GTIOR(ch)		(0x34 + RZG2L_GET_CH_OFFS(ch))
> +#define RZG2L_GTINTAD(ch)	(0x38 + RZG2L_GET_CH_OFFS(ch))
>  #define RZG2L_GTBER(ch)		(0x40 + RZG2L_GET_CH_OFFS(ch))
>  #define RZG2L_GTCNT(ch)		(0x48 + RZG2L_GET_CH_OFFS(ch))
>  #define RZG2L_GTCCR(ch, sub_ch)	(0x4c + RZG2L_GET_CH_OFFS(ch) + 4 * (sub=
_ch))
> @@ -55,12 +56,21 @@
>  #define RZG2L_GTUDDTYC_UP_COUNTING	(RZG2L_GTUDDTYC_UP | RZG2L_GTUDDTYC_U=
DF)
> =20
>  #define RZG2L_GTIOR_GTIOA	GENMASK(4, 0)
> +#define RZG2L_GTIOR_OADF	GENMASK(10, 9)
>  #define RZG2L_GTIOR_GTIOB	GENMASK(20, 16)
> +#define RZG2L_GTIOR_OBDF	GENMASK(26, 25)
> +
>  #define RZG2L_GTIOR_GTIOx(sub_ch)	((sub_ch) ? RZG2L_GTIOR_GTIOB : RZG2L_=
GTIOR_GTIOA)
> +
>  #define RZG2L_GTIOR_OAE		BIT(8)
>  #define RZG2L_GTIOR_OBE		BIT(24)
>  #define RZG2L_GTIOR_OxE(sub_ch)		((sub_ch) ? RZG2L_GTIOR_OBE : RZG2L_GTI=
OR_OAE)
> =20
> +#define RZG2L_GTIOR_OADF_HIGH_IMP_ON_OUT_DISABLE	BIT(9)
> +#define RZG2L_GTIOR_OBDF_HIGH_IMP_ON_OUT_DISABLE	BIT(25)
> +#define RZG2L_GTIOR_PIN_DISABLE_SETTING \
> +	(RZG2L_GTIOR_OADF_HIGH_IMP_ON_OUT_DISABLE | RZG2L_GTIOR_OBDF_HIGH_IMP_O=
N_OUT_DISABLE)
> +
>  #define RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
>  #define RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH \
>  	(RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE | RZG2L_GTIOR_OAE)
> @@ -71,12 +81,17 @@
>  	((sub_ch) ? RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH : \
>  	 RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH)
> =20
> +#define RZG2L_GTINTAD_GRP_MASK	GENMASK(25, 24)
> +
>  #define RZG2L_MAX_HW_CHANNELS	8
>  #define RZG2L_CHANNELS_PER_IO	2
>  #define RZG2L_MAX_PWM_CHANNELS	(RZG2L_MAX_HW_CHANNELS * RZG2L_CHANNELS_P=
ER_IO)
>  #define RZG2L_MAX_SCALE_FACTOR	1024
>  #define RZG2L_MAX_TICKS		((u64)U32_MAX * RZG2L_MAX_SCALE_FACTOR)
> =20
> +#define RZG2L_MAX_POEG_GROUPS	4
> +#define RZG2L_LAST_POEG_GROUP	3
> +
>  struct rzg2l_gpt_chip {
>  	void __iomem *mmio;
>  	struct mutex lock; /* lock to protect shared channel resources */
> @@ -84,6 +99,7 @@ struct rzg2l_gpt_chip {
>  	u32 period_ticks[RZG2L_MAX_HW_CHANNELS];
>  	u32 channel_request_count[RZG2L_MAX_HW_CHANNELS];
>  	u32 channel_enable_count[RZG2L_MAX_HW_CHANNELS];
> +	DECLARE_BITMAP(poeg_gpt_link, RZG2L_MAX_POEG_GROUPS * RZG2L_MAX_HW_CHAN=
NELS);
>  };
> =20
>  static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip *=
chip)
> @@ -362,6 +378,72 @@ static const struct pwm_ops rzg2l_gpt_ops =3D {
>  	.apply =3D rzg2l_gpt_apply,
>  };
> =20
> +/*
> + * This function links a poeg group{A,B,C,D} with a gpt channel{0..7} and
> + * configure the pin for output disable.
> + */
> +static void rzg2l_gpt_poeg_init(struct platform_device *pdev,
> +				struct rzg2l_gpt_chip *rzg2l_gpt)
> +{
> +	struct of_phandle_args of_args;
> +	unsigned int i;
> +	u32 poeg_grp;
> +	u32 bitpos;
> +	int cells;
> +	int ret;
> +
> +	cells =3D of_property_count_u32_elems(pdev->dev.of_node, "renesas,poegs=
");
> +	if (cells =3D=3D -EINVAL)
> +		return;

Please catch other errors, too.

> +	cells >>=3D 1;

Is it an error if cells is an odd number?

> +	for (i =3D 0; i < cells; i++) {
> +		ret =3D of_parse_phandle_with_fixed_args(pdev->dev.of_node,
> +						       "renesas,poegs", 1, i,
> +						       &of_args);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"Failed to parse 'renesas,poegs' property\n");
> +			return;

So .probe() might emit an error message now, but it doesn't fail. I
would suggest to change the latter.

> +		}
> +
> +		if (of_args.args[0] >=3D RZG2L_MAX_HW_CHANNELS) {
> +			dev_err(&pdev->dev, "Invalid channel %d >=3D %d\n",
> +				of_args.args[0], RZG2L_MAX_HW_CHANNELS);
> +			of_node_put(of_args.np);
> +			return;
> +		}
> +
> +		if (!of_device_is_available(of_args.np)) {
> +			/* It's fine to have a phandle to a non-enabled poeg. */
> +			of_node_put(of_args.np);
> +			continue;

Does of_device_is_available() return false if the poeg is enabled, but
not yet probed? In that case .probe() should return -EPROBE_DEFER.

> +		}
> +
> +		if (!of_property_read_u32(of_args.np, "renesas,poeg-id", &poeg_grp)) {
> +			if (poeg_grp > RZG2L_LAST_POEG_GROUP) {
> +				dev_err(&pdev->dev, "Invalid poeg group %d > %d\n",
> +					poeg_grp, RZG2L_LAST_POEG_GROUP);
> +				of_node_put(of_args.np);
> +				return;
> +			}
> +
> +			bitpos =3D of_args.args[0] + poeg_grp * RZG2L_MAX_HW_CHANNELS;
> +			set_bit(bitpos, rzg2l_gpt->poeg_gpt_link);
> +
> +			rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTINTAD(of_args.args[0]),
> +					 RZG2L_GTINTAD_GRP_MASK,
> +					 poeg_grp << 24);
> +
> +			rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR(of_args.args[0]),
> +					 RZG2L_GTIOR_OBDF | RZG2L_GTIOR_OADF,
> +					 RZG2L_GTIOR_PIN_DISABLE_SETTING);
> +		}
> +
> +		of_node_put(of_args.np);
> +	}
> +}

Best regards
Uwe

--gj6zsmmzisxrp5zc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkRyeMACgkQj4D7WH0S
/k7s9wgApCZDVIdO2bIqi/aIZVXoUJ7Wp6EJTjtihSWwg8QQGUNZvLY7h2KtzLXq
1z6r02LlanMr2QZebHLRE8mqx/vBx+QiyNQgoPwXO5m3jhN9J2x+hv1LzWfCVhFg
ylmuLMg4bl16xcPQANUbZqsoJDf/babU3GS/BI/LsOZ3Xhnf2uByJMCfBeS2cMXJ
Vp1tm7331KdC22xhQPiJfCd6ws/X/OfECyZgnI244w2/VW4QJg9dM2tvE9KKJxXI
Pp4X/8A4JMKJHansRYlFAHVEH7aUi6s3nLARDi5prF6RvRnGvosJu1xcoXCG3+u7
rBtbrkSzlGsES6hQYLQ29fDXwG8B+Q==
=t5A5
-----END PGP SIGNATURE-----

--gj6zsmmzisxrp5zc--

