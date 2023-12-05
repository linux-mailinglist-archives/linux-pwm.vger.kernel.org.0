Return-Path: <linux-pwm+bounces-294-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD2580536C
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Dec 2023 12:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCABC281439
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Dec 2023 11:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF32558ADC;
	Tue,  5 Dec 2023 11:49:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD05D197
	for <linux-pwm@vger.kernel.org>; Tue,  5 Dec 2023 03:49:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rATvU-0008CG-4q; Tue, 05 Dec 2023 12:49:20 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rATvT-00DjPo-Li; Tue, 05 Dec 2023 12:49:19 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rATvT-0008Ft-1t;
	Tue, 05 Dec 2023 12:49:19 +0100
Message-ID: <95b1df79f6830eb7d886bcd7099354ad38218e31.camel@pengutronix.de>
Subject: Re: [PATCH v3 058/108] pwm: imx27: Make use of devm_pwmchip_alloc()
 function
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
 Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Fabio
 Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
Date: Tue, 05 Dec 2023 12:49:19 +0100
In-Reply-To: <20231121134901.208535-59-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
	 <20231121134901.208535-59-u.kleine-koenig@pengutronix.de>
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

Hi Uwe,

On Di, 2023-11-21 at 14:50 +0100, Uwe Kleine-K=C3=B6nig wrote:
> This prepares the pwm-imx27 driver to further changes of the pwm core
> outlined in the commit introducing devm_pwmchip_alloc(). There is no
> intended semantical change and the driver should behave as before.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-imx27.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 5d796453519a..52ac65e40e35 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
[...]
> @@ -93,7 +92,10 @@ struct pwm_imx27_chip {
>  	unsigned int duty_cycle;
>  };
> =20
> -#define to_pwm_imx27_chip(chip)	container_of(chip, struct pwm_imx27_chip=
, chip)
> +static inline struct pwm_imx27_chip *to_pwm_imx27_chip(struct pwm_chip *=
chip)
> +{
> +	return pwmchip_priv(chip);
> +}
> =20
>  static int pwm_imx27_clk_prepare_enable(struct pwm_imx27_chip *imx)
>  {
> @@ -306,13 +308,15 @@ MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
> =20
>  static int pwm_imx27_probe(struct platform_device *pdev)
>  {
> +	struct pwm_chip *chip;
>  	struct pwm_imx27_chip *imx;
>  	int ret;
>  	u32 pwmcr;
> =20
> -	imx =3D devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
> -	if (imx =3D=3D NULL)
> -		return -ENOMEM;
> +	chip =3D devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*imx));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	imx =3D pwmchip_priv(chip);

Please use to_pwm_imx27_chip() here. Otherwise,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

