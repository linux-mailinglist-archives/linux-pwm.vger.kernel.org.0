Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A247E20FCA8
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2020 21:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgF3TWg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Jun 2020 15:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgF3TWg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Jun 2020 15:22:36 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F54C061755;
        Tue, 30 Jun 2020 12:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Z50zmfnBPo2u0p8708BAruvf3MnDJq1nng3tchC4BxM=; b=CSRw4qA3mqrXDXC30pTR66alas
        v8/PTBq36Esj+PKN5s/rhns+lUf5KGCaFmEjZLDjCMief1m4AzpfaSpc4pou2l0sWIOxlI1pDg654
        1hCURAZCV5U5z0PapH1RKgrrIwNB7wug4UAaLLNjuNBQINiSr99qYZPe67P4DDMxbpTc=;
Received: from p200300ccff14dd001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff14:dd00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1jqLpZ-0001r0-AN; Tue, 30 Jun 2020 21:22:09 +0200
Date:   Tue, 30 Jun 2020 21:22:07 +0200
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
Message-ID: <20200630212207.018ad355@aktux>
In-Reply-To: <20200630071523.GA2983@latitude>
References: <20200620223915.1311485-1-j.neuschaefer@gmx.net>
        <20200630084051.66feadea@aktux>
        <20200630071523.GA2983@latitude>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 30 Jun 2020 09:15:23 +0200
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:

> On Tue, Jun 30, 2020 at 08:40:51AM +0200, Andreas Kemnade wrote:
> [...]
> > got a chance to test it on a Tolino Shine 2 HD.
> > It uses the RTC from the RC5T619 but backlight seems to go via MSP430
> > EC.
> >=20
> > I got this.
> >=20
> > [    1.453603] ntxec 0-0043: Netronix embedded controller version f110 =
detected.
> > [   10.723638] ntxec-rtc 21a0000.i2c:embedded-controller@43:rtc: regist=
ered as rtc0
> > [   10.775276] ntxec-pwm: probe of 21a0000.i2c:embedded-controller@43:p=
wm failed with error -5 =20
>=20
> Hmm, -EIO from the PWM driver.
>
Weird...
IOMUXC_SW_PAD_CTL_PAD_I2C1_SDA/SCL is identical between
vendor kernel (heavily patched 3.0.35) and patched mainline.
                       =20
MX6SL_PAD_I2C1_SCL__I2C1_SCL     0x4001f8b1
MX6SL_PAD_I2C1_SDA__I2C1_SDA     0x4001f8b1

root@tolino2:~# i2cset -f 0 0x43 0xa3 0x0001 w
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will write to device file /dev/i2c-0, chip address 0x43, data address
0xa3, data 0x01, mode word.
Continue? [Y/n]=20
Error: Write failed
root@tolino2:~# i2cset -f 0 0x43 0xa3 0x0000 w
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will write to device file /dev/i2c-0, chip address 0x43, data address
0xa3, data 0x00, mode word.
Continue? [Y/n]=20
Error: Write failed

but backlight gets toggled. Same behavior on vendor kernel and
in vendor uboot.
That smells.

Regards,
Andreas
