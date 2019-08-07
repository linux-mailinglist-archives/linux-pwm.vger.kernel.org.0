Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8A89842AD
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Aug 2019 04:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfHGC4W (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Aug 2019 22:56:22 -0400
Received: from mail-eopbgr1410123.outbound.protection.outlook.com ([40.107.141.123]:63288
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726518AbfHGC4W (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 6 Aug 2019 22:56:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TANHhjMGjrvSb2rCpXoW2O4md/0hy2uZSJYFM2M0N/3C5sLmiJWt8kQARXV1otAtVH9fT1ewBxNqDBT5N15IsK5v1AzlmihuM1Wqkv4uZB773mXwWAIEm2k31JKqoaIqmpkWKArvij5t4wlO+8D2SvI/XWDAJz694JHRZ73loXUJQDB/TYXh0QPvb5bqwSe2SJlCRB9ag1s1Mv3o2DY5RQdIyphseDm6vP3WaMIKYGMQY4xXjowZWjvi+DT+jfb38uiRUOvL3u3RCCJfGwX6YmvVQUb0X52vvf+EqGxCdf2ywMuBD93WZYhxJh8DZjHiPeG9h0K7h9NHkKKh23BmtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwouzDoUduJqt0YjH9Pp8b71xo7sywKVcdH5jmU6FCg=;
 b=NhI1p6VOqy2fO2VgxiXSjf2hL3Gq2+ayhkwoxKE1WXjpq7aD/qq9wXXH4na9nCtCV63VOlSXqnRIVpnuMWIdfQghcRZ+SfX9GZwdvCpCf32F9JkBZUiP3WQUoBhg5iS8ZLrfvUylzR6jQ8J9zRgJLmq9vDXmcHNd2mN28Al0q25uyDWKxLy/KSdULHBfvJP54LaAjhtJxWL3j5XCdU5xk1j5Brm+4erLb8kaO/akI0qkHAiT24uMhIMWvgEhD63H1ZMqEsNWITNRZbC290fQkn06Krof2XrJOfsbks1lPjVnV2krBkD7mgv530ArBAZb69YwM4F0Yefrf21ETxOcCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=renesas.com;dmarc=pass action=none
 header.from=renesas.com;dkim=pass header.d=renesas.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwouzDoUduJqt0YjH9Pp8b71xo7sywKVcdH5jmU6FCg=;
 b=RIydRyhpssOLn1dSZJsde1Sd37PdYSusYVW07qu0uizU9xg1BVNVfmsiUwaKyS1OzbxOqCjEP7aASGI77DUf6EM2kdOkzMZm9gEW7BqfCcMq/ekXFbNHJB6qBx719hGSjMq4M7xLL89rLYKPuoHxPgQhgN54CoI3gTqmovLwHKM=
Received: from OSBPR01MB4536.jpnprd01.prod.outlook.com (20.179.180.215) by
 OSBPR01MB3592.jpnprd01.prod.outlook.com (20.178.97.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Wed, 7 Aug 2019 02:56:20 +0000
Received: from OSBPR01MB4536.jpnprd01.prod.outlook.com
 ([fe80::106b:32d9:ab57:e8f3]) by OSBPR01MB4536.jpnprd01.prod.outlook.com
 ([fe80::106b:32d9:ab57:e8f3%3]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 02:56:19 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH RFC 5/7] pwm: rcar: remove a redundant condition in
 rcar_pwm_apply()
Thread-Topic: [PATCH RFC 5/7] pwm: rcar: remove a redundant condition in
 rcar_pwm_apply()
Thread-Index: AQHVNWy7B3H0vTEfP02Bon2vW6tMB6buAVcAgABz2ICAALM78A==
Date:   Wed, 7 Aug 2019 02:56:19 +0000
Message-ID: <OSBPR01MB4536907871FEDA8C89271360D8D40@OSBPR01MB4536.jpnprd01.prod.outlook.com>
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdWw1Gh_CxgiO5gd+MY0vUvWX_ACDj+L3_Wcomkaf5Oo4Q@mail.gmail.com>
 <20190806160007.mqwzixddhzejbmcb@pengutronix.de>
In-Reply-To: <20190806160007.mqwzixddhzejbmcb@pengutronix.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff6fd8a6-8a93-42b5-f163-08d71ae2d2e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:OSBPR01MB3592;
x-ms-traffictypediagnostic: OSBPR01MB3592:
x-ms-exchange-purlcount: 6
x-microsoft-antispam-prvs: <OSBPR01MB359286BD23CF1178E431A7BFD8D40@OSBPR01MB3592.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(189003)(199004)(446003)(33656002)(26005)(8676002)(71200400001)(8936002)(71190400001)(52536014)(81166006)(9686003)(68736007)(53936002)(25786009)(316002)(4326008)(54906003)(76176011)(86362001)(11346002)(81156014)(5660300002)(966005)(102836004)(7416002)(53546011)(186003)(3846002)(99286004)(66574012)(6506007)(7696005)(14454004)(486006)(256004)(76116006)(66946007)(74316002)(66476007)(478600001)(66446008)(6116002)(110136005)(66556008)(64756008)(55016002)(6246003)(2906002)(6306002)(66066001)(476003)(6436002)(229853002)(7736002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB3592;H:OSBPR01MB4536.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hqp6PvPkavjObuuoYTvF0SOpTzxoUxdsDDjeBAnep0O3GI3FZ77lvAK4DZ6Q77cJOgCRGwsfDuIXU6XO5cSTqK52YYB8YLohlwPumQbl7B+sC5axqW6e4rt1RExIfpu1wRVZKEMGjDZh9dE4F91PUBNG/7fy2UgRxrlE/Un60vIGyGo2oWM6XZmMSuZwVoWRv0osjQW5EkAZK+7qEe70MLhz6ij/dv3TLNHnugSd4yJj1LDG0CPyllRNHbOatUce12cpcpnKIQG2lTrO9ruik9fTBOP+YKxtwTSvbErBRHo6NCoiUv8S0CR1GUqKVU8YHcob1WDFDbvTP/Vxc3hvx28sX0ctBUUnE/feTe/fnuHfYvYo3Xcz5/x/Zt45cKTnm2B21KdOYwmotUMtYk0Tqqf0SsZdBVBKxgt8p+FpVco=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6fd8a6-8a93-42b5-f163-08d71ae2d2e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 02:56:19.7733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoshihiro.shimoda.uh@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3592
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

> From: Uwe Kleine-K=F6nig, Sent: Wednesday, August 7, 2019 1:00 AM
>=20
> Hello,
>=20
> On Tue, Aug 06, 2019 at 11:05:30AM +0200, Geert Uytterhoeven wrote:
> > On Mon, Jul 8, 2019 at 11:08 AM Yoshihiro Shimoda
> > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > Since the rcar_pwm_apply() has already check whehter state->enabled
> > > is not set or not, this patch removes a redundant condition.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > This is completely independent from the rest of the series, and can be =
applied
> > immediately, right?
>=20
> The original patch didn't make it into my mailbox. I only see a few
> replies. Is it only me?
> https://patchwork.ozlabs.org/project/linux-pwm/list/ doesn't seem to
> have it either.

I don't know why but, linux-renesas-soc ML only got the patch series.
https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=3D14312=
9


JFYI, but I submitted another patch yesterday, and it seemed to be archived=
 on all MLs:
https://www.spinics.net/lists/stable/msg322085.html
https://lkml.org/lkml/2019/8/6/274
https://patchwork.kernel.org/patch/11078469/

Best regards,
Yoshihiro Shimoda

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
