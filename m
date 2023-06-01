Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2811719F40
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Jun 2023 16:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjFAOJr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Jun 2023 10:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbjFAOJq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Jun 2023 10:09:46 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2131.outbound.protection.outlook.com [40.107.114.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC27E44;
        Thu,  1 Jun 2023 07:09:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQz3cQjZhkror0p9N8FQejjc9TBhtDYY3bpN1AKlqGiZ3tVhR2j/F0PQ3OsHT8SO/M/wP2xUPGwDTb52OK0/TKwVRH/7hCIXUWEJow8Fqhg5WZEHRoJxsX0oZMii17I3zX21QJzadpIMFkORrJkNnuiyjGKJVuyqfTjPaan8Oj5gW2HnO/uPto6FmvH4+K5Ci4pwCtqhWjUeGj7tXyg/lKMbvahoUdlscc0z0aeHl+8Ok5492gxG1b0bMkH3zO7VuVeO0Geo/IGFkIm8mBiG7MkLwHkEPzcoNIjhKYk+9l4W/O2CsHwQ04Z6m7j7QJvqu06HEMbaJ3xC3VxGmyoUow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgRbBJBzfv4s+e9BBFosLmo6627Ru4vrkXd6guHJXFE=;
 b=XVqBIauJDxLU9w1vALvD7vz9a1t5ONms3p/88OLeYJjnC+lGHOoi8tJFY5Vc3mZ9NW1VSnCxmNOKpBbFpC9rSJRMT7ASuqlehzy/Jl7Zxlv25cYdRgY9uIjhC49IeaHK6v7bNNuiMwHmiLmnd2cBt4rqWOUIibzkUnj6FKq3wgtwlkUt6eXhd5O8hqUv/a18eVbqba8pgTM/UaQr0fAotC+p5VypXvbLs0c5ohVI11Ql6RsDUosFa52WrloAcKtmdjTtIdQDlw02PlZ6NKsxvlded3qwHodCmyzkxVLPFGSJyxDDfKIR+uBxv7pssw1Y0eMqzqnhk9EaL3ENdtRlHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgRbBJBzfv4s+e9BBFosLmo6627Ru4vrkXd6guHJXFE=;
 b=v3jTn/ymYibeicaKajl6WCeNQBdmB0JY/uYogC9TD5i8AN07WE94o0/2StAcCD+U0Nd++5a0mCyJGv82h8bCA1lapIA+swPPGHpZf7tGui3GqKqUORPyFO5Eoqk73Bt9CxhFhGNgqilhiMZBLeSDqGJYL+5Ku3xJ43uZMoV6V28=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB7749.jpnprd01.prod.outlook.com (2603:1096:400:17a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 14:08:30 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 14:08:30 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v17] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Topic: [PATCH v17] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Index: AQHZjNDvuavovm4aHEiWuwSbjqNTeq92Cwrg
Date:   Thu, 1 Jun 2023 14:08:29 +0000
Message-ID: <OS0PR01MB592245291AA058CFB4722BDE86499@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230522171449.688814-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230522171449.688814-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB7749:EE_
x-ms-office365-filtering-correlation-id: cb9f8333-93ad-4771-d5f4-08db62a9ad56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K72MbiGJ5DgcAkaCn9X8YFwF9ipzyiSK03AG62MB7ROra1SlEWejBdXah+fISiAr7xrrKd402mMpMjde9127wLC7S4iZvzRKNF1hXj72iPF6AKXkwLPvHoBq8olADaedInYQlBR21iUOEQCeIpyGFIQ2yE/lQjKnPtKChl5xtmbe9VHiMJKSG1zCWY2JvzRWS6O8rpNEM6thQCBTT+VYUrtBeMPEziarjgWJRgCt/d1L5ZHzGXkq0ZXrMnWHzW6ArKLqjHus1wVxVzsE3X9pSmogYGpJ/vXU5OFgLerfDBRWQNcP3aXHw4DW92ntjmYT76qVaHMySC07kRwpWC1R4a/jFSmsUmJnuITY9JPzEr/70b2U3FoxS/n2wQyDTpM62a+14Sv581lv593TXC6HpzyEI+yb97dtRTrV1/QgLozxlaXwY6WvQnrajJ2rsRYxvqNS5sn885H88myceH7fmKI3cS2VgqKHRJ+gJrNe0K1l7SY0wmTRg02lJDuW4fV2GBS5CM9cnMqYbjTLJCwxMPp/5HWTNcBQIvGcmScvjUGY3bPknhV+WrnZZv+CNNYKHQwRH68O1rq1mms+ACNXbXH56lUqW8WWqKBbBskOqmP+QQDIu206SLqyjicO0RxY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(54906003)(26005)(6506007)(9686003)(110136005)(53546011)(86362001)(38070700005)(71200400001)(186003)(30864003)(2906002)(478600001)(76116006)(55016003)(66946007)(64756008)(52536014)(66476007)(33656002)(66446008)(66574015)(4326008)(66556008)(5660300002)(83380400001)(8936002)(7696005)(41300700001)(38100700002)(8676002)(316002)(122000001)(32563001)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?haafZKsOSEdCPVV4O3Hwtgi/PmHTYFPSyHRjDNvsT1SsG9NI8zLWmOOGcL?=
 =?iso-8859-1?Q?q+Slsc00nz0ys37J27286E7y5T/H+JSz83CZAKUM3QcQ/oJlBsrrUeIw9P?=
 =?iso-8859-1?Q?KvKJtzCHTsml5UZfuSjNcoDTko46AzCn3yxgxAHN1TkuSqQFzomDLIrg+g?=
 =?iso-8859-1?Q?4EnwDr7AKjFuV5QqikNQJph914aiBsVUUAY3JhbamxFAkjnidV9q3/Ox7t?=
 =?iso-8859-1?Q?UxLB0CH1wJmSzQMSng+fll9UE2+RkKDJeR265tV9dRqLpUCV4yfpPSIUMl?=
 =?iso-8859-1?Q?K4Qn11YzGFncej7YCCPb6Q3pxLOQB/bxPug3iOaU7J7i8eUBTI/7wiySwz?=
 =?iso-8859-1?Q?Qbmi5lYyWE7VPHJtl+3xchB0sZBeR0vVcMyZcHSz6XZ21cHxGyjjBpALeT?=
 =?iso-8859-1?Q?E5FnA1cSEIaU4gA3GpsfDm6CpQOMKX9l783eterNso0PkzvxZRcQXpBfY4?=
 =?iso-8859-1?Q?OVSAG4kqJQbjyRCPH+C5Qz3Aw4/EQyElM7Za+yJPvqDqB0lbLVQmD5bGiW?=
 =?iso-8859-1?Q?Wff6mohfaSjamgNqqXJXzpAIuqvZHhmsHsXOAYNgqBpgyE3udffDm13UgY?=
 =?iso-8859-1?Q?z1NkWeHdFOi2bO0epRZSMv16/3B9pGa2yy/Wa3acT0BM53EzWKVvwyNeRr?=
 =?iso-8859-1?Q?TPA8M8Bl31sjC99mfG01wb1Nugao1zcP8uYGz0BFxv20neLyYDQZfJA8b7?=
 =?iso-8859-1?Q?6ocpF8OtIVxDSZgH6btcQMaTkELNogCyCCNv0EYzW6dvBYZ5DZ+40YyGJl?=
 =?iso-8859-1?Q?RtgHmx3qpM77StTieYNx4eSQjsJ5Au8lAvBQfJrHFW9hSDef4KENyZ/7Xn?=
 =?iso-8859-1?Q?XVAqdN4uG6GRFGEfr1ZZ+4NcoLe74xBiX36BxO/9j1ydG+R7RMrMWwW+KC?=
 =?iso-8859-1?Q?G13mC8Kd78d71zS64PV/lDBBK5EcydQTZb7SboHD+LUjsrWCQejCRnm9uB?=
 =?iso-8859-1?Q?J8l0euhe1jEa+8kEFdZ5rPC+umd1b9nP6AgMDnXLjbO2mNlegMysv9ilfe?=
 =?iso-8859-1?Q?ZzZCcj1pZD4oHu9NHeK7J+w/Eour+lGGVImcsE0cWj31yPghHUhBjsnOEe?=
 =?iso-8859-1?Q?Tt9KXriuge7ySRPGmsDKJtF10zZjWEWDvZKYkCoPKlEbydT45AiZlVXKUD?=
 =?iso-8859-1?Q?6lCZyC4TCH5zaBir4BS8+jBhFLXk6c/HRx0o3FaDT8qSwCoSYYcXhMoWO5?=
 =?iso-8859-1?Q?1So1Vq/ociHziSWag6bj6jLgnrl3LzZtnLHnbWFTFqvNYoerPJx+Bqc8BJ?=
 =?iso-8859-1?Q?P/5g3KEdO3DuqcO4wUtrZg4wG9CcK7L57f8STfNPUrerFXfekj8lbt7hWw?=
 =?iso-8859-1?Q?czDTGER1jUmhTLnpTtzoAYtxiqzg/s1eay5lYHI8jAfQseMd0AaxmMDtAy?=
 =?iso-8859-1?Q?y7cnzZ1OjUyo+turo39lB3SKdZ7ej7fA+S8ygGBtmCpH5UypKPW4P4T/8p?=
 =?iso-8859-1?Q?5OmvFLjUDc3QJIZl+ANzC7ZHOSEK4awyMPVaeBd1rcfOr0ZH2pplxxULjV?=
 =?iso-8859-1?Q?ZaqBQY9yZ4QDNdDQVOYXmt0BcCLPNTnl1nkXNRO+f179KwnjdNO+HfPyAe?=
 =?iso-8859-1?Q?pF3zhUeq3lP39d/xzOqEamv4LsZIfCq3NfLKjA80i+pF8wY0mIWi1blQ9P?=
 =?iso-8859-1?Q?vmEV7cvsJjUna3pEQ8Ck/AeLgF2sjmjs1R7icHB8a5znsgBf6hJN0uag?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9f8333-93ad-4771-d5f4-08db62a9ad56
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 14:08:29.9931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jUGZEocKwt3ayCvFhw+fyZvRoINH/U2mlYtTDgTDha0U2zfgY9Up3SBJ/SpfPfWmPWO46JiPIOtLq5pVpk1BKed/vvCUi1WzXWZVPZEligw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7749
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

Gentle ping. Are you happy with this patch?

Cheers,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Monday, May 22, 2023 6:15 PM
> To: Thierry Reding <thierry.reding@gmail.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Uwe Kleine-K=F6nig <u.kleine-
> koenig@pengutronix.de>; linux-pwm@vger.kernel.org; Geert Uytterhoeven
> <geert+renesas@glider.be>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>; linux-renesas-soc@vger.kernel.org
> Subject: [PATCH v17] pwm: Add Renesas RZ/G2L MTU3a PWM driver
>=20
> The RZ/G2L Multi-Function Timer Pulse Unit 3 (a.k.a MTU3a) uses one
> counter and two match components to configure duty_cycle and period to
> generate PWM output waveform.
>=20
> Add basic support for RZ/G2L MTU3a PWM driver by creating separate PWM
> channels for each IOs.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v16->v17:
>  * Added a comment related to supported prescalar values in rz_mtu3_pwm_
>    calculate_prescale().
>  * Replaced pm_runtime_get_sync->pm_runtime_resume_and_get and
> propogated
>    the error.
>  * Improved the logic in rz_mtu3_pwm_calculate_pv_or_dc() by using
>    min(period_or_duty_cycle >> (2 * prescale), (u64)U16_MAX);
>  * Updated rz_mtu3_pwm_get_state() by moving duty > period check
>    inside the top if block.
> v15->v16:
>  * Fixed extra space around hwpwm check on rz_mtu3_get_channel().
>  * Dropped redundant is_channel_en check on rz_mtu3_pwm_is_ch_enabled().
>  * Replaced channel->base_pwm_number in struct rz_mtu3_channel_io_map.
>  * Added comment for channel_map.
>  * Dropped setting normal mode in rz_mtu3_pwm_disable().
>  * Replaced ddata->parent_ddata in probe()
>  * Added support for modifying prescalar, if other PWM is off or handle
>    it, if current prescale value is less than the one we want to set.
>  * Added below helper functions rz_mtu3_pwm_calculate_pv_or_dc() and
>    rz_mtu3_pwm_{read,write}_tgr_registers to simplify the code.
> v14->v15:
>  * Updated copyright header and Limitations section
>  * Moved register definitions to <linux/mfd/rz-mtu3.h>
>  * Introduced new mapping table struct rz_mtu3_channel_io_map to hold
> the
>    index of the lowest PWM and the number of PWMs handled by the HW
> channel.
>  * Introduced struct rz_mtu3_pwm_channel to hold mtu3 channel data and
>    mapping table.
>  * Replaced rz_mtu3_get_hw_channel->rz_mtu3_get_channel and channel-
> >hwpwm.
>    The rz_mtu3_get_channel() returns struct rz_mtu3_pwm_channel*
>  * Dropped rz_mtu3_pwm_is_second_channel() as same can be obtained
> directly
>    with new mapping (ie, priv->map->channel =3D=3D pwm->hwpwm)
>  * Replaced ch_index->ch throughout and used "priv - rz_mtu3_pwm-
> >channel_data"
>    to find ch and dropped rz_mtu3_get_hw_channel_index().
>  * Optimized rz_mtu3_pwm_is_ch_enabled() by exit early, if is_channel_en
> is false.
>  * Updated rz_mtu3_pwm_request() and added comments.
>  * Introduced a bug in the driver by introducing enable_count, which
> increment/
>    decrement during enable()/disable().
>  * Reduced variable scope in rz_mtu3_pwm_get_state() by moving most of
> variables
>    inside the if statement.
>  * Updated probe() to assign the struct rz_mtu3_pwm_channel values.
> v13->v14:
>  * Updated commit description
>  * Updated Limitations section.
>  * Replaced the macros RZ_MTU*->RZ_MTU3_CHAN_* in probe()
>  * Fixed a kernel crash in error path by moving rz_mtu3_pwm->chip.dev
> before
>    devm_add_action_or_reset()
>  * Added pm_runtime_idle() and simplified error paths for
> devm_add_action_or_reset()
>    and devm_pwmchip_add().
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
>  * Updated header file to <linux/mfd/rz-mtu3.h> as core driver is in
> MFD.
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
>  drivers/pwm/pwm-rz-mtu3.c | 551 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 563 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rz-mtu3.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> 8df861b1f4a3..ac0517b51540 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -493,6 +493,17 @@ config PWM_ROCKCHIP
>  	  Generic PWM framework driver for the PWM controller found on
>  	  Rockchip SoCs.
>=20
> +config PWM_RZ_MTU3
> +	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
> +	depends on RZ_MTU3 || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This driver exposes the MTU3a PWM Timer controller found in
> Renesas
> +	  RZ/G2L like chips through the PWM API.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-rz-mtu3.
> +
>  config PWM_SAMSUNG
>  	tristate "Samsung PWM support"
>  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS ||
> COMPILE_TEST diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 19899b912e00..68b7a15c2ca5 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -45,6 +45,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-raspberrypi-
> poe.o
>  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> +obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c new
> file mode 100644 index 000000000000..bed8bd671e37
> --- /dev/null
> +++ b/drivers/pwm/pwm-rz-mtu3.c
> @@ -0,0 +1,551 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L MTU3a PWM Timer driver
> + *
> + * Copyright (C) 2023 Renesas Electronics Corporation
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
> + * - HW uses one counter and two match components to configure
> duty_cycle
> + *   and period.
> + * - Multi-Function Timer Pulse Unit (a.k.a MTU) has 7 HW channels for
> PWM
> + *   operations. (The channels are MTU{0..4, 6, 7}.)
> + * - MTU{1, 2} channels have a single IO, whereas all other HW channels
> have
> + *   2 IOs.
> + * - Each IO is modelled as an independent PWM channel.
> + * - rz_mtu3_channel_io_map table is used to map the PWM channel to the
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
> +#define RZ_MTU3_MAX_PWM_CHANNELS	12
> +#define RZ_MTU3_MAX_HW_CHANNELS		7
> +
> +/**
> + * struct rz_mtu3_channel_io_map - MTU3 pwm channel map
> + *
> + * @base_pwm_number: First PWM of a channel
> + * @num: number of IOs on the HW channel.
> + */
> +struct rz_mtu3_channel_io_map {
> +	u8 base_pwm_number;
> +	u8 num_channel_ios;
> +};
> +
> +/**
> + * struct rz_mtu3_pwm_channel - MTU3 pwm channel data
> + *
> + * @mtu: MTU3 channel data
> + * @map: MTU3 pwm channel map
> + */
> +struct rz_mtu3_pwm_channel {
> +	struct rz_mtu3_channel *mtu;
> +	const struct rz_mtu3_channel_io_map *map; };
> +
> +/**
> + * struct rz_mtu3_pwm_chip - MTU3 pwm private data
> + *
> + * @chip: MTU3 pwm chip data
> + * @clk: MTU3 module clock
> + * @lock: Lock to prevent concurrent access for usage count
> + * @rate: MTU3 clock rate
> + * @user_count: MTU3 usage count
> + * @enable_count: MTU3 enable count
> + * @prescale: MTU3 prescale
> + * @channel_data: MTU3 pwm channel data  */
> +
> +struct rz_mtu3_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	struct mutex lock;
> +	unsigned long rate;
> +	u32 user_count[RZ_MTU3_MAX_HW_CHANNELS];
> +	u32 enable_count[RZ_MTU3_MAX_HW_CHANNELS];
> +	u8 prescale[RZ_MTU3_MAX_HW_CHANNELS];
> +	struct rz_mtu3_pwm_channel channel_data[RZ_MTU3_MAX_HW_CHANNELS];
> +};
> +
> +/*
> + * The MTU channels are {0..4, 6, 7} and the number of IO on MTU1
> + * and MTU2 channel is 1 compared to 2 on others.
> + */
> +static const struct rz_mtu3_channel_io_map channel_map[] =3D {
> +	{ 0, 2 }, { 2, 1 }, { 3, 1 }, { 4, 2 }, { 6, 2 }, { 8, 2 }, { 10,
> 2 }
> +};
> +
> +static inline struct rz_mtu3_pwm_chip *to_rz_mtu3_pwm_chip(struct
> +pwm_chip *chip) {
> +	return container_of(chip, struct rz_mtu3_pwm_chip, chip); }
> +
> +static void rz_mtu3_pwm_read_tgr_registers(struct rz_mtu3_pwm_channel
> *priv,
> +					   u16 reg_pv_offset, u16 *pv_val,
> +					   u16 reg_dc_offset, u16 *dc_val) {
> +	*pv_val =3D rz_mtu3_16bit_ch_read(priv->mtu, reg_pv_offset);
> +	*dc_val =3D rz_mtu3_16bit_ch_read(priv->mtu, reg_dc_offset); }
> +
> +static void rz_mtu3_pwm_write_tgr_registers(struct rz_mtu3_pwm_channel
> *priv,
> +					    u16 reg_pv_offset, u16 pv_val,
> +					    u16 reg_dc_offset, u16 dc_val) {
> +	rz_mtu3_16bit_ch_write(priv->mtu, reg_pv_offset, pv_val);
> +	rz_mtu3_16bit_ch_write(priv->mtu, reg_dc_offset, dc_val); }
> +
> +static u8 rz_mtu3_pwm_calculate_prescale(struct rz_mtu3_pwm_chip
> *rz_mtu3,
> +					 u64 period_cycles)
> +{
> +	u32 prescaled_period_cycles;
> +	u8 prescale;
> +
> +	/*
> +	 * Supported prescale values are 1, 4, 16 and 64.
> +	 * TODO: Support prescale values 2, 8, 32, 256 and 1024.
> +	 */
> +	prescaled_period_cycles =3D period_cycles >> 16;
> +	if (prescaled_period_cycles >=3D 16)
> +		prescale =3D 3;
> +	else
> +		prescale =3D (fls(prescaled_period_cycles) + 1) / 2;
> +
> +	return prescale;
> +}
> +
> +static struct rz_mtu3_pwm_channel *
> +rz_mtu3_get_channel(struct rz_mtu3_pwm_chip *rz_mtu3_pwm, u32 hwpwm) {
> +	struct rz_mtu3_pwm_channel *priv =3D rz_mtu3_pwm->channel_data;
> +	unsigned int ch;
> +
> +	for (ch =3D 0; ch < RZ_MTU3_MAX_HW_CHANNELS; ch++, priv++) {
> +		if (priv->map->base_pwm_number + priv->map->num_channel_ios
> > hwpwm)
> +			break;
> +	}
> +
> +	return priv;
> +}
> +
> +static bool rz_mtu3_pwm_is_ch_enabled(struct rz_mtu3_pwm_chip
> *rz_mtu3_pwm,
> +				      u32 hwpwm)
> +{
> +	struct rz_mtu3_pwm_channel *priv;
> +	bool is_channel_en;
> +	u8 val;
> +
> +	priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, hwpwm);
> +	is_channel_en =3D rz_mtu3_is_enabled(priv->mtu);
> +	if (!is_channel_en)
> +		return false;
> +
> +	if (priv->map->base_pwm_number =3D=3D hwpwm)
> +		val =3D rz_mtu3_8bit_ch_read(priv->mtu, RZ_MTU3_TIORH);
> +	else
> +		val =3D rz_mtu3_8bit_ch_read(priv->mtu, RZ_MTU3_TIORL);
> +
> +	return val & RZ_MTU3_TIOR_IOA;
> +}
> +
> +static int rz_mtu3_pwm_request(struct pwm_chip *chip, struct pwm_device
> +*pwm) {
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +	struct rz_mtu3_pwm_channel *priv;
> +	bool is_mtu3_channel_available;
> +	u32 ch;
> +
> +	priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch =3D priv - rz_mtu3_pwm->channel_data;
> +
> +	mutex_lock(&rz_mtu3_pwm->lock);
> +	/*
> +	 * Each channel must be requested only once, so if the channel
> +	 * serves two PWMs and the other is already requested, skip over
> +	 * rz_mtu3_request_channel()
> +	 */
> +	if (!rz_mtu3_pwm->user_count[ch]) {
> +		is_mtu3_channel_available =3D rz_mtu3_request_channel(priv-
> >mtu);
> +		if (!is_mtu3_channel_available) {
> +			mutex_unlock(&rz_mtu3_pwm->lock);
> +			return -EBUSY;
> +		}
> +	}
> +
> +	rz_mtu3_pwm->user_count[ch]++;
> +	mutex_unlock(&rz_mtu3_pwm->lock);
> +
> +	return 0;
> +}
> +
> +static void rz_mtu3_pwm_free(struct pwm_chip *chip, struct pwm_device
> +*pwm) {
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +	struct rz_mtu3_pwm_channel *priv;
> +	u32 ch;
> +
> +	priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch =3D priv - rz_mtu3_pwm->channel_data;
> +
> +	mutex_lock(&rz_mtu3_pwm->lock);
> +	rz_mtu3_pwm->user_count[ch]--;
> +	if (!rz_mtu3_pwm->user_count[ch])
> +		rz_mtu3_release_channel(priv->mtu);
> +
> +	mutex_unlock(&rz_mtu3_pwm->lock);
> +}
> +
> +static int rz_mtu3_pwm_enable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
> +			      struct pwm_device *pwm)
> +{
> +	struct rz_mtu3_pwm_channel *priv;
> +	u32 ch;
> +	u8 val;
> +	int rc;
> +
> +	rc =3D pm_runtime_resume_and_get(rz_mtu3_pwm->chip.dev);
> +	if (rc)
> +		return rc;
> +
> +	priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch =3D priv - rz_mtu3_pwm->channel_data;
> +	val =3D RZ_MTU3_TIOR_OC_IOB_TOGGLE |
> RZ_MTU3_TIOR_OC_IOA_H_COMP_MATCH;
> +
> +	rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TMDR1,
> RZ_MTU3_TMDR1_MD_PWMMODE1);
> +	if (priv->map->base_pwm_number =3D=3D pwm->hwpwm)
> +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TIORH, val);
> +	else
> +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TIORL, val);
> +
> +	mutex_lock(&rz_mtu3_pwm->lock);
> +	if (!rz_mtu3_pwm->enable_count[ch])
> +		rz_mtu3_enable(priv->mtu);
> +
> +	rz_mtu3_pwm->enable_count[ch]++;
> +	mutex_unlock(&rz_mtu3_pwm->lock);
> +
> +	return 0;
> +}
> +
> +static void rz_mtu3_pwm_disable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
> +				struct pwm_device *pwm)
> +{
> +	struct rz_mtu3_pwm_channel *priv;
> +	u32 ch;
> +
> +	priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch =3D priv - rz_mtu3_pwm->channel_data;
> +
> +	/* Disable output pins of MTU3 channel */
> +	if (priv->map->base_pwm_number =3D=3D pwm->hwpwm)
> +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TIORH,
> RZ_MTU3_TIOR_OC_RETAIN);
> +	else
> +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TIORL,
> +RZ_MTU3_TIOR_OC_RETAIN);
> +
> +	mutex_lock(&rz_mtu3_pwm->lock);
> +	rz_mtu3_pwm->enable_count[ch]--;
> +	if (!rz_mtu3_pwm->enable_count[ch])
> +		rz_mtu3_disable(priv->mtu);
> +
> +	mutex_unlock(&rz_mtu3_pwm->lock);
> +
> +	pm_runtime_put_sync(rz_mtu3_pwm->chip.dev);
> +}
> +
> +static int rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct
> pwm_device *pwm,
> +				 struct pwm_state *state)
> +{
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +	int rc;
> +
> +	rc =3D pm_runtime_resume_and_get(chip->dev);
> +	if (rc)
> +		return rc;
> +
> +	state->enabled =3D rz_mtu3_pwm_is_ch_enabled(rz_mtu3_pwm, pwm-
> >hwpwm);
> +	if (state->enabled) {
> +		struct rz_mtu3_pwm_channel *priv;
> +		u8 prescale, val;
> +		u16 dc, pv;
> +		u64 tmp;
> +
> +		priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
> +		if (priv->map->base_pwm_number =3D=3D pwm->hwpwm)
> +			rz_mtu3_pwm_read_tgr_registers(priv, RZ_MTU3_TGRA,
> &pv,
> +						       RZ_MTU3_TGRB, &dc);
> +		else
> +			rz_mtu3_pwm_read_tgr_registers(priv, RZ_MTU3_TGRC,
> &pv,
> +						       RZ_MTU3_TGRD, &dc);
> +
> +		val =3D rz_mtu3_8bit_ch_read(priv->mtu, RZ_MTU3_TCR);
> +		prescale =3D FIELD_GET(RZ_MTU3_TCR_TPCS, val);
> +
> +		/* With prescale <=3D 7 and pv <=3D 0xffff this doesn't
> overflow. */
> +		tmp =3D NSEC_PER_SEC * (u64)pv << (2 * prescale);
> +		state->period =3D DIV_ROUND_UP_ULL(tmp, rz_mtu3_pwm->rate);
> +		tmp =3D NSEC_PER_SEC * (u64)dc << (2 * prescale);
> +		state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, rz_mtu3_pwm-
> >rate);
> +
> +		if (state->duty_cycle > state->period)
> +			state->duty_cycle =3D state->period;
> +	}
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	pm_runtime_put(chip->dev);
> +
> +	return 0;
> +}
> +
> +static u16 rz_mtu3_pwm_calculate_pv_or_dc(u64 period_or_duty_cycle, u8
> +prescale) {
> +	return min(period_or_duty_cycle >> (2 * prescale), (u64)U16_MAX);
> }
> +
> +static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device
> *pwm,
> +			      const struct pwm_state *state) {
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +	struct rz_mtu3_pwm_channel *priv;
> +	u64 period_cycles;
> +	u64 duty_cycles;
> +	u8 prescale;
> +	u16 pv, dc;
> +	u8 val;
> +	u32 ch;
> +
> +	priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch =3D priv - rz_mtu3_pwm->channel_data;
> +
> +	period_cycles =3D mul_u64_u32_div(state->period, rz_mtu3_pwm->rate,
> +					NSEC_PER_SEC);
> +	prescale =3D rz_mtu3_pwm_calculate_prescale(rz_mtu3_pwm,
> period_cycles);
> +
> +	/*
> +	 * Prescalar is shared by multiple channels, so prescale can
> +	 * NOT be modified when there are multiple channels in use with
> +	 * different settings. Modify prescalar if other PWM is off or
> handle
> +	 * it, if current prescale value is less than the one we want to
> set.
> +	 */
> +	if (rz_mtu3_pwm->enable_count[ch] > 1) {
> +		if (rz_mtu3_pwm->prescale[ch] > prescale)
> +			return -EBUSY;
> +
> +		prescale =3D rz_mtu3_pwm->prescale[ch];
> +	}
> +
> +	pv =3D rz_mtu3_pwm_calculate_pv_or_dc(period_cycles, prescale);
> +
> +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle, rz_mtu3_pwm-
> >rate,
> +				      NSEC_PER_SEC);
> +	dc =3D rz_mtu3_pwm_calculate_pv_or_dc(duty_cycles, prescale);
> +
> +	/*
> +	 * If the PWM channel is disabled, make sure to turn on the clock
> +	 * before writing the register.
> +	 */
> +	if (!pwm->state.enabled) {
> +		int rc;
> +
> +		rc =3D pm_runtime_resume_and_get(chip->dev);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	val =3D RZ_MTU3_TCR_CKEG_RISING | prescale;
> +
> +	/* Counter must be stopped while updating TCR register */
> +	if (rz_mtu3_pwm->prescale[ch] !=3D prescale && rz_mtu3_pwm-
> >enable_count[ch])
> +		rz_mtu3_disable(priv->mtu);
> +
> +	if (priv->map->base_pwm_number =3D=3D pwm->hwpwm) {
> +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR,
> +				      RZ_MTU3_TCR_CCLR_TGRA | val);
> +		rz_mtu3_pwm_write_tgr_registers(priv, RZ_MTU3_TGRA, pv,
> +						RZ_MTU3_TGRB, dc);
> +	} else {
> +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR,
> +				      RZ_MTU3_TCR_CCLR_TGRC | val);
> +		rz_mtu3_pwm_write_tgr_registers(priv, RZ_MTU3_TGRC, pv,
> +						RZ_MTU3_TGRD, dc);
> +	}
> +
> +	if (rz_mtu3_pwm->prescale[ch] !=3D prescale) {
> +		/*
> +		 * Prescalar is shared by multiple channels, we cache the
> +		 * prescalar value from first enabled channel and use the
> same
> +		 * value for both channels.
> +		 */
> +		rz_mtu3_pwm->prescale[ch] =3D prescale;
> +
> +		if (rz_mtu3_pwm->enable_count[ch])
> +			rz_mtu3_enable(priv->mtu);
> +	}
> +
> +	/* If the PWM is not enabled, turn the clock off again to save
> power. */
> +	if (!pwm->state.enabled)
> +		pm_runtime_put(chip->dev);
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_pwm_apply(struct pwm_chip *chip, struct pwm_device
> *pwm,
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
> +	mutex_lock(&rz_mtu3_pwm->lock);
> +	ret =3D rz_mtu3_pwm_config(chip, pwm, state);
> +	mutex_unlock(&rz_mtu3_pwm->lock);
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
> +	struct rz_mtu3 *parent_ddata =3D dev_get_drvdata(pdev->dev.parent);
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm;
> +	struct device *dev =3D &pdev->dev;
> +	unsigned int i, j =3D 0;
> +	int ret;
> +
> +	rz_mtu3_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*rz_mtu3_pwm),
> GFP_KERNEL);
> +	if (!rz_mtu3_pwm)
> +		return -ENOMEM;
> +
> +	rz_mtu3_pwm->clk =3D parent_ddata->clk;
> +
> +	for (i =3D 0; i < RZ_MTU_NUM_CHANNELS; i++) {
> +		if (i =3D=3D RZ_MTU3_CHAN_5 || i =3D=3D RZ_MTU3_CHAN_8)
> +			continue;
> +
> +		rz_mtu3_pwm->channel_data[j].mtu =3D &parent_ddata-
> >channels[i];
> +		rz_mtu3_pwm->channel_data[j].mtu->dev =3D dev;
> +		rz_mtu3_pwm->channel_data[j].map =3D &channel_map[j];
> +		j++;
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
> +	 * Refuse clk rates > 1 GHz to prevent overflow later for
> computing
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
> +	ret =3D devm_add_action_or_reset(&pdev->dev, rz_mtu3_pwm_pm_disable,
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
>=20
> base-commit: 9f258af06b6268be8e960f63c3f66e88bdbbbdb0
> prerequisite-patch-id: 7d5c55db908971d16a58eb46b25d42dfb0f680ec
> prerequisite-patch-id: 6c15d33bb612750523d14af87a5cf9e6ff142540
> prerequisite-patch-id: e5e4d86a0a012a59f585b84ce7ae0d3f047787dc
> prerequisite-patch-id: d62b4e1326f1518fd30eb98a37bfb4998573979a
> prerequisite-patch-id: 15bf63b610cab275387a2bbee7ab2a0a48414f75
> --
> 2.25.1

