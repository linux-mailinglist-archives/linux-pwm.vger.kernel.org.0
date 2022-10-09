Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1E65F8EDF
	for <lists+linux-pwm@lfdr.de>; Sun,  9 Oct 2022 23:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiJIVPS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 9 Oct 2022 17:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiJIVOz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 9 Oct 2022 17:14:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCEA1AF1E;
        Sun,  9 Oct 2022 14:13:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8753360C79;
        Sun,  9 Oct 2022 21:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA3EC433D6;
        Sun,  9 Oct 2022 21:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665349989;
        bh=y/vuj298TobbmTUgC2gtr5IiQQXFOztoALIpmHmy5ZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ilyGNZkg9qABwN/cUAzDnXQFv5BRs1FhVHltijx1PJpus/Zx31NvT6Hb+TYnYKisW
         Nhe7M3Xrq1cix3eZHurGF2QcOalZKilm+3U+1qbJsEuHxqvAPyWoM7JK10ZIsvUJ9Q
         AGNZw7NXTvMZG/GYVxWiqEo1QQ3PO6wI5cIJ+4Xi7/8L3cYtTKr8OmnlOd6C8zQZT/
         O9TAJ1qioAtor9AczRdONd9UKUMFuM945cL8cWq+933LmnrNMcCV0ANYJsdiiXBMNr
         9XTlMx1ic4H5cxjZ7rWl9IDUhktgcQXgGUoY7T1tO/s5kFWN7/SAxViw1n2wYlC8Vc
         Yglxh5AdJ/Vag==
Date:   Sun, 9 Oct 2022 23:13:06 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: renesas,pwm-rcar: Add r8a779g0 support
Message-ID: <Y0M5Ygv9ALPb94Hf@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <7785f163a5a798574c68495de8b0ca7a02e35f07.1665156318.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SNj1/ZNMPPXvsfJb"
Content-Disposition: inline
In-Reply-To: <7785f163a5a798574c68495de8b0ca7a02e35f07.1665156318.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--SNj1/ZNMPPXvsfJb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 07, 2022 at 05:25:56PM +0200, Geert Uytterhoeven wrote:
> Document support for the PWM timers in the Renesas R-Car V4H (R8A779G0)
> SoC.
>=20
> Based on a patch in the BSP by CongDang.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--SNj1/ZNMPPXvsfJb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmNDOV4ACgkQFA3kzBSg
Kbbrvg/+MuB0iN8uvChRjFAL+DksyM6IqlKyfQV+ZMHMYQr0EYKOKX5I20fm66z5
JeTcj6+kOS9M5JNuErbU6RI/tMKqjHApBjckO4h8RGc5ghfnKVLNQxKWQe1JwX8U
vEEjJvMCIRWw6WfMZBV4shPqo2ILKHz6Pd2ZeQeMZqf+PxSS4cfXvwTIeKvCepL6
2qYRq5p0/en6et1rqvkpyZnK48vg8UWU/Yf47xSliV8N3IRrs8kUMYoS3FsCpqYI
AIAUoqWqA3Us5APNhcGh7dEtjOm4V9gsg2KQ+B+Nb8nKMr3iOLjqatZeE/v3IQan
2iZG9dlvE2EsK3MG8T7kLAiBQ92RpkGifPWbXWbWMKCSrEbIIEEif1/IvuWjHhkl
l9HV/Sk1uX7gZ7DqVYxtkSDVUoBDDiofVlJzsvAm394nyf9jjhGzRYoPtCMnpRNK
kPSIV+pVpWYmHOX5m5Uf11vAAwL5l2gMPgE9nUBqYKZWiVJDRsyVOCOIRq7RsdmI
l+X1hkNMBtwI1WuL0tCvmZNmRiqUi54AHCkftqD2SPUoaNHcscm1Xg6yUm2kTIEc
fAwpE34FDYtaMclaPlzw5XQnWl6T4YFFQQFlArIBO8hCdj/EGJ7xTelOdEGpYf/R
usxAf2TDU0Zip6NMaOvJ1EK2CL+KaByjbbwGOSMEm02SjJRruvQ=
=yA1p
-----END PGP SIGNATURE-----

--SNj1/ZNMPPXvsfJb--
