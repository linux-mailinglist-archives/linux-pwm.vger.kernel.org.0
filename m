Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5480202739
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jun 2020 00:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgFTWqp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 20 Jun 2020 18:46:45 -0400
Received: from mout.gmx.net ([212.227.17.22]:60263 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728433AbgFTWqo (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 20 Jun 2020 18:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592693163;
        bh=h/UMIY6fmTdd2wru1QoL9o5eOI3wFFzm7QlYKwwkUdM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ZEwEkwBO1iCQDD7fQ6Rl7eNxSJ13psdqlSHmPznnxTCP/FrMHut31htqj8rYe8afX
         HNB1qHhFqpjIw2Jxz5eU86XToSWStAo8VBMxQdvC0z6KWtUXvBL/VapPb9jaIfe0Ul
         EcqNt8VKO+vz8MmWnXMi4T9kWacINg/OaRCgesO0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.186]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mt79F-1itzhS1A6r-00tT79; Sun, 21
 Jun 2020 00:46:03 +0200
Date:   Sun, 21 Jun 2020 00:46:01 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
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
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [RFC PATCH 02/10] dt-bindings: Add vendor prefix for Netronix,
 Inc.
Message-ID: <20200620224601.GB2581@latitude>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
X-Provags-ID: V03:K1:5O+YzEQ/vUdLi8utCOogyjE0FxfqX6VgcRxQrjBKDGTtmFSKYjw
 Uwoa04dGgRh/DH6SxYr8fKCqy8jdmILH2jrPFgAp48BzZtNIivny/AR81+kT0m310ruexCA
 lgedeh5W1LsTtR69899tKj4uRBIsiGP39JChZbHO8SNzhRFPFEcBrZkd1n8G1mlBRFmn4ej
 6Kmd3/qW51Rg2wM7Nmhbg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:g9z075SxS1I=:DHqkOKmSdMJd0/cw2/EzAl
 ZHdbov55RWR5jgK2G3UtymifbK8pkIFsjdB+4K97PiN9at2UFVbd5EPUv4YMBunSahziy1NoZ
 uYbZX8maLwxubFdsYS+xFch1G0IOpbS13LZhdS/DW1j/WNxwCQ/Z2nF7YtGMDHrLUr9AB4HuW
 kJIE9S20cxeHJMevCnMpYzwV80VJ6HiYaQQ0P9ZANs8qrZPnWMa3x7egMRDXKoCabUPF5icO8
 gCoKcIOXVn/tDLlbovFdtb+XYqWzcUqH7DRqv6CM0EmQXhoG752hL+aP/HrMHJcfefvnqc7Su
 JR1DVjJKUdpJGkp/l4Jmv/8S2uRNxrcJCvzi69oYo7jVDvoqtu/PvkI+Bbtaj6btHIxJBryK5
 d3fzwv4aIyN4bh3HJ9pvQiIxQ7bv4N9eLd50PPs/GFrLd2K5cf+tiLCem5pc630lhgClDykuZ
 zx4VuE2R4/Kw2FqvEqAOq2EnGA9lGOE6uxVjtjpYRi79iRz0fTd8z4MJu8L8CdMkEgADRpoHF
 iL4/FxANZC3qWF+motaVQBTVHdcy6FqxtvTS7MM8773gT65CYn0KJhznTIPRLM+am3E/i85SZ
 yAbT6Fivg/GFesNe5Ctf5zaCBfUmNHjSenGgPgjT+VoTWMchSwgRYJgUlN6RmZ5UQBfzlqQbQ
 Hps4C9dIo5IlD5bLvlfJmpmY+9tXPRIj21Su9kpHH2NP8U6aVYsP0qEScOT2fjJrnnY8oZfqf
 MqgWKcKVOGLZ3Xv9+zlKZ180OXWpz9gvOp/glcdNcojEY521F1n+hm5IN8ONB00OssQHX2158
 74/hsejdGz1sCBfX0FNK/gODeH4JlNAXH11hf26T0FltDrxf/pWTN2mK/kczV3Zf2R9k0Q34Q
 nlKCFBWdjzGxS861dHLmO1f9oM8qyapYxSsScddUIICU6aPmnX0DPbPNaCt9+P+ixzMNwGKKh
 Avo70qo3qqo4uAaZYxjVkVLT5S5stEEUw3svLQW+5AXRdcIhFTO9Uc6fjGTHJV5QtqQd5weyf
 upf1WrflYqYeUuXZdXWq4OGjZBhbF5fmLPcwTZ5TFG09Pn9DFWKOJX8r/TBrzpaNcbOKsscNo
 HzJxkR7UAgmy4XftuJbYpIRCDldjqPh66x1xdlp7YNHd+YLJLjhOWb7QuiWKiZd1jlYzOs9GC
 U7EngI85XOPmdpGwQXaTkXw9IiHVYyqsibfUcUBOqNafUvgBrzdzzOFvisy9EtalNkxC1Jztg
 WQRIRlLxVbsFTHkMv
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 21, 2020 at 12:42:13AM +0200, Jonathan Neusch=C3=A4fer wrote:
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++

Oops, it seems the mail thread got split here when I resent patches 2-10
after an error. Oh well.

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl7ukaIACgkQCDBEmo7z
X9t5/Q/8Cbd0bFYhNk8CBuYZCY3Hb1671urdC0CCUDZHm8+6f4Hak3r6C2TRVz/l
6mFc4ga7Eaib0kUGNXIr1PKcmAeRrBtDhmk1ouF+jKGoAGSi+vfzbvR3e8TLcwhi
lK+vE4/GlQ8ucVuPDlazvpIraMLPlv61ucgjL7jaExvZK3q6g3uXSb32YGj2LHRF
eaWS+o1coNYWk2D24vqwzlF8Ot5tKRlE8Nlk0tP6s2s5AzDyCGmaTanbpWbMrlkr
f/BG5LbHqRkGnY2cuU1VK+EUxFrg3EtLyHjc9ASPBWDyX5zbPtp7qttUOQ65JUXT
aE52FjQ83S59G+ibTloZWEpqiHf4WuGkb+erE/tWiFwJCRyymf6V+bfSL4bLLlcw
0paBO5cdbdZjAprIzVM9jgTyz76Pd/6fSAvQpA1cnz/sGE/XhgXoOz4CjAGNHC0B
lVCFxsg2lyq8dQx2rBnXiAIzCf7X/72TIf7932wsQd4HUEEILb9kBe0kGNDaHuSF
v0krqal+swKx/ASrPMu3TTlBw3IGLf7JdrxcnUDNQ8N+TxfEE5dc4WGNELSgPpDF
DLtzb0WCL8A6svnupjPbMtT10+e7EZf7ESzLFDlnAm932Cop0SsRc0OvWN790vIg
x7ZzXfwX2B70qJv4yWjJuF1XKmDYluSh0T55EYU7r4oYHZ20DQo=
=mZCk
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
