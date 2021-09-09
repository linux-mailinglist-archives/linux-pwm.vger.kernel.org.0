Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711284046BC
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Sep 2021 10:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhIIIGd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Sep 2021 04:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhIIIGd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Sep 2021 04:06:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85477C061575
        for <linux-pwm@vger.kernel.org>; Thu,  9 Sep 2021 01:05:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOF3f-0004Gx-Um; Thu, 09 Sep 2021 10:05:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOF3d-0007Kw-Sz; Thu, 09 Sep 2021 10:05:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOF3d-0005Nk-Rd; Thu, 09 Sep 2021 10:05:17 +0200
Date:   Thu, 9 Sep 2021 10:05:17 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?Q?M=C3=A5rten?= Lindahl <marten.lindahl@axis.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH v2] pwm: pwm-samsung: Trigger manual update when
 disabling PWM
Message-ID: <20210909080517.rsrohvdqqcnnjv2x@pengutronix.de>
References: <20210908155901.18944-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xxlzaldwqy2co3kp"
Content-Disposition: inline
In-Reply-To: <20210908155901.18944-1-marten.lindahl@axis.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xxlzaldwqy2co3kp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Sep 08, 2021 at 05:59:01PM +0200, M=E5rten Lindahl wrote:
> When duty-cycle is at full level (100%), the TCNTn and TCMPn registers
> needs to be flushed in order to disable the signal. The PWM manual does
> not say anything about this, but states that only clearing the TCON
> auto-reload bit should be needed, and this seems to be true when the PWM
> duty-cycle is not at full level. This can be observed on an Axis
> ARTPEC-8, by running:
>=20
>   echo <period> > pwm/period
>   echo <period> > pwm/duty_cycle
>   echo 1 > pwm/enable
>   echo 0 > pwm/enable
>=20
> Since the TCNTn and TCMPn registers are activated when enabling the PWM
> (setting TCON auto-reload bit), and are not touched when disabling the
> PWM, the double buffered auto-reload function seems to be still active.
> Lowering duty-cycle, and restoring it again in between the enabling and
> disabling, makes the disable work since it triggers a reload of the
> TCNTn and TCMPn registers.
>=20
> Fix this by securing a reload of the TCNTn and TCMPn registers when
> disabling the PWM and having a full duty-cycle.
>=20
> Signed-off-by: M=E5rten Lindahl <marten.lindahl@axis.com>
> ---
>=20
> v2:
>  - Move fix above setting of disabled_mask
>=20
>  drivers/pwm/pwm-samsung.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> index f6c528f02d43..53edc0da3ff8 100644
> --- a/drivers/pwm/pwm-samsung.c
> +++ b/drivers/pwm/pwm-samsung.c
> @@ -105,6 +105,9 @@ struct samsung_pwm_chip {
>  static DEFINE_SPINLOCK(samsung_pwm_lock);
>  #endif
> =20
> +static void __pwm_samsung_manual_update(struct samsung_pwm_chip *chip,
> +				      struct pwm_device *pwm);
> +

If you move the definition of __pwm_samsung_manual_update before
pwm_samsung_disable() you can drop this declaration:

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index d904a2480849..b405dd434ad6 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -105,9 +105,6 @@ struct samsung_pwm_chip {
 static DEFINE_SPINLOCK(samsung_pwm_lock);
 #endif
=20
-static void __pwm_samsung_manual_update(struct samsung_pwm_chip *chip,
-				      struct pwm_device *pwm);
-
 static inline
 struct samsung_pwm_chip *to_samsung_pwm_chip(struct pwm_chip *chip)
 {
@@ -120,6 +117,32 @@ static inline unsigned int to_tcon_channel(unsigned in=
t channel)
 	return (channel =3D=3D 0) ? 0 : (channel + 1);
 }
=20
+static void __pwm_samsung_manual_update(struct samsung_pwm_chip *chip,
+				      struct pwm_device *pwm)
+{
+	unsigned int tcon_chan =3D to_tcon_channel(pwm->hwpwm);
+	u32 tcon;
+
+	tcon =3D readl(chip->base + REG_TCON);
+	tcon |=3D TCON_MANUALUPDATE(tcon_chan);
+	writel(tcon, chip->base + REG_TCON);
+
+	tcon &=3D ~TCON_MANUALUPDATE(tcon_chan);
+	writel(tcon, chip->base + REG_TCON);
+}
+
+static void pwm_samsung_manual_update(struct samsung_pwm_chip *chip,
+				      struct pwm_device *pwm)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&samsung_pwm_lock, flags);
+
+	__pwm_samsung_manual_update(chip, pwm);
+
+	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
+}
+
 static void pwm_samsung_set_divisor(struct samsung_pwm_chip *pwm,
 				    unsigned int channel, u8 divisor)
 {
@@ -291,32 +314,6 @@ static void pwm_samsung_disable(struct pwm_chip *chip,=
 struct pwm_device *pwm)
 	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
=20
-static void __pwm_samsung_manual_update(struct samsung_pwm_chip *chip,
-				      struct pwm_device *pwm)
-{
-	unsigned int tcon_chan =3D to_tcon_channel(pwm->hwpwm);
-	u32 tcon;
-
-	tcon =3D readl(chip->base + REG_TCON);
-	tcon |=3D TCON_MANUALUPDATE(tcon_chan);
-	writel(tcon, chip->base + REG_TCON);
-
-	tcon &=3D ~TCON_MANUALUPDATE(tcon_chan);
-	writel(tcon, chip->base + REG_TCON);
-}
-
-static void pwm_samsung_manual_update(struct samsung_pwm_chip *chip,
-				      struct pwm_device *pwm)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&samsung_pwm_lock, flags);
-
-	__pwm_samsung_manual_update(chip, pwm);
-
-	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
-}
-
 static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *=
pwm,
 				int duty_ns, int period_ns, bool force_period)
 {

)

Maybe split the patch to have it nice and reviewable?

Orthogonal to your patch: I wonder what &samsung_pwm_lock actually
protects and why it disables irqs. In general the pwm functions might
sleep, at least some implementations do.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xxlzaldwqy2co3kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmE5wDoACgkQwfwUeK3K
7Al4dQf/SzpiM4vLyDlaIy5UY4YDkez7lDcT60HK4Scb7bPcfmLlsSDj3W/Z1sgb
AXTEDpYjXu4J+7XninhiDoEGrRe4chV7irl1DEOBbT1RRgCWrBbBMjJbiVQyKAaY
gjdLCqyURpPila9zEl3922GMC+nYybYmDXv1mdcgK21fEzo8UDV9pSftGjEy/krX
X0pbM2yblF4ryfY4npQsoUKS7C16fXHM5Q9pQ+H7djweh4/kAVny8UodOJTRQsAd
xzx0nY/Ha6Um4tH3a0urt5GZ+1SY1tlD3UtbdifHHOIw6cum3crh0QYISmkyfEFa
/k+WEs5ll9uwYgyv10Y+qtjfvX6zvA==
=EgCj
-----END PGP SIGNATURE-----

--xxlzaldwqy2co3kp--
