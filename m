Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE544A9AEE
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Feb 2022 15:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359283AbiBDO2S (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Feb 2022 09:28:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:31467 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359280AbiBDO2P (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 4 Feb 2022 09:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643984895; x=1675520895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o9YdIKckD9PGelgJpGStLxH5Uf4RuvORb3X4B+bs1gs=;
  b=nXgoZIC5sbyY3tFrTwqIqh+Gxnif1P4mZ6zl0YcsU+okb9BVZpPWFPli
   CcbdSKwFzIvnksonLz/Zta7xYbENOjy0qeYzZJfiV8Y1lM7pMAS1YTwE2
   IBrL4XlUsPo6EZKqBEt9ktcCQWHRfQuGj318/HMiIUT88W8flYXqoi5Tb
   vhzobBVxzDkiurFNv/xFYx3u2vV5SMZ8lSl0LdrIid06I16z1d0rAjlus
   xzsxkX4Q2JA5DoZhj7WkF9eP5b23nA0dNmJLglEzeQgqePOTCyEMXEUVt
   Dvh+DXSdF7hD4+p9KZTBsL7R37zIN+d1dNgUZ0dJqW0ucG1YEvmY2ltQm
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="248135023"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="248135023"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 06:28:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="584143895"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 06:27:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nFzY9-000oUT-AL;
        Fri, 04 Feb 2022 16:26:57 +0200
Date:   Fri, 4 Feb 2022 16:26:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 2/4] drm/tiny: Add driver for Solomon SSD130X OLED
 displays
Message-ID: <Yf03sCSuQwHKvgA9@smile.fi.intel.com>
References: <20220204134347.1187749-1-javierm@redhat.com>
 <20220204134347.1187749-3-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204134347.1187749-3-javierm@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Feb 04, 2022 at 02:43:45PM +0100, Javier Martinez Canillas wrote:
> Add a DRM driver for SSD1305, SSD1306, SSD1307 and SSD1309 Solomon OLED
> controllers that can be programmed via an I2C interface. This is a port
> of the ssd1307fb driver that already supports these devices.
> 
> A Device Tree binding is not added because the DRM driver is compatible
> with the existing binding for the ssd1307fb driver.

...

> +/*
> + * DRM driver for Solomon SSD130X OLED displays
> + *
> + * Copyright 2022 Red Hat Inc.
> + *
> + * Based on drivers/video/fbdev/ssd1307fb.c
> + * Copyright 2012 Free Electrons

> + *

No need for this blank line.

> + */

...

> +struct ssd130x_device {
> +	struct drm_device drm;
> +	struct drm_simple_display_pipe pipe;
> +	struct drm_display_mode mode;
> +	struct drm_connector connector;


> +	struct i2c_client *client;

Can we logically separate hw protocol vs hw interface from day 1, please?
This will allow to add SPI support for this panel much easier.

Technically I would like to see here

	struct device *dev;

and probably (I haven't looked into design)

	struct ssd130x_ops *ops;

or something alike.

> +	const struct ssd130x_deviceinfo *device_info;
> +
> +	unsigned area_color_enable : 1;
> +	unsigned com_invdir : 1;
> +	unsigned com_lrremap : 1;
> +	unsigned com_seq : 1;
> +	unsigned lookup_table_set : 1;
> +	unsigned low_power : 1;
> +	unsigned seg_remap : 1;
> +	u32 com_offset;
> +	u32 contrast;
> +	u32 dclk_div;
> +	u32 dclk_frq;
> +	u32 height;
> +	u8 lookup_table[4];
> +	u32 page_offset;
> +	u32 col_offset;
> +	u32 prechargep1;
> +	u32 prechargep2;
> +
> +	struct backlight_device *bl_dev;
> +	struct pwm_device *pwm;
> +	struct gpio_desc *reset;
> +	struct regulator *vbat_reg;
> +	u32 vcomh;
> +	u32 width;
> +	/* Cached address ranges */
> +	u8 col_start;
> +	u8 col_end;
> +	u8 page_start;
> +	u8 page_end;
> +};

...

> +static inline int ssd130x_write_value(struct i2c_client *client, u8 value)

Not sure inline does anything useful here.
Ditto for the rest similar cases.

...

> +static inline int ssd130x_write_cmd(struct i2c_client *client, int count,
> +				    /* u8 cmd, u8 value, ... */...)
> +{
> +	va_list ap;
> +	u8 value;
> +	int ret;
> +
> +	va_start(ap, count);

> +	while (count--) {
> +		value = va_arg(ap, int);
> +		ret = ssd130x_write_value(client, (u8)value);
> +		if (ret)
> +			goto out_end;
> +	}

I'm wondering if this can be written in a form

	do {
		...
	} while (--count);

In this case it will give a hint that count can't be 0.

> +out_end:
> +	va_end(ap);
> +
> +	return ret;
> +}


...

> +	ssd130x->pwm = pwm_get(dev, NULL);
> +	if (IS_ERR(ssd130x->pwm)) {
> +		dev_err(dev, "Could not get PWM from device tree!\n");

"device tree" is a bit confusing here if I run this on ACPI.
Maybe something like "firmware description"?

> +		return PTR_ERR(ssd130x->pwm);
> +	}

...

> +	/* Set initial contrast */
> +	ret = ssd130x_write_cmd(ssd130x->client, 2, SSD130X_CONTRAST, ssd130x->contrast);

Creating a local variable for client allows to:
- make lines shorter and might even be less LOCs
- allow to convert struct device to client in one place
  (as per my above comment)

Ditto for other similar cases.

> +	if (ret < 0)
> +		return ret;

...

> +		for (i = 0; i < ARRAY_SIZE(ssd130x->lookup_table); ++i) {

i++ should work same way.

> +		}

...

> +	/* Switch to horizontal addressing mode */
> +	ret = ssd130x_write_cmd(ssd130x->client, 2, SSD130X_SET_ADDRESS_MODE,
> +				SSD130X_SET_ADDRESS_MODE_HORIZONTAL);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;

Can it be

	return ssd130x_write_cmd(...);

?

...

> +	unsigned int line_length = DIV_ROUND_UP(width, 8);
> +	unsigned int pages = DIV_ROUND_UP(height, 8);

For power of two there are more efficient roundup()/rounddown()
(or with _ in the names, I don't remember by heart).

...

> +			for (k = 0; k < m; k++) {

> +				u8 byte = buf[(8 * i + k) * line_length +
> +					       j / 8];

One line?

> +				u8 bit = (byte >> (j % 8)) & 1;
> +
> +				data |= bit << k;
> +			}

...

> +static int ssd130x_display_pipe_mode_valid(struct drm_simple_display_pipe *pipe,
> +					   const struct drm_display_mode *mode)
> +{
> +	struct ssd130x_device *ssd130x = drm_to_ssd130x(pipe->crtc.dev);
> +
> +	if (mode->hdisplay != ssd130x->mode.hdisplay &&
> +	    mode->vdisplay != ssd130x->mode.vdisplay)
> +		return MODE_ONE_SIZE;

> +	else if (mode->hdisplay != ssd130x->mode.hdisplay)
> +		return MODE_ONE_WIDTH;
> +	else if (mode->vdisplay != ssd130x->mode.vdisplay)
> +		return MODE_ONE_HEIGHT;

'else' in both cases is redundant.

> +	return MODE_OK;
> +}

...

> +poweroff:

out_power_off: ?

...

> +	if (!fb)
> +		return;

Can it happen?

...

> +	drm_mode_probed_add(connector, mode);
> +	drm_set_preferred_mode(connector, mode->hdisplay, mode->vdisplay);
> +
> +	return 1;

Positive code, what is the meaning of it?

...

> +	if (device_property_read_u32(dev, "solomon,prechargep2", &ssd130x->prechargep2))
> +		ssd130x->prechargep2 = 2;

You can drop conditionals for the optional properties

	ssd130x->prechargep2 = 2;
	device_property_read_u32(dev, "solomon,prechargep2", &ssd130x->prechargep2);

and so on for the similar.

...

> +	ssd130x->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(ssd130x->reset)) {

> +		ret = PTR_ERR(ssd130x->reset);
> +		dev_err(dev, "Failed to get reset gpio: %d\n", ret);
> +		return ret;

Why not

	return dev_err_probe()?

Each time you call it for deferred probe, it will spam logs.

> +	}
> +
> +	ssd130x->vbat_reg = devm_regulator_get_optional(dev, "vbat");
> +	if (IS_ERR(ssd130x->vbat_reg)) {
> +		ret = PTR_ERR(ssd130x->vbat_reg);
> +		if (ret == -ENODEV) {
> +			ssd130x->vbat_reg = NULL;

> +		} else {
> +			dev_err(dev, "Failed to get VBAT regulator: %d\n", ret);
> +			return ret;
> +		}

Ditto ?

> +	}

...

> +	if (IS_ERR(ssd130x)) {
> +		ret = PTR_ERR(ssd130x);
> +		dev_err(dev, "Failed to allocate DRM device: %d\n", ret);
> +		return ret;
> +	}

Ditto.

...

> +	i2c_set_clientdata(client, ssd130x);

Wondering if you can split i2c part from the core part and perhaps use regmap
to access the device.

...

> +	if (IS_ERR(bl)) {
> +		ret = PTR_ERR(bl);
> +		dev_err(dev, "Unable to register backlight device: %d\n", ret);
> +		return ret;

	return dev_err_probe();

> +	}

...

> +	ret = drm_dev_register(drm, 0);
> +	if (ret) {
> +		dev_err(dev, "DRM device register failed: %d\n", ret);
> +		return ret;
> +	}

Ditto.

...

> +	{},

Comma is not needed in terminator entry.

...

> +static struct i2c_driver ssd130x_i2c_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.of_match_table = ssd130x_of_match,
> +	},
> +	.probe_new = ssd130x_probe,
> +	.remove = ssd130x_remove,
> +	.shutdown = ssd130x_shutdown,
> +};

> +

Redundant blank line.

> +module_i2c_driver(ssd130x_i2c_driver);

-- 
With Best Regards,
Andy Shevchenko


