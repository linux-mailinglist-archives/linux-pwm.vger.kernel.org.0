Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54266F7040
	for <lists+linux-pwm@lfdr.de>; Thu,  4 May 2023 18:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjEDQxX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 May 2023 12:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjEDQxX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 May 2023 12:53:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DEC3C15
        for <linux-pwm@vger.kernel.org>; Thu,  4 May 2023 09:53:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pucCc-0003fH-0B; Thu, 04 May 2023 18:53:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pucCa-0016YD-VE; Thu, 04 May 2023 18:53:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pucCZ-001Hie-LD; Thu, 04 May 2023 18:53:07 +0200
Date:   Thu, 4 May 2023 18:53:07 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 18/19] platform/x86: lenovo-yogabook: Add keyboard
 backlight control to platform driver
Message-ID: <20230504165307.tydqlk6sml7sp5qe@pengutronix.de>
References: <20230430165807.472798-1-hdegoede@redhat.com>
 <20230430165807.472798-19-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="koyzklwvdvr2xotu"
Content-Disposition: inline
In-Reply-To: <20230430165807.472798-19-hdegoede@redhat.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--koyzklwvdvr2xotu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Apr 30, 2023 at 06:58:06PM +0200, Hans de Goede wrote:
> On the Android yb1-x90f/l models there is not ACPI method to control
> the keyboard backlight brightness. Instead the second PWM controller
> is exposed directly to the OS there.
>=20
> Add support for controlling keyboard backlight brightness on the Android
> model by using the PWM subsystem to directly control the PWM.
>=20
> The Android model also requires explicitly turning the backlight off
> on suspend, which on the Windows model was done automatically.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Use YB_KBD_BL_PWM_PERIOD define in yogabook_pdev_pwm_lookup[]
> - Turn off keyboard backlight on suspend
> ---
>  drivers/platform/x86/lenovo-yogabook-wmi.c | 31 +++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platfor=
m/x86/lenovo-yogabook-wmi.c
> index 0183b75a47e8..b49109d91ec3 100644
> --- a/drivers/platform/x86/lenovo-yogabook-wmi.c
> +++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
> @@ -19,6 +19,7 @@
>  #include <linux/leds.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/pwm.h>
>  #include <linux/wmi.h>
>  #include <linux/workqueue.h>
> =20
> @@ -26,6 +27,7 @@
> =20
>  #define YB_KBD_BL_DEFAULT	128
>  #define YB_KBD_BL_MAX		255
> +#define YB_KBD_BL_PWM_PERIOD	13333
> =20
>  #define YB_PDEV_NAME		"yogabook-touch-kbd-digitizer-switch"
> =20
> @@ -48,6 +50,7 @@ struct yogabook_data {
>  	struct gpio_desc *pen_touch_event;
>  	struct gpio_desc *kbd_bl_led_enable;
>  	struct gpio_desc *backside_hall_gpio;
> +	struct pwm_device *kbd_bl_pwm;
>  	int (*set_kbd_backlight)(struct yogabook_data *data, uint8_t level);
>  	int pen_touch_irq;
>  	int backside_hall_irq;
> @@ -267,8 +270,11 @@ static int yogabook_suspend(struct device *dev)
>  	struct yogabook_data *data =3D dev_get_drvdata(dev);
> =20
>  	set_bit(YB_SUSPENDED, &data->flags);
> -
>  	flush_work(&data->work);
> +
> +	if (test_bit(YB_KBD_IS_ON, &data->flags))
> +		data->set_kbd_backlight(data, 0);
> +
>  	return 0;
>  }
> =20
> @@ -424,8 +430,21 @@ static struct gpiod_lookup_table yogabook_pdev_gpios=
 =3D {
>  	},
>  };
> =20
> +static struct pwm_lookup yogabook_pdev_pwm_lookup[] =3D {
> +	PWM_LOOKUP_WITH_MODULE("80862289:00", 0, YB_PDEV_NAME, "kbd_bl_pwm",
> +			       YB_KBD_BL_PWM_PERIOD, PWM_POLARITY_NORMAL,
> +			       "pwm-lpss-platform"),
> +};
> +
>  static int yogabook_pdev_set_kbd_backlight(struct yogabook_data *data, u=
8 level)
>  {
> +	struct pwm_state state =3D {
> +		.period =3D YB_KBD_BL_PWM_PERIOD,
> +		.duty_cycle =3D YB_KBD_BL_PWM_PERIOD * level / YB_KBD_BL_MAX,
> +		.enabled =3D level,
> +	};
> +
> +	pwm_apply_state(data->kbd_bl_pwm, &state);
>  	gpiod_set_value(data->kbd_bl_led_enable, level ? 1 : 0);
>  	return 0;
>  }
> @@ -475,6 +494,16 @@ static int yogabook_pdev_probe(struct platform_devic=
e *pdev)
>  		goto error_put_devs;
>  	}
> =20
> +	pwm_add_table(yogabook_pdev_pwm_lookup, ARRAY_SIZE(yogabook_pdev_pwm_lo=
okup));
> +	data->kbd_bl_pwm =3D devm_pwm_get(dev, "kbd_bl_pwm");
> +	pwm_remove_table(yogabook_pdev_pwm_lookup, ARRAY_SIZE(yogabook_pdev_pwm=
_lookup));

Keeping the table added just long enough to call devm_pwm_get() looks
very creative to me. Why don't you keep the table around while the
device is available? Also note that a given table must only ever be
added once using pwm_add_table(). If there happen to be two yogabook
devices and .probe() is called a second time, the list of tables might
be corrupted.

I don't know much about x86, but I think the table belongs to where this
"80862289:00" device is created.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--koyzklwvdvr2xotu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRT4vIACgkQj4D7WH0S
/k7bZAgAiyi0yYTFappMtV6MAA2/DIQHhqqYCSOoRR1CxaNzm0bYwJqNrPJ2qgti
ZnTHtVFFU8ittZfVhQMfKIChLP+l0X9eACZ4hQszuwr8fn4xUPECJ8gJig9GzVVR
NRzihRJC54uiFqsZemhywDp5xVn5A70n/pEbhJhIuPlXMKN288I3wB6Dq2JOPJGk
xwu6sOGDmZrAkA930sA+rH4CR+42zGMeG96YusEt+G7HdqorePitq/cAg0uDoy6j
NQQIf6LZvGlwpF3fLeFydDgSnsXLax5GNKOOckIleIL0PGcU+7R4pq/vzqRTbGZl
9vD5BfMgVJcGA5/KEUPo+DfrFUvEOw==
=D3HY
-----END PGP SIGNATURE-----

--koyzklwvdvr2xotu--
