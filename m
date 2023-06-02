Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205F871FD18
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Jun 2023 11:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbjFBJFq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Jun 2023 05:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjFBJE5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Jun 2023 05:04:57 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2094.outbound.protection.outlook.com [40.107.113.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCD713D;
        Fri,  2 Jun 2023 02:04:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FC6uWDynWzUMwOC1uoxvBHfo5lOeVOwMovo6E0t3mdoLMyv3S9EJ0gPdtV8+RBBVsffLrXqQYpclT7JoXA8mFtHOMM7vw61/IG5ACqKMw7NbRxBpRkEHJi6/asNMxOUw5ENppkeAG9ZXno3zKIKMBWcA6PQhIB1YoXHknVfTp6s3nq0112HwCFt9u+ZAOMp5J4xlG8Illdr2YsTIN7peFqLIzZFqd+nUx9GLL8zYwIklZzj6mY+IlBQnh5cbrzFz7uxtIRt8rCFsVZg6e8MuZODJhlhvI+1G1p4aRisK4Tr3g1t/ZTywkteKLPNyqLyXUXIUnJuTNT2rtgK7OcEJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEagKmwiOcuhs8JSp3Yr9zZM+kKjsAKlLwiaH9GB2dQ=;
 b=k0Fm4xgcsX9FuhxMADWSFxkfTbyDUiYpK2zGHBinDGuip5Ryj5JB9RHk8GWEbQxOj/v4x+iy4teou5ArzxQfLDUdTeV853H0qFNT6MUQZIBC+0B2B52A+W+3phSOlMjuyBk8lg/XRCHukrENwLLtSD0l15zPM2LEKEyAiMNCBT155GIyyyLwHj6YgTGh0qieRvo/q0hsGr/niztfSU+gHwFZY/0nHrIad8TnAohtvIoe456Jc2tJTMSHDbINpM4KS4mZEBy5R7LX8SGGODsXldSUDvUynP298rTsj21HQ4889h02pGXeP1G+YWa+X6Xa/T4QBoclS4eTK81RLdV6iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEagKmwiOcuhs8JSp3Yr9zZM+kKjsAKlLwiaH9GB2dQ=;
 b=TbublUfR1XrgyIXO5Vo/Y/5s4hlB3mFtj85htw7Ahv/McIntj+OeHfx0naS+vUk9yuwHqWjrUNNGqPuqE45NDZuSPm2hJFDAjo7Y3D7F9WCmEFhHU0Q9AX8Yn6+uT5eEC5LHcVCi9kp9xdh4IBptlZ2KRmVhJBMBD8oV7tuEabA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB11085.jpnprd01.prod.outlook.com (2603:1096:400:3a5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 09:04:29 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 09:04:29 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v17] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Topic: [PATCH v17] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Index: AQHZjNDvuavovm4aHEiWuwSbjqNTeq93PjEAgAAAlbA=
Date:   Fri, 2 Jun 2023 09:04:28 +0000
Message-ID: <OS0PR01MB5922F29548AA079EEB2EA800864EA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230522171449.688814-1-biju.das.jz@bp.renesas.com>
 <20230602082622.vs3boxqgek4jmb7b@pengutronix.de>
In-Reply-To: <20230602082622.vs3boxqgek4jmb7b@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB11085:EE_
x-ms-office365-filtering-correlation-id: 36f7aee8-e1c5-44e2-7b0d-08db63485f46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +RWMx7c6yRpiwzAzx/NpiAod5/hkJKsNSjg8L4GtUaCt7wMebEoRdIRtLQtwfSF+0mw/85ZzrvUtXBo1kQOQDUem+QdCERp/LCr6YkNypzarwTbG735qHQJfjRWg2xuQ9YwoJjIF5N8wNFYODd9bVaxo1KqbZAySYJn6ndL8WdshGreVDzM2JzYip8eWD+KFVXV4yXX+CpiBYSYAiaky/K2j14wspgbeD+fgguvnJHZSpmOCSoOC7WbTSOeMrlkP6F5I+E8dcvcAapGXrKQOItMRgvtys5ZKM7NxVFg+VAeJYNsV+7yFOfUyx3ihIPYHI66wM9PmeKUZAQ/PadOWUuS2gwLdHyt5RexWtuFuht6kA5rBCnoz8s0lv5RR17+77aUMMlMtykpi/FplXgjrjxq1UfU+6NJNjpH4JNP6WMe9VqLKyVK8GthiA+JVfh+nmD8DXUKPtAExpg9+snkPXB2rccGnpgVCafkoJMDqjwAPANFrGEWEQdkpJA2E71dHT38w5D5C1o5Cy6yxPO/qZjtfy6UpNQ1xye7SLJhMVE2mYVhzC793TZFImusXG3mK6xAxGeybPiRdSxVz0VRxQCyyKwLv8LoZQsk2B0BI8PdgVHq6yDhAodblgFzNiPY1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199021)(55016003)(66574015)(33656002)(122000001)(66946007)(38070700005)(41300700001)(4326008)(38100700002)(316002)(7696005)(26005)(6506007)(966005)(71200400001)(6916009)(64756008)(66446008)(66476007)(66556008)(9686003)(76116006)(52536014)(2906002)(8676002)(8936002)(5660300002)(54906003)(19627235002)(86362001)(478600001)(186003)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lO+WWFZF3vRIOwufei0Q0r1n3P74AonsOeS6DdFaAYfuv1/M63FaEE/oDD?=
 =?iso-8859-1?Q?9y7jwlhR+R7E5Wuq2VAFxnl/3m8BClIZCDhwT8b3+dcPo6qJOBPvEukjGi?=
 =?iso-8859-1?Q?f9gz16TzVXUECgmQAiwMmwgotcmxYOdIK6iAdOAAReaaUf/vJLM8qJjdrz?=
 =?iso-8859-1?Q?KDwXQBKM9L46HO7n2Tiv9mW/8rxN24W4TPHu+LAJh7Dk03auRLG/qrMrYU?=
 =?iso-8859-1?Q?iDuVpgGl4+pFZvmR8C1jtNdwkqAXWJbypdv0eKoD4A6aBb7vuKZm1j6uCz?=
 =?iso-8859-1?Q?MXVirUgskFe6jWxYt0qf6dxI62ezn9s7FjJUCDs3fJTWvN6VBauyISJlFr?=
 =?iso-8859-1?Q?WF8/+vKvCSXd0daaVzVvZH+mTwJ5zgXdCMyZdXuux3UeejeXn6b0l99T5e?=
 =?iso-8859-1?Q?py5nD1Nis+T6Bgb5PxDDXnKumrZISyhL3ySkovSq1aBY3ApdSWwDBpz4kl?=
 =?iso-8859-1?Q?UziCkBOEE1VWQGGp8o2EJ/qMELex1wGg065thR6a0gs+jcATH2IjyEuDDb?=
 =?iso-8859-1?Q?N1qTTdWRl03SVhy/e8S2mcPvmKkwqXpwnnE0z1WvHButNLBQ2cYwKEvJoe?=
 =?iso-8859-1?Q?TB88e3qXxafDhYbZnp1h8UkCgpddMnXRvpAFBRaLHAXIiC9eqNMCSggqvG?=
 =?iso-8859-1?Q?Oe5Vak+Jol5xDLzP4XuB43Tlz/vAeTA8UJCongQ7bfoRocsVAD+WgR52vT?=
 =?iso-8859-1?Q?lX/LjCbX34FulO7duSM7BOq3x15rPAu+mXbGRANRcLIMqqslEddqYlJWqs?=
 =?iso-8859-1?Q?Y14i10TdRTnb0qvzHBj4CBQOdCtvNwgbsvsre3m28Ow19tUUjePAKbILRj?=
 =?iso-8859-1?Q?xx2JjRYhiZi3AOP8Py5WuPPzCKbtoTFTMXefMEbqxE9we2RowES14RUlqS?=
 =?iso-8859-1?Q?5EsnTro8FTYVXwqx7UJMUZNFBWATFAa3W+7Y+gwe2zm843s41ZXPMgmvPK?=
 =?iso-8859-1?Q?ix6XpA+4pqcdlZNzoPe7oDqLSFLPptDvN8XUPNewD907Wjg/q9WaUlH9ki?=
 =?iso-8859-1?Q?ql5IsQokhcBxWEwxZXpjchvAUupxUf2UjAam2ZAYrYQLzAXg0v521lyQLd?=
 =?iso-8859-1?Q?ila5th5SiCttDibnKqgpsBlWjW68FGPxfF1cJv3sk4cxa611s7DBCPRsQj?=
 =?iso-8859-1?Q?GKI3TQEmLb3ZO60pMA0AEWZpBHoEnrzpC9Gf7QAjd5i9miLhOxpMcB9DGv?=
 =?iso-8859-1?Q?pM+VaNoKMpww3t/anDs9lj2K0VGqvhLnx0YFWStLweYOayFiB+YuXwMQdV?=
 =?iso-8859-1?Q?ZNBlyU5NI73QYz6jDGqvqgk+v0JLhnDb5XKdEKJ3piyNW5R4mxlv2gVM+z?=
 =?iso-8859-1?Q?rGPVnYcNzdgMU0vnzjuvIJLFH5UxPQmtoLkupdC1JGEQvBCUPYlDDmlH6a?=
 =?iso-8859-1?Q?EFLMxN+uM0CJVeOgqpm6MgnGcq0L7881lWrJedsN/fp/yGw+NRzBv4KZK9?=
 =?iso-8859-1?Q?ECkgtDkijNhPp3wy+3up/N090hck0iW2A23bek1biQIPKVBH/qRJQC8Lua?=
 =?iso-8859-1?Q?tcWi7S5Mu+4qySUS7+pwkJnzcYwg9Q2VFfuiiysn2TUP5heGMonpdtE8kM?=
 =?iso-8859-1?Q?ym0Ilvq56Cxqt5POX7oTt7p1xh85tOpaPsxNJqTYe29vuHSLrsLA2ncPF4?=
 =?iso-8859-1?Q?rzsmBuFkzR4t/2BSySJ0An7bhPGtbJIewF?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f7aee8-e1c5-44e2-7b0d-08db63485f46
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 09:04:29.0038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y3z/j4xjyIGyCG7pNvWs3lm2x2QJ6aFHIiRFI62vEeeF1JTxW/1jy3HyofJSHgH1cW+GG6DKoUCi0v1ASsDieqduzJN5tr7+Bg7bh7IH2yo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for the feedback.

> Subject: Re: [PATCH v17] pwm: Add Renesas RZ/G2L MTU3a PWM driver
>=20
> Hello,
>=20
> On Mon, May 22, 2023 at 06:14:49PM +0100, Biju Das wrote:
> > base-commit: 9f258af06b6268be8e960f63c3f66e88bdbbbdb0
> > prerequisite-patch-id: 7d5c55db908971d16a58eb46b25d42dfb0f680ec
> > prerequisite-patch-id: 6c15d33bb612750523d14af87a5cf9e6ff142540
> > prerequisite-patch-id: e5e4d86a0a012a59f585b84ce7ae0d3f047787dc
> > prerequisite-patch-id: d62b4e1326f1518fd30eb98a37bfb4998573979a
> > prerequisite-patch-id: 15bf63b610cab275387a2bbee7ab2a0a48414f75
>=20
> My working copy doesn't contain
> 9f258af06b6268be8e960f63c3f66e88bdbbbdb0, so I wonder what is the base
> you used here. Also the other prerequisite patches are unclear to me and
> I didn't find them[1]. I assume it's stuff around
>=20
> 	654c293e1687 mfd: Add Renesas RZ/G2L MTU3a core driver

Yes,

base-commit: 9f258af06b62 is based on Linux-next as PWM git [2], does not h=
ave the commit=20
654c293e1687 'mfd: Add Renesas RZ/G2L MTU3a core driver'

Other patches are not in mainline( config, device tree and CI related).

0001-CI-Add-CI-build.patch
0002-renesas-defconfig.patch
0003-Enable-MTU3.patch
0004-defconfig-Enable-MTU3.patch
0005-renesas_defconfig-Enable-MTU3.patch

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.gi=
t/log/?qt=3Dgrep&q=3Dbiju.das&h=3Dfor-next

>=20
> (which is in v6.4-rc1)? I recommend duplicating this information in
> human readable form in the cover letter (or below the --- if it's only a
> single patch).
>=20
> So this patch was probably not tested by the build bots.

OK, Will resend with base-commit for mainline 6.4-rc1.

Will drop other prerequisite patches.

Cheers,
Biju

> Otherwise I think this is good enough to go in now, so:
>=20
> Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Thanks
> Uwe
>=20
