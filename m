Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD28877230D
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Aug 2023 13:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjHGLui (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Aug 2023 07:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjHGLug (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Aug 2023 07:50:36 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2102.outbound.protection.outlook.com [40.107.113.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D453C92;
        Mon,  7 Aug 2023 04:50:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjKTA+VwSEVemfm4oTLslHHmyYM4qZ4Gm/tG8dEVb7dDDZVzDbHj4qeU/HYjS0ADwpqjmul/lxmB0GtQ95bwsFdJqR4vFpvX7X0pDd8gJidmEzD9VBMK7AsuT/dPci+roAvztm4nCSQ2gqcocM5qXMel7SkRRnfqc0v6WqF9uiL0bsq0v+lVtQZ19Nw5luvVhnZIVwhXGVbx/TSR8RuRbaNlZezevmMdpT/xjWrqs6gJKxBa7RlsCtXUmlh63x1WpjT7Ew01wBB0fxzdCOiO52JQdv6Q9VhMSmDvM5m/LN9AyLCM/VYnF18JGsvqaB+E2S8I9/ah0ve3HRinZJm2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJGdtBITaieDb++uasIBqDg1FcK3TTIw2OKPJdCGICk=;
 b=eacZOsE1YR1aumPNkCenpZszD5nXAQ+nbXGxkIcS6e8eRCoaa03YXYECoV2uOEqwME8RURZu8KQwlOFMt0o6vWrqxoxC6LYi5YsFWc3Gsj3R5FIruHFFkH7I8MrQaRSv+agO3HJA1gmcxJfZqarUuNJI2xD9SVA6k9fQfdCXBYdC6IebBcHlZzQpU18vhu9B0YDT1/fYC0umidw+rQbXgvYW1UzZaxsQx+2V7iCQzMfY0OtSI8GZ1b5e/MLlmW/iM77beXMyWpNYLb+4DGYreeED6oaZXoXC134D0Nrx5HQP8hqRfYyuHOpaGeWJntHFYsZDmP+8kVnhIhYKvLZt6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJGdtBITaieDb++uasIBqDg1FcK3TTIw2OKPJdCGICk=;
 b=lCdk3yoU5eYjFM6v8KYakZOL7GxsWl256N0eIgaHmOn707bvNdx9ptg92RGt0DfcBLKOTT47zHvv8LBivXO5QJ7Zhgp55nGF/SohJ9zHhN1fTsOpOCwJbi/7KgZJSGrBBJe0s9SJ6H5hDqkWVEmb2LRQe3L9mfmee4pU/uWRc1s=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB5991.jpnprd01.prod.outlook.com (2603:1096:604:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 11:50:30 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f4c1:5f6e:abd1:2bf9]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f4c1:5f6e:abd1:2bf9%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 11:50:30 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v15 0/4] Add support for RZ/G2L GPT
Thread-Topic: [PATCH v15 0/4] Add support for RZ/G2L GPT
Thread-Index: AQHZu5nRS9UEj1xjhEKw73iL/YoZtq/e00cA
Date:   Mon, 7 Aug 2023 11:50:30 +0000
Message-ID: <OS0PR01MB5922774DA08EBD836460BAC8860CA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230721060840.8546-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230721060840.8546-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB5991:EE_
x-ms-office365-filtering-correlation-id: e18dde35-d033-41b5-354b-08db973c8037
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: txANtUBKelIp/CV4RSxdKc372WJeBZiDJDPuN82aeR8vnrws+uM4AxI4BcVR0jP5GI23P4MLeDGMpaAOmuHrELWaw7la/zYQO2CSxfLDQv4TaP1uXWWRAC28eiL5uF3uT6ba1Ro4m5vc8pxlXDEWMNlMh2a7iRFfdJHqLpj51b7F3BppgpJer7Ydykknd3BMKXEOuyGb/7+0DMbBrh0XFPSVSTIrvn/pf0sxiLNWynnLR8WRKwoB7T8Qn3tqSbfp+XDQ/PJr9CTno75G1nnLNAuJWqdswpHdseITCIwrzUxn/4+x+PsIZEy4FvnGnGdxaNbd0xSEEd1DnUJoAiAwDUTQSdLa8VvGCZ1CD8wZWXNX3zB6gIRo7rQRdxBl4pV7wilsWGbPLY5Hsa7OTJFmxP86QedRhlFlNTDzNl1/1ER2qtzfIRhXkoNGuHf8T/i1U5rViyPfN+TvNYbsZQYftrCi9pCgi7SMSGXY04x1TV8Q5sCpT0nLQbK+TQCsL39q4i0jBfaPVpdlFR+GbpXdN2VHGGYeMHYAEdmppy7c6ZJVRdeAnZj3HRKlgGYmNX9jqB8+g/iEH13TIdDcv1c3V/bXtiSgypVyIRZMLTU9GJ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199021)(1800799003)(186006)(9686003)(966005)(55016003)(6506007)(54906003)(110136005)(38100700002)(5660300002)(7416002)(38070700005)(52536014)(86362001)(30864003)(4326008)(2906002)(66946007)(64756008)(66556008)(76116006)(66476007)(41300700001)(33656002)(66446008)(8936002)(8676002)(316002)(71200400001)(7696005)(122000001)(45080400002)(478600001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UZZ5gadJTHIZuE35VV8ufigEhwefW99lultqrfO0Tf1VCWcr6S1ZGJ+8xD?=
 =?iso-8859-1?Q?6YTJCXf3TYOigOEIKZKWzpNPPCuN2l+1uXJcjb+XPr1DdD2RqjZoPCJl4L?=
 =?iso-8859-1?Q?uhqe/dFcObD5LGPYi7uQXmB7qTEphy5J1uMumPnnd5AzgVbvAfH7P8Vf5a?=
 =?iso-8859-1?Q?mR82c8PHuh9xZi7Ge9Df9E5pu7zn/Yy+0NKV/NLgS8f492UnvqFZd71Gf5?=
 =?iso-8859-1?Q?X4W867MY/xIbpXSdn3z2V38MRDEB5yvjCL2Qe2r00l+fCsi/Lhwupg3tvK?=
 =?iso-8859-1?Q?0pbEjPYt1qN6o09ssLJxqOXo/O1z7fKWUY8KBE5cDzU12G8m4y0u4IG5md?=
 =?iso-8859-1?Q?iEzaKFawEamSMlorKu3fOfZOwAcWyf+MF+2K5J/8N2faoxPfBbjXGQrPC1?=
 =?iso-8859-1?Q?j8Mf86Iz3ksACHdEM/ELBKMJ0J1Has+s1b9F63ZxPHqDmM3KMqdOB6Nj4l?=
 =?iso-8859-1?Q?0J/qvf3wP+ccs6hTpG2cU6UQlpsp+4KSbjFhR9GykpSGu7hw0F0B6NDnUV?=
 =?iso-8859-1?Q?MiVXSxgiRjhREQk4ZPyPKAB4SkjvvUlRP76K4QaGRWXh6VKCt61PWRfzrj?=
 =?iso-8859-1?Q?H4044nq7XGS06lZBjwKI44gmpVSLwF49pAEONVVJ/3BZBcO8/qjetuo8Ic?=
 =?iso-8859-1?Q?myCCH/RrJdXnJLqNVwy3Y7WUFDA97SuMsjev7o6dOfE1GDZ/C0p48QeCrp?=
 =?iso-8859-1?Q?qvhZvv8Ucn5qrDG9yniKGMFeKrL8CK+0eVf+qUXOEhS4yrR0VdFKxaCT0c?=
 =?iso-8859-1?Q?+I1yDvcUHR68407CfI2zXKa9jI/FqdWB6iijG1iIkjLxa0MNvsCoVu1Vap?=
 =?iso-8859-1?Q?NyjOtxqNYk70O57E2yFEA5TNeBDIkellQxjSHLzIvmZFPM3fxdgQ4KWbXe?=
 =?iso-8859-1?Q?uIKtuh4VN9kgKYL9hROOGX11h3ZD719z894MY/kVQzfYm7Qy7NWzy0/lCr?=
 =?iso-8859-1?Q?8rx359Cb9VmIj0Atl6UMGD6hSQoe3HxBXG2tVEJ0l6rAUh38m7eGWKMsKA?=
 =?iso-8859-1?Q?SaSdr+jF1RufJD95mIy5M/ssXwm9JTChbjvOcD6+5ZUiyvusB3IEnZqset?=
 =?iso-8859-1?Q?qSTGB0qwgca4ygBrsMen8B98s+VSpt2sw6+yIi9a6wap/lAJUijU2d1wT5?=
 =?iso-8859-1?Q?/hjgQxiOEnYuG/vFzQOiZmcb0jXXVdCcamHE7N8+oy29V/Hqin6BEH1OuM?=
 =?iso-8859-1?Q?ksPiFebOsNC+diQ47O1z0UJkZ2LcBAwbv1GKYKQoMWbONfHhhAKFarhaIL?=
 =?iso-8859-1?Q?5vv31F15VjpbOAtlch/+hc+Fzz5X9R1Ce0fCAYN9SNSliGQInNEKgsHU2K?=
 =?iso-8859-1?Q?yDOK7usG0cQpE0OteFCCuEGkLH36ML6KMbcBRhMhrGDMtnNma/d3b9lhVt?=
 =?iso-8859-1?Q?M6bGf/sMweX3jnUIU7hiHJQdSbaS1P9DClNlGiGDBKFGgqZfOZP9VwieVX?=
 =?iso-8859-1?Q?JE9Kg3ioMVpY/fBGuF8QajTr2JbHRKD/aRlmGe3s5Xj1W0j9b0wGcdvRKS?=
 =?iso-8859-1?Q?rQj+/PP81AzC7zeMjob7f/BUyU/jNNkh18PAC+EHSb7ywXpfMyCTry8ndg?=
 =?iso-8859-1?Q?DJBTz/lSAqfRg9iQcAmejUfIaI+Mtq4Ftq2C1GBcL69ZnBXH0TT7zIsJz+?=
 =?iso-8859-1?Q?iBF4Ew469yFYs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e18dde35-d033-41b5-354b-08db973c8037
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 11:50:30.7488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/7duSVQ1l1Ko6LJtyhQ7xZH54ysMv3+OfFli6ELhvlaT0Dr/9T6byb9oeFaS34dbjs69LFYRgdtqqZBfHVlyQ6fUBwi1pEAoK1hatOkLKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5991
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Gentle ping.

Cheers,
Biju

> Subject: [PATCH v15 0/4] Add support for RZ/G2L GPT
>
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
>
> This patch series aims to add basic pwm support for RZ/G2L GPT driver by
> creating separate logical channels for each IOs.
>
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
> * Updated commit description of patch#4 by replacing "This patch add"->
>   "Add".
> v13->v14:
> * Moved the patch from series[1] to here.
>  [1]
> https://lore.ker/
> nel.org%2Flinux-renesas-soc%2F20221215205843.4074504-1-
> biju.das.jz%40bp.renesas.com%2FT%2F%23t&data=3D05%7C01%7Cbiju.das.jz%40bp=
.re
> nesas.com%7C5e49c1dce57a4fb65f8008db89b0f2bc%7C53d82571da1947e49cb4625a16=
6
> a4a2a%7C0%7C0%7C638255165297945656%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
A
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=
=3D
> zS%2FQnDta9svTRgCKwNQzxIZnK7ie8QOQufDZ6K18hc0%3D&reserved=3D0
>  * Add Rb tag from Rob for patch#2
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
>  * Removed the parenthesis for RZG2L_MAX_POEG_GROUPS.
>  * Renamed rzg2l_gpt_parse_properties()->rzg2l_gpt_poeg_init() as it not
> only parse
>    the properties but also implements the needed register writes.
>  * Added acomment here about the purpose of the function
> rzg2l_gpt_poeg_init()
>  * Removed magic numbers from rzg2l_gpt_poeg_init()
>  * Fixed resource leak in rzg2l_gpt_poeg_init().
> v12->v13:
>  * Added test logs in [1] below
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
>  * Updated the example gpt4: pwm@10048400-> gpt: pwm@10048000
>  * Keep Rb tag from Rob as the above change is trivial one.
>  * Updated the error handling in probe(), clk_disable_unprepare called
>    on the error path.
>  * Removed ch_en array and started using bitmask instead.
> v8->v9:
>  * Added Rb tag from Rob.
>  * deassert after devm_clk_get() to avoid reset stays deasserted,in case
>    clk_get() fails.
>  * Removed ch_offs from struct rzg2l_gpt_chip and use macro instead.
>  * Updated error handling in probe()
> v7->v8:
>  * Removed Rb tags from Rob and Geert as it modelled as single GPT
>    device handling multiple channels.
>  * Updated description
>  * Updated interrupts and interrupt-names properties
>  * Updated binding example
>  * Modelled as single PWM device handling multiple channels
>  * Replaced shared reset->devm_reset_control_get_exclusive()
>  * Added PM runtime callbacks
>  * Updated PM handling and removed "pwm_enabled_by_bootloader" variable
>  * Replaced iowrite32->writel and ioread32->readl
>  * Updated prescale calculation
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
>  * Added a limitation for disabling the channels, when both channels used
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
>  * Added dev_err_probe in various probe error path.
>  * Added an error message, if devm_pwmchip_add fails.
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
>  * Added Rb tag from Rob for the bindings.
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
>  * Added '|' after 'description:' to preserve formatting.
>  * Removed description for pwm_cells as it is common property.
>  * Changed the reg size in example from 0xa4->0x100
>  * Added Rb tag from Geert for bindings.
>  * Added Limitations section
>  * dropped "_MASK" from the define names.
>  * used named initializer for struct phase
>  * Added gpt_pwm_device into a flexible array member in rzg2l_gpt_chip
>  * Revised the logic for prescale
>  * Added .get_state callback
>  * Improved error handling in rzg2l_gpt_apply
>  * Removed .remove callback
>  * Tested the driver with PWM_DEBUG enabled.
>
> RFC->v1:
>  * Added Description in binding patch
>  * Removed comments from reg and clock
>  * replaced rzg2l_gpt_write_mask()->rzg2l_gpt_modify()
>  * Added rzg2l_gpt_read() and updated macros
>  * Removed dtsi patches, will send it separately
>
> RFC:
>  *
> https://lore.ker/
> nel.org%2Flinux-renesas-soc%2F20220430075915.5036-1-
> biju.das.jz%40bp.renesas.com%2FT%2F%23t&data=3D05%7C01%7Cbiju.das.jz%40bp=
.re
> nesas.com%7C5e49c1dce57a4fb65f8008db89b0f2bc%7C53d82571da1947e49cb4625a16=
6
> a4a2a%7C0%7C0%7C638255165297945656%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
A
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=
=3D
> 8Z2uXHblS94d1zundM01wgdT3pmasWhLuMlmPrSZAAQ%3D&reserved=3D0
>
> Biju Das (4):
>   dt-bindings: pwm: Add RZ/G2L GPT binding
>   dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs property
>   pwm: Add support for RZ/G2L GPT
>   pwm: rzg2l-gpt: Add support for gpt linking with poeg
>
>  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 401 +++++++++++
>  drivers/pwm/Kconfig                           |  11 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-rzg2l-gpt.c                   | 640 ++++++++++++++++++
>  4 files changed, 1053 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg2l-
> gpt.yaml
>  create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c
>
>
> base-commit: 92554cdd428fce212d2a71a06939e7cab90f7c77
> --
> 2.25.1

