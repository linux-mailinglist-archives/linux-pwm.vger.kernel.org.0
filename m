Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1822D4033
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Dec 2020 11:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgLIKmx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Dec 2020 05:42:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:34822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgLIKmx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 9 Dec 2020 05:42:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08849AB63;
        Wed,  9 Dec 2020 10:42:11 +0000 (UTC)
Message-ID: <fcc97ca28c3aaa3ab69b4de4818c1dc89b85b430.camel@suse.de>
Subject: Re: [PATCH v5 11/11] pwm: Add Raspberry Pi Firmware based PWM bus
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     f.fainelli@gmail.com, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org, bgolaszewski@baylibre.com,
        andy.shevchenko@gmail.com
Date:   Wed, 09 Dec 2020 11:42:09 +0100
In-Reply-To: <20201123183833.18750-12-nsaenzjulienne@suse.de>
References: <20201123183833.18750-1-nsaenzjulienne@suse.de>
         <20201123183833.18750-12-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-DYDWHGJjHHu30M9SeI+k"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-DYDWHGJjHHu30M9SeI+k
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

On Mon, 2020-11-23 at 19:38 +0100, Nicolas Saenz Julienne wrote:
> Adds support to control the PWM bus available in official Raspberry Pi
> PoE HAT. Only RPi's co-processor has access to it, so commands have to
> be sent through RPi's firmware mailbox interface.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20

I'll soon send a v6 of this series and was wondering if there is any more
feedback for this patch.

Regards,
Nicolas


--=-DYDWHGJjHHu30M9SeI+k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl/QqgEACgkQlfZmHno8
x/4KCgf/atII/Noi91247tu9b99CnitDBaC5oT2VJlArRSWUNcHEEJPbZ1seDvpF
wmsApHQ7yKkAnDJdCzSRj7K+/Pp8PhETFK/vmD5TWAxaBtjbvvdHDQT+2RvLSthv
x4AJ/aAdpPsHuGzde7JViJAuogdoPuqVWExVPdjBbA2+SoWmuHxsaCBtnlD+HYhL
jP+22+d6ea9OTvtVHgWrgeRjfWXPaNSvQ6GCWASLBpbsfssUWlSWWAURk4NP/lXA
XhGFaDg+yzd1scAtX8T74lseUd7EP0sMpGmL4G3YWx1eg1oLSChdPx4hdupyIA6G
ZUcTKvwbLhTkXiSJYnXeAUDjSgbJag==
=FbnN
-----END PGP SIGNATURE-----

--=-DYDWHGJjHHu30M9SeI+k--

