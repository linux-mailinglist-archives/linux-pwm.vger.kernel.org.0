Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4F66CF13F
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Mar 2023 19:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjC2Rk3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Mar 2023 13:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjC2Rk2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 Mar 2023 13:40:28 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2122.outbound.protection.outlook.com [40.107.113.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DC046AD;
        Wed, 29 Mar 2023 10:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ylsp4ajg3kOitKxwGUnGgQHiK/vKAQCsCU3b1sydxX2zVsYiqUvjycugnY2qBdN4U64Fr9APUOHAGaIY7cicKC/4f9NMvHXWbyr/PjLvj8mNpMXHXB3/0mAISd8Bqb0EZcU9uBIuI3dmfmwBAsJRqv589rryvi9je2p4E7zUJ3RKGPwchqjkg1YOgbDclgikkDAquxVAIerEC/yQCX78A3IORx9QTd6zZyXM8WoBOh3TCBu/EMh6yBrtw8/5Y+TO57MYGX/TUJIX0ihuprvS+N4QKvM0HQameX+n0u5M53I2EHaAT9ARR9M+Wxd3w+YAyy9IYnGihwsUcJGz6bHbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBaCpI/rhT5FBz9wQ19jmKISsfzlsgpMjoKn2cj5s1Y=;
 b=FJUeH1UNR6ifidrgHJvJwBNIq1oFKMGOxluSbE2pA85s+ooGw0JKVGElaoMuJBRya5XBs7kO2KhC3UYTsNyqLDLIZCzBTNw7x3p3xc2UWYqkT2duvjIiDxosrgMO7ZdQJ2s/zcWrMxKO8k0AS4fNz1qlXP3eQbEMThi7ifuY6g6Z2mJqfRaKdAzef5h/2GKqWM93mNsQe5E4v1GoIjZ+1921kH02Fg4/QUPIRxcwY9W3SlECu07dCcj4hJ9x+edZBf/W4Y4AzZoB5v9fXeu7M0DA+mLAunlsHWTnfUnEmWkEl56s1cb3wGMLUVeFsPcZa1LUIoHAQ+umoTyVGFHKxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBaCpI/rhT5FBz9wQ19jmKISsfzlsgpMjoKn2cj5s1Y=;
 b=pa/4HXWMXty1fkC7PC38YLKLocsBxcCih7/bRwKKADaMsWJ5Sm96em1MJKfZPW9SG59MSx2JwgfTPZsFvWf7LJGnb3m5yUdCXIdqF18ZI84Ev4qwDQTnPXvCVISjuF43b0t0sxdWbhewxA5Xz1SeHY+a73UI58r5h7m/amGtwmY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB11609.jpnprd01.prod.outlook.com (2603:1096:400:373::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Wed, 29 Mar
 2023 17:40:19 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::e521:994c:bb0e:9bf6]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::e521:994c:bb0e:9bf6%8]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 17:40:17 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
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
Thread-Index: AQHZU3LMHTd9Hvc0bUWzblzJbkvYRK8PMbMAgALss3A=
Date:   Wed, 29 Mar 2023 17:40:17 +0000
Message-ID: <OS0PR01MB5922B1D75AF03CA851572AB586899@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230310170654.268047-1-biju.das.jz@bp.renesas.com>
 <20230310170654.268047-7-biju.das.jz@bp.renesas.com>
 <20230327204000.x67sybfbp34udwfg@pengutronix.de>
In-Reply-To: <20230327204000.x67sybfbp34udwfg@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB11609:EE_
x-ms-office365-filtering-correlation-id: 9f7a6c6f-d9ec-4c49-e5a1-08db307ca95c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hKjPUBOmSaKPS7riOi4sVhaY3SX2AH+pe3iegOBb/uIBcbzwietHhww+8mLQF7ERW7pog0ciczmFeoygxXq1twEpgsiDL6008/RQW5jhMMGzzaT6xBnD5qmllSMJO7OoV5DJUeouU+NaP9GCzyc9uby7XrYtwqEdny5OEdCIWL4R8JGDHqBFhjuydOpzc2T/gvdHY1bOhpLWBLNclfOIDIimxNNqN+5At9PVF+S+r5IQsfUGNwfovMqIxIChWqSPe2gem+tYBSit2016M5s36vZRFAqoXa/mq/VAluGFnb9WfI4bTt2OgDJswT6BrBC3/CAHrzThGavylWOCr0qVMhH/7rpgijmLluiMBG3cUBu40LiZ3egCQvq71GTeZJg5fDtNiqCNrJbd4XsaonRWFK6rJ6BKkPLpGhEO0Xj/Y6gJZkF331U5ei58mwjQq249IVD3vUElJFzQu3CSQq056Kxzs2h8Zp48QkCyIUIFrX5G4DLD+p5tCN8tx1jmbsv1e1NRaD3lnIH2Pxnl0+VNuhORZw7rqVBdNqdY3hUnq0vCmumRKz+wRwk+8aboWErDNlBD6tIQmn1N9oUFxcYo9VJKuOHcOdSQ49z10/jmqlL25vnYxFKTrzQitP8eGXbK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(83380400001)(66574015)(33656002)(86362001)(122000001)(4326008)(6916009)(30864003)(5660300002)(8936002)(38070700005)(64756008)(66446008)(66476007)(38100700002)(76116006)(66556008)(41300700001)(52536014)(66946007)(8676002)(55016003)(966005)(26005)(9686003)(6506007)(54906003)(2906002)(7696005)(71200400001)(478600001)(316002)(186003)(32563001)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QKNCCHhDzV3U5eao0/TREGMUF0KmNeZjtSLNndslhDkLiMIq+oEE6wYpnW?=
 =?iso-8859-1?Q?Qrgnuz+eCyfGczxPRCY5rFt8X8++AgkL6hZ1PeWb5Zdd5QnV+jB4n6Xbbo?=
 =?iso-8859-1?Q?tgVGADQEbv8fYwHDxM43LTjy1YAfk3tygEBmQemtOa7VHemINiwOn7msXm?=
 =?iso-8859-1?Q?JHHwsQ3p7WvxVtoFuGNaZ+d3Y4P9Ox/FrgQGf8oQOHithEavXRKs14tQ+y?=
 =?iso-8859-1?Q?b9fxn1BfDnNbEichYBz/CJhgOMwXXVm8NaeI2u6bhMubaTXwYcBM8EgPvw?=
 =?iso-8859-1?Q?8m3BK/GmaOxoMl2uO2lZ3HNgwx/YPSZlk8/2CzLHsu60Fxw2IYSenpnVGP?=
 =?iso-8859-1?Q?WaC+9hmtEOk0cTzccAwsMSov6i6A3uwOCKqspYFkkKfrrrzzA+vMqzPenE?=
 =?iso-8859-1?Q?h4+1BIBdXgnWIa08rKWVhFogUjbD7RjuE88xVxCKKu0fOxDJXvZBupBGKg?=
 =?iso-8859-1?Q?iV1D5/ZNwnAcaTYZBEPoQfwQf6inTc9H/8BRQ0maRBU5OWpJ0sjogZpIsQ?=
 =?iso-8859-1?Q?L8lvMyngpZFWKT5s67by2kDlqVuiV18UoaoOFj3U8TmDEtfrcYB7gDJUSx?=
 =?iso-8859-1?Q?nq6VXODGxNjjc+f/LSR4foCWTNHqwjk/Wu0EZ56ZQoa0VDxhxSbrD4tmjK?=
 =?iso-8859-1?Q?bJQMh1GzvuEy4e4m6AdslAau+Q230vE2htCWabm9K2XYf5IbP7AVwiYRoI?=
 =?iso-8859-1?Q?NooPP2CXICHWzIJQN022YDxxI+eVxmGVsUlRhRtK6frMtMAoXksHGm3jp/?=
 =?iso-8859-1?Q?LeINwIzVMC/SjcV4JqvBPJUQpejLC2Ls3S6hThlxvdreHVWkqzs+N/8JHc?=
 =?iso-8859-1?Q?Zn0GU0xyGqgR6ZmclBywL8Q0SCdBQRPSYfMcYSWuhogDjkBBJ82na2IHRT?=
 =?iso-8859-1?Q?Dc4vrh2y6FhrVubxioWYhbNXAPeXZlKQSF/K4f4nGpSWtJCeXo+PI7nNxq?=
 =?iso-8859-1?Q?GlXSRoeAgWEPii4l0YxcSjXb8KKWomDzFDGQhP3Fi7JpH5ff2WPmK5teIT?=
 =?iso-8859-1?Q?iMzTDZMviBHvf/jEv1mSrbZ1rRXE3qd8IZ/W+LWu2vJy9FVQrgWhqc3kb/?=
 =?iso-8859-1?Q?AHF6fTQM9DXvHBRcRX4ejhit6Ojy3YJwKwtIwi9ZLFZz2deIomkk9LtcWJ?=
 =?iso-8859-1?Q?WsubZDme48hxgP4NVSRugM8W3mIsx9AhJkAOHdXPOwRL1RzylpduL86laJ?=
 =?iso-8859-1?Q?EIHAoB+ZMbUdkrMAPb0oVEcVNgCg6fN/1fnVuKQVtQEVkSFzH521GzUhO+?=
 =?iso-8859-1?Q?80vKdM8Yv3pYW9SjwwhfawcR7gHFOT4oFtGSeOxsjOxwDM+i5/0FEAosXS?=
 =?iso-8859-1?Q?gU9W31rO9TS9PIN2pDFiyMK2l4JSMm07dlJlyMdwmwioQ1D7c1Fbaktaxo?=
 =?iso-8859-1?Q?D/qDml6HDI1juyGCd4VocqY+LpMqmVfRnaej3JoWWmOM+PWSVP6h6DOhZl?=
 =?iso-8859-1?Q?PuSV/F+8TTYLgZ2ZjmaYxNtaqFGz4F90ZotVlorKw8LpoduDWUyszBA7PN?=
 =?iso-8859-1?Q?82IqaoQlje//JgdUrzDrp9ewvm3n4XTHw2SMfbs7gTLc8DPaJgFB54juXH?=
 =?iso-8859-1?Q?OAAotOfnIWH+RC2Y0iIaJ9yhG7ksAHM2DrYe3TUYRsWD4PQsSpeGaqQBvY?=
 =?iso-8859-1?Q?WvafTtRk8uZ0eUcy8cXC1KvhnbAx/k3Xu2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7a6c6f-d9ec-4c49-e5a1-08db307ca95c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 17:40:17.8481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aztz7hpvXFwNn5lXQgrFin2iytq1tsyZTimkNwGHtQsEiPSJik+KMS6UXmBdqOdmdhl0wXL8UHCeC129Yy5KlzC9LTX2AaS6GRZEgl2Pu88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11609
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for the feedback.

> Subject: Re: [PATCH v14 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
>=20
> Hello,
>=20
> I have the feeling this driver is more complicated than necessary.

I agree, your suggestions made it less complex.

>=20
> On Fri, Mar 10, 2023 at 05:06:54PM +0000, Biju Das wrote:
> > The RZ/G2L Multi-Function Timer Pulse Unit 3 (a.k.a MTU3a) uses one
> > counter and two match components to configure duty_cycle and period to
> > generate PWM output waveform.
> >
> > Add basic support for RZ/G2L MTU3a PWM driver by creating separate PWM
> > channels for each IOs.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v13->v14:
> >  * Updated commit description
> >  * Updated Limitations section.
> >  * Replaced the macros RZ_MTU*->RZ_MTU3_CHAN_* in probe()
> >  * Fixed a kernel crash in error path by moving rz_mtu3_pwm->chip.dev
> before
> >    devm_add_action_or_reset()
> >  * Added pm_runtime_idle() and simplified error paths for
> devm_add_action_or_reset()
> >    and devm_pwmchip_add().
> >
> > v12->v13:
> >  * Updated commit description
> >  * Moved RZ_MTU3_TMDR1_MD_* macros to rz_mtu3.h
> >  * Updated Limitations section.
> >  * Removed PWM mode1 references from the driver.
> >  * Dropped prescale and duty_cycle from struct rz_mtu3_pwm_chip.
> >  * Replaced rz_mtu3_pwm_mode1_num_ios->rz_mtu3_hw_channel_ios.
> >  * Avoided race condition in rz_mtu3_pwm_request()/rz_mtu3_pwm_free().
> >  * Updated get_state() by adding dc > pv check and added a comment abou=
t
> >    overflow condition.
> >  * Moved overflow condition check from config->probe()
> >  * Replaced pm_runtime_resume_and_get with unconditional
> pm_runtime_get_sync()
> >    in config()
> >  * Added error check for clk_prepare_enable() in probe() and propagatin=
g
> error
> >    to the caller for pm_runtime_resume()
> >  * clk_get_rate() is called after enabling the clock and
> > clk_rate_exclusive_put()
> > v11->v12:
> >  * Updated header file to <linux/mfd/rz-mtu3.h> as core driver is in MF=
D.
> >  * Reordered get_state()
> > v10->v11:
> >  * No change.
> > v9->v10:
> >  * No change.
> > v8->v9:
> >  * Added prescale/duty_cycle variables to struct rz_mtu3_pwm_chip and
> >    cached this values in rz_mtu3_pwm_config and used this cached values
> >    in get_state(), if PWM is disabled.
> >  * Added return code for get_state()
> > v7->v8:
> >  * Simplified rz_mtu3_pwm_request by calling rz_mtu3_request_channel()
> >  * Simplified rz_mtu3_pwm_free by calling rz_mtu3_release_channel()
> > v6->v7:
> >  * Added channel specific mutex lock to avoid race between counter
> >    device and rz_mtu3_pwm_{request,free}
> >  * Added pm_runtime_resume_and_get in rz_mtu3_pwm_enable()
> >  * Added pm_runtime_put_sync in rz_mtu3_pwm_disable()
> >  * Updated rz_mtu3_pwm_config()
> >  * Updated rz_mtu3_pwm_apply()
> > v5->v6:
> >  * Updated commit and Kconfig description
> >  * Sorted the header
> >  * Replaced dev_get_drvdata from rz_mtu3_pwm_pm_disable()
> >  * Replaced SET_RUNTIME_PM_OPS->DEFINE_RUNTIME_DEV_PM_OPS and removed
> >    __maybe_unused from suspend/resume()
> > v4->v5:
> >  * pwm device is instantiated by mtu3a core driver.
> > v3->v4:
> >  * There is no resource associated with "rz-mtu3-pwm" compatible
> >    and moved the code to mfd subsystem as it binds against "rz-mtu".
> >  * Removed struct platform_driver rz_mtu3_pwm_driver.
> > v2->v3:
> >  * No change.
> > v1->v2:
> >  * Modelled as a single PWM device handling multiple channles.
> >  * Used PM framework to manage the clocks.
> > ---
> >  drivers/pwm/Kconfig       |  11 +
> >  drivers/pwm/Makefile      |   1 +
> >  drivers/pwm/pwm-rz-mtu3.c | 482
> > ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 494 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-rz-mtu3.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> > dae023d783a2..ccc0299fd0dd 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -481,6 +481,17 @@ config PWM_ROCKCHIP
> >  	  Generic PWM framework driver for the PWM controller found on
> >  	  Rockchip SoCs.
> >
> > +config PWM_RZ_MTU3
> > +	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
> > +	depends on RZ_MTU3 || COMPILE_TEST
> > +	depends on HAS_IOMEM
> > +	help
> > +	  This driver exposes the MTU3a PWM Timer controller found in Renesas
> > +	  RZ/G2L like chips through the PWM API.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called pwm-rz-mtu3.
> > +
> >  config PWM_SAMSUNG
> >  	tristate "Samsung PWM support"
> >  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS ||
> > COMPILE_TEST diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 7bf1a29f02b8..b85fc9fba326 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -44,6 +44,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-raspberryp=
i-
> poe.o
> >  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
> >  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
> >  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> > +obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o
> >  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
> >  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> >  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> > diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c new
> > file mode 100644 index 000000000000..146948656755
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-rz-mtu3.c
> > @@ -0,0 +1,482 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Renesas RZ/G2L MTU3a PWM Timer driver
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corporation
>=20
> 2023?
OK.

>=20
> > + *
> > + * Hardware manual for this IP can be found here
> > + *
> > + https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-
> > + users-manual-hardware-0?language=3Den
> > + *
> > + * Limitations:
> > + * - When PWM is disabled, the output is driven to Hi-Z.
> > + * - While the hardware supports both polarities, the driver (for now)
> > + *   only handles normal polarity.
> > + * - HW uses one counter and two match components to configure duty_cy=
cle
> > + *   and period.
> > + * - Multi-Function Timer Pulse Unit(a.k.a MTU) has 7 HW channels for
> > + PWM
>=20
> s/t(/t (/
Done.
>=20
> > + *   operations(The channels are MTU{0..4, 6, 7}).
>=20
> s/s(/s. (/; s/)./.)/
Done.

>=20
> > + * - MTU{1, 2} channels have a single IO, whereas all other HW channel=
s
> have
> > + *   2 IOs.
> > + * - Each IO is modelled as an independent PWM channel.
> > + * - rz_mtu3_hw_channel_ios table is used to map the PWM channel to th=
e
> > + *   corresponding HW channel as there are difference in number of IOs
> > + *   between HW channels.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/limits.h>
> > +#include <linux/mfd/rz-mtu3.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/pwm.h>
> > +#include <linux/time.h>
> > +
> > +#define RZ_MTU3_TIOR_OC_RETAIN		(0)
> > +#define RZ_MTU3_TIOR_OC_0_H_COMP_MATCH	(2)
> > +#define RZ_MTU3_TIOR_OC_1_TOGGLE	(7)
> > +#define RZ_MTU3_TIOR_OC_IOA		GENMASK(3, 0)
> > +
> > +#define RZ_MTU3_TCR_CCLR_TGRC		(5 << 5)
> > +#define RZ_MTU3_TCR_CKEG_RISING		(0 << 3)
> > +
> > +#define RZ_MTU3_TCR_TPCS		GENMASK(2, 0)
>=20
> I assume the other register definitions are in <linux/mfd/rz-mtu3.h>, I
> suggest to move these there, too.

Yep moved the definitions.

/* Macros for setting registers */
+#define RZ_MTU3_TCR_CCLR       GENMASK(7, 5)
+#define RZ_MTU3_TCR_CKEG       GENMASK(4, 3)
+#define RZ_MTU3_TCR_TPCS       GENMASK(2, 0)
 #define RZ_MTU3_TCR_CCLR_TGRA  BIT(5)
+#define RZ_MTU3_TCR_CCLR_TGRC  FIELD_PREP(RZ_MTU3_TCR_CCLR, 5)
+#define RZ_MTU3_TCR_CKEG_RISING        FIELD_PREP(RZ_MTU3_TCR_CKEG, 0)
+
+#define RZ_MTU3_TIOR_IOB                       GENMASK(7, 4)
+#define RZ_MTU3_TIOR_IOA                       GENMASK(3, 0)
+#define RZ_MTU3_TIOR_OC_RETAIN                 (0)
+#define RZ_MTU3_TIOR_OC_INIT_OUT_LO_HI_OUT             (2)
+#define RZ_MTU3_TIOR_OC_INIT_OUT_HI_TOGGLE_OUT (7)
+
+#define RZ_MTU3_TIOR_OC_IOA_H_COMP_MATCH \
+       FIELD_PREP(RZ_MTU3_TIOR_IOA, RZ_MTU3_TIOR_OC_INIT_OUT_LO_HI_OUT)
+#define RZ_MTU3_TIOR_OC_IOB_TOGGLE \
+       FIELD_PREP(RZ_MTU3_TIOR_IOB, RZ_MTU3_TIOR_OC_INIT_OUT_HI_TOGGLE_OUT=
)

>=20
> > +
> > +#define RZ_MTU3_MAX_PWM_CHANNELS	(12)
> > +
> > +#define RZ_MTU3_MAX_HW_CHANNELS	(7)
> > +
> > +/* The table represents the number of IOs on each MTU HW channel. */
> > +static const u8 rz_mtu3_hw_channel_ios[] =3D { 2, 1, 1, 2, 2, 2, 2 };
>=20
> OK, so you have twelve PWM outputs, each one is driven by a "channel".
> Each channel drives one or two PWMs according to the above array, right?

Yes that is correct.

Now as per your suggestion, it is mapped differently.

+/**
+ * struct rz_mtu3_channel_io_map - MTU3 channel io map
+ *
+ * @pwm_index: Index of the lowest pwm channel
+ * @num: number of IOs on the channel.
+ */
+
+struct rz_mtu3_channel_io_map {
+       u8 pwm_index;
+       u8 num;
+};
+
+static const struct rz_mtu3_channel_io_map channel_map[] =3D
+       { { 0, 2 }, { 2, 1 }, { 3, 1 }, { 4 , 2 }, { 6 ,2 } , { 8, 2 }, { 1=
0, 2 } };


>=20
> > +
> > +/**
> > + * struct rz_mtu3_pwm_chip - MTU3 pwm private data
> > + *
> > + * @chip: MTU3 pwm chip data
> > + * @clk: MTU3 module clock
> > + * @lock: Lock to prevent concurrent access for usage count
> > + * @rate: MTU3 clock rate
> > + * @user_count: MTU3 usage count
> > + * @rz_mtu3_channel: HW channels for the PWM  */
> > +
> > +struct rz_mtu3_pwm_chip {
> > +	struct pwm_chip chip;
> > +	struct clk *clk;
> > +	struct mutex lock;
> > +	unsigned long rate;
> > +	u32 user_count[RZ_MTU3_MAX_HW_CHANNELS];
> > +	struct rz_mtu3_channel *ch[RZ_MTU3_MAX_HW_CHANNELS]; };
> > +
> > +static inline struct rz_mtu3_pwm_chip *to_rz_mtu3_pwm_chip(struct
> > +pwm_chip *chip) {
> > +	return container_of(chip, struct rz_mtu3_pwm_chip, chip); }
> > +
> > +static u8 rz_mtu3_pwm_calculate_prescale(struct rz_mtu3_pwm_chip
> *rz_mtu3,
> > +					 u64 period_cycles)
> > +{
> > +	u32 prescaled_period_cycles;
> > +	u8 prescale;
> > +
> > +	prescaled_period_cycles =3D period_cycles >> 16;
> > +	if (prescaled_period_cycles >=3D 16)
> > +		prescale =3D 3;
> > +	else
> > +		prescale =3D (fls(prescaled_period_cycles) + 1) / 2;
> > +
> > +	return prescale;
> > +}
> > +
> > +static struct rz_mtu3_channel *
> > +rz_mtu3_get_hw_channel(struct rz_mtu3_pwm_chip *rz_mtu3_pwm, u32
> > +channel) {
> > +	unsigned int i, ch_index =3D 0;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(rz_mtu3_hw_channel_ios); i++) {
> > +		ch_index +=3D rz_mtu3_hw_channel_ios[i];
> > +
> > +		if (ch_index > channel)
> > +			break;
> > +	}
> > +
> > +	return rz_mtu3_pwm->ch[i];
> > +}
>=20
> This function determines the channel that drives pwm $channel. Maybe pick
> more sensible names? Something like "hwpwm" instead of "channel"
> and "channel" instead of "hw_channel" (and "ch"). I think the driver woul=
d
> be easier to understand if the naming was used in a consistent way.

OK.

>=20
> > +static u32 rz_mtu3_get_hw_channel_index(struct rz_mtu3_pwm_chip
> *rz_mtu3_pwm,
> > +					struct rz_mtu3_channel *ch)
> > +{
> > +	u32 i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(rz_mtu3_hw_channel_ios); i++) {
> > +		if (ch =3D=3D rz_mtu3_pwm->ch[i])
> > +			break;
> > +	}
> > +
> > +	return i;
> > +}
>=20
> This is a complicated way to express
>=20
> 	ch - rz_mtu3_pwm->ch
>=20
> isn't it?

Agreed.

>=20
> > +
> > +static bool rz_mtu3_pwm_is_second_channel(u32 ch_index, u32 hwpwm) {
> > +	u32 i, pwm_ch_index =3D 0;
> > +
> > +	for (i =3D 0; i < ch_index; i++)
> > +		pwm_ch_index +=3D rz_mtu3_hw_channel_ios[i];
> > +
> > +	return pwm_ch_index !=3D hwpwm;
> > +}
>=20
> I think the three functions above could be simplified (or not needed) if =
you
> represent the channel -> pwm mapping in a different way.
>=20
> I'd do something like:
>=20
> 	ch =3D rz_mtu3_pwm_get_channel(..., hwpwm);
>=20
> and in *ch store the index of the lowest PWM and the number of PWMs handl=
ed
> by this channel.

Agreed defined below structure to take care this.

+/**
+ * struct rz_mtu3_pwm_channel - MTU3 pwm channel
+ *
+ * @rz_mtu3_channel: HW channel for the PWM
+ * @pwm_index: Index of the pwm channel
+ * @num: number of IOs on the channel.
+ */
+struct rz_mtu3_pwm_channel {
+       struct rz_mtu3_channel *mtu;
+       u8 pwm_index;
+       u8 num;
+};

@@ -67,9 +67,26 @@ struct rz_mtu3_pwm_chip {
        struct mutex lock;
        unsigned long rate;
        u32 user_count[RZ_MTU3_MAX_HW_CHANNELS];
-       struct rz_mtu3_channel *ch[RZ_MTU3_MAX_HW_CHANNELS];
+       struct rz_mtu3_pwm_channel channel[RZ_MTU3_MAX_HW_CHANNELS];
 };

static struct rz_mtu3_pwm_channel *
+rz_mtu3_get_channel(struct rz_mtu3_pwm_chip *rz_mtu3_pwm, u32 hwpwm)
 {
+       unsigned int i;
+       for (i =3D 0; i < RZ_MTU3_MAX_HW_CHANNELS; i++) {
+               if (rz_mtu3_pwm->channel[i].pwm_index + rz_mtu3_pwm->channe=
l[i].num >  hwpwm)
                        break;
        }

+       return &rz_mtu3_pwm->channel[i];
 }


>=20
> > +static bool rz_mtu3_pwm_is_ch_enabled(struct rz_mtu3_pwm_chip
> *rz_mtu3_pwm,
> > +				      u32 hwpwm)
> > +{
> > +	struct rz_mtu3_channel *ch;
> > +	bool is_channel_en;
> > +	u32 ch_index;
> > +	u8 val;
> > +
> > +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, hwpwm);
> > +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> > +	is_channel_en =3D rz_mtu3_is_enabled(ch);
> > +
> > +	if (rz_mtu3_pwm_is_second_channel(ch_index, hwpwm))
> > +		val =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TIORL);
> > +	else
> > +		val =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TIORH);
> > +
> > +	return (is_channel_en && (val & RZ_MTU3_TIOR_OC_IOA));
>=20
> You could exit early (and so skip reading from the hardware) if
> is_channel_en is false.

Agreed.

>=20
> > +}
> > +
> > +static int rz_mtu3_pwm_request(struct pwm_chip *chip, struct
> > +pwm_device *pwm) {
> > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> > +	struct rz_mtu3_channel *ch;
> > +	u32 ch_index;
> > +
> > +	mutex_lock(&rz_mtu3_pwm->lock);
> > +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> > +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
>=20
> ch and ch_index can be determined before taking the lock, can it not?


Agreed.

>=20
> I'd only work with a single variable that holds the value of your ch_inde=
x,
> call it "ch" and use rz_mtu3_pwm->channel[ch]. This is simpler and so eas=
ier
> to understand for a code reader.
>=20
> > +	if (!rz_mtu3_pwm->user_count[ch_index] &&
> !rz_mtu3_request_channel(ch)) {
> > +		mutex_unlock(&rz_mtu3_pwm->lock);
> > +		return -EBUSY;
> > +	}
>=20
> This would be easier to read if written as follows:
>=20
> 	/*
> 	 * Each channel must be requested only once, so if the channel
> 	 * serves two PWMs and the other is already requested, skip over
> 	 * rz_mtu3_request_channel()
> 	 */
> 	if (!rz_mtu3_pwm->user_count[ch_index]) {
> 		ret =3D rz_mtu3_request_channel(ch);
> 		if (ret)
> 			return ret; /* or -EBUSY? */
> 	}

Ok, it is rewritten as

+       if (!rz_mtu3_pwm->user_count[index]) {
+               ch_idle =3D rz_mtu3_request_channel(ch->mtu);
+               if (!ch_idle) {
+                       mutex_unlock(&rz_mtu3_pwm->lock);
+                       return -EBUSY;
+               }
        }

Where index =3D ch - rz_mtu3_pwm->channel;


>=20
> > +
> > +	rz_mtu3_pwm->user_count[ch_index]++;
> > +	mutex_unlock(&rz_mtu3_pwm->lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rz_mtu3_pwm_free(struct pwm_chip *chip, struct pwm_device
> > +*pwm) {
> > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> > +	struct rz_mtu3_channel *ch;
> > +	u32 ch_index;
> > +
> > +	mutex_lock(&rz_mtu3_pwm->lock);
> > +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> > +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> > +
> > +	rz_mtu3_pwm->user_count[ch_index]--;
> > +	if (!rz_mtu3_pwm->user_count[ch_index])
> > +		rz_mtu3_release_channel(ch);
> > +
> > +	mutex_unlock(&rz_mtu3_pwm->lock);
> > +}
> > +
> > +static int rz_mtu3_pwm_enable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
> > +			      struct pwm_device *pwm)
> > +{
> > +	struct rz_mtu3_channel *ch;
> > +	u32 ch_index;
> > +	u8 val;
> > +	int rc;
> > +
> > +	rc =3D pm_runtime_resume_and_get(rz_mtu3_pwm->chip.dev);
> > +	if (rc)
> > +		return rc;
> > +
> > +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> > +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> > +	val =3D (RZ_MTU3_TIOR_OC_1_TOGGLE << 4) |
> > +RZ_MTU3_TIOR_OC_0_H_COMP_MATCH;
>=20
> Introduce a symbol for the 4 above? This is the only use of
> RZ_MTU3_TIOR_OC_1_TOGGLE, maybe move the shift to the definition of that
> symbol?

Done.
+       val =3D RZ_MTU3_TIOR_OC_IOB_TOGGLE | RZ_MTU3_TIOR_OC_IOA_H_COMP_MAT=
CH;

>=20
> > +	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_MD_PWMMODE1);
> > +	if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm))
> > +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORL, val);
> > +	else
> > +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORH, val);
> > +
> > +	if (rz_mtu3_pwm->user_count[ch_index] <=3D 1)
> > +		rz_mtu3_enable(ch);
>=20
> That looks wrong. user_count signals if the channel is used for one or tw=
o
> PWMs, right? If both PWMs are requested before any of them is enabled,
> rz_mtu3_enable is never called, isn't it?

OK, Introduced enable_count to take care this in enable/disable function.


@@ -67,9 +67,26 @@ struct rz_mtu3_pwm_chip {
        struct mutex lock;
        unsigned long rate;
        u32 user_count[RZ_MTU3_MAX_HW_CHANNELS];
+       u32 enable_count[RZ_MTU3_MAX_HW_CHANNELS];
};

Enable:

+       mutex_lock(&rz_mtu3_pwm->lock);
+       if (!rz_mtu3_pwm->enable_count[index])
+               rz_mtu3_enable(ch->mtu);
+      =20
+       rz_mtu3_pwm->enable_count[index]++;
+       mutex_unlock(&rz_mtu3_pwm->lock);

Disable:
+       mutex_lock(&rz_mtu3_pwm->lock);
+       rz_mtu3_pwm->enable_count[index]--;
+       if (!rz_mtu3_pwm->enable_count[index])
+               rz_mtu3_disable(ch->mtu);
=20
+       mutex_unlock(&rz_mtu3_pwm->lock);

>=20
> > +	return 0;
> > +}
> > +
> > +static void rz_mtu3_pwm_disable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
> > +				struct pwm_device *pwm)
> > +{
> > +	struct rz_mtu3_channel *ch;
> > +	u32 ch_index;
> > +
> > +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> > +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> > +
> > +	/* Return to normal mode and disable output pins of MTU3 channel */
> > +	if (rz_mtu3_pwm->user_count[ch_index] <=3D 1)
> > +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1,
> RZ_MTU3_TMDR1_MD_NORMAL);
> > +
> > +	if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm))
> > +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORL,
> RZ_MTU3_TIOR_OC_RETAIN);
> > +	else
> > +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORH,
> RZ_MTU3_TIOR_OC_RETAIN);
> > +
> > +	if (rz_mtu3_pwm->user_count[ch_index] <=3D 1)
> > +		rz_mtu3_disable(ch);
> > +
> > +	pm_runtime_put_sync(rz_mtu3_pwm->chip.dev);
> > +}
> > +
> > +static int rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_dev=
ice
> *pwm,
> > +				 struct pwm_state *state)
> > +{
> > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> > +	struct rz_mtu3_channel *ch;
> > +	u8 prescale, val;
> > +	u32 ch_index;
> > +	u16 dc, pv;
> > +	u64 tmp;
> > +
> > +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> > +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> > +	pm_runtime_get_sync(chip->dev);
> > +	state->enabled =3D rz_mtu3_pwm_is_ch_enabled(rz_mtu3_pwm, pwm->hwpwm)=
;
> > +	if (state->enabled) {
>=20
> Most variables can have a narrower scope and be declared here.

OK.

>=20
> > +		val =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TCR);
> > +		prescale =3D FIELD_GET(RZ_MTU3_TCR_TPCS, val);
> > +
> > +		if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm)) {
> > +			dc =3D rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRD);
> > +			pv =3D rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRC);
> > +		} else {
> > +			dc =3D rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRB);
> > +			pv =3D rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRA);
> > +		}
> > +
> > +		/* With prescale <=3D 7 and pv <=3D 0xffff this doesn't overflow.
> */
> > +		tmp =3D NSEC_PER_SEC * (u64)pv << (2 * prescale);
> > +		state->period =3D DIV_ROUND_UP_ULL(tmp, rz_mtu3_pwm->rate);
> > +		tmp =3D NSEC_PER_SEC * (u64)dc << (2 * prescale);
> > +		state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, rz_mtu3_pwm->rate);
> > +	}
> > +
> > +	if (state->duty_cycle > state->period)
> > +		state->duty_cycle =3D state->period;
> > +
> > +	state->polarity =3D PWM_POLARITY_NORMAL;
> > +	pm_runtime_put(chip->dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > +			      const struct pwm_state *state) {
> > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> > +	struct rz_mtu3_channel *ch;
> > +	unsigned long pv, dc;
> > +	u64 period_cycles;
> > +	u64 duty_cycles;
> > +	u32 ch_index;
> > +	u8 prescale;
> > +	u8 val;
> > +
> > +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> > +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> > +	period_cycles =3D mul_u64_u32_div(state->period, rz_mtu3_pwm->rate,
> > +					NSEC_PER_SEC);
> > +	prescale =3D rz_mtu3_pwm_calculate_prescale(rz_mtu3_pwm,
> > +period_cycles);
> > +
> > +	if (period_cycles >> (2 * prescale) <=3D U16_MAX)
> > +		pv =3D period_cycles >> (2 * prescale);
> > +	else
> > +		pv =3D U16_MAX;
> > +
> > +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle, rz_mtu3_pwm->rate,
> > +				      NSEC_PER_SEC);
> > +	if (duty_cycles >> (2 * prescale) <=3D U16_MAX)
> > +		dc =3D duty_cycles >> (2 * prescale);
> > +	else
> > +		dc =3D U16_MAX;
> > +
> > +	/*
> > +	 * If the PWM channel is disabled, make sure to turn on the clock
> > +	 * before writing the register.
> > +	 */
> > +	if (!pwm->state.enabled)
> > +		pm_runtime_get_sync(chip->dev);
> > +
> > +	val =3D RZ_MTU3_TCR_CKEG_RISING | prescale;
> > +	if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm)) {
> > +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR,
> > +				      RZ_MTU3_TCR_CCLR_TGRC | val);
> > +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRD, dc);
> > +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRC, pv);
> > +	} else {
> > +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR,
> > +				      RZ_MTU3_TCR_CCLR_TGRA | val);
> > +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRB, dc);
> > +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRA, pv);
> > +	}
> > +
> > +	/* If the PWM is not enabled, turn the clock off again to save power.
> */
> > +	if (!pwm->state.enabled)
> > +		pm_runtime_put(chip->dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rz_mtu3_pwm_apply(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > +			     const struct pwm_state *state) {
> > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> > +	bool enabled =3D pwm->state.enabled;
> > +	int ret;
> > +
> > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > +		return -EINVAL;
> > +
> > +	if (!state->enabled) {
> > +		if (enabled)
> > +			rz_mtu3_pwm_disable(rz_mtu3_pwm, pwm);
> > +
> > +		return 0;
> > +	}
> > +
> > +	ret =3D rz_mtu3_pwm_config(chip, pwm, state);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!enabled)
> > +		ret =3D rz_mtu3_pwm_enable(rz_mtu3_pwm, pwm);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct pwm_ops rz_mtu3_pwm_ops =3D {
> > +	.request =3D rz_mtu3_pwm_request,
> > +	.free =3D rz_mtu3_pwm_free,
> > +	.get_state =3D rz_mtu3_pwm_get_state,
> > +	.apply =3D rz_mtu3_pwm_apply,
> > +	.owner =3D THIS_MODULE,
> > +};
> > +
> > +static int rz_mtu3_pwm_pm_runtime_suspend(struct device *dev) {
> > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D dev_get_drvdata(dev);
> > +
> > +	clk_disable_unprepare(rz_mtu3_pwm->clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rz_mtu3_pwm_pm_runtime_resume(struct device *dev) {
> > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D dev_get_drvdata(dev);
> > +
> > +	return clk_prepare_enable(rz_mtu3_pwm->clk);
> > +}
> > +
> > +static DEFINE_RUNTIME_DEV_PM_OPS(rz_mtu3_pwm_pm_ops,
> > +				 rz_mtu3_pwm_pm_runtime_suspend,
> > +				 rz_mtu3_pwm_pm_runtime_resume, NULL);
> > +
> > +static void rz_mtu3_pwm_pm_disable(void *data) {
> > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D data;
> > +
> > +	clk_rate_exclusive_put(rz_mtu3_pwm->clk);
> > +	pm_runtime_disable(rz_mtu3_pwm->chip.dev);
> > +	pm_runtime_set_suspended(rz_mtu3_pwm->chip.dev);
> > +}
> > +
> > +static int rz_mtu3_pwm_probe(struct platform_device *pdev) {
> > +	struct rz_mtu3 *ddata =3D dev_get_drvdata(pdev->dev.parent);
> > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm;
> > +	struct device *dev =3D &pdev->dev;
> > +	int num_pwm_hw_ch =3D 0;
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	rz_mtu3_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*rz_mtu3_pwm),
> GFP_KERNEL);
> > +	if (!rz_mtu3_pwm)
> > +		return -ENOMEM;
> > +
> > +	rz_mtu3_pwm->clk =3D ddata->clk;
> > +
> > +	for (i =3D 0; i < RZ_MTU_NUM_CHANNELS; i++) {
> > +		if (i =3D=3D RZ_MTU3_CHAN_5 || i =3D=3D RZ_MTU3_CHAN_8)
> > +			continue;
> > +
> > +		rz_mtu3_pwm->ch[num_pwm_hw_ch] =3D &ddata->channels[i];
> > +		rz_mtu3_pwm->ch[num_pwm_hw_ch]->dev =3D dev;
> > +		num_pwm_hw_ch++;
> > +	}
> > +
> > +	mutex_init(&rz_mtu3_pwm->lock);
> > +	platform_set_drvdata(pdev, rz_mtu3_pwm);
> > +	ret =3D clk_prepare_enable(rz_mtu3_pwm->clk);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Clock enable failed\n");
> > +
> > +	clk_rate_exclusive_get(rz_mtu3_pwm->clk);
> > +
> > +	rz_mtu3_pwm->rate =3D clk_get_rate(rz_mtu3_pwm->clk);
> > +	/*
> > +	 * Refuse clk rates > 1 GHz to prevent overflow later for computing
> > +	 * period and duty cycle.
> > +	 */
> > +	if (rz_mtu3_pwm->rate > NSEC_PER_SEC) {
> > +		ret =3D -EINVAL;
> > +		clk_rate_exclusive_put(rz_mtu3_pwm->clk);
> > +		goto disable_clock;
> > +	}
> > +
> > +	pm_runtime_set_active(&pdev->dev);
> > +	pm_runtime_enable(&pdev->dev);
> > +	rz_mtu3_pwm->chip.dev =3D &pdev->dev;
> > +	ret =3D devm_add_action_or_reset(&pdev->dev,
> > +				       rz_mtu3_pwm_pm_disable,
> > +				       rz_mtu3_pwm);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	rz_mtu3_pwm->chip.ops =3D &rz_mtu3_pwm_ops;
> > +	rz_mtu3_pwm->chip.npwm =3D RZ_MTU3_MAX_PWM_CHANNELS;
> > +	ret =3D devm_pwmchip_add(&pdev->dev, &rz_mtu3_pwm->chip);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret, "failed to add PWM
> chip\n");
> > +
> > +	pm_runtime_idle(&pdev->dev);
> > +
> > +	return 0;
> > +
> > +disable_clock:
> > +	clk_disable_unprepare(rz_mtu3_pwm->clk);
> > +	return ret;
> > +}
>=20
> .probe() enables rz_mtu3_pwm->clk, but there is no .remove() that cares
> about disabling it again.

I believe it is ok. I have added WARN_ON for double checking.
Please correct me, if it is wrong.

Probe:
Clock enable by "clk_prepare_enable"
[    6.923881]  rzg2l_mod_clock_endisable+0x130/0x180
[    6.929295]  rzg2l_mod_clock_enable+0x54/0x70
[    6.934229]  clk_core_enable+0xdc/0x278
[    6.938599]  clk_enable+0x28/0x44
[    6.942403]  rz_mtu3_pwm_probe+0xf0/0x230
[    6.946944]  platform_probe+0x64/0xcc


Clock disable by " pm_runtime_idle"
[    7.283961]  rzg2l_mod_clock_endisable+0x130/0x180
[    7.289383]  rzg2l_mod_clock_disable+0x50/0x5c
[    7.294415]  clk_core_disable+0x8c/0xd8
[    7.298787]  clk_disable+0x2c/0x44
[    7.302685]  rz_mtu3_pwm_pm_runtime_suspend+0x1c/0x34
[    7.308361]  pm_generic_runtime_suspend+0x28/0x3c
[    7.313667]  __rpm_callback+0x44/0x134
[    7.317936]  rpm_callback+0x64/0x70
[    7.321920]  rpm_suspend+0x130/0x628
[    7.325999]  rpm_idle+0x118/0x2c0
[    7.329796]  __pm_runtime_idle+0x4c/0x84
[    7.334250]  rz_mtu3_pwm_probe+0x1b8/0x230


Unbind:
cd /sys/bus/platform/drivers/pwm-rz-mtu3/
echo pwm-rz-mtu3.0 > unbind

Clock enable by "__pm_runtime_resume"
[  263.003787]  rzg2l_mod_clock_endisable+0x130/0x180
[  263.009196]  rzg2l_mod_clock_enable+0x54/0x70
[  263.014122]  clk_core_enable+0xdc/0x278
[  263.018484]  clk_enable+0x28/0x44
[  263.022278]  rz_mtu3_pwm_pm_runtime_resume+0x3c/0x5c
[  263.027850]  pm_generic_runtime_resume+0x28/0x3c
[  263.033054]  __rpm_callback+0x44/0x134
[  263.037314]  rpm_callback+0x64/0x70
[  263.041287]  rpm_resume+0x428/0x6a0
[  263.045260]  __pm_runtime_resume+0x50/0x74
[  263.049893]  device_release_driver_internal+0xcc/0x234
[  263.055670]  device_driver_detach+0x14/0x1c


Clock disable by "__pm_runtime_idle"
[  263.304970]  rzg2l_mod_clock_endisable+0x130/0x180
[  263.309812]  rzg2l_mod_clock_disable+0x50/0x5c
[  263.314301]  clk_core_disable+0x8c/0xd8
[  263.318180]  clk_disable+0x2c/0x44
[  263.321620]  rz_mtu3_pwm_pm_runtime_suspend+0x1c/0x34
[  263.326720]  pm_generic_runtime_suspend+0x28/0x3c
[  263.331472]  __rpm_callback+0x44/0x134
[  263.335261]  rpm_callback+0x64/0x70
[  263.338787]  rpm_suspend+0x130/0x628
[  263.342400]  rpm_idle+0x118/0x2c0
[  263.345751]  __pm_runtime_idle+0x4c/0x84
[  263.349713]  device_release_driver_internal+0x1d0/0x234


Please correct me if anything wrong or clarifications needed.

Cheers,
Biju

>=20
> > +
> > +static struct platform_driver rz_mtu3_pwm_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "pwm-rz-mtu3",
> > +		.pm =3D pm_ptr(&rz_mtu3_pwm_pm_ops),
> > +	},
> > +	.probe =3D rz_mtu3_pwm_probe,
> > +};
> > +module_platform_driver(rz_mtu3_pwm_driver);
> > +
> > +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> > +MODULE_ALIAS("platform:pwm-rz-mtu3");
> > +MODULE_DESCRIPTION("Renesas RZ/G2L MTU3a PWM Timer Driver");
> > +MODULE_LICENSE("GPL");
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
