Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80876621B4
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Jan 2023 10:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjAIJhU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Jan 2023 04:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbjAIJhS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Jan 2023 04:37:18 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2129.outbound.protection.outlook.com [40.107.114.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2F0645D;
        Mon,  9 Jan 2023 01:37:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpWo5qwIkciXMIopITSbSf1zX7JCr1/AjB+vh9ZAudtEjAMJGlrDY0OGQWF5M29hxvAsIAJk+xexXZe4bfb0YOLYK41cuXyC4eT1Je521B9Pc1pxUseS63vrHBYAxV0Tx1+aF5bPjhA1pJtvCX8RWe4EjM1r3FD/zhFzQhfFBVAwPVk8GjrC/84AqFodooV9txkDepWVDk/1niwwgUI0jPmkF84kk1jIN8ILIV5oJydBjzC048kDsEdwh59jCu6rplQrxvcvqrxBV5I3CJ78MlGfA1Z3Uxo9XJ/MHIODDr8ph156o2V5Bz5cwoWMKEEHdSxyEb+aV1TMEAct8lPz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/igtteuPJQVk1Pc8zPzfxFbBYXtGx4sXxOOL5SuJD0k=;
 b=BuGcxZd/aXw/4gnPoe1NG3GAmjNMJsqXf715mHl+4qXqKofSV+cbaBkLP2cYnFa4rzCsYfJUvHjqOlm/9giXBJTJwwhicj7SH3WRfAUDtHzM0sDTZTQA6lam46vak9J+k+7ku2EcQ2Uiry1f2tOKjhQFJ0P4PiytECCoaAkUIr+w14r6uEnM5ihuhK7KpAJOD/DRvCVrnV6NeT2o9jZhiV50nqoFTlaPODWSi/H1Mhi6OmfmNmgCJWK6eoRHJjGi94+ehSzEeY1eDxfHRuJtLMM0O+x1vpFHgXayojFrzyjWK03/WHTisYhxF8pXiFHKcGc3oS1Fec4KnfB2R0XVjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/igtteuPJQVk1Pc8zPzfxFbBYXtGx4sXxOOL5SuJD0k=;
 b=rKyws127cz4MoN+JP9Cy4esaOIg2mWlvBupTsOV6vUyjqLfo38O3ITq/9OxxCgCj6gGpue5MofHkrwuVyA4zEWFr6rWsiR8Sa5eXnskNqMYH0k6BWGdVGkXRhG5FyC4gKe4wOijydgo423b7juZbLnHQ5JL8uSuWItaM3r2BYtQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB5990.jpnprd01.prod.outlook.com (2603:1096:604:d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 09:37:14 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%3]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 09:37:14 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH v3 0/4] Add RZ/V2{M, MA} PWM driver support
Thread-Topic: [PATCH v3 0/4] Add RZ/V2{M, MA} PWM driver support
Thread-Index: AQHZDyToB3Uyho0w1UCooeXFse0vf66V/UYQ
Date:   Mon, 9 Jan 2023 09:37:14 +0000
Message-ID: <OS0PR01MB592242AAB70CFF0DA3EDEC8086FE9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221213185827.2012004-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20221213185827.2012004-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB5990:EE_
x-ms-office365-filtering-correlation-id: b61f5f9e-cd01-4a51-0239-08daf2251762
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NazMuGueY7BBUHmM6RunassO0ZxjgLxv8iWYhM6XTdT0IApkjTSmMk9hiydGIAqpzDVrEVidcen8cU0CA7S4zxc/o32ubd3ifmjlkhP5DVSO98zxwLi7Ro2/xBSvIssgHi8GEN75U7immz4n6eUlGXZO+saleFtTqrTsgIpmB8SePKGazYlLLzQwycbiEaVzWYtgbKDglu6vLrb+WSvRL4XHUIieW3I/uA0kw70lFnnL/5b7vIn0gq7Ey/yFnGmBG24s2b29tnA65QXDM3kcLkDIQz4FCEHwexjvm4lHDhxC5RQtvLhKODmk/oc/OAlu5jyEw4MTwVKZDVDHTSlkg7sNpcZcEsqiHgTyzio7ZCc5eqjZyCf0nf7Gfw7Rr34fVeO6KS2wMwBHWcQjJe8mcPnou+R7e9WQQdhbx2PqjEoeF1saNQCqrmCRKMhbpnqNBqgo1FaiEF+oTtEBggLKGpL68VbteK+MzWjyTWVYBGGzr/Lm5wzS2fFQDtaINLzDCOXoI9H7w+xjuf//IlN4wrcMSHAtm5vpG1+dm9EtwZOzw3+QC3P2WcKJo4AROaWK9YUHiU/KGfKgRKK7Kvb77iwlfd7VKPwAtOvhC4fuTtXzSjBN7xkZkse3UGUiS3uFCk4L9PbnyKBjn5PlXrJMBM+ZI/Xd7aMwNUIfDgIO7UWGBpS8qxXU3qGNmMGjkINlfHbgI9ONPDvnUXOrXAxfRSTIs2aJoIB67FWP53+1Yjo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199015)(33656002)(86362001)(2906002)(8936002)(5660300002)(7416002)(41300700001)(52536014)(83380400001)(66574015)(122000001)(110136005)(66946007)(71200400001)(7696005)(54906003)(76116006)(38070700005)(66556008)(53546011)(6506007)(107886003)(55016003)(186003)(38100700002)(966005)(8676002)(26005)(66476007)(4326008)(316002)(64756008)(66446008)(9686003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8NOj5Obepg09PSaXJiq+1g1+bW2dMgi0fGJ1iXSCyJBq4dm+ksgKzZb+eT?=
 =?iso-8859-1?Q?KHRVYg/SREgvlYip5HbRrEXgwIRU+FVvCO4H6deThVrcDq6D9dtusDxdWr?=
 =?iso-8859-1?Q?4pENLRKCSrUMkNmBcjprO04LCgqkfzAqyKyCR2eH/TGqV7N8wEiZbcTZgY?=
 =?iso-8859-1?Q?pqYLhOimiES9wrhCgXSFu80+VZHNKRsB6seltaV7GsjeF8wirl2JlIiQTG?=
 =?iso-8859-1?Q?j8vpv3XBgqHBUqHzpN/Hy/8OZ7HIaEpU+TJnjRrLmpWz2nFT0bPEMQtzQL?=
 =?iso-8859-1?Q?AwzdGorUZVsFrdrrIew5WBYgr597zbYqdws+g6ZsZtAvv/EMs61+cz2upA?=
 =?iso-8859-1?Q?wWY5IgxarbvaekU3sp10VzRD3wXqZYhIjM+xjNRTr9glmPJ13pP3U4oTZc?=
 =?iso-8859-1?Q?L5WnGq6XWGR8V+9VwhyZpsauaT+1Varx3Pf18EKxzDWOywDlRnv1sM48a9?=
 =?iso-8859-1?Q?EgUHAfTAGr8l+7+WptpwLBWYFO3sWjXDfqA5qrdfJdTp07bVIEYLl8iy8u?=
 =?iso-8859-1?Q?ew1nDju6euoE/RheNQv4no1uSMIlkefA0Tbo018y5JayWivLBM/OvZAH64?=
 =?iso-8859-1?Q?xGTzpHtGhykyLkxsG4ZN1vZKLMSTZPVSf4GUdLVVQjqI5hclYy3ZH+IVt0?=
 =?iso-8859-1?Q?1IsS1/VOMkOsrU/lpSRREcWffXBWhxgotDJ3aNvIyhio9D00mPJQGu2NGe?=
 =?iso-8859-1?Q?/RxMRWamaQtjb1z9SepVkEfFubsp5dmJkagWMAj3JYkLWEFtwWDKpxnqQp?=
 =?iso-8859-1?Q?wtR2/7HeV2zKNwHrZR/FiffHWjqdYsxWwgsrt0vpT3Sxa2NpiApZH7Xhgz?=
 =?iso-8859-1?Q?EorGq/O+mX1LMEQaAoRKb2jM32lKKOlTq8GvTVgT6n5x9DzlU4O78E7XyG?=
 =?iso-8859-1?Q?eA94HmjVnZYtaHfqHiMneQlfKOr0xhczq50IvJNFwxQXpVouKQ2jHKTHVX?=
 =?iso-8859-1?Q?8HYSUiq/QE4JSoJBeyKPdVzUNzV5GyNh3iNuD5OXLTEaYkWMqKaQGaJsAG?=
 =?iso-8859-1?Q?aUhZTLa8is16Wx2HyHEzbN/Vj6WVB091PHVv7Kca+69XytbJBezMjHTPPj?=
 =?iso-8859-1?Q?9y8w36XDk2NVKWM4zr6cy+leSijBo0xVa+IVUqhYU6qFLN0tBgQL0Vw/FU?=
 =?iso-8859-1?Q?cZNaUwAoHGrkcnxeBro7khZ4rqbR3dGEY1mbLmQjgs1DjDdCChvGAzrKyt?=
 =?iso-8859-1?Q?8sbCmi998NnMbfjd8CIPOYG1pd4AW/mGRuzUnbftYzEc5bN9uzpvI4y9vH?=
 =?iso-8859-1?Q?wGMYVstWZ2QKNbDwtmKYRHRWps42trAlUDH00DzEXDY2a40AuduG9zRZui?=
 =?iso-8859-1?Q?QDf0+aCkSVr+BX6czKYeCtvuklgI1u7A2ZHvkhTCQ9oltsridry0JYAVtK?=
 =?iso-8859-1?Q?4O5hzRqK9GvHiSfcru9tTi6OQ9rhZ6Zp2wCeSBR0dpMQlJgHSNHaA20HbE?=
 =?iso-8859-1?Q?IlXA6azYeZ00bvt6vAQfxtle/O0NnBSJqMBXdOjJlHPZebfCZ2XPWE27no?=
 =?iso-8859-1?Q?8hRBHO64hlYTNW06iBnTqX2i+uEYNtFizUjyEWyRMh97ONiYbRwVxplGm2?=
 =?iso-8859-1?Q?clQ/P9c0PCBwcX2m/h6PjqhuF07wv1h4exXsEeAuqR7WxioBvtM3/1tAvG?=
 =?iso-8859-1?Q?+7oSyAC5BhpILNC7/K3su2RRe0RcfBimCQ2gpdRAPlMHWJgK8Cy3/yvw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61f5f9e-cd01-4a51-0239-08daf2251762
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 09:37:14.5732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ex9GjlXefkvxiZUVcX/eWNnZvVYWN0e7l++H5YJartBWULF8q3vLPjLVJHu3vj6D4y6UeClY/Y9kVwt4Xa77aM1B/vS4Gbk+E/UuXrDplW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5990
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry, Uwe, Geert and PWM folks,

Gentle ping for review.=20

Cheers,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: 13 December 2022 18:58
> To: Thierry Reding <thierry.reding@gmail.com>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Michael Turquette
> <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>; Philipp Zabel
> <p.zabel@pengutronix.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Uwe Kleine-K=F6nig <u.kleine-
> koenig@pengutronix.de>; Geert Uytterhoeven <geert+renesas@glider.be>; Mag=
nus
> Damm <magnus.damm@gmail.com>; linux-pwm@vger.kernel.org;
> devicetree@vger.kernel.org; linux-renesas-soc@vger.kernel.org; linux-
> clk@vger.kernel.org; Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Subject: [PATCH v3 0/4] Add RZ/V2{M, MA} PWM driver support
>=20
> The RZ/V2{M, MA} PWM Timer (PWM) is composed of 16 channels. Linux is onl=
y
> allowed access to channels 8 to 14 on RZ/V2M, while there is no restricti=
on
> for RZ/V2MA.
>=20
> The RZ/V2{M, MA} PWM Timer (PWM) supports the following functions:
>  * The PWM has 24-bit counters which operate at PWM_CLK (48 MHz).
>  * The frequency division ratio for internal counter operation is selecta=
ble
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
>  arch/arm64/boot/dts/renesas/r9a09g011.dtsi    |  98 +++++
>  drivers/pwm/Kconfig                           |  11 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-rzv2m.c                       | 398 ++++++++++++++++++
>  6 files changed, 668 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzv2m-
> pwm.yaml
>  create mode 100644 drivers/pwm/pwm-rzv2m.c
>=20
> --
> 2.25.1

