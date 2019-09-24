Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B85AFBC522
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2019 11:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfIXJqZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 24 Sep 2019 05:46:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:59939 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726707AbfIXJqY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Sep 2019 05:46:24 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-32-bDsbnQiNOe68NbhcH2sO_g-1; Tue, 24 Sep 2019 10:46:21 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 24 Sep 2019 10:46:21 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 24 Sep 2019 10:46:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Anson Huang' <Anson.Huang@nxp.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Linux-imx@nxp.com" <Linux-imx@nxp.com>
Subject: RE: [PATCH] pwm: pwm-imx27: Use 'dev' instead of dereferencing it
 repeatedly
Thread-Topic: [PATCH] pwm: pwm-imx27: Use 'dev' instead of dereferencing it
 repeatedly
Thread-Index: AQHVcra7p8HS4HCHSk+GwFkUo51L56c6k17Q
Date:   Tue, 24 Sep 2019 09:46:20 +0000
Message-ID: <6cfb1595992b46dc884731555e6f0334@AcuMS.aculab.com>
References: <1569315593-769-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1569315593-769-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: bDsbnQiNOe68NbhcH2sO_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Anson Huang
> Sent: 24 September 2019 10:00
> Add helper variable dev = &pdev->dev to simply the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/pwm/pwm-imx27.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 434a351..3afee29 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -290,27 +290,28 @@ MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
> 
>  static int pwm_imx27_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	struct pwm_imx27_chip *imx;
> 
> -	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
> +	imx = devm_kzalloc(dev, sizeof(*imx), GFP_KERNEL);
>  	if (imx == NULL)
>  		return -ENOMEM;
> 
>  	platform_set_drvdata(pdev, imx);
> 
> -	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> +	imx->clk_ipg = devm_clk_get(dev, "ipg");
>  	if (IS_ERR(imx->clk_ipg)) {
> -		dev_err(&pdev->dev, "getting ipg clock failed with %ld\n",
> +		dev_err(dev, "getting ipg clock failed with %ld\n",
>  				PTR_ERR(imx->clk_ipg));
>  		return PTR_ERR(imx->clk_ipg);
>  	}
> 
> -	imx->clk_per = devm_clk_get(&pdev->dev, "per");
> +	imx->clk_per = devm_clk_get(dev, "per");
>  	if (IS_ERR(imx->clk_per)) {
>  		int ret = PTR_ERR(imx->clk_per);
> 
>  		if (ret != -EPROBE_DEFER)
> -			dev_err(&pdev->dev,
> +			dev_err(dev,
>  				"failed to get peripheral clock: %d\n",
>  				ret);

Hopefully the compiler will optimise this back otherwise you've added another
local variable which may cause spilling to stack.
For a setup function it probably doesn't matter, but in general it might
have a small negative performance impact.

In any case this doesn't shorten any lines enough to remove line-wrap
and using &pdev->dev is really one less variable to mentally track
when reading the code.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

