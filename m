Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 766F3170151
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2020 15:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgBZOfY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Feb 2020 09:35:24 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:45748 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbgBZOfY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2020 09:35:24 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C82711C0411; Wed, 26 Feb 2020 15:35:22 +0100 (CET)
Date:   Wed, 26 Feb 2020 15:35:22 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 2/3] leds: pwm: convert to atomic PWM API
Message-ID: <20200226143522.GM4080@duo.ucw.cz>
References: <20200124165409.12422-1-uwe@kleine-koenig.org>
 <20200124165409.12422-3-uwe@kleine-koenig.org>
 <20200126191457.GB2569@labundy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="00sTfE/IIAT5d2r5"
Content-Disposition: inline
In-Reply-To: <20200126191457.GB2569@labundy.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--00sTfE/IIAT5d2r5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Fri, Jan 24, 2020 at 05:54:08PM +0100, Uwe Kleine-K=F6nig wrote:
> > pwm_config(), pwm_enable() and pwm_disable() should get removed in the
> > long run. So update the driver to use the atomic API that is here to
> > stay.
> >=20
> > A few side effects:
> >=20
> >  - led_pwm_set() now returns an error when setting the PWM fails.
> >  - During .probe() the PWM isn't disabled implicitly by pwm_apply_args()
> >    any more.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>

> And so:
>=20
> Tested-by: Jeff LaBundy <jeff@labundy.com>

Thanks for patches, thanks for testing.

1,2 applied to -for-next.

AFAICT 3/3 should really get the default-state: keep support before
being merged?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--00sTfE/IIAT5d2r5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXlaCKgAKCRAw5/Bqldv6
8tkqAJsF8bftZ3wS04FuyW4IpQygM1S14gCgg+4e6gWacsAZMM5NzL7n15EBm+M=
=Z5PN
-----END PGP SIGNATURE-----

--00sTfE/IIAT5d2r5--
