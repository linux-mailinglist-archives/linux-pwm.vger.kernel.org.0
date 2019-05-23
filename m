Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA7E27348
	for <lists+linux-pwm@lfdr.de>; Thu, 23 May 2019 02:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfEWA3S (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 22 May 2019 20:29:18 -0400
Received: from www3345.sakura.ne.jp ([49.212.235.55]:12327 "EHLO
        www3345.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfEWA3S (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 22 May 2019 20:29:18 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www3345.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4N0T3SU033900;
        Thu, 23 May 2019 09:29:03 +0900 (JST)
        (envelope-from cv-dong@jinso.co.jp)
Received: from www3345.sakura.ne.jp (49.212.235.55)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Thu, 23 May 2019 09:29:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.225] (p14010-ipadfx41marunouchi.tokyo.ocn.ne.jp [61.118.107.10])
        (authenticated bits=0)
        by www3345.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4N0T2Me033884
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 23 May 2019 09:29:03 +0900 (JST)
        (envelope-from cv-dong@jinso.co.jp)
Subject: Re: [PATCH] pwm: renesas-tpu: Add suspend/resume function
To:     linux-renesas-soc@vger.kernel.org, thierry.reding@gmail.com,
        horms+renesas@verge.net.au, geert+renesas@glider.be,
        broonie@kernel.org, linux-pwm@vger.kernel.org
Cc:     yoshihiro.shimoda.uh@renesas.com, kuninori.morimoto.gx@renesas.com,
        h-inayoshi@jinso.co.jp, na-hoan@jinso.co.jp, cv-dong@jinso.co.jp
References: <1558512379-8858-1-git-send-email-cv-dong@jinso.co.jp>
From:   Cao Van Dong <cv-dong@jinso.co.jp>
Message-ID: <54383c1a-6bb3-8695-b1af-cc2dd91537cc@jinso.co.jp>
Date:   Thu, 23 May 2019 09:29:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558512379-8858-1-git-send-email-cv-dong@jinso.co.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2019/05/22 17:06, Cao Van Dong wrote:
> This patch adds suspend/resume function support for Renesas the 16-Bit Timer
> Pulse Unit (TPU) driver. This has been tested on the Salvator-XS board
> with R-Car M3-N and H3 at renesas-drivers-2019-05-21-v5.2-rc1 tag.
> I expect this to work on other SoCs.
>
> Test procedure:
>    - Enable TPU and pin control in DTS.
>    - Make sure switches { SW29-[1-2] are switched off or
>      SW31-[1-4] are switched off(only for Salvator-xs) }.
>    - Exercise userspace PWM control for pwm[2,3]
>      of /sys/class/pwm/pwmchip1/ .
>    - Inspect PWM signals on the input side of { CN29-[58,60]
>      or SW31-[1,2] (only for Salvator-xs) }
>      before and after suspend/resume using an oscilloscope.
>
> Signed-off-by: Cao Van Dong <cv-dong@jinso.co.jp>
> Tested-by: Cao Van Dong <cv-dong@jinso.co.jp>
> ---
>   drivers/pwm/pwm-renesas-tpu.c | 49 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
>
> diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
> index 4a855a2..97b026e 100644
> --- a/drivers/pwm/pwm-renesas-tpu.c
> +++ b/drivers/pwm/pwm-renesas-tpu.c
> @@ -366,6 +366,54 @@ static void tpu_pwm_disable(struct pwm_chip *chip, struct pwm_device *_pwm)
>   	tpu_pwm_timer_stop(pwm);
>   }
>   
> +#ifdef CONFIG_PM_SLEEP
> +static struct pwm_device *tpu_pwm_dev_to_pwm_dev(struct device *dev)
> +{
> +	struct tpu_device *tpu = dev_get_drvdata(dev);
> +	struct pwm_chip *chip = &tpu->chip;
> +
> +	if((pwm_get_chip_data(&chip->pwms[0])) != NULL)
> +		return &chip->pwms[0];
> +	if((pwm_get_chip_data(&chip->pwms[1])) != NULL)
> +		return &chip->pwms[1];
> +	if((pwm_get_chip_data(&chip->pwms[2])) != NULL)
> +		return &chip->pwms[2];
> +	if((pwm_get_chip_data(&chip->pwms[3])) != NULL)
> +		return &chip->pwms[3];

Sorry everyone,

The current handling code only cover the case of using a timer.
In case of using multiple timers at a time, it will not be able
to restart all of them. Therefore, I will repair it to cover all
and resubmit in version v2.

Thank you,
Dong

> +	return NULL;
> +}
> +
> +static int tpu_pwm_suspend(struct device *dev)
> +{
> +	struct pwm_device *pwm = tpu_pwm_dev_to_pwm_dev(dev);
> +
> +	if (!test_bit(PWMF_REQUESTED, &pwm->flags))
> +		return 0;
> +
> +	pm_runtime_put(dev);
> +
> +	return 0;
> +}
> +
> +static int tpu_pwm_resume(struct device *dev)
> +{
> +	struct pwm_device *pwm = tpu_pwm_dev_to_pwm_dev(dev);
> +
> +	if ((!test_bit(PWMF_REQUESTED, &pwm->flags)) || pwm == NULL)
> +		return 0;
> +
> +	pm_runtime_get_sync(dev);
> +
> +	/* Restart timer */
> +	tpu_pwm_disable(pwm->chip,pwm);
> +	tpu_pwm_enable(pwm->chip,pwm);
> +
> +	return 0;
> +}
> +#endif /* CONFIG_PM_SLEEP */
> +static SIMPLE_DEV_PM_OPS(tpu_pwm_pm_ops, tpu_pwm_suspend, tpu_pwm_resume);
> +
>   static const struct pwm_ops tpu_pwm_ops = {
>   	.request = tpu_pwm_request,
>   	.free = tpu_pwm_free,
> @@ -459,6 +507,7 @@ static struct platform_driver tpu_driver = {
>   	.remove		= tpu_remove,
>   	.driver		= {
>   		.name	= "renesas-tpu-pwm",
> +		.pm		= &tpu_pwm_pm_ops,
>   		.of_match_table = of_match_ptr(tpu_of_table),
>   	}
>   };
