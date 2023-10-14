Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B8A7C9552
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Oct 2023 18:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjJNQRa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 14 Oct 2023 12:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjJNQR3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 14 Oct 2023 12:17:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2BCA2
        for <linux-pwm@vger.kernel.org>; Sat, 14 Oct 2023 09:17:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrhKP-0006TD-Pg; Sat, 14 Oct 2023 18:17:25 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrhKN-001f0g-6l; Sat, 14 Oct 2023 18:17:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrhKM-00GJMK-TG; Sat, 14 Oct 2023 18:17:22 +0200
Date:   Sat, 14 Oct 2023 18:17:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Saravana Kannan <saravanak@google.com>
Cc:     linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Wolfram Sang <wsa@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        James Clark <james.clark@arm.com>, kernel@pengutronix.de,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 01/18] pwm: Provide devm_pwmchip_alloc() function
Message-ID: <20231014161721.f4iqyroddkcyoefo@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
 <20230718181849.3947851-2-u.kleine-koenig@pengutronix.de>
 <ZLeX4UbFaY592HIa@orome>
 <20230725211004.peqxxb4y3j62gmnp@pengutronix.de>
 <20231010080508.7ssnroaefyaeeedd@pengutronix.de>
 <CAGETcx8CNGLnHdWrDpdm4Sx5cFcFFBT2bZKJzNZttAEknFK4Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="56mmcz5vtc7432bh"
Content-Disposition: inline
In-Reply-To: <CAGETcx8CNGLnHdWrDpdm4Sx5cFcFFBT2bZKJzNZttAEknFK4Cw@mail.gmail.com>
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


--56mmcz5vtc7432bh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 02:42:20PM -0700, Saravana Kannan wrote:
> On Tue, Oct 10, 2023 at 1:05=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Hello Saravana,
> >
> > you were pointed out to me as the expert for device links. I found a
> > problem with these.
> >
> > On Tue, Jul 25, 2023 at 11:10:04PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > Today I managed to trigger the problem I intend to address with this
> > > series. My machine to test this on is an stm32mp157. To be able to
> > > trigger the problem reliably I applied the following patches on top of
> > > v6.5-rc1:
> > >
> > >  - pwm: stm32: Don't modify HW state in .remove() callback
> > >    This is a cleanup that I already sent out.
> > >    https://lore.kernel.org/r/20230713155142.2454010-2-u.kleine-koenig=
@pengutronix.de
> > >    The purpose for reproducing the problem is to not trigger further
> > >    calls to the apply callback.
> > >
> > >  - The following patch:
> > >
> > > diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> > > index 687967d3265f..c7fc02b0fa3c 100644
> > > --- a/drivers/pwm/pwm-stm32.c
> > > +++ b/drivers/pwm/pwm-stm32.c
> > > @@ -451,6 +451,10 @@ static int stm32_pwm_apply(struct pwm_chip *chip=
, struct pwm_device *pwm,
> > >       struct stm32_pwm *priv =3D to_stm32_pwm_dev(chip);
> > >       int ret;
> > >
> > > +     dev_info(chip->dev, "%s:%d\n", __func__, __LINE__);
> > > +     msleep(5000);
> > > +     dev_info(chip->dev, "%s:%d\n", __func__, __LINE__);
> > > +
> > >       enabled =3D pwm->state.enabled;
> > >
> > >       if (enabled && !state->enabled) {
> > > @@ -650,7 +654,11 @@ static void stm32_pwm_remove(struct platform_dev=
ice *pdev)
> > >  {
> > >       struct stm32_pwm *priv =3D platform_get_drvdata(pdev);
> > >
> > > +     dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
> > >       pwmchip_remove(&priv->chip);
> > > +     dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
> > > +
> > > +     priv->regmap =3D NULL;
> > >  }
> > >
> > >  static int __maybe_unused stm32_pwm_suspend(struct device *dev)
> > >
> > > The first hunk is only there to widen the race window. The second is =
to
> > > give some diagnostics and make stm32_pwm_apply() crash if it continues
> > > to run after the msleep. (Without it it didn't crash reproducibly, do=
n't
> > > understand why. *shrug*)
> > >
> > > The device tree contains a pwm-fan device making use of one of the PW=
Ms.
> > >
> > > Now I do the following:
> > >
> > >       echo fan > /sys/bus/platform/drivers/pwm-fan/unbind & sleep 1; =
echo 40007000.timer:pwm > /sys/bus/platform/drivers/stm32-pwm/unbind
> > >
> > > Unbinding the fan device has two effects:
> > >
> > >  - The device link between fan and pwm looses its property to unbind =
fan
> > >    when pwm gets unbound.
> > >    (Its .status changes from DL_STATE_ACTIVE to DL_STATE_AVAILABLE)
> > >  - It calls pwm_fan_cleanup() which triggers a call to
> > >    pwm_apply_state().
> > >
> > > So when the pwm device gets unbound the first thread is sleeping in
> > > stm32_pwm_apply(). The driver calls pwmchip_remove() and sets
> > > priv->regmap to NULL. Then a few seconds later the first thread wakes=
 up
> > > in stm32_pwm_apply() with the chip freed and priv->regmap =3D NULL. B=
ang!
> > >
> > > This looks as follows:
> > >
> > > root@crown:~# echo fan > /sys/bus/platform/drivers/pwm-fan/unbind & s=
leep 1; echo 40007000.timer:pwm > /sys/bus/platform/drivers/stm32-pwm/unbind
> > > [  187.182113] stm32-pwm 40007000.timer:pwm: stm32_pwm_apply:454
> > > [  188.164769] stm32-pwm 40007000.timer:pwm: stm32_pwm_remove:657
> > > [  188.184555] stm32-pwm 40007000.timer:pwm: stm32_pwm_remove:659
> > > root@crown:~# [  192.236423] platform 40007000.timer:pwm: stm32_pwm_a=
pply:456
> > > [  192.240727] 8<--- cut here ---
> > > [  192.243759] Unable to handle kernel NULL pointer dereference at vi=
rtual address 0000001c when read
> > > ...
> > >
> > > Even without the crash you can see that stm32_pwm_apply() is still
> > > running after pwmchip_remove() completed.
> > >
> > > I'm unsure if the device link could be improved here to ensure that t=
he
> > > fan is completely unbound even if it started unbinding already before
> > > the pwm device gets unbound. (And if it could, would this fit the dev=
ice
> > > links purpose and so be a sensible improvement?)
> >
> > While I think that there is something to be done in the pwm core that
> > this doesn't explode (i.e. do proper lifetime tracking such that a
> > pwm_chip doesn't disappear while still being used---and I'm working on
> > that) I expected that the device links between pwm consumer and provider
> > would prevent the above described oops, too. But somehow the fan already
> > going away (but still using the PWM) when the PWM is unbound, results in
> > the PWM disappearing before the fan is completely gone.
> >
> > Is this expected, or a problem that can (and should?) be fixed?
>=20
> I didn't read your full series, but I read this email. With what's in
> this email, the problem seems to be in the driver or the pwm
> framework. The pwm driver/framework can't tell the driver core that
> you successfully unbound (returning from .remove()) before you have
> finish all your ongoing transactions with the device. If your
> "apply()" is still running, you need to make sure it's complete before
> .remove() does any resource releasing/clean up.
>=20
> Also, how is the consumer driver's .remove() succeeding if it has an
> ongoing pwm call()?

The thing that works fine and as expected is:

 - trigger unbind of PWM device via sysfs

Because there is a device link PWM provider -> pwm consumer (fan), the
fan is removed and once its gone (and not earlier), the PWM gets unbound.

The failing sequence is:

 - trigger unbind of fan device in userspace thread A via sysfs. The
   fan's remove callback blocks for 5s in pwm_apply_state() and so
   .remove() doesn't complete yet.

 - a second later: trigger unbind of PWM device via sysfs in thread B.
   As before I'd expect that the device link results in waiting for the
   fan to be removed completely, but the PWM is removed immediately.

 - pwm_apply_state's sleep completes (in thread B) and operates on freed
   resources =3D> bang!

> This all sounds like insufficient locking and
> critical region protection in both the consumer and supplier.

My (and I think also Thierry's) expectation was, that the device link
provides the needed synchronisation. But it doesn't as it doesn't block
the PWM provider going away until the fan is completely gone.

> Device links can't do anything here because you are giving it wrong
> info -- that the unbind was successful before it actually is.

The fan's unbind is ongoing, but not complete yet and I'd expect that
the device link blocks unbinding the PWM until the fan is completely
gone. So I think there is no wrong information.

> Device links will and can make sure that the consumer is unbound
> successfully before the unbind is called on the supplier. And it looks
> like that's still true here.

I hope you understood the situation better now and see the problem we
have.

The problem is fixable in the pwm framework (and I'm working on that),
but I think there is also something to improve around devicelink
handling.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--56mmcz5vtc7432bh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUqvxAACgkQj4D7WH0S
/k6APgf/XzNWco1nZBdD6GZf46Y8QAk5WhDNtaTcX6PONOjKeZW3qmiyaoHPIuZA
x7zNN9F5j20txPoQwSIM6rsI4r8ZUbRqKRJFOzvtZgSsDL/LUHXYH7WvJBUDEuem
k8VHzw7NHAXhVYsGn8CFNR657PzANV2Rq5ttuHMI8FGLd/5/UmlUA7jG9RwDcPB7
eYODY/pRMUkom8PIxXC43DE2i53iOV6vQSBFFEjegSEocdMuVZYpTqp8f3SgbVyM
t0Z+iNUMoEHhF9oRWwP+XfCgCxHUaqrTGc4aoGYLM2Hf2ewtDe7XRFUad8Qj7pzZ
vsKLiu8G/EOQmRt3hTenqUXA4ErZOw==
=mlq/
-----END PGP SIGNATURE-----

--56mmcz5vtc7432bh--
