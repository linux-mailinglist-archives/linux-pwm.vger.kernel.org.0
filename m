Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40642C7A6E
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Nov 2020 19:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgK2SCQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Nov 2020 13:02:16 -0500
Received: from mout.gmx.net ([212.227.15.19]:43797 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgK2SCP (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 29 Nov 2020 13:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606672794;
        bh=3LO01b6ePsr95w6s0OE3cim87PA17rLRuYBzyHbuaZ0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NZI5O5/27y6cFPQpr+0yNYeHDiAFjX8Y70HTlKQyxTj3UeD/YKmQF1Lw1wg/kV5uD
         uuviy1eNr52emHx/m4txk5yY5DjbRvcvjtarXDDpQV7NQUeYSDaqE1TpAhX6+NlFr6
         Tq7z+RYFfzPV6OPZpCbaDUeNpgefYZhNSkNml6AQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVvPD-1kbMP11bmv-00RrAj; Sun, 29
 Nov 2020 18:59:54 +0100
Date:   Sun, 29 Nov 2020 18:59:44 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Fabio Estevam <festevam@gmail.com>, linux-rtc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        allen <allen.chen@ite.com.tw>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v4 4/7] pwm: ntxec: Add driver for PWM function in
 Netronix EC
Message-ID: <20201129175944.GG456020@latitude>
References: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
 <20201122222739.1455132-5-j.neuschaefer@gmx.net>
 <20201124082019.vpkr3xnp55arjpnp@pengutronix.de>
 <20201126231931.GE456020@latitude>
 <20201127071105.k2rb4iykeqevbao5@pengutronix.de>
 <X8DeQ7IWjSV5Jtic@ulmo>
 <20201127142325.aqipoqtnysdkdbi2@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rMWmSaSbD7nr+du9"
Content-Disposition: inline
In-Reply-To: <20201127142325.aqipoqtnysdkdbi2@pengutronix.de>
X-Provags-ID: V03:K1:L7KEHoeMCN48HEM5/4cIUkRn0xk+rPB6AeA6mXjJoixH0SwGpQN
 Z0YZ0oE4VjwDujGhDhONErl8RaUDj8hEXvg3VxFmm89zr3V4Pu+L3r8qXng+Bi/fd+kGtDs
 NTwgPVLXGXuoCkJBr+9BH2R/axpZViYsYzlWnlmMmXQb4YEKEaugQNdGVRImogmaiCjstwT
 toViNl9x4MQ9t3rCD643w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XEGl+5EZNJc=:zF7W9UGNdHdh+D5u2+d7nH
 Ni/QYGZYTvpTQpYZ19rSJ/sCG5iVTUDnvSbBYdpxv+gFTfBzTFRSVDnKrwF5LU0+EGButPC1l
 kf+thVy22fyKsB0Hzxy0Zk2aIyCd/tAq2hJyra4ciq7eUEsUwH61GTbY101oCNQKBhyusVsAT
 YShmidFAjigl9TCEs7sUBfwJ/udgVouJ7IZ8RD2Ox+qbo4LLqO7ShVMIusPbnlc3uH24pKkuS
 jyvlegFNK/gIUP92oQtyRDgpmmDxVN5LMGM607u1SYJbZ6Gt+AS+UVxX6vtNQMgFBUhRrwY7x
 5Z6fW87Qm+WX/porI7A5iWV1Ditt9QgK4Mq86KC5oYrli+Jm/Z26A+/kEzkcW0MusWV2B5OHP
 RotPcYl4/0hAgfJ8c3s462WXFIemDr2ojVTW0uFLv/b7bMxdIh5XW/tPnX0usWbEataKmvaty
 ShG/kInzOmO4o1h/Wt2G9N+vgDGMnAhSKs2gv7SNdHfrzCbA9Nl+PuxvGe4TZofWPSGf+XF1v
 XCs+Ivae19I9PnRcIA5wMGFgWClhCMxJxyUrUr5X8Ml/abhlg2kgyTmlsWgA0JUsfXs0dLDVC
 w1iQqqUZuWyz9yrnERF+GBz/D/FAM3JMnOC3Yf8OjdTgHxjgqwQn1+0K/1kRDXE0QHgooPtZ0
 FenziL+JJ8/PErB+M0wV2QyymkvJMHjKmfJ6gsvXcv9OHtVUPIRaYNRSyIyDAbhb68pLs9uIe
 IhtPQPEX2Z5zQCm7/tqos2Hifj416C2xTY2V0MF+13qVW7X6Jmjyrlzns+SQKVzoaeh0pyTG5
 //HvESjjPkVP2h6kqtVL/BphnnPpr7t838rD32OjKQZtmiLMYQNPeG7qV84vsytGfNh63Gg89
 SSDFBwrpvDlJtuUl3wSQ==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--rMWmSaSbD7nr+du9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2020 at 03:23:25PM +0100, Uwe Kleine-K=C3=B6nig wrote:
[...]
> I suggest for now we go for "don't provide a .get_state() callback"
> because in the only case where it is currently called there is no cached
> data to rely on anyhow.

Alright!


Thanks,
Jonathan

--rMWmSaSbD7nr+du9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl/D4YgACgkQCDBEmo7z
X9vAuw//QVVHEH16FDLp9i8ZRV+phbtQw/JDRZf7v6feqUxHHl46iB7e3qAF0nQu
rBhl/hfyN+FyGAK/oB7lJczZVXEhDCt7ppVrID6zldGXdc3HRyXswrWG8oWcwi2B
zZ9hc8rq8QNplOPMqfwtLnUJdnc6YfarCHr82Usv5NM6T/zCeBHkKPw8Hd2qvG9Y
lluBCzf9ahPLgpG23WfPXU18ANTSNwpXScrrO5x4qGeGLff9cjE/aNiNFGjXYhqp
kHdgqZyt9INLbpPEGNjz+4bky53faMdEOTlfJKfo1T8ctOYCM8IogHzdl+WRcpfk
1Yfds5Ph91en5pTT1qHg8sfrF4Khf30aRBcIfFdGXNpznGkpvPBcRKFK09nMAlL6
D9+SYklu4qNtspuCJXSXwdbKXfbioHMa7BqFlxv7AEWsVb00TjqTsIPFKsv4ZdJT
4H1xxrslzyCT0CzwkIBBLqNbXUuzvpeRGqH/nc9+PKav02j1eqWqudiqvY6wWWPU
FgdEGDg4ym7Plzm0BKt0VEDg0NvCVPTN8HwvkuaB/HHjRzhnH53dq4ELCaMjP8mC
6mcjmYzxrHlTmGrECqna1QD6dNxETMkL8epaB3fYe8Htsu4DGyjhYGMSzD12KDB5
L+uIkb+q0PyQVqLqFNK7mTg/vnM2+THGjVbymWVNHMR3y6MuIrg=
=CVtS
-----END PGP SIGNATURE-----

--rMWmSaSbD7nr+du9--
