Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF01743550
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jun 2023 08:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjF3GvD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Jun 2023 02:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjF3Gu5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Jun 2023 02:50:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813071FDF
        for <linux-pwm@vger.kernel.org>; Thu, 29 Jun 2023 23:50:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qF7y0-0001eE-3I; Fri, 30 Jun 2023 08:50:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qF7xy-00B4JK-Sz; Fri, 30 Jun 2023 08:50:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qF7xy-000ymU-4Q; Fri, 30 Jun 2023 08:50:50 +0200
Date:   Fri, 30 Jun 2023 08:50:49 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     linux-pwm@vger.kernel.org, chrome-platform@lists.linux.dev,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH 7/8] pwm: cros-ec: Put per channel data into driver data
Message-ID: <20230630065049.fj5rehmzemydp5bv@pengutronix.de>
References: <20230629094839.757092-1-u.kleine-koenig@pengutronix.de>
 <20230629094839.757092-8-u.kleine-koenig@pengutronix.de>
 <ZJ5gDWlm38qYguyH@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hdfsmmj2bbmdegt2"
Content-Disposition: inline
In-Reply-To: <ZJ5gDWlm38qYguyH@google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--hdfsmmj2bbmdegt2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2023 at 12:54:37PM +0800, Tzung-Bi Shih wrote:
> On Thu, Jun 29, 2023 at 11:48:38AM +0200, Uwe Kleine-K=F6nig wrote:
> > Instead of an allocation of a single u16 per channel, allocate them all
> > in a single chunk which greatly reduces memory fragmentation and also
> > the overhead to track the allocated memory. Also put the channel data in
> > driver data where it's cheaper to determine the address (no function
> > call involved, just a trivial pointer addition).
> >=20
> > This also allows to get rid of the request and free callbacks.
> >=20
> > The only cost is that the channel data is allocated early, and even for
> > unused channels.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> With comments addressed below:
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
>=20
> > @@ -27,6 +27,7 @@ struct cros_ec_pwm_device {
> >  	struct cros_ec_device *ec;
> >  	struct pwm_chip chip;
> >  	bool use_pwm_type;
> > +	struct cros_ec_pwm *channel;
>=20
> Please update the kernel-doc too.  Otherwise:
> $ ./scripts/kernel-doc -none drivers/pwm/pwm-cros-ec.c
> drivers/pwm/pwm-cros-ec.c:31: warning: Function parameter or member 'chan=
nel'
> not described in 'cros_ec_pwm_device'
>=20
> I have no strong preference: please consider to use `channels` if it makes
> sense.

Thanks for your feedback. Regarding your suggestion about channel vs
channels: While I don't have a strong preference either you have to
choose between

	struct cros_ec_pwm *channel;

which is singular but for all channels, or you have

	ec_pwm->channesl[pwm->hwpwm]

which is plural but for only a single channel. So no matter how you do
it, it's strange at one place or the other.

While looking at the patch again I changed to

	ec_pwm->channel =3D devm_kcalloc(dev, chip->npwm, sizeof(*ec_pwm->channel)=
, GFP_KERNEL)

(from devm_kzalloc with size chip->npwm * sizeof(*ec_pwm->channel)).

So in my tree I have the following change on top of the submission which
I will send out as a v2 soon:

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 2998153a5e92..63c64c4dbf90 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -21,6 +21,7 @@
  * @ec: Pointer to EC device
  * @chip: PWM controller chip
  * @use_pwm_type: Use PWM types instead of generic channels
+ * @channel: array with per-channel data
  */
 struct cros_ec_pwm_device {
 	struct device *dev;
@@ -295,7 +296,8 @@ static int cros_ec_pwm_probe(struct platform_device *pd=
ev)
 		chip->npwm =3D ret;
 	}
=20
-	ec_pwm->channel =3D devm_kzalloc(dev, chip->npwm * sizeof(*ec_pwm->channe=
l), GFP_KERNEL);
+	ec_pwm->channel =3D devm_kcalloc(dev, chip->npwm, sizeof(*ec_pwm->channel=
),
+					GFP_KERNEL);
 	if (!ec_pwm->channel)
 		return -ENOMEM;
=20

I assume that also with this change it's ok to add your Reviewed-by tag.
If you don't agree, please let me know.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hdfsmmj2bbmdegt2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSee0kACgkQj4D7WH0S
/k4L2AgArI/OR1Pw6klWCM5lCs3er3SklxiTg5RwJB1Kn6J9r7PUApcJ6lOYmhGX
3Ob5cVv0heqKunpqP78A8af+AhjBMEacNtlERQSZMRdLlDqFuS9HL9cjFknNbfL6
tQgIU/q92YRlbVSTV/10QiRItA11VQ9J0fs6FD7EiqQY8T0kR+eJkfc3fJlNWsd2
1m/l+9bzabJl9TKBBl7EmW9fzU92YQgAfcf8swgEhG+/P5letyeBBBpNGA4wSPgY
P5KM94BDmoqX5jQ9v7VuU42pQLz8ZDY2itMYYoZszVnzawbqampeLTiQ/nDyOyy4
X21L5tkcqsgF6Ti7bUV1Nrn4SpzjRg==
=Spqc
-----END PGP SIGNATURE-----

--hdfsmmj2bbmdegt2--
