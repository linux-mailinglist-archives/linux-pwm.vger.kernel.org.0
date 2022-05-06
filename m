Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C676151D782
	for <lists+linux-pwm@lfdr.de>; Fri,  6 May 2022 14:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386696AbiEFM1B (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 May 2022 08:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243253AbiEFM1A (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 May 2022 08:27:00 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40C027B07;
        Fri,  6 May 2022 05:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1651839796; x=1683375796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ce6Cy9AT/qbJXKX4tVMf6+Dzdy8lGTUQCjrCpxERytY=;
  b=qGTPAsKHyTd2ueqMDZFvAhQKcFgXW6bZdDNzKxVi+aBv9W+nemyMNX80
   A9ZMp0BiLUmHMRt/SYqKIjsk2Yv0YNuvBGHEGqLQJrdj5HXduERIz4vdm
   bvyeWPcZwo3vCdDjCQTXg/t76ESkg2/bhTDrJEG5sDk48ftVaXjmjmXhR
   kBZaQZmPGqZpuC5f5RBKwNYoEZWE/5fTmdFAaiZvKMkq8cD9IXM+uMANZ
   0bmyuDCal9Cjua83qaiF1qksHjNJjnZ5vdkWuquQqkgebDUG8Xkr4oeV+
   KfxOIs5I3XnYNKDLyzy1HidSxSJ4XA07CTFeIFGLH1/JKOroUF1IDrywT
   g==;
X-IronPort-AV: E=Sophos;i="5.91,203,1647298800"; 
   d="scan'208";a="23721709"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 06 May 2022 14:23:14 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 06 May 2022 14:23:14 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 06 May 2022 14:23:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1651839794; x=1683375794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ce6Cy9AT/qbJXKX4tVMf6+Dzdy8lGTUQCjrCpxERytY=;
  b=gT8kcLYOKIv2xSA1Vzo5gqnpLcZoFTLm62MAnt4t+kQOMwPDiFlL1rz1
   WbV1QqBTB+dN71WU9rbW4zQ28sDpa7bGIMS9UWlo2D2RJOST9hbP/+jxu
   wPkAGcZCJ1VD1vJbcH4x59fjVkzt92S6LL6u3hkvuinJ/SLQsYqvd/Chm
   PgQRDf3L8I7nrweXuFsO72NsaK4+rQqbfGG8GyDKRUAonmU3/DJmS2WLF
   sJzI7eiWiTcFBf56qJcMZxF4ANJ1PdvbfDxYz7NWL/G8OGp0GaQ5gKXzp
   tYTten815N6BV5ejj4zEfgcOKdY2PGd5ljXqg2Yd7NH1z8m6BolTzb21q
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,203,1647298800"; 
   d="scan'208";a="23721708"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 May 2022 14:23:13 +0200
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id AA220280070;
        Fri,  6 May 2022 14:23:13 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: (EXT) Re: (EXT) Re: (EXT) Re: [PATCH v2 1/1] hwmon: pwm-fan: dynamically switch regulator
Date:   Fri, 06 May 2022 14:23:11 +0200
Message-ID: <3417990.V25eIC5XRa@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220506102301.my2tsn7kfldwqtll@pengutronix.de>
References: <20220504124551.1083383-1-alexander.stein@ew.tq-group.com> <2371611.jE0xQCEvom@steina-w> <20220506102301.my2tsn7kfldwqtll@pengutronix.de>
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

Am Freitag, 6. Mai 2022, 12:23:01 CEST schrieb Uwe Kleine-K=F6nig:
> * PGP Signed by an unknown key
>=20
> On Fri, May 06, 2022 at 10:35:21AM +0200, Alexander Stein wrote:
> > Am Freitag, 6. Mai 2022, 10:20:01 CEST schrieb Uwe Kleine-K=F6nig:
> > > > Old Signed by an unknown key
> > >=20
> > > Hello,
> > >=20
> > > On Fri, May 06, 2022 at 09:15:55AM +0200, Alexander Stein wrote:
> > > > Am Freitag, 6. Mai 2022, 00:00:37 CEST schrieb Guenter Roeck:
> > > > > On Wed, May 04, 2022 at 02:45:51PM +0200, Alexander Stein wrote:
> > > > > > From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> > > > > >=20
> > > > > > A pwm value equal to zero is meant to switch off the pwm
> > > > > > hence also switching off the fan. Currently the optional
> > > > > > regulator is always on. When using this driver on boards
> > > > > > with an inverted pwm signal polarity this can cause running
> > > > > > the fan at maximum speed when setting pwm to zero.
> > > > >=20
> > > > > The appropriate solution in this case would be to tell the
> > > > > software that the pwm is inverted. Turning off the regulator
> > > > > in that situation is a bad idea since setting the pwm value to
> > > > > 1 would set it to almost full speed. That does not really make
> > > > > sense.
> > > >=20
> > > > The pwm-fan driver is already configured for inverted PWM (ommited
> > > > some
> > > > properties for shortness):
> > > > fan0: pwm-fan {
> > > >=20
> > > > 	compatible =3D "pwm-fan";
> > > > 	fan-supply =3D <&reg_pwm_fan>;
> > > > 	pwms =3D <&pwm3 0 40000 PWM_POLARITY_INVERTED>;
> > > > 	cooling-levels =3D <0 32 64 128 196 240>;
> > > >=20
> > > > [...]
> > > > };
> > > >=20
> > > > The problem here is that the pwm-fan driver currently enables the
> > > > regulator
> > > > unconditionally, but the PWM only when the fan is enabled, refer to
> > > > __set_pwm(). This results in a fan at full speed when pwm-fan is id=
le,
> > > > as
> > > > pwm state is not enabled.
> > >=20
> > > Which PWM driver are you using?
> >=20
> > It's pwm-imx27 on a imx8mp based board.
>=20
> This is one of the known offenders.
>=20
> > > There is an implicit assumption in some PWM consumers that a disabled
> > > PWM emits the inactive level. However not all PWMs do this. Is this s=
uch
> > > a case?
> >=20
> > Oh, I was not aware of that assumption. As far I can tell, this assumpt=
ion
> > might actually be violated in pwm-imx27.
>=20
> The pwm-imx27 driver is a known offender.
>=20
> IMHO the problem is that there is no properly documented definition what
> "disabled" means for a PWM. I had some discussions about that in the
> past with Thierry, but with no agreement. Either we have do define that
> the output of a PWM is undefined when it's disabled (then the pwm-fan
> needs fixing) or the output must be the inactive level (then the
> pwm-imx27 must be fixed to not unset the EN bit when configured for an
> inverted polarity). In my eyes the first is the sensible thing to do.
>=20
> See
> https://lore.kernel.org/linux-pwm/20180806155129.cjcc7okmwtaujf43@pengutr=
oni
> x.de/ for one of the previous discussions.

Thanks for the link. I took a look into it. I'm on your side here, IMHO=20
pwm_disable() implies that the PWM perphery is disabled, including any cloc=
ks=20
or powerdomain. This is what pwm-imx27 actually does. This might lead to a,=
=20
probably platform dependent, (undefined?) state of the PWM output pin.
This implies it is not possible to disable the PWM periphery for inverted=20
signals, if the disabled state is not the inactive level. You know all abou=
t=20
it already.
Then again from pwm-fan side I want be able to disable the FAN, turning of=
=20
regulator and PWM, so powersaving is possible. That's what this patch is=20
about. This is similar also what pwm_bl is doing.
Independent of the exact semantics, it makes sense to disable the regulator=
 in=20
pwm-fan as well when the fan shall be disabled.

> > If state->enabled=3D=3Dfalse then the EN Bit in PWMCR is not set which =
most
> > probably renders the output polarity in POUTC as inactive.
>=20
> It drives the output to 0 which in the inverted polarity case is a 100%
> relative duty.

Thanks for confirmation, this matches my observations.

Best regards,
Alexander



