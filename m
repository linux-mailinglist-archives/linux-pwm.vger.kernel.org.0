Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7904126DB21
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Sep 2020 14:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgIQMIh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Sep 2020 08:08:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:42977 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgIQMIY (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 17 Sep 2020 08:08:24 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 08:07:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600344418;
        bh=24JQ5sxy5SnOel0/HBCrFVsyOI5NmS1/SQy2+UMuASk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Tsn7Ag+JDQLQHP3Yw0GyVvjd2Ak07hzc2HG9ouWHP4pe6O3MkIJgyAfjj+vt+4jkH
         Rj5wCv651IyssEkildCv6XRtEgCcnkhxMgEYrVMTBsV1Bsb+22G+I6c77GTQfikN1v
         YY+g81M2IDdyRwIP0Lr56Ynx+++NGrrUszsb4M5E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHoRK-1kF4f53zks-00EveU; Thu, 17
 Sep 2020 13:58:54 +0200
Date:   Thu, 17 Sep 2020 13:58:48 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
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
        devicetree@vger.kernel.org,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Subject: Re: [PATCH v2 04/10] dt-bindings: pwm: Add bindings for PWM function
 in Netronix EC
Message-ID: <20200917115848.GH3306@latitude>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
 <20200905133230.1014581-5-j.neuschaefer@gmx.net>
 <20200915005443.GA604385@bogus>
 <20200915082348.2f6fff7a@aktux>
 <CAL_JsqL=gQxiU5uK-AEJtG3daOy83aS_D6G2Jo8_-dzKH70NkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y9PDtDHaFrXNoMPU"
Content-Disposition: inline
In-Reply-To: <CAL_JsqL=gQxiU5uK-AEJtG3daOy83aS_D6G2Jo8_-dzKH70NkQ@mail.gmail.com>
X-Provags-ID: V03:K1:S3H4EVtrAYZRUhJu6GbZc4OedPCD0Db2PTcKwit2EczWfGIux+C
 fTnPE7kzejg+V1Ln6NYce3Qz27+0vjAlwAKzArlfdi+JOqUrdrGoHbM60fLIEEnAsSIuc7G
 9G2E8kq7hBv1tPd+NjSvK3XdLv+WdFAf+bTWSsLRNnMvsXH524bMTTDY+239ZCG4urdVZ39
 wq8FHBknn1r/1vALX3caA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:anzz6x+VGXU=:Ap6qLk1j90q8pQl02qYR5i
 RjFjf/5JGBjybFfd3oWBX4AjvHxZkaiqBSwgSFzvXHeN6lv9iEAFILvAMnCCBfFnNBGIm1rGb
 5HTwKkd8wdg/v27bPLjxGeHJ/OR21IVpwEOXqGspfEeefGXhkCuisAuugrzjpJQBbWcE4sEAF
 Mc+ZN7ZfXfhjrTw/bneDlhCf+TEktmMQDlVeFr/1t6hS3eqLu3cxLqSGfJkCoL02uR37kjrkE
 swXjocwdW0S+du67yhzr/txD9hEXAfYshMa7z1Lc0kPV0wj2nZWxk2qda858lJB7kjfyHWB39
 vsRLlLpGGkPg/qEngb0bSlspKXdngRWztXON3tyGhFdfbwCyhAjTHxrD8aeN8qsyG+jmL4R3M
 Xe+m3sXo5A/lk296Xa04fBbTz03lpFxxONzgywCI1Aw7xw77KAUW234ROsO3/Rz8lyeiInLDP
 GmL0/neEusFOb9m2XFs5asBIFoLwSJ55m7BNBXObZ1y/EAcaYHMRHdMK7O5be3nEp4O2z1sUb
 hjnIcbBb3X3xPo8PPTobND58arzzXyqmq4vQzAvDEJ7YIc9ftLt2OOAQFiRzCYzxfFGBSotzY
 HMD8mIAm2eGBHUvdsPC2qjYg/DZ254sPfRtud2VSPMSP9v6RfY+vW1A6JNyCqKEa6mgHPkdno
 MFKYw3BxuT6cR3vvVDP3iczVuXSPmBEdXSaZpDHZWeMW75AI3L6CdA4GKxHDP8mOEXg8XrP0y
 H7Y1rdjGJ2FakIXZJJZpv2z1nf01Jm6G/SvBg6//kkYSQHZQmLhRdWou9mfpI9cePfVdMDNEm
 ODW6GOKERPX89bqpmnNoyVFn0yl72WPg0VD9orra6Aln05J7t0YEaMGJ02gr8WL0eUZK3lb6q
 iMk25gsbHN42ycJh2CBvfiSS3/5JU+BmQkBK9IrWOV9jB9A+nswjPQuoqI5KnDbBAChoYeqgu
 5OvDFo8pLOLVEkWqSXPSLzmCl34/mLkmTCpGCXnvJqNBFBUOSe//eySqUb1GKeO+kzYoUamO2
 IfUDzITGZnXjqnZh5Gg3tXh080Rd4noyEOQlkHxNvhEviq5HjHKy5/L+npJ+iQUoORdf212CB
 ubocYvOrvN6dlsEGDdW0IgqFDDa+6klXpr+SJobRvUceAQG80j58f12Aimpqy5h0isf3kQiHg
 WYv8uI3ta1Pse8UxtLcLUu4a7Zwru4YhrWM3BxCI45z/n23SE8KRzxyab0m3u4OzcIjuhY+mD
 nbwgcPGl8dyisQqePhkvJjBmo5ybYwKHc5AGg8g==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--y9PDtDHaFrXNoMPU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 08:31:55AM -0600, Rob Herring wrote:
> On Tue, Sep 15, 2020 at 12:24 AM Andreas Kemnade <andreas@kemnade.info> w=
rote:
> > On Mon, 14 Sep 2020 18:54:43 -0600 Rob Herring <robh@kernel.org> wrote:
[...]
> > > Just move this to the parent and make the parent a pwm provider. Ther=
e's
> > > no need for child nodes for this or the rtc.
> > >
> > hmm, there are apparently devices without rtc. If there is a child node
> > for the rtc, the corresponding devicetrees could disable rtc by not
> > having that node.
> > But maybe using the controller version is also feasible for that task.
>=20
> If not probeable, then the compatible string should distinguish that.

Okay.

It's even simpler in some cases: The firmware version reported by the EC
should tell us if it's one that is known to have no RTC.

That said, I don't have a good overview of the different variants of
this device.


Thanks,
Jonathan Neusch=C3=A4fer

--y9PDtDHaFrXNoMPU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl9jT3EACgkQCDBEmo7z
X9vUoxAAkyn46+EvI774tTF2xzkOECPy08b3dfWCKmdc1jT0+XgT9cP5TeB1mEE0
tX+cVVE9+yTFYno3cT8NwFY134Qzusin/+xBWUP07weUIt+ov6X3mFWjAV20ye9+
8+UcnwaLEXDXCbrt5hG+eexwlXVQuxjiHdjIdiRL7FyRfbedLGG9q2LQWUWom3Sm
Y3jGhzeEt60nIZTZ5iFcPT8P87tpT65YArmuO11ryUEoodzgO2mYsGR1ovZcN8vN
DvEvDWuWxnPwNY5AAsFCyF2vzgif9aWwixCKskED8L33IC6HscmusmaEQNF1XpRk
/khi5dhGqpsuSP9BkMC9HTPwVxmKZBX7BM7MpQYvQiAQCgKbqUPXiRYdHRNjCPCl
OQg0/7FBlq7hVeZQeM92eEqiHaxtq7MjLpctM19vBwMlkJ4bX82qzsC/E7RtRyNu
Il9eY7xG61gcyCLV0na7C+Cnwfva6u951d2pUI8N4KH/GsEbDY7FZiD07qBKv1Ur
BAbDSOGryF/aRL/AJ1FyZrm9VxSSxoEkHeeTsuEn7OhhrRff4FCb/jfLZLnMv3KK
tDCic9mPL1nsiOHU32qmzYkfpQRpVEBCN2/SwDNtqfl82TLA+6bLtPnWsXcCWWdi
BTWzBgu+dvJa46LUBFKjRVliAHA/t9hyD7Vd0pZXt21rAoDXSmM=
=YAep
-----END PGP SIGNATURE-----

--y9PDtDHaFrXNoMPU--
