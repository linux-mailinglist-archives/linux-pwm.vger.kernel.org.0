Return-Path: <linux-pwm+bounces-6324-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 627EBAD757D
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 17:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 304017ABEBA
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 15:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F4229827D;
	Thu, 12 Jun 2025 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqfvEvcO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D041BC2A;
	Thu, 12 Jun 2025 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741424; cv=none; b=PMuCKim+UJjsJQhimQEMcAPqWfUYoUSlgtaK4Tf6URTvpWt28PzOIp8l5coM6L4Y6ydxeBHetgYCeY9WfMiPg2gfibTOxvOzUMLwVO9YwWfR9+siYdyS8nuvIN7L7yvU9jcg4Avp+b+kkKI603/HSWd3x7F/wYVhCUazu0s5GA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741424; c=relaxed/simple;
	bh=Dvj5LFY5RO3EHClSFerz0zlL/OIN8SVF52drVXU9e9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LB5dHlqkQlibQx2Nw/ObJakxcXOrVrchoxyA5NJULxUzShQDVry8lZsfDgRtexWE4feGBBOKHAOea2+iracTFw/36ktgsgywjyNMNrAbTwplP6OKykeWeSqYvj4eIo225tQZBlfoboiBA3eloAmqSBv7rFrCzfK4rctKMgFtj/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqfvEvcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C25C4CEEA;
	Thu, 12 Jun 2025 15:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749741424;
	bh=Dvj5LFY5RO3EHClSFerz0zlL/OIN8SVF52drVXU9e9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HqfvEvcOZFoBdJFrNxY0X9fH/8dRKiYJmEf4AZYQlaCdHh0YIJgKqRJV+aKhgRqH9
	 wNepx0Bw2y/OGLaUW5aLcBFAibY+WZdw3V0TCx8CCOYhQQV7+R07o2Xg5MLnUao7Fi
	 uwy+JtVN4hDL6AtNARIO7wF0B3dR74m8eLd00jIXSFxUz8wyQML7uoAnFGBo9vD4lM
	 hNWOoYHRheBLwp4Iqs3oyRzGr3kBBaqm/6Sl6FQVdmY8MwlkVvmdRXPfge3k8HX585
	 N8fV266awqDLEfJjqHweDzXs78MMGnCiWymwcM3zKGdtAvb8qLWlbGc1qDLfroCozf
	 5PppsL8oMZVDA==
Date: Thu, 12 Jun 2025 16:16:58 +0100
From: Lee Jones <lee@kernel.org>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v4 14/20] mfd: adp5585: add support for input devices
Message-ID: <20250612151658.GL381401@google.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
 <20250521-dev-adp5589-fw-v4-14-f2c988d7a7a0@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250521-dev-adp5589-fw-v4-14-f2c988d7a7a0@analog.com>

On Wed, 21 May 2025, Nuno Sá via B4 Relay wrote:

> From: Nuno Sá <nuno.sa@analog.com>
> 
> The ADP558x family supports a built in keypad matrix decoder which can
> be added as an Input device. In order to both support the Input and the
> GPIO device, we need to create a bitmap of the supported pins and track
> their usage since they can either be used as GPIOs (GPIs) or as part of
> the keymap.
> 
> We also need to mark special pins busy in case some features are being
> used (ex: pwm or reset events).
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/mfd/adp5585.c       | 33 +++++++++++++++++++++++++++++++++
>  include/linux/mfd/adp5585.h |  9 +++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> index 6737d622a7ed9f280c439399f3709ca8162dee01..122e2c95385f8d5cbd7839db78dda77ad7ba4ae4 100644
> --- a/drivers/mfd/adp5585.c
> +++ b/drivers/mfd/adp5585.c
> @@ -22,17 +22,20 @@
>  enum {
>  	ADP5585_DEV_GPIO,
>  	ADP5585_DEV_PWM,
> +	ADP5585_DEV_INPUT,
>  	ADP5585_DEV_MAX
>  };
>  
>  static const struct mfd_cell adp5585_devs[ADP5585_DEV_MAX] = {
>  	MFD_CELL_NAME("adp5585-gpio"),
>  	MFD_CELL_NAME("adp5585-pwm"),
> +	MFD_CELL_NAME("adp5585-keys"),
>  };
>  
>  static const struct mfd_cell adp5589_devs[] = {
>  	MFD_CELL_NAME("adp5589-gpio"),
>  	MFD_CELL_NAME("adp5589-pwm"),
> +	MFD_CELL_NAME("adp5589-keys"),
>  };
>  
>  static const struct regmap_range adp5585_volatile_ranges[] = {
> @@ -173,6 +176,7 @@ static const struct adp5585_regs adp5585_regs = {
>  	.reset_cfg = ADP5585_RESET_CFG,
>  	.reset1_event_a = ADP5585_RESET1_EVENT_A,
>  	.reset2_event_a = ADP5585_RESET2_EVENT_A,
> +	.pin_cfg_a = ADP5585_PIN_CONFIG_A,
>  };
>  
>  static const struct adp5585_regs adp5589_regs = {
> @@ -183,6 +187,7 @@ static const struct adp5585_regs adp5589_regs = {
>  	.reset_cfg = ADP5589_RESET_CFG,
>  	.reset1_event_a = ADP5589_RESET1_EVENT_A,
>  	.reset2_event_a = ADP5589_RESET2_EVENT_A,
> +	.pin_cfg_a = ADP5589_PIN_CONFIG_A,
>  };
>  
>  static int adp5585_validate_event(const struct adp5585_dev *adp5585, unsigned int ev)
> @@ -236,6 +241,8 @@ static int adp5585_fill_variant_config(struct adp5585_dev *adp5585,
>  		*regmap_config = adp5585_regmap_config_template;
>  		adp5585->id = ADP5585_MAN_ID_VALUE;
>  		adp5585->regs = &adp5585_regs;
> +		adp5585->n_pins = ADP5585_PIN_MAX;
> +		adp5585->reset2_out = ADP5585_RESET2_OUT;
>  		if (adp5585->variant == ADP5585_01)
>  			adp5585->has_pin6 = true;
>  		break;
> @@ -247,6 +254,8 @@ static int adp5585_fill_variant_config(struct adp5585_dev *adp5585,
>  		adp5585->regs = &adp5589_regs;
>  		adp5585->has_unlock = true;
>  		adp5585->has_pin6 = true;
> +		adp5585->n_pins = ADP5589_PIN_MAX;
> +		adp5585->reset2_out = ADP5589_RESET2_OUT;
>  		break;
>  	default:
>  		return -ENODEV;
> @@ -434,6 +443,8 @@ static int adp5585_add_devices(const struct adp5585_dev *adp5585)
>  		cells = adp5589_devs;
>  
>  	if (device_property_present(adp5585->dev, "#pwm-cells")) {
> +		/* Make sure the PWM output pin is not used by the GPIO or INPUT  devices */

Nit: Remove the double space.

> +		__set_bit(ADP5585_PWM_OUT, adp5585->pin_usage);
>  		ret = mfd_add_devices(adp5585->dev, PLATFORM_DEVID_AUTO,
>  				      &cells[ADP5585_DEV_PWM], 1, NULL, 0, NULL);
>  		if (ret)
> @@ -449,6 +460,15 @@ static int adp5585_add_devices(const struct adp5585_dev *adp5585)
>  		}
>  	}
>  
> +	if (device_property_present(adp5585->dev, "adi,keypad-pins")) {
> +		ret = mfd_add_devices(adp5585->dev, PLATFORM_DEVID_AUTO,
> +				      &cells[ADP5585_DEV_INPUT], 1, NULL, 0, NULL);
> +		if (ret) {
> +			ret = dev_err_probe(adp5585->dev, ret, "Failed to add input device\n");
> +			goto out_error;
> +		}
> +	}
> +
>  	return devm_add_action_or_reset(adp5585->dev, adp5585_remove_devices, adp5585->dev);
>  out_error:
>  	mfd_remove_devices(adp5585->dev);
> @@ -518,6 +538,10 @@ static int adp5585_setup(struct adp5585_dev *adp5585)
>  	unsigned int reg_val, i;
>  	int ret;
>  
> +	/* if pin_6 (ROW5/GPI6) is not available, make sure to mark it as "busy" */

Same thing about comments (I'll not mention it again).

> +	if (!adp5585->has_pin6)
> +		__set_bit(5, adp5585->pin_usage);

Please define all magic numbers.

> +
>  	/* Configure the device with reset and unlock events */
>  	for (i = 0; i < adp5585->nkeys_unlock; i++) {
>  		ret = regmap_write(adp5585->regmap, ADP5589_UNLOCK1 + i,
> @@ -542,6 +566,9 @@ static int adp5585_setup(struct adp5585_dev *adp5585)
>  				   adp5585->reset1_keys[i] | ADP5585_RESET_EV_PRESS);
>  		if (ret)
>  			return ret;
> +
> +		/* mark that pin as not usable for the input and gpio devices */

Input or INPUT and GPIO.

> +		__set_bit(ADP5585_RESET1_OUT, adp5585->pin_usage);
>  	}
>  
>  	for (i = 0; i < adp5585->nkeys_reset2; i++) {
> @@ -549,6 +576,8 @@ static int adp5585_setup(struct adp5585_dev *adp5585)
>  				   adp5585->reset2_keys[i] | ADP5585_RESET_EV_PRESS);
>  		if (ret)
>  			return ret;
> +
> +		__set_bit(adp5585->reset2_out, adp5585->pin_usage);
>  	}
>  
>  	if (adp5585->nkeys_reset1 || adp5585->nkeys_reset2) {
> @@ -703,6 +732,10 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
>  		return dev_err_probe(&i2c->dev, -ENODEV,
>  				     "Invalid device ID 0x%02x\n", id);
>  
> +	adp5585->pin_usage = devm_bitmap_zalloc(&i2c->dev, adp5585->n_pins, GFP_KERNEL);
> +	if (!adp5585->pin_usage)
> +		return -ENOMEM;
> +
>  	ret = adp5585_parse_fw(adp5585);
>  	if (ret)
>  		return ret;
> diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
> index 5a1de5ae4bb144ed49a03a4e9e93eb614abe9fa3..5aa042a30c6e9eb2736fb5ab91b505324168d7b5 100644
> --- a/include/linux/mfd/adp5585.h
> +++ b/include/linux/mfd/adp5585.h
> @@ -126,6 +126,9 @@
>  #define ADP5585_GPI_EVENT_END		47
>  #define ADP5585_ROW5_KEY_EVENT_START	1
>  #define ADP5585_ROW5_KEY_EVENT_END	30
> +#define ADP5585_PWM_OUT			3
> +#define ADP5585_RESET1_OUT		4
> +#define ADP5585_RESET2_OUT		9
>  
>  /* ADP5589 */
>  #define		ADP5589_MAN_ID_VALUE		0x10
> @@ -154,6 +157,7 @@
>  #define ADP5589_PWM_ONT_LOW		0x40
>  #define ADP5589_PWM_CFG			0x42
>  #define ADP5589_POLL_PTIME_CFG		0x48
> +#define ADP5589_PIN_CONFIG_A		0x49
>  #define ADP5589_PIN_CONFIG_D		0x4C
>  #define ADP5589_GENERAL_CFG		0x4d
>  #define ADP5589_INT_EN			0x4e
> @@ -164,6 +168,7 @@
>  #define ADP5589_KEY_EVENT_END		88
>  #define ADP5589_GPI_EVENT_START		97
>  #define ADP5589_GPI_EVENT_END		115
> +#define ADP5589_RESET2_OUT		12
>  
>  struct regmap;
>  
> @@ -187,6 +192,7 @@ struct adp5585_regs {
>  	unsigned int reset_cfg;
>  	unsigned int reset1_event_a;
>  	unsigned int reset2_event_a;
> +	unsigned int pin_cfg_a;
>  };
>  
>  struct adp5585_dev {
> @@ -194,6 +200,9 @@ struct adp5585_dev {
>  	struct regmap *regmap;
>  	struct device *dev;
>  	struct blocking_notifier_head event_notifier;
> +	unsigned long *pin_usage;
> +	unsigned int n_pins;
> +	unsigned int reset2_out;
>  	enum adp5585_variant variant;
>  	unsigned int id;
>  	bool has_unlock;
> 
> -- 
> 2.49.0
> 
> 

-- 
Lee Jones [李琼斯]

