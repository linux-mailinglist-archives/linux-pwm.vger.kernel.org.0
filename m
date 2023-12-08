Return-Path: <linux-pwm+bounces-456-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF2480A285
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 12:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53961F21461
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 11:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD241BDC0;
	Fri,  8 Dec 2023 11:47:18 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D0611D
	for <linux-pwm@vger.kernel.org>; Fri,  8 Dec 2023 03:47:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rBZJz-0004XI-NA; Fri, 08 Dec 2023 12:47:07 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rBZJw-00EPCy-74; Fri, 08 Dec 2023 12:47:04 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rBZJw-0006NC-0S;
	Fri, 08 Dec 2023 12:47:04 +0100
Message-ID: <92ac0bc4c43fa70ff4bcba44ba4382c0c8ebfb75.camel@pengutronix.de>
Subject: Re: [PATCH v9 2/4] pwm: opencores: Add PWM driver support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: William Qiu <william.qiu@starfivetech.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-pwm@vger.kernel.org
Cc: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring
 <robh+dt@kernel.org>,  Thierry Reding <thierry.reding@gmail.com>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>, Hal Feng <hal.feng@starfivetech.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Date: Fri, 08 Dec 2023 12:47:04 +0100
In-Reply-To: <20231208094209.1910934-3-william.qiu@starfivetech.com>
References: <20231208094209.1910934-1-william.qiu@starfivetech.com>
	 <20231208094209.1910934-3-william.qiu@starfivetech.com>
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

Hi William,

On Fr, 2023-12-08 at 17:42 +0800, William Qiu wrote:
> Add driver for OpenCores PWM Controller. And add compatibility code
> which based on StarFive SoC.
>=20
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
[...]
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 4b956d661755..d87e1bb350ba 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -444,6 +444,18 @@ config PWM_NTXEC
>  	  controller found in certain e-book readers designed by the original
>  	  design manufacturer Netronix.
> =20
> +config PWM_OCORES
> +	tristate "OpenCores PWM support"
> +	depends on HAS_IOMEM && OF
> +	depends on COMMON_CLK && RESET_CONTROLLER

There is no need for reset consumers to depend on RESET_CONTROLLER.

[...]
> diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c
> new file mode 100644
> index 000000000000..996ca3805901
> --- /dev/null
> +++ b/drivers/pwm/pwm-ocores.c
> @@ -0,0 +1,229 @@
[...]
> +static int ocores_pwm_probe(struct platform_device *pdev)
> +{
[...]
> +	ddata->rst =3D devm_reset_control_get_optional_exclusive(dev, NULL);

Missing error handling.

> +	reset_control_deassert(ddata->rst);

Missing error handling.


regards
Philipp

