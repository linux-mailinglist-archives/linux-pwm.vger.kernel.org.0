Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787B1552B34
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jun 2022 08:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346095AbiFUGlr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 21 Jun 2022 02:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346087AbiFUGlq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 21 Jun 2022 02:41:46 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97BF18E10;
        Mon, 20 Jun 2022 23:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1655793702; x=1687329702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BZksM27YizkujSkjCyARUVXlm0iWUJX1Mxr22hSXOMI=;
  b=bxT3eRp3FeqN7jvExEqpvs7xNAJ2kW3/Bnga4onYsm8ZkiYDR43oCYJW
   zIBIWqyueT4/RbOYKPmiZKYRc7yASeJBqoGjJclv6k+/AafCdhOe0ZJNd
   Eucofnf5X4O/SwpxMjClfJIGupbVSbhlFey7GKnNEWHRk4FnlQtbKFCTG
   OfAqxhHr9XiFsGW0+4fJQHDg8LuLC5XtzKQMyKvGRhVxMu3c3nwxDAVh7
   CxRlkLJ9JHflRtvDmio+J9JynsLLL8OryqAz1NQAs5f+JHu2nl7bxo/io
   lCVMCp6sLKMUrMxWFtmlj5cU5TYvosynMpN0m8HNd3uBTXViS+GtEOSzF
   A==;
X-IronPort-AV: E=Sophos;i="5.92,209,1650924000"; 
   d="scan'208";a="24563675"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 21 Jun 2022 08:41:39 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 21 Jun 2022 08:41:39 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 21 Jun 2022 08:41:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1655793699; x=1687329699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BZksM27YizkujSkjCyARUVXlm0iWUJX1Mxr22hSXOMI=;
  b=mRiBx1bGwW+R4sUTqpowouzwBXrFQMRlefXdXIrTLmGsyQ32wCoqqKoq
   UVXOuKNWYz22/F5nPTWdagQxy4Y3Q/CtoEOm/LGdGWny+rW1O2LiCWzFc
   PBRU7QqAUsBprupyuRiIRT2tM/FaR4fuPVDXhMZEiqsEnn6ah5kgp73Fv
   BdAXR5Q4PRkD4dOpS/aTCtWFVn2JEp1mbzdJBr9xfnQTq3ROIkK31QGYd
   wHBElqwbk2CwnVuA7mv+1f4Rv0P550xCzx04LpyzqyQVJcEFI3LwqpqTi
   /H4IPtnWOUaJ/eGCm7qY66oYHr9+7/ZGuNHnCLcOX9J4VRhyLiKRQoWeh
   A==;
X-IronPort-AV: E=Sophos;i="5.92,209,1650924000"; 
   d="scan'208";a="24563674"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 21 Jun 2022 08:41:39 +0200
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 9CDF8280056;
        Tue, 21 Jun 2022 08:41:39 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH v4 6/6] hwmon: pwm-fan: Remove internal duplicated pwm_state
Date:   Tue, 21 Jun 2022 08:41:37 +0200
Message-ID: <13043200.uLZWGnKmhe@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <aa6f8c6c-6d8f-6d23-f035-00d27e7ec0af@roeck-us.net>
References: <20220523110513.407516-1-alexander.stein@ew.tq-group.com> <4715301.GXAFRqVoOG@steina-w> <aa6f8c6c-6d8f-6d23-f035-00d27e7ec0af@roeck-us.net>
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

Hello Guenter, Uwe,

Am Montag, 23. Mai 2022, 16:18:57 CEST schrieb Guenter Roeck:
> On 5/23/22 06:55, Alexander Stein wrote:
> > Hi Uwe,
> >=20
> > Am Montag, 23. Mai 2022, 14:46:14 CEST schrieb Uwe Kleine-K=F6nig:
> >> * PGP Signed by an unknown key
> >>=20
> >> Hello,
> >>=20
> >> On Mon, May 23, 2022 at 01:05:13PM +0200, Alexander Stein wrote:
> >>> Each pwm device has already a pwm_state. Use this one instead of
> >>> managing an own copy of it.
> >>>=20
> >>> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> >>> ---
> >>>=20
> >>>   drivers/hwmon/pwm-fan.c | 49 +++++++++++++++++++++++++-------------=
=2D--
> >>>   1 file changed, 30 insertions(+), 19 deletions(-)
> >>>=20
> >>> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> >>> index e5d4b3b1cc49..e0ce81cdf5e0 100644
> >>> --- a/drivers/hwmon/pwm-fan.c
> >>> +++ b/drivers/hwmon/pwm-fan.c
> >>> @@ -40,7 +40,6 @@ struct pwm_fan_ctx {
> >>>=20
> >>>   	struct mutex lock;
> >>>   	struct pwm_device *pwm;
> >>>=20
> >>> -	struct pwm_state pwm_state;
> >>>=20
> >>>   	struct regulator *reg_en;
> >>>   	enum pwm_fan_enable_mode enable_mode;
> >>>   	bool regulator_enabled;
> >>>=20
> >>> @@ -142,7 +141,7 @@ static int pwm_fan_switch_power(struct pwm_fan_ctx
> >>> *ctx, bool on)>
> >>>=20
> >>>   static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
> >>>   {
> >>>=20
> >>> -	struct pwm_state *state =3D &ctx->pwm_state;
> >>> +	struct pwm_state state;
> >>>=20
> >>>   	int ret;
> >>>   =09
> >>>   	if (ctx->enabled)
> >>>=20
> >>> @@ -154,8 +153,9 @@ static int pwm_fan_power_on(struct pwm_fan_ctx *c=
tx)
> >>>=20
> >>>   		return ret;
> >>>   =09
> >>>   	}
> >>>=20
> >>> -	state->enabled =3D true;
> >>> -	ret =3D pwm_apply_state(ctx->pwm, state);
> >>> +	pwm_get_state(ctx->pwm, &state);
> >>> +	state.enabled =3D true;
> >>> +	ret =3D pwm_apply_state(ctx->pwm, &state);
> >>>=20
> >>>   	if (ret) {
> >>>   =09
> >>>   		dev_err(ctx->dev, "failed to enable PWM\n");
> >>>   		goto disable_regulator;
> >>=20
> >> IMHO this isn't a net win. You trade the overhead of pwm_get_state
> >> against some memory savings. I personally am not a big fan of the
> >> get_state + modify + apply codeflow. The PWM framework does internal
> >> caching of the last applied state, but the details are a bit ugly. (i.=
e.
> >> pwm_get_state returns the last applied state, unless there was no state
> >> applied before. In that case it returns what .get_state returned during
> >> request time, unless there is no .get_state callback ... not sure if t=
he
> >> device tree stuff somehow goes into that, didn't find it on a quick
> >> glance)
> >>=20
> >> Also there is a (small) danger, that pwm_state contains something that
> >> isn't intended by the driver, e.g. a wrong polarity. So I like the
> >> consumer to fully specify what they intend and not use pwm_get_state().
> >=20
> > Ah, I see. I have no hard feelings for this patch. I just wondered why =
the
> > PWM state is duplicated. and wanted to get rid of it. If there is a
> > specific reason for this, I'm ok with that.
>=20
> I don't see the value of continuous runtime overhead to save a few bytes =
of
> data, so I don't see a reason to _not_ cache the state locally. This is
> similar to caching a clock frequency locally instead of calling the clock
> subsystem again and again to read it. Sure, nowadays CPUs are more powerf=
ul
> than they used to be, but I don't see that as reason or argument for
> wasting their power.

Ok, seems reasonable. I'm fully fine with patch 6 being dropped. What about=
=20
the other patches?

Best regards,
Alexander



