Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20B21DAB4A
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 13:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406049AbfJQLf7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 07:35:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40097 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405493AbfJQLf7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Oct 2019 07:35:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id o28so1939296wro.7;
        Thu, 17 Oct 2019 04:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kd9slrJN+SdPmMmPQlYtEDCdUaRQIdAmy0KubnyFaUU=;
        b=SkIZOIWHw/4sAfLy1k0g5XfxjGo2CY6qn8uFfJsRnbyUMT+nA6cScBd1oZUKvRGLOO
         tC94Z7EPMdRtMqcMZ86W4NUb0zvB0gTxKayN2U/BDb4/XLNJ7GodRcqVKy5zwcFiPjsJ
         R+Vm+CDA9gH4kYiSDkOYQOuojHYuXcq6gFGcVdEP8Qah5Ou0JHg+nz2e53yzrZZax7R/
         YIiv4AWYE6tq5/cMH2SgLvJPVx5BQGbi0fZJx2nyzvu0VkDTTQkKRAC4C8gDUTlKdyak
         A86oimlyhN8qmj2pFBN7Ce+6fQ87L0rBCraE+oIK5s7rf4V2hjqBAkE+YtQsTkTNjbri
         cUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kd9slrJN+SdPmMmPQlYtEDCdUaRQIdAmy0KubnyFaUU=;
        b=fBMF/2dc3fwa3ike+n6cViW8uxO6cBd2AK/3JTViVkBa46wQrbTyVRRkaELQgQiKbH
         zIbsaZwW8l6FeABVombSBaSYN7ajWEvXMYNKkjsr1mbVVhbwFKkqv6RyuKZJvbYVWedD
         48IKRdIsGBMU2GBLh/RWpKUTjPvzicDVuzq6r/ptljBuc2W2G3q1nW7klQny3KOYzzjI
         /Ye6s0iPGjKuV3RPPZY1zDyNyxnD1P8pZYdDaIu0+C/yZtlfhr8gmcdc89h1H2Y38YUi
         D4QkH8n7FlTOc4icHhumnOUek14CNrBNIQ4vLHG4WvAme5ulUprMfBn1Cw+dLLWFj8hq
         jsvA==
X-Gm-Message-State: APjAAAXAjGARvEon70BI84nB0ZdoOB+7RPOhI+ztyPus5ZJKgBuvDahC
        orLZKVU3heHchaAYNpZdGGI=
X-Google-Smtp-Source: APXvYqxCsDPVs+aAd39FRWgWCZjsLNA9foZeraaobnxi/GZBDmu8Sf6CnMtommxIC/IARQ4IQoU2Mw==
X-Received: by 2002:a05:6000:128c:: with SMTP id f12mr1540074wrx.279.1571312155418;
        Thu, 17 Oct 2019 04:35:55 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id s9sm2380301wme.36.2019.10.17.04.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 04:35:54 -0700 (PDT)
Date:   Thu, 17 Oct 2019 13:35:52 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        heiko@sntech.de, dianders@chromium.org, mka@chromium.org,
        groeck@chromium.org, kernel@collabora.com, bleung@chromium.org,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] pwm: cros-ec: Let cros_ec_pwm_get_state() return the
 last applied state
Message-ID: <20191017113552.GC3122066@ulmo>
References: <20191008143432.pbhcqamd6f4qwbqn@pengutronix.de>
 <4f009344-242e-19a7-6872-2c55df086044@collabora.com>
 <20191008203137.s22clq6v2om5ktio@pengutronix.de>
 <53b7d02b-1a2d-11da-fdd0-5378f360d876@collabora.com>
 <20191009095635.yysr33lnwldicyng@holly.lan>
 <20191009101637.gmvghwdvcmfw4yyk@pengutronix.de>
 <20191009104236.ux23ywnhvsym2qcb@holly.lan>
 <20191009112126.slpyxhnuqpiqgmes@pengutronix.de>
 <20191009113540.x6uxo3ryiuf7ql55@holly.lan>
 <49990b56-44f9-7c3c-ce81-ed295895f90a@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline
In-Reply-To: <49990b56-44f9-7c3c-ce81-ed295895f90a@collabora.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2019 at 03:47:43PM +0200, Enric Balletbo i Serra wrote:
> Hi Uwe, Daniel,
>=20
> On 9/10/19 13:35, Daniel Thompson wrote:
> > On Wed, Oct 09, 2019 at 01:21:26PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> >> On Wed, Oct 09, 2019 at 11:42:36AM +0100, Daniel Thompson wrote:
> >>> On Wed, Oct 09, 2019 at 12:16:37PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> >>>> On Wed, Oct 09, 2019 at 10:56:35AM +0100, Daniel Thompson wrote:
> >>>>> On Wed, Oct 09, 2019 at 11:27:13AM +0200, Enric Balletbo i Serra wr=
ote:
> >>>>>> Hi Uwe,
> >>>>>>
> >>>>>> Adding Daniel and Lee to the discussion ...
> >>>>>
> >>>>> Thanks!
> >>>>>
> >>>>>> On 8/10/19 22:31, Uwe Kleine-K=C3=B6nig wrote:
> >>>>>>> On Tue, Oct 08, 2019 at 06:33:15PM +0200, Enric Balletbo i Serra =
wrote:
> >>>>>>>>> A few thoughts to your approach here ...:
> >>>>>>>>>
> >>>>>>>>>  - Would it make sense to only store duty_cycle and enabled in =
the
> >>>>>>>>>    driver struct?
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Yes, in fact, my first approach (that I didn't send) was only st=
oring enabled
> >>>>>>>> and duty cycle. For some reason I ended storing the full pwm_sta=
te struct, but I
> >>>>>>>> guess is not really needed.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>>  - Which driver is the consumer of your pwm? If I understand co=
rrectly
> >>>>>>>>>    the following sequence is the bad one:
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> The consumer is the pwm_bl driver. Actually I'n trying to identi=
fy
> >>>>>>>> other consumers.
> >>>>>>>
> >>>>>>
> >>>>>> So far, the pwm_bl driver is the only consumer of cros-ec-pwm.
> >>>>>>
> >>>>>>> Ah, I see why I missed to identify the problem back when I checke=
d this
> >>>>>>> driver. The problem is not that .duty_cycle isn't set but there .=
enabled
> >>>>>>> isn't set. So maybe we just want:
> >>>>>>>
> >>>>>>> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/bac=
klight/pwm_bl.c
> >>>>>>> index 2201b8c78641..0468c6ee4448 100644
> >>>>>>> --- a/drivers/video/backlight/pwm_bl.c
> >>>>>>> +++ b/drivers/video/backlight/pwm_bl.c
> >>>>>>> @@ -123,6 +123,7 @@ static int pwm_backlight_update_status(struct=
 backlight_device *bl)
> >>>>>>>         if (brightness > 0) {
> >>>>>>>                 pwm_get_state(pb->pwm, &state);
> >>>>>>>                 state.duty_cycle =3D compute_duty_cycle(pb, brigh=
tness);
> >>>>>>> +               state.enabled =3D true;
> >>>>>>>                 pwm_apply_state(pb->pwm, &state);
> >>>>>>>                 pwm_backlight_power_on(pb);
> >>>>>>>         } else
> >>>>>>>
> >>>>>>> ? On a side note: It's IMHO strange that pwm_backlight_power_on
> >>>>>>> reconfigures the PWM once more.
> >>>>>>>
> >>>>>>
> >>>>>> Looking again to the pwm_bl code, now, I am not sure this is corre=
ct (although
> >>>>>> it probably solves the problem for me).
> >>>>>
> >>>>> Looking at the pwm_bl code I wouldn't accept the above as it is but=
 I'd
> >>>>> almost certainly accept a patch to pwm_bl to move the PWM enable/di=
sable
> >>>>> out of both the power on/off functions so the duty-cycle/enable or
> >>>>> disable can happen in one go within the update_status function. I d=
on't
> >>>>> think such a change would interfere with the power and enable seque=
ncing
> >>>>> needed by panels and it would therefore be a nice continuation of t=
he
> >>>>> work to convert over to the pwm_apply_state() API.
> >>>>
> >>>> OK for me. Enric, do you care enough to come up with a patch for pwm=
_bl?
> >>>> I'd expect that this alone should already fix your issue.
> >>>> =20
> >>>>> None of the above has anything to do with what is right or wrong for
> >>>>> the PWM API evolution. Of course, if this thread does conclude that=
 it
> >>>>> is OK the duty cycle of a disabled PWM to be retained for some driv=
ers
> >>>>> and not others then I'd hope to see some WARN_ON()s added to the PWM
> >>>>> framework to help bring problems to the surface with all drivers.
> >>>>
> >>>> I think it's not possible to add a reliable WARN_ON for that issue. =
It
> >>>> is quite expected that .get_state returns something that doesn't
> >>>> completely match the requested configuration. So if a consumer reque=
sts
> >>>>
> >>>> 	.duty_cycle =3D 1
> >>>> 	.period =3D 100000000
> >>>> 	.enabled =3D false
> >>>>
> >>>> pwm_get_state possibly returns .duty_cycle =3D 0 even for drivers/ha=
rdware
> >>>> that has a concept of duty_cycle for disabled hardware.
> >>>>
> >>>> A bit this is addressed in https://patchwork.ozlabs.org/patch/114751=
7/.
> >>>
> >>> Isn't that intended to help identify "odd" PWM drivers rather than "o=
dd"
> >>> clients?
> >>>
> >>> Initially I was thinking that a WARN_ON() could be emitted when:
> >>>
> >>> 1. .duty_cycle is non-zero
> >>> 2. .enabled is false
> >>> 3. the PWM is not already enabled
> >>>
> >>> (#3 included to avoid too many false positives when disabling a PWM)
> >>
> >> I think I created a patch for that in the past, don't remember the
> >> details.
> >>
> >>> A poisoning approach might be equally valid. If some drivers are
> >>> permitted to "round" .duty_cycle to 0 when .enabled is false then the
> >>> framework could get *all* drivers to behave in the same way by
> >>> zeroing it out before calling the drivers apply method. It is not that
> >>> big a deal but minimising the difference between driver behaviour sho=
uld
> >>> automatically reduce the difference in API usage by clients.
> >>
> >> I like it, but that breaks consumers that set .duty_cycle once during
> >> probe and then only do:
> >>
> >> 	pwm_get_state(pwm, &state);
> >> 	state.enabled =3D ...
> >> 	pwm_apply_state(pwm, &state);
> >>
> >> which is a common idiom.
> >=20
> > Sorry I must have missed something. That appears to be identical to
> > what pwm_bl.c currently does, albeit for rather better reasons.
> >=20
> > If setting the duty cycle and then separately enabling it is a
> > reasonable idiom then the cros-ec-pwm driver is a broken implementation
> > of the API and needs to be fixed regardless of any changes to pwm_bl.c .
> >=20
>=20
> I think that Daniel has reason here. Just come to my mind that, if the fi=
x is
> not in the cros-ec-pwm driver we will also have the PWM sysfs user space
> interface broken for that driver, apart from future consumers.
>=20
> This turns on to my first approach, this patch. Uwe, You had some complai=
ns
> regarding is if I can only store enabled and duty_cycle instead of all the
> pwm_state, that should also work for me. If I solve that concern, might b=
e this
> solution acceptable for you? Do you have more concerns?

There's been a similar report of pwm-backlight getting confused with the
i.MX PWM driver. What ChromeOS EC and i.MX drivers both have in common
is that they return a duty cycle of 0 when the PWM is off. For i.MX, the
patch I propose caches the duty cycle and uses the cached value when
appropriate. I think a similar patch (see below) would work for cros-ec.

Can somebody give that a quick test to see whether it fixes the issue on
ChromeOS hardware?

Thierry

--- >8 ---
=46rom 15245e5f0dc02af021451b098df93901c9f49373 Mon Sep 17 00:00:00 2001
=46rom: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 17 Oct 2019 13:21:15 +0200
Subject: [PATCH] pwm: cros-ec: Cache duty cycle value

The ChromeOS embedded controller doesn't differentiate between disabled
and duty cycle being 0. In order not to potentially confuse consumers,
cache the duty cycle and return the cached value instead of the real
value when the PWM is disabled.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-cros-ec.c | 58 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 89497448d217..09c08dee099e 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -25,11 +25,39 @@ struct cros_ec_pwm_device {
 	struct pwm_chip chip;
 };
=20
+/**
+ * struct cros_ec_pwm - per-PWM driver data
+ * @duty_cycle: cached duty cycle
+ */
+struct cros_ec_pwm {
+	u16 duty_cycle;
+};
+
 static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chi=
p *c)
 {
 	return container_of(c, struct cros_ec_pwm_device, chip);
 }
=20
+static int cros_ec_pwm_request(struct pwm_chip *chip, struct pwm_device *p=
wm)
+{
+	struct cros_ec_pwm *channel;
+
+	channel =3D kzalloc(sizeof(*channel), GFP_KERNEL);
+	if (!channel)
+		return -ENOMEM;
+
+	pwm_set_chip_data(pwm, channel);
+
+	return 0;
+}
+
+static void cros_ec_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct cros_ec_pwm *channel =3D pwm_get_chip_data(pwm);
+
+	kfree(channel);
+}
+
 static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 d=
uty)
 {
 	struct {
@@ -96,7 +124,9 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
 			     const struct pwm_state *state)
 {
 	struct cros_ec_pwm_device *ec_pwm =3D pwm_to_cros_ec_pwm(chip);
-	int duty_cycle;
+	struct cros_ec_pwm *channel =3D pwm_get_chip_data(pwm);
+	u16 duty_cycle;
+	int ret;
=20
 	/* The EC won't let us change the period */
 	if (state->period !=3D EC_PWM_MAX_DUTY)
@@ -108,13 +138,20 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
 	 */
 	duty_cycle =3D state->enabled ? state->duty_cycle : 0;
=20
-	return cros_ec_pwm_set_duty(ec_pwm->ec, pwm->hwpwm, duty_cycle);
+	ret =3D cros_ec_pwm_set_duty(ec_pwm->ec, pwm->hwpwm, duty_cycle);
+	if (ret < 0)
+		return ret;
+
+	channel->duty_cycle =3D state->duty_cycle;
+
+	return 0;
 }
=20
 static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device=
 *pwm,
 				  struct pwm_state *state)
 {
 	struct cros_ec_pwm_device *ec_pwm =3D pwm_to_cros_ec_pwm(chip);
+	struct cros_ec_pwm *channel =3D pwm_get_chip_data(pwm);
 	int ret;
=20
 	ret =3D cros_ec_pwm_get_duty(ec_pwm->ec, pwm->hwpwm);
@@ -126,8 +163,19 @@ static void cros_ec_pwm_get_state(struct pwm_chip *chi=
p, struct pwm_device *pwm,
 	state->enabled =3D (ret > 0);
 	state->period =3D EC_PWM_MAX_DUTY;
=20
-	/* Note that "disabled" and "duty cycle =3D=3D 0" are treated the same */
-	state->duty_cycle =3D ret;
+	/*
+	 * Note that "disabled" and "duty cycle =3D=3D 0" are treated the same. If
+	 * the cached duty cycle is not zero, used the cached duty cycle. This
+	 * ensures that the configured duty cycle is kept across a disable and
+	 * enable operation and avoids potentially confusing consumers.
+	 *
+	 * For the case of the initial hardware readout, channel->duty_cycle
+	 * will be 0 and the actual duty cycle read from the EC is used.
+	 */
+	if (ret =3D=3D 0 && channel->duty_cycle > 0)
+		state->duty_cycle =3D channel->duty_cycle;
+	else
+		state->duty_cycle =3D ret;
 }
=20
 static struct pwm_device *
@@ -149,6 +197,8 @@ cros_ec_pwm_xlate(struct pwm_chip *pc, const struct of_=
phandle_args *args)
 }
=20
 static const struct pwm_ops cros_ec_pwm_ops =3D {
+	.request =3D cros_ec_pwm_request,
+	.free =3D cros_ec_pwm_free,
 	.get_state	=3D cros_ec_pwm_get_state,
 	.apply		=3D cros_ec_pwm_apply,
 	.owner		=3D THIS_MODULE,
--=20
2.23.0


--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2oUhYACgkQ3SOs138+
s6E7Nw//Rw1n6HnwDRSTajA1krgScHSjsbRua4NDehrLfmYUtcJxUB6+UY/4WbB1
k+nXJsGo5ZF3++d+ABhLQZ8AqjaRTnLUfJ7zNXVL/HURAjInqYkFzgxZ4FQMxAUb
I9l2w7ERYOfxNUI79qU6BVdJS2BOo5HFQxzNYZOvggbTwzrQN2ISls49KDUEw1t9
3otu1tDoS9DIjgGYqyVrWrcibKYmhRj+t2a5b4QosMcHFAYtiTOP/UmAPMhQKGVR
i1WoceH8wXueVoPH7KmUw7foF51jW6hkvKczM94GvD5ZuW0Ev1jTuSiZrF4EUc+x
tojskRz9ayvd+nBxlSgyVfxs0ub2TmzOzWD1FmIK8oNMB0zFgGimgdCbieONBf8b
V6kVlBAdJwoRzzLzzlW2Mck/PEyqWglhcHrTiaSu+oJYI6kCZrwlFEmOsI+h0L4V
7LOiG1Gsc06Ufb6dIIaivd+pVVXlWS5JcCi/EgFf1WkffX7eCzCko7bvRFwJd09q
nna0hz7wG7b6R26aj7qnqf844lpHttI23gATtV3nAs9EWnm+aiZhq/ZCgFMpdVQZ
73q3ISlejXGbtpknjmFv9+yyZqjef09f2URd9CV9ol6eNTgl6P39rSbx6+aFf1z6
T1eEMasibt80cFX2LY1EViOGKjrTV6R+o7CHx+lq4NBibJhtX50=
=97sT
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
