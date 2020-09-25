Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0143227939C
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Sep 2020 23:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgIYVdT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Sep 2020 17:33:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:56413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgIYVdT (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 25 Sep 2020 17:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601069535;
        bh=fOmj3zQts7kybefgEaY4WROeVIrinhK+N1GjZXrXArI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=cA2PZ86zIHF0faVYeRCFmQODzEuzOrQ14kPmbJoIr+mbA6zoZy/a9GXLjs+Q7loz6
         8Mx9/eb8TJwPpRDJR1gMjSe3GhBiBjgbzMUo8+GYBZZCL8NXV+ZPC6cX3FeMEpARP9
         NxZtjRd2zp8oOY69snz1IEFVsnOxMvC/XszvbNpU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAfYw-1kAtmB1wcK-00B3BS; Fri, 25
 Sep 2020 23:32:15 +0200
Date:   Fri, 25 Sep 2020 23:32:07 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
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
Subject: Re: [PATCH v3 3/7] mfd: Add base driver for Netronix embedded
 controller
Message-ID: <20200925213207.GA2510@latitude>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
 <20200924192455.2484005-4-j.neuschaefer@gmx.net>
 <CAHp75VdUHPsuvDPLnfP9sM2p1FDiCsjkCf1SSM-y02ZsQxSDWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <CAHp75VdUHPsuvDPLnfP9sM2p1FDiCsjkCf1SSM-y02ZsQxSDWQ@mail.gmail.com>
X-Provags-ID: V03:K1:d7YI7q9xhqyMeuCoSJ1xFCTdK3X2pL7XIlrg4rAzNabthB/psZt
 nXMDjOk/jQqamXBNOiQn+Q9P/JBxwgKqMPnGhCESNzmn/7qeT/HCVTXZbyiJPLI9hO/5rn4
 oAtweDKzKff+8CCCRxQaxU80sSIQLQ3jaZ5dA/H5+LfE3EBYhMWvXNot8fkeZDzIaPikYuM
 R03MmlsYcbs8UG8yEJ+fw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:C90YUi8I8sk=:5PjtnPdDQNWUL5SwSPcnNC
 9wQi65fczQ2OQV55FrLbp7WHPGyFxABDORcsvNPRwva1fA/TS4nXYuHD/2X+tH/dkkrNMAVoU
 gqMlfQdtAhy+Ay2bluLKiTuz25YnoMniiLtSkHFKoQKtFzMzev36ZiRdJI1f1gtz1yLaIB/49
 DMwHHf8kvubeNfECMfYw/04O/Nqla5B5KSTxJelJqIvlFk4NffJ9Z2qj111F6753sUbuJdj74
 16HPy0A1bBonwv7Vn2KNrmAi7ffMO66WCeWSmJizQkVejJyMXCrJ74M/1UbxSv9sqreAMB1hq
 pEKUrQMrUAuvBw7iaty7fCbi07ROFfKzstre8hDZ7FtfkzuiJUOhKAA9RQhYVUz+7VBJ5YmDl
 /WsqlmKLvzPu1y7D91DrX6mGujtDU+/zeK0g+cm1Cv6hlnUajsmO9SlKeWxqiwzHYJ/cpKhrk
 cI5SW8R9hyS382IheldeKchhz+4Qr6mrolNDz/aGVjh/VePVfrkMxIQTCHfObE27S++C81o9m
 pENmeiEXEJe3cZrErV0SxCtn+5xX9a3OfrOE+rx3cllTQYCdiwaItBiVim3xVQVG3zmU8zi5j
 1flRATWukx7GU1Xj456qc+73aAVRjD1QUEDNTVtUsfH1DjSy6Mkehq6jFyP+lfZFv7CTDApvY
 zDfnO3l9kV6iLEGuMYgpyUP+5WxByIHMnS9i1iK1qL9UXVPFEpSv/qc9Dcua1EcFXaIS2CxYE
 ecLaoUF4XNSlY2MIGwpW/aQwdnBVsgbcZp/NsexE58gtR/qlJspVfPsa/oW59Pk/W/eEeWXDb
 bGrGRYIAt6Lk6j4kznp39FxhK9aMXP3VQ0TEDKIKKLNKIf0PwmHJbqtgxZIu3VleDFyNYG1dz
 XpXLjh5/2cMcraosM279k2rooVEFZ1f0l+ce/M5cUAk+fu36jsvMItRQbEzCW1jh2W4ljUI5w
 2hzV5Ew3svvGa54vPd8Nar9wnycky29HETQst9UoPmEx1r0C2e0V8Uik8zqvSZq0B9Q+DIQAz
 yCXIoDPfhM9oadoRLjV7RQLxFf96EuQ/AT+vvAvvKrA6GqfU3xnV6iriD6quwR9nMswcM2AxE
 mXYWagwrULzPjMARY7QKDmEVb0kq4k38uN6U4d2GSiQ4J7PnsB2Y0LuFvfMZIdBuJEZM7EzzG
 Z5GvXO/iwdm9jOOOEPWXkMcc655rBu5XKD4+p0C7MWaagiU2PoOB5aiRHAvLmU/I1z/KBPPzn
 e0wQ9a1R4J8C4odC6NyDEkGS5C6aYg0ORKLdqZA==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2020 at 12:29:45PM +0300, Andy Shevchenko wrote:
> On Thu, Sep 24, 2020 at 10:26 PM Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
> >
> > The Netronix embedded controller is a microcontroller found in some
> > e-book readers designed by the ODM Netronix, Inc. It contains RTC,
> > battery monitoring, system power management, and PWM functionality.
> >
> > This driver implements register access and version detection.
> >
> > Third-party hardware documentation is available at:
> >
> >   https://github.com/neuschaefer/linux/wiki/Netronix-MSP430-embedded-co=
ntroller
> >
> > The EC supports interrupts, but the driver doesn't make use of them so
> > far.
>=20
> ...
>=20
> > +#include <asm/unaligned.h>
>=20
> This usually goes after linux/*.h
> (and actually not visible how it's being used, but see below first)

I think it was a leftover from v1 before I used regmap for general
access to the registers. Will fix the ordering.

> > +#include <linux/delay.h>
> > +#include <linux/errno.h>
> > +#include <linux/i2c.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/mfd/ntxec.h>
> > +#include <linux/module.h>
> > +#include <linux/pm.h>
> > +#include <linux/reboot.h>
> > +#include <linux/regmap.h>
> > +#include <linux/types.h>
>=20
> ...
>=20
> > +static void ntxec_poweroff(void)
> > +{
> > +       int res;
> > +       u8 buf[] =3D {
> > +               NTXEC_REG_POWEROFF,
>=20
> > +               (NTXEC_POWEROFF_VALUE >> 8) & 0xff,
> > +               NTXEC_POWEROFF_VALUE & 0xff,
>=20
> '& 0xff' parts are redundant. *u8 implies that. Fix in all cases.
> Also I would rather see something like
>=20
>   buf[0] =3D _POWEROFF;
>   put_unaligned_be16(_VALUE, &buf[1]);
>=20
> to explicitly show the endianess of the register values.

Good idea.

> > +       };
> > +       struct i2c_msg msgs[] =3D {
> > +               {
> > +                       .addr =3D poweroff_restart_client->addr,
> > +                       .flags =3D 0,
> > +                       .len =3D sizeof(buf),
>=20
> > +                       .buf =3D buf
>=20
> It's slightly better to keep trailing commas in cases like this.

Ok.

>=20
> > +               }
> > +       };
> > +
> > +       res =3D i2c_transfer(poweroff_restart_client->adapter, msgs, AR=
RAY_SIZE(msgs));
> > +       if (res < 0)
>=20
> > +               dev_alert(&poweroff_restart_client->dev,
> > +                         "Failed to power off (err =3D %d)\n", res);
>=20
> alert? This needs to be explained.

I copied the dev_alert from drivers/mfd/rn5t618.c.

Upon reconsideration, I'm not sure what the correct log level would be,
but _warn seems enough, or maybe _err is better

> > +       /*
> > +        * The time from the register write until the host CPU is power=
ed off
> > +        * has been observed to be about 2.5 to 3 seconds. Sleep long e=
nough to
> > +        * safely avoid returning from the poweroff handler.
> > +        */
> > +       msleep(5000);
> > +}
> > +
> > +static int ntxec_restart(struct notifier_block *nb,
> > +                        unsigned long action, void *data)
> > +{
> > +       int res;
> > +       /*
> > +        * NOTE: The lower half of the reset value is not sent, because=
 sending
> > +        * it causes an error
>=20
> Why? Any root cause? Perhaps you need to send 0xffff ?

Unknown, because I don't have the EC firmware for analysis. The vendor
kernel sends 0xff00 and gets an error.

Sending 0xffff doesn't help.

> > +        */
> > +       u8 buf[] =3D {
> > +               NTXEC_REG_RESET,
>=20
> > +               (NTXEC_RESET_VALUE >> 8) & 0xff,
>=20
> Here you may still use put_unaligned_be16() but move the comment to be
> before len hardcoded to sizeof(buf) - 1.

Okay, will do.

>=20
> > +       };
> > +       struct i2c_msg msgs[] =3D {
> > +               {
> > +                       .addr =3D poweroff_restart_client->addr,
> > +                       .flags =3D 0,
> > +                       .len =3D sizeof(buf),
> > +                       .buf =3D buf
> > +               }
> > +       };
> > +
> > +       res =3D i2c_transfer(poweroff_restart_client->adapter, msgs, AR=
RAY_SIZE(msgs));
> > +       if (res < 0)
> > +               dev_alert(&poweroff_restart_client->dev,
> > +                         "Failed to restart (err =3D %d)\n", res);
> > +
> > +       return NOTIFY_DONE;
> > +}
>=20
> ...

An error in the i2c transfer here is an abnormal situation that should
in my opinion be logged, but I don't see what else the code can do here
to handle the error.

>=20
> > +static int ntxec_probe(struct i2c_client *client)
> > +{
> > +       struct ntxec *ec;
> > +       unsigned int version;
> > +       int res;
> > +
> > +       ec =3D devm_kmalloc(&client->dev, sizeof(*ec), GFP_KERNEL);
> > +       if (!ec)
> > +               return -ENOMEM;
> > +
> > +       ec->dev =3D &client->dev;
> > +
> > +       ec->regmap =3D devm_regmap_init_i2c(client, &regmap_config);
> > +       if (IS_ERR(ec->regmap)) {
> > +               dev_err(ec->dev, "Failed to set up regmap for device\n"=
);
> > +               return res;
> > +       }
> > +
> > +       /* Determine the firmware version */
> > +       res =3D regmap_read(ec->regmap, NTXEC_REG_VERSION, &version);
> > +       if (res < 0) {
> > +               dev_err(ec->dev, "Failed to read firmware version numbe=
r\n");
> > +               return res;
> > +       }
>=20
> > +       dev_info(ec->dev,
> > +                "Netronix embedded controller version %04x detected.\n=
",
> > +                version);
>=20
> This info level may confuse users if followed by an error path.

Right. I suppose printing incompatible versions is still useful, so how
about something like the following?


       /* Bail out if we encounter an unknown firmware version */
       switch (version) {
       case 0xd726: /* found in Kobo Aura */
	       dev_info(ec->dev,
			"Netronix embedded controller version %04x detected.\n",
			version);
               break;
       default:
	       dev_err(ec->dev,
			"Netronix embedded controller version %04x is not supported.\n",
			version);
               return -ENODEV;
       }

> > +
> > +       if (of_device_is_system_power_controller(ec->dev->of_node)) {
> > +               /*
> > +                * Set the 'powerkeep' bit. This is necessary on some b=
oards
> > +                * in order to keep the system running.
> > +                */
> > +               res =3D regmap_write(ec->regmap, NTXEC_REG_POWERKEEP,
> > +                                  NTXEC_POWERKEEP_VALUE);
> > +               if (res < 0)
> > +                       return res;
>=20
> > +               WARN_ON(poweroff_restart_client);
>=20
> WARN_ON? All these alerts, WARNs, BUGs must be explained. Screaming to
> the user is not good if it wasn't justified.

poweroff_restart_client being already set is not a situation that should
happen (and would indicate a bug in this driver, AFAICT), but I guess
the log message could be better in that case...

> > +               poweroff_restart_client =3D client;
> > +               if (pm_power_off)
> > +                       dev_err(ec->dev, "pm_power_off already assigned=
\n");
> > +               else
> > +                       pm_power_off =3D ntxec_poweroff;
> > +
> > +               res =3D register_restart_handler(&ntxec_restart_handler=
);
> > +               if (res)
> > +                       dev_err(ec->dev,
> > +                               "Failed to register restart handler: %d=
\n", res);
> > +       }
> > +
> > +       i2c_set_clientdata(client, ec);
> > +
> > +       res =3D devm_mfd_add_devices(ec->dev, PLATFORM_DEVID_NONE, ntxe=
c_subdevices,
> > +                                  ARRAY_SIZE(ntxec_subdevices), NULL, =
0, NULL);
> > +       if (res)
>=20
> > +               dev_warn(ec->dev, "Failed to add subdevices: %d\n", res=
);
>=20
> 'warn' is inconsistent with 'return err'. Either do not return an
> error, or mark a message as an error one.

Okay, I'll change it to dev_err.

>=20
> And above with the restart handler has the same issue.
>=20
> > +       return res;
> > +}
> > +
> > +static int ntxec_remove(struct i2c_client *client)
> > +{
>=20
> > +       if (client =3D=3D poweroff_restart_client) {
>=20
> When it's not the case?

The EC doesn't always need to provide poweroff/restart functionality,
and AFAIK, in some systems it doesn't. In those systems, ntxec_remove
would run with poweroff_restart_client =3D=3D NULL.

In theory, there might also be two of it in the same system, of which
only one controls system poweroff/restart, but I'm not sure if that is
actually the case on any existing board design.

> > +               poweroff_restart_client =3D NULL;
> > +               pm_power_off =3D NULL;
> > +               unregister_restart_handler(&ntxec_restart_handler);
> > +       }
> > +
> > +       return 0;
> > +}
>=20
> ...
>=20
> > +#include <linux/types.h>
> > +
>=20
> Missed
>=20
> struct device;
> struct regmap;
>=20
> here.

I'll add them.

> > +struct ntxec {
> > +       struct device *dev;
> > +       struct regmap *regmap;
> > +};
>=20
> > +/*
> > + * Some registers, such as the battery status register (0x41), are in
> > + * big-endian, but others only have eight significant bits, which are =
in the
> > + * first byte transmitted over I2C (the MSB of the big-endian value).
> > + * This convenience function converts an 8-bit value to 16-bit for use=
 in the
> > + * second kind of register.
> > + */
> > +static inline u16 ntxec_reg8(u8 value)
> > +{
> > +       return value << 8;
> > +}
>=20
> I'm wondering why __be16 is not used as returned type.

I didn't think of it, but it's a good idea. Will do.


Thanks,
Jonathan Neusch=C3=A4fer

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl9uYckACgkQCDBEmo7z
X9tfeA/+PcBI/xMedlMauddT3snjDWczk7NDO6pSKs9Z+FgLKmNM7VjP8KZ8BlSy
hZhYOCMqvnzPOTv+CR474Yn6sO4mzScSm2BRTo7k6CTOVO5BCKN1QvXRjkD6eCJ6
U2aUw4hssBJs/lJrbsejJDZA++/3o4AKPpZa2ZKgERbNCUaSL4osxgzh4n23qS4J
8NXyUKFzKOGtmVAek7FDfUMeqKVeVnfvtQ8baNJ6KKjHNBItK7LIAZ6Qfj5RKirT
dPmtkPKJnniw/pIsandzQcPk+6KOK+DTpu+xqR1X9jOF58pM33u8lviKsMzeIpYn
b9sMZrut9d/bJ+S8lhtw40KfjpFczabkd74T3IrCwSw242sTYoJDq+nMHkFr8YFG
EMItgLfmVvgodLNar6Xr/2I3820oyejrt4S6QAuRIe9e6KKLN3J/ltVKv7PChEU5
9tVfD2+5j72MZu25Gqvh0EKY6Jj7VirKqnqK/I3WgcK52EY4/hx6UHkaHKhGrdmX
kpQ4xx/dHijgC/7/D/1aJjSvGOwLHf87PYgfiH7E23F9WXZ5XtWzN3wiq87OgWY8
MOeXnX5Io2b3Zuts7lo+XNAZfKlzgX5B5xEPKtpdF5PGc6aqZ4Qxs/jwednvs7R4
4C3e/bll5qi8es1ap7ofnsswjMOMYKXv0WxrEc0/JEekBv7RKQA=
=+7Ew
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
