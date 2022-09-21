Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8969B5BFC94
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Sep 2022 12:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiIUKu4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 21 Sep 2022 06:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiIUKuw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 21 Sep 2022 06:50:52 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2135.outbound.protection.outlook.com [40.107.114.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD047CAA0;
        Wed, 21 Sep 2022 03:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlgGDchk8pCleUSwKJDIwEaV26B0vpbNFjAgS6MejsGWMMNx7N0xqswT/4jcP3EgOpRKkh1FgCSG23Yv7jSAQ7ZiKlR+xNS+wiQcjNHt5JGhzZezIFjdjsTD9ijvpYeZxyF2TTqSPYKEDMRujgGcs5nBmmu9EQ5UPov8oJgP9HEy1nMPfeHQJ6nJEEAigiKFnkrr7eSJEFyvCyNZvFfyshRH8ghlyHg9S1cbRNeUXpP1jRBpGJyI8BRRCVXrEw5djEL1Mw+iJIkLN7AmcBJTZSLt58M6w+iMphuo5zwpNAwLuoxqkZ/GtpqYdHKQnb0RQhq0IPyXOHu1D1NRtN5P2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hz3vBChET99+Ujji32DHeOh44fr2aKKwpe1yyLkeOc8=;
 b=L/3O4nHQZl0qPyC27MGf5p9F9pJ0mrNmqnP5rjpAaORHp/MDe4IUI/q+TOaozq7V7M44nk1vfXRgiwrgrhVK7zGYUjSbyRJGPBbzkJrFo4yv92adC0cd3E4nnthKN5XAEaGFds9ZRT/wrr+W0hR1M9SsEhZcgiMiQ8vDm5p7iZTKdUEni65emlmyCWXYF7tHxT9E63TvzlJ1hj01UlEa/jkWZXXdYCeK4qMv27NTkF2kzp5hRKsS9Ebfb8EAegUsJYpSpwrePNDilHp6h8CBuVvsR03Lgn+LzrmaCY5xwnInqoNHJMJAI5rXhe0LFgZSbmx0FWypE/EhXc9yWKsUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz3vBChET99+Ujji32DHeOh44fr2aKKwpe1yyLkeOc8=;
 b=UetKzgOcWm632b7Z72i7XVdCRs1P+A3yDWi4M8YwS064q/+ljBGE7wBLGCoxmdjulzbG6YiI10YgzcsGxsXkbzMl3ExVW9MZyWJmOWaNxXZ1h+oVqfTt65sq7nn4CwND2oPsI1BLf0xJFdNJByzs2I4W3nv0yfNvP1E9VA5jzmI=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB5676.jpnprd01.prod.outlook.com (2603:1096:404:805a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.15; Wed, 21 Sep
 2022 10:50:48 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f%3]) with mapi id 15.20.5654.015; Wed, 21 Sep 2022
 10:50:48 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHYwUrah2CK2PlWrU6yp9jjjlk8rK3meFWAgAIFOuCAABIAAIAADOWAgAEuu3A=
Date:   Wed, 21 Sep 2022 10:50:48 +0000
Message-ID: <OS0PR01MB5922289B89061F6B3DF4819F864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220905171328.991367-1-biju.das.jz@bp.renesas.com>
 <20220905171328.991367-3-biju.das.jz@bp.renesas.com>
 <20220919075727.rmph7jmopaqvyyri@pengutronix.de>
 <OS0PR01MB5922B87D4A05973F88B427A7864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220920155306.dvcz4324zvg72udm@pengutronix.de>
 <OS0PR01MB5922A9B3314F2F2B32F6B0DE864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922A9B3314F2F2B32F6B0DE864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB5676:EE_
x-ms-office365-filtering-correlation-id: a95dc2df-8ba6-4530-ce93-08da9bbf250a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H1orVm0ARu+JxjJSwBydndCvb4DMpe2YZIHkOVJo4p5Ff4VaEXp9sSwC/pjoQbNhnYe0XdqRp3fme2cq1S5nvSQ91kPYgUvrMwBY9owBVPUc68qfyes+BFcieAd9Uat1euGrRH8Iz1Mxu0Zax0pghPSlboxIurHTKRvew9ls0SHVo8VOuSz3rXrONs2PrBg8jAMryAZV5PpHk7xtFHuVBVlS4m29Ch0JBOOK4yhGmJ6NFRyfnyR718moht0X8bDPlEm15D7xVHrf9K5FeNKHn+wYurgbxG2e/Mi1YyXxfOGH5uJbccDG8s0H6B5disVm+tx4thhxKMMdCVjpzp4w8CDxsxOvQ5dvcjTd/jZIMByNjGQApz5FALOXxxd2aTC9HBqDa34YlLuvTSJ84oLT6+I8nqBT4Z33fcYFnVaOPhjlcjFqWy5DlV+hZT/NX0tOmT/lcnE93ezhNJA36J1YBO/aD5qTUVN703XJ/iM/wYTUGbU1B06bt+fpn6w2Xc0/hdEYnTI+Erje7HdIOsweigr9UG7o+hlHxVFkI6JkjysBHX/5J73i+wQsw2hxjo0dtbfYyAfbT+Kn058dbu7fho85/P8Fiiof15B/iuOH6vKKWpDZSN7zyA/CqJhl7LOHZsSvUqtl6om1gjk/AaqGRVh3BE+xKnEdOYxBvGIMhLARCELfwlvyMqmGcYmbUfoSmO1wmaSUNYsCwheSXRe2eAmx8av4EdIF7enyYvxEnrbd+Kqv9SG0QHjVsZLIQDwL2UGIPoWrc8BQH9jyMvxEVhs7cJeSMhcEdAs9Q8A7ZYI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199015)(55016003)(33656002)(71200400001)(52536014)(5660300002)(8936002)(66946007)(66446008)(66476007)(66556008)(64756008)(122000001)(8676002)(2906002)(38070700005)(76116006)(4326008)(38100700002)(86362001)(6916009)(54906003)(478600001)(186003)(83380400001)(66574015)(53546011)(6506007)(7696005)(41300700001)(9686003)(26005)(316002)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yXGsxpa0QnUKRH7GDfBu5/NQUrFZUWxoPlk7fbDL5YtYagOd4Se2wBwZGI?=
 =?iso-8859-1?Q?CwmQY2Hc+ImysUzropIwH8mX82avaaBZ0+zUKMSf3PXqgY3e3FKcR4Pf7N?=
 =?iso-8859-1?Q?w1iVfOlhmPiRccN706oeIpgzkvakaNKp4L1XbecEhb68f60vvySYEZfGm1?=
 =?iso-8859-1?Q?4F793YcUVtxYLGd5WyL1uDRGoPmRwyZrXoe1BC/p9sjCdbxan3zna7pGXa?=
 =?iso-8859-1?Q?zmPA/QX6St21AObiR/FFAE5Fsep7vJCSKCzPKEmxaWWrhVnxKedwDXynzn?=
 =?iso-8859-1?Q?S2/Hz4c2g3oM84HP6fSsvXvUVK5jaSCxdQlzF0mzopUqTpu5vEJFDL4ssm?=
 =?iso-8859-1?Q?rZBmao7gCu7PIrrk3Wz5v3XL2h3asnON+LX87VzR+VmohgWLufFtjrqtWl?=
 =?iso-8859-1?Q?i6arQKKZqq4Ap5KiswO9pZTUm7JtdyKbpeYREOO/7P/zPKIDSrB3EYBRJm?=
 =?iso-8859-1?Q?/phrpvN3JY+g+xWQzxOwBONP/J3au62Xi9qilkneY+53sFOgnTEch7CDS2?=
 =?iso-8859-1?Q?AqPCWWP4ZDGvRHxecubGGeR61Hu8XH1plESb0w0sJjanOaHuK1hB6modwK?=
 =?iso-8859-1?Q?BXxrT5Rv2YRzqPrPI5hFnEu+tCiBT2LxeZgfl4LPSP3FP3OZ3q8Dg2QJ3g?=
 =?iso-8859-1?Q?NJ8Qy8DYvF43vJNFrbg+m/T1k61sirLWKb3PZcI6M4fQeIpCXswzh0uVsP?=
 =?iso-8859-1?Q?vNfv0JAVEVYSOLDeRJixzLKBo4h96E8E6PzUJ2V8dCZJds6g5mbJxVJuc8?=
 =?iso-8859-1?Q?m070EI+gJpNjgXnAfuGAMlGcNcM4GD4YjOjhMiRGucvG1CP7dyGQux8+MR?=
 =?iso-8859-1?Q?GgU60c7ooN8zYJ+19I2/k8V9UmgvMzsUc3xre/i60YkWOCjseqER+DXpNe?=
 =?iso-8859-1?Q?Oz6J7ueFNicg+05xbzrfu2QnrLvD+AF30bJhCTVaNny9l6Sd4Z0GaN0PXg?=
 =?iso-8859-1?Q?O9rx00yKLyWczeCfYrQAj2dWMXhJ1R/GQWRafZEC/VBpzkEkHZPY2EG3Z8?=
 =?iso-8859-1?Q?ThO0AfE5QgoXe9MFzkg7P6FQ+7rd6ov1Slv3TR9MWPrb8RZ0Ji+bkqN4zG?=
 =?iso-8859-1?Q?Q/YzZe3wvEn9jZ6t6T5FOyt12yibGh3cxM9G1UGY1S+NcotBfdj7l7MNqh?=
 =?iso-8859-1?Q?wfpCrKvzU2DOV6nrf83fXLS7uBqFnyAmU5I8krL3aisr8foaONabkCYwWe?=
 =?iso-8859-1?Q?4kton/KE0OhRGzkjo/AW/swxBpTyTwSgSxZdz2UlwXysRKQPQvvfC7iSuA?=
 =?iso-8859-1?Q?Qp4zxk/WslQY4Nf3hpsMdPs/tio4cSapBK2C3mvn+eT3TNXmGyIZbB9fWr?=
 =?iso-8859-1?Q?GlLbEuUGsmNTKFPQVMSplNMJY7vWo5unwdTkTAcUwQmXlp+rmYv5P099HG?=
 =?iso-8859-1?Q?MHwGPj+57G+VvMknil+dFEKEsflj2MtvRuBtCJUwDfl925riBWIP9oYpPe?=
 =?iso-8859-1?Q?uKdaPt8PUH3brpcmzZZGnQPsU2ZQ/Ij0W3lKSqlmzqQO5nACvcJXorF0ZE?=
 =?iso-8859-1?Q?b5RLhD6y6i3i8mm4LhUXuIQ8u6uD37NT2TCZJA/gfM5/5XvQGJrQMGeELd?=
 =?iso-8859-1?Q?3TNaST1M4o7lU0rzQDFeyUrd5yJqnBdUiflK2hr0cts6sSyqLsZFexp56O?=
 =?iso-8859-1?Q?yQLce37RiOiMU62pGHFOVxNSPQjwjNkf4kIB3QPGIdT5E7mcE6FFmeKg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95dc2df-8ba6-4530-ce93-08da9bbf250a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 10:50:48.8245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lcWtSfUwwmgOCXXp3V3Ttagnw6U9H9LmXd2P4lE0aPnwgW/1boQjfPNA34QX/Es57lGUaoO3xySeamgwgTUfziT+pcu4X8omoQ0qzSGREyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5676
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



> -----Original Message-----
> From: Biju Das
> Sent: 20 September 2022 18:01
> To: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>; Lee Jones
> <lee.jones@linaro.org>; Philipp Zabel <p.zabel@pengutronix.de>; linux-
> pwm@vger.kernel.org; Geert Uytterhoeven <geert+renesas@glider.be>;
> Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das
> <biju.das@bp.renesas.com>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>; linux-renesas-soc@vger.kernel.org
> Subject: RE: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
>=20
> Hi Uwe,
>=20
> > Subject: Re: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
> >
> > Hello,
> >
> > On Tue, Sep 20, 2022 at 03:31:16PM +0000, Biju Das wrote:
> > > > On Mon, Sep 05, 2022 at 06:13:28PM +0100, Biju Das wrote:
> > > > > +	if (period_cycles >=3D (1024ULL << 32))
> > > > > +		pv =3D U32_MAX;
> > > > > +	else
> > > > > +		pv =3D period_cycles >> (2 * prescale);
> > > >
> > > > You're assuming that pv <=3D U32_MAX after this block, right? Then
> > > > maybe
> > > Yes, That is correct.
> > >
> > > >
> > > > 	if (period_cycles >> (2 * prescale) <=3D U32_MAX)
> > > >
> > > > is the more intuitive check?
> > >
> > > Ok will add like below, so we support up to (U32_MAX * 1024); Is
> it
> > ok
> > > for you?
> > >
> > >   if (!(period_cycles >> (2 * prescale) <=3D U32_MAX))
> > > +               return -EINVAL;
> > > +
> > > +       pv =3D period_cycles >> (2 * prescale);
> >
> > Not -EINVAL, using pv =3D U32_MAX is correct.
>=20
> OK.
>=20
> >
> > > Same case for duty cycle.
> > > >
> > > > > +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle,
> > > > > +rzg2l_gpt->rate, NSEC_PER_SEC);
> > > > > +
> > > > > +	if (duty_cycles >=3D (1024ULL << 32))
> > > > > +		dc =3D U32_MAX;
> > > > > +	else
> > > > > +		dc =3D duty_cycles >> (2 * prescale);
> > > > > +
> > > > > +	/* Counter must be stopped before modifying Mode and
> > Prescaler */
> > > > > +	if (rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST)
> > > > > +		rzg2l_gpt_disable(rzg2l_gpt);
> > > >
> > > > For v5 I asked if this affects other channels, you said yes and
> in
> > > > the follow up I failed to reply how to improve this.
> > > >
> > > > I wonder how this affects other channels. Does it restart a
> period
> > > > afterwards, or is the effect only that the currently running
> > period
> > > > is a bit stretched?
> > >
> > > If we stops the counter, it resets to starting count position.
> >
> > So if I update pwm#1, pwm#0 doesn't only freeze for a moment, but
> > starts a new period. Hui.
> >
> > > >At least point that this stops the global counter and  so affects
> > the
> > > >other PWMs provided by this chip.
> > >
> > > We should not allow Counter to stop if it is running.
> > > We should allow changing mode and prescalar only for the first
> > enabled
> > > channel in Linux.
> > >
> > > Also as per the HW manual, we should not change RZG2L_GTCNT,
> > > RZG2L_GTBER while Counter is running.
> > >
> > > Will add bool is_counter_running to take care of this conditions.
> > >
> > > Is it ok with you?
> >
> > I'm torn here. Resetting the period for the other counter is quite
> > disturbing. If you cannot prevent that, please document that in the
> > Limitations section above.
>=20

OK, I will document this in limitation section.=20

 * - While using dual channels, both the channels should be enabled and
 *   disabled at the same time as it uses shared register for controlling
 *   counter start/stop.

Cheers,
Biju

> >
> > > > > +	pm_runtime_get_sync(chip->dev);
> > > > > +	val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR);
> > > > > +	state->enabled =3D val & RZG2L_GTCR_CST;
> > > > > +	if (state->enabled) {
> > > > > +		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);
> > > > > +
> > > > > +		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR);
> > > > > +		tmp =3D NSEC_PER_SEC * val << (2 * prescale);
> > > >
> > > > This can overflow.
> > >
> > > OK will use inverse calculation to avoid overflow.
> > > mul_u64_u32_div(val << (2 * prescale), NSEC_PER_SEC, rzg2l_gpt-
> > >rate);
> > >
> > > Is it ok?
> >
> > It uses the wrong rounding direction :-\ Using
> >
> > 	tmp =3D NSEC_PER_SEC * (u64)val << (2 * prescale);
> >
> > should be enough to fix the problem I pointed out.
>=20
> OK, Thanks for the pointer.
>=20
> Cheers,
> Biju
>=20
> >
> > > > > +		state->period =3D DIV_ROUND_UP_ULL(tmp, rzg2l_gpt-
> > >rate);
> > > > > +
> > > > > +		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(pwm-
> > >hwpwm));
> > > > > +		tmp =3D NSEC_PER_SEC * val << (2 * prescale);
> >
> > Best regards
> > Uwe
> >
> > --
> > Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> > |
> > Industrial Linux Solutions                 |
> > https://www.pengutronix.de/ |
