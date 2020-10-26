Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8267299258
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Oct 2020 17:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785915AbgJZQ0X (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Oct 2020 12:26:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:47980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404162AbgJZQ0W (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 26 Oct 2020 12:26:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EEE67AC48;
        Mon, 26 Oct 2020 16:26:19 +0000 (UTC)
Message-ID: <160f3f542a89e0263d5d375fdae796af6017c33c.camel@suse.de>
Subject: Re: [PATCH v2 01/10] firmware: raspberrypi: Introduce
 rpi_firmware_put()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        linux-input <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Date:   Mon, 26 Oct 2020 17:26:17 +0100
In-Reply-To: <CAHp75Vej4UfsySRB6qXL7fFN7SjnTjy=p4Xkn1xBO0YOFy-kcQ@mail.gmail.com>
References: <20201022155858.20867-1-nsaenzjulienne@suse.de>
         <20201022155858.20867-2-nsaenzjulienne@suse.de>
         <CAHp75Vej4UfsySRB6qXL7fFN7SjnTjy=p4Xkn1xBO0YOFy-kcQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+M2bTZi8S7Ge32C0tkNp"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-+M2bTZi8S7Ge32C0tkNp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-22 at 21:46 +0300, Andy Shevchenko wrote:
> On Thu, Oct 22, 2020 at 9:06 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > When unbinding the firmware device we need to make sure it has no
> > consumers left. Otherwise we'd leave them with a firmware handle
> > pointing at freed memory.
> >=20
> > Keep a reference count of all consumers and make sure they all finished
> > unbinding before we do.
>=20
> Wait, if it's a device, why do we need all these?
> get_device() / put_device() along with module_get() / module_put()
> should be sufficient, no?

Could you expand here a little, I do see how I could use get_device()'s
reference count. But it seems to me I'd be digging way too deep into kobj i=
n
order to get the functionality I need.

If you meant to say that it should be automatically taken care by the platf=
orm
bus, just FYI we're using 'simple-mfd' in DT. Where firmware supplier is th=
e
parent and all consumers are children.

Regards,
Nicolas


--=-+M2bTZi8S7Ge32C0tkNp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+W+KkACgkQlfZmHno8
x/6XwQf+N4Vi5LyZRLbYPf2alcEVhV4rJF362cZVbIn76rK576WGug740xSWsiwO
gfzWfNuZQ8dHdYtromdKWWMK3JYZ1EYnhWwxzQVC9bhKypTweP7tpIxNgdQLfoi0
qS6Omn19ldcynO+YlLCEp76lrapt5ADWIGR5phjOWOj2yPHYJN0TsaQ80bNsNHZL
caC8ddA5LxpEZKe8NEd9tqOdhB9rnvTHmPLG4A7CdjCsNdwcO6TXUTM4os21JNVv
IB/eaEzZp7DLTWVAUJxV+HIX0SSdy80TCryzgCsfbcd8q6AuD2RWtWpVQ88Qtrbl
fFrXd+Hf3/iVhraCCi5GKegidy4SyA==
=30G8
-----END PGP SIGNATURE-----

--=-+M2bTZi8S7Ge32C0tkNp--

