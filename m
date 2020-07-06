Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734AB215F53
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2020 21:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgGFT3X (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Jul 2020 15:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgGFT3X (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Jul 2020 15:29:23 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79AFC061755;
        Mon,  6 Jul 2020 12:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=J+EsQQs1HUBrfOSzhNecD2M81XWwzO+HyRXgroFAxgk=; b=k03cFx+8mx+FJD/tl2s7IMVwiy
        iNCJlj5ygc2kLSa91DasQzKXl8lSP7IFL+573UsRp13GRB1X0muGUbK5ZvzGrH3uO/yFRzvWTFyXN
        1ryu+HMVt2tDCXop+i5hPiKFmoHQ2Dk3BHCemJqW7R7IKvGaRrKu1nCh8raJcYNokvW4=;
Received: from p200300ccff0e48001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0e:4800:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1jsWnN-0003Yy-Tw; Mon, 06 Jul 2020 21:28:54 +0200
Date:   Mon, 6 Jul 2020 21:28:48 +0200
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
Message-ID: <20200706212848.7e19886b@aktux>
In-Reply-To: <20200704205808.GD2578@latitude>
References: <20200620223915.1311485-1-j.neuschaefer@gmx.net>
        <20200630084051.66feadea@aktux>
        <20200630071523.GA2983@latitude>
        <20200630221447.3e03ae28@aktux>
        <20200704205808.GD2578@latitude>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, 4 Jul 2020 22:58:08 +0200
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:

> On Tue, Jun 30, 2020 at 10:14:47PM +0200, Andreas Kemnade wrote:
> > On Tue, 30 Jun 2020 09:15:23 +0200
> > Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:
> >  =20
> > > On Tue, Jun 30, 2020 at 08:40:51AM +0200, Andreas Kemnade wrote:
> > > [...] =20
> > > > got a chance to test it on a Tolino Shine 2 HD.
> > > > It uses the RTC from the RC5T619 but backlight seems to go via MSP4=
30
> > > > EC.
> > > >=20
> > > > I got this.
> > > >=20
> > > > [    1.453603] ntxec 0-0043: Netronix embedded controller version f=
110 detected.
> > > > [   10.723638] ntxec-rtc 21a0000.i2c:embedded-controller@43:rtc: re=
gistered as rtc0
> > > > [   10.775276] ntxec-pwm: probe of 21a0000.i2c:embedded-controller@=
43:pwm failed with error -5   =20
> > >=20
> > > Hmm, -EIO from the PWM driver.
> > >  =20
> > turing debugging on: =20
>=20
> (edited for compactness:)
> > [  330.332971] i2c i2c-0: write slave address: addr=3D0x86   ACK receiv=
ed
> > [  330.334420] i2c i2c-0: write byte: B0=3D0xA3              ACK receiv=
ed
> > [  330.334790] i2c i2c-0: write byte: B1=3D0x0               No ACK =20
>=20
> > [  330.352339] i2c i2c-0: write slave address: addr=3D0x86   ACK receiv=
ed
> > [  330.362208] i2c i2c-0: write byte: B0=3D0xA1              ACK receiv=
ed
> > [  330.362479] i2c i2c-0: write byte: B1=3D0xFF              No ACK =20
>=20
> > [  330.363112] i2c i2c-0: write slave address: addr=3D0x86   ACK receiv=
ed
> > [  330.363362] i2c i2c-0: write byte: B0=3D0xA2              ACK receiv=
ed
> > [  330.363608] i2c i2c-0: write byte: B1=3D0xFF              No ACK =20
>=20
> Hmm, it doesn't ack the writes to 0xA3, 0xA1 and 0xA2, which should
> disable the PWM output and then disable the auto-off timer (according to
> the vendor kernel).
>=20
> And you said in your other mail that you can actually toggle the light
> with writes to 0xA3, so I suspect a bug in the EC firmware here (which
> may have gone unnoticed because the vendor kernel doesn't check if the
> i2c transfers succeed). :/
>=20
That is a also my theory.

> IMHO we should get this driver merged first, and perhaps add a quirk to
> deal with the missing ACKs later (unless a better solution is found).
>=20
Yes, that can be done separately (after the Tolino Shine 2 HD dtb is
in, I am polishing it right now).

Regards,
Andreas
