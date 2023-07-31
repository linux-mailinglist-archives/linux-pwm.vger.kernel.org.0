Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A167769B21
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Jul 2023 17:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjGaPsc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Jul 2023 11:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjGaPs2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Jul 2023 11:48:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0715B198B;
        Mon, 31 Jul 2023 08:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27D86611B6;
        Mon, 31 Jul 2023 15:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4B9C433C8;
        Mon, 31 Jul 2023 15:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690818502;
        bh=m8ixijRMZAOC8xXD813MvkECftXap9fxbZmJs4qUrjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RnlbfEelf7XNw9O+XPFTHvfkgD8Scu56CN6ZL1urjtMpZ2bGybgt/QN9yu++SVeMe
         jtIf0/yKc487JZ4l/skphUCSPFtcmrJH1dMlwIe+tT1r7HU3fwtdGAXg9NJcRyU9sX
         3YoNFSXM+A2g3Jm2JUuPPJIkIWszxZv90+rLxdGRrBr5Px+TZn3pKo4mKbjCu6CY3r
         cWJd3bTtePrtJI8zNsUxaJQsU9OCDRfhEIjAJlHnhIsb+Yn1hXLiI8qQO0azh6ibja
         YUZnxHGzEE37m5erQ2sQWGID+2gd9tGjOFOCOZbxmkTe72MVp76FNfz7iiCq8aFgeW
         3tSD7SOl0FuXw==
Date:   Mon, 31 Jul 2023 16:48:17 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jagan Teki <jagan@edgeble.ai>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 01/13] dt-bindings: pwm: rockchip: Document rv1126-pwm
Message-ID: <20230731-doornail-shrunk-26c9948dacf9@spud>
References: <20230731103518.2906147-1-jagan@edgeble.ai>
 <20230731103518.2906147-2-jagan@edgeble.ai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="svlWwtAlFNyPjpWF"
Content-Disposition: inline
In-Reply-To: <20230731103518.2906147-2-jagan@edgeble.ai>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--svlWwtAlFNyPjpWF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2023 at 04:05:06PM +0530, Jagan Teki wrote:
> Document pwm compatible for rv1126 which is fallback compatible
> of rk3328-pwm group.
>=20
> Signed-off-by: Jagan Teki <jagan@edgeble.ai>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
> Cc: linux-pwm@vger.kernel.org
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.de>
>=20
>  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml b/Do=
cumentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> index f2d1dc7e7b3f..65bfb492b3a4 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> @@ -32,6 +32,7 @@ properties:
>                - rockchip,rk3308-pwm
>                - rockchip,rk3568-pwm
>                - rockchip,rk3588-pwm
> +              - rockchip,rv1126-pwm
>            - const: rockchip,rk3328-pwm
> =20
>    reg:
> --=20
> 2.25.1

--svlWwtAlFNyPjpWF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMfXwQAKCRB4tDGHoIJi
0mUeAP9FfrnB/pm7rQ7mO6aHsHn/jUsaVsmx7s+8Dwkbx3KQnQD+OHt+J0rsv5CK
UZeS0tqfxtrUSgvDrGKzYGeTNadu1Ak=
=ova7
-----END PGP SIGNATURE-----

--svlWwtAlFNyPjpWF--
