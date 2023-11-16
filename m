Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424127EE713
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Nov 2023 20:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjKPTAT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Nov 2023 14:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKPTAT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Nov 2023 14:00:19 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2129.outbound.protection.outlook.com [40.107.114.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B2F182;
        Thu, 16 Nov 2023 11:00:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQLa2LZOXWWgPHUPWYrplMS93PoZExatGgnuMD3A83J1o0By41EwtNtN1p84p3M+W772cH3jbyS2BrruNUBMPi8hfqEStswNiJ1OJGXDJKb96YMlCMY2zXvknCT2JXTTLTRTXsdKPRlWY1lTmfQeT6wmuogmZoIl+6usX/V8kCoovaWMy0eZYBhLfU5jujhLvojiPT1zdm6SJI6Po96rNQEYk5GdmwNEG+m2IAabDKrnoBu5SYB9AtK4zmIh/nqQCS2bdH4Qp3frDUcLYR+fGZQr9nWOApC/q/g1Je6u5wo29q/u6AWDFzdxoubzKDOWCcIAx1rEUJ3hEmoz+tJNGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIu9M9AaRTGXT/GuLGtjFKCzGLRTNFPPk1xrwG9Dh50=;
 b=a/cyDfXTTpHnXy0kXeKCgTu4l/176sBEIctmQ4YRWEM2664c6pJtJupwQIHTiK9Wiw3wQxGBFtdrLUsjWkSZXQBKuPWQpgLMG92/uOAHV07omxKLY1+f7M017u9aXBqalyzbX8nEnEu1D4UMupBGyuJUt9RVRKwaMFDtUH4jr+Ldotx3Aqx4Zyo0oNbPvpX8G0NHrO+7jKQWpxz6o7i+uyUUrHO4ztKdmAVddoFHEIDoV0XSjFC8gSpQFjCjC2trxfHoHLT4aKwBa2y+hbNF91gG7fHOaUQbaIZJNafgVSnnPlsusJ2AuX08Dyjjcbwxy+HT3aHb1qU9xyVA4+oMOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIu9M9AaRTGXT/GuLGtjFKCzGLRTNFPPk1xrwG9Dh50=;
 b=wylEy4DDXYyTjde+5431qo3LQJNXuOrAgvCBzCsSaJFVCh4x+ZfwUiosDflsGCodsxfrwUchQNv0LIK8pVYPNq/kwb/T174ujrbD1Y3aSM5RAUXKqaD+jVnCTZSFJgwzeQexy8yyzAk2XYJqieUWulvQ2vW3pG3GcCTF1BHqSOA=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OSZPR01MB8497.jpnprd01.prod.outlook.com
 (2603:1096:604:186::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Thu, 16 Nov
 2023 19:00:06 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6069:90c7:909:c89b]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6069:90c7:909:c89b%7]) with mapi id 15.20.7002.022; Thu, 16 Nov 2023
 19:00:00 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v16 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v16 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHZ9rQMFWDsgVRgWEOut3JS4AjEP7B9bN9g
Date:   Thu, 16 Nov 2023 19:00:00 +0000
Message-ID: <TYCPR01MB112699BBDA620567EA36AE2AC86B0A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231004111451.126195-1-biju.das.jz@bp.renesas.com>
 <20231004111451.126195-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20231004111451.126195-4-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OSZPR01MB8497:EE_
x-ms-office365-filtering-correlation-id: 1d17f22b-56a5-4abe-9529-08dbe6d63c1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jgEC/NDqtJtTPExfFLCRQ/x+cLYMnkUhCZRivobAZVH2ItFcpe4q/gAZkFiVFnxH5kMI5n8QmqswzLQEfmLvHUkfx7OPRr5Eq1/4BOdHrQrU2857IEYbENDEmHOTC4LPx0mJscaZ1hOVx7n9RMF8xYoz05796tok6NvWPu0ccQO9fHkqik1RTrNPLLcaNyVExrDyUJDyRRWDywJMdyT217NviYlVQoD3jf6jocICzsW1Rixndip1xL7Fh4WeDyrFnADh1cDyQ3aO8d1Ku4tW3Buest89h7dycfm01QwugO2+j+eHHnuTp3QRS35rMsTqHrCdXUpKQbKhT25RiByDg3pSRtj97mKlqVp+T2da0pLrw++FThz0ByZmYPt3DJmSUB6Nmmdtm4+r7EQyPHNTHmmQT8k/ozxr+uDlN8B1DqB3KoMxIh9TqGIIdNHTJAdj3+WN2iOJlxcRUqTQRvsZ4eGGmgdOsSsp3ff38c1SNTvEY3HMku2ufJQhkNbrK/1utz1y20mZNI2ZfXCDjHvRwV2J8zqj+mKaHfISJ/7OHs0tj9201DxCLQ7iGom1nAe6VAWQoADfukZw4tLHSmfqF15w2Jeh+EUSrJOhMJWswzQyUpLJUM9LTrbjXpKSQnfTpC4hd+HMBLkYllkl7chrCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799009)(55016003)(478600001)(71200400001)(53546011)(26005)(9686003)(7696005)(6506007)(122000001)(38100700002)(86362001)(33656002)(5660300002)(4326008)(66446008)(76116006)(64756008)(66946007)(110136005)(41300700001)(2906002)(30864003)(107886003)(83380400001)(38070700009)(66476007)(52536014)(66556008)(8936002)(54906003)(8676002)(316002)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rCyJiw3o/MJrvte7L0y/InOuBXUXNGNu77gB7YIGvTJVNgYRyLHTTFkaQv?=
 =?iso-8859-1?Q?/DX00cyexsb4p4kHiOp3prH9JTqJGAsP8GV12fYph43qaInk9glmuImK7M?=
 =?iso-8859-1?Q?3zRMtbNqSAjXEpSVzRdlcBKFRZFyj4Ow2AIj9K2Uv96S3chyP+ELqI9/uZ?=
 =?iso-8859-1?Q?QknCw8Ghneah5lDyhALadluznmabXDxmZmt2XzajJvgJWK7uSnKYM0Adro?=
 =?iso-8859-1?Q?UaUItk6XjZdWTduhQZcTTFFn83Ojyyl2bVyQLuXqPhyZ0aghg/eS8tcAEM?=
 =?iso-8859-1?Q?GwMIGIU7c5cOSf+yo9iUAhG7fNPKXbgeF/aHnI8FQYUY7Lt0gdn/ZEHifF?=
 =?iso-8859-1?Q?QvviQV8n3o44gk2FHSbf18Kpa9VuxP4KM5O7q1VQVWQaVAx2in3EdAIm6m?=
 =?iso-8859-1?Q?YI9LmgnR5F5jxz0Qg91P3uc9uA1SgIKN+de410xG4M2uLp3S5KSvGpVOPJ?=
 =?iso-8859-1?Q?i8Qh1c4bp/YvNG/8kHWt+zbG1bWwehKAq97cvwf1L0UpuK6bhKi7oGR4EF?=
 =?iso-8859-1?Q?owFXv/cy8rhcccXocJDbqAfM3YLM/8G9kCSlF+HooRtqwL8qNwChqxSMxa?=
 =?iso-8859-1?Q?WojwsMRnb5tZt6iQaPyJrKUdBakG/Wbr9+sD0Pwh1nZF28j7Tp+oA+REhG?=
 =?iso-8859-1?Q?Vv2tzKnenQmfPKOhCQZrR0oW1w908DmLHIZI6lwiyy5ufxsobeHpfcZ0uM?=
 =?iso-8859-1?Q?Q98oiDSOSRsGOgfta6tXo6mJHS2SqQOOhnLQtb0iZDtGu4D27R37Twgpyj?=
 =?iso-8859-1?Q?S9GW29UmFWzKPav0vkZ0rb2RvyGZZVjcvR4Ha3SAj9BNV0/5e01q5LxiEg?=
 =?iso-8859-1?Q?uu4ygWp/vITW2l2m2h4Q8dbMndAuCLVdpcBBZjSwdsuDCmN82cYo4G6j11?=
 =?iso-8859-1?Q?Eq3oemN0q8JNan5wFxkEXYccybMJ36yZ7IGIpgl5aj5PO1n7xNhY3SQtou?=
 =?iso-8859-1?Q?+Ads291MTFCCo6w2EYnocrzOo7c51qRrMJAZXxR4aYv/6Xv6OA9kS7mkcs?=
 =?iso-8859-1?Q?AVs4pQ6gpc1zPjBvqfmWvs1RNU964Awogz6tYZGbVTHO16hwryQmI9zyKV?=
 =?iso-8859-1?Q?o5dgVNtxMBrXrEVQVpwHhcaahbUhXZcppCXUayRgL8a7ifCI4bnKN2xlfC?=
 =?iso-8859-1?Q?jorZrFGa7KfLHamKdJxidNbFlPGEolHZ4RN835u1o3S6T7uj+OcnplIyRA?=
 =?iso-8859-1?Q?gkPPikp6/dpH62hOgoDI0lV2WwtAwlX8xKopdamm6HamRhDZs0ebye1Bes?=
 =?iso-8859-1?Q?z0NSWUDmgF4woAjUnMxWxzxEiiPBkTkzAunSMz3b6+BBw/AKmAG7R5Ciha?=
 =?iso-8859-1?Q?dao2atT5VpfJ84oQT6HaHBYyTKbNqA94MazGDpr9Jfc3VZG4BqoQDFFj7t?=
 =?iso-8859-1?Q?oHrYEAfO36/hzoF0w9x3W2hmu30e0mFfkDzNL3ZlhYq9rqUYkjyLvMmVzX?=
 =?iso-8859-1?Q?ZqEv9ReyEm/m7Marh8aZDLWHsmorb9M79eo7klcN0x9MTwywGCFu2nZNh1?=
 =?iso-8859-1?Q?0+qm2iol+o7VnKBrGvgGqfyPVNb22awusO4ypb6yf3J+idwpNZVxrHUGVh?=
 =?iso-8859-1?Q?lLq7nVz+XH5/h1plJVPpP4J3liyJJLgfX/WZiSgPJyTp92bNJTAp12KBi2?=
 =?iso-8859-1?Q?2QaIq+Q1AaeTEAS5tZuB0+8rVTsrhQXrLeaM/yDZVR4YO0AgOvgk1hcA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d17f22b-56a5-4abe-9529-08dbe6d63c1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 19:00:00.8825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bJvgzF6USHC42ZuPwNi7/qpsV9aJvvt5iy+KxnkiVkSEH1rCk8D1dnS2nj/sqSx19CS7Ifg+fZ2YrhJUb/qx1DuYoj7WvIU6OknTrgsfaWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8497
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Uwe,

The clock rate for RZ/G2L family SoCs is 100 MHz.

With this, maximum possible period in nsec =3D  2^32 * 10 nsecs * 1024 (pre=
scale) =3D 43,980,465,111,040 nsec which is well below than
2^64.

So I am planning to reject the PWM Period  > 43,980,465,111,040 nsecs in ap=
ply on next version.

Please correct me, if It is wrong.

Cheers,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Wednesday, October 4, 2023 12:15 PM
> Subject: [PATCH v16 3/4] pwm: Add support for RZ/G2L GPT
>=20
> RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit timer
> (GPT32E). It supports the following functions
>  * 32 bits =D7 8 channels
>  * Up-counting or down-counting (saw waves) or up/down-counting
>    (triangle waves) for each counter.
>  * Clock sources independently selectable for each channel
>  * Two I/O pins per channel
>  * Two output compare/input capture registers per channel
>  * For the two output compare/input capture registers of each channel,
>    four registers are provided as buffer registers and are capable of
>    operating as comparison registers when buffering is not in use.
>  * In output compare operation, buffer switching can be at crests or
>    troughs, enabling the generation of laterally asymmetric PWM waveforms=
.
>  * Registers for setting up frame cycles in each channel (with capability
>    for generating interrupts at overflow or underflow)
>  * Generation of dead times in PWM operation
>  * Synchronous starting, stopping and clearing counters for arbitrary
>    channels
>  * Starting, stopping, clearing and up/down counters in response to input
>    level comparison
>  * Starting, clearing, stopping and up/down counters in response to a
>    maximum of four external triggers
>  * Output pin disable function by dead time error and detected
>    short-circuits between output pins
>  * A/D converter start triggers can be generated (GPT32E0 to GPT32E3)
>  * Enables the noise filter for input capture and external trigger
>    operation
>=20
> Add basic pwm support for RZ/G2L GPT driver by creating separate logical
> channels for each IOs.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v15->v16:
> * Replaced the macro DIV_ROUND_UP_ULL->DIV64_U64_ROUND_UP
> * Added DIV_ROUND_UP in rzg2l_gpt_calculate_pv_or_dc() to avoid loss of
>   precision.
> * Replaced min->min_t() in rzg2l_gpt_calculate_pv_or_dc().
> * Added a comment for rzg2l_gpt_config()
> * Replaced mul_u64_u32_div()->mul_u64_u64_div_u64() in rzg2l_gpt_config()
> * Fixed the logical condition related to counter stop in
>   rzg2l_gpt_config().
> * Dropped pm_runtime_resume_*() from rzg2l_gpt_config() as it is managed
>   by rzg2l_gpt_apply().
> * Moved pm_runtime_resume_*() from rzg2l_gpt_{en,dis}able() to
>   rzg2l_gpt_apply().
> v14->v15:
> * Added enable_count and ch_en_bits variables to struct rzg2l_gpt_chip
>   based on feedback for pwm_mtu3 driver.
> * Updated copyright header and commit description by replacing "This patc=
h
>   adds"-> "Add"
> * Replaced macro RZG2L_GET_CH_INDEX->RZG2L_GET_CH and replaced ch_index-
> >ch
>   throughout
> * rzg2l_gpt_{enable,disable}() enables/disables PWM based on the
>   enable_count.
> * Replaced pm_runtime_get_sync->pm_runtime_resume_and_get and propogated
>   the error in rzg2l_gpt_get_state() and rzg2l_gpt_config()
> * Reduced variable scope in rzg2l_gpt_get_state() by moving most of
> variables
>   inside the if statement.
> * Updated rzg2l_gpt_get_state() by moving duty > period check
>   inside the top if block.
> * Added helper functions rzg2l_gpt_calculate_pv_or_dc()to simplify config=
.
>   Also Improved the logic in rzg2l_gpt_calculate_pv_or_dc() by using
>   min(period_or_duty_cycle >> (2 * prescale), (u64)U32_MAX);
> * Updated rzg2l_gpt_get_state() by moving duty > period check
>   inside the top if block.
> * Simplified rzg2l_gpt_config() for updating registers
> * Dropped pm_runtime_get_sync() and used bitmap variable "ch_en_bits"
>   to make balanced PM usage count in rzg2l_gpt_reset_assert_pm_disable()
>   For case were unbind is called before apply where pwm is enabled by
>   bootloader.
> * Added error check for clk_rate_exclusive_get() and clk_get_rate() in
>   probe().
> * Dropped prescale from struct rzg2l_gpt_chip.
> * Replaced of_match_ptr(rzg2l_gpt_of_table)->rzg2l_gpt_of_table in struct
>   rzg2l_gpt_driver
> v13->v14:
>  * Removed parenthesis for RZG2L_MAX_HW_CHANNELS and RZG2L_CHANNELS_PER_I=
O
>  * Removed duty_cycle variable from struct rzg2l_gpt_chip and added
> comment
>    for cache for prescale variable.
>  * Fixed a bug in rzg2l_gpt_cntr_need_stop().
>  * Reordered rzg2l_gpt_config() just above apply()
>  * Replaced pwm_is_enabled()->pwm->state.enabled in config
>  * Replaced pm_runtime_resume_and_get with unconditional
> pm_runtime_get_sync()
>    in config().
>  * Restored duty_cycle > period check in rzg2l_gpt_get_state().
>  * Added error check for clk_prepare_enable() in probe() and propagating
> error
>    to the caller for pm_runtime_resume()
>  * clk_get_rate() is called after enabling the clock and
> clk_rate_exclusive_get()
>  * Simplified rzg2l_gpt_probe() by removing bitmap variables.
>  * Added pm_runtime_idle() to suspend the device during probe.
>  * Moved overflow condition check from config->probe().
>  * Simplified rzg2l_gpt_reset_assert_pm_disable().
> v12->v13:
>  * Replaced Kconfig dependency from ARCH_RENESAS->ARCH_RZG2L
>  * Sorted #include <linux/limits.h> alphabetically
>  * Added a comment for mutex_lock to fix check patch warning
>  * Replaced data type of duty_cycle from unsigned int->u32 as
>    the maximum value stored is U32_MAX.
>  * Improved rzg2l_gpt_config() by removing unwanted duty_cycle related
> code.
>  * Improved rzg2l_gpt_get_state() by setting "val =3D rzg2l_gpt-
> >duty_cycle[pwm->hwpwm];",
>    and factor "tmp =3D NSEC_PER_SEC * (u64)val;" out of the if-statement.
>  * Started using DEFINE_RUNTIME_DEV_PM_OPS(), and dropped __maybe_unused
>    from the callbacks.
> v11->v12:
>  * Added return code for get_state()
>  * Cache duty cycle/prescale as the driver cannot read the current duty
>    cycle/prescale from the hardware if the hardware is disabled. Cache th=
e
>    last programmed duty cycle/prescale value to return in that case.
>  * Updated rzg2l_gpt_enable to enable the clocks.
>  * Updated rzg2l_gpt_disable to disable the clocks.
>  * Updated rzg2l_gpt_config() to cache duty cucle/prescale value
>  * Updated rzg2l_gpt_get_state to use cached value of duty
> cycle/prescale,If the PWM
>    is disabled.
>  * Simplified rzg2l_gpt_apply()
>  * Added comments in rzg2l_gpt_reset_assert_pm_disable()
> v10->v11:
>  * Used bitmap_zero for initializing bitmap varable.
>  * Fixed clock imbalance during remove for the case bootloader turning
>    on PWM and module unload is called just after the boot.
>  * Fixed over flow condition in get_state() for a prescale value of 2 &
> more.
>  * Improved rzg2l_gpt_cntr_need_stop() based on prescale as it is the
>    only runtime variable.
>  * Added array for Cache variables state_period and prescale
>  * Probe caches the prescale value set by the bootloader.
>  * Updated rzg2l_gpt_config() to make use of array variables.
> v9->v10:
>  * Updated the error handling in probe(), clk_disable_unprepare called
>    on the error path.
>  * Removed ch_en array and started using bitmask instead.
> v8->v9:
>  * deassert after devm_clk_get() to avoid reset stays deasserted,in case
>    clk_get() fails.
>  * Removed ch_offs from struct rzg2l_gpt_chip and use macro instead.
>  * Updated error handling in probe()
> v7->v8:
>  * Modelled as single PWM device handling multiple channels
>  * Replaced shared reset->devm_reset_control_get_exclusive()
>  * Replaced iowrite32->writel and ioread32->readl
>  * Updated prescale calculation
>  * Added PM runtime callbacks
>  * Updated PM handling and removed "pwm_enabled_by_bootloader" variable
>  * Introduced rzg2l_gpt_is_ch_enabled for checking enable status on both
>    IO's
>  * Moved enable/disable output pins from config->enable/disable.
>  * Added rzg2l_gpt_cntr_need_stop() for caching prescalar/mode values.
> v6->v7:
>  * Added the comment for cacheing rzg2l_gpt->state_period.
>  * Fixed boundary values for pv and dc.
>  * Added comment for modifying mode, prescaler, timer counter and buffer
> enable
>    registers.
>  * Fixed buffer overflow in get_state()
>  * Removed unnecessary assignment of state->period value in get_state().
>  * Fixed state->duty_cycle value in get_state().
>  * Added a limitation for disabling the channels.
> v5->v6:
>  * Updated macros RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH and
>    RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH with computation
>    involving FIELD_PREP macro.
>  * Removed struct rzg2l_gpt_phase and started using RZG2L_GTCCR macro
>    for duty_offset.
>  * replaced misnomer real_period->state_period.
>  * Added handling for values >=3D (1024 << 32) for both period
>    and duty cycle.
>  * Added comments for pwm {en,dis}abled by bootloader during probe.
> v4->v5:
>  * Added Hardware manual details
>  * Replaced the comment GTCNT->Counter
>  * Removed the macros RZG2L_GPT_IO_PER_CHANNEL and chip.npwm directly
>    used in probe.
>  * Removed the unsed macro RZG2L_GTPR_MAX_VALUE
>  * Added driver prefix for the type name and the variable.
>  * Initialization of per_channel data moved from request->probe.
>  * Updated clr parameter for rzg2l_gpt_modify for Start count.
>  * Started using mutex and usage_count for handling shared
>    period and prescalar for the 2 channels.
>  * Updated the comment cycle->period.
>  * Removed clk_disable from rzg2l_gpt_reset_assert_pm_disable()
>  * Replaced pc->rzg2l_gpt.
>  * Updated prescale calculation.
>  * Moved pm_runtime_{get_sync,put} from {request,free}->{enable,disable}
>  * Removed platform_set_drvdata as it is unused
>  * Removed the variable pwm_enabled_by_bootloader
>  * Added dev_err_probe in various error paths in probe.
>  * Added an error message, if devm_pwmchip_add() fails.
> v3->v4:
>  * Changed the local variable type i from u16->u8 and prescaled_period_
>    cycles from u64->u32 in calculate_prescale().
>  * Replaced mul_u64_u64_div_u64()->mul_u64_u32_div()
>  * Dropped the comma after the sentinel.
>  * Add a variable to track pwm enabled by bootloader and added comments
>    in probe().
>  * Removed unnecessary rzg2l_gpt_reset_assert_pm_disable() from probe.
>  * Replaced devm_clk_get()->devm_clk_get_prepared()
>  * Removed devm_clk_get_optional_enabled()
> v2->v3:
>  * Updated limitation section
>  * Added prefix "RZG2L_" for all macros
>  * Modified prescale calculation
>  * Removed pwm_set_chip_data
>  * Updated comment related to modifying Mode and Prescaler
>  * Updated setting of prescale value in rzg2l_gpt_config()
>  * Removed else branch from rzg2l_gpt_get_state()
>  * removed the err label from rzg2l_gpt_apply()
>  * Added devm_clk_get_optional_enabled() to retain clk on status,
>    in case bootloader turns on the clk of pwm.
>  * Replaced devm_reset_control_get_exclusive-
> >devm_reset_control_get_shared
>    as single reset shared between 8 channels.
> v1->v2:
>  * Added Limitations section
>  * dropped "_MASK" from the define names.
>  * used named initializer for struct phase
>  * Added gpt_pwm_device into a flexible array member in rzg2l_gpt_chip
>  * Revised the logic for prescale
>  * Added .get_state callback
>  * Improved error handling in rzg2l_gpt_apply
>  * Removed .remove callback
>  * Tested driver with PWM_DEBUG enabled
> RFC->V1:
>  * Updated macros
>  * replaced rzg2l_gpt_write_mask()->rzg2l_gpt_modify()
>  * Added rzg2l_gpt_read()
> ---
>  drivers/pwm/Kconfig         |  11 +
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-rzg2l-gpt.c | 544 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 556 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> 6210babb0741..031ceaf09de7 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -503,6 +503,17 @@ config PWM_ROCKCHIP
>  	  Generic PWM framework driver for the PWM controller found on
>  	  Rockchip SoCs.
>=20
> +config PWM_RZG2L_GPT
> +	tristate "Renesas RZ/G2L General PWM Timer support"
> +	depends on ARCH_RZG2L || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This driver exposes the General PWM Timer controller found in
> Renesas
> +	  RZ/G2L like chips through the PWM API.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-rzg2l-gpt.
> +
>  config PWM_RZ_MTU3
>  	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
>  	depends on RZ_MTU3 || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile index
> c822389c2a24..d579825f11bf 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-raspberrypi-
> poe.o
>  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> +obj-$(CONFIG_PWM_RZG2L_GPT)	+=3D pwm-rzg2l-gpt.o
>  obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c ne=
w
> file mode 100644 index 000000000000..1289b7f72e09
> --- /dev/null
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -0,0 +1,544 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L General PWM Timer (GPT) driver
> + *
> + * Copyright (C) 2023 Renesas Electronics Corporation
> + *
> + * Hardware manual for this IP can be found here
> + *
> +https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-use
> +rs-manual-hardware-0?language=3Den
> + *
> + * Limitations:
> + * - Counter must be stopped before modifying Mode and Prescaler.
> + * - When PWM is disabled, the output is driven to inactive.
> + * - While the hardware supports both polarities, the driver (for now)
> + *   only handles normal polarity.
> + * - When both channels are used, disabling the channel on one stops the
> + *   other.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/limits.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +#include <linux/time.h>
> +
> +#define RZG2L_GTCR		0x2c
> +#define RZG2L_GTUDDTYC		0x30
> +#define RZG2L_GTIOR		0x34
> +#define RZG2L_GTBER		0x40
> +#define RZG2L_GTCNT		0x48
> +#define RZG2L_GTCCRA		0x4c
> +#define RZG2L_GTCCRB		0x50
> +#define RZG2L_GTPR		0x64
> +
> +#define RZG2L_GTCR_CST		BIT(0)
> +#define RZG2L_GTCR_MD		GENMASK(18, 16)
> +#define RZG2L_GTCR_TPCS		GENMASK(26, 24)
> +
> +#define RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE	FIELD_PREP(RZG2L_GTCR_MD, 0)
> +
> +#define RZG2L_GTUDDTYC_UP	BIT(0)
> +#define RZG2L_GTUDDTYC_UDF	BIT(1)
> +#define RZG2L_UP_COUNTING	(RZG2L_GTUDDTYC_UP | RZG2L_GTUDDTYC_UDF)
> +
> +#define RZG2L_GTIOR_GTIOA	GENMASK(4, 0)
> +#define RZG2L_GTIOR_GTIOB	GENMASK(20, 16)
> +#define RZG2L_GTIOR_OAE		BIT(8)
> +#define RZG2L_GTIOR_OBE		BIT(24)
> +
> +#define RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE	0x07
> +#define RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
> +
> +#define RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH \
> +	(RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE | RZG2L_GTIOR_OAE) #define
> +RZG2L_GTIOR_GTIOA_OUT_LO_END_TOGGLE_CMP_MATCH \
> +	(RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE | RZG2L_GTIOR_OAE) #define
> +RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH \
> +	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE)
> |
> +RZG2L_GTIOR_OBE) #define RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH \
> +	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE)
> |
> +RZG2L_GTIOR_OBE)
> +
> +#define RZG2L_GTCCR(i) (0x4c + 4 * (i))
> +
> +#define RZG2L_MAX_HW_CHANNELS	8
> +#define RZG2L_CHANNELS_PER_IO	2
> +#define RZG2L_MAX_PWM_CHANNELS	(RZG2L_MAX_HW_CHANNELS *
> RZG2L_CHANNELS_PER_IO)
> +
> +#define RZG2L_IS_IOB(a)	((a) & 0x1)
> +#define RZG2L_GET_CH(a)	((a) / 2)
> +
> +#define RZG2L_GET_CH_OFFS(i) (0x100 * (i))
> +
> +struct rzg2l_gpt_chip {
> +	struct pwm_chip chip;
> +	void __iomem *mmio;
> +	struct reset_control *rstc;
> +	struct clk *clk;
> +	struct mutex lock; /* lock to protect shared channel resources */
> +	unsigned long rate;
> +	u32 state_period[RZG2L_MAX_HW_CHANNELS];
> +	u32 user_count[RZG2L_MAX_HW_CHANNELS];
> +	u32 enable_count[RZG2L_MAX_HW_CHANNELS];
> +	DECLARE_BITMAP(ch_en_bits, RZG2L_MAX_PWM_CHANNELS); };
> +
> +static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip
> +*chip) {
> +	return container_of(chip, struct rzg2l_gpt_chip, chip); }
> +
> +static void rzg2l_gpt_write(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg,
> +u32 data) {
> +	writel(data, rzg2l_gpt->mmio + reg);
> +}
> +
> +static u32 rzg2l_gpt_read(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg) {
> +	return readl(rzg2l_gpt->mmio + reg);
> +}
> +
> +static void rzg2l_gpt_modify(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg,
> u32 clr,
> +			     u32 set)
> +{
> +	rzg2l_gpt_write(rzg2l_gpt, reg,
> +			(rzg2l_gpt_read(rzg2l_gpt, reg) & ~clr) | set); }
> +
> +static u8 rzg2l_gpt_calculate_prescale(struct rzg2l_gpt_chip *rzg2l_gpt,
> +				       u64 period_cycles)
> +{
> +	u32 prescaled_period_cycles;
> +	u8 prescale;
> +
> +	prescaled_period_cycles =3D period_cycles >> 32;
> +	if (prescaled_period_cycles >=3D 256)
> +		prescale =3D 5;
> +	else
> +		prescale =3D (fls(prescaled_period_cycles) + 1) / 2;
> +
> +	return prescale;
> +}
> +
> +static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device
> +*pwm) {
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +
> +	mutex_lock(&rzg2l_gpt->lock);
> +	rzg2l_gpt->user_count[ch]++;
> +	mutex_unlock(&rzg2l_gpt->lock);
> +
> +	return 0;
> +}
> +
> +static void rzg2l_gpt_free(struct pwm_chip *chip, struct pwm_device
> +*pwm) {
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +
> +	mutex_lock(&rzg2l_gpt->lock);
> +	rzg2l_gpt->user_count[ch]--;
> +	mutex_unlock(&rzg2l_gpt->lock);
> +}
> +
> +static bool rzg2l_gpt_is_ch_enabled(struct rzg2l_gpt_chip *rzg2l_gpt,
> +u8 hwpwm) {
> +	u8 ch =3D RZG2L_GET_CH(hwpwm);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +	bool is_counter_running, is_output_en;
> +	u32 val;
> +
> +	val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTCR);
> +	is_counter_running =3D val & RZG2L_GTCR_CST;
> +
> +	val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTIOR);
> +	if (RZG2L_IS_IOB(hwpwm))
> +		is_output_en =3D val & RZG2L_GTIOR_OBE;
> +	else
> +		is_output_en =3D val & RZG2L_GTIOR_OAE;
> +
> +	return (is_counter_running && is_output_en); }
> +
> +static int rzg2l_gpt_enable(struct rzg2l_gpt_chip *rzg2l_gpt,
> +			    struct pwm_device *pwm)
> +{
> +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +
> +	/* Enable pin output */
> +	if (RZG2L_IS_IOB(pwm->hwpwm))
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
> +				 RZG2L_GTIOR_GTIOB | RZG2L_GTIOR_OBE,
> +				 RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH);
> +	else
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
> +				 RZG2L_GTIOR_GTIOA | RZG2L_GTIOR_OAE,
> +				 RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH);
> +
> +	mutex_lock(&rzg2l_gpt->lock);
> +	if (!rzg2l_gpt->enable_count[ch])
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, 0,
> RZG2L_GTCR_CST);
> +
> +	rzg2l_gpt->enable_count[ch]++;
> +	mutex_unlock(&rzg2l_gpt->lock);
> +
> +	return 0;
> +}
> +
> +static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
> +			      struct pwm_device *pwm)
> +{
> +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +
> +	/* Disable pin output */
> +	if (RZG2L_IS_IOB(pwm->hwpwm))
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
> RZG2L_GTIOR_OBE, 0);
> +	else
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
> RZG2L_GTIOR_OAE, 0);
> +
> +	/* Stop count, Output low on GTIOCx pin when counting stops */
> +	mutex_lock(&rzg2l_gpt->lock);
> +	rzg2l_gpt->enable_count[ch]--;
> +	if (!rzg2l_gpt->enable_count[ch])
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_CST,
> 0);
> +
> +	mutex_unlock(&rzg2l_gpt->lock);
> +
> +	/*
> +	 * Probe() set these bits, if pwm is enabled by bootloader. In such
> +	 * case, clearing the bits will avoid errors during unbind.
> +	 */
> +	if (test_bit(pwm->hwpwm, rzg2l_gpt->ch_en_bits))
> +		clear_bit(pwm->hwpwm, rzg2l_gpt->ch_en_bits); }
> +
> +static int rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_device
> *pwm,
> +			       struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	int rc;
> +
> +	rc =3D pm_runtime_resume_and_get(chip->dev);
> +	if (rc)
> +		return rc;
> +
> +	state->enabled =3D rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm);
> +	if (state->enabled) {
> +		u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +		u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +		u8 prescale;
> +		u64 tmp;
> +		u32 val;
> +
> +		val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTCR);
> +		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);
> +
> +		val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTPR);
> +		tmp =3D NSEC_PER_SEC * (u64)val;
> +		state->period =3D DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate) << (2
> * prescale);
> +		val =3D rzg2l_gpt_read(rzg2l_gpt,
> +				     offs + RZG2L_GTCCR(RZG2L_IS_IOB(pwm-
> >hwpwm)));
> +
> +		tmp =3D NSEC_PER_SEC * (u64)val;
> +		state->duty_cycle =3D DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate)
> << (2 *
> +prescale);
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
> +static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8
> +prescale) {
> +	return min_t(u64, DIV_ROUND_UP(period_or_duty_cycle, 1 << (2 *
> prescale)),
> +		     (u64)U32_MAX);
> +}
> +
> +/* Caller holds the lock while calling rzg2l_gpt_config() */ static int
> +rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +	unsigned long pv, dc;
> +	u64 period_cycles;
> +	u64 duty_cycles;
> +	u8 prescale;
> +
> +	/*
> +	 * GPT counter is shared by multiple channels, so prescale and
> period
> +	 * can NOT be modified when there are multiple channels in use with
> +	 * different settings.
> +	 */
> +	if (state->period !=3D rzg2l_gpt->state_period[ch] && rzg2l_gpt-
> >user_count[ch] > 1)
> +		return -EBUSY;
> +
> +	period_cycles =3D mul_u64_u64_div_u64(state->period, rzg2l_gpt->rate,
> NSEC_PER_SEC);
> +	prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_cycles);
> +
> +	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_cycles, prescale);
> +
> +	duty_cycles =3D mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt-
> >rate, NSEC_PER_SEC);
> +	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_cycles, prescale);
> +
> +	/*
> +	 * GPT counter is shared by multiple channels, we cache the period
> value
> +	 * from the first enabled channel and use the same value for both
> +	 * channels.
> +	 */
> +	rzg2l_gpt->state_period[ch] =3D state->period;
> +
> +	/*
> +	 * Counter must be stopped before modifying mode, prescaler, timer
> +	 * counter and buffer enable registers. These registers are shared
> +	 * between both channels. So allow updating these registers only for
> the
> +	 * first enabled channel.
> +	 */
> +	if (rzg2l_gpt->enable_count[ch] <=3D 1)
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_CST,
> 0);
> +
> +	/* GPT set operating mode (saw-wave up-counting) */
> +	rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_MD,
> +			 RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
> +
> +	/* Set count direction */
> +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTUDDTYC,
> RZG2L_UP_COUNTING);
> +	/* Select count clock */
> +	rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_TPCS,
> +			 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
> +
> +	/* Set period */
> +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTPR, pv);
> +
> +	/* Set duty cycle */
> +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTCCR(RZG2L_IS_IOB(pwm-
> >hwpwm)),
> +			dc);
> +
> +	/* Set initial value for counter */
> +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTCNT, 0);
> +
> +	/* Set no buffer operation */
> +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTBER, 0);
> +
> +	/* Restart the counter after updating the registers */
> +	if (rzg2l_gpt->enable_count[ch] <=3D 1)
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR,
> +				 RZG2L_GTCR_CST, RZG2L_GTCR_CST);
> +
> +	return 0;
> +}
> +
> +static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device *pwm=
,
> +			   const struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	bool enabled =3D pwm->state.enabled;
> +	int ret;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (!state->enabled) {
> +		if (enabled) {
> +			rzg2l_gpt_disable(rzg2l_gpt, pwm);
> +			pm_runtime_put_sync(rzg2l_gpt->chip.dev);
> +		}
> +
> +		return 0;
> +	}
> +
> +	if (!enabled) {
> +		ret =3D pm_runtime_resume_and_get(rzg2l_gpt->chip.dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	mutex_lock(&rzg2l_gpt->lock);
> +	ret =3D rzg2l_gpt_config(chip, pwm, state);
> +	mutex_unlock(&rzg2l_gpt->lock);
> +	if (ret)
> +		return ret;
> +
> +	if (!enabled)
> +		ret =3D rzg2l_gpt_enable(rzg2l_gpt, pwm);
> +
> +	return ret;
> +}
> +
> +static const struct pwm_ops rzg2l_gpt_ops =3D {
> +	.request =3D rzg2l_gpt_request,
> +	.free =3D rzg2l_gpt_free,
> +	.get_state =3D rzg2l_gpt_get_state,
> +	.apply =3D rzg2l_gpt_apply,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int rzg2l_gpt_pm_runtime_suspend(struct device *dev) {
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(rzg2l_gpt->clk);
> +
> +	return 0;
> +}
> +
> +static int rzg2l_gpt_pm_runtime_resume(struct device *dev) {
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D dev_get_drvdata(dev);
> +
> +	return clk_prepare_enable(rzg2l_gpt->clk);
> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(rzg2l_gpt_pm_ops,
> +				 rzg2l_gpt_pm_runtime_suspend,
> +				 rzg2l_gpt_pm_runtime_resume, NULL);
> +
> +static void rzg2l_gpt_reset_assert_pm_disable(void *data) {
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D data;
> +	u32 i;
> +
> +	clk_rate_exclusive_put(rzg2l_gpt->clk);
> +	/*
> +	 * The below check is for making balanced PM usage count
> +	 * eg: boot loader is turning on PWM and probe increments the PM
> usage
> +	 * count. Before apply, if there is unbind/remove callback we need
> to
> +	 * decrement the PM usage count.
> +	 */
> +	for (i =3D 0; i < RZG2L_MAX_PWM_CHANNELS; i++) {
> +		if (test_bit(i, rzg2l_gpt->ch_en_bits))
> +			pm_runtime_put(rzg2l_gpt->chip.dev);
> +	}
> +
> +	pm_runtime_disable(rzg2l_gpt->chip.dev);
> +	pm_runtime_set_suspended(rzg2l_gpt->chip.dev);
> +	reset_control_assert(rzg2l_gpt->rstc);
> +}
> +
> +static int rzg2l_gpt_probe(struct platform_device *pdev) {
> +	struct rzg2l_gpt_chip *rzg2l_gpt;
> +	int ret;
> +	u32 i;
> +
> +	rzg2l_gpt =3D devm_kzalloc(&pdev->dev, sizeof(*rzg2l_gpt),
> GFP_KERNEL);
> +	if (!rzg2l_gpt)
> +		return -ENOMEM;
> +
> +	rzg2l_gpt->mmio =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(rzg2l_gpt->mmio))
> +		return PTR_ERR(rzg2l_gpt->mmio);
> +
> +	rzg2l_gpt->rstc =3D devm_reset_control_get_exclusive(&pdev->dev,
> NULL);
> +	if (IS_ERR(rzg2l_gpt->rstc))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->rstc),
> +				     "get reset failed\n");
> +
> +	rzg2l_gpt->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(rzg2l_gpt->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->clk),
> +				     "cannot get clock\n");
> +
> +	ret =3D reset_control_deassert(rzg2l_gpt->rstc);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "cannot deassert reset control\n");
> +
> +	ret =3D clk_prepare_enable(rzg2l_gpt->clk);
> +	if (ret)
> +		goto err_reset;
> +
> +	ret =3D clk_rate_exclusive_get(rzg2l_gpt->clk);
> +	if (ret)
> +		goto err_clk_disable;
> +
> +	rzg2l_gpt->rate =3D clk_get_rate(rzg2l_gpt->clk);
> +	if (!rzg2l_gpt->rate) {
> +		dev_err_probe(&pdev->dev, -EINVAL, "gpt clk rate is 0");
> +		goto err_clk_rate_put;
> +	}
> +
> +	/*
> +	 * Refuse clk rates > 1 GHz to prevent overflow later for computing
> +	 * period and duty cycle.
> +	 */
> +	if (rzg2l_gpt->rate > NSEC_PER_SEC) {
> +		ret =3D -EINVAL;
> +		goto err_clk_rate_put;
> +	}
> +
> +	/*
> +	 *  We need to keep the clock on, in case the bootloader has enabled
> the
> +	 *  PWM and is running during probe().
> +	 */
> +	for (i =3D 0; i < RZG2L_MAX_PWM_CHANNELS; i++) {
> +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, i)) {
> +			set_bit(i, rzg2l_gpt->ch_en_bits);
> +			pm_runtime_get_sync(&pdev->dev);
> +		}
> +	}
> +
> +	mutex_init(&rzg2l_gpt->lock);
> +	platform_set_drvdata(pdev, rzg2l_gpt);
> +	rzg2l_gpt->chip.dev =3D &pdev->dev;
> +
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	ret =3D devm_add_action_or_reset(&pdev->dev,
> +				       rzg2l_gpt_reset_assert_pm_disable,
> +				       rzg2l_gpt);
> +	if (ret < 0)
> +		return ret;
> +
> +	rzg2l_gpt->chip.ops =3D &rzg2l_gpt_ops;
> +	rzg2l_gpt->chip.npwm =3D RZG2L_MAX_PWM_CHANNELS;
> +	ret =3D devm_pwmchip_add(&pdev->dev, &rzg2l_gpt->chip);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to add PWM
> chip\n");
> +
> +	pm_runtime_idle(&pdev->dev);
> +
> +	return 0;
> +
> +err_clk_rate_put:
> +	clk_rate_exclusive_put(rzg2l_gpt->clk);
> +err_clk_disable:
> +	clk_disable_unprepare(rzg2l_gpt->clk);
> +err_reset:
> +	reset_control_assert(rzg2l_gpt->rstc);
> +	return ret;
> +}
> +
> +static const struct of_device_id rzg2l_gpt_of_table[] =3D {
> +	{ .compatible =3D "renesas,rzg2l-gpt", },
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
> +
> +static struct platform_driver rzg2l_gpt_driver =3D {
> +	.driver =3D {
> +		.name =3D "pwm-rzg2l-gpt",
> +		.pm =3D pm_ptr(&rzg2l_gpt_pm_ops),
> +		.of_match_table =3D rzg2l_gpt_of_table,
> +	},
> +	.probe =3D rzg2l_gpt_probe,
> +};
> +module_platform_driver(rzg2l_gpt_driver);
> +
> +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> +MODULE_ALIAS("platform:pwm-rzg2l-gpt");
> +MODULE_DESCRIPTION("Renesas RZ/G2L General PWM Timer (GPT) Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.25.1

