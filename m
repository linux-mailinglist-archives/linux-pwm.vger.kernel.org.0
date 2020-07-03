Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D2E213E45
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 19:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgGCRKW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 13:10:22 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:58748 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgGCRKV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 13:10:21 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200703171019epoutp011c7968bf6a018a70ef1b0148891f79c7~eTTeO73bX0630506305epoutp01R
        for <linux-pwm@vger.kernel.org>; Fri,  3 Jul 2020 17:10:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200703171019epoutp011c7968bf6a018a70ef1b0148891f79c7~eTTeO73bX0630506305epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593796219;
        bh=HcAGD6B1JnP2lDnlKdtr6p7vH/7+xhr07urK3N8AbhQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=itr9zMrpC0E5t5bisOhAlIc7t/aMmQaNOQjllqp0AKZD/0F8nmbWz2SH0I1Y0LxI2
         AVfmsPRTsZCSaxPTmW2k08rdxBzIjfA5bg6W1oZj8WiZThQ5WfGBUKkokGVEYsQaSo
         +qUiXKTMsi0KUejzHw2ULPdJEkiyb0CPRLAUKdQk=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200703171017epcas5p2e5662ec53557a62454d057d28b893d61~eTTcRzvND0205102051epcas5p2I;
        Fri,  3 Jul 2020 17:10:17 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.DB.09703.8766FFE5; Sat,  4 Jul 2020 02:10:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200703171015epcas5p38d1995e1ba086fde1f8eee79dccc47db~eTTazyHSK0671706717epcas5p3X;
        Fri,  3 Jul 2020 17:10:15 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200703171015epsmtrp1efffc6882f6ca01d3aab3a296b1f8249~eTTay68810607506075epsmtrp1k;
        Fri,  3 Jul 2020 17:10:15 +0000 (GMT)
X-AuditID: b6c32a4a-4cbff700000025e7-f7-5eff66780bd1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.87.08303.7766FFE5; Sat,  4 Jul 2020 02:10:15 +0900 (KST)
Received: from alimakhtar02 (unknown [107.108.234.165]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200703171011epsmtip2e6bc5aa70a6e5b90b86f4d723b439512~eTTXJO5uG3195631956epsmtip2L;
        Fri,  3 Jul 2020 17:10:11 +0000 (GMT)
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
In-Reply-To: <20200702155149.12854-2-krzk@kernel.org>
Subject: RE: [PATCH v2 2/8] arm64: dts: exynos: Describe PWM interrupts on
 Exynos7
Date:   Fri, 3 Jul 2020 22:40:09 +0530
Message-ID: <000001d6515c$d19f7de0$74de79a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFJ6dR4UxNy2lAmU1YfvCM6WVVcaQEv8itqAud1DcWp7UV0UA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsWy7bCmum5F2v84g/VHLC02zljPanH9y3NW
        i/lHzrFa9D9+zWxx/vwGdov7X48yWmx6fI3V4vKuOWwWd++uYrSYcX4fk8XaI3fZLRZt/cJu
        0br3CLtF+9OXzBY/d81jsbg9cTKjg4DHzll32T02repk87hzbQ+bx+Yl9R79fw08+rasYvT4
        vEkugD2KyyYlNSezLLVI3y6BK+PXl1ksBbPFK47NPsvYwLhVrIuRk0NCwERixq5Wti5GLg4h
        gd2MEm2/Z7CAJIQEPjFKrP3nDZH4zCjxcM1MJpiOnTv2sEMkdjFKHLj8iBXCecMosf/DZrB2
        NgFdiR2L28DmiggcZZbo+7oMzGEW+Mko0bThICtIFaeAqcTaDZvAOoQFQiSmr3/MCGKzCKhI
        PPlxkxnE5hWwlFjx5i4LhC0ocXLmEzCbWUBbYtnC18wQNylI/Hy6DGymiICTxJxDvcwQNeIS
        R3/2QNU84ZA4PUWni5EDyHaROL3DDyIsLPHq+BZ2CFtK4mV/GztESbZEzy5jiHCNxNJ5x1gg
        bHuJA1fmsICUMAtoSqzfpQ+xiE+i9/cTJohOXomONiGIalWJ5ndXoTqlJSZ2d7NC2B4SH9Y2
        ME5gVJyF5K1ZSN6aheT8WQjLFjCyrGKUTC0ozk1PLTYtMMpLLdcrTswtLs1L10vOz93ECE53
        Wl47GB8++KB3iJGJg/EQowQHs5IIb4Lqvzgh3pTEyqrUovz4otKc1OJDjNIcLErivEo/zsQJ
        CaQnlqRmp6YWpBbBZJk4OKUamMLqN/73i5j06UfFkU8fJN/xdiiLcaidOPN6+c5LpfvyGpZd
        Dog5enHxDe6VJpNj4i5Oebf5xOO9Zremczbuz576QKpZ8xAf34MUjaddChc4rS9nx2q4RB0y
        W9j5RmBj6iO7ZT0sj5jP/n0VtF+CtSVhz8kjx7mjbnQya2gyqhc+mmYlf7LzdVNbBsPTOuUj
        jwSXuHLHGrGtfdSVv2TOjJkWf4VmyATJ5/S9V8wudLbzO6f7KDDl4v/NZZcFF7BFz19juEZT
        b2+Q4ouQoozqez9CIm5s+Hih1laQnaNpO0OGjszhO+vWvj93V/rfv7UFLQoaTWqbOSsW8e0u
        OFnVG922iE3y5Kdz1Z+7tNV8O5VYijMSDbWYi4oTAac9isfmAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsWy7bCSvG552v84g4vN4hYbZ6xntbj+5Tmr
        xfwj51gt+h+/ZrY4f34Du8X9r0cZLTY9vsZqcXnXHDaLu3dXMVrMOL+PyWLtkbvsFou2fmG3
        aN17hN2i/elLZoufu+axWNyeOJnRQcBj56y77B6bVnWyedy5tofNY/OSeo/+vwYefVtWMXp8
        3iQXwB7FZZOSmpNZllqkb5fAlbH743zWgm8CFde/LGZvYGzj62Lk5JAQMJHYuWMPexcjF4eQ
        wA5Gid45yxkhEtIS1zdOYIewhSVW/nsOVfSKUeL2gQ3MIAk2AV2JHYvb2EASIgJnmSXaDqxm
        AXGYBX4zSjy9eIEVomU9o8TzlztZQFo4BUwl1m7YBGYLCwRJ3GifBzaKRUBF4smPm2A2r4Cl
        xIo3d1kgbEGJkzOfgNnMAtoST28+hbOXLXzNDHGfgsTPp8tYQWwRASeJOYd6mSFqxCWO/uxh
        nsAoPAvJqFlIRs1CMmoWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGC41dL
        awfjnlUf9A4xMnEwHmKU4GBWEuFNUP0XJ8SbklhZlVqUH19UmpNafIhRmoNFSZz366yFcUIC
        6YklqdmpqQWpRTBZJg5OqQamjk8fgt6UN//KSlseV5Eloa56fcN56eCgotx876nKMkaiSY7H
        PtWc7dONeRnFs7jtwpGkYwp/S7zbykoW+r/TCjY44NddeE6lw9B+51f2a71KC9snXWldeGSv
        5PRSv7C9hnvEeveU+wt+/Gxeofdhk2lY9NXL7M8YH95Vn3Zv+otVysvuRV8Jes0eKBfweq5b
        ocf+OTY1zr1cCYfLfGPk7B6+bP188WQI27LpafPZOVTZjzwOnZC5avLmdotVKW2xHz5t2mRc
        YPb68qoPSpO4e7e9FSxa6d6wdu12s2TWpElr72ztmSq3+OKfVad8asT/77+yOtzvHqtfyNwt
        1jGik6p3i3lKuE/e8OCs8JoTSizFGYmGWsxFxYkA1W6Mhk4DAAA=
X-CMS-MailID: 20200703171015epcas5p38d1995e1ba086fde1f8eee79dccc47db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200702155204epcas5p34d7635968376b68fc243e8887cf16388
References: <20200702155149.12854-1-krzk@kernel.org>
        <CGME20200702155204epcas5p34d7635968376b68fc243e8887cf16388@epcas5p3.samsung.com>
        <20200702155149.12854-2-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Krzysztof,

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
ey=40samsung.com>=0D=0A>=20Subject:=20=5BPATCH=20v2=202/8=5D=20arm64:=20dts=
:=20exynos:=20Describe=20PWM=20interrupts=20on=0D=0A>=20Exynos7=0D=0A>=20=
=0D=0A>=20Add=20interrupts=20property=20to=20PWM=20node=20on=20Exynos7=20to=
=20describe=20the=20hardware=0D=0A>=20fully.=20=20No=20functional=20change=
=20as=20the=20interrupts=20are=20not=20used=20by=20drivers.=0D=0A>=20=0D=0A=
>=20Signed-off-by:=20Krzysztof=20Kozlowski=20<krzk=40kernel.org>=0D=0A>=20=
=0D=0AReviewed-by:=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=0A>=20-=
--=0D=0A>=20=0D=0A>=20Changes=20since=20v1:=0D=0A>=201.=20Correct=20the=20i=
nterrupts,=20change=20message.=0D=0A>=20=0D=0A>=20Not=20tested=0D=0A>=20---=
=0D=0A>=20=20arch/arm64/boot/dts/exynos/exynos7.dtsi=20=7C=205=20+++++=0D=
=0A>=20=201=20file=20changed,=205=20insertions(+)=0D=0A>=20=0D=0A>=20diff=
=20--git=20a/arch/arm64/boot/dts/exynos/exynos7.dtsi=0D=0A>=20b/arch/arm64/=
boot/dts/exynos/exynos7.dtsi=0D=0A>=20index=20f590891efe25..709742b98c9c=20=
100644=0D=0A>=20---=20a/arch/arm64/boot/dts/exynos/exynos7.dtsi=0D=0A>=20++=
+=20b/arch/arm64/boot/dts/exynos/exynos7.dtsi=0D=0A>=20=40=40=20-581,6=20+5=
81,11=20=40=40=0D=0A>=20=20=09=09pwm:=20pwm=40136c0000=20=7B=0D=0A>=20=20=
=09=09=09compatible=20=3D=20=22samsung,exynos4210-pwm=22;=0D=0A>=20=20=09=
=09=09reg=20=3D=20<0x136c0000=200x100>;=0D=0A>=20+=09=09=09interrupts=20=3D=
=20<GIC_SPI=20449=20IRQ_TYPE_LEVEL_HIGH>,=0D=0A>=20+=09=09=09=09=20=20=20=
=20=20<GIC_SPI=20450=20IRQ_TYPE_LEVEL_HIGH>,=0D=0A>=20+=09=09=09=09=20=20=
=20=20=20<GIC_SPI=20451=20IRQ_TYPE_LEVEL_HIGH>,=0D=0A>=20+=09=09=09=09=20=
=20=20=20=20<GIC_SPI=20452=20IRQ_TYPE_LEVEL_HIGH>,=0D=0A>=20+=09=09=09=09=
=20=20=20=20=20<GIC_SPI=20453=20IRQ_TYPE_LEVEL_HIGH>;=0D=0A>=20=20=09=09=09=
samsung,pwm-outputs=20=3D=20<0>,=20<1>,=20<2>,=20<3>;=0D=0A>=20=20=09=09=09=
=23pwm-cells=20=3D=20<3>;=0D=0A>=20=20=09=09=09clocks=20=3D=20<&clock_peric=
0=20PCLK_PWM>;=0D=0A>=20--=0D=0A>=202.17.1=0D=0A=0D=0A=0D=0A
