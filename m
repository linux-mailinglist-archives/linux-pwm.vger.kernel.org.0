Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190B02CD99C
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Dec 2020 15:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgLCOxg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Dec 2020 09:53:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:57454 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgLCOxf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 3 Dec 2020 09:53:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D6E6DAC6A;
        Thu,  3 Dec 2020 14:52:53 +0000 (UTC)
Message-ID: <25466e2a562765be1d67abd2d1bdae1a089a8d33.camel@suse.de>
Subject: Re: [PATCH v5 08/11] input: raspberrypi-ts: Release firmware handle
 when not needed
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        p.zabel@pengutronix.de, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        sboyd@kernel.org, linux-rpi-kernel@lists.infradead.org,
        bgolaszewski@baylibre.com, andy.shevchenko@gmail.com
Date:   Thu, 03 Dec 2020 15:52:52 +0100
In-Reply-To: <20201202060347.GA2034289@dtor-ws>
References: <20201123183833.18750-1-nsaenzjulienne@suse.de>
         <20201123183833.18750-9-nsaenzjulienne@suse.de>
         <20201202060347.GA2034289@dtor-ws>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ZvftALHIaTsXsRIracDG"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-ZvftALHIaTsXsRIracDG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-12-01 at 22:03 -0800, Dmitry Torokhov wrote:
> Hi Nicolas,
>=20
> On Mon, Nov 23, 2020 at 07:38:29PM +0100, Nicolas Saenz Julienne wrote:
> > Use devm_rpi_firmware_get() so as to make sure we release RPi's firmwar=
e
> > interface when unbinding the device.
>=20
> I do not believe this comment is correct any longer. Otherwise:
>=20
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Yes, sorry for that. I'll update it.

Regards,
Nicolas


--=-ZvftALHIaTsXsRIracDG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl/I+8QACgkQlfZmHno8
x/7NvQf+JfeK0Lnf/15akeGZ/8CgqH3D9RSZKgyFKFIcOAUVnKXWdodRdXxrVu0+
1VgbGz2N5efgb/8exdYKRQqJine/T/NLCHW1PcrUE/NJPvJZ+JdM8P+JcOndFCv3
ERWwKGhxK5gboL1Av3jiy9rUGSc/xDfmV5JZVDGnaANaDx7TWE0ZrznAqmwLhxfb
qWo3bToylX8NAWP5vNs24bzPP7KyQHBwXDNuC3LIg3n9D5aj8s/qq/ZbHK3upjIG
M/3jrHsvITNvyvy5xVhJhlzywtd2780n2VbwUW4JkfxELPxeCrJRmSyop46k98zX
qBEeTzyBfM9kHKAcklkuqve2moyBtw==
=2QiO
-----END PGP SIGNATURE-----

--=-ZvftALHIaTsXsRIracDG--

