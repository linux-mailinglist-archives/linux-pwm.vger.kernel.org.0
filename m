Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379BA6C6C8B
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Mar 2023 16:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjCWPtO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Mar 2023 11:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjCWPtN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Mar 2023 11:49:13 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2097.outbound.protection.outlook.com [40.107.114.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873FA30CA;
        Thu, 23 Mar 2023 08:49:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9XrvGrcRMjN0oXKOP5WXqcIqrHQjIbIG3PgYHFN/nKxOsPoR8Izrlnb9z4TUJ2Ztc3+xC2uKAmqA4jdukGE3Zvxd1pRoyh1TiR0cbEXraBaSHH43LBT56G6vlXLaJa3OtX7bU0Wdsx24TZsmpDZg+VZGaYUE7Nl8xYLPc9TyH2Lic8tzJF7Xmzge2VME7ltUYq67t/62TtHiQ8ymddoL2VyG/ikygQOOtY5SlMKkeMp6JSdhHNoDxaek5Bdwry5giQRYkXwnKb0ie9PxvzaRAU6eFFrwbDlo44/JySNYMDlOW2WKxfIiRD79NfLn0ItKurXGVNmks/5MzggVAXpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BG2WjuQCzp/JOtP9szjuONQcRNHLSKDU9tl46rY+tPU=;
 b=GvMrVwPPjBQnBu6Z0H5EvuyqwFf1Y+WRTfyrPymN7gXRodsJD+aD1lpMC13oL6d4JX+C/Iao82VBwd+5xfdt1nTis2dCOYJWFLBuTF1xgFoNt5SxGkjEtHNGBshF69b754L7bhA6ddE+S0hWvuAsNjT/jOFCk8ZcMh7SprN6OG0WpaU38b4YvzGAN8x50QQOtQuK3x4BhFyWTjg1YsV8/zP3lIEyhgXN5GF+zNjhyCwYtO1uFM31SOviD2LybdN3OXHlJEO2jRbbwsfSZ0UP6wDrsDkXCBNXlRgFDRYD0+iZsN/+TRpIgQsUOAbZtxnRHyWD3d4W/OeVy4vzURy8HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BG2WjuQCzp/JOtP9szjuONQcRNHLSKDU9tl46rY+tPU=;
 b=bMcqW/JicYoc5R9i3ikoSuqJ+LvPP3EmGq1zjTO8hHJpzqYjiqd6U6EtAoGefljTfs//nZtt4A4yoWNs2weRtV6o8Vm69RHk15j08K6+c3fU+i7tEkpBxjIlcZkQDrGsdFJhuAWUpO+3QSdJPnt5uBb9UDYbeQ4+/whVLoRTDRY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8454.jpnprd01.prod.outlook.com (2603:1096:400:158::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 15:49:01 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f54c:4b2:9c7d:f207]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f54c:4b2:9c7d:f207%8]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 15:48:59 +0000
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
Subject: RE: [PATCH v14 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Topic: [PATCH v14 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Index: AQHZU3LMHTd9Hvc0bUWzblzJbkvYRK8IlomQ
Date:   Thu, 23 Mar 2023 15:48:59 +0000
Message-ID: <OS0PR01MB5922FCB77CFF0D56E68557F486879@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230310170654.268047-1-biju.das.jz@bp.renesas.com>
 <20230310170654.268047-7-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230310170654.268047-7-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB8454:EE_
x-ms-office365-filtering-correlation-id: 5c4801a0-406d-4031-4f4e-08db2bb61e2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8gV0wCHT37YF5M638tSQN/IbMPkkev2UaXqX40GXuFXGCNFdGGx6iKvhrFBgnNbdv1A53yB51f0ymYphjDVco46gYY5gr1+Cd2zE2lPh5T/CNrJmjRZQlu7DXu72WGMko2ghD6q2ewxTJBsvt3ZRr66lJVaSVQT4V86GDimVXVhUEPBJiB2OBHIXuCgv5eYXnxGXBx2ulQLpdIleCb4Z2gre2BF77+dJikhf03C+azPX9vYdS3IW85r2na+WYyNhfvaUcQ0uLQKhn1yFnMvFrkPZ6CaQiMpbvfPdvefSN+JX2lKhZq8YcYiFw2fzW5gM1ycjt6m0GD8vrTSNWRkmTTz0BUrM/7LY6qdc7N6l7fWXuW5HYmUz+a/tfxHkLx47Gi8kcJ+2oWSNC/t3li6MtEgxWmHRKjkXPGnPkJ/X6vCtU44ttn5j4+ApFAh028V9WuwlUiVAzOe50CEclDNFLZHshT4rD7It8SwSquuI58pV8OwsYb/w9wNyQ2cUJCMsDM16MqkAa+nduQF5meaZZsZs4oJckAbGOUMjtUzJv9HFqoCbsAOr7mPqhMfPGfQTbu2/Ianv6N1jqwDm0USDBgf6zFwyFbX2dqrF8PeaQQSRfYmCitWmXVoehGXyG5MkDQwV+HP/uew6zUHM9dFLExoAPe2lqS9N13sFI8Pe4U0BJv6XUU2KXbnZ5IHFmedLr6wNhhJBi5JqMMnwhVCIhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199018)(33656002)(8676002)(86362001)(4326008)(66946007)(66556008)(66446008)(64756008)(8936002)(66476007)(52536014)(76116006)(41300700001)(71200400001)(7696005)(316002)(478600001)(54906003)(110136005)(5660300002)(2906002)(30864003)(38070700005)(55016003)(26005)(38100700002)(53546011)(9686003)(6506007)(122000001)(186003)(66574015)(83380400001)(32563001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OALylhK2OO8yoy9SDlu6VgrE79wpoNTNiHhgrvsn/QaRyC9BS88/CnVDag?=
 =?iso-8859-1?Q?4YBfwQyqko4gmJO5cfV5KYl6YT679fcBWLr7lcuwtwhHzM+2ETyXCYpNGt?=
 =?iso-8859-1?Q?P/WM/ZipHlgBm0pJgKNw9Dq5HI9/4CctCdayERq8NI4/d0mlaConhMKYEx?=
 =?iso-8859-1?Q?A6Wq1W2L4/2UDm2hItKfiXa/kbLkspbZolGbI6zYxWelHjbs4l4PFvrXXL?=
 =?iso-8859-1?Q?/J9GCxPbNjn7texI57VRQPdUWq8IdoGRqSBnFpMEZmBP+HprESGiZMp/HI?=
 =?iso-8859-1?Q?W9FyfWjoaIA7CWzMy22kfaAGO/Ra/mR159+WtoCltKN4z219bvevJiT1Mh?=
 =?iso-8859-1?Q?/kwNVQvefaWSgyRTJQRFi3DfxARPyM7Aw9ITPgiSdHG5W6aTeXISAc3tor?=
 =?iso-8859-1?Q?PlYH05rfE3UKNXR4MzyxcLbB4iDhsTWSz3/QWu3elxgMRwgpD8RBIWXOzm?=
 =?iso-8859-1?Q?KyC9BXBIE6lcD5557p9Nf4+/qA3mhgFgYw+IAstpgmzPh4/DnuZhTGellN?=
 =?iso-8859-1?Q?kwIQZ0Q3lX4G9+pnjS1ptNY4qhirI1LUvoOk1u7B2W3YR2/4LchuBmznNb?=
 =?iso-8859-1?Q?5zAzH9hCWw0hUIRzMA0kBcYmVT4tHDNLNzPF1/Yj8fWXKdrJSeL6Lz01Q9?=
 =?iso-8859-1?Q?dEzRpYF3WLd9neTvdi3HDtsVZUe4b4bqZ0xsKB0MGlGnu2jARTobSrdSno?=
 =?iso-8859-1?Q?i9sjHaFSjWAI2hP4MngOFZGsItCygqJrrnk2d6DHgU21/QoMB2loglwly0?=
 =?iso-8859-1?Q?O650E/H6roMQ5QoSDRTVzqEIUjZYqRncmd4guZ74dFGC5Smc13TirCdoEK?=
 =?iso-8859-1?Q?Du1tl3r9rNanZd0llVrMAhYbNuhlnZNeGCVEO7VNXYfGJxVLvhALr7ox7X?=
 =?iso-8859-1?Q?ofoplBzr41H8RNbPEm1D+dNbm751RWBmPHCKSLDy1L38nnOGc4tMdBokQo?=
 =?iso-8859-1?Q?meHiTirJ1d3otV8VUD+noC556R35ElRVv5O0bw2m0bqCLVBvk/tT2f0ug0?=
 =?iso-8859-1?Q?f5hBjZSwk+NnHIJ8wDAS/8ZaTvgRmCRaDEnerBp30CHA3KW47zjwQh9MGg?=
 =?iso-8859-1?Q?wBEQ3KreZV5TWYbZNJ6ineLJz2pnqxmdBw1ZDGx5hT4cImFL2xjuS6cyZV?=
 =?iso-8859-1?Q?nnfy4gbEmQ6VkMUUCK6GY8dlKMivVhe1KOUkyVwZxknpmi/C3ad0RzTpnm?=
 =?iso-8859-1?Q?dfmy95UCPnAWv3f9btL7WsTy5TK5UaYdMx8p6/J1RNNRIeHp/7NwKcYmnC?=
 =?iso-8859-1?Q?2n32LOIHqCLwBxW8Lq/myYc8LM8XLBkEGjINMRBZJja+mU+Mf8ZDl4/bYg?=
 =?iso-8859-1?Q?XQ32hL5NGSjjfoRAdN3yDw1EHGoFOb3b0di/MT/V8fEJJXcBGK+h+NZeYl?=
 =?iso-8859-1?Q?V8Lgf/Es8AZQ1TyunpNECyAFf0RQZGgfs1HlopN818teyLSsCpE+CGCeqi?=
 =?iso-8859-1?Q?YPQ8UYDpyiF1hPCPvj/NQhuaJt2pEut+30kGenkxVqgrVolZ5hNiBqniqB?=
 =?iso-8859-1?Q?6mWif4toUOwQVVr0IyDYdThOCSyGhDzIA7x/qJyMqCJtZqxNyC/AHunC3K?=
 =?iso-8859-1?Q?3tF4nVKWlkTISnYyhYMEQL+2zBXyKJodOkthr5vCOPecCTEffdWdpIsT75?=
 =?iso-8859-1?Q?rQXruk1UVG4EoNTIz91GYmHF3KUCCnsRmv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4801a0-406d-4031-4f4e-08db2bb61e2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 15:48:59.2785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kr1hHUh7h+H06B7rkGP4tUX+EjLvHjiVeMIWLuv44pOakLIzy3J5oFH3oH09Lvap0n9Dy9LDMDrA3CSP3jPMX4QQ4jSEKc6B328cJ8szvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8454
X-Spam-Status: No, score=1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry and Uwe,

Gentle ping

Cheers,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Friday, March 10, 2023 5:07 PM
> To: Thierry Reding <thierry.reding@gmail.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Uwe Kleine-K=F6nig <u.kleine-
> koenig@pengutronix.de>; linux-pwm@vger.kernel.org; Lee Jones
> <lee@kernel.org>; Daniel Lezcano <daniel.lezcano@linaro.org>; William
> Breathitt Gray <william.gray@linaro.org>; Geert Uytterhoeven
> <geert+renesas@glider.be>; Chris Paterson <Chris.Paterson2@renesas.com>;
> Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; linux-
> renesas-soc@vger.kernel.org
> Subject: [PATCH v14 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
>=20
> The RZ/G2L Multi-Function Timer Pulse Unit 3 (a.k.a MTU3a) uses one count=
er
> and two match components to configure duty_cycle and period to generate P=
WM
> output waveform.
>=20
> Add basic support for RZ/G2L MTU3a PWM driver by creating separate PWM
> channels for each IOs.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v13->v14:
>  * Updated commit description
>  * Updated Limitations section.
>  * Replaced the macros RZ_MTU*->RZ_MTU3_CHAN_* in probe()
>  * Fixed a kernel crash in error path by moving rz_mtu3_pwm->chip.dev bef=
ore
>    devm_add_action_or_reset()
>  * Added pm_runtime_idle() and simplified error paths for
> devm_add_action_or_reset()
>    and devm_pwmchip_add().
>=20
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
>  drivers/pwm/pwm-rz-mtu3.c | 482 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 494 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rz-mtu3.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> dae023d783a2..ccc0299fd0dd 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -481,6 +481,17 @@ config PWM_ROCKCHIP
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
> 7bf1a29f02b8..b85fc9fba326 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-raspberrypi-
> poe.o
>  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> +obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c new fi=
le
> mode 100644 index 000000000000..146948656755
> --- /dev/null
> +++ b/drivers/pwm/pwm-rz-mtu3.c
> @@ -0,0 +1,482 @@
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
> + *   operations(The channels are MTU{0..4, 6, 7}).
> + * - MTU{1, 2} channels have a single IO, whereas all other HW channels
> have
> + *   2 IOs.
> + * - Each IO is modelled as an independent PWM channel.
> + * - rz_mtu3_hw_channel_ios table is used to map the PWM channel to the
> + *   corresponding HW channel as there are difference in number of IOs
> + *   between HW channels.
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
> +/* The table represents the number of IOs on each MTU HW channel. */
> +static const u8 rz_mtu3_hw_channel_ios[] =3D { 2, 1, 1, 2, 2, 2, 2 };
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
> +		if (i =3D=3D RZ_MTU3_CHAN_5 || i =3D=3D RZ_MTU3_CHAN_8)
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
> +	rz_mtu3_pwm->chip.dev =3D &pdev->dev;
> +	ret =3D devm_add_action_or_reset(&pdev->dev,
> +				       rz_mtu3_pwm_pm_disable,
> +				       rz_mtu3_pwm);
> +	if (ret < 0)
> +		return ret;
> +
> +	rz_mtu3_pwm->chip.ops =3D &rz_mtu3_pwm_ops;
> +	rz_mtu3_pwm->chip.npwm =3D RZ_MTU3_MAX_PWM_CHANNELS;
> +	ret =3D devm_pwmchip_add(&pdev->dev, &rz_mtu3_pwm->chip);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to add PWM
> chip\n");
> +
> +	pm_runtime_idle(&pdev->dev);
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

