Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC36066291B
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Jan 2023 15:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbjAIOyB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Jan 2023 09:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjAIOyA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Jan 2023 09:54:00 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2109.outbound.protection.outlook.com [40.107.114.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99B0B39;
        Mon,  9 Jan 2023 06:53:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nti/Ueqy0yPxOQotw5TtBwVSBEqi6OkE74fgU++2LJBd7bbr/YHJcJlG5uvO3eqH2lI/jzl77d6IfnjLGAFxn/akYGRqIjiQ3d6e6BXaR+MR7FqmbCr/HUZTEqornKNIPClohzjg9uahJzkLniTNd4Z4vsqacDtYLf1dr2CdE7XZtwtTz4023E2UZ9dWXbrFraGNZrUOTMGRXMxUWqlZ6cQG0+losg3kuDTLNCmJIDGo6LgcF3wrDrgWwCIX2z+jT61O9pmUo/MI+nHYWSLyzzH74zhCP8YzHV/gxLkVKtOCFNjGCqxKCi3FyANbcWS72jU42H8BAFN54DCxMGoiZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgAlftZK+1VuBUw0ev4imNfbgQbPcWjFm8PCdcRUvXM=;
 b=njAxqIgGOt8carwkdcxPWdDkOq30D74fppJb1SX3hDhhxuff/V3DxPkYlT8eEyoIqtjoBz3nXiG3E3u1MQzPzywV1cWr/SAh2p4AEfX+A/Y1N7SQwD8sQG85Y2XfZeKdNZhwoCBW+TQMZGIljbkrVT0iyEsbEdzaXoBs11INWxuXh7d8ViX5Dyrs0p/UGEBZXHXRNyJUqV6YfeUDg+39U6R2/Ft+tm/T3OJGfDu9xnTeiowm0v1hVhcUMybbP9UGG1JzbTRKRNuTW/VQCtSB15f9zE5Y/L7LXDo37VzynMUCQFtmeHO1f+Uwkqy+1u2xLmq/1UK4OwRaDGQxGKjOng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgAlftZK+1VuBUw0ev4imNfbgQbPcWjFm8PCdcRUvXM=;
 b=GdE5B8UimZMH4GzMe3OOTaqB45LIQSoa9mG1h8HORQ10AIxxo26Y+z3VKm93LYTGc/5hgSMlVZFJ7xE+K2w+A3iRIlMwD4y45127IuKKtTj3luUh0K7t35L5pveVqdfbK9iF/TLrxgeTTdj3JNK4Tfty2o9vOC/H2k2wiyCa86g=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB8684.jpnprd01.prod.outlook.com (2603:1096:604:154::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 14:53:57 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%3]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 14:53:56 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [DO NOT APPLY PATCH v3 1/3] dt-bindings: pwm: Add RZ/G2L GPT
 binding
Thread-Topic: [DO NOT APPLY PATCH v3 1/3] dt-bindings: pwm: Add RZ/G2L GPT
 binding
Thread-Index: AQHZEMgLlpkVPstjSUKWXygJwqBkSq53FLwAgB891+A=
Date:   Mon, 9 Jan 2023 14:53:56 +0000
Message-ID: <OS0PR01MB5922C5EB1F4C8B4A9AFD34B986FE9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221215205843.4074504-1-biju.das.jz@bp.renesas.com>
 <20221215205843.4074504-2-biju.das.jz@bp.renesas.com>
 <20221220174738.GA800802-robh@kernel.org>
In-Reply-To: <20221220174738.GA800802-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB8684:EE_
x-ms-office365-filtering-correlation-id: 1bcc94a3-141b-4bf5-7a58-08daf25155a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pczv8vsIXOrR/l1hYR2NoHEfEnn49m3XrI/qTA1ZO7mm3uHFDObgDmMAWfKFr0dZU4gwZ2ME+xczswlTX8NJKOBvjMc24inNIv3MCXWfx8vpxqv2fAPnCqGCiOMKf2+GFjs4EywRPeu+9axQrY8nFfucV6pQMU0EvIR2TrVmQkEnTx/Jf+oSI4cRq4wFbQmj0scQSmg0g39Sp0AzqEsUYbnYyJWuw/kprLFDBEiqY3Rk8AxRmRfqvH3WT25nZM+G3Ln5fWn04JbV4K9Fto5oDAj45yq0ZYFzn9amPqlyvJMvTMUdMh32iNAtphUG5dNdGrR4bIFMGTfU9Pd61PettOyF0KKATueKQU9sz2HEAuhlQi7P1+jq1dnp6AkBXVxfqqkcnX7QN6VE3awOLM1CVtuvi3MtCLYanKX0JW4zoevYnrdVhp2Og36eD9gxn26Sx0jLJ3MkxxztB/+DeE6QLs0qvQBT48msRUn4mxMHxx0biTjxiXp+BLR2X2Ulwwzu/9xJUdtvl8UMt9k0fNtPIYStrkTL2dfsOvZIT1W2NxVkMHGMd6JPPuQltlK2V2aTgXpCLYyS7UKvXkXzI+63UeEvDtgTPwbbLFiXOkFkNXDpWWUjHrHIHjodCjti4ISLIsm5l6F2cOZMSo5xnzS3fAgo6/Bpx8q1C7WIDTeNPUs8gXH0QexZGwkLdMWJjbGC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(8936002)(2906002)(5660300002)(52536014)(41300700001)(71200400001)(66446008)(38070700005)(7696005)(66556008)(4326008)(6916009)(76116006)(8676002)(66476007)(316002)(66946007)(64756008)(4744005)(54906003)(86362001)(186003)(9686003)(26005)(122000001)(38100700002)(55016003)(83380400001)(33656002)(478600001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HFlBazKHJOuRV4oj5d3Uz+9G7HYvq66rx9zbweoqXO4JlTAt+orTAW7A1B?=
 =?iso-8859-1?Q?oNyVPaZ0gJgEBbapvAwvRSOmXMFZm3Lmae0zqkTBNznBYMY7wnco5rkn02?=
 =?iso-8859-1?Q?1PI1jzOv9O3Yo8RLgv4qS/F6PjfG8oJcnXzUQTTc8Z1/6CYwCQ32jYSVu7?=
 =?iso-8859-1?Q?eGm2SnXkHvgTt1tSCA7zKEFAO3qhubIwJgTCjncM/oEiK1L7zwCZXUk3EN?=
 =?iso-8859-1?Q?vnIv6dY3/aMq+0sCwVsOTcY3v+7xB+lrjanVQ/5BdZFNuY9pyveXKP5rTV?=
 =?iso-8859-1?Q?RgGFAv5Y9eD3RadhdXf3IeDtEi88XQPMD1o4NmXQ/DHnB199v1OUCJG+LZ?=
 =?iso-8859-1?Q?tZLnvfDbX3OPne52AIgpSIta9KYAqVkcYVTZXc2dP4w17vCuBSi5FtRwKs?=
 =?iso-8859-1?Q?JifRrdwCJcsOcl+tlKf4GnDYV+CRW+qlO1d7NSBsOeRj7LHRRVs2xRoZyi?=
 =?iso-8859-1?Q?7yb5Ad5Qv0UtCi81tGtdvi3z/y85TF6hzI4mIXKvX19qflYY8bD8RdAoHt?=
 =?iso-8859-1?Q?DLXwekGfdv3ixK2GZltVvl//3kUiIMUpUfVXr3IuN1J1H/QtUqTjhZZIk6?=
 =?iso-8859-1?Q?1BcGxiW3cokqI7r8Ua8weqsJ1bbGYIx2ugNu9yYoGy9RHLB/vteZ1ZsotV?=
 =?iso-8859-1?Q?t3zubI1aRRstjwBZylIx618o6tgKf+FGswdzIXpfxlaoEFzyF+ufsfD3xP?=
 =?iso-8859-1?Q?eHmf8tpj0pNwm+LhuNZgfjRGVULbqoP/GLfV8I25PyXGnI+bD5kNZRAA25?=
 =?iso-8859-1?Q?IdVGEOpOtjW6XVABmwxwt1MreUSqtKsoWZVuOza8SUB4iUMtsEDl/Z7UoR?=
 =?iso-8859-1?Q?wrcnrj4oEoM76SBY2ScNalNP8MwCypTafn8XvF1XNU16maJ4xVx8HrZ6M8?=
 =?iso-8859-1?Q?9kw2C9pbwpPXuJDjRKbb8iCd0AsUQscuX/IV5w7t9lj8C+iCfSB9TH3wru?=
 =?iso-8859-1?Q?SIpQ0ifLpDGsoHIv3YDlBbJwIn0AT/UOdCX7HpAKPQm6VW6Fj2EsmZIs2D?=
 =?iso-8859-1?Q?zu/Yv9Cz5uUWz5ly0rfl1uj36YeMlHzSrCN6Crwn01On5VrpfH4bq14+mB?=
 =?iso-8859-1?Q?hKWALTrx1l8kf4jIYD8VoXTfxEtyyJxsW6GH/UIIhRYz9BBUxQjBHh4qgO?=
 =?iso-8859-1?Q?lLHvVN3/r/mi4iRjANli8pN/K8l6lfr+2eLXSbJl7PlXQFzoPCkGZtdQL1?=
 =?iso-8859-1?Q?wr52nvLwN5TBk/t4l7sBvdhFNDoxfXU+eEjYkxJtRB3Lgb/GmGZjfHrU8i?=
 =?iso-8859-1?Q?4WFHrWxUcdnFoIXHfg1YYCHTHgmouCpsxSk+C5RqlQQMfoFISstMoa6Erb?=
 =?iso-8859-1?Q?JZZeuI+VIoQ8ArVfKZWOCwpjyaSD29rHZSx8AccwY6e+oYhIcMltBD0sCY?=
 =?iso-8859-1?Q?tIZGsEOUgRM7+EWJQNIC6TSGcFR0e9m+ogAjDwv9marsS/x0xMlUhf+oPS?=
 =?iso-8859-1?Q?98Ei8GeKmFEUPM5pu+J0yHX2TKrU6OTLJnWSLz+KMRGibEbKA4uekrRNMK?=
 =?iso-8859-1?Q?GdQwNcRzR4A+9uX97qbNVQAnHKM2zw44yI6ksyOF9RRZrSEMwJydY0k3Ke?=
 =?iso-8859-1?Q?7bon1L0bOmXL0QOUTsDIqTLqivxIuexpeTJ8wohqb5NvsWXmAdLyxOyWpH?=
 =?iso-8859-1?Q?dHa+zVpvAkimBuOWjA6sjL9JxekTdJ19Zj5Ddob1Rv9MhLTY+qnql9mw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcc94a3-141b-4bf5-7a58-08daf25155a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 14:53:56.9370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3D2A5mQglel143r/DrDC2FAtRjSoX7n5BVTuKFXSxwqrsXBC9dB4z7CxrRl7/5dzmR6kDWZUznsJs3LKN0FcJ8Ux2NqJI2ggKS3KYafFtlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8684
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Rob,

> Subject: Re: [DO NOT APPLY PATCH v3 1/3] dt-bindings: pwm: Add RZ/G2L GPT
> binding
>=20
> On Thu, Dec 15, 2022 at 08:58:41PM +0000, Biju Das wrote:
> > Add device tree bindings for the General PWM Timer (GPT).
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  sending[1] to avoid bot error for the next patch.
>=20
> Don't do that. The correct thing to do is note the dependency in the patc=
h
> with the dependency (after '---'). The bot will read that and decide to n=
ot
> send a failure email to you. The bot doesn't read cover letters.

OK, Will take care next time.

Cheers,
Biju
