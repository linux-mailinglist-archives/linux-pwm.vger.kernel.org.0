Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A818A186F91
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2020 17:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731890AbgCPQEr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Mar 2020 12:04:47 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:38234 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731674AbgCPQEr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Mar 2020 12:04:47 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4232BA3B;
        Mon, 16 Mar 2020 17:04:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1584374685;
        bh=dRi+PlGRHbKvE7mk5KHQiUT4Abh19CdvycHyiA6qRzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=peLDD8bUKlVpwYFuGOlHtV3carecvR9z2cRyvytYNZi7qQ0vAPVRnGMnDbSGUSVSa
         CxglgIDGFjuWggAKY4jgNDjP0F95cCVJHBU3qZQznDVB50noYDY7vPqEHMJ7GSbGeD
         KSBwSVSBsXFq4U279tAzaimXli/db6HCN6MD1DBM=
Date:   Mon, 16 Mar 2020 18:04:40 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/3] pwm: renesas-tpu: Fix late Runtime PM enablement
Message-ID: <20200316160440.GO4732@pendragon.ideasonboard.com>
References: <20200316103216.29383-1-geert+renesas@glider.be>
 <20200316103216.29383-3-geert+renesas@glider.be>
 <20200316160108.qylpoglfhhqvqqwt@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200316160108.qylpoglfhhqvqqwt@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Mon, Mar 16, 2020 at 05:01:08PM +0100, Uwe Kleine-König wrote:
> On Mon, Mar 16, 2020 at 11:32:15AM +0100, Geert Uytterhoeven wrote:
> > Runtime PM should be enabled before calling pwmchip_add(), as PWM users
> > can appear immediately after the PWM chip has been added.
> > Likewise, Runtime PM should always be disabled after the removal of the
> > PWM chip, even if the latter failed.
> > Fixes: 99b82abb0a35b073 ("pwm: Add Renesas TPU PWM driver")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/pwm/pwm-renesas-tpu.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
> > index 4a855a21b782dea3..8032acc84161a9dd 100644
> > --- a/drivers/pwm/pwm-renesas-tpu.c
> > +++ b/drivers/pwm/pwm-renesas-tpu.c
> > @@ -415,16 +415,17 @@ static int tpu_probe(struct platform_device *pdev)
> >  	tpu->chip.base = -1;
> >  	tpu->chip.npwm = TPU_CHANNEL_MAX;
> >  
> > +	pm_runtime_enable(&pdev->dev);
> > +
> >  	ret = pwmchip_add(&tpu->chip);
> >  	if (ret < 0) {
> >  		dev_err(&pdev->dev, "failed to register PWM chip\n");
> > +		pm_runtime_disable(&pdev->dev);
> >  		return ret;
> >  	}
> >  
> >  	dev_info(&pdev->dev, "TPU PWM %d registered\n", tpu->pdev->id);
> >  
> > -	pm_runtime_enable(&pdev->dev);
> > -
> >  	return 0;
> >  }

This part looks good to me.

> >  
> > @@ -434,12 +435,10 @@ static int tpu_remove(struct platform_device *pdev)
> >  	int ret;
> >  
> >  	ret = pwmchip_remove(&tpu->chip);
> > -	if (ret)
> > -		return ret;
> >  
> >  	pm_runtime_disable(&pdev->dev);
> >  
> > -	return 0;
> > +	return ret;
> >  }
> 
> Maybe I was a bit quick with my reply to the previous patch. I wonder if
> it is right to call pm_runtime_disable if pwmchip_remove failed?

It should at least be explained in the commit message why this is the
right thing to do.

-- 
Regards,

Laurent Pinchart
