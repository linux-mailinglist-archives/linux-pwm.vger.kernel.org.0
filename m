Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A97D213E81
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 19:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgGCRXP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 13:23:15 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:53005 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgGCRXP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 13:23:15 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200703172312epoutp026895923344b4679c4b387fb22519d04b~eTeuMSufe1380213802epoutp02B
        for <linux-pwm@vger.kernel.org>; Fri,  3 Jul 2020 17:23:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200703172312epoutp026895923344b4679c4b387fb22519d04b~eTeuMSufe1380213802epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593796992;
        bh=LkuASxAqOE9BhtzKihP6DhC695ikQ3/eH5W9oN5wDOs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=A9QpN4GfSbNBx/5ZTfIp2WCHGhXdCGbBpMNdZNfZz9LSUjdp5tUhMf7yIDADewWzy
         bMbwVjUxX82MWwY2xlqPxcIfljyT7jAgkQXuCjMgpbDtxQrdPuxX3phaPB8ESs4vap
         Wq7ebgNw3TQAsXiWuveQkDX2rXqXAmztbYhHkteA=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200703172311epcas5p339bbf3baa835e725d735d9a8300b9ed7~eTetL8yRQ0592005920epcas5p3q;
        Fri,  3 Jul 2020 17:23:11 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.8C.09703.E796FFE5; Sat,  4 Jul 2020 02:23:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20200703172310epcas5p424c50ac69796c64c4c8044ca261fcec7~eTesbbADy3260332603epcas5p4P;
        Fri,  3 Jul 2020 17:23:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200703172310epsmtrp18f938ad2a68e3b3694bd72f11b56cb9c~eTesajeZF1311513115epsmtrp1m;
        Fri,  3 Jul 2020 17:23:10 +0000 (GMT)
X-AuditID: b6c32a4a-4b5ff700000025e7-88-5eff697ecae0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.05.08382.E796FFE5; Sat,  4 Jul 2020 02:23:10 +0900 (KST)
Received: from alimakhtar02 (unknown [107.108.234.165]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200703172306epsmtip1d218fa48f7535e6c02910d287fa569d4~eTeo4hGGZ0932009320epsmtip1i;
        Fri,  3 Jul 2020 17:23:06 +0000 (GMT)
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
In-Reply-To: <20200702155149.12854-4-krzk@kernel.org>
Subject: RE: [PATCH v2 4/8] arm64: dts: exynos: Remove DMA controller bus
 node name to fix dtschema warnings
Date:   Fri, 3 Jul 2020 22:53:04 +0530
Message-ID: <000201d6515e$9f7a33d0$de6e9b70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFJ6dR4UxNy2lAmU1YfvCM6WVVcaQKPDKCgAkWvKSCp6ENa8A==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7bCmpm5d5v84g01/rC02zljPanH9y3NW
        i/lHzrFa9D9+zWxx/vwGdov7X48yWmx6fI3V4vKuOWwWd++uYrSYcX4fk8XaI3fZLRZt/cJu
        0br3CLtF+9OXzBY/d81jsbg9cTKjg4DHzll32T02repk87hzbQ+bx+Yl9R79fw08+rasYvT4
        vEkugD2KyyYlNSezLLVI3y6BK+Nv7w+mgj0CFQ9/PWFrYHzD38XIySEhYCKx4O87ti5GLg4h
        gd2MEk/eH2QFSQgJfGKUmPVLHcL+xihxZZIBTMO/R/dZIRr2Mkr8OfCKGcJ5wyix8mcXWDeb
        gK7EjsVtYGNFBI4yS/R9XQbmMAv8ZJRo2gCyg4ODU8BUYmefGEiDsECexLZ558GaWQRUJHZ1
        3mcEsXkFLCWuvLjMAmELSpyc+QTMZhbQlli28DUzxEkKEj+fLgPrFRFwkvi7Zy4TRI24xNGf
        PVA1LzgkJk2UhLBdJB5vnsEGYQtLvDq+hR3ClpJ42d/GDnKahEC2RM8uY4hwjcTSecdYIGx7
        iQNX5rCAlDALaEqs36UPsYlPovf3EyaITl6JjjYhiGpVieZ3V6E6pSUmdnezQtgeEj232hgn
        MCrOQvLXLCR/zUJy/yyEZQsYWVYxSqYWFOempxabFhjlpZbrFSfmFpfmpesl5+duYgQnOy2v
        HYwPH3zQO8TIxMF4iFGCg1lJhDdB9V+cEG9KYmVValF+fFFpTmrxIUZpDhYlcV6lH2fihATS
        E0tSs1NTC1KLYLJMHJxSDUw8LDsn7gzonfikfMKWZ2knLqkFC3TLXt27Ly85v1zTef7SSuuk
        5bu8J5vNz3K45VabvnJVnj5fZgV3N/NZkRfMN5kzSkzKxBYEBLp+uSdwO8Jzs8aStyyHHxZr
        /tzh+rb5tZrX++N/FpTUCH1RN7o1O/LT28tzZtvtbS7LKV3w2dlni3sy//tH8fc2vhQ3WMMf
        FFOyM13kb9yOWlWHPylf/2ddt/3aNuXovMg1ThU1vBvMK2Kev/yRfmUqR10mp+fRD4KJZ44d
        3nc1//7zl3OTjx5e/sy5Y11NYtr2378KDnm5F14r6f+ZqnTs+guDhpjIb1l2yt+ueJ3iVN05
        Mer06Yw3f7M9DCLrJPLL759VYinOSDTUYi4qTgQA10lMDeUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7bCSnG5d5v84gy3L+Cw2zljPanH9y3NW
        i/lHzrFa9D9+zWxx/vwGdov7X48yWmx6fI3V4vKuOWwWd++uYrSYcX4fk8XaI3fZLRZt/cJu
        0br3CLtF+9OXzBY/d81jsbg9cTKjg4DHzll32T02repk87hzbQ+bx+Yl9R79fw08+rasYvT4
        vEkugD2KyyYlNSezLLVI3y6BK6N9cxdTwR6eiqM/HzE2MJ7m6mLk5JAQMJH49+g+axcjF4eQ
        wG5GiYtrz7JDJKQlrm+cAGULS6z895wdougVo8SNvuNsIAk2AV2JHYvb2EASIgJnmSXaDqxm
        AXGYBX4zSjy9eIEVpEpIYD2jxMI38l2MHBycAqYSO/vEQMLCAjkS6/fNBtvAIqAisavzPiOI
        zStgKXHlxWUWCFtQ4uTMJ2A2s4C2xNObT+HsZQtfM0NcpyDx8+kysFUiAk4Sf/fMZYKoEZc4
        +rOHeQKj8Cwko2YhGTULyahZSFoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQI
        jl0tzR2M21d90DvEyMTBeIhRgoNZSYQ3QfVfnBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeG4UL
        44QE0hNLUrNTUwtSi2CyTBycUg1MGUJCr172GoXra7pav+Y/Ps9Q5U/K1je2Gxg2xQV32e45
        e25LadsSgRMP3AUdTRbfD1acY9zyf/X1ByfiSx7Ib5U5zfLj0ePgbpV961K7LgVOtb40wXUH
        W/XT2b2f7pnrbfx5OjUgb4Hl7WU3v21v2dj9TMC1uCz0aYWicmLq49czDZsepzotPx23KvHk
        jZVT/N3f7570a+0GwZUMcWoV1zp5y/fNS9536I2b1KT+iPZFLpsq7No7BV3PvV8+Y3H63vfL
        21LPeBW0ZAduj7/5zbs7ukJHdxqL/KdUHuMpmhKpl8T+Bmo6Sl/OnsXdvcD86Mbf2e8m/Dh9
        ctcC/5dh1/wbf1v+7xBfylH5SPvwYSWW4oxEQy3mouJEANq/501MAwAA
X-CMS-MailID: 20200703172310epcas5p424c50ac69796c64c4c8044ca261fcec7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200702155211epcas5p1bcbcd489b250d3e66a8022c5c4e429ba
References: <20200702155149.12854-1-krzk@kernel.org>
        <CGME20200702155211epcas5p1bcbcd489b250d3e66a8022c5c4e429ba@epcas5p1.samsung.com>
        <20200702155149.12854-4-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Krzysztof

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
ey=40samsung.com>=0D=0A>=20Subject:=20=5BPATCH=20v2=204/8=5D=20arm64:=20dts=
:=20exynos:=20Remove=20DMA=20controller=20bus=20node=0D=0A>=20name=20to=20f=
ix=20dtschema=20warnings=0D=0A>=20=0D=0A>=20There=20is=20no=20need=20to=20k=
eep=20DMA=20controller=20nodes=20under=20AMBA=20bus=20node.=0D=0A>=20Remove=
=20the=20=22amba=22=20node=20to=20fix=20dtschema=20warnings=20like:=0D=0A>=
=20=0D=0A>=20=20=20=20=20amba:=20=24nodename:0:=20'amba'=20does=20not=20mat=
ch=20'=5E(bus=7Csoc=7Caxi=7Cahb=7Capb)(=40=5B0-=0D=0A>=209a-f=5D+)?=24'=0D=
=0A>=20=0D=0A>=20Signed-off-by:=20Krzysztof=20Kozlowski=20<krzk=40kernel.or=
g>=0D=0A>=20=0D=0AReviewed-by:=20Alim=20Akhtar=20<alim.akhtar=40samsung.com=
>=0D=0A>=20---=0D=0A>=20=0D=0A>=20Changes=20since=20v1:=0D=0A>=201.=20Remov=
e=20the=20bus,=20as=20suggested=20by=20Marek=0D=0A>=20---=0D=0A>=20=20arch/=
arm64/boot/dts/exynos/exynos5433.dtsi=20=7C=2047=20+++++++++-------------=
=0D=0A>=20=20arch/arm64/boot/dts/exynos/exynos7.dtsi=20=20=20=20=7C=2047=20=
+++++++++-------------=0D=0A>=20=202=20files=20changed,=2040=20insertions(+=
),=2054=20deletions(-)=0D=0A=0D=0A=0D=0A
