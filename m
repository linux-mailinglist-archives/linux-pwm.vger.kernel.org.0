Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B4D264FBD
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Sep 2020 21:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgIJTuc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Sep 2020 15:50:32 -0400
Received: from mout.gmx.net ([212.227.15.19]:44107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbgIJTs6 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 10 Sep 2020 15:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599767332;
        bh=S5yPB053GMXMHY3i5MJ4KAmLRKTmf2lq+7D4srpxwxA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=jM1asNJt/ix2ZlIOnXfAE6sccIIMgf8FxojhOifClk+HKpCj9HgRFuUXrsm1ManNZ
         RZFdeuO858ImmrQfexQpRKbRsIqrX4fDwdLlj/fdrAIp21A4ZbyGMb4sm92sgupfUT
         woI+Yij2bBzD59wPPu1fmCTwJ4Yv0I+TcK9Zd3OI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wLZ-1k9buV46Xb-007YSO; Thu, 10
 Sep 2020 21:42:25 +0200
Date:   Thu, 10 Sep 2020 21:42:20 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Subject: Re: [PATCH v2 08/10] rtc: New driver for RTC in Netronix embedded
 controller
Message-ID: <20200910194220.GE3306@latitude>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
 <20200905144503.1067124-1-j.neuschaefer@gmx.net>
 <CAHp75Vca+Tp0v_Q4RBuUNSo_5aq_u6mBGeXecHULC1Avgm5=Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline
In-Reply-To: <CAHp75Vca+Tp0v_Q4RBuUNSo_5aq_u6mBGeXecHULC1Avgm5=Xg@mail.gmail.com>
X-Provags-ID: V03:K1:I+JHLMuApGMJsrLC1+HTMJo4e+AdFLZlrfPoEwt9cZhavkBEALt
 KEuqmQh83PWYEOPX4hpSBy14KsqEc22Bv6M6KBWlWjugfK8dQ3fqoEsSgzpUTPBP3klCStn
 DLchNVAcurXMi7f7tztEYTNgRxekTEMRiFgRLqlbVmP7sBQsU9ROBaYKU6iBVigHi6IRHCM
 nxMX7UNeDkSoMvWURjeOg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2dHLMKghe+A=:ParlLhkgApuJLRZToMXMcX
 SpZV16KncewUV8cUZPir1GulBY6LLM7bRPIPzZSLpJpB45Vqzkeo7FM/HurFQE8E8W0qKnNhr
 DFoA/0Pf0YVlO2wRmUDuhrp1tVWchHBG/6ewIpOcvLL9JYchQfdhADkiB69P7yeEo/AV8AIWX
 7CG10fYKzQyvw4vCNzcndiJZfnngABszAuxzHvhWltTR14kNBZB5K32I6/sOOEYpW1Exi4nYf
 OTDN31IoJmuMlAFni9uHsZPh2qK8v76hmuD2XU+28FAEuR5OTWYD86hsV/gEu6wN5ktBmXTQ4
 DVS+uucosDVAQ1LWYeU9x4CmuY1pnc8BB9y21uYTR/cxkQ1BH2lvHb4A478XxNFP9gXX+LqdN
 S11H5fHzqzQxZvKAoAUWk49uOIFt4ExaCsOTe3uByll7YJ3LESe8wiAafBcPM4+II5oLqB8Sk
 LuBXvXOeaHgqHK3iJReQG2w5HAHF/LP2SA1W714eLZuGYYk9qwfQsHmu8wevDjsBJW5mPVdba
 2zhBUfhkXQX3Lb8B5bXom6pZIoXR12XfIfqSSijCNB6y/wU1ejoK4NReoB63DhioFiI95GA2e
 tZCtAo0D5YJBMbV7anJ79881AuavVnpVQ1/dWH+BilBeyIyrL3AM9t3bqc0pqWkG6W8q+n9Qe
 mjtzMuGa3RygjmPnZqBHNOimIeRqgkn20LFvfgyI5saQGp2L6G3w240I4/d6NTp81LvCA2G0d
 ik58XSwa/bS3JjnHDrEIl7yBbmXWGoPjgXiBW07nIL9p5gdovyNVZljj1Q7cUerDZSRJqVI8a
 Wyym8gRauOSoQEAoJRyslUzFjZnr3egV78YxMw+nQIzr0+PwWsbvm/3oSGTCjSRnsfUninb8D
 8162fTVWJr47U0602S5QSNG49yzFFQCPStfU1gAOYN/2KGhPkNhqfNBSWoIyEFrZuToLKSVE+
 QXBcg3aka+jps1BR2pf9EohJNe+g4hPrlM+AYuTg14PEVmKDFVEz0X9l68TusDxJ/zUbEYoLR
 Iy+6sHpmZpR01F6CDv8WesD2pb2SwV5Usa8/MQ/sR9IdGJ/NmpzxZpSDpAZA6pTF+QkiShkQ1
 8tFc1WSulCH4YD+ItoIZgNYwdZ8mj/wqnTCxMJXTn1x8dNpOcbVZHHp0HnSOl0o8G64N5hSRs
 1K/EzKoTeY4Uplxz8QiGVu4aygQpaY+BhZ/FsGXWLupwubeizQTUZI7W9C/87aOPuZzYEgn4D
 X3RQBD2lrmt0ItZvvbqDI9XqQKjYEkN+Fyd37vA==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 05, 2020 at 08:56:35PM +0300, Andy Shevchenko wrote:
> On Saturday, September 5, 2020, Jonathan Neusch=C3=A4fer <j.neuschaefer@g=
mx.net>
> wrote:
[...]
> > +#include <linux/of_device.h>
>=20
>=20
> No user for this. Perhaps you meant mod_devicetable.h?

Yes

> > +/* Convert an 8-bit value into the correct format for writing into a
> > register */
> > +#define u8_to_reg(x) (((x) & 0xff) << 8)
>=20
>=20
> This needs more explanation. Does register be16?

Yes, the registers are treated as be16 in the base driver. I wrote a
slightly longer explanation in response to your other review.

> > +static int ntxec_set_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +       struct ntxec_rtc *rtc =3D dev_get_drvdata(dev);
> > +       int res =3D 0;
> > +
> > +       res |=3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_YEAR,
> > u8_to_reg(tm->tm_year - 100));
> > +       res |=3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_MONTH,
> > u8_to_reg(tm->tm_mon + 1));
> > +       res |=3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_DAY,
> > u8_to_reg(tm->tm_mday));
> > +       res |=3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_HOUR,
> > u8_to_reg(tm->tm_hour));
> > +       res |=3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_MINUTE,
> > u8_to_reg(tm->tm_min));
> > +       res |=3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_SECOND,
> > u8_to_reg(tm->tm_sec));
> > +
> > +       return (res < 0) ? -EIO : 0;
>=20
>=20
> Hmm... (I stumbled over res |=3D parts)

I'll convert it to the (more verbose but also more correct) pattern of
returning each error early.

> > +static const struct of_device_id ntxec_rtc_of_match[] =3D {
> > +       { .compatible =3D "netronix,ntxec-rtc" },
> > +       { },
>=20
>=20
> No need for comma in terminator line.

Okay


Thanks,
Jonathan Neusch=C3=A4fer

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl9agZQACgkQCDBEmo7z
X9t7Vg//TklGb5L5lL/xuITfZUbaWRE0NO9ebO0gQJ0jIXLZw0XMii5+QFlgjmn/
53tgs2wghDAcz4Es/t9azuuiTLkt76nIZU2uYGX17ULQ9RK3bEA3Wz8N+7VY3QXM
txcZ4McFlMCmWAhclQDnK3VVywI3Nu0iF6CNnWQY1xRH4KmjyIAbXkalDiYI3y3s
VRcdUjBTaOEQSnNoQFSew2DN1yl+OpN5z7XONYznBWMpnMAzB5+QL/IHrIYjvVZt
3lnu2beHd4eUGHH6RsyqyRGJHM59uUckMynmEdXjuoktOdLJte3pXdce4EE7HF6k
LJCMrRcZP7XKe+AP4DQaFD3fr9ZHU6z6yqtgePzGh6aAtgjjnC16Y4mgEK0Lvvb8
5Z1PU9e39G1WqsSnacmdRPBgxTT8hbogcnroW4GKfE3VW2ph1CE4CDCc1cBYzu93
NhtNw6fTa9gXJXETC5zEH+Xf/Yf9K5cCwsuvzVGnBJbw57530eMuzV4/PjwOlayM
fDa4BM+N9Lf/EIfzupT5CTcTFvUmz5Ao4aM1XQOFTtdtEjKdqZV1O2Y1tH7+Zfj3
TDG1itKF2vm9iToGWEr4wMoe/X75/uf7YV7kGhN8kv3kIPBpeeygOyP96dJo1Gk5
gQ2N3HBm2oesXQSvoEhMmCuUSLHkuL5sB7Zz1NRMN7XomQ+7rEA=
=9c8/
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--
