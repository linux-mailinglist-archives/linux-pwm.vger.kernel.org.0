Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB30552BC9
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jun 2022 09:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346999AbiFUHXV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 21 Jun 2022 03:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345935AbiFUHXE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 21 Jun 2022 03:23:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A9BBE17
        for <linux-pwm@vger.kernel.org>; Tue, 21 Jun 2022 00:23:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3YDn-0008AI-Jt; Tue, 21 Jun 2022 09:22:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3YDk-001n8U-4Z; Tue, 21 Jun 2022 09:22:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3YDk-0009s5-Qt; Tue, 21 Jun 2022 09:22:44 +0200
Date:   Tue, 21 Jun 2022 09:22:44 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH v4 6/6] hwmon: pwm-fan: Remove internal duplicated
 pwm_state
Message-ID: <20220621072244.72j6n2inwut36wsx@pengutronix.de>
References: <20220523110513.407516-1-alexander.stein@ew.tq-group.com>
 <4715301.GXAFRqVoOG@steina-w>
 <aa6f8c6c-6d8f-6d23-f035-00d27e7ec0af@roeck-us.net>
 <13043200.uLZWGnKmhe@steina-w>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5zfdheq5nefi6ciq"
Content-Disposition: inline
In-Reply-To: <13043200.uLZWGnKmhe@steina-w>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5zfdheq5nefi6ciq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Alexander,

On Tue, Jun 21, 2022 at 08:41:37AM +0200, Alexander Stein wrote:
> Am Montag, 23. Mai 2022, 16:18:57 CEST schrieb Guenter Roeck:
> > On 5/23/22 06:55, Alexander Stein wrote:
> > > Hi Uwe,
> > >=20
> > > Am Montag, 23. Mai 2022, 14:46:14 CEST schrieb Uwe Kleine-K=F6nig:
> > >> * PGP Signed by an unknown key
> > >>=20
> > >> Hello,
> > >>=20
> > >> On Mon, May 23, 2022 at 01:05:13PM +0200, Alexander Stein wrote:
> > >>> Each pwm device has already a pwm_state. Use this one instead of
> > >>> managing an own copy of it.
> > >>>=20
> > >>> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > >>> ---
> > >>>=20
> > >>>   drivers/hwmon/pwm-fan.c | 49 +++++++++++++++++++++++++-----------=
-----
> > >>>   1 file changed, 30 insertions(+), 19 deletions(-)
> > >>>=20
> > >>> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> > >>> index e5d4b3b1cc49..e0ce81cdf5e0 100644
> > >>> --- a/drivers/hwmon/pwm-fan.c
> > >>> +++ b/drivers/hwmon/pwm-fan.c
> > >>> @@ -40,7 +40,6 @@ struct pwm_fan_ctx {
> > >>>=20
> > >>>   	struct mutex lock;
> > >>>   	struct pwm_device *pwm;
> > >>>=20
> > >>> -	struct pwm_state pwm_state;
> > >>>=20
> > >>>   	struct regulator *reg_en;
> > >>>   	enum pwm_fan_enable_mode enable_mode;
> > >>>   	bool regulator_enabled;
> > >>>=20
> > >>> @@ -142,7 +141,7 @@ static int pwm_fan_switch_power(struct pwm_fan_=
ctx
> > >>> *ctx, bool on)>
> > >>>=20
> > >>>   static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
> > >>>   {
> > >>>=20
> > >>> -	struct pwm_state *state =3D &ctx->pwm_state;
> > >>> +	struct pwm_state state;
> > >>>=20
> > >>>   	int ret;
> > >>>   =09
> > >>>   	if (ctx->enabled)
> > >>>=20
> > >>> @@ -154,8 +153,9 @@ static int pwm_fan_power_on(struct pwm_fan_ctx =
*ctx)
> > >>>=20
> > >>>   		return ret;
> > >>>   =09
> > >>>   	}
> > >>>=20
> > >>> -	state->enabled =3D true;
> > >>> -	ret =3D pwm_apply_state(ctx->pwm, state);
> > >>> +	pwm_get_state(ctx->pwm, &state);
> > >>> +	state.enabled =3D true;
> > >>> +	ret =3D pwm_apply_state(ctx->pwm, &state);
> > >>>=20
> > >>>   	if (ret) {
> > >>>   =09
> > >>>   		dev_err(ctx->dev, "failed to enable PWM\n");
> > >>>   		goto disable_regulator;
> > >>=20
> > >> IMHO this isn't a net win. You trade the overhead of pwm_get_state
> > >> against some memory savings. I personally am not a big fan of the
> > >> get_state + modify + apply codeflow. The PWM framework does internal
> > >> caching of the last applied state, but the details are a bit ugly. (=
i.e.
> > >> pwm_get_state returns the last applied state, unless there was no st=
ate
> > >> applied before. In that case it returns what .get_state returned dur=
ing
> > >> request time, unless there is no .get_state callback ... not sure if=
 the
> > >> device tree stuff somehow goes into that, didn't find it on a quick
> > >> glance)
> > >>=20
> > >> Also there is a (small) danger, that pwm_state contains something th=
at
> > >> isn't intended by the driver, e.g. a wrong polarity. So I like the
> > >> consumer to fully specify what they intend and not use pwm_get_state=
().
> > >=20
> > > Ah, I see. I have no hard feelings for this patch. I just wondered wh=
y the
> > > PWM state is duplicated. and wanted to get rid of it. If there is a
> > > specific reason for this, I'm ok with that.
> >=20
> > I don't see the value of continuous runtime overhead to save a few byte=
s of
> > data, so I don't see a reason to _not_ cache the state locally. This is
> > similar to caching a clock frequency locally instead of calling the clo=
ck
> > subsystem again and again to read it. Sure, nowadays CPUs are more powe=
rful
> > than they used to be, but I don't see that as reason or argument for
> > wasting their power.
>=20
> Ok, seems reasonable. I'm fully fine with patch 6 being dropped. What abo=
ut=20
> the other patches?

+1 for dropping patch #6. Otherwise (with my PWM expert hat on) I have
no further criticism. But I didn't look deep enough into the patches for
an Ack, I guess I'm also missing some hwmon foo to objectively review
further.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5zfdheq5nefi6ciq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKxccEACgkQwfwUeK3K
7Am81gf6AxG0Wo4euPb4Zw0l9QoKNpyeSuLr7O18W93hCyMKWSk9y6dt6d7L4NSk
GX7zH2SI/DHk3/KzsmgqH0pSorhYL/BdoTdky6GAnZFzW87O9C+R9sBP7rBC/OPN
9ufkBov0ou9RmMbbyapxN2oMrmYgU1Gg7SHNOX7flXR3mD4ngMmvN6wFANstqdEu
iIqS98cqQpCGPlJRE0jlIqlDNzSQjR0VqynmCzU5X7YtdiDdpcRMQZqewglFuF6f
9cu9Da0h9dwGUVk2reCenokrlg3Ab/SLBdYoCl06oc6ztN4a3G43SGxMdQAMQqsM
9OFifYrNJ9JkCF5l9YOGsZp8KD/TOA==
=y0Bg
-----END PGP SIGNATURE-----

--5zfdheq5nefi6ciq--
