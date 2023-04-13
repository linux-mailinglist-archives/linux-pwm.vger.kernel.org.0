Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A35B6E0CC5
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Apr 2023 13:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDMLif (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Apr 2023 07:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDMLie (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Apr 2023 07:38:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152DC269D
        for <linux-pwm@vger.kernel.org>; Thu, 13 Apr 2023 04:38:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmvHb-0007gS-7S; Thu, 13 Apr 2023 13:38:31 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmvHa-00AxLD-IL; Thu, 13 Apr 2023 13:38:30 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmvHZ-00Crf9-Q5; Thu, 13 Apr 2023 13:38:29 +0200
Date:   Thu, 13 Apr 2023 13:38:29 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: Delete deprecated functions pwm_request() and
 pwm_free()
Message-ID: <20230413113829.pm32b3mdnyu477gi@pengutronix.de>
References: <20230412115636.3533366-1-u.kleine-koenig@pengutronix.de>
 <ZDfLyP5bP0PdBS1J@orome>
 <ZDfMF3wAfbd-1y-Z@orome>
 <ZDfMtB_lakGPDsZZ@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3giti53lh6iuvrys"
Content-Disposition: inline
In-Reply-To: <ZDfMtB_lakGPDsZZ@orome>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--3giti53lh6iuvrys
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2023 at 11:34:44AM +0200, Thierry Reding wrote:
> On Thu, Apr 13, 2023 at 11:32:07AM +0200, Thierry Reding wrote:
> > On Thu, Apr 13, 2023 at 11:30:48AM +0200, Thierry Reding wrote:
> > > On Wed, Apr 12, 2023 at 01:56:36PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > Since commit 5a7fbe452ad9 ("backlight: pwm_bl: Drop support for leg=
acy PWM
> > > > probing") the last user of pwm_request() and pwm_free() is gone. So=
 remove
> > > > these functions that were deprecated over 10 years ago in commit
> > > > 8138d2ddbcca ("pwm: Add table-based lookup for static mappings").
> > > >=20
> > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > >  Documentation/driver-api/pwm.rst | 13 ++++-----
> > > >  drivers/pwm/core.c               | 49 ----------------------------=
----
> > > >  include/linux/pwm.h              | 13 ---------
> > > >  3 files changed, 5 insertions(+), 70 deletions(-)
> > >=20
> > > There seem to be two more occurrences of pwm_free() in
> > > drivers/pwm/core.c, but I think they can trivially be replaced by
> > > pwm_put(). I can do that while applying, but let me know if you don't
> > > agree.
> >=20
> > I also get warnings about pwm_to_device() now being unused, so I'll
> > remove that one along with these.
>=20
> With pwm_to_device() gone, there's now also no purpose in the pwm_tree
> radix tree, so let me try to drop that as well.

Huh, it seems I was too sloppy here. Thanks for cleaning up after me.
Feel free to grab authorship of your result, given that you seem to have
done more than me now.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3giti53lh6iuvrys
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQ36bQACgkQj4D7WH0S
/k5G6Af9FmEwGbW+zVQoRIATVp9loxC6Urucf7nSMsh9D1WKdp8UglGbiwVPUPMI
NXY7Orm9CSA5bRRnURifsIwSWHSwH5Ys+3KGuJoIv30cT/mngE+EIpfjNBwZKZ1c
8IHr9zsYLw3FHwYgEIrt9FTmAgrVRk073pF4fcKbpvhZ9dSPINDNzw6GphgRQnZa
8379eTz+4uuMy/5Vp0r1rRWF9yYgcs4NHyqQ94DMMKJ81I0Aea8WK9wpoRI8X2BT
txUT5FU5FshyqNGrByiEoLRdzQNx6iWo435ZqKJ6vv22n7hlzaM9TwWryEyJcDS1
dw3FqLquzoyBan6gz0LOjJZdA8UTtg==
=UcwA
-----END PGP SIGNATURE-----

--3giti53lh6iuvrys--
