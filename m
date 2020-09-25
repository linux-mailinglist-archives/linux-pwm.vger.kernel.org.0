Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96ADD278400
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Sep 2020 11:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgIYJaE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Sep 2020 05:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbgIYJaE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Sep 2020 05:30:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07611C0613CE;
        Fri, 25 Sep 2020 02:30:04 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k8so2619173pfk.2;
        Fri, 25 Sep 2020 02:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=njuKnzjM1XbkGHdVLOoKdb5c4Qn0ofNq9S9KwUbkq6w=;
        b=MXqLK/NjBAfx6dPwfwUBsQkW3e5I1SI1Rg34aYxvpU2In+TP/Tk5T+p4w/NCUXbD9Q
         fwvBexwllzRw/qjVmJzstwLqpgXatja7mEIU6rx5lnDytAcn0mU3AhlXVBZpYf69lN9F
         4LbtezU94x33cxITq4VfuWXhihgdGtSPnCRiK/dmQcoVv5ltSN/g1wBd7stCt8q7NLSr
         4oKjMm3y58m6hjC9yExBq1himVKM4tRIaYiXyOESiY/NGtZOaWJo2lqKV2w8h3rSHhnI
         fnyzyq7QlBcOfsw3O/0pmYQWQ2MRBpfw/u6Mxxrc6+oDoNVqQq29QWf/J4/nl436Uj2v
         igaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=njuKnzjM1XbkGHdVLOoKdb5c4Qn0ofNq9S9KwUbkq6w=;
        b=nrLpwmS3nRxol0n8vCyGZA0K/k4LCQ48VzSrqqNAQiGBdHKZPkuGoKoMU1kCUaQRMo
         3ERRxLpoinDinje8iwvCS5ZHzLPsDebQoaXI/H/2fdvM/ou1H9ahErBfQ8y7JbwXYkBj
         CI81Qq465io+vLsfMcOETEzuzTIGo7A2Bbxt3a/cRRyHnh+pCD1xLm+ol80PuS6fn3q0
         U5BdbiNDgYVUKHZUJ8Gt/er4JbaoLqXtGc0l+iBhMBlRqZzQD0cZXZbHklj5nuKba21Q
         831cNXF2yWfZFuTHkXz3tpsJabN0LPvvQnvb+hToWGgwoAnkm0xGyYmwunhoMrnRAtUt
         fQVQ==
X-Gm-Message-State: AOAM532vWtDv7862D5JDkrEpJmwHKpftq6kiETMrfbbTf2QlJUpVml1B
        kxte5qis7DBLhoJmiew79rxXgjcjEEIkZml3IHg=
X-Google-Smtp-Source: ABdhPJyFoDjI+Lj09DYic41xsSzC3rmiR3KE3jBfV92lPrpC2h1Ga6l1MDN/00ywFSoBy8sV7nlzIF0rOVQK3VxgTX8=
X-Received: by 2002:a17:902:c14c:b029:d2:4345:5a9 with SMTP id
 12-20020a170902c14cb02900d2434505a9mr3519072plj.0.1601026203296; Fri, 25 Sep
 2020 02:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net> <20200924192455.2484005-4-j.neuschaefer@gmx.net>
In-Reply-To: <20200924192455.2484005-4-j.neuschaefer@gmx.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 25 Sep 2020 12:29:45 +0300
Message-ID: <CAHp75VdUHPsuvDPLnfP9sM2p1FDiCsjkCf1SSM-y02ZsQxSDWQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] mfd: Add base driver for Netronix embedded controller
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Sep 24, 2020 at 10:26 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
>
> The Netronix embedded controller is a microcontroller found in some
> e-book readers designed by the ODM Netronix, Inc. It contains RTC,
> battery monitoring, system power management, and PWM functionality.
>
> This driver implements register access and version detection.
>
> Third-party hardware documentation is available at:
>
>   https://github.com/neuschaefer/linux/wiki/Netronix-MSP430-embedded-cont=
roller
>
> The EC supports interrupts, but the driver doesn't make use of them so
> far.

...

> +#include <asm/unaligned.h>

This usually goes after linux/*.h
(and actually not visible how it's being used, but see below first)

> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/ntxec.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/reboot.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>

...

> +static void ntxec_poweroff(void)
> +{
> +       int res;
> +       u8 buf[] =3D {
> +               NTXEC_REG_POWEROFF,

> +               (NTXEC_POWEROFF_VALUE >> 8) & 0xff,
> +               NTXEC_POWEROFF_VALUE & 0xff,

'& 0xff' parts are redundant. *u8 implies that. Fix in all cases.
Also I would rather see something like

  buf[0] =3D _POWEROFF;
  put_unaligned_be16(_VALUE, &buf[1]);

to explicitly show the endianess of the register values.

> +       };
> +       struct i2c_msg msgs[] =3D {
> +               {
> +                       .addr =3D poweroff_restart_client->addr,
> +                       .flags =3D 0,
> +                       .len =3D sizeof(buf),

> +                       .buf =3D buf

It's slightly better to keep trailing commas in cases like this.

> +               }
> +       };
> +
> +       res =3D i2c_transfer(poweroff_restart_client->adapter, msgs, ARRA=
Y_SIZE(msgs));
> +       if (res < 0)

> +               dev_alert(&poweroff_restart_client->dev,
> +                         "Failed to power off (err =3D %d)\n", res);

alert? This needs to be explained.

> +       /*
> +        * The time from the register write until the host CPU is powered=
 off
> +        * has been observed to be about 2.5 to 3 seconds. Sleep long eno=
ugh to
> +        * safely avoid returning from the poweroff handler.
> +        */
> +       msleep(5000);
> +}
> +
> +static int ntxec_restart(struct notifier_block *nb,
> +                        unsigned long action, void *data)
> +{
> +       int res;
> +       /*
> +        * NOTE: The lower half of the reset value is not sent, because s=
ending
> +        * it causes an error

Why? Any root cause? Perhaps you need to send 0xffff ?

> +        */
> +       u8 buf[] =3D {
> +               NTXEC_REG_RESET,

> +               (NTXEC_RESET_VALUE >> 8) & 0xff,

Here you may still use put_unaligned_be16() but move the comment to be
before len hardcoded to sizeof(buf) - 1.

> +       };
> +       struct i2c_msg msgs[] =3D {
> +               {
> +                       .addr =3D poweroff_restart_client->addr,
> +                       .flags =3D 0,
> +                       .len =3D sizeof(buf),
> +                       .buf =3D buf
> +               }
> +       };
> +
> +       res =3D i2c_transfer(poweroff_restart_client->adapter, msgs, ARRA=
Y_SIZE(msgs));
> +       if (res < 0)
> +               dev_alert(&poweroff_restart_client->dev,
> +                         "Failed to restart (err =3D %d)\n", res);
> +
> +       return NOTIFY_DONE;
> +}

...

> +static int ntxec_probe(struct i2c_client *client)
> +{
> +       struct ntxec *ec;
> +       unsigned int version;
> +       int res;
> +
> +       ec =3D devm_kmalloc(&client->dev, sizeof(*ec), GFP_KERNEL);
> +       if (!ec)
> +               return -ENOMEM;
> +
> +       ec->dev =3D &client->dev;
> +
> +       ec->regmap =3D devm_regmap_init_i2c(client, &regmap_config);
> +       if (IS_ERR(ec->regmap)) {
> +               dev_err(ec->dev, "Failed to set up regmap for device\n");
> +               return res;
> +       }
> +
> +       /* Determine the firmware version */
> +       res =3D regmap_read(ec->regmap, NTXEC_REG_VERSION, &version);
> +       if (res < 0) {
> +               dev_err(ec->dev, "Failed to read firmware version number\=
n");
> +               return res;
> +       }

> +       dev_info(ec->dev,
> +                "Netronix embedded controller version %04x detected.\n",
> +                version);

This info level may confuse users if followed by an error path.

> +       /* Bail out if we encounter an unknown firmware version */
> +       switch (version) {
> +       case 0xd726: /* found in Kobo Aura */
> +               break;
> +       default:
> +               return -ENODEV;
> +       }
> +
> +       if (of_device_is_system_power_controller(ec->dev->of_node)) {
> +               /*
> +                * Set the 'powerkeep' bit. This is necessary on some boa=
rds
> +                * in order to keep the system running.
> +                */
> +               res =3D regmap_write(ec->regmap, NTXEC_REG_POWERKEEP,
> +                                  NTXEC_POWERKEEP_VALUE);
> +               if (res < 0)
> +                       return res;

> +               WARN_ON(poweroff_restart_client);

WARN_ON? All these alerts, WARNs, BUGs must be explained. Screaming to
the user is not good if it wasn't justified.

> +               poweroff_restart_client =3D client;
> +               if (pm_power_off)
> +                       dev_err(ec->dev, "pm_power_off already assigned\n=
");
> +               else
> +                       pm_power_off =3D ntxec_poweroff;
> +
> +               res =3D register_restart_handler(&ntxec_restart_handler);
> +               if (res)
> +                       dev_err(ec->dev,
> +                               "Failed to register restart handler: %d\n=
", res);
> +       }
> +
> +       i2c_set_clientdata(client, ec);
> +
> +       res =3D devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE, ntxec_=
subdevices,
> +                                  ARRAY_SIZE(ntxec_subdevices), NULL, 0,=
 NULL);
> +       if (res)

> +               dev_warn(ec->dev, "Failed to add subdevices: %d\n", res);

'warn' is inconsistent with 'return err'. Either do not return an
error, or mark a message as an error one.

And above with the restart handler has the same issue.

> +       return res;
> +}
> +
> +static int ntxec_remove(struct i2c_client *client)
> +{

> +       if (client =3D=3D poweroff_restart_client) {

When it's not the case?

> +               poweroff_restart_client =3D NULL;
> +               pm_power_off =3D NULL;
> +               unregister_restart_handler(&ntxec_restart_handler);
> +       }
> +
> +       return 0;
> +}

...

> +#include <linux/types.h>
> +

Missed

struct device;
struct regmap;

here.

> +struct ntxec {
> +       struct device *dev;
> +       struct regmap *regmap;
> +};

> +/*
> + * Some registers, such as the battery status register (0x41), are in
> + * big-endian, but others only have eight significant bits, which are in=
 the
> + * first byte transmitted over I2C (the MSB of the big-endian value).
> + * This convenience function converts an 8-bit value to 16-bit for use i=
n the
> + * second kind of register.
> + */
> +static inline u16 ntxec_reg8(u8 value)
> +{
> +       return value << 8;
> +}

I'm wondering why __be16 is not used as returned type.

--=20
With Best Regards,
Andy Shevchenko
