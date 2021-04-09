Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE6335A87D
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 23:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbhDIVwb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 17:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbhDIVwb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 17:52:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8B8C061763
        for <linux-pwm@vger.kernel.org>; Fri,  9 Apr 2021 14:52:17 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lUz2v-0004d4-Kq; Fri, 09 Apr 2021 23:52:09 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lUz2u-00032A-1f; Fri, 09 Apr 2021 23:52:08 +0200
Date:   Fri, 9 Apr 2021 23:52:07 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rex-BC Chen <rex-bc.chen@mediatek.com>, lee.jones@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: Re: [v3,PATCH 3/3] pwm: mtk_disp: implement .get_state()
Message-ID: <20210409215207.uuyc42mddq4jify5@pengutronix.de>
References: <1617703062-4251-1-git-send-email-rex-bc.chen@mediatek.com>
 <1617703062-4251-4-git-send-email-rex-bc.chen@mediatek.com>
 <20210406102756.4kncasxe4um3q6wi@pengutronix.de>
 <YHBHizYI7oyULZx9@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4syjqtkokaojouyy"
Content-Disposition: inline
In-Reply-To: <YHBHizYI7oyULZx9@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--4syjqtkokaojouyy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 09, 2021 at 02:24:43PM +0200, Thierry Reding wrote:
> On Tue, Apr 06, 2021 at 12:27:56PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Apr 06, 2021 at 05:57:42PM +0800, Rex-BC Chen wrote:
> > > implement get_state function for pwm-mtk-disp
> > >=20
> > > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> >=20
> > Ideally you S-o-b line is the last one to show the order in which this
> > patch went from one person to another.
> >=20
> > > ---
> > >  drivers/pwm/pwm-mtk-disp.c | 46 ++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 46 insertions(+)
> > >=20
> > > diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> > > index 502228adf718..166e0a8ca703 100644
> > > --- a/drivers/pwm/pwm-mtk-disp.c
> > > +++ b/drivers/pwm/pwm-mtk-disp.c
> > > @@ -179,8 +179,54 @@ static int mtk_disp_pwm_apply(struct pwm_chip *c=
hip, struct pwm_device *pwm,
> > >  	return mtk_disp_pwm_enable(chip, state);
> > >  }
> > > =20
> > > +static void mtk_disp_pwm_get_state(struct pwm_chip *chip,
> > > +				   struct pwm_device *pwm,
> > > +				   struct pwm_state *state)
> > > +{
> > > +	struct mtk_disp_pwm *mdp =3D to_mtk_disp_pwm(chip);
> > > +	u32 clk_div, period, high_width, con0, con1;
> > > +	u64 rate;
> > > +	int err;
> > > +
> > > +	err =3D clk_prepare_enable(mdp->clk_main);
> > > +	if (err < 0) {
> > > +		dev_err(chip->dev, "Can't enable mdp->clk_main: %d\n", err);
> > > +		return;
> > > +	}
> > > +	err =3D clk_prepare_enable(mdp->clk_mm);
> > > +	if (err < 0) {
> > > +		dev_err(chip->dev, "Can't enable mdp->clk_mm: %d\n", err);
> > > +		clk_disable_unprepare(mdp->clk_main);
> >=20
> > As before: %pe please
>=20
> According to the documentation %pe only works on pointers for which
> IS_ERR() is true, so I'm not sure it can be used with plain integer
> error codes.

It cannot.

> Looks like there's a bunch of drivers that will do %pe and then use
> ERR_PTR(err) to make this work, but to be honest, that seems like
> jumping through hoops.

When I suggested to implement %dE to print error codes this was shot
down by the printk guys who's position is that %pe has to be good enough
for everybody. And yes, you'd need to pass ERR_PTR(err) then.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4syjqtkokaojouyy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBwzIUACgkQwfwUeK3K
7AnyxggAigDNiQqZ8bPoBuYlWlAd+v2Wmp/BYm14Mz2GqZMFbn+qKWFm2KnZFRmD
ifcWkjMCgmIv6nbf++kbBndEiYkmWBN/9b5F3MGmbuZSXzL+9XzW0UCRaf14kcei
oGoMmbU/mR3mwKo1p10KmP17aIgYgCu57MLcMGdFgryR0VVLAi0Lp+zICVtqisfs
HxkN1k81u5Vqhn7jnfNUfIFr+b/wWYykqD1QLsPNlNv74lDgmgF1ixPEkH321OMm
bAxbX9wdsr5n0fLs6/cVHnq8WdKHzqwWrMch02ysWWZ8gdpqGx4zULu1lbewSBN9
Cve9wbJwhlGWV1I2BIOvZN/4vzoY8A==
=YjFc
-----END PGP SIGNATURE-----

--4syjqtkokaojouyy--
