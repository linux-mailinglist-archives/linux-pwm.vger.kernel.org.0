Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05622E0DCF
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Dec 2020 18:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgLVRYB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Dec 2020 12:24:01 -0500
Received: from foss.arm.com ([217.140.110.172]:38122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbgLVRYA (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 22 Dec 2020 12:24:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C532E30E;
        Tue, 22 Dec 2020 09:23:14 -0800 (PST)
Received: from [10.57.34.90] (unknown [10.57.34.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50D9F3F66E;
        Tue, 22 Dec 2020 09:23:13 -0800 (PST)
Subject: Re: [PATCH v2 3/3] pwm: rockchip: Do not start PWMs not already
 running
To:     Simon South <simon@simonsouth.net>, tpiepho@gmail.com,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <cover.1608407584.git.simon@simonsouth.net>
 <0acdf3a78f670a2678e03b0bbbb01aa58a11ce9a.1608407584.git.simon@simonsouth.net>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ff2bf1bb-e95f-138c-df5a-12ed73568572@arm.com>
Date:   Tue, 22 Dec 2020 17:23:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <0acdf3a78f670a2678e03b0bbbb01aa58a11ce9a.1608407584.git.simon@simonsouth.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2020-12-19 20:44, Simon South wrote:
> Currently the Rockchip PWM driver enables the signal ("bus") clock for
> every PWM device it finds during probing, then disables it for any device
> that was not already enabled (such as by a bootloader) when the kernel
> started.
> 
> Instead of starting PWMs unnecessarily, check first to see whether a device
> has already been enabled and if not, do not enable its signal clock.
> 
> Signed-off-by: Simon South <simon@simonsouth.net>
> ---
>   drivers/pwm/pwm-rockchip.c | 28 +++++++++++++---------------
>   1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index f286a498b82c..b9faef3e9954 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -327,19 +327,6 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	ret = clk_prepare_enable(pc->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Can't prepare enable bus clk: %d\n", ret);
> -		return ret;
> -	}
> -
> -	ret = clk_prepare_enable(pc->pclk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Can't enable APB clk: %d\n", ret);
> -		clk_disable_unprepare(pc->clk);
> -		return ret;
> -	}
> -
>   	platform_set_drvdata(pdev, pc);
>   
>   	pc->data = id->data;
> @@ -353,12 +340,23 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
>   		pc->chip.of_pwm_n_cells = 3;
>   	}
>   
> +	ret = clk_prepare_enable(pc->pclk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't enable APB clk: %d\n", ret);
> +		return ret;
> +	}
> +
>   	/* Keep the PWM clk enabled if the PWM appears to be up and running. */
>   	enable_conf = pc->data->enable_conf;
>   	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
>   	enabled = ((ctrl & enable_conf) == enable_conf);
> -	if (!enabled)
> -		clk_disable(pc->clk);
> +
> +	ret = enabled ? clk_prepare_enable(pc->clk) : clk_prepare(pc->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't prepare bus clk: %d\n", ret);

Since you're touching it, I guess it might be a good idea to update this 
message to say "PWM clk" for clarity.

I suspect there might also have been some historical confounding in the 
fact that when there is only one clock (pclk_pwm), it's merely a gate 
whose parent is pclk_bus, which serves all the peripherals in the 
usefully-named PD_BUS domain...

Robin.

> +		clk_disable_unprepare(pc->pclk);
> +		return ret;
> +	}
>   
>   	clk_disable(pc->pclk);
>   
> 
