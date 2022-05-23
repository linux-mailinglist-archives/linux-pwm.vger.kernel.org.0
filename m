Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B589531204
	for <lists+linux-pwm@lfdr.de>; Mon, 23 May 2022 18:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbiEWNz2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 May 2022 09:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236604AbiEWNz1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 May 2022 09:55:27 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5894156FB2;
        Mon, 23 May 2022 06:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1653314125; x=1684850125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3/ppf4w2Cb7wpU4jY0Cz3XxHBQxGXd+vTOekAQysKuk=;
  b=j+2Y0X/QkJaYWjNDxZbb/wPu7M7rPDz9JFc0Ux7ewuHjXesuhg1LThw7
   EtgtOHiOpS0U01KdXgyUTmwPnzZJh2nRxVqzr95QrZoPgw0WPR6sh0nDt
   VWkU3Rhn7XIN2/fBX3Gi4oOryTtdAR7ko8vUGPz00oohmJNsnaeoQpUZu
   teRa2gr4VMN6NUZUaQwqKI/4hh40iDQNJh5gFSEHnGlwltoU8nlmnbUr8
   dHWKm6w6zJMcfSszgn1gr2PoM+xX/h56T+xq2Lx2IcKsXCYe8WbnJ1F4w
   vtqWbwcxmx9gZiDtgHHNjTq+/zy0s+yaW6m2xUciVE/nfe8ia7rrzeeeN
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647298800"; 
   d="scan'208";a="24036942"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 23 May 2022 15:55:23 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 23 May 2022 15:55:23 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 23 May 2022 15:55:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1653314123; x=1684850123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3/ppf4w2Cb7wpU4jY0Cz3XxHBQxGXd+vTOekAQysKuk=;
  b=B25WS3lbvRBI8vLgym3CH447i8cPuOSFvDV3GoCGXb9LTL8nI8fvPVie
   eSobGPbXv9yEPGdvtDDXCAsM0JITW734CMvKX+hhpNF8kQfIB9zV6tSqT
   8vYJr27c3yqDYezQsPZvjfScwwUDKf1e6TXiFlN+fT82D4LgoOBZAFIFu
   +8+JCyCyQU1zGrqvJLNyj/dMpbKE4bb7YmPHi2hpRHq10UR9n7etU7yqf
   zRnVIfZ+EScGhbhaes39q5KqejcurJurEVUkmbpZT9M6BiTkEGJhaaDVn
   tjRu5PCsvXKZjxkd6n0/4J/Cj6OyAv9xGU24+hzmHrnu2BF7LITqYCgfI
   w==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647298800"; 
   d="scan'208";a="24036941"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 May 2022 15:55:23 +0200
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id E6655280070;
        Mon, 23 May 2022 15:55:22 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH v4 6/6] hwmon: pwm-fan: Remove internal duplicated pwm_state
Date:   Mon, 23 May 2022 15:55:22 +0200
Message-ID: <4715301.GXAFRqVoOG@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220523124614.74hwex5a4eedpitl@pengutronix.de>
References: <20220523110513.407516-1-alexander.stein@ew.tq-group.com> <20220523110513.407516-7-alexander.stein@ew.tq-group.com> <20220523124614.74hwex5a4eedpitl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_CSS_A autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Am Montag, 23. Mai 2022, 14:46:14 CEST schrieb Uwe Kleine-K=F6nig:
> * PGP Signed by an unknown key
>=20
> Hello,
>=20
> On Mon, May 23, 2022 at 01:05:13PM +0200, Alexander Stein wrote:
> > Each pwm device has already a pwm_state. Use this one instead of
> > managing an own copy of it.
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >=20
> >  drivers/hwmon/pwm-fan.c | 49 +++++++++++++++++++++++++----------------
> >  1 file changed, 30 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> > index e5d4b3b1cc49..e0ce81cdf5e0 100644
> > --- a/drivers/hwmon/pwm-fan.c
> > +++ b/drivers/hwmon/pwm-fan.c
> > @@ -40,7 +40,6 @@ struct pwm_fan_ctx {
> >=20
> >  	struct mutex lock;
> >  	struct pwm_device *pwm;
> >=20
> > -	struct pwm_state pwm_state;
> >=20
> >  	struct regulator *reg_en;
> >  	enum pwm_fan_enable_mode enable_mode;
> >  	bool regulator_enabled;
> >=20
> > @@ -142,7 +141,7 @@ static int pwm_fan_switch_power(struct pwm_fan_ctx
> > *ctx, bool on)>=20
> >  static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
> >  {
> >=20
> > -	struct pwm_state *state =3D &ctx->pwm_state;
> > +	struct pwm_state state;
> >=20
> >  	int ret;
> >  =09
> >  	if (ctx->enabled)
> >=20
> > @@ -154,8 +153,9 @@ static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
> >=20
> >  		return ret;
> >  =09
> >  	}
> >=20
> > -	state->enabled =3D true;
> > -	ret =3D pwm_apply_state(ctx->pwm, state);
> > +	pwm_get_state(ctx->pwm, &state);
> > +	state.enabled =3D true;
> > +	ret =3D pwm_apply_state(ctx->pwm, &state);
> >=20
> >  	if (ret) {
> >  =09
> >  		dev_err(ctx->dev, "failed to enable PWM\n");
> >  		goto disable_regulator;
>=20
> IMHO this isn't a net win. You trade the overhead of pwm_get_state
> against some memory savings. I personally am not a big fan of the
> get_state + modify + apply codeflow. The PWM framework does internal
> caching of the last applied state, but the details are a bit ugly. (i.e.
> pwm_get_state returns the last applied state, unless there was no state
> applied before. In that case it returns what .get_state returned during
> request time, unless there is no .get_state callback ... not sure if the
> device tree stuff somehow goes into that, didn't find it on a quick
> glance)
>=20
> Also there is a (small) danger, that pwm_state contains something that
> isn't intended by the driver, e.g. a wrong polarity. So I like the
> consumer to fully specify what they intend and not use pwm_get_state().

Ah, I see. I have no hard feelings for this patch. I just wondered why the =
PWM=20
state is duplicated. and wanted to get rid of it. If there is a specific=20
reason for this, I'm ok with that.

Best regards,
Alexander



