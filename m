Return-Path: <linux-pwm+bounces-3203-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFA8975BCA
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 22:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40392287583
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 20:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363311B5808;
	Wed, 11 Sep 2024 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="uQmB+SkJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AF614D708;
	Wed, 11 Sep 2024 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086876; cv=none; b=e5855gybL+Q3ayrkJldd2TpwGW4UZ8tdXlleb7qj29Ao9BlfRgp20zsNrwPMoYjC7DD3juNJNJgMRGLmtw1XlttARkTC5M7+9Nsg6+zv4TKrgLt0JzxeeW2qSyQsTbEpSkKS2i1mtD/0638YTlb9hf2y1w2G7JWVkTD2U1qoFHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086876; c=relaxed/simple;
	bh=SsBgfJqZ7FjXY31Gt2Ke3cvZGSgY0FEC9iyAZTz9eFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6oNMCdZK5BWAcXOt8sXIngkLZgkvA2+vbdF8Sm0iJ1atxnOhUf/7ovS23VF4OoiqTmUNCLF1IFkA3I8QbjvLug0l/M+OLga0jMcaF/Bg72Xs87HOvepRo/kz1K7sGgryY4Ogp2AoW+kS6OgFtKfvtg/EpawizScHCmMwdQGVww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=uQmB+SkJ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 1AA9288AB1;
	Wed, 11 Sep 2024 22:34:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726086872;
	bh=PWFsMLcUDDDxDl8hPygkD2SZfiSGqlgXqLg5FMn4wms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uQmB+SkJtp3WzkgjzdhS66+GaBsr+i/lEkSjAm+AH4s/UdmZGRCuol40Annp6l29r
	 ItFgZj8cVZjKj05ErR8bzN5i/yOsLWIGywX8xz7NFxERteeRlTFQwWjnoLp/iyI2OZ
	 LaMbDi7kMDamr3Elizmr90wfnC40H9fPLZKOW45SdCXPs3BsuIqZ7hwvKxStzXkGql
	 sDbTq736VCpvb4/GV3DcESJB+Ss6Be3OLtApEygVtG03TUia6216XPzV+TCNFUmCOp
	 UBOFjpR7uRiiuR3bib2G8D4dfTmHVBklt149Np1sMysVHhxiFwFpXBXfRpFt5RsK2e
	 oHJm/lWDTxZeg==
Message-ID: <f42fefb6-2815-4f74-b403-fecd2aa79688@denx.de>
Date: Wed, 11 Sep 2024 22:26:38 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
To: Frank Li <Frank.Li@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
 francesco@dolcini.it, imx@lists.linux.dev, jun.li@nxp.com,
 kernel@pengutronix.de, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, p.zabel@pengutronix.de, pratikmanvar09@gmail.com,
 robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
 ukleinek@kernel.org, xiaoning.wang@nxp.com
References: <20240910152455.2425152-1-Frank.Li@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240910152455.2425152-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/10/24 5:24 PM, Frank Li wrote:

Hi,

purely nitpicking further below, one quick question right below.

> This only resolves the issue when the PWM period is longer than 2us
> (or <500KHz) because write register is not quick enough when PWM period is
> very short.

You did mention the IPS bus is slow. Do I understand it correctly that 
the IPS bus write takes about 1us ? Because of the PWM consumes a sample 
every 2us and we need to write 2 samples to avoid FIFO underrun, then to 
safely write those 2 samples, we need to be able to write 1 sample per 1 
us into the FIFO ?

Also, would writing more samples help with such "fast" use cases ?
Something like this:

if (clkrate > 500000) {
   // This usleep() could use some further improvement, e.g. calculate
   // precise delay for the FIFO to get empty based on PWM clkrate
   usleep(2 * 5); // wait 2us for each of the 4 samples in FIFO and a bit
   // Now the FIFO is surely empty, write all four FIFO slots
   writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
   writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
   writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
   writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
} else { // clock rate less than 500 kHz
   // Do the workaround below
   if (duty_cycles < imx->duty_cycle && val < MX3_PWMSR_FIFOAV_2WORDS
     ...
}

> Reproduce steps:
>    cd /sys/class/pwm/pwmchip1/pwm0
>    echo 2000000000 > period     # It is easy to observe by using long period
>    echo 1000000000 > duty_cycle
>    echo 1 > enable
>    echo  800000000 > duty_cycle # One full high plus will be seen by scope
> 
> Fixes: 166091b1894d ("[ARM] MXC: add pwm driver for i.MX SoCs")
> Reviewed-by: Jun Li <jun.li@nxp.com>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v4 to v5
> - fix typo PMW & If
> - using imx->mmio_base + MX3_PWMSAR
> 
> Change from v3 to v4
> - none, wrong bump version number
> Change from v2 to v3
> - simple workaround implement.
> - add reproduce steps.
> 
> Change from v1 to v2
> - address comments in https://lore.kernel.org/linux-pwm/20211221095053.uz4qbnhdqziftymw@pengutronix.de/
>    About disable/enable pwm instead of disable/enable irq:
>    Some pmw periphal may sensitive to period. Disable/enable pwm will
> increase period, althouhg it is okay for most case, such as LED backlight
> or FAN speed. But some device such servo may require strict period.
> 
> - address comments in https://lore.kernel.org/linux-pwm/d72d1ae5-0378-4bac-8b77-0bb69f55accd@gmx.net/
>    Using official errata number
>    fix typo 'filp'
>    add {} for else
> 
> I supposed fixed all previous issues, let me know if I missed one.
> ---
>   drivers/pwm/pwm-imx27.c | 67 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 253afe94c4776..713d368f03931 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -27,6 +27,7 @@
>   #define MX3_PWMSR			0x04    /* PWM Status Register */
>   #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
>   #define MX3_PWMPR			0x10    /* PWM Period Register */
> +#define MX3_PWMCNR			0x14    /* PWM Counter Register */
>   
>   #define MX3_PWMCR_FWM			GENMASK(27, 26)
>   #define MX3_PWMCR_STOPEN		BIT(25)
> @@ -234,6 +235,8 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
>   	unsigned long long c;
>   	unsigned long long clkrate;
> +	unsigned long flags;
> +	int val;
>   	int ret;
>   	u32 cr;
>   
> @@ -274,7 +277,69 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   		pwm_imx27_sw_reset(chip);
>   	}
>   
> -	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> +	/*
> +	 * This is a limited workaround. When the SAR FIFO is empty, the new
> +	 * write value will be directly applied to SAR even the current period
> +	 * is not over.
> +	 *
> +	 *           ─────────────────────┐
> +	 * PWM OUTPUT                     │
> +	 *                                └─────────────────────────
> +	 *
> +	 *           ┌──────────────────────────────────────────────┐
> +	 * Counter   │       XXXXXXXXXXXXXX                         │
> +	 *           └──────────────────────────────────────────────┘
> +	 *                   ▲            ▲
> +	 *                   │            │
> +	 *                 New SAR      Old SAR
> +	 *
> +	 *           XXXX  Errata happen window
> +	 *
> +	 * If the new SAR value is less than the old one, and the counter is
> +	 * greater than the new SAR value (see above diagram XXXX), the current
> +	 * period will not flip the level. This will result in a pulse with a
> +	 * duty cycle of 100%.
> +	 *
> +	 * Check new sar less than old sar and current counter is in errata

Better do 's@\<sar\>@SAR@g' so all the instances of 'sar' in the text 
are in uppercase. Currently, some are in lowercase and some are in 
uppercase.

> +	 * windows, write extra old sar into FIFO and new sar will effect at
> +	 * next period.
> +	 *
> +	 * Sometime period is quite long, such as over 1 second. If add old sar
> +	 * into FIFO unconditional, new sar have to wait for next period. It
> +	 * may be too long.
> +	 *
> +	 * Turn off the interrupt to ensure that not irq and schedule happen

IRQ, in uppercase.

> +	 * during above operations. If any irq and schedule happen, counter
> +	 * in PWM will be out of data and take wrong action.
> +	 *
> +	 * Add a safety margin 1.5us because it needs some time to complete
> +	 * IO write.
> +	 *
> +	 * Use __raw_writel() to minimize the interval between two writes to
> +	 * the SAR register to increase the fastest pwm frequency supported.

PWM, in uppercase.

> +	 * When the PWM period is longer than 2us(or <500KHz), this workaround

kHz, kilo lowercase, Hz Hertz uppercase H lowercase z .

Also fix in the commit message.

> +	 * can solve this problem. No software workaround is available if PWM
> +	 * period is shorter than IO write.
> +	 */
> +	c = clkrate * 1500;
> +	do_div(c, NSEC_PER_SEC);
> +
> +	local_irq_save(flags);
> +	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
> +	if (duty_cycles < imx->duty_cycle && val < MX3_PWMSR_FIFOAV_2WORDS) {
> +		val = readl_relaxed(imx->mmio_base + MX3_PWMCNR);

I would put the comment below above this conditional statement.

> +		if ((val + c >= duty_cycles && val < imx->duty_cycle) ||
> +		    /*
> +		     * If counter is close to period, controller may roll over
> +		     * when next IO write.
> +		     */
> +		    val + c >= period_cycles)
> +			writel_relaxed(imx->duty_cycle, imx->mmio_base + MX3_PWMSAR);
> +	}
> +	writel_relaxed(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> +	local_irq_restore(flags);
> +
>   	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
The patch looks good, the above are just trivial nitpicks.

Thanks !

