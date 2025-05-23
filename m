Return-Path: <linux-pwm+bounces-6106-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C766AC2624
	for <lists+linux-pwm@lfdr.de>; Fri, 23 May 2025 17:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E79D17D434
	for <lists+linux-pwm@lfdr.de>; Fri, 23 May 2025 15:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C812063F0;
	Fri, 23 May 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKgBHpOm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D480192D68;
	Fri, 23 May 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013320; cv=none; b=ANiLvNLyayALQQTYTg/z1PxgEWcLer3hLKQtDMb44HTjHkEzt3XidByf+MKzGoPajgJ7wsSSwgOuDYPBwkWwldWw4Jxa0/41DXnB1ABIKHO8ccdz0UeiBX2gpy022Z+yQ8bqAAJktEc3tp94kznio9bEEjLr5qHO7XcaeH349x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013320; c=relaxed/simple;
	bh=lt6RRUtb6k0aMFhsNeofdLi40LgBKlwGshGWkkp1bng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fN0XWTF7OmzHWDWfmhgB2WfSDt2tRJzoc7Blnxlkqn2RDRxIXH0qcZF/q8LbuYNyIgvxOml+R3jViZiCcNwcF7Ji20wqOXJYKsPpf7lp3xN82Jh/QZoEIH8pCxastOzfmGwto5XUXphfKkd3sZySonuETpvqUJURT7Cl7iVoALA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKgBHpOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307E7C4CEE9;
	Fri, 23 May 2025 15:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748013319;
	bh=lt6RRUtb6k0aMFhsNeofdLi40LgBKlwGshGWkkp1bng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cKgBHpOm1ptqoE/D9dk3931DCDVXRpN9lMO7xQM5t/u+UYDVgiYS/2n34wWDf01MW
	 zxtywwt5i89yN7/5+JSoTzyxQh1iC4wPy6DByKCfon4pAeQhGNNgKJQevz73uMJWzL
	 /Tj9LBbWQwwWpbhjyEeZi+Fc5zw3uyqnj3UFrlUnNUaoberjXAo3Iqsvsbdo1+DCgw
	 gI0c+drhfvWO0ej/4H9bGtleSoaH+u4QSOgvWHLdORBimY1y8WUTL8QkeUnavNn2rk
	 gRxxo2M3zTMUk2fCe8+9WwwtXc3p/Wb2vh1QoLxkeSygZp++RYEc0WNA3CcaLbEzLD
	 79FeBzsBCI57w==
Date: Fri, 23 May 2025 16:15:14 +0100
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
Subject: Re: [PATCH v4 07/20] mfd: adp5585: add support for adp5589
Message-ID: <20250523151514.GI1378991@google.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
 <20250521-dev-adp5589-fw-v4-7-f2c988d7a7a0@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250521-dev-adp5589-fw-v4-7-f2c988d7a7a0@analog.com>

On Wed, 21 May 2025, Nuno Sá via B4 Relay wrote:

> From: Nuno Sá <nuno.sa@analog.com>
> 
> The ADP5589 is a 19 I/O port expander with built-in keypad matrix decoder,
> programmable logic, reset generator, and PWM generator.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/mfd/adp5585.c       | 139 +++++++++++++++++++++++++++++++++++++++-----
>  include/linux/mfd/adp5585.h |  11 ++++
>  2 files changed, 134 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> index 672f3468bda5be6af85a5982c3626053b4cb59bf..53ac46365e56874a05855f1df1843717148f181a 100644
> --- a/drivers/mfd/adp5585.c
> +++ b/drivers/mfd/adp5585.c
> @@ -29,6 +29,11 @@ static const struct mfd_cell adp5585_devs[ADP5585_DEV_MAX] = {
>  	MFD_CELL_NAME("adp5585-pwm"),
>  };
>  
> +static const struct mfd_cell adp5589_devs[] = {
> +	MFD_CELL_NAME("adp5589-gpio"),
> +	MFD_CELL_NAME("adp5589-pwm"),
> +};
> +
>  static const struct regmap_range adp5585_volatile_ranges[] = {
>  	regmap_reg_range(ADP5585_ID, ADP5585_GPI_STATUS_B),
>  };
> @@ -38,6 +43,15 @@ static const struct regmap_access_table adp5585_volatile_regs = {
>  	.n_yes_ranges = ARRAY_SIZE(adp5585_volatile_ranges),
>  };
>  
> +static const struct regmap_range adp5589_volatile_ranges[] = {
> +	regmap_reg_range(ADP5585_ID, ADP5589_GPI_STATUS_C),
> +};
> +
> +static const struct regmap_access_table adp5589_volatile_regs = {
> +	.yes_ranges = adp5589_volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(adp5589_volatile_ranges),
> +};
> +
>  /*
>   * Chip variants differ in the default configuration of pull-up and pull-down
>   * resistors, and therefore have different default register values:
> @@ -81,6 +95,45 @@ static const u8 adp5585_regmap_defaults_04[ADP5585_MAX_REG + 1] = {
>  	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
>  };
>  
> +static const u8 adp5589_regmap_defaults_00[ADP5589_MAX_REG + 1] = {

Why +1?

> +	/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x18 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x40 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x48 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +};
> +
> +static const u8 adp5589_regmap_defaults_01[ADP5589_MAX_REG + 1] = {
> +	/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x18 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00,
> +	/* 0x40 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x48 */ 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00,
> +};
> +
> +static const u8 adp5589_regmap_defaults_02[ADP5589_MAX_REG + 1] = {
> +	/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x18 */ 0x00, 0x41, 0x01, 0x00, 0x11, 0x04, 0x00, 0x00,
> +	/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x40 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	/* 0x48 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +};
> +
>  /* -1 since the enum starts at 1 for error checking in i2c_get_match_data()*/
>  static const u8 *adp5585_regmap_defaults[ADP5585_MAX - 1] = {
>  	[ADP5585_00 - 1] = adp5585_regmap_defaults_00,
> @@ -88,6 +141,9 @@ static const u8 *adp5585_regmap_defaults[ADP5585_MAX - 1] = {
>  	[ADP5585_02 - 1] = adp5585_regmap_defaults_02,
>  	[ADP5585_03 - 1] = adp5585_regmap_defaults_00,
>  	[ADP5585_04 - 1] = adp5585_regmap_defaults_04,
> +	[ADP5589_00 - 1] = adp5589_regmap_defaults_00,
> +	[ADP5589_01 - 1] = adp5589_regmap_defaults_01,
> +	[ADP5589_02 - 1] = adp5589_regmap_defaults_02,
>  };
>  
>  static const struct regmap_config adp5585_regmap_config_template = {
> @@ -99,11 +155,39 @@ static const struct regmap_config adp5585_regmap_config_template = {
>  	.num_reg_defaults_raw = ADP5585_MAX_REG + 1,
>  };
>  
> -static void adp5585_fill_regmap_config(const struct adp5585_dev *adp5585,
> +static const struct regmap_config adp5589_regmap_config_template = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = ADP5589_MAX_REG,
> +	.volatile_table = &adp5589_volatile_regs,
> +	.cache_type = REGCACHE_MAPLE,
> +	.num_reg_defaults_raw = ADP5589_MAX_REG + 1,

This is 0x4F, but there are only 0x4E values?
> +};
> +
> +static int adp5585_fill_variant_config(struct adp5585_dev *adp5585,
>  				       struct regmap_config *regmap_config)
>  {
> -	*regmap_config = adp5585_regmap_config_template;
> +	switch (adp5585->variant) {
> +	case ADP5585_00:
> +	case ADP5585_01:
> +	case ADP5585_02:
> +	case ADP5585_03:
> +	case ADP5585_04:
> +		*regmap_config = adp5585_regmap_config_template;
> +		adp5585->id = ADP5585_MAN_ID_VALUE;
> +		break;
> +	case ADP5589_00:
> +	case ADP5589_01:
> +	case ADP5589_02:
> +		*regmap_config = adp5589_regmap_config_template;
> +		adp5585->id = ADP5589_MAN_ID_VALUE;
> +		break;
> +	default:
> +		return -ENODEV;

If you take my previous advice, this will become ERR_PTR();

> +	}
> +
>  	regmap_config->reg_defaults_raw = adp5585_regmap_defaults[adp5585->variant - 1];
> +	return 0;
>  }
>  
>  static void adp5585_remove_devices(void *dev)
> @@ -111,29 +195,35 @@ static void adp5585_remove_devices(void *dev)
>  	mfd_remove_devices(dev);
>  }
>  
> -static int adp5585_add_devices(struct device *dev)
> +static int adp5585_add_devices(const struct adp5585_dev *adp5585)
>  {
> +	const struct mfd_cell *cells;
>  	int ret;
>  
> -	if (device_property_present(dev, "#pwm-cells")) {
> -		ret = mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> -				      &adp5585_devs[ADP5585_DEV_PWM], 1, NULL, 0, NULL);
> +	if (adp5585->id == ADP5585_MAN_ID_VALUE)
> +		cells = adp5585_devs;
> +	else
> +		cells = adp5589_devs;
> +
> +	if (device_property_present(adp5585->dev, "#pwm-cells")) {
> +		ret = mfd_add_devices(adp5585->dev, PLATFORM_DEVID_AUTO,

Instead of making all of these changes, add the following at the top:

	struct device *dev = adp5585->dev;

... and continue using the short form.

> +				      &cells[ADP5585_DEV_PWM], 1, NULL, 0, NULL);
>  		if (ret)
> -			return dev_err_probe(dev, ret, "Failed to add pwm device\n");
> +			return dev_err_probe(adp5585->dev, ret, "Failed to add pwm device\n");
>  	}
>  
> -	if (device_property_present(dev, "#gpio-cells")) {
> -		ret = mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> -				      &adp5585_devs[ADP5585_DEV_GPIO], 1, NULL, 0, NULL);
> +	if (device_property_present(adp5585->dev, "#gpio-cells")) {
> +		ret = mfd_add_devices(adp5585->dev, PLATFORM_DEVID_AUTO,
> +				      &cells[ADP5585_DEV_GPIO], 1, NULL, 0, NULL);
>  		if (ret) {
> -			ret = dev_err_probe(dev, ret, "Failed to add gpio device\n");
> +			ret = dev_err_probe(adp5585->dev, ret, "Failed to add gpio device\n");
>  			goto out_error;
>  		}
>  	}
>  
> -	return devm_add_action_or_reset(dev, adp5585_remove_devices, dev);
> +	return devm_add_action_or_reset(adp5585->dev, adp5585_remove_devices, adp5585->dev);
>  out_error:
> -	mfd_remove_devices(dev);
> +	mfd_remove_devices(adp5585->dev);
>  	return ret;
>  }
>  
> @@ -161,19 +251,24 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
>  	if (!adp5585->variant)
>  		return -ENODEV;
>  
> -	adp5585_fill_regmap_config(adp5585, &regmap_config);
> +	ret = adp5585_fill_variant_config(adp5585, &regmap_config);
> +	if (ret)
> +		return ret;
>  
>  	adp5585->regmap = devm_regmap_init_i2c(i2c, &regmap_config);
>  	if (IS_ERR(adp5585->regmap))
>  		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),
>  				     "Failed to initialize register map\n");
>  
> +	adp5585->dev = &i2c->dev;
> +
>  	ret = regmap_read(adp5585->regmap, ADP5585_ID, &id);
>  	if (ret)
>  		return dev_err_probe(&i2c->dev, ret,
>  				     "Failed to read device ID\n");
>  
> -	if ((id & ADP5585_MAN_ID_MASK) != ADP5585_MAN_ID_VALUE)
> +	id &= ADP5585_MAN_ID_MASK;
> +	if (id != adp5585->id)
>  		return dev_err_probe(&i2c->dev, -ENODEV,
>  				     "Invalid device ID 0x%02x\n", id);
>  
> @@ -193,7 +288,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
>  	if (ret)
>  		return ret;
>  
> -	return adp5585_add_devices(&i2c->dev);
> +	return adp5585_add_devices(adp5585);
>  }
>  
>  static int adp5585_suspend(struct device *dev)
> @@ -233,6 +328,18 @@ static const struct of_device_id adp5585_of_match[] = {
>  	}, {
>  		.compatible = "adi,adp5585-04",
>  		.data = (void *)ADP5585_04,
> +	}, {
> +		.compatible = "adi,adp5589-00",
> +		.data = (void *)ADP5589_00,
> +	}, {
> +		.compatible = "adi,adp5589-01",
> +		.data = (void *)ADP5589_01,
> +	}, {
> +		.compatible = "adi,adp5589-02",
> +		.data = (void *)ADP5589_02,
> +	}, {
> +		.compatible = "adi,adp5589",
> +		.data = (void *)ADP5589_00,
>  	},
>  	{ /* sentinel */ }
>  };
> diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
> index 2813b20e638b6e73ef198e43af07ef29ff25f273..40c87981e5a24f8a175cc41e38b1495ed9f194e5 100644
> --- a/include/linux/mfd/adp5585.h
> +++ b/include/linux/mfd/adp5585.h
> @@ -117,6 +117,12 @@
>  #define ADP5585_BANK(n)			((n) >= 6 ? 1 : 0)
>  #define ADP5585_BIT(n)			((n) >= 6 ? BIT((n) - 6) : BIT(n))
>  
> +/* ADP5589 */
> +#define		ADP5589_MAN_ID_VALUE		0x10
> +#define ADP5589_GPI_STATUS_C		0x18
> +#define ADP5589_INT_EN			0x4e
> +#define ADP5589_MAX_REG			ADP5589_INT_EN
> +
>  struct regmap;
>  
>  enum adp5585_variant {
> @@ -125,12 +131,17 @@ enum adp5585_variant {
>  	ADP5585_02,
>  	ADP5585_03,
>  	ADP5585_04,
> +	ADP5589_00,
> +	ADP5589_01,
> +	ADP5589_02,
>  	ADP5585_MAX
>  };
>  
>  struct adp5585_dev {
>  	struct regmap *regmap;
> +	struct device *dev;

Can you pop this at the top please.

It has a higher standing (in my own head *twitch*) than regmap.

>  	enum adp5585_variant variant;
> +	unsigned int id;
>  };
>  
>  #endif
> 
> -- 
> 2.49.0
> 
> 

-- 
Lee Jones [李琼斯]

