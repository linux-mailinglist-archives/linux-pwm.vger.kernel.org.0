Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4596FA1A9
	for <lists+linux-pwm@lfdr.de>; Mon,  8 May 2023 09:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjEHH4U (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 May 2023 03:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbjEHH4T (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 May 2023 03:56:19 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2123.outbound.protection.outlook.com [40.107.113.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E4A1FEB;
        Mon,  8 May 2023 00:56:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtQoIZL4CUS4MxnBi5rrTCa/WqLJQB/3Y4FmblqgWvW6Rjm4xvcqAIeaHkDGF9Ug8qzLO8Ei3EOcmu7BE5G0tyjz85vUCk8ZeonJcIi90pgvkD3enipsOo50YEI+lCu8sr4jMPR2vgzUcJzDZ0YQXpaTv4MKLKVskAf2K0S5dKU6iMtXFQEYNGqjNCtXcOUWrL2lL6NyXNXAdByW6Re0SOUkAhGbIGogNu6f/oZ2RzDUFu+NvEocFIqrLO9ruF94iRV6zcU3rfJy6Wxn8hJagq1QXxoBpyDgPsfPyznHs0S9RAsdZJVVWsYE3pIdNCaXpyhjlWbjWnCiPFKFR8p2mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlRXuIw1D14mdZG44+xIiWXQh5K3vEz0Y8nbSQOJat8=;
 b=jq6SEn8GrY/uMizH2wntT5hablcRT2dL5xLa8Qx7JmXIZj6aa6lFZUMAVQNGE1ZCpaImmux3s8UJoI3mcCCOKC0mnekYMrC6n4pcu4TtH+qZSGC8tDnebEgp5fVLFe9A+g3E4Z0/IlDc37IxWw+IXSyLgkBsuPgFGdzdqCeWYJoand6eOmj2yXKT9NJOKYqRIr67YBhMJs1Q7Wmkn/UN42YTr1PmN5apFLyh/8xiDWLfbcZlCPRF1jYvHns3Mjly7IalgkKqiFlvVIwHqVVT2dLI4qzl7EXRDSppQIp/d9F8OD19S5pBSRi/y9NVJhZZr7KUDp+dmUAz7qREMVIgtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlRXuIw1D14mdZG44+xIiWXQh5K3vEz0Y8nbSQOJat8=;
 b=vku3LwtlK/MXUQDPn2AY9jAcWXrpcMxP1LJObYVEJCKcZUnjSd1rkoVo2i/HpVSPBc2jQquEW8wl9aGZeXvx7gbPCnlBf3oJDX/6LrC+9ZrwDwxMuk7r6Q/zGhWX0NYKMKQ7jwYT9KP7tAi96tBckRvfB6e964TpvhbLZOo2TG0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYYPR01MB10610.jpnprd01.prod.outlook.com (2603:1096:400:30a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 07:56:11 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 07:56:08 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v16] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Topic: [PATCH v16] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Index: AQHZcd9vSL7mgT59Q0WiNyhNNIZK3a9QIGbg
Date:   Mon, 8 May 2023 07:56:08 +0000
Message-ID: <OS0PR01MB5922D142435F4755009E6F6D86719@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230418102037.346405-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230418102037.346405-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYYPR01MB10610:EE_
x-ms-office365-filtering-correlation-id: ab6af46e-0a70-499f-0cc7-08db4f99aef6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KuD35aAj1ul9qqe3OvBM7yQ3ekk6f8R4KB5dSn2UFc16uS9CBtcEuYWQvGs3cahwCQ1bVGM0/5FY10rxT0DrmHuuklg81wR7LSJw/9BMsRvy5jaZHWa07BJJ9bMyYcMl49Z+cInnHql7B0RPWCccR6KG8NXCMqZ9I8rlPE69BDDiNYHyKzN/UCJTaQHZBNorNM142ZQCYljPVljMF91MriRjzaXZzI9B6BOfiO9i8Kr6NlGfA/Zd3m263w9qFNjDTnHB6Hjq2M6/EyrKfQGv3oFzg00+kVWYe4eB1VqSa+s6h2lFBvSfCH3Z5Wk+GlTDOu3a5kuSaBf5zVWhA06uxWqXUYh0m87UO+Mqh/Wim1xGoGknYcaDqK9ZXho8dtzLottV4WCKIOkVZx7esMRI4lDKkA/sHmbwb2ewNKg+dX0suQjvEJXCbXNpaJ1N7depxFedO8aLSSsofeBEeFeMk38fzN9sfSd88S7tZ+TGpbfo/RKImVyWzCVYy3n00QAg1uZzcwrejdKkG1jAB7bqBjKPLeiP84aTV3rSqWFjs2VrkgQ5AmVw5ax0Qb838hf83otpR/jNkp2X5f2G1VjcE/07kS9xijS88gTGg8G3Gm+an+/0VXXR7ly4eMBc4YvovA4O9A9sh5hObITLFlezWXlu1VXXOWC8IZZD/RBNTHg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199021)(122000001)(71200400001)(38070700005)(38100700002)(55016003)(66574015)(26005)(186003)(30864003)(6506007)(9686003)(83380400001)(53546011)(33656002)(2906002)(52536014)(8936002)(8676002)(7696005)(478600001)(110136005)(54906003)(316002)(86362001)(4326008)(5660300002)(41300700001)(64756008)(66556008)(66446008)(66476007)(66946007)(76116006)(966005)(32563001)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JEFz13DM0oR1WwrALTs3UrQnl+KhFDdkxLKXMlRtW37yNTaEh2cxX2plHe?=
 =?iso-8859-1?Q?9XDju6nIxNWiE2aq7CXMKF+bF2p87oqgfsTL+hp5zSdMr0HRoaWFsamCye?=
 =?iso-8859-1?Q?QGgTIQDKk6raewKciAQTTOVxSJ0+OL3vEG36nD2Q4Yr1wADTRuZ/aF/iaH?=
 =?iso-8859-1?Q?cN2+8JreZkFGycUsCE+myfK0K6uhbSEJAjN/pFVdRWhPW9IZH6kwR3DriN?=
 =?iso-8859-1?Q?90VDu3HJqJKXjGRF0tNsXO11LdRXI5t9BKUPSmiu3N34JPZTD5x8R8n3ni?=
 =?iso-8859-1?Q?LD6C4Ggd2VwXVu3RtXQ99ddr2S3KdPXzDSY2RJS6kbpQv06rGFPqWt78n8?=
 =?iso-8859-1?Q?2huTQdPnM2rdCJ/V7TETGasEYq4KEajLIcRDMazNioI6QPq3cqD0Q0KCmM?=
 =?iso-8859-1?Q?sOWetsweowfRDTi92R5HwPS5hl2QCPvdH5DKeDnCc/9pLX6YKN50TLvoCg?=
 =?iso-8859-1?Q?fF+olO+0YlotEnizoH5JGCB4UdirQXAYGIcEXqm8dQXhj2GML95fpFS0YB?=
 =?iso-8859-1?Q?+gPxGKyc5luDCbjN/KVKHRuJtxnR+5HdKVlQIEoKi08WEOmu0aITn0cBoB?=
 =?iso-8859-1?Q?PweoA+YlxqYXBdbwPKHGjOnSRBD8XMZEEspSJKXA3W5CetZ3yB1h8M9P/d?=
 =?iso-8859-1?Q?4sWrM0+neTBLP2wCBkta9jwgTUua0a5D8wnjdXpr8RwZpSr2p/7GIrnnM5?=
 =?iso-8859-1?Q?QvOxa8/VVnyl2QzcyyW9xXZKFnld9Y9wetxgdhj3Omp7a8M3J1FJM7ri53?=
 =?iso-8859-1?Q?FMZ3y/HYIK0vrokobpbg+1DgY3vuPxkjfUiZmpA2ooSlDMhqR4C1pOoMGs?=
 =?iso-8859-1?Q?uCJI+VLfHKfv5T8NvBEgrOR9ZqysZG4SGqdudNcSsRdSHp61kW1N404V4G?=
 =?iso-8859-1?Q?K+XNnJYXFr3g1lRtM6JsCauuP2hyev3niux1iCtU5+JNNGxjX3mmMDgYra?=
 =?iso-8859-1?Q?lWMF7zyZy4r7QB9knIF4I519ca70tqH4yRORVagZ36omT7tdlRQ73qLlXG?=
 =?iso-8859-1?Q?XAhES3GooburMS1Hxzor6Ut35i0iKo0F1FYrjzEGSm4WSvbaRd3V3B+/7r?=
 =?iso-8859-1?Q?XB5Z4yS3A66sQMx/egoD3Zmn8v9nNZJD0aYxf2+uyjddXlPI9wD7lygyJ6?=
 =?iso-8859-1?Q?gbe97KWhChIhMDFgxatvCr9l872M/NgJsKAS8zorc9fK7xtA6BcqnjJlfv?=
 =?iso-8859-1?Q?nzYXLJVuiu8ZP/ASJ3mcbpKxcKHKi9zl3Dfwbs2d95YCsEpvxDDcshWsbr?=
 =?iso-8859-1?Q?QOzzELnCzyclz9K9/vtIKZUwTrUNm7yrL0IR/L+uaLN8S2Uk3HXcC32pum?=
 =?iso-8859-1?Q?EhVBMOg97HYb6F8Cbut5gTKH6stR8DpfFnlDI3fVLx3Mw5ci/4xR+0Y6PJ?=
 =?iso-8859-1?Q?MB3Zqnw/ig/OCbdxZS7/R0OL3L+YX9BjvnRaqSd2COEXtbHmAv72XAF75L?=
 =?iso-8859-1?Q?HpyB4WOmtcF1UkoJkBqHRAjl6Cw9bAj9DdEzDCdG2MNIl9noTCh9RbC4+n?=
 =?iso-8859-1?Q?2ztuKz/JMCBSjfbqTGG+v0XovpQN/86jqyt9cTnqs0WKoNlfJUeaf/N1it?=
 =?iso-8859-1?Q?+FeRYLT0NbL/y+pcHnxust40+xEcX5xKJ4NdCUURnzZ2q+mhx52JbeYghM?=
 =?iso-8859-1?Q?7KC42UKDkhyaz+T9iHzvqQwgN3xWpdDKlD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6af46e-0a70-499f-0cc7-08db4f99aef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 07:56:08.6411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V4APgGLvTdYc3gvbD6RzzCuLVDu4md9ZJT3qCoF3PA4Fzdz8EDS4qrEKsMeSgy/akp7J/vvZdtlZ0CsjmACWn+5rHfn4WGZG5/8CIPsOjBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10610
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

The dependency patch[1] hits on v6.4-rc1.

So are you happy with this patch? or do you want me to rebase and resend th=
e patch
on Linux-pwm? Please let me know.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/?h=
=3Dv6.4-rc1


Cheers,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Tuesday, April 18, 2023 11:21 AM
> To: Thierry Reding <thierry.reding@gmail.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Uwe Kleine-K=F6nig <u.kleine-
> koenig@pengutronix.de>; linux-pwm@vger.kernel.org; Geert Uytterhoeven
> <geert+renesas@glider.be>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>; linux-renesas-soc@vger.kernel.org
> Subject: [PATCH v16] pwm: Add Renesas RZ/G2L MTU3a PWM driver
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
> This patch series depend upon linux-next [1] [1]
>=20
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
>  * Introduced new mapping table struct rz_mtu3_channel_io_map to hold the
>    index of the lowest PWM and the number of PWMs handled by the HW chann=
el.
>  * Introduced struct rz_mtu3_pwm_channel to hold mtu3 channel data and
>    mapping table.
>  * Replaced rz_mtu3_get_hw_channel->rz_mtu3_get_channel and channel->hwpw=
m.
>    The rz_mtu3_get_channel() returns struct rz_mtu3_pwm_channel*
>  * Dropped rz_mtu3_pwm_is_second_channel() as same can be obtained direct=
ly
>    with new mapping (ie, priv->map->channel =3D=3D pwm->hwpwm)
>  * Replaced ch_index->ch throughout and used "priv - rz_mtu3_pwm-
> >channel_data"
>    to find ch and dropped rz_mtu3_get_hw_channel_index().
>  * Optimized rz_mtu3_pwm_is_ch_enabled() by exit early, if is_channel_en =
is
> false.
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
>  * Fixed a kernel crash in error path by moving rz_mtu3_pwm->chip.dev bef=
ore
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
>  drivers/pwm/pwm-rz-mtu3.c | 539 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 551 insertions(+)
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
> 19899b912e00..68b7a15c2ca5 100644
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
> diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c new fi=
le
> mode 100644 index 000000000000..4e63c20e3198
> --- /dev/null
> +++ b/drivers/pwm/pwm-rz-mtu3.c
> @@ -0,0 +1,539 @@
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
> + * - HW uses one counter and two match components to configure duty_cycl=
e
> + *   and period.
> + * - Multi-Function Timer Pulse Unit (a.k.a MTU) has 7 HW channels for P=
WM
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
> +	{ 0, 2 }, { 2, 1 }, { 3, 1 }, { 4, 2 }, { 6, 2 }, { 8, 2 }, { 10, 2 }
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
> +static struct rz_mtu3_pwm_channel *
> +rz_mtu3_get_channel(struct rz_mtu3_pwm_chip *rz_mtu3_pwm, u32 hwpwm) {
> +	struct rz_mtu3_pwm_channel *priv =3D rz_mtu3_pwm->channel_data;
> +	unsigned int ch;
> +
> +	for (ch =3D 0; ch < RZ_MTU3_MAX_HW_CHANNELS; ch++, priv++) {
> +		if (priv->map->base_pwm_number + priv->map->num_channel_ios >
> hwpwm)
> +			break;
> +	}
> +
> +	return priv;
> +}
> +
> +static bool rz_mtu3_pwm_is_ch_enabled(struct rz_mtu3_pwm_chip *rz_mtu3_p=
wm,
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
> +		is_mtu3_channel_available =3D rz_mtu3_request_channel(priv->mtu);
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
> +	val =3D RZ_MTU3_TIOR_OC_IOB_TOGGLE | RZ_MTU3_TIOR_OC_IOA_H_COMP_MATCH;
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
> +static int rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_devic=
e
> *pwm,
> +				 struct pwm_state *state)
> +{
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +
> +	pm_runtime_get_sync(chip->dev);
> +	state->enabled =3D rz_mtu3_pwm_is_ch_enabled(rz_mtu3_pwm, pwm->hwpwm);
> +	if (state->enabled) {
> +		struct rz_mtu3_pwm_channel *priv;
> +		u8 prescale, val;
> +		u16 dc, pv;
> +		u64 tmp;
> +
> +		priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
> +		if (priv->map->base_pwm_number =3D=3D pwm->hwpwm)
> +			rz_mtu3_pwm_read_tgr_registers(priv, RZ_MTU3_TGRA, &pv,
> +						       RZ_MTU3_TGRB, &dc);
> +		else
> +			rz_mtu3_pwm_read_tgr_registers(priv, RZ_MTU3_TGRC, &pv,
> +						       RZ_MTU3_TGRD, &dc);
> +
> +		val =3D rz_mtu3_8bit_ch_read(priv->mtu, RZ_MTU3_TCR);
> +		prescale =3D FIELD_GET(RZ_MTU3_TCR_TPCS, val);
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
> +static u16 rz_mtu3_pwm_calculate_pv_or_dc(u64 period_or_duty_cycle, u8
> +prescale) {
> +	return (period_or_duty_cycle >> (2 * prescale)) <=3D U16_MAX ?
> +		period_or_duty_cycle >> (2 * prescale) : U16_MAX; }
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
> +	prescale =3D rz_mtu3_pwm_calculate_prescale(rz_mtu3_pwm, period_cycles)=
;
> +
> +	/*
> +	 * Prescalar is shared by multiple channels, so prescale can
> +	 * NOT be modified when there are multiple channels in use with
> +	 * different settings. Modify prescalar if other PWM is off or handle
> +	 * it, if current prescale value is less than the one we want to set.
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
> +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle, rz_mtu3_pwm->rate,
> +				      NSEC_PER_SEC);
> +	dc =3D rz_mtu3_pwm_calculate_pv_or_dc(duty_cycles, prescale);
> +
> +	/*
> +	 * If the PWM channel is disabled, make sure to turn on the clock
> +	 * before writing the register.
> +	 */
> +	if (!pwm->state.enabled)
> +		pm_runtime_get_sync(chip->dev);
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
> +		 * prescalar value from first enabled channel and use the same
> +		 * value for both channels.
> +		 */
> +		rz_mtu3_pwm->prescale[ch] =3D prescale;
> +
> +		if (rz_mtu3_pwm->enable_count[ch])
> +			rz_mtu3_enable(priv->mtu);
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
> +		rz_mtu3_pwm->channel_data[j].mtu =3D &parent_ddata->channels[i];
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
> --
> 2.25.1

