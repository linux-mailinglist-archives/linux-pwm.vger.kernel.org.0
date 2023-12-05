Return-Path: <linux-pwm+bounces-301-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BB080552E
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Dec 2023 13:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60DC2B209BB
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Dec 2023 12:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F136341747;
	Tue,  5 Dec 2023 12:50:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDF3C6
	for <linux-pwm@vger.kernel.org>; Tue,  5 Dec 2023 04:50:29 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rAUsd-0001eE-Uv; Tue, 05 Dec 2023 13:50:27 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rAUsd-00DkNW-5L; Tue, 05 Dec 2023 13:50:27 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rAUsd-0009ig-0J;
	Tue, 05 Dec 2023 13:50:27 +0100
Message-ID: <b501d70ce1bcfc7586d195f54a8fec73f9dcfcf0.camel@pengutronix.de>
Subject: Re: [PATCH v3 058/108] pwm: imx27: Make use of devm_pwmchip_alloc()
 function
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Shawn Guo
 <shawnguo@kernel.org>,  Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>,  linux-pwm@vger.kernel.org, Fabio
 Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 linux-arm-kernel@lists.infradead.org
Date: Tue, 05 Dec 2023 13:50:26 +0100
In-Reply-To: <20231205121404.djhpn5t3gylebfyc@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
	 <20231121134901.208535-59-u.kleine-koenig@pengutronix.de>
	 <95b1df79f6830eb7d886bcd7099354ad38218e31.camel@pengutronix.de>
	 <20231205121404.djhpn5t3gylebfyc@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

On Di, 2023-12-05 at 13:14 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Philipp,
>=20
> On Tue, Dec 05, 2023 at 12:49:19PM +0100, Philipp Zabel wrote:
> > On Di, 2023-11-21 at 14:50 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > @@ -306,13 +308,15 @@ MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
> > > =20
> > >  static int pwm_imx27_probe(struct platform_device *pdev)
> > >  {
> > > +	struct pwm_chip *chip;
> > >  	struct pwm_imx27_chip *imx;
> > >  	int ret;
> > >  	u32 pwmcr;
> > > =20
> > > -	imx =3D devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
> > > -	if (imx =3D=3D NULL)
> > > -		return -ENOMEM;
> > > +	chip =3D devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*imx));
> > > +	if (IS_ERR(chip))
> > > +		return PTR_ERR(chip);
> > > +	imx =3D pwmchip_priv(chip);
> >=20
> > Please use to_pwm_imx27_chip() here. Otherwise,
> >=20
> > Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>=20
> Thanks. This is already fixed in my tree for this and a few other
> drivers. Currently the patch looks as follows:
>=20
> 	https://git.pengutronix.de/cgit/ukl/linux/commit/?h=3Dpwm-lifetime-track=
ing&id=3D4fa8c8a8661fa6d91de0368693d4a92907fb5359
>=20
> The only other changes since this v3 is the usage of
> pwmchip_get_drvdata() instead of pwmchip_priv(). Can I keep your
> Reviewed-by for this new variant?

Yes.

regards
Philipp

