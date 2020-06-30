Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FDC20EEAB
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2020 08:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgF3Gl1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Jun 2020 02:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730190AbgF3Gl1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Jun 2020 02:41:27 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC320C061755;
        Mon, 29 Jun 2020 23:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dqdqP9RRgNiXtHwuMESvsYqArYSjsXn6hYwLSXg9Z+E=; b=kMxKmpbGA6gEpK5aXTTnvAWOIn
        aJE8zIQ54SyYGKsa11ofbBkJH+aaExjMqYDyRiaDklgGG2rE7Og+YI8cTnmEDr4LNXeDxyzaICYFe
        Mx67qtcLaPRekFa4PhhKpSEIkrDkwNeHwhkGiVynpoKPdQUkr3nHf/bY9gBk84xwHseQ=;
Received: from p200300ccff14dd001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff14:dd00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1jq9wq-0004vi-W6; Tue, 30 Jun 2020 08:40:53 +0200
Date:   Tue, 30 Jun 2020 08:40:51 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
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
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>
Subject: Re: [RFC PATCH 00/10] Netronix embedded controller driver for Kobo
 and Tolino ebook readers
Message-ID: <20200630084051.66feadea@aktux>
In-Reply-To: <20200620223915.1311485-1-j.neuschaefer@gmx.net>
References: <20200620223915.1311485-1-j.neuschaefer@gmx.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Sun, 21 Jun 2020 00:39:04 +0200
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:

> Hi,
>=20
> This patchset adds basic support for the embedded controller found on
> older ebook reader boards designed by/with the ODM Netronix Inc.[1] and
> sold by Kobo or Tolino, for example the Kobo Aura and the Tolino Shine.
> These drivers are based on the vendor kernel sources, but in order to
> all information in a single place, I documented the register interface
> of the EC on GitHub[4].
>=20
> A few things still needs to be ironed out, hence the RFC tag:
>  - The reboot/reset handler in patch 3/10 calls into I2C code, which may
>    sleep, but reboot handlers are apparently not allowed to sleep.
>  - I'm not sure I got the YAML DT bindings right. I have also included
>    the plain text DT bindings for reference.
>=20
>=20
got a chance to test it on a Tolino Shine 2 HD.
It uses the RTC from the RC5T619 but backlight seems to go via MSP430
EC.

I got this.

[    1.453603] ntxec 0-0043: Netronix embedded controller version f110 dete=
cted.
[   10.723638] ntxec-rtc 21a0000.i2c:embedded-controller@43:rtc: registered=
 as rtc0
[   10.775276] ntxec-pwm: probe of 21a0000.i2c:embedded-controller@43:pwm f=
ailed with error -5
[   10.850597] ntxec-rtc 21a0000.i2c:embedded-controller@43:rtc: hctosys: u=
nable to read the hardware clock

version number matchess with what the vendor kernel reports. Maybe we
should document which version is running on which devices?

&i2c1 {
        pinctrl-names =3D "default","sleep";
        pinctrl-0 =3D <&pinctrl_i2c1>;
        pinctrl-1 =3D <&pinctrl_i2c1_sleep>;
        status =3D "okay";

        embedded-controller@43 {
//              pinctrl-names =3D "default";
//              pinctrl-0 =3D <&pinctrl_ec>;
                compatible =3D "netronix,ntxec";
                reg =3D <0x43>;
                interrupts-extended =3D <&gpio5 11 IRQ_TYPE_EDGE_FALLING>;
                interrupt-controller;
                #interrupt-cells =3D <1>;

                ec_pwm: pwm {
                        compatible =3D "netronix,ntxec-pwm";
                        #pwm-cells =3D <2>;
                };

                rtc {
                        compatible =3D "netronix,ntxec-rtc";
                };
        };
};

Regards,
Andreas
