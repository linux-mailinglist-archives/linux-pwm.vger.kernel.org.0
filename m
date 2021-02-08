Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B8431426A
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Feb 2021 22:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbhBHV57 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Feb 2021 16:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhBHV5s (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Feb 2021 16:57:48 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5E5C061786;
        Mon,  8 Feb 2021 13:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=muAMtb9ILWZ6iaLm4pWkawLMXFX8+VhM7QtMLbbVjO8=; b=CSepVBcl/mu1uxOGAD7x76EaSG
        +LBzoX4IQP+rspzFB9N16nU4JP/i3Kcwahr9P/Ql2k/DNe1nbPGqc5uIiTlGT8PeiIsMn74s1kfG8
        8yLycgCCScpr5qAROdrbkv7+lDLrEqor+QByAeBVoAXT/d8PJYHy2u7k7XXX7w5xLA9k=;
Received: from p200300ccff06e1001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff06:e100:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1l9EWT-0005aA-En; Mon, 08 Feb 2021 22:56:45 +0100
Date:   Mon, 8 Feb 2021 22:56:44 +0100
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
        Josua Mayer <josua.mayer@jm0.eu>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 0/7] Netronix embedded controller driver for Kobo and
 Tolino ebook readers
Message-ID: <20210208225644.3df4da99@aktux>
In-Reply-To: <20210124214127.3631530-1-j.neuschaefer@gmx.net>
References: <20210124214127.3631530-1-j.neuschaefer@gmx.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 24 Jan 2021 22:41:20 +0100
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:

> This patchset adds basic support for the embedded controller found on
> older ebook reader boards designed by/with the ODM Netronix Inc.[1] and
> sold by Kobo or Tolino, for example the Kobo Aura and the Tolino Shine.
> These drivers are based on information contained in the vendor kernel
> sources, but in order to all information in a single place, I documented
> the register interface of the EC on GitHub[2].
>=20
> [1]: http://www.netronixinc.com/products.aspx?ID=3D1
> [2]: https://github.com/neuschaefer/linux/wiki/Netronix-MSP430-embedded-c=
ontroller
>=20
> v9:
> - Fixed a bug in the error handling of ntxec_probe,
>   Reported-by: kernel test robot <lkp@intel.com>
> - Added Thierry Reding's ACK to the PWM patch
>=20
what is the fate of this one, looks like it got all acks from
maintainers.

Regards,
Andreas
