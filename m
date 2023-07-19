Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0993C75931B
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jul 2023 12:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjGSKcI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jul 2023 06:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjGSKcH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jul 2023 06:32:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA1A268D
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jul 2023 03:31:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qM4T3-0007JD-Mu; Wed, 19 Jul 2023 12:31:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qM4T0-000a0I-Kd; Wed, 19 Jul 2023 12:31:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qM4Sz-00652u-4l; Wed, 19 Jul 2023 12:31:33 +0200
Date:   Wed, 19 Jul 2023 12:31:32 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        James Clark <james.clark@arm.com>, kernel@pengutronix.de,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH 01/18] pwm: Provide devm_pwmchip_alloc() function
Message-ID: <20230719103132.h3tfor2dswza7z26@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
 <20230718181849.3947851-2-u.kleine-koenig@pengutronix.de>
 <ZLbwib753V6wSHKB@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c47aihx6qnumjkol"
Content-Disposition: inline
In-Reply-To: <ZLbwib753V6wSHKB@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--c47aihx6qnumjkol
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Tue, Jul 18, 2023 at 11:05:29PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 18, 2023 at 08:18:32PM +0200, Uwe Kleine-K=F6nig wrote:
> > This function allocates a struct pwm_chip and driver data. Compared to
> > the status quo the split into pwm_chip and driver data is new, otherwise
> > it doesn't change anything relevant (yet).
> >=20
> > The intention is that after all drivers are switched to use this
> > allocation function, its possible to add a struct device to struct
> > pwm_chip to properly track the latter's lifetime without touching all
> > drivers again. Proper lifetime tracking is a necessary precondition to
> > introduce character device support for PWMs (that implements atomic
> > setting and doesn't suffer from the sysfs overhead of the /sys/class/pwm
> > userspace support).
> >=20
> > The new function pwmchip_priv() (obviously?) only works for chips
> > allocated with devm_pwmchip_alloc().
>=20
> ...
>=20
> > +void *pwmchip_priv(struct pwm_chip *chip)
> > +{
> > +	return (char *)chip + ALIGN(sizeof(*chip), 32);
>=20
> Why 32? I haven't found any explanation on the choice. I can understand a=
rch
> minimum align, but hard coded value is a bit hard to get.

I copied that part from netdev_priv (without introducing the equivalent
of NETDEV_ALIGN). The 32 there isn't motivated in a comment, and i
didn't think much about it. Alternatives that I'm aware of are:

	dma_get_cache_alignment() (spi)
	Use a struct (counter's counter_device_allochelper uses ____cacheline_alig=
ned)

(but I wonder about dma_get_cache_alignment() which might return 1 on
some archs and then doesn't even ensure natural aligning for shorts.)

> > +}
>=20
> ...
>=20
> > +struct pwm_chip *devm_pwmchip_alloc(struct device *parent, size_t size=
of_priv)
> > +{
> > +	struct pwm_chip *chip;
> > +	size_t alloc_size;
>=20
> > +	alloc_size =3D ALIGN(sizeof(*chip), 32) + sizeof_priv;
>=20
> Ditto.

Of course this needs to match the above. spi uses dev_get_drvdata on the
controller's dev. Also a nice idea.

> Shouldn't it use a macro from overflow.h?

Yupp, that would make sense. Something like:

	if (unlikely(check_add_overflow(ALIGN(sizeof(*chip), 32), sizeof_priv, &al=
loc_size)))
		return NULL;

(with 32 replaced by something with a better name.)

Thanks for your feedback,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--c47aihx6qnumjkol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmS3u4QACgkQj4D7WH0S
/k63uwgAgEjte499Qzqkybmbo3Hnvx4gt8KAcSTR4BRd+1YG9y9ENRVfkt4RucR9
WeIHfwn5JrbcxMQkTYrDosWm7QeJXSimuelrpFLgD4blcu3Y0BSTwQEM0L7vfF/5
6bhOQBnrn3BB1f523YSUJi2vIXBxfXk/4dYf/v3Sp9Dt40wXE6z659JLejtLvXvH
MgWQ+hIOE3yY7ZhUi7pGDOUUqlQ2DcbV6kDpRQ+TLkXWIFHBFG3O7Hi/sP2Zi0by
G+zqIGzjRijApdk58ybzrUcarOHgJc3P8KalexRpcNH314ue/C3A9G7iFAQhqpb6
CxZoWE/b482gFpgGyJcv8FH/L75fig==
=iHpb
-----END PGP SIGNATURE-----

--c47aihx6qnumjkol--
