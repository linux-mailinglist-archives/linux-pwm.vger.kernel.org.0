Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077387CE9EA
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Oct 2023 23:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjJRVVI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Oct 2023 17:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjJRVVH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Oct 2023 17:21:07 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE2D9B
        for <linux-pwm@vger.kernel.org>; Wed, 18 Oct 2023 14:21:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtDyR-0001u1-2v; Wed, 18 Oct 2023 23:21:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtDyM-002dxC-Vs; Wed, 18 Oct 2023 23:20:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtDyM-001Fzy-Lr; Wed, 18 Oct 2023 23:20:58 +0200
Date:   Wed, 18 Oct 2023 23:20:54 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Saravana Kannan <saravanak@google.com>
Cc:     linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Wolfram Sang <wsa@kernel.org>, Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        James Clark <james.clark@arm.com>, kernel@pengutronix.de,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Android Kernel Team <kernel-team@android.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 01/18] pwm: Provide devm_pwmchip_alloc() function
Message-ID: <20231018212054.cjwhjx4fevip2kjt@pengutronix.de>
References: <20230718181849.3947851-2-u.kleine-koenig@pengutronix.de>
 <ZLeX4UbFaY592HIa@orome>
 <20230725211004.peqxxb4y3j62gmnp@pengutronix.de>
 <20231010080508.7ssnroaefyaeeedd@pengutronix.de>
 <CAGETcx8CNGLnHdWrDpdm4Sx5cFcFFBT2bZKJzNZttAEknFK4Cw@mail.gmail.com>
 <20231014161721.f4iqyroddkcyoefo@pengutronix.de>
 <CAGETcx-T33-TWmfXxT1dqTt7gWi8E1Z+EXhjpFfdFtpa7h+pQQ@mail.gmail.com>
 <CAGETcx9Ps5gaMZZk7o6NvrdVte8P=jQeedJw-Ae1NZroo9z-NA@mail.gmail.com>
 <20231018111747.alk3lkw7v7gl632k@pengutronix.de>
 <CAGETcx9+-MkF9kKoP_LxwtLYVEmzDS8twASrMPo1=0XpHw0OxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uppqargxs3l4hzpm"
Content-Disposition: inline
In-Reply-To: <CAGETcx9+-MkF9kKoP_LxwtLYVEmzDS8twASrMPo1=0XpHw0OxA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--uppqargxs3l4hzpm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 02:01:30PM -0700, Saravana Kannan wrote:
> On Wed, Oct 18, 2023 at 4:17=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > On Tue, Oct 17, 2023 at 06:42:40PM -0700, Saravana Kannan wrote:
> > > On Tue, Oct 17, 2023 at 4:35=E2=80=AFPM Saravana Kannan <saravanak@go=
ogle.com> wrote:
> > > >
> > > > On Sat, Oct 14, 2023 at 9:17=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > >
> > > > > On Fri, Oct 13, 2023 at 02:42:20PM -0700, Saravana Kannan wrote:
> > > > > > On Tue, Oct 10, 2023 at 1:05=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > > > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > > >
> > > > > > > Hello Saravana,
> > > > > > >
> > > > > > > you were pointed out to me as the expert for device links. I =
found a
> > > > > > > problem with these.
> > > > > > >
> > > > > > > On Tue, Jul 25, 2023 at 11:10:04PM +0200, Uwe Kleine-K=C3=B6n=
ig wrote:
> > > > > > > > Today I managed to trigger the problem I intend to address =
with this
> > > > > > > > series. My machine to test this on is an stm32mp157. To be =
able to
> > > > > > > > trigger the problem reliably I applied the following patche=
s on top of
> > > > > > > > v6.5-rc1:
> > > > > > > >
> > > > > > > >  - pwm: stm32: Don't modify HW state in .remove() callback
> > > > > > > >    This is a cleanup that I already sent out.
> > > > > > > >    https://lore.kernel.org/r/20230713155142.2454010-2-u.kle=
ine-koenig@pengutronix.de
> > > > > > > >    The purpose for reproducing the problem is to not trigge=
r further
> > > > > > > >    calls to the apply callback.
> > > > > > > >
> > > > > > > >  - The following patch:
> > > > > > > >
> > > > > > > > diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm3=
2.c
> > > > > > > > index 687967d3265f..c7fc02b0fa3c 100644
> > > > > > > > --- a/drivers/pwm/pwm-stm32.c
> > > > > > > > +++ b/drivers/pwm/pwm-stm32.c
> > > > > > > > @@ -451,6 +451,10 @@ static int stm32_pwm_apply(struct pwm_=
chip *chip, struct pwm_device *pwm,
> > > > > > > >       struct stm32_pwm *priv =3D to_stm32_pwm_dev(chip);
> > > > > > > >       int ret;
> > > > > > > >
> > > > > > > > +     dev_info(chip->dev, "%s:%d\n", __func__, __LINE__);
> > > > > > > > +     msleep(5000);
> > > > > > > > +     dev_info(chip->dev, "%s:%d\n", __func__, __LINE__);
> > > > > > > > +
> > > > > > > >       enabled =3D pwm->state.enabled;
> > > > > > > >
> > > > > > > >       if (enabled && !state->enabled) {
> > > > > > > > @@ -650,7 +654,11 @@ static void stm32_pwm_remove(struct pl=
atform_device *pdev)
> > > > > > > >  {
> > > > > > > >       struct stm32_pwm *priv =3D platform_get_drvdata(pdev);
> > > > > > > >
> > > > > > > > +     dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
> > > > > > > >       pwmchip_remove(&priv->chip);
> > > > > > > > +     dev_info(&pdev->dev, "%s:%d\n", __func__, __LINE__);
> > > > > > > > +
> > > > > > > > +     priv->regmap =3D NULL;
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static int __maybe_unused stm32_pwm_suspend(struct device =
*dev)
> > > > > > > >
> > > > > > > > The first hunk is only there to widen the race window. The =
second is to
> > > > > > > > give some diagnostics and make stm32_pwm_apply() crash if i=
t continues
> > > > > > > > to run after the msleep. (Without it it didn't crash reprod=
ucibly, don't
> > > > > > > > understand why. *shrug*)
> > > > > > > >
> > > > > > > > The device tree contains a pwm-fan device making use of one=
 of the PWMs.
> > > > > > > >
> > > > > > > > Now I do the following:
> > > > > > > >
> > > > > > > >       echo fan > /sys/bus/platform/drivers/pwm-fan/unbind &=
 sleep 1; echo 40007000.timer:pwm > /sys/bus/platform/drivers/stm32-pwm/unb=
ind
> > > > > > > >
> > > > > > > > Unbinding the fan device has two effects:
> > > > > > > >
> > > > > > > >  - The device link between fan and pwm looses its property =
to unbind fan
> > > > > > > >    when pwm gets unbound.
> > > > > > > >    (Its .status changes from DL_STATE_ACTIVE to DL_STATE_AV=
AILABLE)
> > > > > > > >  - It calls pwm_fan_cleanup() which triggers a call to
> > > > > > > >    pwm_apply_state().
> > > > > > > >
> > > > > > > > So when the pwm device gets unbound the first thread is sle=
eping in
> > > > > > > > stm32_pwm_apply(). The driver calls pwmchip_remove() and se=
ts
> > > > > > > > priv->regmap to NULL. Then a few seconds later the first th=
read wakes up
> > > > > > > > in stm32_pwm_apply() with the chip freed and priv->regmap =
=3D NULL. Bang!
> > > > > > > >
> > > > > > > > This looks as follows:
> > > > > > > >
> > > > > > > > root@crown:~# echo fan > /sys/bus/platform/drivers/pwm-fan/=
unbind & sleep 1; echo 40007000.timer:pwm > /sys/bus/platform/drivers/stm32=
-pwm/unbind
> > > > > > > > [  187.182113] stm32-pwm 40007000.timer:pwm: stm32_pwm_appl=
y:454
> > > > > > > > [  188.164769] stm32-pwm 40007000.timer:pwm: stm32_pwm_remo=
ve:657
> > > > > > > > [  188.184555] stm32-pwm 40007000.timer:pwm: stm32_pwm_remo=
ve:659
> > > > > > > > root@crown:~# [  192.236423] platform 40007000.timer:pwm: s=
tm32_pwm_apply:456
> > > > > > > > [  192.240727] 8<--- cut here ---
> > > > > > > > [  192.243759] Unable to handle kernel NULL pointer derefer=
ence at virtual address 0000001c when read
> > > > > > > > ...
> > > > > > > >
> > > > > > > > Even without the crash you can see that stm32_pwm_apply() i=
s still
> > > > > > > > running after pwmchip_remove() completed.
> > > > > > > >
> > > > > > > > I'm unsure if the device link could be improved here to ens=
ure that the
> > > > > > > > fan is completely unbound even if it started unbinding alre=
ady before
> > > > > > > > the pwm device gets unbound. (And if it could, would this f=
it the device
> > > > > > > > links purpose and so be a sensible improvement?)
> > > > > > >
> > > > > > > While I think that there is something to be done in the pwm c=
ore that
> > > > > > > this doesn't explode (i.e. do proper lifetime tracking such t=
hat a
> > > > > > > pwm_chip doesn't disappear while still being used---and I'm w=
orking on
> > > > > > > that) I expected that the device links between pwm consumer a=
nd provider
> > > > > > > would prevent the above described oops, too. But somehow the =
fan already
> > > > > > > going away (but still using the PWM) when the PWM is unbound,=
 results in
> > > > > > > the PWM disappearing before the fan is completely gone.
> > > > > > >
> > > > > > > Is this expected, or a problem that can (and should?) be fixe=
d?
> > > > > >
> > > > > > I didn't read your full series, but I read this email. With wha=
t's in
> > > > > > this email, the problem seems to be in the driver or the pwm
> > > > > > framework. The pwm driver/framework can't tell the driver core =
that
> > > > > > you successfully unbound (returning from .remove()) before you =
have
> > > > > > finish all your ongoing transactions with the device. If your
> > > > > > "apply()" is still running, you need to make sure it's complete=
 before
> > > > > > .remove() does any resource releasing/clean up.
> > > > > >
> > > > > > Also, how is the consumer driver's .remove() succeeding if it h=
as an
> > > > > > ongoing pwm call()?
> > > > >
> > > > > The thing that works fine and as expected is:
> > > > >
> > > > >  - trigger unbind of PWM device via sysfs
> > > > >
> > > > > Because there is a device link PWM provider -> pwm consumer (fan)=
, the
> > > > > fan is removed and once its gone (and not earlier), the PWM gets =
unbound.
> > > > >
> > > > > The failing sequence is:
> > > > >
> > > > >  - trigger unbind of fan device in userspace thread A via sysfs. =
The
> > > > >    fan's remove callback blocks for 5s in pwm_apply_state() and so
> > > > >    .remove() doesn't complete yet.
> > > > >
> > > > >  - a second later: trigger unbind of PWM device via sysfs in thre=
ad B.
> > > > >    As before I'd expect that the device link results in waiting f=
or the
> > > > >    fan to be removed completely, but the PWM is removed immediate=
ly.
> > > > >
> > > > >  - pwm_apply_state's sleep completes (in thread B) and operates o=
n freed
> > > > >    resources =3D> bang!
> > > > >
> > > > > > This all sounds like insufficient locking and
> > > > > > critical region protection in both the consumer and supplier.
> > > > >
> > > > > My (and I think also Thierry's) expectation was, that the device =
link
> > > > > provides the needed synchronisation. But it doesn't as it doesn't=
 block
> > > > > the PWM provider going away until the fan is completely gone.
> > > > >
> > > > > > Device links can't do anything here because you are giving it w=
rong
> > > > > > info -- that the unbind was successful before it actually is.
> > > > >
> > > > > The fan's unbind is ongoing, but not complete yet and I'd expect =
that
> > > > > the device link blocks unbinding the PWM until the fan is complet=
ely
> > > > > gone. So I think there is no wrong information.
> > > > >
> > > > > > Device links will and can make sure that the consumer is unbound
> > > > > > successfully before the unbind is called on the supplier. And i=
t looks
> > > > > > like that's still true here.
> > > > >
> > > > > I hope you understood the situation better now and see the proble=
m we
> > > > > have.
> > > > >
> > > > > The problem is fixable in the pwm framework (and I'm working on t=
hat),
> > > > > but I think there is also something to improve around devicelink
> > > > > handling.
> > > >
> > > > Thanks for a better explanation of the issue. I agree, this seems l=
ike
> > > > something device links should be able to take care of.
> > > >
> > > > I'll take a look into this.
> > >
> > > Took me a while to debug this because I couldn't find the .remove()
> > > function and I was very confused about what's going on.
> > > I'm guessing you started hitting this issue only after moving to the
> > > devm_ variant of the pwm APIs.
> >
> > Ah I see. That problem wouldn't happen if the fan called a pwm API
> > function in its remove callback but that happens in a devm cleanup call
> > (registered by devm_add_action_or_reset(dev, pwm_fan_cleanup, ctx) in
> > pwm_fan_probe()). I first thought you talked about
> > 8c89fd866ad221af037ef0ec3d60b83d0b859c65.
>=20
> Am I not talking about that commit?

The relevant thing is that the fan (i.e. the consumer) uses
pwm_apply_state() in a devm cleanup. If the pwm provider uses
devm_pwmchip_add or plain pwmchip_add + pwmchip_remove in .remove()
doesn't matter.

> Btw, I'm still a bit confused by this thread. In your earlier emails
> to me, you said:
>=20
> >  - trigger unbind of fan device in userspace thread A via sysfs. The
> >  fan's remove callback blocks for 5s in pwm_apply_state() and so
> >  .remove() doesn't complete yet.
>=20
> But the latest tree (Tot) didn't have any .remove() function at all.
> So I just decided to see if there's any issue in Tot and just fix
> that. I'm glad my fix helps fixed the issue with the used of devm_*()
> APIs.

I was sloppy here and called it "remove callback" when it was really a
devm cleanup call. Sorry if that confused you. I didn't expect this to
make a difference (and I'm not even sure I was aware this is a devm
cleanup and not directly .remove() when I wrote that).

> However, are you really seeing the issue (supplier freed before
> consumer) if you do the clean up in the .remove() function? If so,
> there might still be another issue that needs to be fixed.

I didn't test that and now having understood the issue you fixed and
seeing the effect, I confidently claim there is nothing to fix for
drivers that use pwm_apply_state in .remove().

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uppqargxs3l4hzpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUwTDUACgkQj4D7WH0S
/k7wNQf+IiovjTeyrUj8qL5HHkKbQn7POIxMV3kl3K4OH6TEf5N0WGryrGIoodjz
AxX5QiyQA1ECLUmL6zNTZusX2A83bUHcDa83l5qwRn53s4lXikr1nunTdY6XlKtd
Iz8Iwsdj1L09y3otaDJFpXJn+HHmncaCuLxsM8S93EQ09hbfMU6NyaUbSk5K64Mg
5fHa6Q0X+B2mZctVZG8ZiVePlR+YqfOGokpHJUMe4tMOnjjxYJUzmB8WMDveIQrc
5PP62t4i/DxGqS+aYarWKM+qNJKWxOZDe6lR5O+/bLvcxlkYEbCwkFNStA8HRTLI
tisA9iknPAOtML6nXKGyqkJFuFRKLw==
=6fCj
-----END PGP SIGNATURE-----

--uppqargxs3l4hzpm--
