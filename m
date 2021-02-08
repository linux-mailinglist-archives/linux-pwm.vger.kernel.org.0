Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8368A314110
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Feb 2021 21:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhBHU4p (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Feb 2021 15:56:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:40120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhBHUyp (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 8 Feb 2021 15:54:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BAD3EAE57;
        Mon,  8 Feb 2021 20:53:54 +0000 (UTC)
Message-ID: <5c69d62a7b4479d184b0ee8b8e5168e43cd494a0.camel@suse.de>
Subject: Re: [PATCH v7 11/11] pwm: Add Raspberry Pi Firmware based PWM bus
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     u.kleine-koenig@pengutronix.de
Cc:     f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org, bgolaszewski@baylibre.com,
        andy.shevchenko@gmail.com
Date:   Mon, 08 Feb 2021 21:53:52 +0100
In-Reply-To: <20210118123244.13669-12-nsaenzjulienne@suse.de>
References: <20210118123244.13669-1-nsaenzjulienne@suse.de>
         <20210118123244.13669-12-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-oVNnO66HmWqHkepYu506"
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-oVNnO66HmWqHkepYu506
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-01-18 at 13:32 +0100, Nicolas Saenz Julienne wrote:
> Adds support to control the PWM bus available in official Raspberry Pi
> PoE HAT. Only RPi's co-processor has access to it, so commands have to
> be sent through RPi's firmware mailbox interface.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20
> ---

ping :)

Regards,
Nicolas


--=-oVNnO66HmWqHkepYu506
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmAhpOEACgkQlfZmHno8
x/5Kegf+M/oVJydAlzbsZjeRxmVcRPlY/aU1YOdpfuIQyx991ny1JYSYaGMZ8b9g
lJ4nBwIeNjAbsPMc0Th89250D6UkOhRb5L7C6grd0B++Ue01IMyQ2mA8UzxxhzYI
aP/E3P1iwlnTpd/UbvgBr2xd2XBBEYEZ+CEeQohVX51Z/En4bEofLxQloVCwrAQ9
z+4AWH9ZQDX3ItJ1zmdJGzmNuZjuNQV2igYjp0UuWY01wIkeau20FxDqFMweN9ul
xMKBZ8zaX3T85TLQcYtj29KNQQGvUwV5xs8P36KJ5OfVUw4Ay4M5mSpb6nHb0GiU
9YqIJIOQ+gzZH+tFpYr93phGwLoI7Q==
=bPaD
-----END PGP SIGNATURE-----

--=-oVNnO66HmWqHkepYu506--

