Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356785718E0
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Jul 2022 13:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiGLLuT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 12 Jul 2022 07:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiGLLuS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Jul 2022 07:50:18 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2127.outbound.protection.outlook.com [40.107.113.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E10AF771;
        Tue, 12 Jul 2022 04:50:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMSegRAdnxaC09AWjhzTwJeGNN5IPJK+PVFsVKk0Bvp2PbuF2DSb0FUYEpO+S66K9DmL9Hcj1t1t6LBmT9pqYhYODH5lg08MlhSW8opfARrptbvTtxlb01HYPlIKCKn+y2lSLm053FlNLIKSG554TKfEmtpHm+Q7KFLApfk64K0VZIrJJzFpKKtXMZw1tSWRhbx7rlgdAgqnFLUFAEUAcJ+1Rm3V8ECYMBa0Kn9wnLJj98wKWFrppkVV+G6Qg4MwR5ePnU68U2sTiSyku5wK3y7/so3136e7W3pd4vlxawKUJfB2QkXhr78DN/rmO5jeYKJKJQeom8INmlGHI2+hsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zb/s1C8KtsFd9abal5Ne/HpGlEGwCBbYIUGirHtpu44=;
 b=Bz2vqwjpSl+SiJgHHkz40jFvsZ7JKHC7DBxtU32PdByE1fvCRYP596MnAYswFivW+oh5EQZEAMK8ufpqpQ2VhFDp+zZekraOzQH/q4XfwOnIbGyZ2/xSpYYjYfBxVaqa/xr1Wnp7ck7keGVx72GGwEEKZrxURTKuyiKKQ5Q48SM7Ym6FCJR+2dqeM8NHsAaMp0SIzrKOdX4yn+ApBXU85pMcxBfZLdYuVKz/BGQbjdJfJOmFKN1uOfoOA5D6ipCsDwGBLwfuvcf0ZZg+f3AqKfmgMsr8DmrWL4zHpgWY0oSuDQGqTyonBPBxVzLyz9WyzBFOeIASKjJtFaeIskxxng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zb/s1C8KtsFd9abal5Ne/HpGlEGwCBbYIUGirHtpu44=;
 b=MGLVwxULfbR7VibH/YPenOhyc8EjJR0NMp/0tlP4Moy2JVuOZ1yhLKO0PQxAQRmWXbFbn1Mnms7KOXKH2dc+Do5NNBMkgWd+EF6L2A4OqE6sGhfd860qJouqa8WgMm2bcR6kxVHbvIHe0vfsbqsLXifMxc0BF+70K1LTa2398bA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB7845.jpnprd01.prod.outlook.com (2603:1096:400:182::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Tue, 12 Jul
 2022 11:50:14 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::dc06:eb07:874:ecce]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::dc06:eb07:874:ecce%8]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 11:50:14 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v2 2/2] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHYeb88fVRxU1LRfUqGAdbY2HigvK1IVR2AgDD3jICAAYcg4A==
Date:   Tue, 12 Jul 2022 11:50:14 +0000
Message-ID: <OS0PR01MB5922CC2A6F6B0DC441947BC186869@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220606160509.250962-1-biju.das.jz@bp.renesas.com>
 <20220606160509.250962-3-biju.das.jz@bp.renesas.com>
 <20220610083013.7asxcv4b554ln7pu@pengutronix.de>
 <OS0PR01MB592298C8E5FFCCE333F60D6A86879@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592298C8E5FFCCE333F60D6A86879@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90ec805a-baf7-433d-bf3c-08da63fcaeb8
x-ms-traffictypediagnostic: TYCPR01MB7845:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1ql40mNKD6f/o8ucB4vqWITenyDF4C1Dn0B5wrWAjQSP3TJ2u6aIKI7yMz3CnXUayaWPui93PXd3tN903Oz+tgf/bIR5AjYS2y4Qq4YXEpP2ZuN9QNSMlpDYOCh9iHyqu2YTpoOzXf777LO/gI6MzTZk5RihIW/PxQ4tDYasOSSYTbA+fkYnbUehuWG874nH1UOyXrwl7sR9vn+iYdCiTGB1iylIfuy2KrnULCNhrTzyQeybkeP3z/gpDwQx2W9ybzpJpgUa/Skogeo3N5O/+nVFzkt5MIjt7ACDQtovkiqbVutqQkw14RQKhXves01ZQ6Ok/FXeOLV5TewghgzrBL8aEZNzAz7Erax82SLqw/W2ym8f0ASyeDCFbEN2vLQDQY3f9kVAoMMe/kXLUKXoB5w3DJ93EtjRcr3xtxzomHPjVNThbKoCfaeSTh9JAVG4MBJKTu/lukNBCEKYE2TZNKfZZ6VKhR0mjxzgsb2oa/b2BNXQ/kZef+EYr+XLFzXuESULN1LmXU6zY2yDalFsbKJJF9uqykwgzs3rLG72zyuLD5Mzc/XnqawjD3S3D2a22i5sFTXc6SHlG1jUKnbOqzWuiBbuvl3Nd8Co25ETUtzDe+SaPWQKDzYurShS61OKHegYy/kJvVmeRRe0ywHC5jCTDq7EZKAkoc0h9w8ZsIx9151fR5r5frcoirMWz/9lZUY/HUjPtLrHD5o/tsjKx2hSdjkRU0r52RnJzxML1fbdys8KJii/tp2xOXs63ZpWgXKDJlcANUw0uMJng6j6z4rZzmjIvXonDz3dzPP7yuoT/wUtD1h6uKrPXzzdcfPM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(86362001)(2906002)(316002)(38100700002)(186003)(55016003)(478600001)(30864003)(52536014)(5660300002)(122000001)(8936002)(6916009)(38070700005)(66476007)(83380400001)(54906003)(6506007)(64756008)(8676002)(66556008)(33656002)(66446008)(76116006)(66946007)(26005)(4326008)(41300700001)(9686003)(7696005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SQOQZKwYZMeMN9gnBGyC1SrKO9awF2VIFbTpRBoDLkh7KTk6ZGAwWUbSee?=
 =?iso-8859-1?Q?qU3s3lB3C5SZQ8flzhxlVwHYAwDBCOmEJNZdY9SI+PMQnvVDyZF7AwYo38?=
 =?iso-8859-1?Q?QtsTsKA7tHBdPGs6aSrJbb0DKtuvRLdZhK36wxta4n7awMFsIgJuJxCfrr?=
 =?iso-8859-1?Q?iu4tpTWwQBvshdxGjZ5zDei7+KqkO/uFwwMaWjq2iXtKwpTpILq8Bbaqtm?=
 =?iso-8859-1?Q?GWYMbeXpWXN9k5Ocdsp4tV1JUvZEfwAjllfrUSgw17JY6QYCV4zYeSrNJa?=
 =?iso-8859-1?Q?7mCdoTZouif71Oa3pvsLWnbhkf46dRz6tK4GQ0lwLVjnhZM8nFQ6wp8Pgs?=
 =?iso-8859-1?Q?DPlzxsVpETnt85mr3fPuvNAqrXXCEbOZTQ3t5ClCxwRCyHT0xi+ydsFljP?=
 =?iso-8859-1?Q?HwD/pIood+i0OnJx9O7mrugYgnLJntgwKyyLZxd8lW0E3mQPkdHyB39Tqi?=
 =?iso-8859-1?Q?bccNV/2e1jsL9VOFJFPIO8X0YneedBzp/cVvVVDTDgpbEPo0CvMTQk/FZv?=
 =?iso-8859-1?Q?kL83znnNhV83w932aABITcaKIMl62TR9iNwPB1NrFjLOQVTjJB4X1KpJkq?=
 =?iso-8859-1?Q?wviIFJkVsJ32zmQ+M680/wFRnqMONvS7hnZXbbEp/BipTAHpVnLflYe/hF?=
 =?iso-8859-1?Q?ksnicUJlBY7NYJK86j0qATur4iB0bIV57W5F7yLcI/h5vNBN91t+PJJBd9?=
 =?iso-8859-1?Q?EU5BuN6yddpwjEhKY2kj9zyzdbaBf5UYNOIOMFwtzT2pQUCcTBRnYS+nMt?=
 =?iso-8859-1?Q?TKT4q2E5eVqGY9nF/nrer2IyIZNBUSv1baXEkbz3vOuHaCqm2UX2f/bNkP?=
 =?iso-8859-1?Q?jE/7wODTRjEJqNN1ZCpydRrIlrajfCit6RvWBSFTyaKF9pLMaaRUoJFszu?=
 =?iso-8859-1?Q?6dlexyMXSxw7Nh5jMXA6/p2MLyrgd/QnsK6+sxztZHz90RigHGyv/WBTMa?=
 =?iso-8859-1?Q?KVuxCFmJVCgMbSPdeuuHQUsUaeRTu7fllZQU11ng97mMisbHwlXlEYVrqH?=
 =?iso-8859-1?Q?xk3XVkudoN8IYwTqgyuelyKKY0IuJKbjNo79yOnyWvg9uGl9yVkqPrxmGT?=
 =?iso-8859-1?Q?6io0XhI3DG/7ZVTEbMsnntoIVgxr9s5FZcSNijVz1lp5jvY3myRxj8aIPG?=
 =?iso-8859-1?Q?VUO57mEFcc2qbCgA4j+1c4fqFhbl4bnquhL21fvasaXLBPc5wegU51tEoX?=
 =?iso-8859-1?Q?WpIW+JHguIgPaHi0K61FnOdbMryXIc/HUHmZXlzrg1NGtdfgpuJjzszzJ/?=
 =?iso-8859-1?Q?Vf8Cyv4M6tBxkmbnmoAXMAtZDPtNoO4LiBnwIf1rpnx0of2+KZSXQTizDf?=
 =?iso-8859-1?Q?KSy/nTSZ+GB94H3Chzam36PqeHSZ72GC/hanBtFrxz7JOXn15ypJ+gok4d?=
 =?iso-8859-1?Q?pIluGO9PQwdx7IfBAIAvpvqesA/fi7pJd0ST3Ymc1URKLvPevx1sD1xAE2?=
 =?iso-8859-1?Q?6UwCzBHfI4BaG2QCj+n5K9j523yb7ZbEWH4nmbLNS1wiKUPCtYgjiMEsZM?=
 =?iso-8859-1?Q?zU+772SPTeWG5+cz/ZRnSyyu6ZiMRbn+zNmbUW5dpuW4+SpE/y543Qc+bA?=
 =?iso-8859-1?Q?oCtnB/+RxXAgGhgtKauqUBqz1WRfYd8REp5vQEdddqWd+l4mE125GMLR4H?=
 =?iso-8859-1?Q?iA7gvcREqyGH6qE4LmKEuCoKgJYBMmCYVRz2exxEGEAlZvj2/rIqsZQQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ec805a-baf7-433d-bf3c-08da63fcaeb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 11:50:14.0441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LXsw6tPDrFKZ55PeIbbheYbpXOrRRHCK2Dj2bSZrvcMCMJFUJmBzlmb95Vd6eKtphBr/0Xe0xsdDlyAc8RB6PuUEZmtXknwwr2CabNfodGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7845
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

> Subject: RE: [PATCH v2 2/2] pwm: Add support for RZ/G2L GPT
>=20
> Hi Uwe,
>=20
> Thanks for the feedback.
>=20
> > Subject: Re: [PATCH v2 2/2] pwm: Add support for RZ/G2L GPT
> >
> > Hello,
> >
> > On Mon, Jun 06, 2022 at 05:05:09PM +0100, Biju Das wrote:
> > > RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit
> > > timer (GPT32E). It supports the following functions
> > >  * 32 bits =D7 8 channels
> > >  * Up-counting or down-counting (saw waves) or up/down-counting
> > >    (triangle waves) for each counter.
> > >  * Clock sources independently selectable for each channel
> > >  * Two I/O pins per channel
> > >  * Two output compare/input capture registers per channel
> > >  * For the two output compare/input capture registers of each
> channel,
> > >    four registers are provided as buffer registers and are capable of
> > >    operating as comparison registers when buffering is not in use.
> > >  * In output compare operation, buffer switching can be at crests or
> > >    troughs, enabling the generation of laterally asymmetric PWM
> > waveforms.
> > >  * Registers for setting up frame cycles in each channel (with
> > capability
> > >    for generating interrupts at overflow or underflow)
> > >  * Generation of dead times in PWM operation
> > >  * Synchronous starting, stopping and clearing counters for arbitrary
> > >    channels
> > >  * Starting, stopping, clearing and up/down counters in response to
> > input
> > >    level comparison
> > >  * Starting, clearing, stopping and up/down counters in response to a
> > >    maximum of four external triggers
> > >  * Output pin disable function by dead time error and detected
> > >    short-circuits between output pins
> > >  * A/D converter start triggers can be generated (GPT32E0 to
> > > GPT32E3)
> > >  * Enables the noise filter for input capture and external trigger
> > >    operation
> > >
> > > This patch adds basic pwm support for RZ/G2L GPT driver by creating
> > > separate logical channels for each IOs.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > > v1->v2:
> > >  * Added Limitations section
> > >  * dropped "_MASK" from the define names.
> > >  * used named initializer for struct phase
> > >  * Added gpt_pwm_device into a flexible array member in
> > > rzg2l_gpt_chip
> > >  * Revised the logic for prescale
> > >  * Added .get_state callback
> > >  * Improved error handling in rzg2l_gpt_apply
> > >  * Removed .remove callback
> > >  * Tested driver with PWM_DEBUG enabled
> > > RFC->V1:
> > >  * Updated macros
> > >  * replaced rzg2l_gpt_write_mask()->rzg2l_gpt_modify()
> > >  * Added rzg2l_gpt_read()
> > > ---
> > >  drivers/pwm/Kconfig         |  11 ++
> > >  drivers/pwm/Makefile        |   1 +
> > >  drivers/pwm/pwm-rzg2l-gpt.c | 351
> > > ++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 363 insertions(+)
> > >  create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c
> > >
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> > > 904de8d61828..a6cf24cb31e0 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -471,6 +471,17 @@ config PWM_ROCKCHIP
> > >  	  Generic PWM framework driver for the PWM controller found on
> > >  	  Rockchip SoCs.
> > >
> > > +config PWM_RZG2L_GPT
> > > +	tristate "Renesas RZ/G2L General PWM Timer support"
> > > +	depends on ARCH_RENESAS || COMPILE_TEST
> > > +	depends on HAS_IOMEM
> > > +	help
> > > +	  This driver exposes the General PWM Timer controller found in
> > Renesas
> > > +	  RZ/G2L like chips through the PWM API.
> > > +
> > > +	  To compile this driver as a module, choose M here: the module
> > > +	  will be called pwm-rzg2l-gpt.
> > > +
> > >  config PWM_SAMSUNG
> > >  	tristate "Samsung PWM support"
> > >  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS ||
> > > COMPILE_TEST diff --git a/drivers/pwm/Makefile
> > > b/drivers/pwm/Makefile index 5c08bdb817b4..12bc2a005e24 100644
> > > --- a/drivers/pwm/Makefile
> > > +++ b/drivers/pwm/Makefile
> > > @@ -43,6 +43,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-
> raspberrypi-
> > poe.o
> > >  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
> > >  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
> > >  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> > > +obj-$(CONFIG_PWM_RZG2L_GPT)	+=3D pwm-rzg2l-gpt.o
> > >  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
> > >  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> > >  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> > > diff --git a/drivers/pwm/pwm-rzg2l-gpt.c
> > > b/drivers/pwm/pwm-rzg2l-gpt.c new file mode 100644 index
> > > 000000000000..f83ba2d5c219
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > > @@ -0,0 +1,351 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Renesas RZ/G2L General PWM Timer (GPT) driver
> > > + *
> > > + * Copyright (C) 2022 Renesas Electronics Corporation
> > > + *
> > > + * Limitations:
> > > + * - Mode and Prescalar must be set, while the GTCNT is stopped.
> > > + * - Configured for Output low on GTIOCx pin when counting stops.
> >
> > The last item means the PWM emits the inactive level when disabled,
> > right? Then I suggest to write that as:
> >
> >  * - When PWM is disabled, the output is driven to inactive.
> >
> > to simplify understanding that. Also add:
> >
> >  * - While the hardware supports both polarities, the driver (for now)
> >  *   only handles normal polarity.
>=20
> OK.
>=20
> >
> > > + */
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/io.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/pwm.h>
> > > +#include <linux/reset.h>
> > > +#include <linux/time.h>
> > > +
> > > +#define GPT_IO_PER_CHANNEL	2
> > > +
> > > +#define GTPR_MAX_VALUE	0xFFFFFFFF
> > > +#define GTCR		0x2c
> > > +#define GTUDDTYC	0x30
> > > +#define GTIOR		0x34
> > > +#define GTBER		0x40
> > > +#define GTCNT		0x48
> > > +#define GTCCRA		0x4c
> > > +#define GTCCRB		0x50
> > > +#define GTPR		0x64
> > > +
> > > +#define GTCR_CST	BIT(0)
> > > +#define GTCR_MD		GENMASK(18, 16)
> > > +#define GTCR_TPCS	GENMASK(26, 24)
> > > +
> > > +#define GTCR_MD_SAW_WAVE_PWM_MODE	FIELD_PREP(GTCR_MD, 0)
> > > +
> > > +#define GTUDDTYC_UP	BIT(0)
> > > +#define GTUDDTYC_UDF	BIT(1)
> > > +#define UP_COUNTING	(GTUDDTYC_UP | GTUDDTYC_UDF)
> > > +
> > > +#define GTIOR_GTIOA	GENMASK(4, 0)
> > > +#define GTIOR_GTIOB	GENMASK(20, 16)
> > > +#define GTIOR_OAE	BIT(8)
> > > +#define GTIOR_OBE	BIT(24)
> > > +
> > > +#define INIT_OUT_LO_OUT_LO_END_TOGGLE	0x07
> > > +#define INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
> > > +
> > > +#define GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH
> > 	(INIT_OUT_HI_OUT_HI_END_TOGGLE | GTIOR_OAE)
> > > +#define GTIOR_GTIOA_OUT_LO_END_TOGGLE_CMP_MATCH
> > 	(INIT_OUT_LO_OUT_LO_END_TOGGLE | GTIOR_OAE)
> > > +#define GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH
> > 	((INIT_OUT_HI_OUT_HI_END_TOGGLE << 16) | GTIOR_OBE)
> > > +#define GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH
> > 	((INIT_OUT_LO_OUT_LO_END_TOGGLE << 16) | GTIOR_OBE)
> >
> > the LHS of the last define can be better written as:
> >
> > 	FIELD_PREP(GTIOR_GTIOB, INIT_OUT_LO_OUT_LO_END_TOGGLE) | GTIOR_OBE
> >
> > It's a bit longer, but doesn't duplicate the 16. Similar for the other
> > defines.
>=20
> But this is giving compilation error, Any pointers to fix this issue?
>=20
> In file included from drivers/pwm/pwm-rzg2l-gpt.c:14:
> ./include/linux/bitfield.h:113:2: error: braced-group within expression
> allowed only inside a function
>   113 |  ({        \
>       |  ^
> drivers/pwm/pwm-rzg2l-gpt.c:57:55: note: in expansion of macro
> 'FIELD_PREP'
>    57 | #define RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH
> FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE) |
> RZG2L_GTIOR_OBE
>       |                                                       ^~~~~~~~~~
> drivers/pwm/pwm-rzg2l-gpt.c:75:12: note: in expansion of macro
> 'RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH'
>    75 |   .value =3D RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH,
>       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> make[2]: *** [scripts/Makefile.build:249: drivers/pwm/pwm-rzg2l-gpt.o]
> Error 1
> make[1]: *** [scripts/Makefile.build:466: drivers/pwm] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1843: drivers] Error 2
> make: *** Waiting for unfinished jobs....
>=20
> >
> > Can you please prefix all these defines all by RZG2L_?
>=20
> Ok, Agreed.
>=20
> >
> > > +
> > > +struct phase {
> > > +	u32 value;
> > > +	u32 mask;
> > > +	u32 duty_reg_offset;
> > > +};
> > > +
> > > +static const struct phase phase_params[] =3D {
> > > +	/* Setting for phase A */
> > > +	{
> > > +		.value =3D GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH,
> > > +		.mask =3D GTIOR_GTIOA | GTIOR_OAE,
> > > +		.duty_reg_offset =3D GTCCRA,
> > > +	},
> > > +	/* Setting for phase B */
> > > +	{
> > > +		.value =3D GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH,
> > > +		.mask =3D GTIOR_GTIOB | GTIOR_OBE,
> > > +		.duty_reg_offset =3D GTCCRB,
> > > +	},
> > > +};
> > > +
> > > +struct gpt_pwm_device {
> > > +	const struct phase *ph;
> > > +};
> > > +
> > > +struct rzg2l_gpt_chip {
> > > +	struct pwm_chip chip;
> > > +	void __iomem *mmio;
> > > +	struct reset_control *rstc;
> > > +	struct clk *clk;
> > > +	struct gpt_pwm_device gpt[2];
> > > +};
> > > +
> > > +static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct
> > > +pwm_chip *chip) {
> > > +	return container_of(chip, struct rzg2l_gpt_chip, chip); }
> > > +
> > > +static void rzg2l_gpt_write(struct rzg2l_gpt_chip *pc, u32 reg, u32
> > > +data) {
> > > +	iowrite32(data, pc->mmio + reg);
> > > +}
> > > +
> > > +static u32 rzg2l_gpt_read(struct rzg2l_gpt_chip *pc, u32 reg) {
> > > +	return ioread32(pc->mmio + reg);
> > > +}
> > > +
> > > +static void rzg2l_gpt_modify(struct rzg2l_gpt_chip *pc, u32 reg,
> > > +u32 clr, u32 set) {
> > > +	rzg2l_gpt_write(pc, reg, (rzg2l_gpt_read(pc, reg) & ~clr) | set);
> > > +}
> > > +
> > > +static u8 rzg2l_calculate_prescale(struct rzg2l_gpt_chip *pc, u64
> > > +period_cycles) {
> > > +	u16 i, prod;
> > > +	u8 prescale;
> > > +
> > > +	prescale =3D 5;
> > > +	/* prescale 1, 4, 16, 64, 256 and 1024 */
> > > +	for (i =3D 0; i < 6; i++) {
> > > +		prod =3D 1 << (2 * i);
> > > +		if ((period_cycles / (1ULL * GTPR_MAX_VALUE * prod)) =3D=3D 0) {
> > > +			prescale =3D i;
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	return prescale;
> >
> > You must not do 64 bit divisions using /.
> > Also you can shorten the calculation using something like:
> >
> > 	prescaled_period_cycles =3D period_cycles;
> > 	do_div(prescaled_period_cycles, GTPR_MAX_VALUE);
> >
> > 	prescale =3D fls((prescaled_period_cycles + 1) >> 1);
> > 	return min(prescale, 5);
> >
> > (Please double check, I didn't)
>=20
> OK, will do.

I double checked and prescalar values seems to be wrong with the above calc=
ulation.

Rate=3D100MHz
32 bit counter

With this max period achievable is 42 sec and min is 0.1 nsec.

Max -> 2^32 / 100M =3D 42 sec
Min -> 1 / 100M =3D 0.1 nsec.

To increase the max period, say
from 42 sec to 168 sec we need to use prescalar =3D 4, So Clk rate reduces =
to 100 M/ 4.
from 168 sec to 640 sec we need to use prescalar =3D 16 =20
etc ...

I used the below logic and it gives proper prescale values.

+       prescaled_period_cycles =3D period_cycles >> 32;
+       prescale =3D 5;
+       /* prescale 1, 4, 16, 64, 256 and 1024 */
+       for (i =3D 0; i < 6; i++) {
+               if ((1 << (2 * i)) > prescaled_period_cycles) {
+                       prescale =3D i;
+                       break;
+               }
+       }

Please correct me, if anything wrong with this calculation.

Cheers,
Biju

