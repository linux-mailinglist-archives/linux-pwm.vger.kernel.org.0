Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9417AC4891
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2019 09:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfJBHd2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Oct 2019 03:33:28 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46417 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfJBHd2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Oct 2019 03:33:28 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iFZ8T-0006eS-7W; Wed, 02 Oct 2019 09:33:21 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iFZ8S-0006Cj-0p; Wed, 02 Oct 2019 09:33:20 +0200
Date:   Wed, 2 Oct 2019 09:33:19 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Anson Huang' <Anson.Huang@nxp.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Linux-imx@nxp.com" <Linux-imx@nxp.com>
Subject: Re: [PATCH] pwm: pwm-imx27: Use 'dev' instead of dereferencing it
 repeatedly
Message-ID: <20191002073319.tv55olneh6i6x4ir@pengutronix.de>
References: <1569315593-769-1-git-send-email-Anson.Huang@nxp.com>
 <6cfb1595992b46dc884731555e6f0334@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cfb1595992b46dc884731555e6f0334@AcuMS.aculab.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Sep 24, 2019 at 09:46:20AM +0000, David Laight wrote:
> From: Anson Huang
> > Sent: 24 September 2019 10:00
> > Add helper variable dev = &pdev->dev to simply the code.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  drivers/pwm/pwm-imx27.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> > index 434a351..3afee29 100644
> > --- a/drivers/pwm/pwm-imx27.c
> > +++ b/drivers/pwm/pwm-imx27.c
> > @@ -290,27 +290,28 @@ MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
> > 
> >  static int pwm_imx27_probe(struct platform_device *pdev)
> >  {
> > +	struct device *dev = &pdev->dev;
> >  	struct pwm_imx27_chip *imx;
> > 
> > -	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
> > +	imx = devm_kzalloc(dev, sizeof(*imx), GFP_KERNEL);
> >  	if (imx == NULL)
> >  		return -ENOMEM;
> > 
> >  	platform_set_drvdata(pdev, imx);
> > 
> > -	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> > +	imx->clk_ipg = devm_clk_get(dev, "ipg");
> >  	if (IS_ERR(imx->clk_ipg)) {
> > -		dev_err(&pdev->dev, "getting ipg clock failed with %ld\n",
> > +		dev_err(dev, "getting ipg clock failed with %ld\n",
> >  				PTR_ERR(imx->clk_ipg));
> >  		return PTR_ERR(imx->clk_ipg);
> >  	}
> > 
> > -	imx->clk_per = devm_clk_get(&pdev->dev, "per");
> > +	imx->clk_per = devm_clk_get(dev, "per");
> >  	if (IS_ERR(imx->clk_per)) {
> >  		int ret = PTR_ERR(imx->clk_per);
> > 
> >  		if (ret != -EPROBE_DEFER)
> > -			dev_err(&pdev->dev,
> > +			dev_err(dev,
> >  				"failed to get peripheral clock: %d\n",
> >  				ret);
> 
> Hopefully the compiler will optimise this back otherwise you've added another
> local variable which may cause spilling to stack.

I wonder that in reply to this comment nobody actually tried. I just did
that and applying the patch doesn't change the resulting binary. (Tested
with gcc 7.3.1).

> For a setup function it probably doesn't matter, but in general it might
> have a small negative performance impact.
> 
> In any case this doesn't shorten any lines enough to remove line-wrap
> and using &pdev->dev is really one less variable to mentally track
> when reading the code.

On the other hand having a variable named "dev" is so usual that I
personally slightly prefer using it instead of &pdev->dev. So I think
(given there is no effect on the compiled result) this is really just
about personal taste and so to actually switch from one preference to
the other needs a better justification IMHO.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
