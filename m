Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66445220C5
	for <lists+linux-pwm@lfdr.de>; Tue, 10 May 2022 18:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiEJQMO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 May 2022 12:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344196AbiEJQMM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 May 2022 12:12:12 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2133.outbound.protection.outlook.com [40.107.114.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9AD2265E5;
        Tue, 10 May 2022 09:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij/kcG2m/+I0KZcV1h1W9BhB9fK34/B4RVOALZYdDYzY34nxs6HMWgofDy6RSPvyGrRYT+F6Doq+oxvyK4T7M6YEKi/BjzirVvEs66shAJSEnDF6eGLctYdYb+OdKeMowFV1RI7wIb/cRh2G5oaBlEm+e5w2jsWutjOtOXdxhSB71hx9jQE3L8jgMZ0SQyXX1mk2S2yQYUTbCftX65VEqLjulw4DDuW0ShRZuKEQOHjpLPuZBqEb9YAAoXSPqS+9ZkglpvqCZd6UlPWgXFGNZHjbfgnDlkfmqjET+xhfLEPbMrRv+rrF90TgRHLS4Famf1fYz3KokamT1Abfwv1srg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnmhCjRJlrTuqaOU3JPyFSfwyW+2CdDGMfOM4brVIdk=;
 b=GT0J/VIjlw5lMg7OkJ0nmmLJMZ6wgcNvBUGWuCeHQoU/IJIyvDDNNF8ow/LKnU84Fh12vhKCwDEXZ6b0u8yzvw2PaTNj2wdPwYspHmV5tA6Z6ACpBYABXQeGtK6NWHHB0R+6JO/Q0t8SSS8OIWTXdvCSC1HwkmUnynSBB4K+Hvbew2gwQ/dqsCWoUFqd+XkMsiAsrxrhyErya3FQFHPb++OF9zxj4TkaetttmeMzyNubcPZd/u5NQE3Q0Hp1njFZ33LOgGzPbxTiZPYgPmkKNZvPV4Y0jGR+uprdJjC28BR36WSSGljfu9wqShjhdEOR7w2RLWT8g9CWu4/tywEJbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnmhCjRJlrTuqaOU3JPyFSfwyW+2CdDGMfOM4brVIdk=;
 b=S2gi/AsNLqC/GGAb9l6BdWwu9vsAb3V4AK0Ef7f8H9QpO0imI0NqdxIpMqsvR+jnsCq2BvJf+T8UaL+Fok69ur1Rx+QcHAOnYpYzEfw+Uo1+eVhl8aAq3Z1Z0ayUmui6cxZB3f7NnLH9Mmyo2HbXGIE5CP0JENWx6gTdQCspLd8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB8623.jpnprd01.prod.outlook.com (2603:1096:400:13c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 16:08:08 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 16:08:08 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [RFC 0/8] Add RZ/G2L POEG support
Thread-Topic: [RFC 0/8] Add RZ/G2L POEG support
Thread-Index: AQHYZIA09AHD8uWV4kaTo7LYB/fLIq0YRTaAgAABpFA=
Date:   Tue, 10 May 2022 16:08:08 +0000
Message-ID: <OS0PR01MB59222F00EB16154E4DDE365386C99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220510151112.16249-1-biju.das.jz@bp.renesas.com>
 <20220510160045.4d3pgvjlbea2jwy5@pengutronix.de>
In-Reply-To: <20220510160045.4d3pgvjlbea2jwy5@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27d8a4e1-0c37-4019-f76d-08da329f4633
x-ms-traffictypediagnostic: TYWPR01MB8623:EE_
x-microsoft-antispam-prvs: <TYWPR01MB86230D0176B676FCFC75A76586C99@TYWPR01MB8623.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vWZ7f32Dk7dBSMbbK3TLbfV32eafB2j+R9J355AqGnAMZRDxDP8lfZefm92DFGF1clWDhQVyDRIbVf2M9th8+dzOxiEYfMDcgsD+9DNXkKQK648tZh1vQ9G8C5G7JOM1WP3w6BBHSf2lUAAKUOawau5jBbSHMgDt8vql1VsRz3fAD9+uWsk+h8NnC/8rx9X73chqVNc3tBISo1+WyNAxgKPtdW+yoBfWSnaTyfj2gBQrFNIPM/4oCxMSiUAec+vl9lMjIoJPzjdIabvZMyXlIQO5VQXA5wUeyLeouk/N5KfBNXzfXybsp1Xt9duerZteHn5F1nyS0j9V+dSjvwzO+nK78cDfOmcxd+taElm6Gakdh4Tr0Q1bnYnbs+tAln39Q4EDgRS7GDYpziefy6a/TDJ20Ujd4buDFP+T75AqovNePjhMA3WDyeTwLwwEuYZHhH3hJqmuQG9jGtzRwFiOwWWX90GJM81Fd13P1yXZEf3tArCqhkjXSDe7Pu9UOD3wCP78AqeaeYSkxYlFv6LVJ/Z9cY6MFXosE0qdEN2GBPMXqhXBwPXZkRW8iMOmdcjJYEa2o5A9zTVfcdhrdWH45MTrrwWMQLp2qnCZ3vhjVHMNmopvUE+b9mZEX/6KE721D6fzOX9qCWCGE/R3M79GhepX0jOvVOcxUwTitpE74tKSVCzi6RlwNwJNWY+q6IE1QZ8buRZMqBqen7mGiJKl2PslQ07bVvRqmaoyBmScJ5AV3MaQful841JlIYi7rUqlk3IEkn8AuiAe8MLVwmJxC4OiaRC3XJyThkeA6ebZh38=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(122000001)(9686003)(54906003)(64756008)(66946007)(4326008)(8676002)(66556008)(66446008)(66476007)(76116006)(186003)(316002)(6916009)(55016003)(52536014)(6506007)(7696005)(2906002)(966005)(86362001)(71200400001)(38070700005)(83380400001)(5660300002)(33656002)(8936002)(508600001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KIHnlmZ5DBgBVGT91APUtTwn9la76dtRwGJWhGVaCapzKyjDMK74FhjCzw?=
 =?iso-8859-1?Q?0htEzBNeKDrg7I4HamdFy5p6WTMMX0iAMhUyOnQpC1JNZ5ZJXN8WFozfnN?=
 =?iso-8859-1?Q?zj0Qw1sZ6py62cjklbGhhWMYp2fxlR762HkWDQw8l16jw1ycCM3Ol/xJou?=
 =?iso-8859-1?Q?Jffplt2P5yV7de8lQQ01ykIfkFXly6/9eFbr1iBgFXYKHlL0BlVRCuyTvr?=
 =?iso-8859-1?Q?IzT/aYUaXBVMdUlKK6RnrB0W76HC5dcsOvGpOODzh3eCki6BpqHG5RR2cF?=
 =?iso-8859-1?Q?BWyK6GY33f6GpGwWdkjb6AUZUpLYQNhs7rZKbCbF8dIBIOTFZtI+VHIMNe?=
 =?iso-8859-1?Q?d5Hr3MMk62NEs18wNoRsUB2cLJhEPlijFRP6N8e1V735hotga+fER0Ab2L?=
 =?iso-8859-1?Q?yd8MEUuBiTO50dmz8wIKKfBoTpuEaoSAMM8/a8cnmAxU3iWeJPTW/wu/2Z?=
 =?iso-8859-1?Q?Nu8sLW4iWwcsOFyl9eAuzRl6c3FTYEiZjICfvLhgpKhbGD9pvRTRxSRfz6?=
 =?iso-8859-1?Q?00zee9b5wa2PVKSRCNyWz1VnwrYC2JhX73baQLEi9Jg8698w+3HvGjZp/7?=
 =?iso-8859-1?Q?QU885CuZsil/qXm8suyvuEJCzu+QQ71griMkQwUtqSyhVLY5rMD5fdtcAt?=
 =?iso-8859-1?Q?8PkoqDxtIPfULucqgR5Qs11diTycFRZn29bzfWw3crSGuiHALH6aWaDdOg?=
 =?iso-8859-1?Q?/6+L526MES283o41mBjw1iYOmescIxFmX0Jcuv+yLsV8gPH6V7X9GRksRY?=
 =?iso-8859-1?Q?lxU6PPsbf+1jDrQ4CX0VzOrMKr4aU3oTUtklgvNVcMG2qUuKqVreva0hAG?=
 =?iso-8859-1?Q?9kQ98USol0F6ynAy6PGxKLNGl+ytA7zCUeecTlw87yr1tvG/KFnKhxwhTE?=
 =?iso-8859-1?Q?V9YxS+Fj5wJCF1UXRh2WT1cOzugmEH19dnGyiiYIDSw3Yto9UDtJQGdvuW?=
 =?iso-8859-1?Q?nqqxPEa9GVbGLp0gpHGbsqTUtZUMCphoN8xRczCPBhB9zCnSv3L1t9nKSB?=
 =?iso-8859-1?Q?to61JUT0TZ0DXDZDrdyT4D2oS1eirL09iavly9lmsuLAutqdMZriCknFV1?=
 =?iso-8859-1?Q?TR1gGcH5Kljv6wZVXXa7dM6hXhrAI32JOY2BuxLlJIvKmVb8haYvIkaF9k?=
 =?iso-8859-1?Q?mOy2TTHPLqSjq/EV5dj1Pvhg2nt4CTcPGWVwAJ+J5C9gmvHOwWf+I1iNB5?=
 =?iso-8859-1?Q?J9puTM79WUD1xvPdgF1lN/YUyCfgQ2blP6ZFTK+uFzsg4MqMYflgiPwgvW?=
 =?iso-8859-1?Q?nk7kmjiuKTpO+cMV+zGHnPCUH9iTFeZMwLs1CVDnHjhI7GSWNseY38t7mt?=
 =?iso-8859-1?Q?eozpaKhtO+AFx/xm7NXXqVDlr5/LjPl7oCFOuBauzn6M7uzXUTYddcgpOJ?=
 =?iso-8859-1?Q?RBL+DaeEzQLUqZ/L76Yy7Y0ZYQsatKeruNa1X+wICP8nJqGib/B5fCC6Cy?=
 =?iso-8859-1?Q?7dffb2zim+srYvVL5N/uQ4o+CwP9p4stKubcbJQuZIx8tVGQwbsx3kn5nT?=
 =?iso-8859-1?Q?mkgRrVp06V5fcMIZsIm0+VO57dXny4m1LlSH/NdPlkbRThSqLvdEDsgOPv?=
 =?iso-8859-1?Q?m2WQk3rpaIcCLBZOfMo7Lxb0DgI+YLDsYxo7klkd7+jKNcmU4wDkv/hshe?=
 =?iso-8859-1?Q?0FJ3UISw3uTMUfpluYyk8OxCCVhu2Nyk3cBmFctTYPO8qAjDLr8+pm6SNh?=
 =?iso-8859-1?Q?Pdtay2MDdOb7MV2ywVW+F7Foe2W6XHFbTLvl4tatZQ/euobz3kpebskr5e?=
 =?iso-8859-1?Q?ZDiMhnc5ABmiptOh4GK5R3wd5H9k/GaYK+gOBV6DdFVmrkp4blDFeTl66W?=
 =?iso-8859-1?Q?+I3hcLNlYewk+fPnkIPe148EWJRvw6k=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d8a4e1-0c37-4019-f76d-08da329f4633
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 16:08:08.4846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTHU7Nt7IZdv+xMnd4XJpGC/BLRJ9bnO/2w21HEHey3GF7oQYeUksOn6qICHRZGwT19ZImzDnFtAClAbWgrAqtSi0/gKKljJFkTXWqLwAKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8623
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

> Subject: Re: [RFC 0/8] Add RZ/G2L POEG support
>=20
> On Tue, May 10, 2022 at 04:11:04PM +0100, Biju Das wrote:
> > The output pins of the general PWM timer (GPT) can be disabled by
> > using the port output enabling function for the GPT (POEG).
> > Specifically, either of the following ways can be used.
> >   * Input level detection of the GTETRGA to GTETRGD pins.
> >   * Output-disable request from the GPT.
> >   * Register settings.
> >
> > Added RZ/G2L POEG support under driver/soc/renesas, as currently I am
> > not sure about the framework to be used for POEG.
> >
> > This patch series add support for controlling output disable function
> using sysfs.
> >
> > For output disable operation, POEG group needs to be linked with GPT.
> > So introduced renesas,poeg-group property in pwm for linking both GPT
> > and POEG devices.
> >
> > Please share your valuable comments.
> >
> > patch#3 and #4 depend upon [1]
> > [1]
> > https://lore.kernel.org/linux-renesas-soc/20220510144259.9908-1-biju.d
> > as.jz@bp.renesas.com/T/#t
>=20
> I suggest to use the --base switch to git-format-patch for the next
> submission round. This way the built robots can parse this information,
> too.

Agreed. Will take care this in next submission.

Cheers,
Biju
