Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A5A7BA176
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Oct 2023 16:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbjJEOmP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Oct 2023 10:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236779AbjJEOhD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Oct 2023 10:37:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A724787F;
        Thu,  5 Oct 2023 07:02:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651F2C4AF74;
        Thu,  5 Oct 2023 13:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696513053;
        bh=gQO8gzEGdkAvnIig++YIzdt2XSzjnK/sMCovAlXVcec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsMLk3v9sa0Le4rZCkVPgBBMlnc4tFWpH62qc39eH2N15SCHzvCAvn0vmaUv3/wJB
         Qyw0rIk9li58oSFclEaRxPe3ynG0NXqU02/w+nt03qU3LdwghdjKZYXRlDMf3sVTgK
         cfDR049tas6X8DDlAbVSyeePDD+i2PTC1A8gglM5tor1YawSY9TYGGpXm8Zi781UyN
         NSMkDCoPwlADzc81V9SbuSpDS0FXZTyySoI6MlgZaaEhcQukEbx0aFSA6nILZDikcc
         Ld8CKaa47X100eCxKqIGJ2Z8ZcGV+bozjHnmpK3mUg0ZrBWoWRfSNg6KgcX+GByLTY
         0q5vT+j2514DQ==
Date:   Thu, 5 Oct 2023 14:37:26 +0100
From:   Lee Jones <lee@kernel.org>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     pavel@ucw.cz, thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, luca.weiss@fairphone.com,
        konrad.dybcio@linaro.org, u.kleine-koenig@pengutronix.de,
        quic_subbaram@quicinc.com, quic_gurus@quicinc.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org, kernel@quicinc.com
Subject: Re: [PATCH v5 4/7] leds: rgb: leds-qcom-lpg: Add support for single
 SDAM PPG
Message-ID: <20231005133726.GD681678@google.com>
References: <20230929003901.15086-1-quic_amelende@quicinc.com>
 <20230929003901.15086-5-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230929003901.15086-5-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 28 Sep 2023, Anjelique Melendez wrote:

> In some PMICs like pmi632, the pattern look up table (LUT) and LPG
> configuration is stored in a single SDAM module instead of LUT
> peripheral. Currently, PMICs without LUT peripheral will not be
> able to produce LED patterns.
> 
> Add support for PBS Pattern Generation (PPG), which is the feature
> that allows PMICs without LUT peripherals to produce LED patterns
> from SDAM module. PPG uses the Qualcomm Programmable Boot
> Sequencer (PBS) to trigger LED pattern sequences.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  drivers/leds/rgb/leds-qcom-lpg.c | 282 ++++++++++++++++++++++++++++---
>  1 file changed, 261 insertions(+), 21 deletions(-)

Looking good.  Just a couple of nits and throughts.

> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
> index df469aaa7e6e..4d87686f916c 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -8,11 +8,13 @@
>  #include <linux/bitfield.h>
>  #include <linux/led-class-multicolor.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> +#include <linux/soc/qcom/qcom-pbs.h>
>  
>  #define LPG_SUBTYPE_REG		0x05
>  #define  LPG_SUBTYPE_LPG	0x2
> @@ -39,6 +41,8 @@
>  #define PWM_SEC_ACCESS_REG	0xd0
>  #define PWM_DTEST_REG(x)	(0xe2 + (x) - 1)
>  
> +#define SDAM_REG_PBS_SEQ_EN		0x42
> +
>  #define TRI_LED_SRC_SEL		0x45
>  #define TRI_LED_EN_CTL		0x46
>  #define TRI_LED_ATC_CTL		0x47
> @@ -48,9 +52,25 @@
>  
>  #define LPG_RESOLUTION_9BIT	BIT(9)
>  #define LPG_RESOLUTION_15BIT	BIT(15)
> +#define PPG_MAX_LED_BRIGHTNESS	255
> +
>  #define LPG_MAX_M		7
>  #define LPG_MAX_PREDIV		6
>  
> +#define DEFAULT_TICK_DURATION_US	7800
> +#define RAMP_STEP_DURATION(x)		(((x) * 1000 / DEFAULT_TICK_DURATION_US) & 0xff)
> +
> +/* LPG common config settings for PPG */
> +#define SDAM_REG_RAMP_STEP_DURATION		0x47
> +#define SDAM_LPG_SDAM_LUT_PATTERN_OFFSET	0x80
> +
> +/* LPG per channel config settings for PPG */
> +#define SDAM_LUT_EN_OFFSET			0x0
> +#define SDAM_PATTERN_CONFIG_OFFSET		0x1
> +#define SDAM_END_INDEX_OFFSET			0x3
> +#define SDAM_START_INDEX_OFFSET		0x4
> +#define SDAM_PBS_SCRATCH_LUT_COUNTER_OFFSET	0x6
> +
>  struct lpg_channel;
>  struct lpg_data;
>  
> @@ -64,7 +84,10 @@ struct lpg_data;
>   * @lut_base:	base address of the LUT block (optional)
>   * @lut_size:	number of entries in the LUT block
>   * @lut_bitmap:	allocation bitmap for LUT entries
> - * @triled_base: base address of the TRILED block (optional)
> + * @pbs_dev:	PBS device
> + * @lpg_chan_sdam:	LPG SDAM peripheral device
> + * @pbs_en_bitmap:	bitmap for tracking PBS triggers
> + * @triled_base:	base address of the TRILED block (optional)
>   * @triled_src:	power-source for the TRILED
>   * @triled_has_atc_ctl:	true if there is TRI_LED_ATC_CTL register
>   * @triled_has_src_sel:	true if there is TRI_LED_SRC_SEL register
> @@ -85,6 +108,10 @@ struct lpg {
>  	u32 lut_size;
>  	unsigned long *lut_bitmap;
>  
> +	struct pbs_dev *pbs_dev;
> +	struct nvmem_device *lpg_chan_sdam;
> +	unsigned long pbs_en_bitmap;
> +
>  	u32 triled_base;
>  	u32 triled_src;
>  	bool triled_has_atc_ctl;
> @@ -101,6 +128,8 @@ struct lpg {
>   * @triled_mask: mask in TRILED to enable this channel
>   * @lut_mask:	mask in LUT to start pattern generator for this channel
>   * @subtype:	PMIC hardware block subtype
> + * @sdam_offset:	Channel offset in LPG SDAM

Nit: De-capitalise Channel.

> + * @lpg_idx:	index of the channel
>   * @in_use:	channel is exposed to LED framework
>   * @color:	color of the LED attached to this channel
>   * @dtest_line:	DTEST line for output, or 0 if disabled
> @@ -112,6 +141,7 @@ struct lpg {
>   * @pre_div_sel: divider selector of the reference clock
>   * @pre_div_exp: exponential divider of the reference clock
>   * @pwm_resolution_sel:	pwm resolution selector
> + * @pattern_set: true when setting pattern
>   * @ramp_enabled: duty cycle is driven by iterating over lookup table
>   * @ramp_ping_pong: reverse through pattern, rather than wrapping to start
>   * @ramp_oneshot: perform only a single pass over the pattern
> @@ -129,6 +159,8 @@ struct lpg_channel {
>  	unsigned int triled_mask;
>  	unsigned int lut_mask;
>  	unsigned int subtype;
> +	u32 sdam_offset;
> +	u32 lpg_idx;
>  
>  	bool in_use;
>  
> @@ -146,6 +178,7 @@ struct lpg_channel {
>  	unsigned int pre_div_exp;
>  	unsigned int pwm_resolution_sel;
>  
> +	bool pattern_set;
>  	bool ramp_enabled;
>  	bool ramp_ping_pong;
>  	bool ramp_oneshot;
> @@ -180,8 +213,10 @@ struct lpg_led {
>   * struct lpg_channel_data - per channel initialization data
>   * @base:		base address for PWM channel registers
>   * @triled_mask:	bitmask for controlling this channel in TRILED
> + * @sdam_offset:	Channel offset in LPG SDAM

Nit: Please keep these ordered.

>   */
>  struct lpg_channel_data {
> +	unsigned int sdam_offset;
>  	unsigned int base;
>  	u8 triled_mask;
>  };
> @@ -206,6 +241,75 @@ struct lpg_data {
>  	const struct lpg_channel_data *channels;
>  };
>  
> +#define PBS_SW_TRIG_BIT		BIT(0)
> +
> +static int lpg_clear_pbs_trigger(struct lpg_channel *chan)
> +{
> +	u8 val = 0;
> +	int rc;
> +
> +	clear_bit(chan->lpg_idx, &chan->lpg->pbs_en_bitmap);
> +	if (!chan->lpg->pbs_en_bitmap) {
> +		rc = nvmem_device_write(chan->lpg->lpg_chan_sdam, SDAM_REG_PBS_SEQ_EN, 1, &val);
> +		if (rc < 0)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int lpg_set_pbs_trigger(struct lpg_channel *chan)
> +{
> +	u8 val = PBS_SW_TRIG_BIT;
> +	int rc;
> +
> +	if (!chan->lpg->pbs_en_bitmap) {
> +		rc = nvmem_device_write(chan->lpg->lpg_chan_sdam, SDAM_REG_PBS_SEQ_EN, 1, &val);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = qcom_pbs_trigger_event(chan->lpg->pbs_dev, val);
> +		if (rc < 0)
> +			return rc;
> +	}
> +	set_bit(chan->lpg_idx, &chan->lpg->pbs_en_bitmap);
> +
> +	return 0;
> +}
> +
> +static int lpg_sdam_configure_triggers(struct lpg_channel *chan, bool set_trig)
> +{
> +	u32 addr = SDAM_LUT_EN_OFFSET + chan->sdam_offset;
> +	u8 val;
> +	int rc;
> +
> +	if (chan->lpg->lut_base)

Because?  I think I comment here would be handy.

> +		return 0;
> +
> +	if (set_trig) {
> +		val = 1;
> +		rc = nvmem_device_write(chan->lpg->lpg_chan_sdam, addr, 1, &val);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = lpg_set_pbs_trigger(chan);
> +		if (rc < 0)
> +			return rc;
> +		chan->pattern_set = false;
> +	} else {
> +		val = 0;
> +		rc = nvmem_device_write(chan->lpg->lpg_chan_sdam, addr, 1, &val);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = lpg_clear_pbs_trigger(chan);
> +		if (rc < 0)
> +			return rc;

Nothing to be done for pattern_set?

> +	}
> +
> +	return 0;
> +}
> +
>  static int triled_set(struct lpg *lpg, unsigned int mask, unsigned int enable)
>  {
>  	/* Skip if we don't have a triled block */
> @@ -216,6 +320,41 @@ static int triled_set(struct lpg *lpg, unsigned int mask, unsigned int enable)
>  				  mask, enable);
>  }
>  
> +static int lpg_lut_store_sdam(struct lpg *lpg, struct led_pattern *pattern,
> +			 size_t len, unsigned int *lo_idx, unsigned int *hi_idx)
> +{
> +	unsigned int idx;
> +	u8 brightness;
> +	int i, rc;
> +	u16 addr;
> +
> +	if (len > lpg->lut_size) {
> +		dev_err(lpg->dev, "Pattern length (%zu) exceeds maximum pattern length (%d)\n",
> +			len, lpg->lut_size);
> +		return -EINVAL;
> +	}
> +
> +	idx = bitmap_find_next_zero_area(lpg->lut_bitmap, lpg->lut_size,
> +					 0, len, 0);

These line wraps are inconsistent with some others.

Pick 80 or 100, but be consistent throughout.

> +	if (idx >= lpg->lut_size)
> +		return -ENOSPC;
> +
> +	for (i = 0; i < len; i++) {
> +		brightness = pattern[i].brightness;
> +		addr = SDAM_LPG_SDAM_LUT_PATTERN_OFFSET + i + idx;
> +		rc = nvmem_device_write(lpg->lpg_chan_sdam, addr, 1, &brightness);
> +		if (rc < 0)
> +			return rc;
> +	}
> +
> +	bitmap_set(lpg->lut_bitmap, idx, len);
> +
> +	*lo_idx = idx;
> +	*hi_idx = idx + len - 1;
> +
> +	return 0;
> +}
> +
>  static int lpg_lut_store(struct lpg *lpg, struct led_pattern *pattern,
>  			 size_t len, unsigned int *lo_idx, unsigned int *hi_idx)
>  {
> @@ -462,6 +601,28 @@ static void lpg_apply_pwm_value(struct lpg_channel *chan)
>  #define LPG_PATTERN_CONFIG_PAUSE_HI	BIT(1)
>  #define LPG_PATTERN_CONFIG_PAUSE_LO	BIT(0)
>  
> +static void lpg_sdam_apply_lut_control(struct lpg_channel *chan)
> +{
> +	struct nvmem_device *lpg_chan_sdam = chan->lpg->lpg_chan_sdam;
> +	unsigned int lo_idx = chan->pattern_lo_idx;
> +	unsigned int hi_idx = chan->pattern_hi_idx;
> +	u8 val = 0, conf = 0;
> +
> +	if (!chan->ramp_enabled || chan->pattern_lo_idx == chan->pattern_hi_idx)
> +		return;
> +
> +	if (!chan->ramp_oneshot)
> +		conf |= LPG_PATTERN_CONFIG_REPEAT;
> +
> +	nvmem_device_write(lpg_chan_sdam, SDAM_PBS_SCRATCH_LUT_COUNTER_OFFSET + chan->sdam_offset, 1, &val);
> +	nvmem_device_write(lpg_chan_sdam, SDAM_PATTERN_CONFIG_OFFSET + chan->sdam_offset, 1, &conf);
> +	nvmem_device_write(lpg_chan_sdam, SDAM_END_INDEX_OFFSET + chan->sdam_offset, 1, &hi_idx);
> +	nvmem_device_write(lpg_chan_sdam, SDAM_START_INDEX_OFFSET + chan->sdam_offset, 1, &lo_idx);
> +
> +	val = RAMP_STEP_DURATION(chan->ramp_tick_ms);
> +	nvmem_device_write(lpg_chan_sdam, SDAM_REG_RAMP_STEP_DURATION, 1, &val);
> +}
> +
>  static void lpg_apply_lut_control(struct lpg_channel *chan)
>  {
>  	struct lpg *lpg = chan->lpg;
> @@ -597,7 +758,10 @@ static void lpg_apply(struct lpg_channel *chan)
>  	lpg_apply_pwm_value(chan);
>  	lpg_apply_control(chan);
>  	lpg_apply_sync(chan);
> -	lpg_apply_lut_control(chan);
> +	if (chan->lpg->lpg_chan_sdam)
> +		lpg_sdam_apply_lut_control(chan);
> +	else
> +		lpg_apply_lut_control(chan);
>  	lpg_enable_glitch(chan);
>  }
>  
> @@ -642,6 +806,9 @@ static void lpg_brightness_set(struct lpg_led *led, struct led_classdev *cdev,
>  		triled_mask |= chan->triled_mask;
>  
>  		lpg_apply(chan);
> +
> +		if (chan->pattern_set)
> +			lpg_sdam_configure_triggers(chan, true);
>  	}
>  
>  	/* Toggle triled lines */
> @@ -836,18 +1003,24 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
>  	 * If the specified pattern is a palindrome the ping pong mode is
>  	 * enabled. In this scenario the delta_t of the middle entry (i.e. the
>  	 * last in the programmed pattern) determines the "high pause".
> +	 *
> +	 * SDAM devices supporting LUT do not support "low pause", "high pause"
> +	 * or "ping pong"
>  	 */
>  
>  	/* Detect palindromes and use "ping pong" to reduce LUT usage */
> -	for (i = 0; i < len / 2; i++) {
> -		brightness_a = pattern[i].brightness;
> -		brightness_b = pattern[len - i - 1].brightness;
> -
> -		if (brightness_a != brightness_b) {
> -			ping_pong = false;
> -			break;
> +	if (lpg->lut_base) {
> +		for (i = 0; i < len / 2; i++) {
> +			brightness_a = pattern[i].brightness;
> +			brightness_b = pattern[len - i - 1].brightness;
> +
> +			if (brightness_a != brightness_b) {
> +				ping_pong = false;
> +				break;
> +			}
>  		}
> -	}
> +	} else
> +		ping_pong = false;
>  
>  	/* The pattern length to be written to the LUT */
>  	if (ping_pong)
> @@ -875,12 +1048,27 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
>  	if (delta_t >= BIT(9))
>  		goto out_free_pattern;
>  
> -	/* Find "low pause" and "high pause" in the pattern */
> -	lo_pause = pattern[0].delta_t;
> -	hi_pause = pattern[actual_len - 1].delta_t;
> +	/*
> +	 * Find "low pause" and "high pause" in the pattern in the LUT case.
> +	 * LPGs using SDAM for pattern require equal duration of all steps
> +	 */
> +	if (lpg->lut_base) {
> +		lo_pause = pattern[0].delta_t;
> +		hi_pause = pattern[actual_len - 1].delta_t;
> +	} else {
> +		if (delta_t != pattern[0].delta_t ||
> +		    delta_t != pattern[actual_len - 1].delta_t)
> +			goto out_free_pattern;
> +	}
> +
>  
>  	mutex_lock(&lpg->lock);
> -	ret = lpg_lut_store(lpg, pattern, actual_len, &lo_idx, &hi_idx);
> +
> +	if (lpg->lpg_chan_sdam)
> +		ret = lpg_lut_store_sdam(lpg, pattern, actual_len, &lo_idx, &hi_idx);
> +	else
> +		ret = lpg_lut_store(lpg, pattern, actual_len, &lo_idx, &hi_idx);
> +
>  	if (ret < 0)
>  		goto out_unlock;
>  
> @@ -896,6 +1084,8 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
>  
>  		chan->pattern_lo_idx = lo_idx;
>  		chan->pattern_hi_idx = hi_idx;
> +

Why are we spacing them out?  They look related?

> +		chan->pattern_set = true;
>  	}
>  
>  out_unlock:
> @@ -953,6 +1143,7 @@ static int lpg_pattern_clear(struct lpg_led *led)
>  
>  	for (i = 0; i < led->num_channels; i++) {
>  		chan = led->channels[i];
> +		lpg_sdam_configure_triggers(chan, false);
>  		chan->pattern_lo_idx = 0;
>  		chan->pattern_hi_idx = 0;
>  	}
> @@ -1188,8 +1379,8 @@ static int lpg_add_led(struct lpg *lpg, struct device_node *np)
>  		cdev->brightness_set_blocking = lpg_brightness_mc_set;
>  		cdev->blink_set = lpg_blink_mc_set;
>  
> -		/* Register pattern accessors only if we have a LUT block */
> -		if (lpg->lut_base) {
> +		/* Register pattern accessors if we have a LUT block or when using PPG */
> +		if (lpg->lut_base || lpg->lpg_chan_sdam) {
>  			cdev->pattern_set = lpg_pattern_mc_set;
>  			cdev->pattern_clear = lpg_pattern_mc_clear;
>  		}
> @@ -1202,15 +1393,19 @@ static int lpg_add_led(struct lpg *lpg, struct device_node *np)
>  		cdev->brightness_set_blocking = lpg_brightness_single_set;
>  		cdev->blink_set = lpg_blink_single_set;
>  
> -		/* Register pattern accessors only if we have a LUT block */
> -		if (lpg->lut_base) {
> +		/* Register pattern accessors if we have a LUT block or when using PPG */
> +		if (lpg->lut_base || lpg->lpg_chan_sdam) {
>  			cdev->pattern_set = lpg_pattern_single_set;
>  			cdev->pattern_clear = lpg_pattern_single_clear;
>  		}
>  	}
>  
>  	cdev->default_trigger = of_get_property(np, "linux,default-trigger", NULL);
> -	cdev->max_brightness = LPG_RESOLUTION_9BIT - 1;
> +
> +	if (lpg->lpg_chan_sdam)
> +		cdev->max_brightness = PPG_MAX_LED_BRIGHTNESS;
> +	else
> +		cdev->max_brightness = LPG_RESOLUTION_9BIT - 1;

Are these not both 0xff (255)?

>  	if (!of_property_read_string(np, "default-state", &state) &&
>  	    !strcmp(state, "on"))
> @@ -1251,6 +1446,8 @@ static int lpg_init_channels(struct lpg *lpg)
>  		chan->base = data->channels[i].base;
>  		chan->triled_mask = data->channels[i].triled_mask;
>  		chan->lut_mask = BIT(i);
> +		chan->sdam_offset = data->channels[i].sdam_offset;
> +		chan->lpg_idx = i;
>  
>  		regmap_read(lpg->map, chan->base + LPG_SUBTYPE_REG, &chan->subtype);
>  	}
> @@ -1297,11 +1494,12 @@ static int lpg_init_lut(struct lpg *lpg)
>  {
>  	const struct lpg_data *data = lpg->data;
>  
> -	if (!data->lut_base)
> +	if (!data->lut_size)
>  		return 0;
>  
> -	lpg->lut_base = data->lut_base;
>  	lpg->lut_size = data->lut_size;
> +	if (data->lut_base)
> +		lpg->lut_base = data->lut_base;
>  
>  	lpg->lut_bitmap = devm_bitmap_zalloc(lpg->dev, lpg->lut_size, GFP_KERNEL);
>  	if (!lpg->lut_bitmap)
> @@ -1310,6 +1508,44 @@ static int lpg_init_lut(struct lpg *lpg)
>  	return 0;
>  }
>  
> +static int lpg_init_sdam(struct lpg *lpg)
> +{
> +	struct lpg_channel *chan;
> +	int i, sdam_count, rc;
> +	u8 val = 0;
> +
> +	sdam_count = of_property_count_strings(lpg->dev->of_node, "nvmem-names");
> +	if (sdam_count <= 0)
> +		return 0;
> +
> +	/* get the SDAM device for LPG/LUT config */

Nit: Start comments with an uppercase char.

> +	lpg->lpg_chan_sdam = devm_nvmem_device_get(lpg->dev, "lpg_chan_sdam");
> +	if (IS_ERR(lpg->lpg_chan_sdam))
> +		return dev_err_probe(lpg->dev, PTR_ERR(lpg->lpg_chan_sdam),
> +				"Failed to get lpg sdam device\n");

Should these abbreviations be capitalised?

> +	lpg->pbs_dev = get_pbs_client_device(lpg->dev);
> +	if (IS_ERR(lpg->pbs_dev))
> +		return dev_err_probe(lpg->dev, PTR_ERR(lpg->pbs_dev),
> +				"Failed to get PBS client device\n");
> +
> +	for (i = 0; i < lpg->num_channels; i++) {
> +		chan = &lpg->channels[i];

Is 'chan' used outside of this for loop?

If not, move the declaration into here.

> +		if (chan->sdam_offset) {
> +			rc = nvmem_device_write(lpg->lpg_chan_sdam,
> +				SDAM_PBS_SCRATCH_LUT_COUNTER_OFFSET + chan->sdam_offset, 1, &val);
> +			if (rc < 0)
> +				return rc;
> +
> +			rc = lpg_sdam_configure_triggers(chan, false);
> +			if (rc < 0)
> +				return rc;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int lpg_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np;
> @@ -1346,6 +1582,10 @@ static int lpg_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = lpg_init_sdam(lpg);
> +	if (ret < 0)
> +		return ret;
> +
>  	ret = lpg_init_lut(lpg);
>  	if (ret < 0)
>  		return ret;
> -- 
> 2.41.0
> 

-- 
Lee Jones [李琼斯]
