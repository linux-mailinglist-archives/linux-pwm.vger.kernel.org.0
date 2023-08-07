Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13610772311
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Aug 2023 13:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjHGLvZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Aug 2023 07:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjHGLvY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Aug 2023 07:51:24 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2107.outbound.protection.outlook.com [40.107.114.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5F1B3;
        Mon,  7 Aug 2023 04:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuMrW58eQPJLt8SqLrXUXSopPFPOjIjvaPOyBGEebOiUHfZ8m0JJ5Gu+zjslKxAVQWXfKjazfKoZJtskWrQxLNCoQoIIs5wS9uzrVxX+JD4YGjHwtTX6eOdmWf0nqIMpem1g8US7dvwjAWhS92NZXZkQmDAEQdY7GJBuhGJllfctnCEdWEuyHitrxHzLo5Bu0fP48lUHqmhVspQK90YTJyIzkYxo7FaA4jupmeR2nUew7YAebfapWnU0kk5U35sgtzeGG5pNw1YApOhfanh22DUM8wnMOOx/+o3Ji3EhhDsSQwX1uvXmWKxfWWPOiHmgE08Ycae6KN2TH6j4buxcOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmesPf4tfWekfgqKfW5xbP1GxVy+6RKd97kg7Mlgif4=;
 b=Guf+IEhF+DHWGXROazRhvPJYKW07Ha1BfuCTlgpWkKH0OXi1fMP7jyrpNfAhTp5t+/a5e5YvkEjY1GAiBJwIi3mBATTVVZAvQ+NrAcorWTfE3griPkG2ShfQlLVO1Cd2euyJvVC8KqwEjntydCM+9wYAu9j0bD+ktrwTEACdv/V8oHTITsi+OUWjDPHanQl2XU558WgKVfieSxH/0/PmmKox7/LvCKvPB5lF23RcbgwKd5VQSCTEe3wJpqxAEQFu6Z5Zb0AudcH7AwcmBA0Iqzj4L9a/Mux4BrYIfLJM2pdd+rmp90174opaWr9oe9mb1x8vgJxdXFXGXw5F0+5NhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmesPf4tfWekfgqKfW5xbP1GxVy+6RKd97kg7Mlgif4=;
 b=d8UBqrFXXC5J7z5T+4QfbTnBnXMlDJhXug/UW5Ve6N2Qns5+9Ce368+hdbrcgYXaYWWO6kTjisKLqjh97kD9+MNIjjRY5mUZlvCsswVaRR7ctC5e4eZ3uz1/Bx53tBBsezc62/lHUPO05mAxuTzXLumxK/5pHYRn/n7ZNjEtcyo=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB5991.jpnprd01.prod.outlook.com (2603:1096:604:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 11:51:19 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f4c1:5f6e:abd1:2bf9]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f4c1:5f6e:abd1:2bf9%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 11:51:19 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH v5 0/4] Add RZ/V2{M, MA} PWM driver support
Thread-Topic: [PATCH v5 0/4] Add RZ/V2{M, MA} PWM driver support
Thread-Index: AQHZq0eivZXELtqdK0mRuV6/HyPYya/e9ERw
Date:   Mon, 7 Aug 2023 11:51:19 +0000
Message-ID: <OS0PR01MB59225AA08163660946229E19860CA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230630114003.320641-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230630114003.320641-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB5991:EE_
x-ms-office365-filtering-correlation-id: 2174bb50-38c6-4c2c-6679-08db973c9d50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z3E/5ncHwrI1LzZkEmqnxE9F8Aonq+8A5ZxFXtay2AcwjHg8p+zQHgwoe11ID+GfyIk81as1ENq+bfNVynktYoF5MX96nq9EP2gPoT7cIo7FTXxuYncSJ5nqE+Nqfr2VRTpSj9y5dwudRtg2/UEKKeaEXw+0lFXKKD6o6wC6BkkAOEo/JcXJDnaFcLWIURErZ6wbquWonvVOHGL+rfVdNdSjYYFisLHpJp/IO6N+mS2xMn6DIofXWxUAtEu5BqUDOfl5aqySpurA0eTVX8T8N/lE0/4EZdgNFvAf59xRwSK/jtQu4QMnkmksIuzFU5SKnS/Itee8WOtuigCmnRPZ+PQou19AOCUX3qv3P9ep+WAm1NWVcrJNNQ1l3UCRtXaQ0A2slYGjD/WCM9djOgxJ+ovXxcPgJrhRkgXfv6d/XLg5UxYIpYmlfv/9jV/MlL3FjGHGfx1t1usNOz2MWZyWvSA2LtWmc+sJpgbp5ASOfwZJXCbewA+NHd8Ok8Ht1Pi1MAeZKNTSy51139/3JSwl4aAIK93yOuABdI1rp0KXDtvubE3YDdGpI9jGFxgp5Y/mzHd/Pz3WcqYcu4ZsSZl+5EjsZn95a+16dCeng8+i2fY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199021)(1800799003)(186006)(9686003)(966005)(55016003)(6506007)(107886003)(54906003)(110136005)(38100700002)(5660300002)(7416002)(38070700005)(52536014)(86362001)(4326008)(2906002)(66946007)(64756008)(66556008)(76116006)(66476007)(41300700001)(33656002)(66446008)(8936002)(8676002)(316002)(71200400001)(7696005)(122000001)(478600001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tiGvCFqXWktifaxBMWid4HxcLGfZs+XDuygpsr6w/yutI1LmITOXtaEVmw?=
 =?iso-8859-1?Q?ye5mnziVDX9J7LoMEdbjCqijhnui1SKKNRgLhLJUejXea1CYhcnQ5SUJiF?=
 =?iso-8859-1?Q?CCOY99zqB5jMWfpvQDI1rdkIXJ5TkZLIKWfSA9DHINkL9ACPf5ZPg7QHrQ?=
 =?iso-8859-1?Q?wcE6vsH1Lt9HI/IJdiJVHBBotH3hvMueCCMZAK3h2KMripTn8QQDzRVGha?=
 =?iso-8859-1?Q?hvK5RYQmcbDOx8oggPbKz5h2IGPt2b+MbUwX9BbX3JQ7fHBjzm/TQ3bz0w?=
 =?iso-8859-1?Q?ff6hxBQTSozPcxpShJLNXfx/H6P7Un9bgkUiCWFGwhX6MH9FmLGr0ZYCzr?=
 =?iso-8859-1?Q?70k7CJGQqrGLspiFjXo9oBJVoNLRyLBu6fUEuIuivABc1Bhednh3Zi4i4y?=
 =?iso-8859-1?Q?Is5Hw0QlpN9qI+8hnoLqf47+tELNlOC/4ygp5JWUNQwsBBW1+xMwSggHdf?=
 =?iso-8859-1?Q?FJne25xmT+lLCs3C2W49fSf+l2h3w1PhEKYv1G0XbjfIRsFbRbRKfcm/BY?=
 =?iso-8859-1?Q?hdTR+a3o5CUG0OM3z/0+E4QuekVVrDUGsa02LbqSjo3IoIDAMVq1ujraT7?=
 =?iso-8859-1?Q?G2ZqlJvStuzNk5P4zBi3Hv8W9Gd2Dg8oNW5YdG+10qmJlmpHR7kPrjqKtD?=
 =?iso-8859-1?Q?JP4xedzlyUePKMqLTgxyglyJTk0wMUwvXgjFvJCBe6xlDTuommGlkpGFud?=
 =?iso-8859-1?Q?lTq+IYgUIabrO+FSVNay8oqw0Orxs8FDyqrvskzZGzT1gYH/GrxoXVslhb?=
 =?iso-8859-1?Q?mnue71EH20KZP2RN9tVe5Zm6m6KsctV43ijLPpCezUyOlH3AZbyY/f7myE?=
 =?iso-8859-1?Q?PEBczYMn0ZYm+VCtooOuMwNlKLsDqsg+/k6/qgkqBXPXmHZT1i5vQJSzAO?=
 =?iso-8859-1?Q?KNixuMUELCFAG+b5QQhPfHTrHDSLBDb0PTYNoxalAms/itB6OvNFG97apK?=
 =?iso-8859-1?Q?4cUPFA13TcSEUfZ2RL1Th46UDcYH4tphQ0QJH0EBBvhEMoTacf9H+jY3b6?=
 =?iso-8859-1?Q?w0qB20yYoOOuDtyXfOrv0VKfdkac9jwcA4KhWbVE1YJDJunOewyHK4Xhzn?=
 =?iso-8859-1?Q?3UZSPXdFWpWfee8C+b7G4Awc6OLMXwh+/JTK+mJ5WT+Vp4D9xMUVqCikLB?=
 =?iso-8859-1?Q?L65QgyApMpHg7tL1cfi+XOt7LQ28HK/YxXGEudrvLtQ9PvskMfb8b5H5jG?=
 =?iso-8859-1?Q?GL7rpH1GYUoXNvuY53xzXiNFMkzXiOBvXTa/EVJCZjXTIIhWrtrKze8VZj?=
 =?iso-8859-1?Q?vMFE/Q1HcxHHFt/g9o/A1bd3uFhxp7qSXRtpd1DRWVwIcGgtDO5k339rFu?=
 =?iso-8859-1?Q?tTBoe+3WVglaNdn9hZpSOsoN2JmtZW+HzCHPbTCgHIx8GsZlLNDLZ98XJj?=
 =?iso-8859-1?Q?tO3j34c7W0f2ZacKpHxMasJkJx54ZSaEx3xybzJaMD7TwLuvTUk7uQ+vd7?=
 =?iso-8859-1?Q?8WiVmC1UvUHhHOh19hICtHeRxZm4EETOo0Vru6DD6JREdwm4Z1KkGCSgbO?=
 =?iso-8859-1?Q?bzTkKcBzsRPhRKR2gcPYxij677vOmXualsYTo+Tm/4WPXiBBIm5Sscqp0i?=
 =?iso-8859-1?Q?GFP70RpfgjGVHd+RqLQ6Geo9dpNPcFEuY6tiUvtNvxUjjuyMJ9VRIs/bHa?=
 =?iso-8859-1?Q?wbZigM+1uW8cY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2174bb50-38c6-4c2c-6679-08db973c9d50
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 11:51:19.5848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t9D+v6ZwEtYZ/Xmnx1/hHz/CoLwYQF265a4e6U1ASStV1b14tuhA1au1NOtqc/rCSbAbO3/DVxg3qwk8H43Out44iQRFKu/i7mWADfcftaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5991
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
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

> Subject: [PATCH v5 0/4] Add RZ/V2{M, MA} PWM driver support
>=20
> The RZ/V2{M, MA} PWM Timer (PWM) is composed of 16 channels. Linux is onl=
y
> allowed access to channels 8 to 14 on RZ/V2M, while there is no
> restriction for RZ/V2MA.
>=20
> The RZ/V2{M, MA} PWM Timer (PWM) supports the following functions:
>  * The PWM has 24-bit counters which operate at PWM_CLK (48 MHz).
>  * The frequency division ratio for internal counter operation is
> selectable
>     as PWM_CLK divided by 1, 16, 256, or 2048.
>  * The period as well as the duty cycle is adjustable.
>  * The low-level and high-level order of the PWM signals can be inverted.
>  * The duty cycle of the PWM signal is selectable in the range from 0 to
> 100%.
>  * The minimum resolution is 20.83 ns.
>  * Three interrupt sources: Rising and falling edges of the PWM signal an=
d
>    clearing of the counter
>  * Counter operation and the bus interface are asynchronous and both can
>    operate independently of the magnitude relationship of the respective
>    clock periods.
>=20
> v4->v5:
>  * rebased to pwm for-next.
>  * Sorted KConfig file
>  * Sorted Make file
>  * Updated copyright header 2022->2023.
>  * Updated limitation section.
>  * Replaced the variable chip->rzv2m_pwm in rzv2m_pwm_wait_delay()
>  * Replaced polarity logic as per HW manual dutycycle =3D Ton/Ton+Toff, s=
o
>    eventhough native polarity is inverted from period point of view it is
>    correct.
>  * Updated logic for supporting 0% , 100% and remaining duty cycles.
>  * On config() replaced pm_runtime_resume_and_get()->pm_runtime_get_sync(=
)
>  * Counter is stopped while updating period/polarity to avoid glitches.
>  * Added error check for clk_prepare_enable()
>  * Introduced is_ch_enabled variable to cache channel enable status.
>  * clk_get_rate is called after enabling the clock and
> clk_rate_exclusive_get()
>  * Added comment for delay
>  * Replaced 1000000000UL->NSEC_PER_SEC.
>  * Improved error handling in probe().
> v3->v4:
>  * Documented the hardware properties in "Limitations" section
>  * Dropped the macros F2CYCLE_NSEC, U24_MASK and U24_MAX.
>  * Added RZV2M_PWMCYC_PERIOD macro for U24_MAX
>  * Dropped rzv2m_pwm_freq_div variable and started using 1 << (4 * i) for
>    calculating divider as it is power of 16.
>  * Reordered the functions to have rzv2m_pwm_config() directly before
>    rzv2m_pwm_apply().
>  * Improved the logic for calculating period and duty cycle in config()
>  * Merged multiple RZV2M_PWMCTR register writes to a single write in
> config()
>  * replaced pwm_is_enabled()->pwm->state.enabled
>  * Avoided assigning bit value as enum pwm_polarity instead used enum
> constant.
>  * Fixed various issues in probe error path.
>  * Updated the logic for PWM cycle setting register
>  * A 100% duty cycle is only possible with PWMLOW > PWMCYC. So restrictin=
g
>    PWMCYC values < 0xffffff
>  * The native polarity of the hardware is inverted (i.e. it starts with
> the
>  * low part). So switched the inversion bit handling.
> v2->v3:
>  * Removed clock patch#1 as it is queued for 6.3 renesas-clk
>  * Added Rb tag from Geert for bindings and dt patches
>  * Added return code for rzv2m_pwm_get_state()
>  * Added comment in rzv2m_pwm_reset_assert_pm_disable()
> v1->v2:
>  * Updated commit description
>  * Replaced pwm8_15_pclk->cperi_grpf
>  * Added reset entry R9A09G011_PWM_GPF_PRESETN
>  * Added Rb tag from Krzysztof for bindings and the keep the Rb tag as
>    the below changes are trivial
>  * Updated the description for APB clock
>  * Added resets required property
>  * Updated the example with resets property
>  * Replaced devm_reset_control_get_optional_shared-
> >devm_reset_control_get_shared
>  * Added resets property in pwm nodes.
>=20
> Note:
>  Hardware manual for this IP can be found here
> https://www.renesas.com/in/en/document/mah/rzv2m-users-manual-
> hardware?language=3Den
>=20
> Biju Das (4):
>   dt-bindings: pwm: Add RZ/V2M PWM binding
>   pwm: Add support for RZ/V2M PWM driver
>   arm64: dts: renesas: r9a09g011: Add pwm nodes
>   arm64: dts: renesas: rzv2m evk: Enable pwm
>=20
>  .../bindings/pwm/renesas,rzv2m-pwm.yaml       |  90 ++++
>  .../boot/dts/renesas/r9a09g011-v2mevk2.dts    |  70 +++
>  arch/arm64/boot/dts/renesas/r9a09g011.dtsi    |  98 ++++
>  drivers/pwm/Kconfig                           |  11 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-rzv2m.c                       | 451 ++++++++++++++++++
>  6 files changed, 721 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzv2m-
> pwm.yaml
>  create mode 100644 drivers/pwm/pwm-rzv2m.c
>=20
>=20
> base-commit: 92554cdd428fce212d2a71a06939e7cab90f7c77
> --
> 2.25.1

