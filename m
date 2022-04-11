Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B144FB888
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Apr 2022 11:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344770AbiDKJyb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Apr 2022 05:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344908AbiDKJwR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Apr 2022 05:52:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C544E3CA70
        for <linux-pwm@vger.kernel.org>; Mon, 11 Apr 2022 02:49:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6063760DD4
        for <linux-pwm@vger.kernel.org>; Mon, 11 Apr 2022 09:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3B5C385A4;
        Mon, 11 Apr 2022 09:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670593;
        bh=HxQyupQVbUT1wMb+7QkCEhG41GvtEjdzH8+zfey9Uhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f86/hSXI5mP40YWFYD9fDqvcCPsrifXBqj/DiJfXrNEiWAMT+KJPxX+sriedSI+p5
         nw5fjOabOax34kl/+jwFCdF2HDMLegPyj1lCuiVhYImcCBCBnL/SIvIe8FvdLDtNB1
         NXp5LvG/Ltr0ZoWz81tNPLJMD+tBu5mu3oXF0En/y5l9SnZh5ygLTRMsFbynAhbeeL
         Zh3cuVaDJuuY4h+NoEnawVQMt6TqFisI9ZRFN614GC4Zaev703x+Gxw/M6R3ZmHgFS
         8ZBp1p/wGSZF5sEC0OEKrqOy0FbMb9MeUSLol+deD+9nNXjuwgodsBqZ0Fo2UBf7nE
         xN0KPYugWC0gQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ndqg7-0003ei-1Y; Mon, 11 Apr 2022 11:49:47 +0200
Date:   Mon, 11 Apr 2022 11:49:47 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Drop assignment to struct
 pwm_chip::base
Message-ID: <YlP5u0+u7zlJSJxW@hovoldconsulting.com>
References: <20220411083118.200663-1-u.kleine-koenig@pengutronix.de>
 <YlPxIWfaFoQxW63Z@hovoldconsulting.com>
 <20220411094828.p3bjyioocuzhvqs7@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Fj993QbPu9hDgNXl"
Content-Disposition: inline
In-Reply-To: <20220411094828.p3bjyioocuzhvqs7@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Fj993QbPu9hDgNXl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2022 at 11:48:28AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Apr 11, 2022 at 11:13:05AM +0200, Johan Hovold wrote:
> > On Mon, Apr 11, 2022 at 10:31:18AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > Since commit f9a8ee8c8bcd ("pwm: Always allocate PWM chip base ID
> > > dynamically") the value held in base isn't used any more in the PWM
> > > framework. All PMWs get assigned a dynamic ID, so the assignment is
> > > redundant and can be dropped.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/staging/greybus/pwm.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >=20
> > > diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/=
pwm.c
> > > index ad20ec24031e..3fda172239d2 100644
> > > --- a/drivers/staging/greybus/pwm.c
> > > +++ b/drivers/staging/greybus/pwm.c
> > > @@ -297,7 +297,6 @@ static int gb_pwm_probe(struct gbphy_device *gbph=
y_dev,
> > > =20
> > >  	pwm->dev =3D &gbphy_dev->dev;
> > >  	pwm->ops =3D &gb_pwm_ops;
> > > -	pwm->base =3D -1;			/* Allocate base dynamically */
> > >  	pwm->npwm =3D pwmc->pwm_max + 1;
> > > =20
> > >  	ret =3D pwmchip_add(pwm);
> > >=20
> > > base-commit: 3123109284176b1532874591f7c81f3837bbdc17
> >=20
> > I'd prefer if you added a "pwm: " module prefix to the summary (even if
> > the previous patch to this driver didn't have that).
> >=20
> > Looks good to me otherwise:
> >=20
> > Reviewed-by: Johan Hovold <johan@kernel.org>
>=20
> Am I supposed to resend with the changed subject? Who will pick this up?

Please do. Greg will pick it up. Thanks.

Johan

--Fj993QbPu9hDgNXl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCYlP5tgAKCRALxc3C7H1l
CFGaAP47zksuZIKY6wzZOLp845c4JAIbSwiqx5Im2+8q0UCOCwD8C7l57Ddqi864
PKeawbayXPwlyvGu2po4hzsrtD0A+A8=
=GQdn
-----END PGP SIGNATURE-----

--Fj993QbPu9hDgNXl--
