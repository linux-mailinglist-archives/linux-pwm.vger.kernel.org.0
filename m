Return-Path: <linux-pwm+bounces-647-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C60681E1FF
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Dec 2023 19:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B1BB20C3F
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Dec 2023 18:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0CA537E2;
	Mon, 25 Dec 2023 18:29:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFB8537E4
	for <linux-pwm@vger.kernel.org>; Mon, 25 Dec 2023 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rHpha-0005Uu-DZ; Mon, 25 Dec 2023 19:29:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rHphW-001Tbp-AQ; Mon, 25 Dec 2023 19:29:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rHphX-000xji-13;
	Mon, 25 Dec 2023 19:29:19 +0100
Date: Mon, 25 Dec 2023 19:29:19 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v17 4/4] pwm: rzg2l-gpt: Add support for gpt linking with
 poeg
Message-ID: <iukf4j5bewacpg4k2ucczwjdcv2wvmokjqxasvgij6l6436chp@r242vjhfwaee>
References: <20231120113307.80710-1-biju.das.jz@bp.renesas.com>
 <20231120113307.80710-5-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mn7jhgqhkjbtvxo3"
Content-Disposition: inline
In-Reply-To: <20231120113307.80710-5-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--mn7jhgqhkjbtvxo3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 11:33:07AM +0000, Biju Das wrote:
> The General PWM Timer (GPT) is capable of detecting "dead time error
> and short-circuits between output pins" and send Output disable
> request to poeg(Port Output Enable for GPT).
>=20
> Add support for linking poeg group with gpt, so that
> gpt can control the output disable function.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
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
> index 428e6e577db6..a309131db8ee 100644
> --- a/drivers/pwm/pwm-rzg2l-gpt.c
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -31,6 +31,7 @@
>  #define RZG2L_GTCR		0x2c
>  #define RZG2L_GTUDDTYC		0x30
>  #define RZG2L_GTIOR		0x34
> +#define RZG2L_GTINTAD		0x38
>  #define RZG2L_GTBER		0x40
>  #define RZG2L_GTCNT		0x48
>  #define RZG2L_GTCCRA		0x4c
> @@ -48,9 +49,15 @@
>  #define RZG2L_UP_COUNTING	(RZG2L_GTUDDTYC_UP | RZG2L_GTUDDTYC_UDF)
> =20
>  #define RZG2L_GTIOR_GTIOA	GENMASK(4, 0)
> +#define RZG2L_GTIOR_OADF	GENMASK(10, 9)
>  #define RZG2L_GTIOR_GTIOB	GENMASK(20, 16)
> +#define RZG2L_GTIOR_OBDF	GENMASK(26, 25)
>  #define RZG2L_GTIOR_OAE		BIT(8)
>  #define RZG2L_GTIOR_OBE		BIT(24)
> +#define RZG2L_GTIOR_OADF_HIGH_IMP_ON_OUT_DISABLE	BIT(9)
> +#define RZG2L_GTIOR_OBDF_HIGH_IMP_ON_OUT_DISABLE	BIT(25)
> +#define RZG2L_GTIOR_PIN_DISABLE_SETTING \
> +	(RZG2L_GTIOR_OADF_HIGH_IMP_ON_OUT_DISABLE | RZG2L_GTIOR_OBDF_HIGH_IMP_O=
N_OUT_DISABLE)
> =20
>  #define RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE	0x07
>  #define RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
> @@ -64,6 +71,8 @@
>  #define RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH \
>  	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE) | R=
ZG2L_GTIOR_OBE)
> =20
> +#define RZG2L_GTINTAD_GRP_MASK			GENMASK(25, 24)
> +
>  #define RZG2L_GTCCR(i) (0x4c + 4 * (i))
> =20
>  #define RZG2L_MAX_HW_CHANNELS	8
> @@ -76,6 +85,9 @@
> =20
>  #define RZG2L_GET_CH_OFFS(i) (0x100 * (i))
> =20
> +#define RZG2L_MAX_POEG_GROUPS	4
> +#define RZG2L_LAST_POEG_GROUP	3
> +
>  struct rzg2l_gpt_chip {
>  	struct pwm_chip chip;
>  	void __iomem *mmio;
> @@ -88,6 +100,7 @@ struct rzg2l_gpt_chip {
>  	u32 user_count[RZG2L_MAX_HW_CHANNELS];
>  	u32 enable_count[RZG2L_MAX_HW_CHANNELS];
>  	DECLARE_BITMAP(ch_en_bits, RZG2L_MAX_PWM_CHANNELS);
> +	DECLARE_BITMAP(poeg_gpt_link, RZG2L_MAX_POEG_GROUPS * RZG2L_MAX_HW_CHAN=
NELS);
>  };
> =20
>  static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip *=
chip)
> @@ -454,6 +467,75 @@ static void rzg2l_gpt_reset_assert_pm_disable(void *=
data)
>  	reset_control_assert(rzg2l_gpt->rstc);
>  }
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
> +	u32 offs;
> +	int ret;
> +
> +	cells =3D of_property_count_u32_elems(pdev->dev.of_node, "renesas,poegs=
");
> +	if (cells =3D=3D -EINVAL)
> +		return;
> +
> +	cells >>=3D 1;
> +	for (i =3D 0; i < cells; i++) {
> +		ret =3D of_parse_phandle_with_fixed_args(pdev->dev.of_node,
> +						       "renesas,poegs", 1, i,
> +						       &of_args);

If you use of_for_each_phandle() here, you don't need to determine the
length first.

> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"Failed to parse 'renesas,poegs' property\n");
> +			return;
> +		}
> +
> +		if (of_args.args[0] >=3D RZG2L_MAX_HW_CHANNELS) {
> +			dev_err(&pdev->dev, "Invalid channel %d >=3D %d\n",
> +				of_args.args[0], RZG2L_MAX_HW_CHANNELS);
> +			of_node_put(of_args.np);
> +			return;
> +		}
> +
> +		bitpos =3D of_args.args[0];

This can be moved further down, and so nearer to where it is actually
used.

> +		if (!of_device_is_available(of_args.np)) {
> +			/* It's fine to have a phandle to a non-enabled poeg. */
> +			of_node_put(of_args.np);
> +			continue;
> +		}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mn7jhgqhkjbtvxo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWJyfkACgkQj4D7WH0S
/k5PWgf/UOxCoa5DJPl8CXTDBZz+itaPzQOgDYU+ewswxWlrAghErEd+Uv6c+E+i
MEcZHmqByTRsR2Lj42od4fOQa8o5pxwYp54UyL19qgrK1ELrnoFRt/8QygObvCBk
h138rJ4DtAZss0baxQb6IaMwtM0Qo8o6K/FMBufmEU+21Cg3/FR+4eyZCDIF192M
QZ+0i8pR+xa3tyCyF6TlFi0SmnEG6EBI3WDiaKchO/jTVTWjxPTziVyo2/DfpcWg
LBpPitootrabDQz+eTLFvG47PxpCnmEMjgM1wrp0GqAH4t48sxFsHPJXvaZdi4N6
KGORoN4gMGmxDg8yjzDcVNMPIM2HdQ==
=pQNf
-----END PGP SIGNATURE-----

--mn7jhgqhkjbtvxo3--

