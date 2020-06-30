Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7500B20FD7E
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2020 22:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgF3UPO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Jun 2020 16:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgF3UPN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Jun 2020 16:15:13 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54218C061755;
        Tue, 30 Jun 2020 13:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1Ui03MDnvSSEH+dE2r4HpklkE7If5x4CxWOyDT8PhmU=; b=Wh3csM/nQp3I5ofBzGGjZDfmYj
        LX+B7MD3aD8f2k/+PYmWZyZyyKgybka3XZb1BjeE+VsEA7Qlt9iqw7xVB7nMnpjojxCgaAPsSYXMY
        LI5lCGwSDCA0+UYZx5CisLClLFp+EK/oo6qg8DTzrqz6BsPpGlDpHipOKimQdSNybo/4=;
Received: from p200300ccff14dd001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff14:dd00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1jqMeX-0002Ca-6r; Tue, 30 Jun 2020 22:14:49 +0200
Date:   Tue, 30 Jun 2020 22:14:47 +0200
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
Message-ID: <20200630221447.3e03ae28@aktux>
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
>=20
turing debugging on:

[  330.330599] i2c i2c-0: <i2c_imx_xfer_common>
[  330.330621] i2c i2c-0: <i2c_imx_start>
[  330.332927] i2c i2c-0: <i2c_imx_bus_busy>
[  330.332953] i2c i2c-0: <i2c_imx_xfer_common> transfer message: 0
[  330.332971] i2c i2c-0: <i2c_imx_write> write slave address: addr=3D0x86
[  330.334365] i2c i2c-0: <i2c_imx_trx_complete> TRX complete
[  330.334386] i2c i2c-0: <i2c_imx_acked> ACK received
[  330.334402] i2c i2c-0: <i2c_imx_write> write data
[  330.334420] i2c i2c-0: <i2c_imx_write> write byte: B0=3D0xA3
[  330.334756] i2c i2c-0: <i2c_imx_trx_complete> TRX complete
[  330.334774] i2c i2c-0: <i2c_imx_acked> ACK received
[  330.334790] i2c i2c-0: <i2c_imx_write> write byte: B1=3D0x0
[  330.351573] i2c i2c-0: <i2c_imx_trx_complete> TRX complete
[  330.351598] i2c i2c-0: <i2c_imx_acked> No ACK
[  330.351613] i2c i2c-0: <i2c_imx_stop>
[  330.351629] i2c i2c-0: <i2c_imx_bus_busy>
[  330.351648] i2c i2c-0: <i2c_imx_xfer_common> exit with: error: -6
[  330.351690] i2c i2c-0: <i2c_imx_xfer_common>
[  330.351704] i2c i2c-0: <i2c_imx_start>
[  330.352297] i2c i2c-0: <i2c_imx_bus_busy>
[  330.352321] i2c i2c-0: <i2c_imx_xfer_common> transfer message: 0
[  330.352339] i2c i2c-0: <i2c_imx_write> write slave address: addr=3D0x86
[  330.362152] i2c i2c-0: <i2c_imx_trx_complete> TRX complete
[  330.362176] i2c i2c-0: <i2c_imx_acked> ACK received
[  330.362191] i2c i2c-0: <i2c_imx_write> write data
[  330.362208] i2c i2c-0: <i2c_imx_write> write byte: B0=3D0xA1
[  330.362442] i2c i2c-0: <i2c_imx_trx_complete> TRX complete
[  330.362461] i2c i2c-0: <i2c_imx_acked> ACK received
[  330.362479] i2c i2c-0: <i2c_imx_write> write byte: B1=3D0xFF
[  330.362686] i2c i2c-0: <i2c_imx_trx_complete> TRX complete
[  330.362705] i2c i2c-0: <i2c_imx_acked> No ACK
[  330.362720] i2c i2c-0: <i2c_imx_stop>
[  330.362735] i2c i2c-0: <i2c_imx_bus_busy>
[  330.362753] i2c i2c-0: <i2c_imx_xfer_common> exit with: error: -6
[  330.362794] i2c i2c-0: <i2c_imx_xfer_common>
[  330.362808] i2c i2c-0: <i2c_imx_start>
[  330.363071] i2c i2c-0: <i2c_imx_bus_busy>
[  330.363094] i2c i2c-0: <i2c_imx_xfer_common> transfer message: 0
[  330.363112] i2c i2c-0: <i2c_imx_write> write slave address: addr=3D0x86
[  330.363313] i2c i2c-0: <i2c_imx_trx_complete> TRX complete
[  330.363331] i2c i2c-0: <i2c_imx_acked> ACK received
[  330.363346] i2c i2c-0: <i2c_imx_write> write data
[  330.363362] i2c i2c-0: <i2c_imx_write> write byte: B0=3D0xA2
[  330.363572] i2c i2c-0: <i2c_imx_trx_complete> TRX complete
[  330.363591] i2c i2c-0: <i2c_imx_acked> ACK received
[  330.363608] i2c i2c-0: <i2c_imx_write> write byte: B1=3D0xFF
[  330.363822] i2c i2c-0: <i2c_imx_trx_complete> TRX complete
[  330.363841] i2c i2c-0: <i2c_imx_acked> No ACK
[  330.363854] i2c i2c-0: <i2c_imx_stop>
[  330.363869] i2c i2c-0: <i2c_imx_bus_busy>
[  330.363886] i2c i2c-0: <i2c_imx_xfer_common> exit with: error: -6

Regards,
Andreas
