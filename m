Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BD44D47FD
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Mar 2022 14:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242375AbiCJNZO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Mar 2022 08:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbiCJNZN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Mar 2022 08:25:13 -0500
X-Greylist: delayed 652 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 05:24:10 PST
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB979A4DC;
        Thu, 10 Mar 2022 05:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1646917891;
        bh=pmnm+l4Ris569uSGaDzzAWRmTE1k7P6kzMdlq+dUBJU=;
        h=From:To:CC:Subject:Date:From;
        b=IEYJKJPTVm6IOq4bFF/sqtLs/b1NqX7NZant+U2HkO2ybbBVF1ouTkmXAZxpFCNvO
         uPKG7rkztrUh4a/4De4gSUHeQ3uOk+TM4pimYj6jH6EAnS7iTsKs+yyL4U3um/BRuA
         kBccWgEp66MweKLrnhVCtjYzyFfm++5bI6XiEQqULuOkGQHXFQEUCxIN/8vXCBitcN
         0bgcpa79nFuZi0nBvZQoEdqW2JOVGFZKzt0bEJul7KJoujxgs9nP/y5D59h0BngDAl
         fQTcara+u9IHnCttbfu7VtyoAtDXIR8SQgQBNx6umXul3Q1FNIvVCRj/ezXKiLoKAL
         nCKe7LW2I51NA==
X-secureTransport-forwarded: yes
From:   Dominik Kierner <dkierner@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     "javierm@redhat.com" <javierm@redhat.com>
CC:     "airlied@linux.ie" <airlied@linux.ie>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v6 3/6] drm: Add driver for Solomon SSD130x OLED displays
Thread-Topic: Re: [PATCH v6 3/6] drm: Add driver for Solomon SSD130x OLED
 displays
Thread-Index: Adg0f9qHOCAIrgXYTGq8frgJBu/0lA==
Date:   Thu, 10 Mar 2022 13:11:27 +0000
Message-ID: <5d817ea54144414aa7865a72694b5811@dh-electronics.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Javier,

I was working on a SSD130x driver as well, although with a different
(drm_panel) approach and hit a bit of a roadblock.
Now that Your driver is quite a bit maturer than mine,
I will happily provide You with the source of my draft,
so that any useful bits can be incorporated in Your driver.
I know that links are a bit frowned upon,
but I'd rather avoid cluttering the thread with my draft code,
which is unfinished and incompatible with the code in this thread.

https://github.com/dh-electronics/panel-solomon-ssd130x-draft
https://github.com/dh-electronics/panel-solomon-ssd130x-draft/tree/drm-ssd1=
30x/drivers/gpu/drm/panel

The code was designed as a rewrite from scratch, as I assumed that a new
DRM driver that accommodates for I2C, 3- and 4-wire-SPI,
will probably need a new DTS interface for differentiating the
protocol-specific drivers, which would obviously break compatibility.

I do have few suggestions though:

# Atomic Configuration of Display Driving Regulator and the Charge Pump

The regulator VBAT is the SSD1306-specific low-voltage (3.3 V to 5 V)
regulator for the charge pump and takes the place of the voltage
regulator VCC, that would otherwise supply the OLED driver block with
7 V to 15 V.
The charge pump is never enabled when a VCC with 7 V to 15 V is present.
Configuring the charge pump based on the available regulators,
would provide an atomic configuration for either low-voltage +
charge pump or the regular voltage.

This way, the device tree boolean for enabling the charge pump could be
removed by probing for an optional VBAT first, which replaces VCC,
and falling back to a mandatory VCC otherwise:

```
[...]
struct ssd130x_panel {
...
	struct regulator *vdd;		/* Core logic supply */
	union {
		struct regulator *vcc;	/* Panel driving supply */
		struct regulator *vbat;	/* Charge pump regulator supply */
	};
	struct backlight_device *backlight;
		struct {
		unsigned int com_scan_dir_inv : 1;
		unsigned int com_seq_pin_cfg : 1;
		unsigned int com_lr_remap : 1;
		unsigned int seg_remap : 1;
		unsigned int inverse_display : 1;
		unsigned int use_charge_pump : 1;
		uint8_t height;
		uint8_t width;
		uint8_t height_mm;
		uint8_t width_mm;
		uint8_t display_start_line;
		uint8_t com_offset ;
		uint8_t contrast;
		uint8_t pre_charge_period_dclocks_phase1;
		uint8_t pre_charge_period_dclocks_phase2;
		uint8_t vcomh_deselect_level;
		uint8_t clock_divide_ratio;
		uint8_t oscillator_frequency;
	} display_settings;
	bool prepared;
	bool enabled;

[...]

ssd130x->vbat =3D devm_regulator_get_optional(dev, "vbat");
if (IS_ERR(ssd130x->vbat)) {
	ret =3D PTR_ERR(ssd130x->vbat);

	if (ret !=3D -ENODEV) {
		if (ret !=3D -EPROBE_DEFER)
			dev_err(dev,
				"failed to request regulator: %d\n",
				ret);
		return ret;
	}

	ssd130x->vbat =3D NULL;
}
else {
	ssd130x->display_settings.use_charge_pump =3D true;
}

/* Get panel driving supply */
If (!ssd130x->vbat) {
	ssd130x->vcc =3D devm_regulator_get(dev, "vcc");
	if (IS_ERR(ssd130x->vcc)){
		ret =3D PTR_ERR(ssd130x->vcc);
		return ret;
	}
	else {
		ssd130x->display_settings.use_charge_pump =3D false;
	}
}
```

Splitting in VCC/VBAT and VDD and enforcing their presence is
of course compatibility breaking.

https://github.com/dh-electronics/panel-solomon-ssd130x-draft/blob/drm-ssd1=
30x/drivers/gpu/drm/panel/panel-solomon-ssd130x.h#L85
https://github.com/dh-electronics/panel-solomon-ssd130x-draft/blob/drm-ssd1=
30x/drivers/gpu/drm/panel/panel-solomon-ssd130x.c#L80


# Static or Dynamic Configuration for SPI-Modes 3-Wire and 4-Wire

For the SPI-protocol drivers I see two possible approaches:
* Dynamic configuration by determining the presence/absence of the
  D/C-GPIO and assigning the functions accordingly.
  This way a single driver file for both SPI modes could be sufficient.
* Static configuration by using the device-tree names
  (ssd130x-spi-3wire/-4wire) to differentiate between the SPI protocol
  drivers.
  This would obviously necessitate two drivers files.

Which one do you think would be the best approach for this?


# DRM Mode Configuration via Device Tree

In the old fbdev driver, the display modes are hard-coded, which means
for every new display configuration, a new patch needs to be mainlined,
which slows down official Kernel support and
puts burden on the maintainers.
Additionally, with the DRM-subsystem supporting height and length
information, for scaling, this opens up a lot of new combinations.
The SSD1306 for example, is available in multiple resolutions like
128x64 and 96x16 and comes in different sizes per resolution as well.
Just to name a few:
* 128x64 0.96" (22x11mm)
* 128x64 1.3" (30x15mm)
* 96x16 0.69" (18x3mm)

Instead of hard-coding, I would suggest something along the lines of
of_get_drm_display_mode().
The displays won't need to support multiple modes at the same time,
let alone support for switching between them,
so the one-time invocation of this expensive function might be worth it.=20
maybe a new and simpler function that could be named:
of_get_drm_display_mode_simple()

Providing a mode could later prove useful for a conversion to
drm_panel, if that is feasible.

But for a function like this, I have to chicken out.


# DRM Panel

The reason why I decided for the drm_panel approach in my code,
was power management and a clean handling of the software backlight
dependency, which requires powered display regulators to be powered.

Prepare/unprepare would power on/off the display logic regulator VDD.

Enable/disable would power on/off VCC/VBAT, optionally turn on/off
the charge pump and send the DISPLAY_ON/OFF commands.
The SSD1305's PWM part would likely be placed in enable/disable as well.

What is Your opinion on using drm_panel for Your driver?


Mit freundlichen Gr=FC=DFen / Best regards

Dominik Kierner
Student Employee
Research & Development
DH electronics

