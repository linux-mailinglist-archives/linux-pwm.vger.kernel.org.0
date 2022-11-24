Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFC763757B
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Nov 2022 10:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiKXJqC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Nov 2022 04:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKXJqA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Nov 2022 04:46:00 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2124.outbound.protection.outlook.com [40.107.113.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3FB125229;
        Thu, 24 Nov 2022 01:45:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSuy3vl2uhhMMWPX0lsk7/fK0V4RK6FVoeJgWMsfpbFbmtMR840d+n1RNhzDw6zLF1dt8Os97bcvtt2grGiKG+ahArPVNDblQAQW3v4/hOVibp5kxPbWL+ZLhWfpWBAfzQhBhxcBIjyg1hPoIPbtjOwTDz9pVwK0ohokWNYWXSQiPjK/w/LlmuvWL08PDAvgEb/laKltb88PxjPctUpKUS+ThlDi6ZD4/sbQiLvpqXy7NWKwQTCH8CPary+lwjiqa/1PSSWaW4n+jbF1K5RzYIUdQ/AOR5WGV+eE7SzQznDAXpcwoRNxD73Tp8QzcnU+qWu/7PkHx84LhRJRWkIFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiEDz37JRXvjf5BrmNI3KK7Y7QyHz7IqabZmPoU03sw=;
 b=HM1JkWcy3GSPJLdJX8l3hRTMkfkoW4yqDvIXl84cWD/cR3jxZ7dHakK8QbE8fq5oS8AWgVQOOnLrOkW24+GdHnjwCacRG79rEMeyB+FNG826TbNBicjZsJDuZE1yf3A01d98Pw0Hc6Iw+L0Xh77kd6ySIetJndSe/714sfod/+kCEdKDQgAQN4+hSP0wPZQ9pt3HJ6mWWouLGcB5nHSF7IE6VgAlVXrvQq3vb3mOQOUtS52rfzbWS7zM9tNsDIwaUVbVV0zBcVEn6p67rjORC1kIjtuqstalDw0DGR1INFiiP50e5DrZym/PP2Edlou+mHZ9N7vcpp4dAaNcsLBkgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiEDz37JRXvjf5BrmNI3KK7Y7QyHz7IqabZmPoU03sw=;
 b=kIELeJxICuDhbNRrbOuFGpyEq4ZjXrVhX01SxobZxAabn42dEUSc9sVny9P8nmwVmdlMWYa8dA4muab+GgXh3D/khJ3M3JYXJ14FNvqG34zuHRicB9dsv7F4/HzsxSAdKHBjqhIJIVMlXNv6z059PuCeh69G/ZqE1O0g0qWCmJQ=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by TYCPR01MB8470.jpnprd01.prod.outlook.com (2603:1096:400:158::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 09:45:56 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::dc1d:adf8:9948:6dae]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::dc1d:adf8:9948:6dae%8]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 09:45:56 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 2/5] dt-bindings: pwm: Add RZ/V2M PWM binding
Thread-Topic: [PATCH 2/5] dt-bindings: pwm: Add RZ/V2M PWM binding
Thread-Index: AQHY+1AJzP8tfGCBWUq0Wpj/5XpqF65NyueAgAARNTA=
Date:   Thu, 24 Nov 2022 09:45:56 +0000
Message-ID: <TYCPR01MB59337E9DBB5FF46D7A082553860F9@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <20221118131641.469238-1-biju.das.jz@bp.renesas.com>
 <20221118131641.469238-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdXtKTgUEZWHuS3=KB9w-uCrbWgeRW27yQNw6u_1sq1dzA@mail.gmail.com>
In-Reply-To: <CAMuHMdXtKTgUEZWHuS3=KB9w-uCrbWgeRW27yQNw6u_1sq1dzA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB5933:EE_|TYCPR01MB8470:EE_
x-ms-office365-filtering-correlation-id: fdf0f843-95fa-4084-7100-08dace00af32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yGRoSklfoYKGUvCFyDXlWmpcbZaDyMjoF0l/NVIWGQzER8qEJpSv7ZC2zAzqgr1SCGSet94U0gJBJNEZRcW742Lj43niqGBZDrwkfUQ26K5E1JBmuxvjtIDRjtacreTy5k6U9b2sS3f3A2pPjYOn3AnHYxpXcK0QtRt+xOzVOhSQ3z+jME+TaHKSRx5iW7eDEfMBsXwZAUcBSAnXkWS+DbbTejRZaQvCbOnAWEJzHImAyJUv8dW/HoiC7Yxa6tY6pJpgqIaBHn1YvmTUFLsqd8GYHqL4mEpVuwfmN+48yxxcvGUB5ALLs/ShAThoaQiuL4lddPcIUt6QDARuwvPtguoU80LgCU1mOEryANSrkE8mcbFOf5JaCHjT0zW59L6fAS3IlNAyqANEq4pQB27TFhnsYcibhWt33C1wE6wlyp3vOST9CSes3O7PE56u7JjAsRBv3nzTVddEXw0o1XN+gxqFZQXPg1U5J768xkkMWpxP+bXSZ47o7AnGcX6ff8MrjNjOk5ZfTTa93N2eXZ0TKhjkChmxVh47FuIQ+GoAuhBjyL2dL+kImrg7qsmZCwPV0PGV+fkJFsk3sY9p2QnA2RydUKOAxJqOe7THAL2nlw0g9FlyTHauZNMseHV8Zebp+GoUIZ7VrzPqh82gPu4JhZr84Kf2U4z1Sn4T6Lo9rbeT3Q9ACbY3Fz8M/ybvBMBDHk2z0sM5RyCncWEpW/iGow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199015)(38070700005)(9686003)(83380400001)(186003)(53546011)(55016003)(76116006)(7696005)(2906002)(122000001)(26005)(5660300002)(64756008)(4326008)(6506007)(66556008)(6916009)(52536014)(66476007)(71200400001)(8676002)(66946007)(8936002)(478600001)(316002)(66446008)(54906003)(41300700001)(38100700002)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sQD6UlgoYiz+NRLQdl6IHdpzRIBx8J1xgyLN+mobNDiC3hSg+TNMUuc2vt?=
 =?iso-8859-1?Q?vrtPVKvncAaxM8dvu+Hw3Yag5LDRieIZdmJQwE8k8TC7oY079b2oTzolU1?=
 =?iso-8859-1?Q?siGEWRK5koWrnn/c5vtUy1OSGXkvtYT8rfLY36wZGiuVchajI5FlXsW8ax?=
 =?iso-8859-1?Q?Sz+R/HtZu5twm9BqC9fvJQCtfIEx6vhby6U1efPAH4mkreQr0JqZWLjk5J?=
 =?iso-8859-1?Q?geObA61x+McrGWtF2JpHZYaiY9QbjFy86Z042M81bM5yhHK6YHIaKCml7Q?=
 =?iso-8859-1?Q?NmWHnd6Tuv0qYjr0pnvEri/4aezYC2k7hLeNPnBzo2WZj7At4suUaiD4Mf?=
 =?iso-8859-1?Q?ISP6mRUUEiF4PeT0W91vGjpeLCwtUJf2dSfKFiA6JEEuV2AtJua+Ss9CQx?=
 =?iso-8859-1?Q?pgK5xeXvlkVdoe+v1P74xeT3NFO6MMPhkdfyjfkZ8TwkLt3eR54St8UBp1?=
 =?iso-8859-1?Q?7Tsx/dpjKa1UVZRo0cNml4FezRoWN59CkxG43Ht/iffJh+Eflo64sRGUYH?=
 =?iso-8859-1?Q?IwPnZ7YRK3jrgDHZZ8e+531cojdiQUcycL6+8TWIhKSGOzq9Su/OY+oVGB?=
 =?iso-8859-1?Q?23duEdTprmyv1C/XgsyBrfUKAGzl0ULJudgQDAzs+pFrP7S8IEdlw5LbhT?=
 =?iso-8859-1?Q?b3r6iazRMuFXqqo+tSr+waM7+AOi0ZQmmvfZ7kN/7xTpynxshZQTqLe86Y?=
 =?iso-8859-1?Q?06MPSS3dExUUGJePN307/IdHF0Bi/e0L+cfrFEERKgGvji5PaAg2U8rrux?=
 =?iso-8859-1?Q?CZOOvNqVsV6pwiqwrPQ2Q81DXCX0zvZWPvSIowgCxT7KSjKiBQI9dK1W9m?=
 =?iso-8859-1?Q?aXDgDm+3Zg5/sEnhHm5inncyEwJ5LZyEZK/mNtLPU17a5xaWaSHQD5CvJm?=
 =?iso-8859-1?Q?XGJvUtsBnnQx+ToFEdjvVovssQMWyBi/K52jSpJ7T7nfkayiUL2UkxHtNp?=
 =?iso-8859-1?Q?M5+Bps1tMAG4YnViz0FkWuKq6Dov5B0wngASNXFtTROlEQZQOLtDdIjSoW?=
 =?iso-8859-1?Q?YyBNSErJkdNVQMbYVjaGtcgNi8dWew0ONvW1gVXeUGPUWF+SKlDwT4gqWU?=
 =?iso-8859-1?Q?ZvrQfYtif9SxiCJ2qgTpthwkjHFShHvMydae5u/CUa+S5moq+JXXw4JS5t?=
 =?iso-8859-1?Q?yE8bNZylQOimbrezaZxRbz5AbqOOzSBJGD2IsTFRukottlp35DiBGMCiut?=
 =?iso-8859-1?Q?VNcpDt6ygoExI3ONsiGZZ7Uvv3JAicwfs/7QzX0hEh90ohsiFgC/ju4kPw?=
 =?iso-8859-1?Q?MqvnxH1NlSwzaKsqVF+hhRUyJ+d/gsFgdX34Unl3IqLWyphs7a99WSS3Sz?=
 =?iso-8859-1?Q?yIuFVSdsVKbYH6x+oqrhyHkSzKmQwJZ7wHjZ48QdlCQV74IWDOvA8ftitv?=
 =?iso-8859-1?Q?J8SCnX2yL5cGPTPsGvz0YS/bbBO4HiWqr3K4m/idrJQ2AKoszEAbKTcs5+?=
 =?iso-8859-1?Q?Lm4Cro24iANT5gaoGD/qhjrTSKEMnRhFhGmUIHA5IqXbSr85pmvYd9jVBw?=
 =?iso-8859-1?Q?Sh0zEW95tEaRkF4g18ghmZ7Fk+VlT0YgXPvXF0D+AVVa2FDOqEleDzUXGy?=
 =?iso-8859-1?Q?sNzik0E/cYvq4K6/BkhJSHiFFCrw252732Tt30OKXz7p23mEpcmzSPYLJI?=
 =?iso-8859-1?Q?p9OOULl9fL3aDV5YYoNfgYjmD3SGM3w4FtIPWzI0gF+4JVkLl+xM/b1w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf0f843-95fa-4084-7100-08dace00af32
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 09:45:56.0518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lyLRB5HVqU4KNXQP+M4DVBVHVVjfPzoNN8O8uW54Wu/X+oA+n3ZelYjBe5VCpZ9/cef40PqPk/R7On7pQ5qMPJFt+FNrzojrYG7U0aqQOhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8470
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Geert,

Thanks for the feedback.

> Subject: Re: [PATCH 2/5] dt-bindings: pwm: Add RZ/V2M PWM binding
>=20
> Hi Biju,
>=20
> On Fri, Nov 18, 2022 at 2:16 PM Biju Das <biju.das.jz@bp.renesas.com>
> wrote:
> > Add device tree bindings for the RZ/V2{M, MA} PWM Timer (PWM).
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Thanks for your patch!
>=20
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/renesas,rzv2m-pwm.yaml
> > @@ -0,0 +1,98 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +
> > +title: Renesas RZ/V2{M, MA} PWM Timer (PWM)
> > +
> > +maintainers:
> > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > +
> > +description: |
> > +  The RZ/V2{M, MA} PWM Timer (PWM) composed of 16 channels. It
> > +supports the
> > +  following functions
> > +  * The PWM has 24-bit counters which operate at PWM_CLK (48 MHz).
> > +  * The frequency division ratio for internal counter operation is
> selectable
> > +    as PWM_CLK divided by 1, 16, 256, or 2048.
> > +  * The period as well as the duty cycle is adjustable.
> > +  * The low-level and high-level order of the PWM signals can be
> inverted.
> > +  * The duty cycle of the PWM signal is selectable in the range from
> 0 to 100%.
> > +  * The minimum resolution is 20.83 ns.
> > +  * Three interrupt sources: Rising and falling edges of the PWM
> signal and
> > +    clearing of the counter
> > +  * Counter operation and the bus interface are asynchronous and both
> can
> > +    operate independently of the magnitude relationship of the
> respective
> > +    clock periods.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - renesas,r9a09g011-pwm  # RZ/V2M
> > +          - renesas,r9a09g055-pwm  # RZ/V2MA
> > +      - const: renesas,rzv2m-pwm
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#pwm-cells':
> > +    const: 2
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: CPU Peripheral Group F APB clock
>=20
> "APB clock"
Agreed.

>=20
> PWM0-7] are part of Peripheral Group E, and the block might be reused on
> SoCs not using CPU Peripheral Group clock signals.
>=20
> > +      - description: PWM clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: apb
> > +      - const: pwm
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - power-domains
> > +
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - renesas,r9a09g055-pwm
> > +then:
> > +  required:
> > +    - resets
>=20
> I think you should make the resets property required unconditionally.
> DT describes hardware, not software policy.

OK will send V2 with these changes.

Cheers,
Biju
