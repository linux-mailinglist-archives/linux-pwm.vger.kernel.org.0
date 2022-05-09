Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A120F51F5D9
	for <lists+linux-pwm@lfdr.de>; Mon,  9 May 2022 09:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiEIH4v (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 May 2022 03:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiEIHoQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 May 2022 03:44:16 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E09C1C94FC;
        Mon,  9 May 2022 00:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1652082022; x=1683618022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NH2bCpAfSF6dzBC2s1g5mVBQnvaoxXYmplus3U1xzaA=;
  b=OKW3fiKqfPh/3v8ewYLaWmfkICRAiju1Uh19p7PZSl8nN4oFVBLt1MDJ
   Hv75K/sOFTP4n5smu4wbRGBbYRlXqW7b4CxJImfx4gewEsyTEP9i7/DEe
   F+N11aEj+fvQ9qElzGmGWVbJSM0NR/aamJ6lq13iBO0qVflwSNClx/1ZE
   Rj4szTHphPTHQr11KFw3YHOMc3ykvzTTsNOmclOwSShNI6UxKkNcS5gsJ
   2EWgpMyUDNR2RhWm4YJrim2wVMQnhSLCqGwfVUUDKVgW/CLpvCR5neT1D
   PfGBYMgsMq7mRP+5MALIX9DPaS4Mo5iV99yNpsmb4FI/q1r8KkXd3bAsT
   A==;
X-IronPort-AV: E=Sophos;i="5.91,210,1647298800"; 
   d="scan'208";a="23744985"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 09 May 2022 09:39:18 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 09 May 2022 09:39:18 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 09 May 2022 09:39:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1652081958; x=1683617958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NH2bCpAfSF6dzBC2s1g5mVBQnvaoxXYmplus3U1xzaA=;
  b=ZU/FCGEiaqVb78fdG2hPVXVSoe6+ky7AWR1Powq7jcCdLihuYIHz4F1a
   1g3Wzz2OhBmTI3nBfvsJ+Akjr+RZLXPHEmpxMekD8lOUlZO7h/LWsj/Xa
   rbWKY/2oa2XOccgiIVpZMnaZihgyHjK0HBKjk6UiAmCYUD+Jf+ZaeaSGR
   iiXcbU6Lv/zoBskZiqsQQdXUtMC2u9UM22lWC4fyVZPP2FLB/kl3/Zy+3
   u/GlxJnc4zsJA8+XjnQ7Ncb3NojJQo8w8SS6zHX+H22Rr4dik/ohPTGxZ
   A/th8cj+MZdcI9QeIgwgyG2+Nn05/qHRSKUYEP4zCevSNl1hLZnT6wC5f
   g==;
X-IronPort-AV: E=Sophos;i="5.91,210,1647298800"; 
   d="scan'208";a="23744984"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 May 2022 09:39:18 +0200
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 27F03280070;
        Mon,  9 May 2022 09:39:18 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: (EXT) Re: (EXT) Re: (EXT) Re: [PATCH v2 1/1] hwmon: pwm-fan: dynamically switch regulator
Date:   Mon, 09 May 2022 09:39:15 +0200
Message-ID: <2184650.iZASKD2KPV@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220506183124.GA2997799@roeck-us.net>
References: <20220504124551.1083383-1-alexander.stein@ew.tq-group.com> <20220506142913.vbddyvkmhuvfd5o5@pengutronix.de> <20220506183124.GA2997799@roeck-us.net>
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

Am Freitag, 6. Mai 2022, 20:31:24 CEST schrieb Guenter Roeck:
> On Fri, May 06, 2022 at 04:29:13PM +0200, Uwe Kleine-K=F6nig wrote:
> > [Dropped Bartlomiej Zolnierkiewicz from Cc:; my mailer daemon claims the
> > email address doens't exist.]
> >=20
> > Hello Guenter,
> >=20
> > On Fri, May 06, 2022 at 07:12:44AM -0700, Guenter Roeck wrote:
> > > On Fri, May 06, 2022 at 02:23:11PM +0200, Alexander Stein wrote:
> > > > Am Freitag, 6. Mai 2022, 12:23:01 CEST schrieb Uwe Kleine-K=F6nig:
> > > > > See
> > > > > https://lore.kernel.org/linux-pwm/20180806155129.cjcc7okmwtaujf43=
@pe
> > > > > ngutronix.de/ for one of the previous discussions.
> > > >=20
> > > > Thanks for the link. I took a look into it. I'm on your side here,
> > > > IMHO
> > > > pwm_disable() implies that the PWM perphery is disabled, including =
any
> > > > clocks or powerdomain. This is what pwm-imx27 actually does. This
> > > > might lead to a, probably platform dependent, (undefined?) state of
> > > > the PWM output pin. This implies it is not possible to disable the
> > > > PWM periphery for inverted signals, if the disabled state is not the
> > > > inactive level. You know all about it already.
> > > > Then again from pwm-fan side I want be able to disable the FAN,
> > > > turning of
> > > > regulator and PWM, so powersaving is possible. That's what this pat=
ch
> > > > is
> > > > about. This is similar also what pwm_bl is doing.
> > > > Independent of the exact semantics, it makes sense to disable the
> > > > regulator in pwm-fan as well when the fan shall be disabled.
> > >=20
> > > There are fans which never stop if pwm=3D=3D0, such as some CPU fans.=
 I
> > > don't
> >=20
> > I assume with pwm=3D=3D0 you actually mean duty_cycle =3D=3D 0?
>=20
> Correct. The "pwm" attribute sets the duty cycle.
>=20
> > > think it is a good idea to force those off by turning off their power.
> > > The
> > > problem in the driver is that it treats pwm=3D=3D0 as "disable pwm", =
not as
> > > "set pwm output to 0", Part of the probem may be that the ABI doesn't
> > > have
> > > a good representation for "disable pwm output", which is what is real=
ly
> > > wanted/needed here.
> >=20
> > Disable pwm output =3D=3D set pwm output to High-Z? Not all PWMs are ab=
le to
> > provide that.
>=20
> It is up to us to define whate it means exactly. If you are ok that "set
> duty cycle to 0" reflects "set duty cycle to 0, disable pwm, and turn off
> regulator", I would hope that you are ok with using the _enable attribute
> to do the same and leaving pwm=3D=3D0 to do what it is supposed to do, ie=
 to
> keep pwm control enabled and set the duty cycle to 0.

Just to make sure to be on the same side and summarize a bit. What you mean=
 is=20
to add a new sysfs attribute to pwm-fan driver which controls what pwm_duty=
=3D=3D0=20
implies. I would suggest to name is 'keep_pwm_enabled' (but I am open for=20
other suggestions) with the following meaning:
1 - pwm_duty=3D=3D0 just means that. Set PWM duty to 0 and keep PWM (and fa=
n=20
regulator) enabled.

0 - pwm_duty=3D=3D0 means that the PWM duty is set to 0, PWM is disabled an=
d any=20
PWM fan regulator is disabled as well.

=46or pwm_duty!=3D0 this setting is irrelevant. Having the default to be '1=
' seems=20
sensible in order to not brake boards as regulator will be kept enabled. PW=
M=20
duty and/or PWM disable is irrelevant as PWM inversion is not yet supported=
=20
properly anyway.

IMHO this should address all the mentioned issues. With 'keep_pwm_enabled=
=3D1'=20
only the duty is set and the regulators are not forced to be disabled. E.g.=
=20
the CPU fans mentioned by Guenter. This is also the case for hardware where=
=20
the regulator is shared or not switchable at all.
On hardware where it is safe to disable the regulator and PWM=20
keep_pwm_enabled=3D0' allows the system to poweroff PWM and powersupply for=
 the=20
fan to improve powersavings.

With this it is up to the administrator to provide the correct setting for=
=20
this attribute as it highly depends on the actual hardware and/or usage.

Best regards,
Alexander



