Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841A251FC42
	for <lists+linux-pwm@lfdr.de>; Mon,  9 May 2022 14:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbiEIMON (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 May 2022 08:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbiEIMOL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 May 2022 08:14:11 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FCA18E21;
        Mon,  9 May 2022 05:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1652098217; x=1683634217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t0IMr50HeyZHemI4xuII3r9g4MujOpmn8OYNNlEZjsc=;
  b=kgBS+SEi6qAhKRHjSgS9pCpI1CmDYA0exYfVUL9SNjW5oBrvC2RfEWyU
   SM6CPpBVyiYoZFdwfK+7apl5KC5BmxhQohMgUpr7X6WZ4SWjJP4J5Yy5q
   HzAg1EskYxl8R8f9P4z4A2OByO2YJ1E/bXMZQgEorlc/3rbj6BYNY8J+/
   iFLsdDnFiA5EtiZEOnw0oVxApGREfz/xSKjeI9NNbLKLft9L/Jn5Qe12p
   HrLHYrFdwAhRBmjZIcDq7Vbh2rPugIFWYkCi9OQCyahZZrsxbHzbuvF8g
   UpZ7E5idojcAXwpesl1Mi2SqTs7+LdGQrnKUNhqeN3dtV9rqD0SN15iQ0
   g==;
X-IronPort-AV: E=Sophos;i="5.91,211,1647298800"; 
   d="scan'208";a="23753895"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 09 May 2022 14:10:15 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 09 May 2022 14:10:15 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 09 May 2022 14:10:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1652098215; x=1683634215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t0IMr50HeyZHemI4xuII3r9g4MujOpmn8OYNNlEZjsc=;
  b=TCZ861ItkV/jjviGEGvF75cTZPqfxO9mrXq9ifGWmxiGCfiuIaBUE+J6
   3RNjWKQEUE3DJVAAk+WFp1ihZZnrGHoLpZx+pLAX3VNuNLS3TWMjiIKJL
   W1XTtGtMbPeJq2JnOEL9lp6f4EgBBf7brnMMyf5FpHriDbf1tqz9QlzE9
   YRPqJbP5Ge2/8HzWN+JA5okwm10I00N9rBpGxpyZvHWR+ZcP7KrFc+cer
   XmveAE2gxRckLGwLp0uoJCNcIEnH2Uh45cpVS4lf0b6y0cWyd6tAqoab2
   spF5S6ToXpZ4CRSPcWNmUDv+sB5C+xnrN6L9YzEKj2YTXdvPwdEZD7Ag4
   w==;
X-IronPort-AV: E=Sophos;i="5.91,211,1647298800"; 
   d="scan'208";a="23753894"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 May 2022 14:10:15 +0200
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id EFC75280070;
        Mon,  9 May 2022 14:10:14 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Lee Jones <lee.jones@linaro.org>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: (EXT) Re: (EXT) Re: (EXT) Re: [PATCH v2 1/1] hwmon: pwm-fan: dynamically switch regulator
Date:   Mon, 09 May 2022 14:10:14 +0200
Message-ID: <23274111.ouqheUzb2q@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220509105921.wzxlapayqidnjmfl@pengutronix.de>
References: <20220504124551.1083383-1-alexander.stein@ew.tq-group.com> <2184650.iZASKD2KPV@steina-w> <20220509105921.wzxlapayqidnjmfl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Uwe,

Am Montag, 9. Mai 2022, 12:59:21 CEST schrieb Uwe Kleine-K=F6nig:
> * PGP Signed by an unknown key
>=20
> Hello Alexander, hello Guenter,
>=20
> On Mon, May 09, 2022 at 09:39:15AM +0200, Alexander Stein wrote:
> > Am Freitag, 6. Mai 2022, 20:31:24 CEST schrieb Guenter Roeck:
> > > On Fri, May 06, 2022 at 04:29:13PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > [Dropped Bartlomiej Zolnierkiewicz from Cc:; my mailer daemon claims
> > > > the
> > > > email address doens't exist.]
> > > >=20
> > > > Hello Guenter,
> > > >=20
> > > > On Fri, May 06, 2022 at 07:12:44AM -0700, Guenter Roeck wrote:
> > > > > On Fri, May 06, 2022 at 02:23:11PM +0200, Alexander Stein wrote:
> > > > > > Am Freitag, 6. Mai 2022, 12:23:01 CEST schrieb Uwe Kleine-K=F6n=
ig:
> > > > > > > See
> > > > > > > https://lore.kernel.org/linux-pwm/20180806155129.cjcc7okmwtau=
jf4
> > > > > > > 3@pe
> > > > > > > ngutronix.de/ for one of the previous discussions.
> > > > > >=20
> > > > > > Thanks for the link. I took a look into it. I'm on your side he=
re,
> > > > > > IMHO
> > > > > > pwm_disable() implies that the PWM perphery is disabled, includ=
ing
> > > > > > any
> > > > > > clocks or powerdomain. This is what pwm-imx27 actually does. Th=
is
> > > > > > might lead to a, probably platform dependent, (undefined?) state
> > > > > > of
> > > > > > the PWM output pin. This implies it is not possible to disable =
the
> > > > > > PWM periphery for inverted signals, if the disabled state is not
> > > > > > the
> > > > > > inactive level. You know all about it already.
> > > > > > Then again from pwm-fan side I want be able to disable the FAN,
> > > > > > turning of
> > > > > > regulator and PWM, so powersaving is possible. That's what this
> > > > > > patch
> > > > > > is
> > > > > > about. This is similar also what pwm_bl is doing.
> > > > > > Independent of the exact semantics, it makes sense to disable t=
he
> > > > > > regulator in pwm-fan as well when the fan shall be disabled.
> > > > >=20
> > > > > There are fans which never stop if pwm=3D=3D0, such as some CPU f=
ans. I
> > > > > don't
> > > >=20
> > > > I assume with pwm=3D=3D0 you actually mean duty_cycle =3D=3D 0?
> > >=20
> > > Correct. The "pwm" attribute sets the duty cycle.
> > >=20
> > > > > think it is a good idea to force those off by turning off their
> > > > > power.
> > > > > The
> > > > > problem in the driver is that it treats pwm=3D=3D0 as "disable pw=
m", not
> > > > > as
> > > > > "set pwm output to 0", Part of the probem may be that the ABI
> > > > > doesn't
> > > > > have
> > > > > a good representation for "disable pwm output", which is what is
> > > > > really
> > > > > wanted/needed here.
> > > >=20
> > > > Disable pwm output =3D=3D set pwm output to High-Z? Not all PWMs ar=
e able
> > > > to
> > > > provide that.
> > >=20
> > > It is up to us to define whate it means exactly. If you are ok that "=
set
> > > duty cycle to 0" reflects "set duty cycle to 0, disable pwm, and turn
> > > off
> > > regulator", I would hope that you are ok with using the _enable
> > > attribute
> > > to do the same and leaving pwm=3D=3D0 to do what it is supposed to do=
, ie to
> > > keep pwm control enabled and set the duty cycle to 0.
> >=20
> > Just to make sure to be on the same side and summarize a bit. What you
> > mean is to add a new sysfs attribute to pwm-fan driver which controls
> > what pwm_duty=3D=3D0 implies. I would suggest to name is 'keep_pwm_enab=
led'
> > (but I am open for other suggestions) with the following meaning:
> > 1 - pwm_duty=3D=3D0 just means that. Set PWM duty to 0 and keep PWM (an=
d fan
> > regulator) enabled.
> >=20
> > 0 - pwm_duty=3D=3D0 means that the PWM duty is set to 0, PWM is disable=
d and
> > any PWM fan regulator is disabled as well.
>=20
> I'm not convinced. A property that is called "keep_pwm_enabled"
> shouldn't have any effect on the regulator. Maybe we need two
> properties, one for the PWM and one for the regulator?

Good point, that name might be misleading. 'keep_fan_enabled' or=20
'keep_device_enabled' comes to might mind right now. The intention is to=20
switch both PWM and regulator simultaneously, or not.
But having two orthogonal properties don't make sense to me.

regulator |   pwm   | comment
=2D---------+---------+--------
 disable  | disable | keep_device_enabled=3D0
 disable  |  enable | does not make sense for me.
 enable   | disable | Current state, which is not correct in some cases
 enable   |  enable | keep_device_enabled=3D1

That's why I would keep a single property, but I might be missing something.
If there is no regulator at all, then keep_device_enabled=3D0 is the same a=
s=20
what currently happens.

> > With this it is up to the administrator to provide the correct setting =
for
> > this attribute as it highly depends on the actual hardware and/or usage.
>=20
> I wonder if that is a devicetree (or firmware) property instead of
> a sysfs knob.
>=20
> A related problem is that there is no official definition for the PWM
> framework what a consumer can expect from a disabled PWM, and some have
> adopted the expectation "constant inactive output" as this is what
> several lowlevel implementations provide.

I guess there are examples for both a) and b). pwm_bl disables both PWM and=
=20
regulator in pwm_backlight_power_off(). AFAICS imx6dl-yapp4-common.dtsi=20
assumes pwm duty 0 means to disable both regulator and PWM, due to inverted=
=20
polarity and pwm-imx27 specific behavior.

> The two obvious candidates for such an expectation are:
>=20
>  a) emit the inactive level
>  b) no guarantees about the output
>=20
> I think there should be an explicit definition and which of them is
> picked has an influence on the decision how to properly model a PWM fan.
> (If you say now the design of a device tree model shouldn't depend on
> what the Linux PWM framework considers as right behaviour for a disabled
> PWM, you're right. But you have to have some concept of "disabled PWM"
> and the thoughts to pick one definition or the other are the same, so
> it's sensible to come to the same conclusion for both formally different
> questions.)
>=20
> I'm convinced that b) is the sane way to pick. The reasons are:
>=20
>  - Some hardware cannot be disabled while emitting a constant 0 or 1.
>  - There is already a way for consumers to express: I want a constant
>    inactive output. (i.e. .duty_cycle =3D 0, .enabled =3D 1, .period =3D =
$big)

Assuming b) for this driver has the benefit that a) can also be implemented=
=20
using the above mentioned knob. This configuration option is apparently nee=
ded=20
anyway to specify if the PWM and regulator can be turned off or need to be=
=20
kept enabled. IMHO if the PWM and regulator can be turned off, it should be=
=20
possible to do so.

> When adopting b) there is some expressiveness missing though and that
> has to do with transitions to new configurations. If a PWM runs at 100%
> relative duty cycle (i.e. .duty_cycle =3D=3D .period) and the consumer th=
en
> calls
>=20
> 	pwm_apply(mypwm, {.duty_cycle =3D 0, .period =3D 5000, .enabled =3D true=
=20
})
>=20
> and some time later
>=20
> 	pwm_apply(mypwm, {.duty_cycle =3D 5000, .period =3D 5000, .enabled =3D=20
true })
>=20
> they might expect that the PWM is low for a duration that is a multiple
> of 5ms. However I think that doesn't have a practical relevance and
> quite a few PWM hardware implementations cannot complete a period on a
> configuration change anyhow. So I believe it's safe to disable a PWM
> after
>=20
> 	pwm_apply(mypwm, {.duty_cycle =3D 0, .period =3D 5000, .enabled =3D true=
=20
})
>=20
> *iff* it provides a constant inactive output. To fix that, we'd have to
> distinguish between "sync" and "async" configuration updates. However I
> see no need to do that now, as it doesn't solve a real life problem.

When adapting b) it should not matter whether a constant inactive output is=
=20
provided. But maybe I didn't get your point here :/

> When adopting a) however a PWM that doesn't maintain an inactive output
> when disabled, must not be disabled in such a case (so we'd actually
> need to do
>=20
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -280,7 +280,13 @@ static int pwm_imx27_apply(struct pwm_chip *chip,
> struct pwm_device *pwm, cr |=3D FIELD_PREP(MX3_PWMCR_POUTC,
>  				MX3_PWMCR_POUTC_INVERTED);
>=20
> -	if (state->enabled)
> +	/*
> +	 * When the EN bit is not set, the hardware emits a constant low=20
output.
> +	 * There is no formal definition about the right behaviour, but=20
some
> +	 * consumers expect an inactive output from a disabled PWM. So only
> +	 * clear EN if normal polarity is configured.
> +	 */
> +	if (state->enabled || state->polarity =3D=3D PWM_POLARITY_INVERSED)
>  		cr |=3D MX3_PWMCR_EN;
>=20
>  	writel(cr, imx->mmio_base + MX3_PWMCR);
>=20
> for the imx27 case[1]). So the downside of adopting a) is that there is
> no way for the lowlevel driver to know that it can safely disable the
> hardware and so safe some power.

=46rom my point of view when a state->enable=3Dfalse is applied, the PWM sh=
ould be=20
disabled regardless of any polarity configuration. As apparently not every =
PWM=20
controller can provide an inactive output level in disabled state this need=
s=20
to be handled in an upper layer, in this case pwm-fan.
The important thing then to know is whether disabling PWM can be done safel=
y.

Best regards,
Alexander



