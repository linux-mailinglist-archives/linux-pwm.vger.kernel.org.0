Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D57D327BB3
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Mar 2021 11:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhCAKPZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Mar 2021 05:15:25 -0500
Received: from mout.gmx.net ([212.227.15.15]:32997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232216AbhCAKPI (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 1 Mar 2021 05:15:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614593597;
        bh=r393rC2gqKbOoEQyITdeiKG7xTX7wRI3Bq/NDLg2M6U=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jwupeDfSkzdMrJgYDRi7FA2i7KBNiZ7sb5xhjzvaPLXzRzTghrdkeOLSBCyocDXeH
         +19k6P/Vf6R0TrYktdYuEFIexIkmWRlawjcCNmr/qz8Xmy7XnQsjlgEh+jpCO7D7bl
         RsoJ+HivDFndcCdbkExhd/ML7zLcw0xaeCeIDKic=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [87.130.101.138] ([87.130.101.138]) by web-mail.gmx.net
 (3c-app-gmx-bs13.server.lan [172.19.170.65]) (via HTTP); Mon, 1 Mar 2021
 11:13:17 +0100
MIME-Version: 1.0
Message-ID: <trinity-1544ddd1-36d5-40f1-b110-373f1bbc776a-1614593597431@3c-app-gmx-bs13>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Sean Young <sean@mess.org>, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Aw: Re: [PATCH v3] pwm: bcm2835: Improve period and duty cycle
 calculation
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 1 Mar 2021 11:13:17 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <YDjhioD17ORWdo8B@ulmo.localdomain>
References: <20210114204804.143892-1-u.kleine-koenig@pengutronix.de>
 <YDjhioD17ORWdo8B@ulmo.localdomain>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:cqSaNDo4CfaNy1u0AmAGJEMlEJHsB8BCd7Y6A6i5uZKNPL9+MVo1DXpsS23TyAskZRmIC
 9ePm1z7P16NaSkAdMbeMm5WSh2kkXcQusFKMjR7B6Makd/Ua0LspjV42CNOKZ9HXK59IRrtkWWJL
 9mSXvozA0CTSHQRCTxia6wP3hZHEAFxW/rJSYsU43aGUA4qwycngS86Gur5Ag6VPttUqymNInxD0
 nic6OL8DCB7QX+zvKP/KPAJWWzq3DtGovH2H/ndUZ48P4b4HwdWh4whDMqRvh3ABHtYTVwbqriHh
 2w=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GMfcDbXRNWg=:WnYieDc/QA56rm24kZITww
 MgAf5NKzneYhBQTnLSKWr50zL7g+zdCN9I6DhUmngBUNCx3n7Zn+6h/hhTxldw9mdHmRIXnFf
 zD0ta5P4tfwQVb4uGTodSGWlUBl5dUGQPaUsjYvp0t8Jb757lhMxgQ+VqkuUnv8Pt0BNnDwHa
 k0xy67nuEsnUPaUATaOHjfLlG5zYmMbgTtGWKbgbQ24KN0WiWgRqJoZ46xvAnmQLWgPdfnfDC
 JGqv3OLCpSVxc5993pVYBv7bF6db9eEzeHLMDWCFyANtDVoe7YMTBOUgKLW8CjWNkg1cttKAg
 ZwXDmNkk18jS/qXNq8nQtEBCwcbsed2FLyvDqowPbQAlkrPmps2fQOzb4RJs89fNSVuJla1Q9
 9HHzo+6gvqv51yqV+sa8wuhVSOAdgu0J/5q93LLM3/dHWLK4yzvUqX7Q+kpqwUHH+Bt2AzQ2X
 4yl6A2fO5cAGqjP2msCCpXnXIsY1RChLLgh8qCZWpAjjaIYC9rdS8KwE6G1L5GmiXo49d30HZ
 OB/5xx2K1n2n6F4P8NNddglxk6rR3Yg9gi2FRQYIubnTqEUu/h8y0oLPfBi3OSpedD0HybWA1
 huYuZ+qgLokPA=
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Hi Thierry, Hi Uwe

> On Thu, Jan 14, 2021 at 09:48:04PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > With an input clk rate bigger than 2000000000, scaler would have been
> > zero which then would have resulted in a division by zero=2E
> >=20
> > Also the originally implemented algorithm divided by the result of a
> > division=2E This nearly always looses precision=2E Consider a requeste=
d period
> > of 1000000 ns=2E With an input clock frequency of 32786885 Hz the hard=
ware
> > was configured with an actual period of 983869=2E007 ns (PERIOD =3D 32=
258)
> > while the hardware can provide 1000003=2E508 ns (PERIOD =3D 32787)=2E
> > And note if the input clock frequency was 32786886 Hz instead, the har=
dware
> > was configured to 1016656=2E477 ns (PERIOD =3D 33333) while the optima=
l
> > setting results in 1000003=2E477 ns (PERIOD =3D 32787)=2E
> >=20
> > This patch implements proper range checking and only divides once for
> > the calculation of period (and similar for duty_cycle)=2E
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u=2Ekleine-koenig@pengutronix=2E=
de>
> > ---
> > Hello,
> >=20
> > changes since v2 (Message-Id:
> > 20201222221319=2E2101107-1-u=2Ekleine-koenig@pengutronix=2Ede):
> >=20
> >  - Add my calculation to the comment explaining the max_period formula
> >    as discussed with Lino=2E
> >=20
> > Best regards
> > Uwe
> >=20
> >  drivers/pwm/pwm-bcm2835=2Ec | 35 +++++++++++++++++++++++++++--------
> >  1 file changed, 27 insertions(+), 8 deletions(-)
>=20
> Florian, Lino,
>=20
> care to give a Reviewed-by and/or Tested-by on this?
>=20
> Thierry

this looks good to me, IMHO also the calculation now is comprehensible due=
 to the comment, so FWIW:

Reviewed-by: Lino Sanfilippo <LinoSanfilippo@gmx=2Ede>

Unfortunately I do not have the possibility to test this right now (I am c=
urrently working on another project)
but I will try to get the needed hardware and then do another test with th=
is patch=2E

Best Regards,
Lino

