Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5A520BBFD
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2020 23:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgFZV4j (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 26 Jun 2020 17:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgFZV4i (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 26 Jun 2020 17:56:38 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54467C03E979;
        Fri, 26 Jun 2020 14:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7IHCsdnoUmmfDZldhAWNkEIt+lt8DWXAOajFIarz2tE=; b=kKEbfSWnL3KXAAUyV5RJhsMkFq
        R168LUlj+Kwcx5NqFvReQe4AX2Yqvt/2oLFrlX6nD9Zezq3YWFwNXbSl3N2TlQIk84oxLkxYuPFiN
        h5g7fLxL176wH380RcqVwdrXjNXgn9mf8ETlFXyCl3iFQQgwvZDhqOjS8UZGEtDiLwNo=;
Received: from p200300ccff124000e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff12:4000:e2ce:c3ff:fe93:fc31] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1jowK9-00029R-MS; Fri, 26 Jun 2020 23:56:00 +0200
Received: from [::1] (helo=localhost)
        by localhost with esmtp (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1jowK8-0005Gb-RO; Fri, 26 Jun 2020 23:55:52 +0200
Date:   Fri, 26 Jun 2020 23:55:52 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
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
Subject: Re: [RFC PATCH 07/10] dt-bindings: rtc: Add bindings for Netronix
 embedded controller RTC
Message-ID: <20200626235552.7820a999@kemnade.info>
In-Reply-To: <20200621000220.GB131826@piout.net>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
        <20200620224222.1312520-6-j.neuschaefer@gmx.net>
        <20200621000220.GB131826@piout.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 21 Jun 2020 02:02:20 +0200
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Hi,
>=20
> On 21/06/2020 00:42:18+0200, Jonathan Neusch=E4fer wrote:
> > The Netronix EC implements an RTC with the following functionality:
> >=20
> > - Calendar-based time keeping with single-second resolution
> > - Automatic power-on with single-minute resolution
> > - Alarm at single-second resolution
> >=20
> > This binding only supports timekeeping for now.
> >=20
> > Signed-off-by: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>
> > ---
> >  .../bindings/mfd/netronix,ntxec.yaml          |  7 +++++
> >  .../bindings/rtc/netronix,ntxec-rtc.yaml      | 27 +++++++++++++++++++
> >  2 files changed, 34 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/netronix,ntxe=
c-rtc.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml =
b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> > index 6562c41c5a9a9..f6a32f46f47bb 100644
> > --- a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> > @@ -34,6 +34,9 @@ properties:
> >    pwm:
> >      $ref: ../pwm/netronix,ntxec-pwm.yaml
> >=20
> > +  rtc:
> > +    $ref: ../rtc/netronix,ntxec-rtc.yaml
> > + =20
>=20
> Shouldn't the node simply be documented here?
>=20
> Also, do you really need a compatible string to be able to proe the
> driver? What are the chances that you'll get a similar EC without an
> RTC?
>=20
Tolino Shine 2 HD has the mentioned EC but the vendor kernel does not use
its RTC (not checked whether it is present or functional).
As a key for grepping in the vendor sources:=20
gptNtxHwCfg->m_val.bPCB =3D 0x50

Tolino Shine 3  and Kobo Clara HD do not have that EC.

Regrads,
Andreas
