Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134F163A35A
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Nov 2022 09:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiK1IrE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Nov 2022 03:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiK1IrB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Nov 2022 03:47:01 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2094.outbound.protection.outlook.com [40.107.114.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AF91144F;
        Mon, 28 Nov 2022 00:46:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9SfAR8cEjHYQNQnPGawyUGm14z/y4ki+JfM2sEbQk+j9mG+Cwi3WFKspXPtBsZx9aM+xIa3vuqHkdHS6y2kQ7qOR1P2CZYPoyuGLcT3cWvuGAL9AwxhObhsyKmk9Xqw4HmQtliLjp0SWRCgkN1ZwlLMJEAI0KfzrahJE6kSU4f7/XM5JK38mH6xRZk0YcB+oZs/QkI+SaliK7gOaCwL1yS+V2xRRdeQsFFprJuglkQsO9maINc6VaCbBA0QBJEKEWZnoNjxw3YiLB8zmMKaMcBOBGj/AcuLLNmvemYRn5HUYEhdGoxhbplZY9vgMuFq/zuyMCvBG8ezfjxaLSQhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNpPBEQSIhv4ULf72YJINUvOfuGL3uiFplAPtnsiN+A=;
 b=A6lamIR+1M2Vfkvm/8zV/tHrwU1AAhIj18p1RVnTCZz1UWyytgu777Is1mjEJGlhYWiLf6kM5JQq+qqT5RKpgdN2zdML32ae9GXZdC4oc/uBKNzvqBFy1N1ssPRewGdBQUwd5aX8mbsUESLmE15wcLJnD05bJnuOV7dNvm5HGWWBOXw5SL60dAqmoaNKtiuvs5eRLc9Pqp9qLrzNRCm1ofLSO79qh+cCWIoYT++bbXT5SGUHfdwHRm2tx+p/U5+2fOq2GRMtax72ZgQYIhSrbXnPfDgcOAOZmDg4YIeP4icAN3ainjAmz8uz3kuujxC3Czs42NVvCzPYqSWE5OtnhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNpPBEQSIhv4ULf72YJINUvOfuGL3uiFplAPtnsiN+A=;
 b=tlI10TCezk+PWzHEhAuMsAyWt1aBVInW4y4rla8hBtk+j+PIHSUgwYS9Lc4rplC38e+SNw5/1wEXHbji4cUw+EtAN0SJKndniD/ptQ+E7yMQ7Hl2QpPW2LzNaf3Kb4SbyBPcVszxNrVZ2MKGrbfE91zFZONIzCETE1jt/ubUFg8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB9365.jpnprd01.prod.outlook.com (2603:1096:604:1cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 08:46:56 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3%5]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 08:46:56 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v4 2/2] drivers: pinctrl: renesas: Add RZ/G2L POEG driver
 support
Thread-Topic: [PATCH v4 2/2] drivers: pinctrl: renesas: Add RZ/G2L POEG driver
 support
Thread-Index: AQHY9gWPntisHsRWC0iCs5w2rib9W65UHI0AgAABxJA=
Date:   Mon, 28 Nov 2022 08:46:56 +0000
Message-ID: <OS0PR01MB5922B3FCB3CDC525B2023FB786139@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221111194059.718154-1-biju.das.jz@bp.renesas.com>
 <20221111194059.718154-3-biju.das.jz@bp.renesas.com>
 <20221128083458.dxj3vsxpxa2xyxap@pengutronix.de>
In-Reply-To: <20221128083458.dxj3vsxpxa2xyxap@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB9365:EE_
x-ms-office365-filtering-correlation-id: 0ba9d3cf-580f-40d2-a871-08dad11d1b10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +U4ZoqNPb5oau2k+ktJHyoouoSBXk/cYBr2P7voqY11uEQVsQ4ZVOUY7PeounNI0aiGt3U++Pzl683iJfPI4Zji2Gq5ZMbfXxj4WrVpDNWgaQfobxIlB/dH/gwoMN+UV1doHcnBPtFV9g+pqroOlbAUIsboDkb/8SDPwsNSvw/KkjvkzV/Ls+s0OWe+cAFyjUmG0puShOLpPqVPDCR+o1u3jcutXMun+LK7UgGA3tSwf+suDcy7H7D4CW5FqXVWi3ZI0sXY4+h+PmrfOoU+M/OBVfbaXOmKYIJXYc+l8snfj6wPG7HmKz/nNRNthva06miT3zmc4PMbBV+92/tPlHIsj/e72gUVd4GYH89OH2ZC6jsw/HYkSBjoOKKPX7TF7CrYyzlgqEX0eK/qDgssNfMaS3S0oppv2WQZov5pzCx4+3LTXMpreWXbiGeSQgo7eU5F2R2nxx5CnljacBJzuuAcOl75GZ2Ha944hs1okLwGP+IrFhTme6/ofc7y6STxBUB9xoYytLSU5x8SQdXL9+e8QX2GEuplZ/jFEdfUaAtCJRF0FN125CSc589B1MNBmWRcgkKk1lcGo5K8Wq9e9/K0VoDi+xkw492db8HREEjyXgEuOYBSA6oEmY5DgofRFTOZwZI10qX3/s/SkV6DWGm9ywfC3sgw3DNM7OjqZT+z0C/sISzr1ns84AJTrCa27+UBq1o5sPt3qQAfMJh4BOALjatTNqdHG/JboNt97fCI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199015)(83380400001)(54906003)(6916009)(107886003)(9686003)(6506007)(71200400001)(7696005)(33656002)(966005)(55016003)(86362001)(38070700005)(122000001)(38100700002)(26005)(186003)(5660300002)(8936002)(52536014)(478600001)(8676002)(66446008)(66476007)(66946007)(64756008)(76116006)(66556008)(41300700001)(316002)(4326008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VDfdSXkIoFuykojXH7Fwge0oRe6NFm3ln0/N1bTm2azjFYh1Y6LTocukFO?=
 =?iso-8859-1?Q?mQgb+9mIibW58N0rcKux5mJbHOkYzhEb7ukRy5pjT2DGgdyghyq1NHjkEF?=
 =?iso-8859-1?Q?1k8zb1OCNRYUrRm2bUKS/+1ftuMyd/YN1towBmu9JIUVCJ6LKVu0KgsmxQ?=
 =?iso-8859-1?Q?bFC2IV6QhJBZg9+NMyftyQHy6OTkKsyN9R4fBNDy1Jte8op216KNp5b7YY?=
 =?iso-8859-1?Q?IaO0LMmoc49baBlWAlYvYKRkgxdWW7Cqi+laWss26o/wz3/4SD5U+fX0j8?=
 =?iso-8859-1?Q?mTHh7MsIPikPcGgoMtU1lJwHOhREyonecklTFP2axJKt8Tg5PfQl/C1qmv?=
 =?iso-8859-1?Q?dI9/8/J7rsHtsrLb9E64ZCyfJrYwcGul7KW4Um/xj5zqD1LVCpPNrHKqdz?=
 =?iso-8859-1?Q?bbP4Gr7X7LM8tU19WfAYUTPrwTVLcCYzOwSQckxyQ8bRPiqnA6Q0g1cFJl?=
 =?iso-8859-1?Q?n5GaeSzK34CMWj8htkjLFQQOWNiyH83IwWrG56vlUgc1sBpDbmyGrD0pzX?=
 =?iso-8859-1?Q?Qj+0UcQKrJOJmss5jDJqpP3cw/nF2xTRjpHgFJtH3wQHY3T4Lp6Yl8JWOt?=
 =?iso-8859-1?Q?VIuiNRgVX/Gs1sqIie1cZanE/E0lh6t1pZP/u2m/SAJyRhWRfpnkQbDs+5?=
 =?iso-8859-1?Q?6paCEBGpkjjhNkPehMRciZa++ALSDSB91Su3xgjbfgYnBgjpAOKZTsMStb?=
 =?iso-8859-1?Q?NpPZ88VP08AWCD04FkOXgERMWN9DcCL2oq6vsmkzSKVtOsjtVgpX99W+lW?=
 =?iso-8859-1?Q?p3Jn4EojixKpRlxV+vbZnSRbEEo9j5RyWioC+ZXbzSOS0DiOUI6yVmoQUU?=
 =?iso-8859-1?Q?hY5EMDVdVJSaZvX0v7ODtKBy2Y5L+VqJYI0C0a7tr4jO99jRQjxVKC3dGV?=
 =?iso-8859-1?Q?nawduv+G4Fh3yqAIUOb4Ik+II6mc7GJtRG1J8FMtl5Z2akKhD01GtzME0e?=
 =?iso-8859-1?Q?OpbQgR70TfuvNL4J7AZmWHwVPGFJsc/cw3DxludG592st4RB2SYzRZktk8?=
 =?iso-8859-1?Q?3Cd/D/DdOrvNmaA1aK93lDxrupakfzHD6j8o8+oMKoytHwjUYqueY0eLY0?=
 =?iso-8859-1?Q?NkdpdCRwn08q90Gl3slOEEVLwOzuKIzZgG6Z8EUaalg7jxozGPJbpweCVZ?=
 =?iso-8859-1?Q?cXg3gw1OsW2109GnmsxdORnFF1jq8QSMcD5ClTJRYMYznMlZGyaCaTYwmp?=
 =?iso-8859-1?Q?W0QlQoh4kgjrmhnNQqzn/AgOrRs5vPzysoAD+vTMWNH1WglA1RESxDSgrp?=
 =?iso-8859-1?Q?+fBgNuySFAS88egqQihX5ZgMtxJkpfkc/RSDSrSvbT5eJCmvANNu5Yb6aR?=
 =?iso-8859-1?Q?vynMSq7LpRo0nNGY2SoTsydlc6ci77TqtBF0DYFINRf5wvrvotH7+33RfO?=
 =?iso-8859-1?Q?VEXn7+lgYx/hJ1ORiF7yuXPGXI6F0j0hAtSAdrWi0nYg8SCiDKBBDUOS6K?=
 =?iso-8859-1?Q?L1X0SnKgddLmWIHcXiZat6FV6rbetmFjgLg3DUzo9+iE0N3Cxc6ifa1L3M?=
 =?iso-8859-1?Q?PiqD+6/JGURpYAUG/viC3UJBXW6Rzj0GqtUf7UGtldvlKkAKhbhlBSx22O?=
 =?iso-8859-1?Q?oiJ14lIQXcatHCU5MMYhQ3ymUCWpwXXWYKJxnx99pNnWZk4Rpbcnv0N1PM?=
 =?iso-8859-1?Q?2m3jMbeeSMGBqasa//IMqFnw/H1fGv3b2tydaV3Ztw1DYIpBAbfTlSYg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba9d3cf-580f-40d2-a871-08dad11d1b10
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 08:46:56.4523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYwzAZEyWFknsryJvxEbEdjXJV8nj2RAz4H+Gd3r3ctGstMwQCuYKdzzDNmTVOtk1086oOWn7d/ABRbKjry2R0+CbaNt+f4JJduxx5DPCgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9365
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for the feedback.

> Subject: Re: [PATCH v4 2/2] drivers: pinctrl: renesas: Add RZ/G2L POEG
> driver support
>=20
> On Fri, Nov 11, 2022 at 07:40:59PM +0000, Biju Das wrote:
> > The output pins of the RZ/G2L general PWM timer (GPT) can be disabled
> > by using the port output enabling function for the GPT (POEG).
> >
> > This patch adds basic support using s/w control through sysfs to
> > enable/disable output from GPT.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> PSA: There is nothing in this patch that is relevant for PWMs, so I'm
> marking it as "handled-elsewhere" in the PWM patchwork. I guess the
> series was sent to the PWM list to give some context for the series "Add
> support for linking gpt with poeg"
> (https://patchwork.ozlabs.org/project/linux-
> pwm/list/?series=3D327828&state=3D*)

The driver patch[1] is part of the pwm driver, which is in review state [2]
[1] https://patchwork.ozlabs.org/project/linux-pwm/patch/20221111192942.717=
137-4-biju.das.jz@bp.renesas.com/
[2] https://patchwork.ozlabs.org/project/linux-pwm/patch/20221111162325.471=
963-3-biju.das.jz@bp.renesas.com/

Cheers,
Biju
