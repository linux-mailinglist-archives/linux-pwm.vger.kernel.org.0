Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02521C06B7
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2020 21:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgD3TqX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 30 Apr 2020 15:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbgD3TqX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 Apr 2020 15:46:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80944C035494
        for <linux-pwm@vger.kernel.org>; Thu, 30 Apr 2020 12:46:22 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jUF8I-0001oM-3f; Thu, 30 Apr 2020 21:46:06 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jUF8F-0008JS-8X; Thu, 30 Apr 2020 21:46:03 +0200
Date:   Thu, 30 Apr 2020 21:46:03 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Roy Im <roy.im.opensource@diasemi.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [RESEND PATCH V11 3/3] Input: new da7280 haptic driver
Message-ID: <20200430194603.ah3ytucf3fzxrfs5@pengutronix.de>
References: <cover.1587949032.git.Roy.Im@diasemi.com>
 <eb301aa028c877a71e60dc7493ee712e4599e8d9.1587949032.git.Roy.Im@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb301aa028c877a71e60dc7493ee712e4599e8d9.1587949032.git.Roy.Im@diasemi.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Mon, Apr 27, 2020 at 09:57:12AM +0900, Roy Im wrote:
> +	/* It is recommended to update the patterns
> +	 * during haptic is not working in order to avoid conflict
> +	 */

I thought only in net related code the comment style is like the above
and in all other areas the /* is on a line for itself.


> +static int da7280_haptic_set_pwm(struct da7280_haptic *haptics, bool enabled)
> +{
> +	struct pwm_state state;
> +	u64 period_mag_multi;
> +	int error;
> +
> +	if (!haptics->gain) {
> +		dev_err(haptics->dev,
> +			"Please set the gain first for the pwm mode\n");
> +		return -EINVAL;

If enabled == false haptics->gain is unused. Does it make sense to only
error out for enabled == true?

> +	}
> +
> +	pwm_get_state(haptics->pwm_dev, &state);
> +	state.enabled = enabled;
> +	if (enabled) {
> +		period_mag_multi = state.period * haptics->gain;
> +		period_mag_multi >>= MAX_MAGNITUDE_SHIFT;
> +
> +		/* The interpretation of duty cycle depends on the acc_en,
> +		 * it should be between 50% and 100% for acc_en = 0.
> +		 * See datasheet 'PWM mode' section.
> +		 */
> +		if (!haptics->acc_en) {
> +			period_mag_multi += state.period;
> +			period_mag_multi /= 2;
> +		}
> +
> +		state.duty_cycle = period_mag_multi;
> +	}
> +
> +	error = pwm_apply_state(haptics->pwm_dev, &state);
> +	if (error)
> +		dev_err(haptics->dev,
> +			"failed to apply pwm state: %pE\n",
> +			ERR_PTR(error));
> +
> +	return error;
> +}
> +
> +static void da7280_haptic_enable(struct da7280_haptic *haptics)
> +{
> +	int error = 0;
> +
> +	if (haptics->enabled)
> +		return;
> +
> +	switch (haptics->op_mode) {
> +	case DA7280_DRO_MODE:
> +		/* the valid range check when acc_en is enabled */
> +		if (haptics->acc_en && haptics->level > 0x7F)
> +			haptics->level = 0x7F;
> +		else if (haptics->level > 0xFF)
> +			haptics->level = 0xFF;
> +
> +		/* Set driver level
> +		 * as a % of ACTUATOR_NOMMAX(nommax)
> +		 */
> +		error = regmap_write(haptics->regmap,
> +				     DA7280_TOP_CTL2,
> +				     haptics->level);
> +		if (error) {
> +			dev_err(haptics->dev,
> +				"i2c err %pE for driving level (%d)\n",
> +				ERR_PTR(error), haptics->level);
> +			return;
> +		}
> +		break;
> +	case DA7280_PWM_MODE:
> +		if (da7280_haptic_set_pwm(haptics, true))
> +			return;
> +		break;
> +	case DA7280_RTWM_MODE:
> +		/* The pattern will be played by
> +		 *  the PS_SEQ_ID and the PS_SEQ_LOOP
> +		 */
> +	case DA7280_ETWM_MODE:
> +		/* The pattern will be played by
> +		 * the GPI[N] state, GPI(N)_SEQUENCE_ID
> +		 * and the PS_SEQ_LOOP.
> +		 * please see the datasheet for the details.
> +		 */
> +		break;
> +	default:
> +		dev_err(haptics->dev,
> +			"Invalid Mode(%d)\n", haptics->op_mode);
> +		return;
> +	}
> +
> +	error = regmap_update_bits(haptics->regmap,
> +				   DA7280_TOP_CTL1,
> +				   DA7280_OPERATION_MODE_MASK,
> +				   haptics->op_mode);
> +	if (error) {
> +		dev_err(haptics->dev,
> +			"i2c err for op_mode setting : %pE\n",
> +			ERR_PTR(error));
> +		return;
> +	}
> +
> +	if (haptics->op_mode == DA7280_PWM_MODE ||
> +	    haptics->op_mode == DA7280_RTWM_MODE) {
> +		error = regmap_update_bits(haptics->regmap,
> +					   DA7280_TOP_CTL1,
> +					   DA7280_SEQ_START_MASK,
> +					   DA7280_SEQ_START_MASK);
> +		if (error) {
> +			dev_err(haptics->dev,
> +				"i2c err for sequence triggering : %pE\n",
> +				ERR_PTR(error));
> +			return;
> +		}
> +	}
> +
> +	haptics->enabled = true;
> +	if (haptics->length_ms && haptics->op_mode <= DA7280_PWM_MODE)
> +		schedule_delayed_work(&haptics->work_duration,
> +				      msecs_to_jiffies(haptics->length_ms));
> +}
> +
> +static void da7280_haptic_disable(struct da7280_haptic *haptics)
> +{
> +	int error;
> +
> +	if (!haptics->enabled)
> +		return;
> +
> +	/* Set to Inactive mode */
> +	error = regmap_update_bits(haptics->regmap,
> +				   DA7280_TOP_CTL1,
> +				   DA7280_OPERATION_MODE_MASK, 0);
> +	if (error) {
> +		dev_err(haptics->dev,
> +			"i2c err for op_mode off : %pE\n", ERR_PTR(error));
> +		return;
> +	}
> +
> +	switch (haptics->op_mode) {
> +	case DA7280_DRO_MODE:
> +		error = regmap_write(haptics->regmap,
> +				     DA7280_TOP_CTL2, 0);
> +		if (error) {
> +			dev_err(haptics->dev,
> +				"i2c err for DRO mode off : %pE\n",
> +				ERR_PTR(error));
> +			return;
> +		}
> +		break;
> +	case DA7280_PWM_MODE:
> +		if (da7280_haptic_set_pwm(haptics, false))
> +			return;
> +		break;
> +	case DA7280_RTWM_MODE:
> +	case DA7280_ETWM_MODE:
> +		error = regmap_update_bits(haptics->regmap,
> +					   DA7280_TOP_CTL1,
> +					   DA7280_SEQ_START_MASK, 0);
> +		if (error) {
> +			dev_err(haptics->dev,
> +				"i2c err for RTWM or ETWM mode off: %pE\n",
> +				ERR_PTR(error));
> +			return;
> +		}
> +		break;
> +	default:
> +		dev_err(haptics->dev,
> +			"Invalid Mode(%d)\n", haptics->op_mode);
> +		return;
> +	}
> +
> +	haptics->enabled = false;
> +}
> +
> +static void da7280_haptic_work_duration(struct work_struct *work)
> +{
> +	struct da7280_haptic *haptics =
> +		container_of(work, struct da7280_haptic, work_duration.work);
> +
> +	da7280_haptic_disable(haptics);
> +}
> +
> +static void da7280_haptic_work_playback(struct work_struct *work)
> +{
> +	struct da7280_haptic *haptics =
> +		container_of(work, struct da7280_haptic, work_playback);
> +	int val = haptics->val;
> +
> +	if (!!val)
> +		da7280_haptic_enable(haptics);
> +	else
> +		da7280_haptic_disable(haptics);
> +}
> +
> +static void da7280_haptic_work_setgain(struct work_struct *work)
> +{
> +	struct da7280_haptic *haptics =
> +		container_of(work, struct da7280_haptic, work_setgain);
> +	u16 gain = haptics->new_gain;
> +	int error = 0;
> +
> +	if (gain == 0)
> +		return;
> +
> +	/* DRO and PWM modes support set_gain feature
> +	 */
> +	switch (haptics->op_mode) {
> +	case DA7280_DRO_MODE:
> +		if (haptics->acc_en == 1) {
> +			haptics->level = (u8)(gain * 0x7F / 0x7fff);
> +		} else if (haptics->acc_en == 0) {
> +			haptics->level = (u8)(gain * 0xFF / 0x7fff);
> +
> +			if (gain <= 0x3FFF)
> +				haptics->level = haptics->level + 0x80;
> +			else if (gain > 0x3FFF)
> +				haptics->level = haptics->level - 0x80;
> +		} else {
> +			dev_err(haptics->dev, "Invalid acc_en %d.\n",
> +				haptics->acc_en);
> +		}
> +
> +		/* Set driver level
> +		 * as a % of ACTUATOR_NOMMAX(nommax)
> +		 */
> +		error = regmap_write(haptics->regmap,
> +				     DA7280_TOP_CTL2,
> +				     haptics->level);
> +		if (error) {
> +			dev_err(haptics->dev,
> +				"i2c err for driving level set: %pE\n",
> +				ERR_PTR(error));
> +			return;
> +		}
> +		break;
> +	case DA7280_PWM_MODE:
> +		haptics->gain = gain;
> +		if (haptics->enabled) {
> +			if (da7280_haptic_set_pwm(haptics, true))
> +				return;
> +		}
> +		break;
> +	default:
> +		dev_err(haptics->dev,
> +			"Invalid Mode(%d). Change to DRM (Constant) mode.\n",
> +			haptics->op_mode);
> +		break;
> +	}
> +}
> +
> +static int da7280_haptics_upload_effect(struct input_dev *dev,
> +					struct ff_effect *effect,
> +					struct ff_effect *old)
> +{
> +	struct da7280_haptic *haptics = input_get_drvdata(dev);
> +	int error;
> +	int tmp, i;
> +	unsigned int val;
> +	s16 data[DA7280_SNP_MEM_SIZE] = {0,};
> +
> +	switch (effect->type) {
> +	/* DRO/PWM modes support this type */
> +	case FF_CONSTANT:
> +		haptics->op_mode = haptics->const_op_mode;
> +		/* effect->replay.length should be ms base */
> +		haptics->length_ms = effect->replay.length;
> +		if (haptics->op_mode == DA7280_DRO_MODE) {
> +			tmp = effect->u.constant.level * 254;
> +			haptics->level = tmp / 0x7FFF;
> +			break;
> +		}
> +
> +		haptics->gain =	(effect->u.constant.level <= 0) ?
> +			0 : effect->u.constant.level;
> +		break;
> +
> +	/* RTWM/ETWM modes support this type */
> +	case FF_PERIODIC:
> +		if (effect->u.periodic.waveform != FF_CUSTOM) {
> +			dev_err(haptics->dev,
> +				"Only accept FF_CUSTOM type\n");
> +			return -EINVAL;
> +		}
> +
> +		/*
> +		 * Load the data and check the length.
> +		 * the data will be patterns in this case: 3 < X <= 100,
> +		 * and will be saved into the waveform memory inside DA728x.
> +		 * If X = 2, the data will be PS_SEQ_ID and PS_SEQ_LOOP .
> +		 */
> +		if (effect->u.periodic.custom_len == DA7280_CUSTOM_DATA_LEN)
> +			goto set_id_loop;
> +
> +		if (effect->u.periodic.custom_len < DA7280_CUSTOM_DATA_LEN ||
> +		    effect->u.periodic.custom_len > DA7280_SNP_MEM_SIZE) {
> +			dev_err(haptics->dev, "Invalid data size\n");
> +			return -EINVAL;
> +		}
> +
> +		if (copy_from_user(data, effect->u.periodic.custom_data,
> +				   sizeof(s16) *
> +				   effect->u.periodic.custom_len)) {
> +			dev_err(haptics->dev,
> +				"custom data load error\n");
> +			return -EFAULT;
> +		}
> +
> +		memset(haptics->snp_mem, 0, DA7280_SNP_MEM_SIZE);
> +
> +		for (i = 0; i < effect->u.periodic.custom_len; i++) {
> +			if (data[i] <= 0xff) {
> +				haptics->snp_mem[i] = (u8)data[i];
> +			} else {
> +				dev_err(haptics->dev,
> +					"Invalid data in the custom data\n");
> +				return -EINVAL;
> +			}
> +		}
> +
> +		error = da7280_haptic_mem_update(haptics);
> +		if (error) {
> +			dev_err(haptics->dev,
> +				"mem update error: %pE\n",
> +				ERR_PTR(error));
> +			return error;
> +		}
> +		break;
> +
> +set_id_loop:
> +		if (copy_from_user(data, effect->u.periodic.custom_data,
> +				   sizeof(s16) * DA7280_CUSTOM_DATA_LEN)) {
> +			dev_err(haptics->dev,
> +				"custom id/loop load error\n");
> +			return -EFAULT;
> +		}
> +
> +		haptics->ps_seq_id =
> +			data[DA7280_CUSTOM_DATA_SEQ_ID_IDX] <=
> +			DA7280_SEQ_ID_MAX ?
> +				data[DA7280_CUSTOM_DATA_SEQ_ID_IDX] : 0;
> +
> +		haptics->ps_seq_loop =
> +			data[DA7280_CUSTOM_DATA_SEQ_LOOP_IDX] <=
> +			DA7280_SEQ_LOOP_MAX ?
> +				data[DA7280_CUSTOM_DATA_SEQ_LOOP_IDX] : 0;
> +
> +		haptics->op_mode = haptics->periodic_op_mode;
> +
> +		val = haptics->ps_seq_id << DA7280_PS_SEQ_ID_SHIFT |
> +			haptics->ps_seq_loop << DA7280_PS_SEQ_LOOP_SHIFT;
> +		error = regmap_write(haptics->regmap,
> +				     DA7280_SEQ_CTL2, val);
> +		if (error) {
> +			dev_err(haptics->dev,
> +				"i2c err for driving level set: %pE\n",
> +				ERR_PTR(error));
> +			return error;
> +		}
> +		break;
> +
> +	default:
> +		dev_err(haptics->dev, "Unsupported effect type: %d\n",
> +			effect->type);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int da7280_haptics_playback(struct input_dev *dev,
> +				   int effect_id, int val)
> +{
> +	struct da7280_haptic *haptics = input_get_drvdata(dev);
> +
> +	if (!haptics->op_mode) {
> +		dev_warn(haptics->dev,
> +			 "Any effects are not uploaded yet\n");
> +		return -EPERM;
> +	}
> +
> +	haptics->val = val;
> +	schedule_work(&haptics->work_playback);
> +
> +	return 0;
> +}
> +
> +static void da7280_haptics_set_gain(struct input_dev *dev, u16 gain)
> +{
> +	struct da7280_haptic *haptics = input_get_drvdata(dev);
> +
> +	if (gain > 0x7fff)
> +		gain = 0x7fff;
> +
> +	haptics->new_gain = gain;
> +
> +	schedule_work(&haptics->work_setgain);
> +}
> +
> +static int da7280_haptic_open(struct input_dev *dev)
> +{
> +	struct da7280_haptic *haptics = input_get_drvdata(dev);
> +	int error;
> +
> +	error = regmap_update_bits(haptics->regmap,
> +				   DA7280_TOP_CTL1,
> +				   DA7280_STANDBY_EN_MASK,
> +				   DA7280_STANDBY_EN_MASK);
> +	if (error)
> +		dev_err(haptics->dev,
> +			"Failed to open haptic, i2c error : %pE\n",
> +			ERR_PTR(error));
> +
> +	return error;
> +}
> +
> +static void da7280_haptic_close(struct input_dev *dev)
> +{
> +	struct da7280_haptic *haptics = input_get_drvdata(dev);
> +	int error;
> +
> +	cancel_delayed_work_sync(&haptics->work_duration);
> +	cancel_work_sync(&haptics->work_playback);
> +	cancel_work_sync(&haptics->work_setgain);
> +
> +	error = regmap_update_bits(haptics->regmap,
> +				   DA7280_TOP_CTL1,
> +				   DA7280_OPERATION_MODE_MASK, 0);
> +	if (error)
> +		goto error_i2c;
> +
> +	if (haptics->op_mode == DA7280_DRO_MODE) {
> +		error = regmap_write(haptics->regmap,
> +				     DA7280_TOP_CTL2, 0);
> +
> +		if (error)
> +			goto error_i2c;
> +	}
> +
> +	error = regmap_update_bits(haptics->regmap,
> +				   DA7280_TOP_CTL1,
> +				   DA7280_STANDBY_EN_MASK, 0);
> +	if (error)
> +		goto error_i2c;
> +
> +	return;
> +
> +error_i2c:
> +	dev_err(haptics->dev, "DA7280-haptic i2c error : %pE\n",
> +		ERR_PTR(error));
> +}
> +
> +static u8 da7280_haptic_of_mode_str(struct device *dev,
> +				    const char *str)
> +{
> +	if (!strcmp(str, "LRA"))
> +		return DA7280_LRA;
> +	else if (!strcmp(str, "ERM-bar"))
> +		return DA7280_ERM_BAR;
> +	else if (!strcmp(str, "ERM-coin"))
> +		return DA7280_ERM_COIN;
> +
> +	dev_warn(dev, "Invalid string - set to default\n");
> +	return DA7280_LRA;
> +}
> +
> +static u8 da7280_haptic_of_gpi_mode_str(struct device *dev,
> +					const char *str)
> +{
> +	if (!strcmp(str, "Single-pattern"))
> +		return 0;
> +	else if (!strcmp(str, "Multi-pattern"))
> +		return 1;
> +
> +	dev_warn(dev, "Invalid string - set to default\n");
> +	return 0;
> +}
> +
> +static u8 da7280_haptic_of_gpi_pol_str(struct device *dev,
> +				       const char *str)
> +{
> +	if (!strcmp(str, "Rising-edge"))
> +		return 0;
> +	else if (!strcmp(str, "Falling-edge"))
> +		return 1;
> +	else if (!strcmp(str, "Both-edge"))
> +		return 2;
> +
> +	dev_warn(dev, "Invalid string - set to default\n");
> +	return 0;
> +}
> +
> +static u8 da7280_haptic_of_volt_rating_set(u32 val)
> +{
> +	u32 voltage;
> +
> +	voltage = val / DA7280_VOLTAGE_RATE_STEP + 1;
> +
> +	if (voltage > 0xFF)
> +		return 0xFF;
> +	return (u8)voltage;
> +}
> +
> +static void da7280_parse_properties(struct device *dev,
> +				    struct da7280_haptic *haptics)
> +{
> +	char gpi_str1[] = "dlg,gpi0-seq-id";
> +	char gpi_str2[] = "dlg,gpi0-mode";
> +	char gpi_str3[] = "dlg,gpi0-polarity";
> +	unsigned int i, mem[DA7280_SNP_MEM_SIZE];
> +	const char *str;
> +	u32 val;
> +
> +	if (!device_property_read_string(dev, "dlg,actuator-type", &str))
> +		haptics->dev_type =
> +			da7280_haptic_of_mode_str(dev, str);
> +	else /* if no property, then use the mode inside chip */
> +		haptics->dev_type = DA7280_DEV_MAX;
> +
> +	if (device_property_read_u32(dev, "dlg,const-op-mode", &val) >= 0)
> +		if (val == DA7280_FF_PERIODIC_PWM)
> +			haptics->const_op_mode = DA7280_PWM_MODE;
> +		else
> +			haptics->const_op_mode = DA7280_DRO_MODE;
> +	else
> +		haptics->const_op_mode = DA7280_DRO_MODE;
> +
> +	if (device_property_read_u32(dev, "dlg,periodic-op-mode", &val) >= 0)
> +		if (val == DA7280_FF_PERIODIC_ETWM)
> +			haptics->periodic_op_mode = DA7280_ETWM_MODE;
> +		else
> +			haptics->periodic_op_mode = DA7280_RTWM_MODE;
> +	else
> +		haptics->periodic_op_mode = DA7280_RTWM_MODE;
> +
> +	if (device_property_read_u32(dev, "dlg,nom-microvolt", &val) >= 0)
> +		if (val < DA7280_VOLTAGE_RATE_MAX)
> +			haptics->nommax =
> +				da7280_haptic_of_volt_rating_set(val);
> +		else
> +			haptics->nommax = DA7280_SKIP_INIT;
> +	else /* if no property, then use the value inside chip */
> +		haptics->nommax = DA7280_SKIP_INIT;
> +
> +	if (device_property_read_u32(dev, "dlg,abs-max-microvolt",
> +				     &val) >= 0)
> +		if (val < DA7280_VOLTAGE_RATE_MAX)
> +			haptics->absmax =
> +				da7280_haptic_of_volt_rating_set(val);
> +		else
> +			haptics->absmax = DA7280_SKIP_INIT;
> +	else
> +		haptics->absmax = DA7280_SKIP_INIT;
> +
> +	if (device_property_read_u32(dev, "dlg,imax-microamp", &val) >= 0)
> +		if (val < DA7280_IMAX_LIMIT)
> +			haptics->imax = (val - 28600)
> +					/ DA7280_IMAX_STEP + 1;
> +		else
> +			haptics->imax = DA7280_IMAX_DEFAULT;
> +	else
> +		haptics->imax = DA7280_IMAX_DEFAULT;
> +
> +	if (device_property_read_u32(dev, "dlg,impd-micro-ohms", &val) >= 0)
> +		if (val <= DA7280_IMPD_MAX)
> +			haptics->impd = val;
> +		else
> +			haptics->impd = DA7280_IMPD_DEFAULT;
> +	else
> +		haptics->impd = DA7280_IMPD_DEFAULT;
> +
> +	if (device_property_read_u32(dev, "dlg,resonant-freq-hz",
> +				     &val) >= 0) {
> +		if (val < DA7280_MAX_RESONAT_FREQ_HZ &&
> +		    val > DA7280_MIN_RESONAT_FREQ_HZ) {
> +			haptics->resonant_freq_h =
> +				((1000000000 / (val * 1333)) >> 7) & 0xFF;
> +			haptics->resonant_freq_l =
> +				(1000000000 / (val * 1333)) & 0x7F;
> +		} else {
> +			haptics->resonant_freq_h =
> +				DA7280_RESONT_FREQH_DFT;
> +			haptics->resonant_freq_l =
> +				DA7280_RESONT_FREQL_DFT;
> +		}
> +	} else {
> +		haptics->resonant_freq_h = DA7280_SKIP_INIT;
> +		haptics->resonant_freq_l = DA7280_SKIP_INIT;
> +	}
> +
> +	if (device_property_read_u32(dev, "dlg,ps-seq-id", &val) >= 0)
> +		if (val <= DA7280_SEQ_ID_MAX)
> +			haptics->ps_seq_id = val;
> +		else
> +			haptics->ps_seq_id = 0;
> +	else /* if no property, set to zero as a default do nothing */
> +		haptics->ps_seq_id = 0;
> +
> +	if (device_property_read_u32(dev, "dlg,ps-seq-loop", &val) >= 0)
> +		if (val <= DA7280_SEQ_LOOP_MAX)
> +			haptics->ps_seq_loop = val;
> +		else
> +			haptics->ps_seq_loop = 0;
> +	else /* if no property, then do nothing */
> +		haptics->ps_seq_loop = 0;
> +
> +	/* GPI0~2 Control */
> +	for (i = 0; i < 3; i++) {
> +		gpi_str1[7] = '0' + i;
> +		if (device_property_read_u32 (dev, gpi_str1, &val) >= 0)
> +			if (val <= DA7280_SEQ_ID_MAX)
> +				haptics->gpi_ctl[i].seq_id = val;
> +			else
> +				haptics->gpi_ctl[i].seq_id =
> +					DA7280_GPI_SEQ_ID_DFT + i;
> +		else /* if no property, then do nothing */
> +			haptics->gpi_ctl[i].seq_id =
> +				DA7280_GPI_SEQ_ID_DFT + i;
> +
> +		gpi_str2[7] = '0' + i;
> +		if (!device_property_read_string(dev, gpi_str2, &str))
> +			haptics->gpi_ctl[i].mode =
> +				da7280_haptic_of_gpi_mode_str(dev, str);
> +		else
> +			haptics->gpi_ctl[i].mode = 0;
> +
> +		gpi_str3[7] = '0' + i;
> +		if (!device_property_read_string(dev, gpi_str3, &str))
> +			haptics->gpi_ctl[i].polarity =
> +				da7280_haptic_of_gpi_pol_str(dev, str);
> +		else
> +			haptics->gpi_ctl[i].polarity = 0;
> +	}
> +
> +	haptics->bemf_sense_en =
> +		device_property_read_bool(dev, "dlg,bemf-sens-enable");
> +	haptics->freq_track_en =
> +		device_property_read_bool(dev, "dlg,freq-track-enable");
> +	haptics->acc_en =
> +		device_property_read_bool(dev, "dlg,acc-enable");
> +	haptics->rapid_stop_en =
> +		device_property_read_bool(dev, "dlg,rapid-stop-enable");
> +	haptics->amp_pid_en =
> +		device_property_read_bool(dev, "dlg,amp-pid-enable");
> +
> +	if (device_property_read_u32_array(dev, "dlg,mem-array",
> +					   &mem[0],
> +					   DA7280_SNP_MEM_SIZE) >= 0) {
> +		haptics->mem_update = true;
> +		memset(haptics->snp_mem, 0, DA7280_SNP_MEM_SIZE);
> +		for (i = 0; i < DA7280_SNP_MEM_SIZE; i++) {
> +			if (mem[i] <= 0xff) {
> +				haptics->snp_mem[i] = (u8)mem[i];
> +			} else {
> +				dev_err(haptics->dev,
> +					"Invalid data in mem-array\n");
> +				haptics->mem_update = false;
> +				break;
> +			}
> +		}
> +	} else {
> +		haptics->mem_update = false;
> +	}
> +}
> +
> +static irqreturn_t da7280_irq_handler(int irq, void *data)
> +{
> +	struct da7280_haptic *haptics = data;
> +	struct device *dev = haptics->dev;
> +	u8 events[IRQ_NUM];
> +	int error;
> +
> +	/* Check what events have happened */
> +	error = regmap_bulk_read(haptics->regmap,
> +				 DA7280_IRQ_EVENT1,
> +				 events, IRQ_NUM);
> +	if (error)
> +		goto error_i2c;
> +
> +	/* Clear events */
> +	error = regmap_write(haptics->regmap,
> +			     DA7280_IRQ_EVENT1, events[0]);
> +	if (error)
> +		goto error_i2c;
> +
> +	if (events[0] & DA7280_E_SEQ_FAULT_MASK) {
> +		/* Stop first if Haptic is working
> +		 * Otherwise, the fault may happen continually
> +		 * even though the bit is cleared.
> +		 */
> +		error = regmap_update_bits(haptics->regmap,
> +					   DA7280_TOP_CTL1,
> +					   DA7280_OPERATION_MODE_MASK, 0);
> +		if (error)
> +			goto error_i2c;
> +	}
> +
> +	if (events[0] & DA7280_E_SEQ_DONE_MASK)
> +		haptics->enabled = false;
> +
> +	if (events[0] & DA7280_E_WARNING_MASK) {
> +		if (events[1] & DA7280_E_LIM_DRIVE_MASK ||
> +		    events[1] & DA7280_E_LIM_DRIVE_ACC_MASK)
> +			dev_warn(dev, "Please reduce the driver level\n");
> +		if (events[1] & DA7280_E_MEM_TYPE_MASK)
> +			dev_warn(dev, "Please check the mem data format\n");
> +		if (events[1] & DA7280_E_OVERTEMP_WARN_MASK)
> +			dev_warn(dev, "Over-temperature warning\n");
> +	}
> +
> +	if (events[0] & DA7280_E_SEQ_FAULT_MASK) {
> +		if (events[2] & DA7280_E_SEQ_ID_FAULT_MASK)
> +			dev_info(dev, "Please reload PS_SEQ_ID & mem data\n");
> +		if (events[2] & DA7280_E_MEM_FAULT_MASK)
> +			dev_info(dev, "Please reload the mem data\n");
> +		if (events[2] & DA7280_E_PWM_FAULT_MASK)
> +			dev_info(dev, "Please restart PWM interface\n");
> +	}
> +
> +	return IRQ_HANDLED;
> +
> +error_i2c:
> +	dev_err(dev, "da7280 i2c error : %pE\n", ERR_PTR(error));
> +	return IRQ_NONE;
> +}
> +
> +static int da7280_init(struct da7280_haptic *haptics)
> +{
> +	int error, i;
> +	unsigned int val = 0;
> +	u32 v2i_factor;
> +	u8 mask = 0;
> +
> +	/* If device type is DA7280_DEV_MAX,
> +	 * then just use default value inside chip.
> +	 */
> +	if (haptics->dev_type == DA7280_DEV_MAX) {
> +		error = regmap_read(haptics->regmap, DA7280_TOP_CFG1, &val);
> +		if (error)
> +			goto error_i2c;
> +		if (val & DA7280_ACTUATOR_TYPE_MASK)
> +			haptics->dev_type = DA7280_ERM_COIN;
> +		else
> +			haptics->dev_type = DA7280_LRA;
> +	}
> +
> +	/* Apply user settings */
> +	if (haptics->dev_type == DA7280_LRA) {
> +		if (haptics->resonant_freq_l != DA7280_SKIP_INIT) {
> +			error = regmap_write(haptics->regmap,
> +					     DA7280_FRQ_LRA_PER_H,
> +					     haptics->resonant_freq_h);
> +			if (error)
> +				goto error_i2c;
> +			error = regmap_write(haptics->regmap,
> +					     DA7280_FRQ_LRA_PER_L,
> +					     haptics->resonant_freq_l);
> +			if (error)
> +				goto error_i2c;
> +		}
> +	} else if (haptics->dev_type == DA7280_ERM_COIN) {
> +		error = regmap_update_bits(haptics->regmap,
> +					   DA7280_TOP_INT_CFG1,
> +					   DA7280_BEMF_FAULT_LIM_MASK, 0);
> +		if (error)
> +			goto error_i2c;
> +
> +		mask = DA7280_TST_CALIB_IMPEDANCE_DIS_MASK |
> +			DA7280_V2I_FACTOR_FREEZE_MASK;
> +		val = DA7280_TST_CALIB_IMPEDANCE_DIS_MASK |
> +			DA7280_V2I_FACTOR_FREEZE_MASK;
> +		error = regmap_update_bits(haptics->regmap,
> +					   DA7280_TOP_CFG4,
> +					   mask, val);
> +		if (error)
> +			goto error_i2c;
> +
> +		haptics->acc_en = false;
> +		haptics->rapid_stop_en = false;
> +		haptics->amp_pid_en = false;
> +	}
> +
> +	mask = DA7280_ACTUATOR_TYPE_MASK |
> +			DA7280_BEMF_SENSE_EN_MASK |
> +			DA7280_FREQ_TRACK_EN_MASK |
> +			DA7280_ACCELERATION_EN_MASK |
> +			DA7280_RAPID_STOP_EN_MASK |
> +			DA7280_AMP_PID_EN_MASK;
> +
> +	val = (haptics->dev_type ? 1 : 0)
> +			<< DA7280_ACTUATOR_TYPE_SHIFT |
> +		(haptics->bemf_sense_en ? 1 : 0)
> +			<< DA7280_BEMF_SENSE_EN_SHIFT |
> +		(haptics->freq_track_en ? 1 : 0)
> +			<< DA7280_FREQ_TRACK_EN_SHIFT |
> +		(haptics->acc_en ? 1 : 0)
> +			<< DA7280_ACCELERATION_EN_SHIFT |
> +		(haptics->rapid_stop_en ? 1 : 0)
> +			<< DA7280_RAPID_STOP_EN_SHIFT |
> +		(haptics->amp_pid_en ? 1 : 0)
> +			<< DA7280_AMP_PID_EN_SHIFT;
> +
> +	error = regmap_update_bits(haptics->regmap,
> +				   DA7280_TOP_CFG1, mask, val);
> +	if (error)
> +		goto error_i2c;
> +
> +	error = regmap_update_bits(haptics->regmap,
> +				   DA7280_TOP_CFG5,
> +				   DA7280_V2I_FACTOR_OFFSET_EN_MASK,
> +				   haptics->acc_en ?
> +				   DA7280_V2I_FACTOR_OFFSET_EN_MASK : 0);
> +	if (error)
> +		goto error_i2c;
> +
> +	error = regmap_update_bits(haptics->regmap,
> +				   DA7280_TOP_CFG2,
> +				   DA7280_MEM_DATA_SIGNED_MASK,
> +				   haptics->acc_en ?
> +				   0 : DA7280_MEM_DATA_SIGNED_MASK);
> +	if (error)
> +		goto error_i2c;
> +
> +	if (haptics->nommax != DA7280_SKIP_INIT) {
> +		error = regmap_write(haptics->regmap,
> +				     DA7280_ACTUATOR1,
> +				     haptics->nommax);
> +		if (error)
> +			goto error_i2c;
> +	}
> +
> +	if (haptics->absmax != DA7280_SKIP_INIT) {
> +		error = regmap_write(haptics->regmap, DA7280_ACTUATOR2,
> +				     haptics->absmax);
> +		if (error)
> +			goto error_i2c;
> +	}
> +
> +	error = regmap_update_bits(haptics->regmap,
> +				   DA7280_ACTUATOR3,
> +				   DA7280_IMAX_MASK,
> +				   haptics->imax);
> +	if (error)
> +		goto error_i2c;
> +
> +	v2i_factor =
> +		haptics->impd * (haptics->imax + 4) / 1610400;
> +	error = regmap_write(haptics->regmap,
> +			     DA7280_CALIB_V2I_L,
> +			     v2i_factor & 0xff);
> +	if (error)
> +		goto error_i2c;
> +	error = regmap_write(haptics->regmap,
> +			     DA7280_CALIB_V2I_H,
> +			     v2i_factor >> 8);
> +	if (error)
> +		goto error_i2c;
> +
> +	error = regmap_update_bits(haptics->regmap,
> +				   DA7280_TOP_CTL1,
> +				   DA7280_STANDBY_EN_MASK,
> +				   DA7280_STANDBY_EN_MASK);
> +	if (error)
> +		goto error_i2c;
> +
> +	if (haptics->mem_update) {
> +		error = da7280_haptic_mem_update(haptics);
> +		if (error)
> +			goto error_i2c;
> +	}
> +
> +	/* Set  PS_SEQ_ID and PS_SEQ_LOOP */
> +	val = haptics->ps_seq_id << DA7280_PS_SEQ_ID_SHIFT |
> +		haptics->ps_seq_loop << DA7280_PS_SEQ_LOOP_SHIFT;
> +	error = regmap_write(haptics->regmap,
> +			     DA7280_SEQ_CTL2, val);
> +	if (error)
> +		goto error_i2c;
> +
> +	/* GPI(N) CTL */
> +	for (i = 0; i < 3; i++) {
> +		val = haptics->gpi_ctl[i].seq_id
> +				<< DA7280_GPI0_SEQUENCE_ID_SHIFT |
> +			haptics->gpi_ctl[i].mode
> +				<< DA7280_GPI0_MODE_SHIFT |
> +			haptics->gpi_ctl[i].polarity
> +				<< DA7280_GPI0_POLARITY_SHIFT;
> +		error = regmap_write(haptics->regmap,
> +				     DA7280_GPI_0_CTL + i, val);
> +		if (error)
> +			goto error_i2c;
> +	}
> +
> +	/* Mask ADC_SAT_M bit as default */
> +	error = regmap_update_bits(haptics->regmap,
> +				   DA7280_IRQ_MASK2,
> +				   DA7280_ADC_SAT_M_MASK,
> +				   DA7280_ADC_SAT_M_MASK);
> +	if (error)
> +		goto error_i2c;
> +
> +	/* Clear Interrupts */
> +	error = regmap_write(haptics->regmap, DA7280_IRQ_EVENT1, 0xff);
> +	if (error)
> +		goto error_i2c;
> +
> +	error = regmap_update_bits(haptics->regmap,
> +				   DA7280_IRQ_MASK1,
> +				   DA7280_SEQ_FAULT_M_MASK
> +				   | DA7280_SEQ_DONE_M_MASK, 0);
> +	if (error)
> +		goto error_i2c;
> +
> +	haptics->enabled = false;
> +	return 0;
> +
> +error_i2c:
> +	dev_err(haptics->dev,
> +		"haptic init - I2C error : %pE\n", ERR_PTR(error));
> +	return error;
> +}
> +
> +/* Valid format for ps_seq_id
> + * echo X > ps_seq_id
> + * ex) echo 2 > /sys/class/..../ps_seq_id
> + * 0 <= X <= 15.
> + */
> +static ssize_t ps_seq_id_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf,
> +			       size_t count)
> +{
> +	struct da7280_haptic *haptics = dev_get_drvdata(dev);
> +	long val = 0xff;
> +	int error;
> +
> +	if (haptics->enabled)
> +		return -EBUSY;
> +
> +	if (kstrtol(&buf[0], 0, &val) < 0)
> +		goto err;
> +
> +	error = regmap_update_bits(haptics->regmap,
> +				   DA7280_SEQ_CTL2,
> +				   DA7280_PS_SEQ_ID_MASK,
> +				   (val & 0xf) >> DA7280_PS_SEQ_ID_SHIFT);
> +	if (error) {
> +		dev_err(haptics->dev,
> +			"failed to update register : %pE\n",
> +			ERR_PTR(error));
> +		return error;
> +	}
> +
> +	haptics->ps_seq_id = val & 0xf;
> +
> +	return count;
> +
> +err:
> +	dev_err(dev, "Invalid input\n");
> +	return count;
> +}
> +
> +static ssize_t ps_seq_id_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct da7280_haptic *haptics = dev_get_drvdata(dev);
> +	int error;
> +	unsigned int val;
> +
> +	error = regmap_read(haptics->regmap, DA7280_SEQ_CTL2, &val);
> +	if (error) {
> +		dev_err(haptics->dev,
> +			"failed to read register : %pE\n",
> +			ERR_PTR(error));
> +		return error;
> +	}
> +	val = (val & DA7280_PS_SEQ_ID_MASK)
> +		>> DA7280_PS_SEQ_ID_SHIFT;
> +
> +	return sprintf(buf, "ps_seq_id is %d\n", val);
> +}
> +
> +/* Valid format for ps_seq_loop
> + * echo X > ps_seq_loop
> + * ex) echo 2 > /sys/class/..../ps_seq_loop
> + * 0 <= X <= 15.
> + */
> +static ssize_t ps_seq_loop_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf,
> +				 size_t count)
> +{
> +	struct da7280_haptic *haptics = dev_get_drvdata(dev);
> +	long val = 0xff;
> +	int error;
> +
> +	if (haptics->enabled)
> +		return -EBUSY;
> +
> +	if (kstrtol(&buf[0], 0, &val) < 0)
> +		goto err;
> +
> +	error = regmap_update_bits(haptics->regmap,
> +				   DA7280_SEQ_CTL2,
> +				   DA7280_PS_SEQ_LOOP_MASK,
> +				   (val & 0xF) << DA7280_PS_SEQ_LOOP_SHIFT);
> +	if (error) {
> +		dev_err(haptics->dev,
> +			"failed to update register : %pE\n",
> +			ERR_PTR(error));
> +		return error;
> +	}
> +
> +	haptics->ps_seq_loop = (val & 0xF);
> +
> +	return count;
> +err:
> +	dev_err(dev, "Invalid input value!\n");
> +	return count;
> +}
> +
> +static ssize_t ps_seq_loop_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct da7280_haptic *haptics = dev_get_drvdata(dev);
> +	int error;
> +	unsigned int val;
> +
> +	error = regmap_read(haptics->regmap, DA7280_SEQ_CTL2, &val);
> +	if (error) {
> +		dev_err(haptics->dev,
> +			"failed to read register : %pE\n",
> +			ERR_PTR(error));
> +		return error;
> +	}
> +	val = (val & DA7280_PS_SEQ_LOOP_MASK)
> +				>> DA7280_PS_SEQ_LOOP_SHIFT;
> +
> +	return sprintf(buf, "ps_seq_loop is %d\n", val);
> +}
> +
> +/* Valid format for GPIx_SEQUENCE_ID
> + * echo X > ./gpi_seq_id0
> + * Range of X: 0 <= X <= 15
> + * ex)
> + *	echo 1 > /sys/class/..../gpi_seq_id0
> + *	echo 2 > /sys/class/..../gpi_seq_id1
> + *	echo 3 > /sys/class/..../gpi_seq_id2
> + */
> +static ssize_t gpi_seq_id0_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf,
> +				 size_t count)
> +{
> +	struct da7280_haptic *haptics = dev_get_drvdata(dev);
> +	long val = 0xff;
> +	int error;
> +
> +	if (haptics->enabled)
> +		return -EBUSY;
> +
> +	if (kstrtol(&buf[0], 0, &val) < 0)
> +		goto err;
> +
> +	error = regmap_update_bits(haptics->regmap,
> +				   DA7280_GPI_0_CTL,
> +				   DA7280_GPI0_SEQUENCE_ID_MASK,
> +				   (val & 0xf)
> +				   << DA7280_GPI0_SEQUENCE_ID_SHIFT);
> +	if (error) {
> +		dev_err(haptics->dev,
> +			"failed to update register : %pE\n",
> +			ERR_PTR(error));
> +		return error;
> +	}
> +
> +	haptics->gpi_ctl[0].seq_id = val & 0xf;
> +
> +	return count;
> +
> +err:
> +	dev_err(dev, "Invalid input\n");
> +	return count;
> +}
> +
> +static ssize_t gpi_seq_id0_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct da7280_haptic *haptics = dev_get_drvdata(dev);
> +	int error;
> +	unsigned int val;
> +
> +	error = regmap_read(haptics->regmap, DA7280_GPI_0_CTL, &val);
> +	if (error) {
> +		dev_err(haptics->dev,
> +			"failed to read register : %pE\n",
> +			ERR_PTR(error));
> +		return error;
> +	}
> +	val = (val & DA7280_GPI0_SEQUENCE_ID_MASK)
> +		>> DA7280_GPI0_SEQUENCE_ID_SHIFT;
> +
> +	return sprintf(buf, "gpi_seq_id0 is %d\n", val);
> +}
> +
> +static ssize_t gpi_seq_id1_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf,
> +				 size_t count)
> +{
> +	struct da7280_haptic *haptics = dev_get_drvdata(dev);
> +	long val = 0xff;
> +	int error;
> +
> +	if (haptics->enabled)
> +		return -EBUSY;
> +
> +	if (kstrtol(&buf[0], 0, &val) < 0)
> +		goto err;
> +
> +	error = regmap_update_bits(haptics->regmap,
> +				   DA7280_GPI_1_CTL,
> +				   DA7280_GPI1_SEQUENCE_ID_MASK,
> +				   (val & 0xf)
> +				   << DA7280_GPI1_SEQUENCE_ID_SHIFT);
> +	if (error) {
> +		dev_err(haptics->dev,
> +			"failed to update register : %pE\n",
> +			ERR_PTR(error));
> +		return error;
> +	}
> +
> +	haptics->gpi_ctl[1].seq_id = val & 0xf;
> +
> +	return count;
> +
> +err:
> +	dev_err(dev, "Invalid input\n");
> +	return count;
> +}
> +
> +static ssize_t gpi_seq_id1_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct da7280_haptic *haptics = dev_get_drvdata(dev);
> +	int error;
> +	unsigned int val;
> +
> +	error = regmap_read(haptics->regmap, DA7280_GPI_1_CTL, &val);
> +	if (error) {
> +		dev_err(haptics->dev,
> +			"failed to read register : %pE\n",
> +			ERR_PTR(error));
> +		return error;
> +	}
> +	val = (val & DA7280_GPI1_SEQUENCE_ID_MASK)
> +		>> DA7280_GPI1_SEQUENCE_ID_SHIFT;
> +
> +	return sprintf(buf, "gpi_seq_id1 is %d\n", val);
> +}
> +
> +static ssize_t gpi_seq_id2_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf,
> +				 size_t count)
> +{
> +	struct da7280_haptic *haptics = dev_get_drvdata(dev);
> +	long val = 0xff;
> +	int error;
> +
> +	if (haptics->enabled)
> +		return -EBUSY;
> +
> +	if (kstrtol(&buf[0], 0, &val) < 0)
> +		goto err;
> +
> +	error = regmap_update_bits(haptics->regmap,
> +				   DA7280_GPI_2_CTL,
> +				   DA7280_GPI2_SEQUENCE_ID_MASK,
> +				   (val & 0xf)
> +				   << DA7280_GPI2_SEQUENCE_ID_SHIFT);
> +	if (error) {
> +		dev_err(haptics->dev,
> +			"failed to update register : %pE\n",
> +			ERR_PTR(error));
> +		return error;
> +	}
> +
> +	haptics->gpi_ctl[2].seq_id = val & 0xf;
> +
> +	return count;
> +
> +err:
> +	dev_err(dev, "Invalid input\n");
> +	return count;
> +}
> +
> +static ssize_t gpi_seq_id2_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct da7280_haptic *haptics = dev_get_drvdata(dev);
> +	int error;
> +	unsigned int val;
> +
> +	error = regmap_read(haptics->regmap, DA7280_GPI_2_CTL, &val);
> +	if (error) {
> +		dev_err(haptics->dev,
> +			"failed to read register : %pE\n",
> +			ERR_PTR(error));
> +		return error;
> +	}
> +	val = (val & DA7280_GPI2_SEQUENCE_ID_MASK)
> +		>> DA7280_GPI2_SEQUENCE_ID_SHIFT;
> +
> +	return sprintf(buf, "gpi_seq_id2 is %d\n", val);
> +}
> +
> +#define MAX_PTN_REGS DA7280_SNP_MEM_SIZE
> +#define MAX_USER_INPUT_LEN (5 * DA7280_SNP_MEM_SIZE)
> +struct parse_data_t {
> +	int len;
> +	u8 val[MAX_PTN_REGS];
> +};
> +
> +static int da7280_parse_args(struct device *dev,
> +			     char *cmd, struct parse_data_t *ptn)
> +{
> +	struct da7280_haptic *haptics = dev_get_drvdata(dev);
> +	char *tok;		/* used to separate tokens */
> +	static const char ct[] = " \t"; /* space or tab delimits the tokens */
> +	int tok_count = 0;	/* total number of tokens parsed */
> +	int i = 0, val;
> +
> +	ptn->len = 0;
> +
> +	/* parse the input string */
> +	while ((tok = strsep(&cmd, ct)) != NULL) {
> +		/* this is a value to be written to the register */
> +		if (kstrtouint(tok, 0, &val) < 0) {
> +			dev_err(haptics->dev,
> +				"failed to read from %s\n", tok);
> +			break;
> +		}
> +
> +		if (i < MAX_PTN_REGS) {
> +			ptn->val[i] = val;
> +			i++;
> +		}
> +		tok_count++;
> +	}
> +
> +	/* decide whether it is a read or write operation based on the
> +	 * value of tok_count and count_flag.
> +	 * tok_count = 0: no inputs, invalid case.
> +	 * tok_count = 1: write one value.
> +	 * tok_count > 1: write multiple values/patterns.
> +	 */
> +	switch (tok_count) {
> +	case 0:
> +		return -EINVAL;
> +	case 1:
> +		ptn->len = 1;
> +		break;
> +	default:
> +		ptn->len = i;
> +	}
> +	return 0;
> +}
> +
> +static ssize_t
> +patterns_store(struct device *dev,
> +	       struct device_attribute *attr,
> +	       const char *buf,
> +	       size_t count)
> +{
> +	struct da7280_haptic *haptics = dev_get_drvdata(dev);
> +	struct parse_data_t mem;
> +	char cmd[MAX_USER_INPUT_LEN];
> +	unsigned int val;
> +	int error;
> +
> +	error = regmap_read(haptics->regmap, DA7280_MEM_CTL1, &val);
> +	if (error)
> +		return error;
> +
> +	if (count > MAX_USER_INPUT_LEN)
> +		memcpy(cmd, buf, MAX_USER_INPUT_LEN);
> +	else
> +		memcpy(cmd, buf, count);
> +
> +	/* chop of '\n' introduced by echo at the end of the input */
> +	if (cmd[count - 1] == '\n')
> +		cmd[count - 1] = '\0';
> +
> +	if (da7280_parse_args(dev, cmd, &mem) < 0)
> +		return -EINVAL;
> +
> +	memset(haptics->snp_mem, 0, DA7280_SNP_MEM_SIZE);
> +	memcpy(haptics->snp_mem, mem.val, mem.len);
> +
> +	error = da7280_haptic_mem_update(haptics);
> +	if (error)
> +		return error;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(ps_seq_id);
> +static DEVICE_ATTR_RW(ps_seq_loop);
> +static DEVICE_ATTR_RW(gpi_seq_id0);
> +static DEVICE_ATTR_RW(gpi_seq_id1);
> +static DEVICE_ATTR_RW(gpi_seq_id2);
> +static DEVICE_ATTR_WO(patterns);
> +static struct attribute *da7280_sysfs_attr[] = {
> +	&dev_attr_ps_seq_id.attr,
> +	&dev_attr_ps_seq_loop.attr,
> +	&dev_attr_gpi_seq_id0.attr,
> +	&dev_attr_gpi_seq_id1.attr,
> +	&dev_attr_gpi_seq_id2.attr,
> +	&dev_attr_patterns.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group da7280_attr_group = {
> +	.attrs = da7280_sysfs_attr,
> +};
> +
> +static int da7280_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct da7280_haptic *haptics;
> +	struct input_dev *input_dev;
> +	struct ff_device *ff;
> +	struct pwm_state state;
> +	unsigned int period2freq;

This variable could be local to the if body below.

> +	int error;
> +
> +	haptics = devm_kzalloc(dev, sizeof(*haptics), GFP_KERNEL);
> +	if (!haptics)
> +		return -ENOMEM;
> +	haptics->dev = dev;
> +
> +	if (!client->irq) {
> +		dev_err(dev, "No IRQ configured\n");
> +		return -EINVAL;
> +	}
> +
> +	da7280_parse_properties(dev, haptics);
> +
> +	if (haptics->const_op_mode == DA7280_PWM_MODE) {
> +		haptics->pwm_dev = devm_pwm_get(dev, NULL);
> +		if (IS_ERR(haptics->pwm_dev)) {
> [...]
> +	error = devm_request_threaded_irq(dev, client->irq, NULL,
> +					  da7280_irq_handler,
> +					  IRQF_ONESHOT,
> +					  "da7280-haptics", haptics);
> +	if (error)
> +		dev_err(dev, "Failed to request IRQ : %d\n", client->irq);

I'd say emitting the error code would be helpful here, the actual irq
number not so.

> +static struct i2c_driver da7280_driver = {
> +	.driver		= {
> +		.name	= "da7280",
> +		.of_match_table = of_match_ptr(da7280_of_match),
> +		.pm	= &da7280_pm_ops,
> +	},
> +	.probe	= da7280_probe,
> +	.id_table	= da7280_i2c_id,

Inconsistent alignment of the = signs. My preference is a single space
before the equal sign, but aligning them in the same column is another
usual style.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
