Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F286213E6E
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 19:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGCRSK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 13:18:10 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:54193 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgGCRSJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 13:18:09 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200703171806epoutp04836f9391ad24095ab1c454ffc66057f6~eTaRdbE632886328863epoutp04j
        for <linux-pwm@vger.kernel.org>; Fri,  3 Jul 2020 17:18:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200703171806epoutp04836f9391ad24095ab1c454ffc66057f6~eTaRdbE632886328863epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593796686;
        bh=J7FW8uqGQ+2qBx2BdC0fWOsDhWY5aJoCeobM23mdcDk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=q2vA71KeeJPNMIc8t50SmZJCAYPjKagax7CsxzcxeSY/LeHcQP4b9VFYHgqJnDed7
         18iEUfZC6WXxOF2rfmC7bnBk3a+0wk1WnaJR4tctG3HPShsxvbL+8eFDy2O/Xla6Zj
         OHPwKr+FfzWhCNHNuZGhjGDv9s3PW/mAjjbrYXrQ=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200703171805epcas5p2adb88dc394dd9c62a10b462b44ac2d35~eTaQsXYp30797807978epcas5p2W;
        Fri,  3 Jul 2020 17:18:05 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.3C.09703.D486FFE5; Sat,  4 Jul 2020 02:18:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200703171804epcas5p1ac30858d631f2c79dd64d0a9ea8cf384~eTaPg9pCe1618216182epcas5p1z;
        Fri,  3 Jul 2020 17:18:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200703171804epsmtrp2084fa6e33101021dbd43a7277af77537~eTaPgFbEc1141011410epsmtrp2k;
        Fri,  3 Jul 2020 17:18:04 +0000 (GMT)
X-AuditID: b6c32a4a-4cbff700000025e7-cb-5eff684dbc8a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.F4.08382.C486FFE5; Sat,  4 Jul 2020 02:18:04 +0900 (KST)
Received: from alimakhtar02 (unknown [107.108.234.165]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200703171800epsmtip1ea2a6b56847555fc36a9615eb7617675~eTaL4rH9E0836808368epsmtip1G;
        Fri,  3 Jul 2020 17:18:00 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Thierry Reding'" <thierry.reding@gmail.com>,
        =?utf-8?Q?'Uwe_Kleine-K=C3=B6nig'?= 
        <u.kleine-koenig@pengutronix.de>,
        "'Lee Jones'" <lee.jones@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Kukjin Kim'" <kgene@kernel.org>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
Cc:     "'Marek Szyprowski'" <m.szyprowski@samsung.com>,
        "'Bartlomiej Zolnierkiewicz'" <b.zolnierkie@samsung.com>,
        "'Sylwester Nawrocki'" <snawrocki@kernel.org>,
        "'Chanwoo Choi'" <cw00.choi@samsung.com>,
        "'Pankaj Dubey'" <pankaj.dubey@samsung.com>
In-Reply-To: <20200702155149.12854-3-krzk@kernel.org>
Subject: RE: [PATCH v2 3/8] arm64: dts: exynos: Remove generic
 arm,armv8-pmuv3 compatible
Date:   Fri, 3 Jul 2020 22:47:58 +0530
Message-ID: <000101d6515d$e91f2870$bb5d7950$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFJ6dR4UxNy2lAmU1YfvCM6WVVcaQJtI6A3AnaElvKp58le8A==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsWy7bCmuq5vxv84gzdXFC02zljPanH9y3NW
        i/lHzrFa9D9+zWxx/vwGdov7X48yWmx6fI3V4vKuOWwWd++uYrSYcX4fk8XaI3fZLRZt/cJu
        0br3CLtF+9OXzBY/d81jsbg9cTKjg4DHzll32T02repk87hzbQ+bx+Yl9R79fw08+rasYvT4
        vEkugD2KyyYlNSezLLVI3y6BK+Nx6yT2ggUCFTPmtLI3MF7g72Lk5JAQMJF4fvEncxcjF4eQ
        wG5GiX89zYwgCSGBT4wSz56JQCS+MUp872hkgunonH4DqmMvo8S3pe3sEB1vGCW+zI0HsdkE
        dCV2LG5jAykSETjKLNH3dRmYwyzwk1GiacNBVpAqTgFTid07LzGD2MIC0RInl9wDKuLgYBFQ
        kTg02RwkzCtgKfHr3llWCFtQ4uTMJywgNrOAtsSyha+ZIS5SkPj5dBlYjYiAk0Tzjg4miBpx
        iaM/e8AulRB4wyHxddskNogGF4kJyzdB2cISr45vYYewpSQ+v9sLdoOEQLZEzy5jiHCNxNJ5
        x1ggbHuJA1fmsICUMAtoSqzfpQ+xik+i9/cTJohOXomONiGIalWJ5ndXoTqlJSZ2d7NC2B4S
        E24cZprAqDgLyWOzkDw2C8kDsxCWLWBkWcUomVpQnJueWmxaYJSXWq5XnJhbXJqXrpecn7uJ
        EZzutLx2MD588EHvECMTB+MhRgkOZiUR3gTVf3FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZV+
        nIkTEkhPLEnNTk0tSC2CyTJxcEo1MO1TS+KawcXklDEjrHepdnuKEb95xadSWxfvxfWH0m5l
        vGzf7FBsvmp5mMpZ3u7D9y4vl9CLqjzp5fPm0xtD94nRewybw7ROGj45/aq9NdxYYGnl+eJ7
        t6bXp86b+ylz1sKvjrtfN1o1B+9btPb7fnFZsbIjNiw+0X8DWz4k2mzclW7EVtkoa7/X8L2N
        0YUs2R3OjibnzA0PWWTlN5yUfia2rrL48frQ3DOTVzMUlUVtZr5vkaMl1i+70u3KSzHzm3MM
        KmwlriR+FDrK8Y+hIjE2jGOOw/fDoXMF1qxfGPTyefmWyFv+ZWXxJ0z7RHZddLW5VPdFIlB2
        X7TPyprnPDMMjRPuLjll26d55+VGJZbijERDLeai4kQAG0Sqr+YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7bCSnK5Pxv84g94tQhYbZ6xntbj+5Tmr
        xfwj51gt+h+/ZrY4f34Du8X9r0cZLTY9vsZqcXnXHDaLu3dXMVrMOL+PyWLtkbvsFou2fmG3
        aN17hN2i/elLZoufu+axWNyeOJnRQcBj56y77B6bVnWyedy5tofNY/OSeo/+vwYefVtWMXp8
        3iQXwB7FZZOSmpNZllqkb5fAlbF823Gmgm08FVMmvGJsYDzK1cXIySEhYCLROf0GcxcjF4eQ
        wG5Gibat5xkhEtIS1zdOYIewhSVW/nvODlH0ilHi6IsOVpAEm4CuxI7FbWwgCRGBs8wSbQdW
        s4A4zAK/GSWeXrwAViUksJ5RYvsWsFGcAqYSu3deYgaxhQUiJU4/egnUwMHBIqAicWiyOUiY
        V8BS4te9s6wQtqDEyZlPWEBsZgFtiac3n8LZyxa+Zoa4TkHi59NlYPUiAk4SzTs6mCBqxCWO
        /uxhnsAoPAvJqFlIRs1CMmoWkpYFjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGC
        Y1dLcwfj9lUf9A4xMnEwHmKU4GBWEuFNUP0XJ8SbklhZlVqUH19UmpNafIhRmoNFSZz3RuHC
        OCGB9MSS1OzU1ILUIpgsEwenVAOT8Tz12XKrOY/XnQgTfVq1vJTV1v3S/qUZCjdfX7p/0yTG
        f+VUpaNXZp2t/zG3dvPHxS3B4St0rqg8PXd0+9MJP062SgrfddayvR7Jtf9/atb8c5fmnObn
        FFaJf3y/IM32+meNmbybu1MlF1cpMzpn7Zqof1jx95Nl5TErVvHzrfho9FXsk+Ry8T1fzq9b
        trTn4I5TsrKFb1k4dz1fuOQu+xebKJfwy11Wyt+Xci/lPzZNfsa9q9/mhy7tPle7wsLiyaL5
        eYWrJ0XG9/31Ws74L1JxXsHXmdmP2mfGN9Z/dMkJmS5Wmt50xKPHwpifPyDqy0Lv1U92Tq/g
        +sXTpJx2ijvQ1dXoTvyPF8+a/+3+uU6JpTgj0VCLuag4EQC6XUTTTAMAAA==
X-CMS-MailID: 20200703171804epcas5p1ac30858d631f2c79dd64d0a9ea8cf384
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200702155208epcas5p3b392837ed0d7183aa8d8724b1ccac9aa
References: <20200702155149.12854-1-krzk@kernel.org>
        <CGME20200702155208epcas5p3b392837ed0d7183aa8d8724b1ccac9aa@epcas5p3.samsung.com>
        <20200702155149.12854-3-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

HI Krzysztof

> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: 02 July 2020 21:22
> To: Thierry Reding <thierry.reding=40gmail.com>; Uwe Kleine-K=C3=B6nig=20=
<u.kleine-=0D=0A>=20koenig=40pengutronix.de>;=20Lee=20Jones=20<lee.jones=40=
linaro.org>;=20Rob=20Herring=0D=0A>=20<robh+dt=40kernel.org>;=20Kukjin=20Ki=
m=20<kgene=40kernel.org>;=20Krzysztof=20Kozlowski=0D=0A>=20<krzk=40kernel.o=
rg>;=20linux-pwm=40vger.kernel.org;=20devicetree=40vger.kernel.org;=0D=0A>=
=20linux-kernel=40vger.kernel.org;=20linux-arm-kernel=40lists.infradead.org=
;=20linux-=0D=0A>=20samsung-soc=40vger.kernel.org=0D=0A>=20Cc:=20Marek=20Sz=
yprowski=20<m.szyprowski=40samsung.com>;=20Bartlomiej=20Zolnierkiewicz=0D=
=0A>=20<b.zolnierkie=40samsung.com>;=20Sylwester=20Nawrocki=20<snawrocki=40=
kernel.org>;=0D=0A>=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>;=20Chanwo=
o=20Choi=0D=0A>=20<cw00.choi=40samsung.com>;=20Pankaj=20Dubey=20<pankaj.dub=
ey=40samsung.com>=0D=0A>=20Subject:=20=5BPATCH=20v2=203/8=5D=20arm64:=20dts=
:=20exynos:=20Remove=20generic=20arm,armv8-pmuv3=0D=0A>=20compatible=0D=0A>=
=20=0D=0A>=20The=20ARM=20PMU=20node=20is=20described=20enough=20with=20firs=
t=20compatible=20so=20remove=20the=0D=0A>=20arm,armv8-pmuv3=20to=20fix=20dt=
schema=20warnings=20like:=0D=0A>=20=0D=0A>=20=20=20=20=20arm-pmu:=20compati=
ble:=20Additional=20items=20are=20not=20allowed=20('arm,armv8-pmuv3'=0D=0A>=
=20was=20unexpected)=0D=0A>=20=20=20=20=20arm-pmu:=20compatible:=20=5B'arm,=
cortex-a57-pmu',=20'arm,armv8-pmuv3'=5D=20is=20too=20long=0D=0A>=20=0D=0A>=
=20Signed-off-by:=20Krzysztof=20Kozlowski=20<krzk=40kernel.org>=0D=0A>=20=
=0D=0AReviewed-by:=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=0A>=20-=
--=0D=0A>=20=0D=0A>=20Changes=20since=20v1:=0D=0A>=201.=20None=0D=0A>=20=0D=
=0A>=20Not=20tested=20although=20no=20effect=20expected.=0D=0A>=20---=0D=0A=
Booted=20on=20exynos7=20board=20and=20see=20arm=20PMU=20still=20gets=20regi=
stered=0D=0ATested-by:=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=0A=
=0D=0A=0D=0A
