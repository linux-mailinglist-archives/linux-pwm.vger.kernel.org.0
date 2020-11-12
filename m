Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27A62B01BB
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 10:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgKLJIM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 04:08:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:37746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbgKLJGZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 12 Nov 2020 04:06:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 96635AE78;
        Thu, 12 Nov 2020 09:06:23 +0000 (UTC)
Message-ID: <9e3a04f0ae76675f610bf25e6b53b4aff26afae4.camel@suse.de>
Subject: Re: [PATCH v3 07/11] input: raspberrypi-ts: Release firmware handle
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
Date:   Thu, 12 Nov 2020 10:06:21 +0100
In-Reply-To: <20201112014542.GA1003057@dtor-ws>
References: <20201104103938.1286-1-nsaenzjulienne@suse.de>
         <20201104103938.1286-8-nsaenzjulienne@suse.de>
         <20201112014542.GA1003057@dtor-ws>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-j2+UKM6wkcW3jVx2ysNJ"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-j2+UKM6wkcW3jVx2ysNJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-11-11 at 17:45 -0800, Dmitry Torokhov wrote:
> Hi Nicolas,
>=20
> On Wed, Nov 04, 2020 at 11:39:33AM +0100, Nicolas Saenz Julienne wrote:
> > Use devm_rpi_firmware_get() so as to make sure we release RPi's firmwar=
e
> > interface when unbinding the device.
>=20
> Unless I am mistaken this driver does not really need the firmware
> structure past rpi_ts_probe(), and will be fine if it disappears earlier
> than unbind time.

Yes, I missed that. Will update it.

Regards,
Nicolas


--=-j2+UKM6wkcW3jVx2ysNJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+s+w0ACgkQlfZmHno8
x/5iuQgApaPJZjl0NVPJ80THZ1yICuyOa9+6d8Bal28kwj6Ft8Xb+Z6ploXmWJ5T
EPDFQF4pFMoSBGmgGSspJj4dl/KD3UaeJIRB3c3UNqIC7icH9TpBZY4Z41Mioqsv
l4QH1DIWYVsRYi/9I1vhoijsquL5t5WK0c1N9GBs6GIQjVwEMN9tsDcQ3flTLKZs
93saK4xtDp6UbqsYQYtwmupmREvAIxqnm0g3GB/Qk8Fkg9vpIK0H5cRBaJT9bfb8
tQPpTY2LWTXQ53azvlBOcZC7yJQRBKitR2GkibS1ynNoNl43f5ZjyWXkzK2TEw1j
HOKtCH+6NObb7Wm+xwL50tkanpTaGg==
=eql2
-----END PGP SIGNATURE-----

--=-j2+UKM6wkcW3jVx2ysNJ--

