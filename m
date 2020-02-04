Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8A1151797
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Feb 2020 10:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgBDJRt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 Feb 2020 04:17:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:49496 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgBDJRs (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 4 Feb 2020 04:17:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9DE97AC65;
        Tue,  4 Feb 2020 09:17:46 +0000 (UTC)
Message-ID: <08e2b640f0a7713d905295fc4f75df49617be6c1.camel@suse.de>
Subject: Re: [PATCH] pwm: bcm2835: Dynamically allocate base
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        Bart Tanghe <bart.tanghe@thomasmore.be>,
        Scott Branden <sbranden@broadcom.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Ray Jui <rjui@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Tue, 04 Feb 2020 10:17:43 +0100
In-Reply-To: <20200203213536.32226-1-f.fainelli@gmail.com>
References: <20200203213536.32226-1-f.fainelli@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-EbQc4kroDO+Hs5CLjdIl"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-EbQc4kroDO+Hs5CLjdIl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-02-03 at 13:35 -0800, Florian Fainelli wrote:
> The newer 2711 and 7211 chips have two PWM controllers and failure to
> dynamically allocate the PWM base would prevent the second PWM
> controller instance being probed for succeeding with an -EEXIST error
> from alloc_pwms().
>=20
> Fixes: e5a06dc5ac1f ("pwm: Add BCM2835 PWM driver")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

>  drivers/pwm/pwm-bcm2835.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
> index 91e24f01b54e..d78f86f8e462 100644
> --- a/drivers/pwm/pwm-bcm2835.c
> +++ b/drivers/pwm/pwm-bcm2835.c
> @@ -166,6 +166,7 @@ static int bcm2835_pwm_probe(struct platform_device *=
pdev)
> =20
>  	pc->chip.dev =3D &pdev->dev;
>  	pc->chip.ops =3D &bcm2835_pwm_ops;
> +	pc->chip.base =3D -1;
>  	pc->chip.npwm =3D 2;
>  	pc->chip.of_xlate =3D of_pwm_xlate_with_flags;
>  	pc->chip.of_pwm_n_cells =3D 3;


--=-EbQc4kroDO+Hs5CLjdIl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl45NrcACgkQlfZmHno8
x/6nWwf/bExOZqkMvtRTNZmYHlMDm/EcuWxY09oRB9bF+sIaJZVAbkj1+gTil1cr
ATdzExmfH0rifiRTbUNV8FaRVhVVYgy0NW+uSmz/+z/pCJ6utDfhPXrkc9nR0tCk
5QrrBVZBPwxQB6VY1nFPSXYQlhR0F7AitIjoCH+ITRPIbCC8fCzamU+COu9vxDuw
QWVA/tYIwTqAV9DKFg31H1SJqhphepSjZ4OTUTO3Yq1H+abKiYUGtS9QYO0I8JI6
23yFymYMBAW53C68ZX9rsg4A//bg/vwDEwP2MgKOXcrmicLZs4s4vx1CyZu6VrGn
2YmNKpAeZ0qy2PRhqdluWH6RM5JNQA==
=tBu+
-----END PGP SIGNATURE-----

--=-EbQc4kroDO+Hs5CLjdIl--

