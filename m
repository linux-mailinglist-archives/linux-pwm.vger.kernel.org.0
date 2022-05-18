Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4983652B2DB
	for <lists+linux-pwm@lfdr.de>; Wed, 18 May 2022 09:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiERGzb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 May 2022 02:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiERGza (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 May 2022 02:55:30 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFB82714C;
        Tue, 17 May 2022 23:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1652856928; x=1684392928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2GWmTywvGXZKo4wTJGwOnrLkBLOm7I5Y8nS00EJHO0s=;
  b=AzsIp02I+Kh6l2siOFeUSOIeYKVTkSUd7iP/70NSiQxo1TNc89mqQj01
   M7wfXBd+fi+LdySuvTuZw53ybD0QXi59jCQTmmudNGXA2WBCPZS1PpozX
   ENEr32Qr4A2AANkldNLIY4NHFFlitikg4P0+vqtpezzrXfAL3qrUobftr
   xZO/JpcrFlgq2JSHmv3wH77fot+koLliON/dpNCKYhtJ48F2WWJ1EY4uN
   s+c+iLwWjSvHr9utvcbNyIiQwP+9l/hSJCfxOw9X+b+Ati8lXHaLet+/6
   ttgayNAuRK+XkoINdKf6KWlHPz9ROCT3P6VUvA1lh4VuKiae4e9aedljD
   w==;
X-IronPort-AV: E=Sophos;i="5.91,234,1647298800"; 
   d="scan'208";a="23937466"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 18 May 2022 08:55:25 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 18 May 2022 08:55:25 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 18 May 2022 08:55:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1652856925; x=1684392925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2GWmTywvGXZKo4wTJGwOnrLkBLOm7I5Y8nS00EJHO0s=;
  b=q8SJJvrjOJwLUiiYNuQY0mI+Ofy6g84NfJUAjcXd/ve+EuPiJ77kUdk7
   1yUxYS522UxRKiF9ZPgrN0hRcjCTPa8tQLVLIeF4FA7uInG8T610ZtubG
   5X8dcWE2QTxcg6gCMUm22m5GYrGaJe/JkTIK447aY2xMVNyyblXK/ILaF
   rsDQ2T2D4h0KS2efzVm/tKGz6xf+9rtPxuUnDiIxjaCSqXBrRf3A69cMG
   yk6LvAyoVgyj3L1BWtmyBDuY0KpJQUSEpMJSUH6AE2ZeU55dCdehxPMUM
   t+0e2L9F+UsZ6PMcwB1sbne5WidSXmaldHofJxEYPt/mGO+a+0NHYG/Em
   A==;
X-IronPort-AV: E=Sophos;i="5.91,234,1647298800"; 
   d="scan'208";a="23937465"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 May 2022 08:55:25 +0200
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 9EE8E280070;
        Wed, 18 May 2022 08:55:25 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH v3 6/6] hwmon: pwm-fan: Add hwmon_pwm_enable attribute
Date:   Wed, 18 May 2022 08:55:23 +0200
Message-ID: <10084894.nUPlyArG6x@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <c8f3e1b3-23e4-1dcb-7da3-e21a01062e9d@roeck-us.net>
References: <20220517142620.1523143-1-alexander.stein@ew.tq-group.com> <20220517165726.trxa7lpz6kluvrg3@pengutronix.de> <c8f3e1b3-23e4-1dcb-7da3-e21a01062e9d@roeck-us.net>
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

Am Dienstag, 17. Mai 2022, 19:32:11 CEST schrieb Guenter Roeck:
> On 5/17/22 09:57, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > [dropping Bartlomiej Zolnierkiewicz from Cc as the address bounces]
> >=20
> > On Tue, May 17, 2022 at 09:32:24AM -0700, Guenter Roeck wrote:
> >> On 5/17/22 07:53, Uwe Kleine-K=F6nig wrote:
> >>> Hello,
> >>>=20
> >>> On Tue, May 17, 2022 at 04:26:20PM +0200, Alexander Stein wrote:
> >>>> This adds the enable attribute which is used to differentiate if PWM
> >>>> duty
> >>>> means to switch off regulator and PWM or to keep them enabled but
> >>>> at inactive PWM output level.
> >>>>=20
> >>>> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> >>>> ---
> >>>>=20
> >>>>    Documentation/hwmon/pwm-fan.rst | 10 ++++
> >>>>    drivers/hwmon/pwm-fan.c         | 95
> >>>>    +++++++++++++++++++++++++++++----
> >>>>    2 files changed, 95 insertions(+), 10 deletions(-)
> >>>>=20
> >>>> diff --git a/Documentation/hwmon/pwm-fan.rst
> >>>> b/Documentation/hwmon/pwm-fan.rst index 82fe96742fee..0083480068d1
> >>>> 100644
> >>>> --- a/Documentation/hwmon/pwm-fan.rst
> >>>> +++ b/Documentation/hwmon/pwm-fan.rst
> >>>> @@ -18,3 +18,13 @@ the hwmon's sysfs interface.
> >>>>=20
> >>>>    The fan rotation speed returned via the optional 'fan1_input' is
> >>>>    extrapolated from the sampled interrupts from the tachometer sign=
al
> >>>>    within 1 second.>>>>=20
> >>>> +
> >>>> +The driver provides the following sensor accesses in sysfs:
> >>>> +
> >>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> +fan1_input	ro	fan tachometer speed in RPM
> >>>> +pwm1_enable	rw	keep enable mode, defines behaviour when=20
pwm1=3D0
> >>>> +			0=3Dswitch off regulator and disable PWM
> >>>> +			1=3Dkeep regulator enabled and set PWM to=20
inactive level
> >>>=20
> >>> Is the pwm1_enable supposed to be set to 0 if that only does the right
> >>> thing if the PWM emits low after pwm_disable()? The question I raised=
 in
> >>> v2 about "what is the meaning of disable?" hasn't evolved, has it?
> >>>=20
> >>> I still think it's unfortunate, that "pwm1_enable" has an effect on t=
he
> >>> regulator.
> >>=20
> >> Trying to understand. Are you saying that you are ok with affecting the
> >> regulator when setting pwm :=3D 0 (even though that doesn't really mean
> >> "disable pwm output"), but not with making the behavior explicit by
> >> using pwm1_enable ?
> >=20
> > Not sure about being ok with affecting the regulator when setting
> > pwm :=3D 0. I don't know enough about pwm-fans to have a strong opinion
> > for that.

In my case (422J fan) just supplying voltage with inactive PWM results in a=
=20
minimum rotation speed. So these two settings are coupled here.

> > Some questions to refine the semantics and my opinion:
> >=20
> > There are fans without a regulator? (I think: yes)
> >=20
> > A fan with a regulator always stops if the regulator is off?
> > (Hmm, there might be problems with shared regulators that only go off
> > when all consumers are off? What about always-on regulators, these don't
> > go off on the last consumer calling disable, right?)

IMHO this is something the system integrator shall manage. Is it possible t=
o=20
disable the regulator? No for shared/always-on ones. In this case stopping =
the=20
fan needs to be done by setting PWM to inactive level and keep regulator on=
=20
(pwm1_enable=3D1). If this results in a minimum rotation speed as it would =
using=20
a 422J, it's pretty much impossible to actually stop the fan in such a syst=
em.

> > Having said that I think the sane behaviour is:
> >=20
> > The intention of pwm :=3D 0 is to stop the fan. So disabling the regula=
tor
> > (if available) sounds right.
>=20
> There are fans (eg at least some CPU fans) which never stop, even with
> pwm=3D0. How do you suggest to handle those ?

If it's impossible to stop the fan from the hardware side (e.g. always-on=20
regulators), then software only can do this much.
Maybe adding those 4 states Uwe mentioned in [1] is not a bad idea. This wa=
y=20
it's possible to configure the exact behavior one would want/need. This als=
o=20
can handle the cases where a disabled PWM has no/wrong defined state.

Best regards
Alexander

[1] https://lore.kernel.org/all/
20220517170658.u3dpe6gglsihh6n6@pengutronix.de/


