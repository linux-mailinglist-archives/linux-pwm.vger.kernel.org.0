Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420895FBBFA
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Oct 2022 22:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJKUSy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Oct 2022 16:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJKUSv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Oct 2022 16:18:51 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2134.outbound.protection.outlook.com [40.107.113.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C409D53C;
        Tue, 11 Oct 2022 13:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSkSumBbpaxZ2BG37r05a3Hjere+ggT1vqFhRQB3nhsZhnw+I1BALqvObFojW9Dqd69Z1XZqaMEym9BOn0psM16DPhqvAld6DdbizSFA5fwb2712ZxzKyTFR994bch8wnz3ZoKPKEPVxJ2TSGAOi+h+Ps+bGEpjDPAWTwQOKu9u8HvEjajNcioexFckzte4i6TqGVpKrs1WcgejqG4o/KP/PG4Yy5EVl6uldEGEEAPTKMlQzuv0kVQjLpWPhxt88dHUXKSpZq66cniMuvxtfuwspRAAeHZY9gZZ8oelfpTuFUryXKu+XscXwDJ/Ajm/zFWXYrfZgknIuHqU1vlGB9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOaNfX8I728M1Jhbv0JFnwDLjJnt7qKZtpoPMMMNbyU=;
 b=EGIAZCsXj8IQP2hgxgURgOUAvru1mA0wHdFAClOd1LSKPEAqhdscg0/8iQdRwcLVIrZZ6Y2ToOIDaNYaAsM3tdPzd0cW29R+/7bJSA3tl9u8djriHZEt6Alrs9H0ZJIVACd1dlPzZWynHqpflCiy7v7MuEEaBQTemK+PxmrJ56zn2LcS4Hpy00ljqoRlXlay0V/Xgwt6CQGIU/MwR7oCV8+JzH63y49wowcWzSVj2i4q3n5MKHx5wUJM4OCtqqfynkqCMwWILnaLnYxuzt1/gutR+zhVxpNuiv1I6Y3zPcWpib885Y584YTslshaGh08qWwSFGXHDI9rxM9HlPCMjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOaNfX8I728M1Jhbv0JFnwDLjJnt7qKZtpoPMMMNbyU=;
 b=L5mtBddnyPrD1EpWKwikyd6Yt1OigwQTxTXCegE15zByl9aiI7edlSPZLjlRMH3mKhYQgCgqJQ0idZq9YlI6f38bfiYacf2zP2YmqzfxfI9vhClm5pEL1v6BoJWlcUFT3UZ9a/eOQ0ZFFoQWFAs2502BQ1YITwCnLht49sSZUvA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYVPR01MB10815.jpnprd01.prod.outlook.com (2603:1096:400:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.40; Tue, 11 Oct
 2022 20:18:44 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%8]) with mapi id 15.20.5709.021; Tue, 11 Oct 2022
 20:18:43 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Lee Jones <lee@kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 4/4] mfd: Add RZ/G2L MTU3 PWM driver
Thread-Topic: [PATCH v4 4/4] mfd: Add RZ/G2L MTU3 PWM driver
Thread-Index: AQHY3Lf1ZjO75wmqM0qPUfqcMk9xD64JjDKAgAACnKCAABKoAIAAATcw
Date:   Tue, 11 Oct 2022 20:18:43 +0000
Message-ID: <OS0PR01MB592269EB3BAE686A2F74B48286239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-5-biju.das.jz@bp.renesas.com>
 <b701187b-d2aa-eecc-0052-d611d1f45807@linaro.org>
 <OS0PR01MB59227CF4B0D4CA846E24298C86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <219922df-5bba-e6ae-fa89-60a9b319424b@linaro.org>
In-Reply-To: <219922df-5bba-e6ae-fa89-60a9b319424b@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYVPR01MB10815:EE_
x-ms-office365-filtering-correlation-id: ce643673-9c2e-4050-133c-08daabc5cba4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zxJFbzVXbAIYhBZaTd2Mf8VaynTcSfPO04c2Zk8qj4TKiScdDn1jtq2kRdAnqm7zZ7nz9T8SxcSrrqTCSFAVB/x3W43+OPI28JH43CAseAEUJu50oNib4yF5IP8wAOKiXJyRsj1DIYdVbGY68QvJw3tfhjcjid4l8gM2+oqKKjdn43lctq5fp0BkP15AmVWjrkcVGwVF8BSIAObZkAztSa7Wvc5AzuGZQ5E0LoeirznLwu/atIFcS4ZYLtWhRv3nx1gCzemrlwAbJumTJ+mOhqVCIdkPQ7XmFr1zQw4rEg0/wg7LesrjkbcnubRZIQSTb9FGKFcCXlA0KY0nV5cbyLhmXNNUaG7DiEuqku4MAhWXgCV5fokEFLpWD2f8XZ0yeaZjtIqtZ2uyEpXcuE2n+MGdPf12XntylM35iQYNsDGQYwu5G2sW9DoplQZI8VEHqCPQK14uNcGurHr+Ob/BQeRVLAzkOnllTBUjgJEiM4dn3tT3xJ15R7P/gy19aULLXMO+M+ZIBbTQOGi2UAv4mQtr7LAlTYvXAs1MYY3g4351esgarnj6AJFOR8/4V30DOw4FxjX9RFdlwmqEDDlYWWDwsgRBFC8pn2oJ3ww7mWyUew4ajJvwPVXSnP0FtiX6V5bhG6XIg/ibhr6GvP7R2dlexsxrgKDC2203lz+R9hFxJUZmKhkdrHLgplc7TWDvvSyXjujJUYihroUHcVaYmQAHYF+wH+DGGNWo/ROsFxsuaw1FS31jwP7aLIazBYhiLp7RGb2kCTiD5/DCHJyC9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199015)(4326008)(38100700002)(38070700005)(9686003)(86362001)(33656002)(53546011)(6506007)(7696005)(41300700001)(8676002)(55016003)(66446008)(54906003)(76116006)(52536014)(66476007)(122000001)(66556008)(5660300002)(8936002)(186003)(71200400001)(110136005)(66946007)(64756008)(26005)(478600001)(316002)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8Vy6AyPvB3KuXU1UUqKEsXZw88uFsNjrMt7erqBWVQyOkAfJfIVnjEs8lM?=
 =?iso-8859-1?Q?M6q0KXpvHa+uV73+jZKuFyMca9FDkoU3IWMV/7znL4lNAtKWigqMS8hPZ6?=
 =?iso-8859-1?Q?wl3czNiX2R9cskBEzzBv8+ty4GFdFzxKVx1+B8f4naxQFkSSsNBgGdDV3k?=
 =?iso-8859-1?Q?CiVk412IbrcS7A5p8lFOmIGJ1O8n5HaU90tOKcBhIyxfh9c6TY+AS5FhHl?=
 =?iso-8859-1?Q?5oU4HeAjmip4zjbtAHs16OI1vGwFPb2gkohnPKxuyYD7EAgq//jH1z6SiA?=
 =?iso-8859-1?Q?CIdcOE758DlTeTNG4/35tjwro+oXjYChbMJcaUcEW8QUiyWl7S2P+HX5ad?=
 =?iso-8859-1?Q?VPQjdCt4Ijm1SnbMpLry5oLipDPIOicSTKmWZfMjh/312bahQFcSkfF8p1?=
 =?iso-8859-1?Q?F41E15gk7NMkg14lNAYN8s3iMEVpT00L7qRUP8uWyl9i4A5f+u9xSXCQ/4?=
 =?iso-8859-1?Q?wLy0mmWIlGejdKoJT5OESqWlEj+VpR3E714FJyszgSTypji7A8rPVOrAFc?=
 =?iso-8859-1?Q?4xnF9kjFXfDD0sBRCn5dzp256j3js/Wsx/PXVMueMOH1c5aVO2nt2gtXXH?=
 =?iso-8859-1?Q?poYEwKTnHcYUFPrWvDC9jmtCxQ//szvC6sJmE4akepqokh5K69QJpXG/zE?=
 =?iso-8859-1?Q?bKkfEn+dHbUavb/sX3EKk+imy1rfZhKdImIQ/gAIFhZnHaJbjj25QuIoOo?=
 =?iso-8859-1?Q?MHfW5KYBmtPby2KesJPQyiBdhdBvDv4tfycimFpZsqbxXI18mzq2VpYOg0?=
 =?iso-8859-1?Q?SqVnYP8J6avdpdYtVyburRK2P/lkwbJgKhF9wuBr3VLh29rXUOrrBv37km?=
 =?iso-8859-1?Q?dzQbkvJvER+A/Tr1pNbpSID/N9FPnEAEnrM0WUq+gM62fxKs9H0REoeObt?=
 =?iso-8859-1?Q?h4TLdWal96SLH1+VSE6UwVJOQ1EnbDPFNMY4v/F8O+tMPyYC6LTimnKQdU?=
 =?iso-8859-1?Q?RVHmZ3QSstdvJcHgd8mb2p3RS27TWefJmSZDwc5P11PT0QM1JX12s/EWHy?=
 =?iso-8859-1?Q?5q24HZEZ7IO7vX8ovHOl18AHPDLIdDDPYqdBxbL8DpPdj0NiZYfDVyhyKi?=
 =?iso-8859-1?Q?ftrpCuDavnfVieDvXLupQ/+PudUbhGlDw8N8j0mQCSyKZ3lnFwQ/5f9zwC?=
 =?iso-8859-1?Q?m8eBtrm8eUW1E0L5kBCWrZ+9kp06QSBZvcxbB4s2/JJXTEDH4U/d0A/+30?=
 =?iso-8859-1?Q?dUp2KfO1QzrQZC+cJITo8nlsrJQKjcHcK6GPDOxAZddDWwhDRxTFQHBfGZ?=
 =?iso-8859-1?Q?yFLQPzAFzFbq2l4Il3MESfb1XvKYIh4KRYGBdCEc2OE5SNe/4gjRYReJ6S?=
 =?iso-8859-1?Q?F+2On8SOJBrYLSnvYmh9E9LY+vkVXgvCbN+8naqbdoAV8/zyQsUn1UYHs8?=
 =?iso-8859-1?Q?e/IkYQ7nf+sc5eTSaQUHTFJl7UwEFk9bGhwg/W8jHaV7ZzLcoba3y5qaJH?=
 =?iso-8859-1?Q?bVBxdJJ78lYFr2bEyOnyM5PHB+5BZ7nJUY9lDm+RHboqjE6kSjPFTBj0I3?=
 =?iso-8859-1?Q?96dm49X6GSm6jorHpu9fETJjWXA1gmFIaGFottr7t3z1OTmlzWVj/eyGom?=
 =?iso-8859-1?Q?9WeHg5tBXYC5xGsEKMJRpvhlEGquvv/Pvnw1iVVE+T1gZOi9FwocmdLJwf?=
 =?iso-8859-1?Q?aEHPvfLrktB/x5K25XVDllYJ4PQHoS8HAlH34lqq2kz6/jc3Ckqa5hig?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce643673-9c2e-4050-133c-08daabc5cba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 20:18:43.9156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wIcImKrw3jQMRnfDNlqOT9saHxAEx1g+C08aSIQmpvjPcHtAJ+RvipIy/BkZ8FdVWbi5lxNzIJzY+aKVmAKyTxM3PZUHiuZa3c5Sz9vp/8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10815
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> Subject: Re: [PATCH v4 4/4] mfd: Add RZ/G2L MTU3 PWM driver
>=20
> On 11/10/2022 15:13, Biju Das wrote:
> >> Subject: Re: [PATCH v4 4/4] mfd: Add RZ/G2L MTU3 PWM driver
> >>
> >> On 10/10/2022 10:52, Biju Das wrote:
> >>> Add support for RZ/G2L MTU3 PWM driver. The IP supports following
> >> PWM
> >>> modes
> >>>
> >>> 1) PWM mode{1,2}
> >>> 2) Reset-synchronized PWM mode
> >>> 3) Complementary PWM mode{1,2,3}
> >>>
> >>> This patch adds basic pwm mode 1 support for RZ/G2L MTU3 driver by
> >>> creating separate logical channels for each IOs.
> >>>
> >>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> >>> ---
> >>> v3->v4:
> >>>  * There is no resource associated with "rz-mtu3-pwm" compatible
> >>>    and moved the code to mfd subsystem as it binds against "rz-
> mtu".
> >>>  * Removed struct platform_driver rz_mtu3_pwm_driver.
> >>> v2->v3:
> >>>  * No change.
> >>> v1->v2:
> >>>  * Modelled as a single PWM device handling multiple channles.
> >>>  * Used PM framework to manage the clocks.
> >>> ---
> >>>  drivers/mfd/Kconfig       |   6 +
> >>>  drivers/mfd/Makefile      |   2 +
> >>>  drivers/mfd/rz-mtu3-pwm.c | 405
> >>> ++++++++++++++++++++++++++++++++++++++
> >>
> >> That's not a MFD driver. That's a PWM. Use proper subsystem and
> email
> >> prefix.
> >
> > See [1]
> > [1]
=3D03qSqax5tr5tAuDHBytn7xH%2BS6oU2xguui9mrshI
> > tCI%3D&amp;reserved=3D0
> >
> > It is a single driver that binds against "renesas,rz-mtu3", and
> > registers both the counter and the pwm functionalities. Just like
> the clock driver, which registers clock, reset, and PM Domain
> functionalities.
>=20
> No, it is not a single driver. You just added a new file - PWM.

It is a single driver rz-mtu.ko binds with "renesas,rz-mtu3"

>=20
> >
> > It is same here, a single MFD driver which binds against
> > ""renesas,rz-mtu3" and registers counter And pwm functionalities.
> >
> > rz-mtu-core is core driver which provides resources to child devices
> like counter and pwm.
> >
> > I already copied PWM subsystem in the loop. Am I missing anything
> > related to [1]
>=20
> MFD subsystem is only a wrapper/parent over actual drivers. It's not
> meant to hold the subsystem-specific code, because relevant
> maintainers will not look here.
>=20
> So no, here and in other files - don't put subsystem specific code
> like PWM or timer into MFD.

Where should do we put, if there is single driver to be bind against=20
"renesas,rz-mtu3" and register functionalities for pwm and counter??

Please suggest.

Cheers,
Biju
