Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B6F264EC1
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Sep 2020 21:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgIJTXf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Sep 2020 15:23:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:46917 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbgIJTWh (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 10 Sep 2020 15:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599765697;
        bh=kDCS9dN7hqNGMC055GQUbyi4MlM92SA6KMWryr8hAJs=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=b5XeNNvDCXlPPb+K9G5hSueCN5zQJ5Zm/04uYQASm3zmYki2QphpNis7IWd1b2mjZ
         uUERKqA9LQ9GwI57Ynl9qoOKMFa+dQrWQ4uICZdTlpN+iiNysA3rSuY9VLqG1EzWb9
         qQjasbRmg/58oq/efQ8IL5kTkm6HbaGQryhIgkHw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26r3-1kEWKW0cxd-002Wa6; Thu, 10
 Sep 2020 21:21:37 +0200
Date:   Thu, 10 Sep 2020 21:21:24 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
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
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Subject: Re: [PATCH v2 07/10] rtc: Introduce RTC_TIMESTAMP_END_2255
Message-ID: <20200910192124.GD3306@latitude>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
 <20200905133230.1014581-8-j.neuschaefer@gmx.net>
 <20200908093946.GQ230586@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Content-Disposition: inline
In-Reply-To: <20200908093946.GQ230586@piout.net>
X-Provags-ID: V03:K1:E21EYSXgKsjD3uQMAQCJ/0uwFmX9uxR62kFo4Q7nePnG3YxtxG6
 nzcUlvqNHdjM0/OT5wL1hOajMmonor+UaNtyZ6AnmhFwDb4oxQmU14eO8zcBVMGi779txLV
 gAK24vGk4z1tAlqRCFXqqdSKC7IQg7Zp31MSdPUUqgipotsboY0FZRqxOZNLL+LF2J1RN1s
 g4uekZKWU6jtpOD9VtGSw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sK50RuEuY6o=:W4Civog64LEYTCU7ztKXIm
 mNhnFDzQesMJ1YoqPZScxAz2RzsAcpC5AACK2AeKPzKvQqYpsb1S7tdb7CcoveLwEDqU6uRcZ
 8V+lkzrJVWdYMS1Uw+xDChlW85tHWbVGUftWS3SC33gPLm2H1DAczkWTPyShwQPFIejwNnBz3
 e/DnK6gb0WLi2InFw0nQBBbtK2Uhv9+Da69am8VQ0h+0Y3gQALjjYFf+IdO26fgoQ1rJJiTjs
 1Wx1HaeH/nC/6n1/jnLcng8BfVRqy1fsNG1h3TOys+4fQIUmj9p1L9wbnymvfg1K+IQetheOr
 wi0FM7cecNzuB/xA7j2ownKcY2yR9fh7wYxhREw/5UfS8RYjmGhllvUmFpQFCWpyi0dVVxsmC
 6tTB2gYjr+5+xrUbGoVlI2b9MYVDC7v25HG9mJsv3Qb4Ypb49fVl4/RGK/OWaLNVcRvQlpecR
 Pu101jLxu4joxNv7gfFGcBp9YaYdyCLkw3JAyr4t0Ef/uiGfann3n8/wMbNOKBkzQHffbx9iX
 D1wOREBYa2Y6WGZn6G98cxBaG+Dvepv1vbKu8t9tsuahuTF6NEvkomb2fQCnw0XVZSdi655bi
 uUwEik1WCqJJLzfgH8tPgDW/r6Kjz1npU27Nvy29YMdRuAqoDhy64IBdMgiAQmKBZlZcPpQRJ
 JKCQEu/bXBmTq3AmrOlLGGTxiXfPa9CjiN2pz177G6e0908/dcmDjP4GsPLZKNhS2zK1hq6Yb
 H/h0uS0zAwWfcQLQ4bDU34J7EQX+rCFZpg/fWcJ/erklTGB1pmTp/omIHjpaqR5tOe2n1QSVL
 tjCqOG5+0Xexnaax7n13wL2vL6p0T/tPUoM7q/SsMzzJjs8EJlZEsHqfRJ7XSNHwn1Q91WLcn
 c1wMgFEzGYrFZqqil5de0PocdwVMBhf7xyA3QC/GH5NLHG7bAwu1nFtbjAi+lsiw1AoCLAuyg
 rnxKNncRLoFhoVk/UV5EBaI0h4zO1r71CBqUtkIkf7xgJJ9qBgVVVbgBXPIz94oMyjdnkscc3
 tbI53j9XbhNYhmD8u8YpDz/pw71ozabCFHcitrdAB7u6PZUBt8dRfZgr/iIEy1UUMzGYzl7UT
 jocHlFyu3ikaGTHm7x9gW9yCvNisUXWVgK6nLDfcqrtMZw0anDj1XNOMRfNsRtmKo3Ir2dEVk
 jSzjO0u6/qGBv4yHDZN90LDkpi9SatruX9EOsSwmp8lxvaIYlH+3TvZVjih3d/4LB2ULHTudE
 e+0/KF5QLIkPT92UuHvQ4aMQBOGJ+rB1ggszo/A==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2020 at 11:39:46AM +0200, Alexandre Belloni wrote:
> On 05/09/2020 15:32:27+0200, Jonathan Neusch=C3=A4fer wrote:
[...]
> >  #define RTC_TIMESTAMP_END_2079		3471292799LL /* 2079-12-31 23:59:59 */
> >  #define RTC_TIMESTAMP_END_2099		4102444799LL /* 2099-12-31 23:59:59 */
> >  #define RTC_TIMESTAMP_END_2199		7258118399LL /* 2199-12-31 23:59:59 */
> > +#define RTC_TIMESTAMP_END_2255		9025257599LL /* 2255-12-31 23:59:59 */
>=20
> Honestly, I wouldn't bother adding that one unless you have examples of
> other RTCs endng at the same date, I'm fine having the value and comment
> directly in the probe function.

Indeed, it's the only RTC I know with this end date. I'll fold it into
the driver.


Thanks,
Jonathan Neusch=C3=A4fer

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl9afLQACgkQCDBEmo7z
X9vFEg//WZbPqecNb6hQ+RFL7wU4xLDRzNy4eCVqc6qH7tkAnJwUJ+j37Vf0J/0n
+sZ9KmrTvdYLstgd8ixk42+eZ81cq2mgShUmf3/NedAVnKR87K/DIytOQkFAWzF4
N4LGV0sBdYzvRpKXab6M5UfXJueNvejvbxVMyA0T3IUyVY7LcfkPpn833cdRfc6h
K4XPpdE+TOTO297ZeIarFSaigdj7GMU28pPrXnfooUo6Q3BpnsvHMceKS8n35O/P
98JJazxQ3jxxEP3qzHR5DG4Rt1FdGZy44PunvmwryhzM+cCUvyyFxtkVz1Haa2IU
eMmDWsOPeSWkZvDsBcsr+1RwINtU9FaQFyTMcCaS40G4+BdPpdPCCt3CT6nDApkV
XYCLChLlDcgaovuahRkWV4up9TtpqYSG8dOtUTWRLRKH0N605lsfFxs7e8vGaMgV
zDKPc0H+lgp3E0pK3r2D12Sw2iiU3jsVIV0uXEZOx8n4UZSnwuKC2yKlumKDNtU/
eQy+6NMNmXfpBo6maK53nOlwXp9+lwNPguALLW7XLnit9qD/B/ENXYAy1htqZyt7
jHR6386FzpBIrca4Z79oUailzCORGj6WAV+IcWjhks/k1YPLFw2Skrs2FBEhO1V1
B9uYKI+6LsuF7wj8odaxhNwCqPQJbhXCx86V9BuabnZJLtO3py4=
=ZcyE
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--
