Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D60DA186F99
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2020 17:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbgCPQFZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Mar 2020 12:05:25 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:38250 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731674AbgCPQFZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Mar 2020 12:05:25 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4DBE1A3B;
        Mon, 16 Mar 2020 17:05:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1584374723;
        bh=GVKZIi+Z5btsGnCqqXAo7vsXepJlbvcOwHtVmBNViT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k5rmcZ8lBM4ohZ48A9LqdgLcST2I98YQvXcO28qdQFvkr5KafoglD5LVZGf4E/tSa
         8PK92+eb/xUt2YVX4/wJV/5p9Mu3xkp3LvB97u1dBtMen4zI8gtKJRPubVpe6kJlmJ
         lVVBncTCNUopfZmo6BGF7qN82yDvaAz+hMNWpa00=
Date:   Mon, 16 Mar 2020 18:05:18 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 3/3] pwm: renesas-tpu: Drop confusing registered message
Message-ID: <20200316160518.GP4732@pendragon.ideasonboard.com>
References: <20200316103216.29383-1-geert+renesas@glider.be>
 <20200316103216.29383-4-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200316103216.29383-4-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Mon, Mar 16, 2020 at 11:32:16AM +0100, Geert Uytterhoeven wrote:
> During device probe, the message
> 
>     TPU PWM -1 registered
> 
> is printed.
> 
> While the "-1" looks suspicious, it is perfectly normal for a device
> instantiated from DT.
> 
> Remove the message, as there are no non-DT users left, and other drivers
> don't print such messages neither.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/pwm/pwm-renesas-tpu.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
> index 8032acc84161a9dd..81ad5a551455e4b8 100644
> --- a/drivers/pwm/pwm-renesas-tpu.c
> +++ b/drivers/pwm/pwm-renesas-tpu.c
> @@ -424,8 +424,6 @@ static int tpu_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	dev_info(&pdev->dev, "TPU PWM %d registered\n", tpu->pdev->id);
> -
>  	return 0;
>  }
>  

-- 
Regards,

Laurent Pinchart
