Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD31B7914D
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2019 18:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfG2QpX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jul 2019 12:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfG2QpW (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 29 Jul 2019 12:45:22 -0400
Received: from localhost (lpr83-1-88-168-111-231.fbx.proxad.net [88.168.111.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2248206A2;
        Mon, 29 Jul 2019 16:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564418721;
        bh=x+aqiC/5J6cLRqB5rlt0xIXHK2pvRJY+eBKePLiGn7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cmypc6YcpSic4RB5SNHXuEL2hvJ1i959kKLp5fSR2JBZ/YiIpnuaCvXPHqhKHUh+t
         e3bB7LrJRRTjCMLIrwmoPdP+ziiPNqcxnkj5iOizdBCFhO1GI+NKQX8ox9cMW3ipbK
         28ReKNhep3bbt5pMbDMTBhyNsPtjRu/hoIqjJahM=
Date:   Mon, 29 Jul 2019 18:45:16 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        mark.rutland@arm.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org, wens@csie.org, robh+dt@kernel.org,
        thierry.reding@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/6] pwm: sun4i: Add a quirk for bus clock
Message-ID: <20190729164516.yxfgj2zd3d5ii4c4@flea.home>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-4-jernej.skrabec@siol.net>
 <20190729063825.wxfky6nswcru26g7@pengutronix.de>
 <4022372.WfP88Fa4Lu@jernej-laptop>
 <20190729161435.5bnj3ikocsyep4dd@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="szfghxy2ac5dvf2h"
Content-Disposition: inline
In-Reply-To: <20190729161435.5bnj3ikocsyep4dd@pengutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--szfghxy2ac5dvf2h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2019 at 06:14:35PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Jernej,
>
> On Mon, Jul 29, 2019 at 05:48:36PM +0200, Jernej =C5=A0krabec wrote:
> > Dne ponedeljek, 29. julij 2019 ob 08:38:25 CEST je Uwe Kleine-K=C3=B6nig
> > napisal(a):
> > > Hello,
> > >
> > > On Fri, Jul 26, 2019 at 08:40:42PM +0200, Jernej Skrabec wrote:
> > > > H6 PWM core needs bus clock to be enabled in order to work.
> > > >
> > > > Add a quirk for it.
> > > >
> > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > ---
> > > >
> > > >  drivers/pwm/pwm-sun4i.c | 15 +++++++++++++++
> > > >  1 file changed, 15 insertions(+)
> > > >
> > > > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > > > index 1b7be8fbde86..7d3ac3f2dc3f 100644
> > > > --- a/drivers/pwm/pwm-sun4i.c
> > > > +++ b/drivers/pwm/pwm-sun4i.c
> > > > @@ -72,6 +72,7 @@ static const u32 prescaler_table[] =3D {
> > > >
> > > >  };
> > > >
> > > >  struct sun4i_pwm_data {
> > > >
> > > > +	bool has_bus_clock;
> > > >
> > > >  	bool has_prescaler_bypass;
> > > >  	bool has_reset;
> > > >  	unsigned int npwm;
> > > >
> > > > @@ -79,6 +80,7 @@ struct sun4i_pwm_data {
> > > >
> > > >  struct sun4i_pwm_chip {
> > > >
> > > >  	struct pwm_chip chip;
> > > >
> > > > +	struct clk *bus_clk;
> > > >
> > > >  	struct clk *clk;
> > > >  	struct reset_control *rst;
> > > >  	void __iomem *base;
> > > >
> > > > @@ -382,6 +384,16 @@ static int sun4i_pwm_probe(struct platform_dev=
ice
> > > > *pdev)>
> > > >  		reset_control_deassert(pwm->rst);
> > > >
> > > >  	}
> > > >
> > > > +	if (pwm->data->has_bus_clock) {
> > > > +		pwm->bus_clk =3D devm_clk_get(&pdev->dev, "bus");
> > >
> > > Similar to my suggestion in patch 2: I'd use devm_clk_get_optional() =
and
> > > drop struct sun4i_pwm_data::has_bus_clock.
> >
> > This one is not so simple. This patch has incorrect logic. Correct logi=
c would
> > be to use "devm_clk_get(&pdev->dev, NULL)" for variants without bus clo=
ck as
> > it is done already and "devm_clk_get(&pdev->dev, "bus")" and
> > "devm_clk_get(&pdev->dev, "mod")" for variants with bus clock.
>
> Then maybe something like the following?:
>
> 	busclk =3D devm_clk_get_optional(..., "bus");
> 	modclk =3D devm_clk_get_optional(..., "mod");
>
> 	/*
> 	 * old dtbs might have a single clock but no clock names. Fall
> 	 * back to this for compatibility reasons.
> 	 */
> 	if (!modclk) {
> 		modclk =3D devm_clk_get(..., NULL);
> 	}

Again, there's nothing optional about these clocks. You need a
particular set of clocks for a given generation, and a separate set of
them on another generation of SoCs.

It really isn't about DT validation. We're really making sure that the
device can be operational. It's as much of a validation step than
making sure we have mapped registers (reg), or an interrupt if we had
any.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--szfghxy2ac5dvf2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXT8inAAKCRDj7w1vZxhR
xfAvAQDPD/W10siMsbxXt0TnODSzxIn/7DF49wiKOuWZz6OwFwEAnwlydOCmRVBw
8J0s2aXuCVfbyJpDqk/FcreSk6jcPQE=
=dYSs
-----END PGP SIGNATURE-----

--szfghxy2ac5dvf2h--
