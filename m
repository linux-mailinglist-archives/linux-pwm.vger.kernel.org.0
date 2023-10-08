Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858367BCE0D
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Oct 2023 13:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344569AbjJHLOo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 8 Oct 2023 07:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344667AbjJHLOn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 8 Oct 2023 07:14:43 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2095.outbound.protection.outlook.com [40.107.114.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993DFAC;
        Sun,  8 Oct 2023 04:14:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xsbi6KwF6OPDEZiJkBEe/9zxvPYbVAipz4DQ8TCpb0g5pMipgfDOPiQ6MQISzofU3+n15RkGX8gJRecp3UUSACa89gFY7UsI/8sldltWCfVAiYFzbAfcMyf0kf/h4fpH7GQBcMHtWikEjCZKlQghze1C7S0iZ8iuGpKK4FsTdQGbWSLyVYt8j42tR0XjAOzxSzWyLdwx+2qZzx2Du/DHSNNGbPOFNrhfyM4HJwuwPuSS0XOLrxIxVek+HjpvLj9zqqCddbhWwPauZiK8UPvV/W8dJrOecU/tFBLfS3xEjrsYit9zImisk1nI+2xVD67UcvV/vJL9jv6tUp9Fs23ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WGqHKZ7cYDNhjf4JrH0l4EHN0p4e38xu2sOj8fED/s=;
 b=EijZgSKqUJ+ecW1mPCOLnoUPwTltjnfx7Br4BPFVikAunjLeV1mvjWUwUK+YxydAqpn6XbJ8kOwXUbPAaHy64aZSgFzBgs6tGrEm7rKJf06CJaaOeiU5BPoTZHqtZbd+fer4Ro0bLKuD00hAloD3vUMx3C2ppOWtl8/XbG5nRQAD1W/cWQmO+I+yIJBP7aECJyAXKNh3h1w8LJAMsVLmQwtT4S64Vi6/FlIRsnjx4lvgvJaymrKHRVbVIu1DWDmSBFuoGRlONNBKQiTYJ/BSIHi0LR+qpNX9NnglLxFb7J3KS58bZcc5cQ28ZFFwLNK38oaHXG50iORCBbyw98IhPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WGqHKZ7cYDNhjf4JrH0l4EHN0p4e38xu2sOj8fED/s=;
 b=dwiLjfQVdoeHyQzDpJpOcaRBz75n6DkhyHroN7+Z2MKmKT0DpZ3wyVTnG2pZ/bZMWU2mY9TK4ow0wNyD6HA3Z+qYiNjfrIffola8KpQ28s5XndQmA6dhsT8O5HXpld3L/5smqXgNJUDm7Emejf63zW9C5qjoq4QiIJ37IgPfifY=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by TYWPR01MB8608.jpnprd01.prod.outlook.com (2603:1096:400:179::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sun, 8 Oct
 2023 11:14:37 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::6cd0:40f:c634:9950]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::6cd0:40f:c634:9950%4]) with mapi id 15.20.6863.032; Sun, 8 Oct 2023
 11:14:34 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     kernel test robot <lkp@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v16 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v16 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHZ9rQMFWDsgVRgWEOut3JS4AjEP7A7hjeAgAQ9QoA=
Date:   Sun, 8 Oct 2023 11:14:33 +0000
Message-ID: <TYCPR01MB59339A116AF60B0BDCAF9ADE86CFA@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <20231004111451.126195-4-biju.das.jz@bp.renesas.com>
 <202310060218.5lQtUezc-lkp@intel.com>
In-Reply-To: <202310060218.5lQtUezc-lkp@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB5933:EE_|TYWPR01MB8608:EE_
x-ms-office365-filtering-correlation-id: 8d9ac12e-7268-447e-0a1b-08dbc7efc045
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dzXMLhdVooE8zjUtMjg75xG9OfYOmZg+gEI41iYrPBD5NZ79PUBIbpR62McCiczuK3Uoz39S0mGyTLiXBgAgG8qg28Mfepnk+DYQG5uOW8c9/hyAyrD0AnPTUGwitfZmy8ucIwqVFdfpPyhDlxVQPo4s8bzc+aL+l9z1zNdcgAqGwzXhYnOLygJy2g7s2qyRb3eUEKtjmgIQJO6f0HHkfKQy63QkfrsqpzXk2rgl1MmNO9IeeYJ1GyAx1Ag937pBEX6X5UcV3IHSxQWIc7SH/wrLSBowcFqkFBkPpMr8EY68Eg5FuyCykaKOSPbf5I7l0L9dVCUy0srOZAhjN7jDuEobjleG6LDFsPk9i6NNQsjigP0s35tWhyhwXOVJuaNrSTR8Hn8cFsvvcJfCifGxXbN6UPN72ncRxSyHL2DA62utFQUgJsA4BEI1pG1EQJDW4jvPM/m4NLRvTEXJa+6+NqAENOP4tqmmkpE2Xh7uQsJjQA9yMxvKG9eGFrjMY1MSZVxoshPAW59eyUSnVwGmrd3D/N8JA3sPpZyPOds2gtzGDHjsMkcekxm+K2TnGtwMHQMrhessI83+2lQ9PIDwXtfy8pPh/chiOphzr1DSz7NxjC8mOjKm5cN5529wWZFn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(5660300002)(8936002)(9686003)(41300700001)(2906002)(6506007)(7696005)(53546011)(316002)(107886003)(54906003)(64756008)(66556008)(66446008)(110136005)(76116006)(66946007)(66476007)(478600001)(4326008)(8676002)(86362001)(71200400001)(26005)(52536014)(38070700005)(33656002)(122000001)(83380400001)(55016003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xE7IjmTJLnHK+gC7I42xXqnjEf3zZZQbeM/bBcwFkUyVECb9nRrcfr5o6m?=
 =?iso-8859-1?Q?SBpgXbwyMvrDcJATdPDxSbtowYOiscXQYrvssAFlf4feyU528XrvMgIlA0?=
 =?iso-8859-1?Q?mudTK12iluVj0pslEyPL5b5MpZVc57jIMF3JwShlHYMw5fKlkdR7tk+G/h?=
 =?iso-8859-1?Q?FKddUeOvfXRFDBK4rbA/KN001VbMXsrBwgSwGgsGcPbrsrOSAvgHQ3k93A?=
 =?iso-8859-1?Q?qkKZ/U457seRNVV3lIvjnfgt0QVcQqqLJHQXYO9GO94r66kvJWNEabZL/i?=
 =?iso-8859-1?Q?nN/55QPmZYJteSC6uc6Rh0BThdZhHMdNTgvgiXHgs19CurZVrAP4TFGVwS?=
 =?iso-8859-1?Q?Ir9X2NjcY8Exhip6/EQHd5vwnbtPssHgSR8IdTv2KcSFNH8Kmxw2aaVKEL?=
 =?iso-8859-1?Q?KxRPqXIYQ7zv8MOSNTkyTrrYsJJlctvfGGHDZ9agtd5JHJkv17aL8pQGMQ?=
 =?iso-8859-1?Q?1+Bio3CescvT3E7R0D4nYTdM801WCMWjfkGaE0l64aJWak8K3Z3cNziDVb?=
 =?iso-8859-1?Q?atgx/kgl4vRdu4uFbO9gF0N5BS77u/UEF712acHbSEjqTdzLDYya91xWf5?=
 =?iso-8859-1?Q?l1eKV827g8uiCxJdkCkDSiqcgjYzfJXbieHH4buFmZdtOE9gTSnB/cpqC+?=
 =?iso-8859-1?Q?6SDEqDCYjw1zU+9tu3twPGRoHV54SFqBhnouZ+LIlz/8//H1Nk7IuqQRqz?=
 =?iso-8859-1?Q?yc1cb9jnuLSEOz62cI5/Dq2oJAqF+MAUodlyQMeivtItd1mGBllM66o00O?=
 =?iso-8859-1?Q?YZ5L2PREWHD+JlCZGBuqmY9mWUu34M/Sh+SavRge4iGkDXTlmmM3u4qgL+?=
 =?iso-8859-1?Q?wkloVwLzCb/UXsf7IkRgOQANzBq8Pxi45Ag+aJmtH2VtZGaRw5wTB6OIr+?=
 =?iso-8859-1?Q?k4oWtuTr8pmJZvnJIjdLY+B9JRXNkJaCJ9PPSJWjCBFmRzAGFLlOzFpUFJ?=
 =?iso-8859-1?Q?JLprIjtq80jmAvacS76SM/7V7fGV+CVWnk6CRQfTFfzqY+KZzN6J7nPd0y?=
 =?iso-8859-1?Q?X92ADcADaGAbQ5hMs+DHNQwoX1NSXGx6iRj5iXSMKWfJlY3s1dNVNvt5cf?=
 =?iso-8859-1?Q?HtIUwOyVPlqvZbBy0els/BXWZ1/sYVqtkcMvBJLv/wL3xnCkrsvYMcdjZw?=
 =?iso-8859-1?Q?LZCvBgJJ4E6JFRV7NYzjvYlPJagJM4chE1+JnwWCQfsh4ZHbIE2HION6PP?=
 =?iso-8859-1?Q?fvJYCSH2MLBDwuOS62euAP+14DxBlcEwaiIGqtn07gNQ91SepdkxbERqcl?=
 =?iso-8859-1?Q?sxmBhvK4nNPJrh47l8z/oVU0UyRPV1zBK66ZxLEb8OB5HoZSNarISvx6q8?=
 =?iso-8859-1?Q?DxmpzhU6V6s3EnKg2TYi8InnIryR3L4W66R8eEjvw/h85V9j7TumPmVEki?=
 =?iso-8859-1?Q?k7YJuMhMd1EkDPa/armXRRN/WJk2mH3a+QUQENB4Eqpxdp7LtXR8yEujMS?=
 =?iso-8859-1?Q?XEb9Gg2lfKhiq4ktHwxsNdN86sg9W6zkNQyMjbvpavbDxe+9zu6vlA3EE9?=
 =?iso-8859-1?Q?RCjMjhthRp3zOtDuaVhc9lvqr0QQxAQ6q/f9PBLiYdpZhGOzPfpKuGhUn1?=
 =?iso-8859-1?Q?lhpooLYx6pgUPARX3LKUCkCzOF0a73Efyvu4w9zXdVaza8WjMHruKzJsIf?=
 =?iso-8859-1?Q?bh/vw08lk6FXwufg9/2tDcuuxOuOuCQ9x1iPSp2RW3ucI7o94TncrmEA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9ac12e-7268-447e-0a1b-08dbc7efc045
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2023 11:14:33.9809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EOg6SV4R5ArPdiAC+xbGG9SfR4HApgLATwoNVAHQWmUhH5XbxSkwY4Ai6XUaF4PGbVav7TTwYAmq/PsSvwoUVEm3zuMYKQM0D8yrdaTwPvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8608
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi kernel test robot,

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Thursday, October 5, 2023 7:29 PM
> Subject: Re: [PATCH v16 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hi Biju,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on 4aae44f65827f0213a7361cf9c32cfe06114473f]
>=20
> All errors (new ones prefixed by >>):
>=20
>    arch/mips/kernel/head.o: in function `kernel_entry':
>    (.ref.text+0xac): relocation truncated to fit: R_MIPS_26 against
> `start_kernel'
>    init/main.o: in function `set_reset_devices':
>    main.c:(.init.text+0x10): relocation truncated to fit: R_MIPS_26 again=
st
> `_mcount'
>    main.c:(.init.text+0x18): relocation truncated to fit: R_MIPS_26 again=
st
> `__sanitizer_cov_trace_pc'
>    init/main.o: in function `debug_kernel':
>    main.c:(.init.text+0x50): relocation truncated to fit: R_MIPS_26 again=
st
> `_mcount'
>    main.c:(.init.text+0x58): relocation truncated to fit: R_MIPS_26 again=
st
> `__sanitizer_cov_trace_pc'
>    init/main.o: in function `quiet_kernel':
>    main.c:(.init.text+0x90): relocation truncated to fit: R_MIPS_26 again=
st
> `_mcount'
>    main.c:(.init.text+0x98): relocation truncated to fit: R_MIPS_26 again=
st
> `__sanitizer_cov_trace_pc'
>    init/main.o: in function `warn_bootconfig':
>    main.c:(.init.text+0xd0): relocation truncated to fit: R_MIPS_26 again=
st
> `_mcount'
>    main.c:(.init.text+0xd8): relocation truncated to fit: R_MIPS_26 again=
st
> `__sanitizer_cov_trace_pc'
>    init/main.o: in function `init_setup':
>    main.c:(.init.text+0x108): relocation truncated to fit: R_MIPS_26
> against `_mcount'
>    main.c:(.init.text+0x114): additional relocation overflows omitted fro=
m
> the output
>    mips-linux-ld: drivers/pwm/pwm-rzg2l-gpt.o: in function
> `rzg2l_gpt_calculate_pv_or_dc':
> >> pwm-rzg2l-gpt.c:(.text.rzg2l_gpt_calculate_pv_or_dc+0x138): undefined
> reference to `__udivdi3'

I can reproduce this with Ubutu-23.04 and the instructions mentioned above.

Like arm32 compiler this issue also is fixed by replacing
DIV_ROUND_UP()->DIV64_U64_ROUND_UP().

Cheers,
Biju
