Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2720A288213
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Oct 2020 08:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgJIGY4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Oct 2020 02:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgJIGY4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Oct 2020 02:24:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDFFC0613D2
        for <linux-pwm@vger.kernel.org>; Thu,  8 Oct 2020 23:24:56 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kQlpf-0008Du-Q0; Fri, 09 Oct 2020 08:24:47 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kQlpd-0003hL-Bb; Fri, 09 Oct 2020 08:24:45 +0200
Date:   Fri, 9 Oct 2020 08:24:45 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: renesas,tpu-pwm: Document
 r8a7742 support
Message-ID: <20201009062445.5g6xck2i5olssokd@pengutronix.de>
References: <20201006081910.1238-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201006081910.1238-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ltd56jumaoflevxr"
Content-Disposition: inline
In-Reply-To: <20201006081910.1238-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Autocrypt: addr=u.kleine-koenig@pengutronix.de; keydata=
        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
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ltd56jumaoflevxr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 06, 2020 at 09:19:09AM +0100, Lad Prabhakar wrote:
> Document r8a7742 specific compatible strings. No driver change is
> needed as the fallback compatible string "renesas,tpu" activates the
> right code in the driver.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renes=
as.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Which tree is this patch series supposed to go in via? pwm or renesas?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ltd56jumaoflevxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+AAioACgkQwfwUeK3K
7AnLUwf/aqq483+p8J2ybZE7iPRU0AXsxfTTg7k31cUcKEsivgLoKVzlchpXIAz+
sicRnqUVyxw94ddWhVGYyLEr9OzfU3v6wmv+L6tzf1ZughE3oLW8Tj4hPLDhPQUz
V80sfTsIyCaXqPesDeHHlu9UNllDaXwCZN/9fumOH6G/GwFAtS5GXMxxCi81o55G
Ffvf5IBjJ1xE3kpWaao22x1xsR5i2ri0GkHaU/QFXm/pqD1lHHrQicQQBamPcD+j
5kO2BNcxiYu9FAYBP02z9A0jrRtJT2f0k6hqp9uwumphgRmP5AsdFG0VI2t8gYfC
ttv0dXCXREEm6Q8cQ9MKVr/LYa2kEA==
=5/Zy
-----END PGP SIGNATURE-----

--ltd56jumaoflevxr--
