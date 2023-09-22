Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCF67AB0DB
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Sep 2023 13:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbjIVLcO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Sep 2023 07:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjIVLcJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Sep 2023 07:32:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5359ECEC
        for <linux-pwm@vger.kernel.org>; Fri, 22 Sep 2023 04:31:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A02BC433C8;
        Fri, 22 Sep 2023 11:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695382318;
        bh=dDlwHF+eiY9+hTkqn2XNMeoXlkZ1Ja1adnUXIXYrsVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jGDkLx6p8bRr/3DfeoGHdwbSJLCHEzTtWl9ylQpGHLQv7/TU8fqPaAKU+T0ca8DWz
         ZsKzXDvpUquCiRZE5iv8i1+drr1z1tkXUJsfMQdodNYDGgU3XwmOOMfMe3p8bV1NJW
         7NK5CcSdAk8ZsTR7lwFxj1fzp2Z1wXsYDj2ScRMW1Pu4OwbL7ZA/6I9sWua/EROV2M
         WlFEsxKalwKXTm45y3KxcMOOFbaaC37HGgQBzFIT00tRoLvwHbgi1GS1u0P4MmcqOs
         XQWmb5gjH6fd3QPYAsLIcYDy34S9w5GL2kDtJH/DT4WOJdr//NKdR+FiCqWjYgs/pR
         bgIQSJxtZY4Uw==
Date:   Fri, 22 Sep 2023 12:31:54 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH 2/3] dt-bindings: pwm: mxs: Document the clocks property
Message-ID: <20230922-likewise-twiddling-31da746e1920@spud>
References: <20230921184348.290261-1-festevam@gmail.com>
 <20230921184348.290261-2-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kku3baJfA0pbcSa+"
Content-Disposition: inline
In-Reply-To: <20230921184348.290261-2-festevam@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Kku3baJfA0pbcSa+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 03:43:47PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>=20
> The 'clocks' property is mandatory for the PWM to operate.
>=20
> Document it.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  Documentation/devicetree/bindings/pwm/mxs-pwm.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml b/Documen=
tation/devicetree/bindings/pwm/mxs-pwm.yaml
> index 655f008081d5..8f50e23ca8c9 100644
> --- a/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
> @@ -25,6 +25,9 @@ properties:
>    reg:
>      maxItems: 1
> =20
> +  clocks:
> +    maxItems: 1
> +
>    "#pwm-cells":
>      const: 3
> =20
> @@ -35,6 +38,7 @@ properties:
>  required:
>    - compatible
>    - reg
> +  - clocks
>    - fsl,pwm-number
> =20
>  additionalProperties: false
> @@ -44,6 +48,7 @@ examples:
>      pwm@80064000 {
>          compatible =3D "fsl,imx23-pwm";
>          reg =3D <0x80064000 0x2000>;
> +        clocks =3D <&clks 30>;
>          #pwm-cells =3D <3>;
>          fsl,pwm-number =3D <8>;
>      };
> --=20
> 2.34.1
>=20

--Kku3baJfA0pbcSa+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQ17KgAKCRB4tDGHoIJi
0nnAAP9aKmv4TvjQRQnrd38ZV4M/TPb47lSdBh4E19+q9epRKgEA2LqRFCTgHtON
gNHVSJoFelrAc+YikAWG23Bg8hDOIA4=
=PCgT
-----END PGP SIGNATURE-----

--Kku3baJfA0pbcSa+--
