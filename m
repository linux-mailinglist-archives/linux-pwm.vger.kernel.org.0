Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092397BB847
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 14:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjJFMzb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 08:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjJFMz1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 08:55:27 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA66FF
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 05:55:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qokMG-0005Vu-T1; Fri, 06 Oct 2023 14:55:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qokMG-00BWNB-Dz; Fri, 06 Oct 2023 14:55:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qokMG-00AF9A-4M; Fri, 06 Oct 2023 14:55:08 +0200
Date:   Fri, 6 Oct 2023 14:55:07 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] pwm: Change how pwm_chip IDs are determined
Message-ID: <20231006125507.2lilz37hkpj6c2hv@pengutronix.de>
References: <20230808165250.942396-1-u.kleine-koenig@pengutronix.de>
 <20230808165250.942396-2-u.kleine-koenig@pengutronix.de>
 <ZR_pltZCN1fRjfBB@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y6xp5ezmka3pbn7e"
Content-Disposition: inline
In-Reply-To: <ZR_pltZCN1fRjfBB@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--y6xp5ezmka3pbn7e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Oct 06, 2023 at 01:03:50PM +0200, Thierry Reding wrote:
> On Tue, Aug 08, 2023 at 06:52:49PM +0200, Uwe Kleine-K=F6nig wrote:
> > Traditionally each PWM device had a unique ID stored in the "pwm" member
> > of struct pwm_device. However this number was hardly used and dropped in
> > the previous commit. Further the unique ID of a PWM chip matched the ID
> > of the first contained PWM device.
>=20
> This is slightly confusing. The PWM chip "base" was never supposed to be
> an ID and its usage in sysfs was more of an accident than actual
> purpose. The primary purpose of it was to serve as the base number of
> pins in the global number space, but with that number space gone, there
> is no use for the base number anymore.
>=20
> So I think changing the subject to something like this would be better:
>=20
> 	pwm: Replace PWM chip unique base by unique ID

Agreed.

> > With the PWM device ID gone PWM chips can get their IDs better and
> > simpler using an idr.
> >=20
> > This is expected to change the numbering of PWM chips, but nothing
> > should rely on the numbering anyhow.
> >=20
> > Other than that the side effects are:
> >=20
> >  - The PWM chip IDs are smaller and in most cases consecutive.
> >  - The ordering in /sys/kernel/debug/pwm is ordered by ascending PWM
> >    chip ID.
> >=20
> > Also use "id" as name for the PWM chip ID which better matches the new
> > semantic of that number.
> >=20
> > For the plan to introduce support for pwmchip character devices this
> > also simplifies getting the struct pwm_chip matching a given PWM chip ID
> > (or character device).
>=20
> Again, it would be interesting to see how this would work in practice.
> As things are this is pure speculation, so I'd leave out this comment.

That's just that you can lookup by ID in an idr, while you have to
iterate through a linked list otherwise. If you want drop the last
paragraph?!

> > [...]
> > -static void free_pwms(struct pwm_chip *chip)
> > -{
> > -	bitmap_clear(allocated_pwms, chip->base, chip->npwm);
> > -
> > -	kfree(chip->pwms);
> > -	chip->pwms =3D NULL;
> > -}
> > +DEFINE_IDR(pwmchip_idr);
>=20
> static?

Agreed.

> I would probably have kept the same pwm_chips as well. We already know
> that this is an IDR given the type, so no need to repeat that.

You mean:

	static DEFINE_IDR(pwm_chips);

? I don't care much. I probably copied that from spi. A quick grep shows
_idr being quite typical:

	$ git grep DEFINE_IDR v6.6-rc1 | perl -n -e 'print if s/.*DEFINE_IDR\s*\(.=
*(_.*)\).*/\1/' | sort | uniq -c      1 _devices
	      4 _id
	     53 _idr
	      2 _index
	      1 _INIT(name
	      1 _list
	      3 _minors
	      1 _protocols
	      1 _stats

But if you prefer pwm_chips and take the patch then, I won't oppose.

> > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > index d2f9f690a9c1..09da803bbd46 100644
> > --- a/include/linux/pwm.h
> > +++ b/include/linux/pwm.h
> > @@ -295,7 +295,7 @@ struct pwm_ops {
> >  struct pwm_chip {
> >  	struct device *dev;
> >  	const struct pwm_ops *ops;
> > -	int base;
> > +	int id;
>=20
> Why not make this unsigned long while we're at it? Looks like that's the
> native type for IDRs and we already make sure that whatever is stored in
> here isn't going to be negative.

Agreed.

> All of the above are minor changes, so I can fix them up as I apply the
> patch, if you don't have any objections.

That's fine for me.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--y6xp5ezmka3pbn7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUgA6sACgkQj4D7WH0S
/k43kwf9ENevAHjOGWdKZNM1GJplizzSgQ9TdHTbBYpvhUWs8Jh3abHXAlW2xnBi
0DfiXhwVJqdlCuft83gLOsSjOXVcF/l0yXi3hvvefEHTMpC1DfN6SA+53eMuEPfg
93TxYorCiGv7HZ0wgy4SSQ+omGM+1bKRNasQSR8eEPPhl5PO14g8V5koHw3wPLMr
eh302aGBoCB1Ah8he695ODWpkWEumvRk4eTRjjWeU5r4PGC4ONQrkmsWOFu/LiKe
aPbJkPilc0K4//DfyWla2/0zEjTFFydgI7aamKMM1FrUpFu9LOqVtq+TbHbC3nlT
HaxaBSZbTJc/w+ghbwQp2LLJrWaVqw==
=OreJ
-----END PGP SIGNATURE-----

--y6xp5ezmka3pbn7e--
