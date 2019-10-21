Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16147DE8F1
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 12:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfJUKCP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 06:02:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37138 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbfJUKCO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 06:02:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id f22so12108684wmc.2;
        Mon, 21 Oct 2019 03:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ohlov+iGP8dzxzQmWfoP/FkUjAgrTmhGfb09cHuW1eE=;
        b=YC46CTb7nKXZvJzxg21+R9dhJTTmRX8uuHRC0TV6qfyJ1A+vWT/PTK+f1vdlqpOuLK
         idXL3UJqMJyJvGs+i63Nr8RmI34sO59+jyEneQWg/QIvRgByw89JCK4BkOLS98kZqTv0
         2l0aqpIk/HByn9RPA5ABK4wl+zNuMU0SvPdSD6PMhOiPXwIYtkw/EfcIBzf8DRW7ABvE
         SA+1qU7+PXoQTkvwo4NAflSCNRWM5epHSta1fW9uKVOvkapySfw09oUiWFkrXCvc9KAP
         MzHjhrx0z5/5e0Th+9/qHGI3Y63A2lPfi9fxLTJ+jabSpTNnU4y/CIEtOvU37bCx7/CB
         vaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ohlov+iGP8dzxzQmWfoP/FkUjAgrTmhGfb09cHuW1eE=;
        b=bG2YbniWmzyg0YoZ4B23qfg3tGZxcQcP76F43lSdR4MaV6xULpwSQN05hWYLlFbLhS
         EkyURclcot8S9t1PcwIjf3ungGzvtsyB86cwX7jcG0UDaEJJFkXXyK4bCC94KFBl6mUq
         gmbkhhYfmh7cZObeQjK0xEm3opVOHXOosFdhn0anE5CWKNjIwnzG1UF70Np2X4FazW4h
         ADRRXhfHLF3fGfBUHbHqCv09lx4HAcRe7D5+YUvfb8kGEw9Chp/43yiOPf5JkN+MHFjw
         pdhqMVSv2ZaoZsLW9Wkgnk70dpWpuR+8/oYknAlOhLi/v2IqHRKeP1vfUsENmUPQyEP7
         w4YQ==
X-Gm-Message-State: APjAAAXrelXI8rWe0rXHAnv7OZrpzRoFvmATK0xXqwJdkdKR49tukMBC
        JRNv9FsKzawGIsn4i+Gkoek=
X-Google-Smtp-Source: APXvYqxpfgd/ACX90cjXShKNJmhxi458QCoHfnRqrQNbgg5J7hWpenofj+P0QGUtEO8/T7U7Ygncrg==
X-Received: by 2002:a05:600c:28d:: with SMTP id 13mr19454158wmk.100.1571652129789;
        Mon, 21 Oct 2019 03:02:09 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id d8sm1237650wrr.71.2019.10.21.03.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:02:07 -0700 (PDT)
Date:   Mon, 21 Oct 2019 12:02:06 +0200
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
Message-ID: <20191021100206.GD1118266@ulmo>
References: <20191008203137.s22clq6v2om5ktio@pengutronix.de>
 <53b7d02b-1a2d-11da-fdd0-5378f360d876@collabora.com>
 <20191009095635.yysr33lnwldicyng@holly.lan>
 <20191009101637.gmvghwdvcmfw4yyk@pengutronix.de>
 <20191009104236.ux23ywnhvsym2qcb@holly.lan>
 <20191009112126.slpyxhnuqpiqgmes@pengutronix.de>
 <20191009113540.x6uxo3ryiuf7ql55@holly.lan>
 <49990b56-44f9-7c3c-ce81-ed295895f90a@collabora.com>
 <20191017113552.GC3122066@ulmo>
 <bb32d5f8-6915-d5f1-06ba-1cf0da99f6b1@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
In-Reply-To: <bb32d5f8-6915-d5f1-06ba-1cf0da99f6b1@collabora.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2019 at 11:42:05AM +0200, Enric Balletbo i Serra wrote:
> Hi Thierry,
> On 17/10/19 13:35, Thierry Reding wrote:
> > On Wed, Oct 09, 2019 at 03:47:43PM +0200, Enric Balletbo i Serra wrote:
>=20
> [snip]
>=20
> >=20
> > --- >8 ---
> > From 15245e5f0dc02af021451b098df93901c9f49373 Mon Sep 17 00:00:00 2001
> > From: Thierry Reding <thierry.reding@gmail.com>
> > Date: Thu, 17 Oct 2019 13:21:15 +0200
> > Subject: [PATCH] pwm: cros-ec: Cache duty cycle value
> >=20
> > The ChromeOS embedded controller doesn't differentiate between disabled
> > and duty cycle being 0. In order not to potentially confuse consumers,
> > cache the duty cycle and return the cached value instead of the real
> > value when the PWM is disabled.
> >=20
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > ---
> >  drivers/pwm/pwm-cros-ec.c | 58 ++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 54 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> > index 89497448d217..09c08dee099e 100644
> > --- a/drivers/pwm/pwm-cros-ec.c
> > +++ b/drivers/pwm/pwm-cros-ec.c
> > @@ -25,11 +25,39 @@ struct cros_ec_pwm_device {
> >  	struct pwm_chip chip;
> >  };
> > =20
> > +/**
> > + * struct cros_ec_pwm - per-PWM driver data
> > + * @duty_cycle: cached duty cycle
> > + */
> > +struct cros_ec_pwm {
> > +	u16 duty_cycle;
> > +};
> > +
> >  static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm=
_chip *c)
> >  {
> >  	return container_of(c, struct cros_ec_pwm_device, chip);
> >  }
> > =20
> > +static int cros_ec_pwm_request(struct pwm_chip *chip, struct pwm_devic=
e *pwm)
> > +{
> > +	struct cros_ec_pwm *channel;
> > +
> > +	channel =3D kzalloc(sizeof(*channel), GFP_KERNEL);
> > +	if (!channel)
> > +		return -ENOMEM;
> > +
> > +	pwm_set_chip_data(pwm, channel);
> > +
> > +	return 0;
> > +}
> > +
> > +static void cros_ec_pwm_free(struct pwm_chip *chip, struct pwm_device =
*pwm)
> > +{
> > +	struct cros_ec_pwm *channel =3D pwm_get_chip_data(pwm);
> > +
> > +	kfree(channel);
> > +}
> > +
> >  static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u=
16 duty)
> >  {
> >  	struct {
> > @@ -96,7 +124,9 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >  			     const struct pwm_state *state)
> >  {
> >  	struct cros_ec_pwm_device *ec_pwm =3D pwm_to_cros_ec_pwm(chip);
> > -	int duty_cycle;
> > +	struct cros_ec_pwm *channel =3D pwm_get_chip_data(pwm);
> > +	u16 duty_cycle;
> > +	int ret;
> > =20
> >  	/* The EC won't let us change the period */
> >  	if (state->period !=3D EC_PWM_MAX_DUTY)
> > @@ -108,13 +138,20 @@ static int cros_ec_pwm_apply(struct pwm_chip *chi=
p, struct pwm_device *pwm,
> >  	 */
> >  	duty_cycle =3D state->enabled ? state->duty_cycle : 0;
> > =20
> > -	return cros_ec_pwm_set_duty(ec_pwm->ec, pwm->hwpwm, duty_cycle);
> > +	ret =3D cros_ec_pwm_set_duty(ec_pwm->ec, pwm->hwpwm, duty_cycle);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	channel->duty_cycle =3D state->duty_cycle;
> > +
> > +	return 0;
> >  }
> > =20
> >  static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_de=
vice *pwm,
> >  				  struct pwm_state *state)
> >  {
> >  	struct cros_ec_pwm_device *ec_pwm =3D pwm_to_cros_ec_pwm(chip);
> > +	struct cros_ec_pwm *channel =3D pwm_get_chip_data(pwm);
> >  	int ret;
> > =20
> >  	ret =3D cros_ec_pwm_get_duty(ec_pwm->ec, pwm->hwpwm);
> > @@ -126,8 +163,19 @@ static void cros_ec_pwm_get_state(struct pwm_chip =
*chip, struct pwm_device *pwm,
> >  	state->enabled =3D (ret > 0);
> >  	state->period =3D EC_PWM_MAX_DUTY;
> > =20
> > -	/* Note that "disabled" and "duty cycle =3D=3D 0" are treated the sam=
e */
> > -	state->duty_cycle =3D ret;
> > +	/*
> > +	 * Note that "disabled" and "duty cycle =3D=3D 0" are treated the sam=
e. If
> > +	 * the cached duty cycle is not zero, used the cached duty cycle. This
> > +	 * ensures that the configured duty cycle is kept across a disable and
> > +	 * enable operation and avoids potentially confusing consumers.
> > +	 *
> > +	 * For the case of the initial hardware readout, channel->duty_cycle
> > +	 * will be 0 and the actual duty cycle read from the EC is used.
> > +	 */
> > +	if (ret =3D=3D 0 && channel->duty_cycle > 0)
> > +		state->duty_cycle =3D channel->duty_cycle;
> > +	else
> > +		state->duty_cycle =3D ret;
> >  }
> > =20
> >  static struct pwm_device *
> > @@ -149,6 +197,8 @@ cros_ec_pwm_xlate(struct pwm_chip *pc, const struct=
 of_phandle_args *args)
> >  }
> > =20
> >  static const struct pwm_ops cros_ec_pwm_ops =3D {
> > +	.request =3D cros_ec_pwm_request,
> > +	.free =3D cros_ec_pwm_free,
> >  	.get_state	=3D cros_ec_pwm_get_state,
> >  	.apply		=3D cros_ec_pwm_apply,
> >  	.owner		=3D THIS_MODULE,
> >=20
>=20
> I just tried your approach but I got a NULL pointer dereference while pro=
be. I
> am just back from a week off but I'll be able to dig into it between toda=
y and
> tomorrow, just wanted to let you know that the patch doesn't works as is =
for me.
>=20
> [   10.128455] Unable to handle kernel NULL pointer dereference at virtual
> address 0000000000000000
> [   10.141895] Mem abort info:
>=20
> [   10.145090]   ESR =3D 0x96000004
>=20
> [   10.148537]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>=20
> [   10.154560]   SET =3D 0, FnV =3D 0
>=20
> [   10.157986]   EA =3D 0, S1PTW =3D 0
>=20
> [   10.161548] Data abort info:
>=20
> [   10.164804]   ISV =3D 0, ISS =3D 0x00000004
>=20
> [   10.169111]   CM =3D 0, WnR =3D 0
>=20
> [   10.172436] user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000ed44b000
>=20
> [   10.179660] [0000000000000000] pgd=3D0000000000000000
>=20
> [   10.179669] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>=20
> [   10.179673] Modules linked in: atmel_mxt_ts(+) rockchip_saradc pwm_cro=
s_ec(+)
> rockchip_thermal pcie_rockchip_host snd_soc_rl6231 ip_tables x_
> tables ipv6 nf_defrag_ipv6
>=20
> [   10.179694] CPU: 1 PID: 255 Comm: systemd-udevd Not tainted 5.4.0-rc4+=
 #230
>=20
> [   10.179696] Hardware name: Google Kevin (DT)
>=20
> [   10.179700] pstate: 60000005 (nZCv daif -PAN -UAO)
>=20
> [   10.179714] pc : cros_ec_pwm_get_state+0xcc/0xf8 [pwm_cros_ec]
>=20
> [   10.179721] lr : cros_ec_pwm_get_state+0x80/0xf8 [pwm_cros_ec]
>=20
> [   10.247829] sp : ffff800012433810
>=20
> [   10.251531] x29: ffff800012433810 x28: 0000000200000026
>=20
> [   10.257469] x27: ffff800012433942 x26: ffff0000ef075010
>=20
> [   10.263405] x25: ffff800011ca8508 x24: ffff800011e68e30
>=20
> [   10.269341] x23: 0000000000000000 x22: ffff0000ee273190
> [   10.275278] x21: ffff0000ee2e3240 x20: ffff0000ee2e3270
> [   10.281214] x19: ffff800011bc98c8 x18: 0000000000000003
> [   10.287150] x17: 0000000000000007 x16: 000000000000000e
> [   10.293088] x15: 0000000000000001 x14: 0000000000000019
> [   10.299024] x13: 0000000000000033 x12: 0000000000000018
> [   10.304962] x11: 071c71c71c71c71c x10: 00000000000009d0
> [   10.310379] atmel_mxt_ts 5-004a: Family: 164 Variant: 17 Firmware V2.0=
=2EAA
> Objects: 31
> [   10.310901] x9 : ffff800012433490 x8 : ffff0000edb81830
> [   10.310905] x7 : 000000000000011b x6 : 0000000000000001
> [   10.310908] x5 : 0000000000000000 x4 : 0000000000000000
> [   10.310911] x3 : ffff0000edb80e00 x2 : 0000000000000002
> [   10.310914] x1 : 0000000000000000 x0 : 0000000000000000
> [   10.310918] Call trace:
> [   10.310931]  cros_ec_pwm_get_state+0xcc/0xf8 [pwm_cros_ec]
> [   10.310944]  pwmchip_add_with_polarity+0x134/0x290
> [   10.363576]  pwmchip_add+0x24/0x30
> [   10.367383]  cros_ec_pwm_probe+0x13c/0x1cc [pwm_cros_ec]
> [   10.373325]  platform_drv_probe+0x58/0xa8
> [   10.377809]  really_probe+0xe0/0x318
> [   10.381804]  driver_probe_device+0x5c/0xf0
> [   10.386381]  device_driver_attach+0x74/0x80

Okay, this is caused by ->get_state() getting called during
pwmchip_add_with_polarity(), which is before any of the PWMs can have
been requested, which means ->request() has not been called yet and
therefore the per-PWM state doesn't exist yet. There's a few ways to
work around that (one would be to store the state within the per-chip
structure (rather than per-PWM, another would be to defer calling the
->get_state() callback when the PWM is requested).

Either way, given that we've got a number of other drivers with similar
problems, I think at this point it's better to revert for now in v5.4
and if we do want to get this functionality back we need to start work
on fixing up the problematic drivers.

Thierry

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2tghsACgkQ3SOs138+
s6EHNxAAsFygsz8NLH/MtxqmflKMGyyQbW4cdHRl9ne/YazNBTU/at9hrId1pOgK
pAIo09hJWrHjiAlZ7St6HGcGj35NJaF5UIKl7DQa4yfcyMjI5LvfMOTGkL/PJAzy
m2kWcATyTL41qi1rXFy+d5FBaqZNNcau3nxpvGigD9UoOg3/o89GBbZ+4MNkBKbY
O1bJO8jkkXZEN39zB9ahPxe+ujRa3OfRmdtnlVVnjvyfItWnDh7kgbWttscXU7lE
ePbcxMzt7uhMX3IJwlNUkr2L8uyzDm+omBe90D6shwVj2mEQo2sCBo68uVyD4WbJ
K/QBC0A4bMw7iVxippKbHAotHsZ/zfG/RZW+l9EwpBf2T5UXsUnhP6XLA0zODqUj
VwgUrXE5Z2VKK9JJNQWEuln/B1+DAsWQMNLJqc9NzZp+F6AqEOVP+vNOjJRCvOfE
PY1ZpmMUZ804gEvAYJx2bxzhegnBm8Wr+nrdV1tbgPeaDLVF4gBuLHqg2+BCjf18
XIrS0+BnlpbGVWTjcDUykavNF3ysG+XINFa03M1K/vC602yS/8542SiF89yn3ym3
Kcy8ZdFcztxz8kchJ8Ri74o+3Hc3x1iwWk6QmvME/4M4hW6lk/eAigQE7y3z7EQx
fI12ULrSPOsVhfaINAVhqiwR+tUm1GrKxTK2Q6KJl42QUab1eHM=
=N3P5
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
