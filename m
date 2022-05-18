Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A949D52B2F1
	for <lists+linux-pwm@lfdr.de>; Wed, 18 May 2022 09:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiERHHB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 May 2022 03:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiERHHA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 May 2022 03:07:00 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519FFA889C;
        Wed, 18 May 2022 00:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1652857618; x=1684393618;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H+hzJvrKetPVEZoJzbpuCq9zdMggKUCx3wXO6f4SVrg=;
  b=Ftwh81G/s/9grp18E7jFR3D3MH7wQgkWvlbAb5vT7fQRzx2J/gM5Jabd
   mmaMpZpsFUolVG4AJp5SDOWjlJcAAt+x+Z3x+vxbYr2ORHAwZObTWSkYh
   f9C36BKlS6qIZ2OI+K6kl8taERvqp76Q/FjWlaqMdv8ErNpSyJmvzP2mB
   92XreQRyrTI6+dTOstn+0JfFieY+WASCFYfk6vSayhmlwplT1F6BV6Y9G
   h72WWY3xbmnqVRrrT6VkbzTbY/w+qY7+BDdiiFDdh36k9NIHoNq+MDrg3
   4Jp4P/5ySc0jgSqdqH6b/obdqgwOb1Em3rluM5YUXVWVCSFNUoO5MVtoD
   A==;
X-IronPort-AV: E=Sophos;i="5.91,234,1647298800"; 
   d="scan'208";a="23937991"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 18 May 2022 09:06:56 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 18 May 2022 09:06:56 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 18 May 2022 09:06:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1652857616; x=1684393616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H+hzJvrKetPVEZoJzbpuCq9zdMggKUCx3wXO6f4SVrg=;
  b=oadaEUfslRSjpArOAs5I4nBQOKACFLieZD5hIAbtzTiIwa5mN2Z6G0bn
   ppvBPEYex610xm9BkFsaMEYTe1oaXMpv3e6qHYQgUTG3zED2v/tZXkLu7
   zJgfEK0qbW7llr4B+3vORwCMr7XFZFGEzuTCax/jh+ci75j3OnQdLPuhd
   rUULnf8atm6bOYcZ501MP+6yuO/ynqvsChB+KzLUZGpfYTdD37Ge1ENQ9
   wZIsFapTmXz2UNTPOBxrXhzNUyfsz3LWCPA7P8s1AgU4H58/s2Zxw7+fn
   CBwthuGHb/wD7PtwhoFpsrJKu0CeXaA2bftSH/HHWqJRBq9GpWsEo6BQF
   g==;
X-IronPort-AV: E=Sophos;i="5.91,234,1647298800"; 
   d="scan'208";a="23937990"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 May 2022 09:06:56 +0200
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 7DB24280070;
        Wed, 18 May 2022 09:06:56 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH v3 6/6] hwmon: pwm-fan: Add hwmon_pwm_enable attribute
Date:   Wed, 18 May 2022 09:06:54 +0200
Message-ID: <3435664.iIbC2pHGDl@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220517170658.u3dpe6gglsihh6n6@pengutronix.de>
References: <20220517142620.1523143-1-alexander.stein@ew.tq-group.com> <355e6efa-dc65-771e-fcc0-2ca774d382de@roeck-us.net> <20220517170658.u3dpe6gglsihh6n6@pengutronix.de>
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

Am Dienstag, 17. Mai 2022, 19:06:58 CEST schrieb Uwe Kleine-K=F6nig:
> * PGP Signed by an unknown key
>=20
> Hello,
>=20
> [dropped Bartlomiej Zolnierkiewicz from Cc:]
>=20
> On Tue, May 17, 2022 at 09:38:56AM -0700, Guenter Roeck wrote:
> > On 5/17/22 07:26, Alexander Stein wrote:
> > > This adds the enable attribute which is used to differentiate if PWM
> > > duty
> > > means to switch off regulator and PWM or to keep them enabled but
> > > at inactive PWM output level.
> > >=20
> > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > ---
> > >=20
> > >   Documentation/hwmon/pwm-fan.rst | 10 ++++
> > >   drivers/hwmon/pwm-fan.c         | 95 +++++++++++++++++++++++++++++-=
=2D--
> > >   2 files changed, 95 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/Documentation/hwmon/pwm-fan.rst
> > > b/Documentation/hwmon/pwm-fan.rst index 82fe96742fee..0083480068d1
> > > 100644
> > > --- a/Documentation/hwmon/pwm-fan.rst
> > > +++ b/Documentation/hwmon/pwm-fan.rst
> > > @@ -18,3 +18,13 @@ the hwmon's sysfs interface.
> > >=20
> > >   The fan rotation speed returned via the optional 'fan1_input' is
> > >   extrapolated from the sampled interrupts from the tachometer signal
> > >   within 1 second.> >=20
> > > +
> > > +The driver provides the following sensor accesses in sysfs:
> > > +
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > +fan1_input	ro	fan tachometer speed in RPM
> > > +pwm1_enable	rw	keep enable mode, defines behaviour when=20
pwm1=3D0
> > > +			0=3Dswitch off regulator and disable PWM
> > > +			1=3Dkeep regulator enabled and set PWM to=20
inactive level
> >=20
> > Unless I am missing something, I think we have (at least) three
> > conditions to handle:
> >=20
> > - regulator disabled (independent of pwm value)
> > - regulator enabled, pwm output disabled if pwm=3D0
> > - regulator enabled, pwm output enabled and set to 0 (or, if inverted,
> >=20
> >   to maximum) if pwm=3D0
>=20
> What is your expectation for a disabled PWM?
> https://lore.kernel.org/linux-pwm/20220517150555.404363-1-u.kleine-koenig=
@pe
> ngutronix.de might be relevant. If you assume that a pwm might output the
> active level after disabling, the case "regulator enabled, pwm output
> disabled if pwm=3D0" sounds wrong.
>=20
> Would "pwm1_disable_on_zero" be a better name than "pwm1_enable"? The
> latter is completely unintuitive to me.

I guess Guenter suggested 'pwm1_enable' as it already exists as a predefine=
d,=20
optional attribute, avoiding adding a new custom attribute.
Reading Documentation/hwmon/w83627ehf.rst or Documentation/hwmon/nzxt-
smart2.rst I get the impression their meaning is pretty unrestricted.
If you are concerned by using 'pwm1_enable', what about 'pwm1_mode'?

> Maybe go for
>=20
>  0 -> keep pwm and regulator on
>  1 -> disable pwm, keep regulator on
>  2 -> keep pwm on, disable regulator
>  3 -> disable pwm and regulator
>=20
> (so one bit for pwm and one for regulator), even if 1 is
> wrong/unusual/dangerous?

I tend to like this approach, as it can handle all combinations. You can=20
decide whether you want to actually shutdown the PWM fan, or keep it enable=
d=20
but without providing any PWM. This can mean the fan still runs at the lowe=
st=20
speed. It also addresses the scenarios where regulator cannot be disabled a=
t=20
all.

Best regards,
Alexander


