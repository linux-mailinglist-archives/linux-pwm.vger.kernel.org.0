Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACD2370903
	for <lists+linux-pwm@lfdr.de>; Sat,  1 May 2021 23:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhEAVKS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 1 May 2021 17:10:18 -0400
Received: from relay03.th.seeweb.it ([5.144.164.164]:59343 "EHLO
        relay03.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhEAVKR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 1 May 2021 17:10:17 -0400
Received: from [10.0.20.3] (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id BBD591F50B;
        Sat,  1 May 2021 23:09:21 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH v7 2/6] leds: Add driver for Qualcomm LPG
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
References: <20210429211517.312792-1-bjorn.andersson@linaro.org>
 <20210429211517.312792-3-bjorn.andersson@linaro.org>
Message-ID: <55b56fd9-0ba5-58d9-2be8-98aa639e4496@somainline.org>
Date:   Sat, 1 May 2021 23:09:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210429211517.312792-3-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Bjorn,

On 4/29/21 11:15 PM, Bjorn Andersson wrote:
> The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> PMICs from Qualcomm. It can operate on fixed parameters or based on a
> lookup-table, altering the duty cycle over time - which provides the
> means for e.g. hardware assisted transitions of LED brightness.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v6:
> - Moved code into drivers/leds/rgb/
> - Reverted to earlier qcom,dtest handling to support routing pwm signals
>    through dtest lines.
> - Remember the duration of each step of the pattern, rather than adding up and
>    then dividing when the value is used.
> - Added missing error prints on DT parse errors.
> - Added sm8150[lb] and made led source and atc presence optional
> - Added missing parenthesis around (len + 1) / 2 in search for hi_pause in the
>    pattern.
> 
>   drivers/leds/Kconfig             |    3 +
>   drivers/leds/Makefile            |    3 +
>   drivers/leds/rgb/leds-qcom-lpg.c | 1286 ++++++++++++++++++++++++++++++
>   3 files changed, 1292 insertions(+)
>   create mode 100644 drivers/leds/rgb/leds-qcom-lpg.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 49d99cb084db..8ab06b3f162d 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -933,6 +933,9 @@ source "drivers/leds/blink/Kconfig"
>   comment "Flash and Torch LED drivers"
>   source "drivers/leds/flash/Kconfig"
>   
> +comment "RGB LED drivers"
> +source "drivers/leds/rgb/Kconfig"


It looks like this file is not included in any of the patches.

> +
>   comment "LED Triggers"
>   source "drivers/leds/trigger/Kconfig"
>   
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 7e604d3028c8..8cad0465aae0 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -106,6 +106,9 @@ obj-$(CONFIG_LEDS_USER)			+= uleds.o
>   # Flash and Torch LED Drivers
>   obj-$(CONFIG_LEDS_CLASS_FLASH)		+= flash/
>   
> +# RGB LED Drivers
> +obj-$(CONFIG_LEDS_CLASS_MULTICOLOR)	+= rgb/


This file appears to be missing from this patch(set), too.

> +static int lpg_lut_store(struct lpg *lpg, struct led_pattern *pattern,
> +			 size_t len, unsigned int *lo_idx, unsigned int *hi_idx)
> +{
> +	unsigned int idx;
> +	u16 val;
> +	int i;
> +
> +	/* Hardware does not behave when LO_IDX == HI_IDX */
> +	if (len == 1)
> +		return -EINVAL;
> +
> +	idx = bitmap_find_next_zero_area(lpg->lut_bitmap, lpg->lut_size,
> +					 0, len, 0);
> +	if (idx >= lpg->lut_size)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < len; i++) {
> +		val = pattern[i].brightness;
> +
> +		regmap_bulk_write(lpg->map, lpg->lut_base + LPG_LUT_REG(idx + i), &val, 1);


This and the other regmap_bulk_write in lpg_apply_pwm_value used 
sizeof(val) before.  As far as I'm aware qcom-spmi-pmic specifies 16-bit 
addresses (.reg_bits) but 8-bit register sizes (.val_bits).  Writing one 
register means only 8 out of 16 bits in u16 val are written?

> +static void lpg_apply_lut_control(struct lpg_channel *chan)
> +{
> +	struct lpg *lpg = chan->lpg;
> +	unsigned int hi_pause;
> +	unsigned int lo_pause;
> +	unsigned int step;
> +	unsigned int conf = 0;
> +	unsigned int lo_idx = chan->pattern_lo_idx;
> +	unsigned int hi_idx = chan->pattern_hi_idx;
> +	int pattern_len;
> +
> +	if (!chan->ramp_enabled || chan->pattern_lo_idx == chan->pattern_hi_idx)
> +		return;
> +
> +	pattern_len = hi_idx - lo_idx + 1 > +
> +	step = chan->ramp_tick_ms;


Since this is not dividing a full pattern duration by pattern_len 
anymore, that variable is now never read and best removed.

> +static int lpg_parse_channel(struct lpg *lpg, struct device_node *np,
> +			     struct lpg_channel **channel)
> +{
> +	struct lpg_channel *chan;
> +	u32 color = LED_COLOR_ID_GREEN;
> +	u32 reg;
> +	int ret;
> +
> +	ret = of_property_read_u32(np, "reg", &reg);
> +	if (ret || !reg || reg > lpg->num_channels) {
> +		dev_err(lpg->dev, "invalid reg of %pOFn\n", np);


Like \"color\" below, escape reg with \"reg\"?

> +static int lpg_add_led(struct lpg *lpg, struct device_node *np)
> +{
> +	struct led_classdev *cdev;
> +	struct device_node *child;
> +	struct mc_subled *info;
> +	struct lpg_led *led;
> +	const char *state;
> +	int num_channels;
> +	u32 color = 0;
> +	int ret;
> +	int i;
> +
> +	ret = of_property_read_u32(np, "color", &color);
> +	if (ret < 0 && ret != -EINVAL) {
> +		dev_err(lpg->dev, "failed to parse \"color\" of %pOF\n", np);
> +		return ret;
> +	}
> +
> +	if (color == LED_COLOR_ID_MULTI)


Since this driver now lives under rgb/, and is specifically for RGB leds 
(afaik), should this and the rest of the code use LED_COLOR_ID_RGB 
instead?  There was a patch floating around on (if I remember correctly) 
##linux-msm by Luca Weiss that performs the conversion, with some 
related changes.

> +static int lpg_init_lut(struct lpg *lpg)
> +{
> +	const struct lpg_data *data = lpg->data;
> +	size_t bitmap_size;
> +
> +	if (!data->lut_base)
> +		return 0;
> +
> +	lpg->lut_base = data->lut_base;
> +	lpg->lut_size = data->lut_size;
> +
> +	bitmap_size = BITS_TO_BYTES(lpg->lut_size);
> +	lpg->lut_bitmap = devm_kzalloc(lpg->dev, bitmap_size, GFP_KERNEL);
> +	if (!lpg->lut_bitmap)
> +		return -ENOMEM;
> +
> +	bitmap_clear(lpg->lut_bitmap, 0, lpg->lut_size);


devm_kzalloc already zeroes the bitmap.  Is it necessary to clear it 
again (assuming a "cleared" bitmap is implementation-dependent and does 
not imply zeroed memory) or could the memory be allocated with 
devm_kalloc instead?

Thanks!
Marijn
