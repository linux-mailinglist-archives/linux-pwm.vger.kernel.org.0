Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D160A277937
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Sep 2020 21:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgIXT0a (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Sep 2020 15:26:30 -0400
Received: from mout.gmx.net ([212.227.15.15]:48073 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbgIXT0a (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 24 Sep 2020 15:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600975520;
        bh=vG7ZTA0jFRagSSV8QIx/+2jeo4eFW8MwsHCZasCdkYU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Gh3tOrV3INN7yL+23MZ+yB+LUOBV87fa/q95aVGh34Hy4ui3DkZCtyyL+gNDlYcUb
         jG8QPJfXWbmXgtTClcHpgBnk1LtU4049RXJXQJd34AUHaq1sMl/GSih6DuCcJVFXap
         wpaXaiL7fL+MmytBOtPUM4gb40vKje5NIwZzw2lg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFbRs-1kEL4535oc-00H8PV; Thu, 24
 Sep 2020 21:25:19 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
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
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v3 1/7] dt-bindings: Add vendor prefix for Netronix, Inc.
Date:   Thu, 24 Sep 2020 21:24:49 +0200
Message-Id: <20200924192455.2484005-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pO47K7lhh+4oAX8Mbuu5NKAh+EJN9++GyAeiyO9lsB21FUmXQYx
 rFfydoOf6MUnID6L3WLSmqOamk2MdB/3iPI8iEfwtNwXWgjHWQa65+txeiz2Jk6QOQLH1hM
 fm0iUBLS4LoiI+nQ7Go+ivm8qfyV/lHBX9hj8/7P07+7HVhEJ4mTO2r/WeHDXjj9V933QZc
 hKduv/t8JopCHJaYU+D0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WeUKGv2LjWQ=:siC9z8RdqyYAJVMjIdVQdz
 3pye5jF/+FLgpd/2xc8/GzkUHEWB7khbf/0CEadI8lWgOPUExYIwdfeG6tWr2GEbHqZHa4oWS
 r3B8N2ynTkbsZtxJVcRBjZlEIhzWnshw06SuPo8RS21xl2ePj8NslCaq2zIKoVxbd6ZKEhLCa
 t0md3cMYk9kJSPPaegfXEP2HpSlKA6Pv4u0j8k1zwrFIxe0ccc1nccfVVQwVMCQQjeMlgmYc1
 PY6uArLpJfCtLGtwCmUdnf9ptdlWgTfKS0MVMNedISSWEEuQ2JzDxqwCrsTDY8MfWEmJYY9U+
 kjHJVjE9+TsSBVqrfAqmGGxIrY6wAjLjyHNUr560WF6HuTDf9s1OkQdf1qvL2p/5eIttAdAbX
 +PzIukCi0HVvl24N3485+B0Ohrl+2CywkX8FZbGXrg5P/cyHXCF7cRUIgsfC8COLh5nk7lqkr
 DoISzeEL79isrhp90SeiclSn2/Eh7WMhiYSdkxqgJ+rRpfRG+eTb9F8QHnzmX4NEcwFRJmOrR
 i43YF8ZfdRGO04+vwaGX3wlqYqQRm7XDq17jyU9To2Dx/QP8c92gY9O6LI6kzSYON6ZfNm69v
 ibKH+qWNe3TE/gh4w90psRgNdRPHbuwwPNsMVpQ9mgLiqKHtihBpr7chnTqYKjaX+DW9VM2Ed
 COiXHdmQEKLGhTstx4MvCWzFCzqhUtArg+vKCs+tmZkVPpN20DBmuNUlRbTxtLVnThROjiyh6
 TsosUkANk8OnN2wQXTM7KeY/7QSsL3x2RdkZUoSrj6Q4K9Xw2PJgNZ5/wEGg7ovWlavrwydFl
 f1309y4NM+WXdhHCSmIFnV1hyFXuEgHG8b3Yfxy8+rVHrJ2ETgsxiC3RxsDCo6vqPeeYwifen
 nKg2yw24cfBsF4mn4viOCTRrNXYNjWS6z9RI7GQe0or4jWcHpGfZXlPr6noIJIAnr6d5FPVEE
 QCZ0pcSE6BB+8I8Lz+LlbQ9ufBzXXjvS8Wj5qcbAvkZ5QNoFawC6rFFEvaE6p+gu0WGv5IWC8
 58PAZA1vgxFdsriISRhQLxJKw4At+AuC6OG/JTvTgMsndNS3D6fJ/D0BxetkfqAZWuGuTDo+t
 SAzukCrciJ7AVo61Iqv2Jh8S7dhdfdQpEzrNxMJikPXcqYoSZOlsQdHYFTmz2s2c5X6+Aw7yl
 RsMoazcMKptSomLRgAcwGkOyjNftTKGSWWJ4xAw2Wz41TGPmd5ex6t8fu2QE4sZVSadwpt9fw
 OsjBHNxPrSBe23fkYZIKvpoVX7tBtfDZNM2rIGg==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Netronix, Inc. (http://www.netronixinc.com/) makes ebook reader board
designs, which are for example used in Kobo and Tolino devices.

An alternative prefix for Netronix would be "ntx", which is already used
in code released by Netronix. It is shorter, but perhaps less clear.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Acked-by: Rob Herring <robh@kernel.org>
=2D--
v3:
- Add Acked-by tag

v2:
- No changes
=2D--
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docu=
mentation/devicetree/bindings/vendor-prefixes.yaml
index 63996ab035217..fa173802000a0 100644
=2D-- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -712,6 +712,8 @@ patternProperties:
     description: Broadcom Corporation (formerly NetLogic Microsystems)
   "^netron-dy,.*":
     description: Netron DY
+  "^netronix,.*":
+    description: Netronix, Inc.
   "^netxeon,.*":
     description: Shenzhen Netxeon Technology CO., LTD
   "^neweast,.*":
=2D-
2.28.0

