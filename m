Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FCD6AB72E
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Mar 2023 08:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjCFHl7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Mar 2023 02:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCFHl6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Mar 2023 02:41:58 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2124.outbound.protection.outlook.com [40.107.113.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD031E9F6;
        Sun,  5 Mar 2023 23:41:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKNwyOEY4vtrxWSCOXYDLU/G0pFNLjNFvjr6VMvd9LD4sKT8IdxrxLd7lACYVt2SgEy8iwwcWp+3jGh9++9G7RXxPM0jT3at/bBYwNxZXv6F76mQUgkvWhB6WCFp8B59ki7mZRjiqXCi1KZL0o1Tu1x5ssjOKT5/NIdaPfrgqRQgz5P7AkLAX6l7f9uTNzM4iQy59unDk0AQngzW6Ds+anl16gvBwR2CSnW5Imr61nDylVJilb5viBFW+DUzDyA7UMEN+3dni3dfGNnE/CcEDoGDhafccUwFGWcOdjPtQSjncKxdqk4TMVOxecNttU2oaymTMA1X0qgSpyimVUIQnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9oQA3L2fdZbsBw9kxz8XF/VU8oUDJJKNIGVpDiYeIY=;
 b=GFywXhSuAjbcuTU3CvStqQ3Mm9srOp8DJwFkRLznVtzDjJWWHpXGlyw7qVW10ObDsGf6ncTEftdVvNpCtEv1IwTsJHhq6UPaBmm4XBkkceN6bbvnxE1btJJOqMNgSSYGwjQBvyCxVhlseVk2ve7GS7mI+QCA0yx5zQPuP04lVmmors9dij29ZEp308m4TF2IeTBKFzdpuEJfN+Ajw0WlQdPZGpaePZRKcgFq1kNRsHCCYHTS8YFVy5dBJuId2j19cUKShTUhbcYosC6OKq/olosUrpxzblGJr0q7DbCqmO+VpeB/C5XXGYAv5VGFJWQa0TKiNfgrvMIlzeiAT5/vfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9oQA3L2fdZbsBw9kxz8XF/VU8oUDJJKNIGVpDiYeIY=;
 b=MB35gZa4saCQcyeq5NEKKdGHmb/oA4jEkBQ+xeaFnN+vkyUaiPxd2XkqXSocgVn8w82VnRv+caTvM2KpTKIGYT4wlWLLGhHx/c+ZHQclBySwiFSF2GuSbp4Rwb78xM4du73hYICf8S0lvXsZ3G+MVYpkx60ZRg9GVdWrB6AwMZI=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB11652.jpnprd01.prod.outlook.com (2603:1096:400:373::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.25; Mon, 6 Mar
 2023 07:41:50 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f54c:4b2:9c7d:f207]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f54c:4b2:9c7d:f207%7]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 07:41:50 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Lee Jones <lee@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v13 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Topic: [PATCH v13 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Index: AQHZQka3WKHDuEiCI0iqGwH6TyqgPa7tePAA
Date:   Mon, 6 Mar 2023 07:41:50 +0000
Message-ID: <OS0PR01MB5922479EE80D67046487063986B69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230216203830.196632-1-biju.das.jz@bp.renesas.com>
 <20230216203830.196632-7-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230216203830.196632-7-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB11652:EE_
x-ms-office365-filtering-correlation-id: b33a58bc-d920-4c99-ca24-08db1e163f2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BV+N+Cu9mI8i5RGJMUTJilg+HLDrOAjIaOwBFm1W20Pbr8/LwQSWzTuPXq4eCvZSEA7C0TqmscxvR5sS3hYXSgJ+BTFPcPYUCr3+IxY10l7ZHuSXDkhQF3Ed50HMM+ivuiPuA1aPjEG08kHsGCNFRjaDTHm3Bg06RQ+7BTIpAtxyuTHn/Sq244lIKCrgY40xXBVpHNgIIfPrOkzdlmP8tLY9Ok9IPhTvF+uNTYdynHoA4qyR+ZepAEf5/agBtnbFVRnObQto2UaUVvkw7WcCH1DPohd4v0XZFIbfRseQZwe8mTsyOu9N0WTlHflY7RF0CBimwkR3+srLLvtj6L85CHAf4BoztH8x8mNBbxepkN/L6T4lGRBeL7Om7phvXr91gLkldthp+EjAXZvP2QtGbyxjSN0xv67thfClIWkhaO4xAnHtMJ6CtT7UG7arRaXEWhpq5MWbmSbr0wtuLgdMq1+PSZXCwL8g/UaNtSOkXsmDRQ3B+FsaWuiKWGFEEmY+3GYpwzpNgjNulPyOhXq7bvnjlXymE/y33lsgxMU9jglWzGHTvSpLEe4hIuewILKUoJo2tijOp79/5dssvd8QXGhuDp9+TR7U1L3eoE7dTrjmXeUR3UFU0URJTIzYafG6G28WP8unIRiwk4J7Y/l2OCIwDclZLPzkrEj4QquqBOiwBHimODjyOb6RXfOREnMnQF0QFsHyojsRs1xNfyO+Bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199018)(7696005)(9686003)(6506007)(186003)(83380400001)(2906002)(478600001)(71200400001)(8676002)(66476007)(64756008)(66446008)(66946007)(122000001)(76116006)(66556008)(110136005)(4326008)(26005)(316002)(8936002)(38070700005)(41300700001)(38100700002)(30864003)(52536014)(5660300002)(33656002)(54906003)(55016003)(86362001)(32563001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pXZqV1xO+WvR3GDuSAxci3NXsz1Yi1vYNXwXLb8bHYdoa4JSHPZtZKR4Bm?=
 =?iso-8859-1?Q?mLLSzs+m+ieYqAcT9i33KY7D6h/SDQ7S8baAvDiLBH8Lo0+H9j3jz0U76q?=
 =?iso-8859-1?Q?JZ2C8hGaclZlltrckbNUHp+ulEB1vBdXVlYceLnZ2IN2Yn69CkC5VizpXT?=
 =?iso-8859-1?Q?vyc8XNuyRVpUtdL2+OnZfYxUevWYW6nEmmSo4Y3gdaBVqMByUJvRgn9Svv?=
 =?iso-8859-1?Q?+9R1VFGu0WRNZzGVr7UCbfuUUJP4drsEXMjEVS5boO3QyBuu4kPhw6cw9g?=
 =?iso-8859-1?Q?lHJH392WlCAXL4AkTbzhhHSdgmFXuvmntUoRhfApiWG89TXvHH4doGzvFg?=
 =?iso-8859-1?Q?YyzWvwbjKmytyYMQNLnUng6e7WgBWqcDut6Vl//6Yu5ojYJ72Dn+d+0S0L?=
 =?iso-8859-1?Q?t70IYS/O17AoFVUJYh3lyCeif8m+FJKLM6bAQi/RqEcEA4CPI0GQqLxxW+?=
 =?iso-8859-1?Q?Sp3M2P2qLn3Y08RbiOef19d7vhT7Qxy+7IgRpr6HB6lSZYlq+b6hEOwQUU?=
 =?iso-8859-1?Q?lqukLbvPNLXDjWvPOlFujMfX4HqGrOJE7iBb8k/OqcGv134hx6HDI9TWB6?=
 =?iso-8859-1?Q?xf6PHEwTmEu8qXscP4BS9A03iGMLFqwqoZRSFVA+Hz3a+MBmvkMihSmZ64?=
 =?iso-8859-1?Q?vqPvL5g8zL0qkRg7clZN8LrkDUqBWeRgq5OwX++luXOLz+owk0lTCJ0wTD?=
 =?iso-8859-1?Q?VGrfjMzgLmfoccPIERs/GQNE3rAD653ajdHTvtmwy/PIgzAzclRzUQAclp?=
 =?iso-8859-1?Q?bn5AUMfGu4d1swABZixR6VXUI2pIkWBv9wC7Jks2pG0hYSl1VVCQBrGY7g?=
 =?iso-8859-1?Q?WNHLmrmYybZ5pz88TI2q4qrLc8HTgWuaImeVhejPNYXV+2LPYX1U5i76Cp?=
 =?iso-8859-1?Q?ws581JgnOuP7VjygxtZsaexQLj6MVQiRTk7YYz9vVCpYZKSa9ykhVdrYX3?=
 =?iso-8859-1?Q?Y/fxYToKvhic7GYYuTlt6UDkdIFMHMVIvXktqYidFtgFcYos4DtYCQdfda?=
 =?iso-8859-1?Q?V9QEGAdF9PwLRJ+uzk+TCMTVr23aBh4VidzzXtrMQYB25Rt9l8sR7hU7or?=
 =?iso-8859-1?Q?a/fAmT0BSfXzqI9RHetlEy2JIBBa9Y35C16D6fd2CnPSaeWQ3cmOxFFNr6?=
 =?iso-8859-1?Q?cZJ1WpgxJP70WyS52gIZ56pYMjtvdqzFWCJGINm2E4FX9aZjTgoz3v7S9a?=
 =?iso-8859-1?Q?FMQQIcnZe/b2R1e9u8JY/tOsUMyKO5ElNOFaZXGqYLvG4CTggfOLLcQgbg?=
 =?iso-8859-1?Q?9U742xrNERIwIk4/XDvA9ltmgDSpG5bd+00ETeeSgJVwPyX2ltsxuyQCks?=
 =?iso-8859-1?Q?wZ8ZEN8WJAywlSBw9XoZqsDG89eRQNpwu+RzjG2joQybIj5p4hion0UZ5M?=
 =?iso-8859-1?Q?NU2SKoJwc0Iw2cnTHBEFWumbNbn/ERdqgtynNp4/FHevWuK9kbKxBSMmFI?=
 =?iso-8859-1?Q?V/uLtjrCkSy9MIPRdLrVTQGfgGn4IZqlpIdWFdtqzqxbZUndrt/cBoAtcv?=
 =?iso-8859-1?Q?3Y80uzFBrg3iYNbOXf+Q17zM1JM08QSRJPPG5PJHixwsAR29bI3ExtjsHP?=
 =?iso-8859-1?Q?CURuycyEjnVe5Z2f3h73mqbprZ2NRArRwa1uz8RWxx3hQ8vJrFWAn59AwR?=
 =?iso-8859-1?Q?R9HxlcnzsTt58ljZsy4oQFlBfdLJTM3DRE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33a58bc-d920-4c99-ca24-08db1e163f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 07:41:50.0520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnPVWGemWgtqXdpCgTXQ0tzVDzV1paNSAILj8zyXK0/LiKpGRQRobmyNMN+80+IAE63LxpgoKDYTZXgNALmSZuCNUrw60RXKD9Qn1Q6Ggyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11652
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry and Uwe,

Gentle ping for review. If you are happy, Can I get your Rb tag for this pa=
tch?

I need to start working for v14 for based on comments from Lee.
So if any comments for PWM, I can incorporate the same in that patch series=
.

Cheers,
Biju

> Subject: [PATCH v13 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
>=20
> The RZ/G2L Multi-Function Timer Pulse Unit 3 (a.k.a MTU3a) uses one count=
er
> and two match components to configure duty_cycle and period to generate P=
WM
> output waveform.
>=20
> This patch adds basic support for RZ/G2L MTU3a PWM driver by creating
> separate PWM channels for each IOs.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v12->v13:
>  * Updated commit description
>  * Moved RZ_MTU3_TMDR1_MD_* macros to rz_mtu3.h
>  * Updated Limitations section.
>  * Removed PWM mode1 references from the driver.
>  * Dropped prescale and duty_cycle from struct rz_mtu3_pwm_chip.
>  * Replaced rz_mtu3_pwm_mode1_num_ios->rz_mtu3_hw_channel_ios.
>  * Avoided race condition in rz_mtu3_pwm_request()/rz_mtu3_pwm_free().
>  * Updated get_state() by adding dc > pv check and added a comment about
>    overflow condition.
>  * Moved overflow condition check from config->probe()
>  * Replaced pm_runtime_resume_and_get with unconditional
> pm_runtime_get_sync()
>    in config()
>  * Added error check for clk_prepare_enable() in probe() and propagating
> error
>    to the caller for pm_runtime_resume()
>  * clk_get_rate() is called after enabling the clock and
> clk_rate_exclusive_put()
> v11->v12:
>  * Updated header file to <linux/mfd/rz-mtu3.h> as core driver is in MFD.
>  * Reordered get_state()
> v10->v11:
>  * No change.
> v9->v10:
>  * No change.
> v8->v9:
>  * Added prescale/duty_cycle variables to struct rz_mtu3_pwm_chip and
>    cached this values in rz_mtu3_pwm_config and used this cached values
>    in get_state(), if PWM is disabled.
>  * Added return code for get_state()
> v7->v8:
>  * Simplified rz_mtu3_pwm_request by calling rz_mtu3_request_channel()
>  * Simplified rz_mtu3_pwm_free by calling rz_mtu3_release_channel()
> v6->v7:
>  * Added channel specific mutex lock to avoid race between counter
>    device and rz_mtu3_pwm_{request,free}
>  * Added pm_runtime_resume_and_get in rz_mtu3_pwm_enable()
>  * Added pm_runtime_put_sync in rz_mtu3_pwm_disable()
>  * Updated rz_mtu3_pwm_config()
>  * Updated rz_mtu3_pwm_apply()
> v5->v6:
>  * Updated commit and Kconfig description
>  * Sorted the header
>  * Replaced dev_get_drvdata from rz_mtu3_pwm_pm_disable()
>  * Replaced SET_RUNTIME_PM_OPS->DEFINE_RUNTIME_DEV_PM_OPS and removed
>    __maybe_unused from suspend/resume()
> v4->v5:
>  * pwm device is instantiated by mtu3a core driver.
> v3->v4:
>  * There is no resource associated with "rz-mtu3-pwm" compatible
>    and moved the code to mfd subsystem as it binds against "rz-mtu".
>  * Removed struct platform_driver rz_mtu3_pwm_driver.
> v2->v3:
>  * No change.
> v1->v2:
>  * Modelled as a single PWM device handling multiple channles.
>  * Used PM framework to manage the clocks.
> ---
>  drivers/pwm/Kconfig       |  11 +
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-rz-mtu3.c | 480 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 492 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rz-mtu3.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> 31cdc9dae3c5..c54cbeabe093 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -492,6 +492,17 @@ config PWM_ROCKCHIP
>  	  Generic PWM framework driver for the PWM controller found on
>  	  Rockchip SoCs.
>=20
> +config PWM_RZ_MTU3
> +	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
> +	depends on RZ_MTU3 || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This driver exposes the MTU3a PWM Timer controller found in Renesas
> +	  RZ/G2L like chips through the PWM API.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-rz-mtu3.
> +
>  config PWM_SAMSUNG
>  	tristate "Samsung PWM support"
>  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile index
> a95aabae9115..6b75c0145336 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -45,6 +45,7 @@ obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_RZV2M)		+=3D pwm-rzv2m.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> +obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c new fi=
le
> mode 100644 index 000000000000..1416c033edb4
> --- /dev/null
> +++ b/drivers/pwm/pwm-rz-mtu3.c
> @@ -0,0 +1,480 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L MTU3a PWM Timer driver
> + *
> + * Copyright (C) 2022 Renesas Electronics Corporation
> + *
> + * Hardware manual for this IP can be found here
> + *
> +https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-use
> +rs-manual-hardware-0?language=3Den
> + *
> + * Limitations:
> + * - When PWM is disabled, the output is driven to Hi-Z.
> + * - While the hardware supports both polarities, the driver (for now)
> + *   only handles normal polarity.
> + * - HW uses one counter and two match components to configure duty_cycl=
e
> + *   and period.
> + * - Multi-Function Timer Pulse Unit(a.k.a MTU) has 7 HW channels for PW=
M
> + *   PWM operatins(MTU{0..4, 6, 7}).
> + * - MTU{1, 2} channels have a single IO, whereas all other channels hav=
e 2
> IOs.
> + * - Each IO is modeled as an independent PWM channel.
> + * - A table rz_mtu3_hw_channel_ios table is used to map the PWM channel=
 to
> the
> + *   corresponding HW channel and vice versa.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/limits.h>
> +#include <linux/mfd/rz-mtu3.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +#include <linux/time.h>
> +
> +#define RZ_MTU3_TIOR_OC_RETAIN		(0)
> +#define RZ_MTU3_TIOR_OC_0_H_COMP_MATCH	(2)
> +#define RZ_MTU3_TIOR_OC_1_TOGGLE	(7)
> +#define RZ_MTU3_TIOR_OC_IOA		GENMASK(3, 0)
> +
> +#define RZ_MTU3_TCR_CCLR_TGRC		(5 << 5)
> +#define RZ_MTU3_TCR_CKEG_RISING		(0 << 3)
> +
> +#define RZ_MTU3_TCR_TPCS		GENMASK(2, 0)
> +
> +#define RZ_MTU3_MAX_PWM_CHANNELS	(12)
> +
> +#define RZ_MTU3_MAX_HW_CHANNELS	(7)
> +
> +/* The below table represents the number of IOs on each MTU HW channel.
> +*/ static const u8 rz_mtu3_hw_channel_ios[] =3D { 2, 1, 1, 2, 2, 2, 2 };
> +
> +/**
> + * struct rz_mtu3_pwm_chip - MTU3 pwm private data
> + *
> + * @chip: MTU3 pwm chip data
> + * @clk: MTU3 module clock
> + * @lock: Lock to prevent concurrent access for usage count
> + * @rate: MTU3 clock rate
> + * @user_count: MTU3 usage count
> + * @rz_mtu3_channel: HW channels for the PWM  */
> +
> +struct rz_mtu3_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	struct mutex lock;
> +	unsigned long rate;
> +	u32 user_count[RZ_MTU3_MAX_HW_CHANNELS];
> +	struct rz_mtu3_channel *ch[RZ_MTU3_MAX_HW_CHANNELS]; };
> +
> +static inline struct rz_mtu3_pwm_chip *to_rz_mtu3_pwm_chip(struct
> +pwm_chip *chip) {
> +	return container_of(chip, struct rz_mtu3_pwm_chip, chip); }
> +
> +static u8 rz_mtu3_pwm_calculate_prescale(struct rz_mtu3_pwm_chip *rz_mtu=
3,
> +					 u64 period_cycles)
> +{
> +	u32 prescaled_period_cycles;
> +	u8 prescale;
> +
> +	prescaled_period_cycles =3D period_cycles >> 16;
> +	if (prescaled_period_cycles >=3D 16)
> +		prescale =3D 3;
> +	else
> +		prescale =3D (fls(prescaled_period_cycles) + 1) / 2;
> +
> +	return prescale;
> +}
> +
> +static struct rz_mtu3_channel *
> +rz_mtu3_get_hw_channel(struct rz_mtu3_pwm_chip *rz_mtu3_pwm, u32
> +channel) {
> +	unsigned int i, ch_index =3D 0;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(rz_mtu3_hw_channel_ios); i++) {
> +		ch_index +=3D rz_mtu3_hw_channel_ios[i];
> +
> +		if (ch_index > channel)
> +			break;
> +	}
> +
> +	return rz_mtu3_pwm->ch[i];
> +}
> +
> +static u32 rz_mtu3_get_hw_channel_index(struct rz_mtu3_pwm_chip
> *rz_mtu3_pwm,
> +					struct rz_mtu3_channel *ch)
> +{
> +	u32 i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(rz_mtu3_hw_channel_ios); i++) {
> +		if (ch =3D=3D rz_mtu3_pwm->ch[i])
> +			break;
> +	}
> +
> +	return i;
> +}
> +
> +static bool rz_mtu3_pwm_is_second_channel(u32 ch_index, u32 hwpwm) {
> +	u32 i, pwm_ch_index =3D 0;
> +
> +	for (i =3D 0; i < ch_index; i++)
> +		pwm_ch_index +=3D rz_mtu3_hw_channel_ios[i];
> +
> +	return pwm_ch_index !=3D hwpwm;
> +}
> +
> +static bool rz_mtu3_pwm_is_ch_enabled(struct rz_mtu3_pwm_chip *rz_mtu3_p=
wm,
> +				      u32 hwpwm)
> +{
> +	struct rz_mtu3_channel *ch;
> +	bool is_channel_en;
> +	u32 ch_index;
> +	u8 val;
> +
> +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, hwpwm);
> +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> +	is_channel_en =3D rz_mtu3_is_enabled(ch);
> +
> +	if (rz_mtu3_pwm_is_second_channel(ch_index, hwpwm))
> +		val =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TIORL);
> +	else
> +		val =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TIORH);
> +
> +	return (is_channel_en && (val & RZ_MTU3_TIOR_OC_IOA)); }
> +
> +static int rz_mtu3_pwm_request(struct pwm_chip *chip, struct pwm_device
> +*pwm) {
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +	struct rz_mtu3_channel *ch;
> +	u32 ch_index;
> +
> +	mutex_lock(&rz_mtu3_pwm->lock);
> +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> +	if (!rz_mtu3_pwm->user_count[ch_index] &&
> !rz_mtu3_request_channel(ch)) {
> +		mutex_unlock(&rz_mtu3_pwm->lock);
> +		return -EBUSY;
> +	}
> +
> +	rz_mtu3_pwm->user_count[ch_index]++;
> +	mutex_unlock(&rz_mtu3_pwm->lock);
> +
> +	return 0;
> +}
> +
> +static void rz_mtu3_pwm_free(struct pwm_chip *chip, struct pwm_device
> +*pwm) {
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +	struct rz_mtu3_channel *ch;
> +	u32 ch_index;
> +
> +	mutex_lock(&rz_mtu3_pwm->lock);
> +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> +
> +	rz_mtu3_pwm->user_count[ch_index]--;
> +	if (!rz_mtu3_pwm->user_count[ch_index])
> +		rz_mtu3_release_channel(ch);
> +
> +	mutex_unlock(&rz_mtu3_pwm->lock);
> +}
> +
> +static int rz_mtu3_pwm_enable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
> +			      struct pwm_device *pwm)
> +{
> +	struct rz_mtu3_channel *ch;
> +	u32 ch_index;
> +	u8 val;
> +	int rc;
> +
> +	rc =3D pm_runtime_resume_and_get(rz_mtu3_pwm->chip.dev);
> +	if (rc)
> +		return rc;
> +
> +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> +	val =3D (RZ_MTU3_TIOR_OC_1_TOGGLE << 4) |
> +RZ_MTU3_TIOR_OC_0_H_COMP_MATCH;
> +
> +	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_MD_PWMMODE1);
> +	if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm))
> +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORL, val);
> +	else
> +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORH, val);
> +
> +	if (rz_mtu3_pwm->user_count[ch_index] <=3D 1)
> +		rz_mtu3_enable(ch);
> +
> +	return 0;
> +}
> +
> +static void rz_mtu3_pwm_disable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
> +				struct pwm_device *pwm)
> +{
> +	struct rz_mtu3_channel *ch;
> +	u32 ch_index;
> +
> +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> +
> +	/* Return to normal mode and disable output pins of MTU3 channel */
> +	if (rz_mtu3_pwm->user_count[ch_index] <=3D 1)
> +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1,
> RZ_MTU3_TMDR1_MD_NORMAL);
> +
> +	if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm))
> +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORL,
> RZ_MTU3_TIOR_OC_RETAIN);
> +	else
> +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORH,
> RZ_MTU3_TIOR_OC_RETAIN);
> +
> +	if (rz_mtu3_pwm->user_count[ch_index] <=3D 1)
> +		rz_mtu3_disable(ch);
> +
> +	pm_runtime_put_sync(rz_mtu3_pwm->chip.dev);
> +}
> +
> +static int rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_devic=
e
> *pwm,
> +				 struct pwm_state *state)
> +{
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +	struct rz_mtu3_channel *ch;
> +	u8 prescale, val;
> +	u32 ch_index;
> +	u16 dc, pv;
> +	u64 tmp;
> +
> +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> +	pm_runtime_get_sync(chip->dev);
> +	state->enabled =3D rz_mtu3_pwm_is_ch_enabled(rz_mtu3_pwm, pwm->hwpwm);
> +	if (state->enabled) {
> +		val =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TCR);
> +		prescale =3D FIELD_GET(RZ_MTU3_TCR_TPCS, val);
> +
> +		if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm)) {
> +			dc =3D rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRD);
> +			pv =3D rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRC);
> +		} else {
> +			dc =3D rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRB);
> +			pv =3D rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRA);
> +		}
> +
> +		/* With prescale <=3D 7 and pv <=3D 0xffff this doesn't overflow.
> */
> +		tmp =3D NSEC_PER_SEC * (u64)pv << (2 * prescale);
> +		state->period =3D DIV_ROUND_UP_ULL(tmp, rz_mtu3_pwm->rate);
> +		tmp =3D NSEC_PER_SEC * (u64)dc << (2 * prescale);
> +		state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, rz_mtu3_pwm->rate);
> +	}
> +
> +	if (state->duty_cycle > state->period)
> +		state->duty_cycle =3D state->period;
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	pm_runtime_put(chip->dev);
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device
> *pwm,
> +			      const struct pwm_state *state) {
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +	struct rz_mtu3_channel *ch;
> +	unsigned long pv, dc;
> +	u64 period_cycles;
> +	u64 duty_cycles;
> +	u32 ch_index;
> +	u8 prescale;
> +	u8 val;
> +
> +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> +	period_cycles =3D mul_u64_u32_div(state->period, rz_mtu3_pwm->rate,
> +					NSEC_PER_SEC);
> +	prescale =3D rz_mtu3_pwm_calculate_prescale(rz_mtu3_pwm, period_cycles)=
;
> +
> +	if (period_cycles >> (2 * prescale) <=3D U16_MAX)
> +		pv =3D period_cycles >> (2 * prescale);
> +	else
> +		pv =3D U16_MAX;
> +
> +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle, rz_mtu3_pwm->rate,
> +				      NSEC_PER_SEC);
> +	if (duty_cycles >> (2 * prescale) <=3D U16_MAX)
> +		dc =3D duty_cycles >> (2 * prescale);
> +	else
> +		dc =3D U16_MAX;
> +
> +	/*
> +	 * If the PWM channel is disabled, make sure to turn on the clock
> +	 * before writing the register.
> +	 */
> +	if (!pwm->state.enabled)
> +		pm_runtime_get_sync(chip->dev);
> +
> +	val =3D RZ_MTU3_TCR_CKEG_RISING | prescale;
> +	if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm)) {
> +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR,
> +				      RZ_MTU3_TCR_CCLR_TGRC | val);
> +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRD, dc);
> +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRC, pv);
> +	} else {
> +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR,
> +				      RZ_MTU3_TCR_CCLR_TGRA | val);
> +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRB, dc);
> +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRA, pv);
> +	}
> +
> +	/* If the PWM is not enabled, turn the clock off again to save power.
> */
> +	if (!pwm->state.enabled)
> +		pm_runtime_put(chip->dev);
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     const struct pwm_state *state)
> +{
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +	bool enabled =3D pwm->state.enabled;
> +	int ret;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (!state->enabled) {
> +		if (enabled)
> +			rz_mtu3_pwm_disable(rz_mtu3_pwm, pwm);
> +
> +		return 0;
> +	}
> +
> +	ret =3D rz_mtu3_pwm_config(chip, pwm, state);
> +	if (ret)
> +		return ret;
> +
> +	if (!enabled)
> +		ret =3D rz_mtu3_pwm_enable(rz_mtu3_pwm, pwm);
> +
> +	return ret;
> +}
> +
> +static const struct pwm_ops rz_mtu3_pwm_ops =3D {
> +	.request =3D rz_mtu3_pwm_request,
> +	.free =3D rz_mtu3_pwm_free,
> +	.get_state =3D rz_mtu3_pwm_get_state,
> +	.apply =3D rz_mtu3_pwm_apply,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int rz_mtu3_pwm_pm_runtime_suspend(struct device *dev) {
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(rz_mtu3_pwm->clk);
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_pwm_pm_runtime_resume(struct device *dev) {
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D dev_get_drvdata(dev);
> +
> +	return clk_prepare_enable(rz_mtu3_pwm->clk);
> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(rz_mtu3_pwm_pm_ops,
> +				 rz_mtu3_pwm_pm_runtime_suspend,
> +				 rz_mtu3_pwm_pm_runtime_resume, NULL);
> +
> +static void rz_mtu3_pwm_pm_disable(void *data) {
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D data;
> +
> +	clk_rate_exclusive_put(rz_mtu3_pwm->clk);
> +	pm_runtime_disable(rz_mtu3_pwm->chip.dev);
> +	pm_runtime_set_suspended(rz_mtu3_pwm->chip.dev);
> +}
> +
> +static int rz_mtu3_pwm_probe(struct platform_device *pdev) {
> +	struct rz_mtu3 *ddata =3D dev_get_drvdata(pdev->dev.parent);
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm;
> +	struct device *dev =3D &pdev->dev;
> +	int num_pwm_hw_ch =3D 0;
> +	unsigned int i;
> +	int ret;
> +
> +	rz_mtu3_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*rz_mtu3_pwm),
> GFP_KERNEL);
> +	if (!rz_mtu3_pwm)
> +		return -ENOMEM;
> +
> +	rz_mtu3_pwm->clk =3D ddata->clk;
> +
> +	for (i =3D 0; i < RZ_MTU_NUM_CHANNELS; i++) {
> +		if (i =3D=3D RZ_MTU5 || i =3D=3D RZ_MTU8)
> +			continue;
> +
> +		rz_mtu3_pwm->ch[num_pwm_hw_ch] =3D &ddata->channels[i];
> +		rz_mtu3_pwm->ch[num_pwm_hw_ch]->dev =3D dev;
> +		num_pwm_hw_ch++;
> +	}
> +
> +	mutex_init(&rz_mtu3_pwm->lock);
> +	platform_set_drvdata(pdev, rz_mtu3_pwm);
> +	ret =3D clk_prepare_enable(rz_mtu3_pwm->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Clock enable failed\n");
> +
> +	clk_rate_exclusive_get(rz_mtu3_pwm->clk);
> +
> +	rz_mtu3_pwm->rate =3D clk_get_rate(rz_mtu3_pwm->clk);
> +	/*
> +	 * Refuse clk rates > 1 GHz to prevent overflow later for computing
> +	 * period and duty cycle.
> +	 */
> +	if (rz_mtu3_pwm->rate > NSEC_PER_SEC) {
> +		ret =3D -EINVAL;
> +		clk_rate_exclusive_put(rz_mtu3_pwm->clk);
> +		goto disable_clock;
> +	}
> +
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	ret =3D devm_add_action_or_reset(&pdev->dev,
> +				       rz_mtu3_pwm_pm_disable,
> +				       rz_mtu3_pwm);
> +	if (ret < 0)
> +		goto disable_clock;
> +
> +	rz_mtu3_pwm->chip.dev =3D &pdev->dev;
> +	rz_mtu3_pwm->chip.ops =3D &rz_mtu3_pwm_ops;
> +	rz_mtu3_pwm->chip.npwm =3D RZ_MTU3_MAX_PWM_CHANNELS;
> +	ret =3D devm_pwmchip_add(&pdev->dev, &rz_mtu3_pwm->chip);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> +		goto disable_clock;
> +	}
> +
> +	return 0;
> +
> +disable_clock:
> +	clk_disable_unprepare(rz_mtu3_pwm->clk);
> +	return ret;
> +}
> +
> +static struct platform_driver rz_mtu3_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "pwm-rz-mtu3",
> +		.pm =3D pm_ptr(&rz_mtu3_pwm_pm_ops),
> +	},
> +	.probe =3D rz_mtu3_pwm_probe,
> +};
> +module_platform_driver(rz_mtu3_pwm_driver);
> +
> +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> +MODULE_ALIAS("platform:pwm-rz-mtu3");
> +MODULE_DESCRIPTION("Renesas RZ/G2L MTU3a PWM Timer Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.25.1

