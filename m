Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9D863A8DB
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Nov 2022 14:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiK1NBV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Nov 2022 08:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiK1NBR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Nov 2022 08:01:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A311D2F5
        for <linux-pwm@vger.kernel.org>; Mon, 28 Nov 2022 05:01:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozdkz-0007XG-0d; Mon, 28 Nov 2022 14:01:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozdkw-000p7D-B2; Mon, 28 Nov 2022 14:01:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ozdkw-000wFj-7A; Mon, 28 Nov 2022 14:01:06 +0100
Date:   Mon, 28 Nov 2022 14:01:04 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 3/3] pwm: rzg2l-gpt: Add support for linking with poeg
Message-ID: <20221128130104.tthhusejfv5qgnyy@pengutronix.de>
References: <20221111192942.717137-1-biju.das.jz@bp.renesas.com>
 <20221111192942.717137-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zwzz2lgd2oubx5vn"
Content-Disposition: inline
In-Reply-To: <20221111192942.717137-4-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zwzz2lgd2oubx5vn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 11, 2022 at 07:29:42PM +0000, Biju Das wrote:
> This patch add support for linking poeg group with gpt, so that
> gpt can control the output disable function.

Without knowing what a "gpt" and a "poeg" is, I don't understand the
purpose of this patch. Why do I want the gpt to be able to control the
output disable function and what is this?

> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Replaced id->poeg-id as per poeg bindings.
> This patch depend upon [1]
> [1] https://lore.kernel.org/linux-renesas-soc/20221111162325.471963-3-bij=
u.das.jz@bp.renesas.com/T/#u
> ---
>  drivers/pwm/pwm-rzg2l-gpt.c | 69 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> index 3f9325e958b8..e16f976c3dcb 100644
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
> @@ -64,12 +71,16 @@
>  #define RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH \
>  	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE) | R=
ZG2L_GTIOR_OBE)
> =20
> +#define RZG2L_GTINTAD_GRP_MASK			GENMASK(25, 24)
> +
>  #define RZG2L_GTCCR(i) (0x4c + 4 * (i))
> =20
>  #define RZG2L_MAX_HW_CHANNELS	(8)
>  #define RZG2L_CHANNELS_PER_IO	(2)
>  #define RZG2L_MAX_PWM_CHANNELS	(RZG2L_MAX_HW_CHANNELS * RZG2L_CHANNELS_P=
ER_IO)
> =20
> +#define RZG2L_MAX_POEG_GROUPS	(4)
> +
>  #define RZG2L_IS_IOB(a) ((a) & 0x1)
>  #define RZG2L_GET_CH_INDEX(a) ((a) / 2)
> =20
> @@ -85,6 +96,7 @@ struct rzg2l_gpt_chip {
>  	u32 state_period[RZG2L_MAX_HW_CHANNELS];
>  	u32 user_count[RZG2L_MAX_HW_CHANNELS];
>  	u8 prescale[RZG2L_MAX_HW_CHANNELS];
> +	DECLARE_BITMAP(poeg_gpt_link, RZG2L_MAX_POEG_GROUPS * RZG2L_MAX_HW_CHAN=
NELS);
>  };
> =20
>  static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip *=
chip)
> @@ -438,6 +450,62 @@ static void rzg2l_gpt_reset_assert_pm_disable(void *=
data)
>  	reset_control_assert(rzg2l_gpt->rstc);
>  }
> =20
> +static void rzg2l_gpt_parse_properties(struct platform_device *pdev,
> +				       struct rzg2l_gpt_chip *rzg2l_gpt)
> +{
> +	struct of_phandle_args of_args;
> +	unsigned int i;
> +	u32 poeg_grp;
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
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"Failed to parse 'renesas,poegs' property\n");
> +			return;
> +		}
> +
> +		if (of_args.args[0] >=3D RZG2L_MAX_HW_CHANNELS) {
> +			dev_err(&pdev->dev,
> +				"Invalid channel %d > 7\n", of_args.args[0]);
> +			return;
> +		}
> +
> +		if (!of_device_is_available(of_args.np)) {
> +			/* It's fine to have a phandle to a non-enabled poeg. */
> +			of_node_put(of_args.np);
> +			continue;
> +		}
> +
> +		if (!of_property_read_u32(of_args.np, "renesas,poeg-id", &poeg_grp)) {
> +			offs =3D RZG2L_GET_CH_OFFS(of_args.args[0]);
> +
> +			set_bit(poeg_grp * RZG2L_MAX_HW_CHANNELS + of_args.args[0],
> +				rzg2l_gpt->poeg_gpt_link);

You might want to check if poeg_grp * RZG2L_MAX_HW_CHANNELS +
of_args.args[0] is less than 32 (i.e. the length of the poeg_gpt_link
bitmap). Also ensure that poeg_grp is withing bounds.

> +			rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTINTAD,
> +					 RZG2L_GTINTAD_GRP_MASK,
> +					 poeg_grp << 24);
> +
> +			rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
> +					 RZG2L_GTIOR_OBDF | RZG2L_GTIOR_OADF,
> +					 RZG2L_GTIOR_PIN_DISABLE_SETTING);
> +		}
> +
> +		of_node_put(of_args.np);
> +	}
> +}
> +
>  static int rzg2l_gpt_probe(struct platform_device *pdev)
>  {
>  	DECLARE_BITMAP(ch_en_bits, RZG2L_MAX_PWM_CHANNELS);

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zwzz2lgd2oubx5vn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOEsQ0ACgkQwfwUeK3K
7Alhlwf/URvm3JkpZsPQqLW1V8GG73EOk4mwcfcnbfRpBc/WtWyDXf+KVyBq46k0
UPswAVrObkjloLDq99TeUcKgDJsy8c1yTXCLoOXEvvY8o277xDRRUsSezzcVjEE0
yrvKOcaWiL856PDpKynsUhUn0h3+n7YTMITTbzk7fpilTd6e06FDqNkGmfNxJxaD
o12YyHDsB42eiqvkKpq9MT6XFAmDRmtH7a0PiS9CXln7Cv6zhiuOFXQe0Ekw1h5K
ktEOJA0naXh7q4+5KN/n6AD6LLiUD2MhggQhRgJrpgEWYGZljmNxspWYsa++zTAA
KuD7G3x/9Tt17M9VkF54VUBXKwR2wQ==
=q5vc
-----END PGP SIGNATURE-----

--zwzz2lgd2oubx5vn--
