Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB4E53EB82
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jun 2022 19:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbiFFMdc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Jun 2022 08:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237129AbiFFMdb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Jun 2022 08:33:31 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2132.outbound.protection.outlook.com [40.107.114.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF96D2B1968;
        Mon,  6 Jun 2022 05:33:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZw5PYbZH0MJnviujbsK3rvEDej3ectL9c5JVvAc1+5XBg3eGSrAtJb83rysWGwLOR1lpPwRGWx7mfs2mIoWGgPAq2mMM62qFxzRkshZRBjXRYzKBPQz+ygjIJhI3M7CBfN1dQPGT/Nm/QmvYOhQMSRVPl+h25ssnaut3eIUowBRCGAg+VyHth00mxFgwn1OJomZVpdpIZYtbk8NS+YhgzUx7pRdOvulliMESTfDeruVhTzxBPiIBEr/7myWaZ6pvJvwjGDgm/PSSNaSl5LbGV3JfLJdSjPsk7/3AIcekeIxUlN+VFQXEdX7IXu02jrZEqwqB6M5Us+0KYZnbYK+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KV79rjX2LyOoIitNeMxmmkXlCNygCiIEz7l0KXW7qHw=;
 b=BpzR0L1lwvVgB8zcBa5ZDkvVglEIvj7IpLSdMZTHByePQ5KLeNFQhVhWTF7Lsh373e5dykrfRAeSKPXrQ5P+V3+vl12ysPFIs/MT/mBsL5WHHKb3WT5CUmhdvo74Xil3tZubtQwjWU9vDHH3+G6GM7Iinmg0qnXdjNGYS2UxCgHMZpexJWewnTxG2xy1P/kkMk7MhHjd2eufnSzP9ZR71zbQAKhfVBCncXaZ0Hl4ypLMIrNWk4m8Mtz7ponrv7d1MRfHS9FOa6akQSkfdgIjyAsGlyhjD8E7mtEfSZZmhGYtNVgITZEatQdxCnsvOld1i4eTHxLBjgGZBZOE7ClzlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KV79rjX2LyOoIitNeMxmmkXlCNygCiIEz7l0KXW7qHw=;
 b=lLKFUo1FND25od1cC9HQ+SH2rKZzaZJhNSK3RDQlRIT8FEsyNvdIHbMhNw2Ocf1BSeiero1lQLFyVZrLaxRFYx9+6KdqQ0McrChQkLOWX/b7+/BMQLXKLdbjqr1ur/bL8wGtgqJngOmJRKSUObDnD9e9cpIPqtIme20QiMsyrsE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB9893.jpnprd01.prod.outlook.com (2603:1096:400:208::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Mon, 6 Jun
 2022 12:33:26 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 12:33:26 +0000
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
Subject: RE: [PATCH 2/2] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH 2/2] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHYZHxJPKj+on69sUCHtZySxVH6FK0YTo6AgCK97uCAANNWAIAGkbqg
Date:   Mon, 6 Jun 2022 12:33:26 +0000
Message-ID: <OS0PR01MB5922017927174886AD20580786A29@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220510144259.9908-1-biju.das.jz@bp.renesas.com>
 <20220510144259.9908-3-biju.das.jz@bp.renesas.com>
 <20220510163405.pts6mm7zdoxxpmqt@pengutronix.de>
 <OS0PR01MB59227827AD31CBD0CCC31A6A86DF9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220602074306.4fp2fmf7fv4jfg5h@pengutronix.de>
In-Reply-To: <20220602074306.4fp2fmf7fv4jfg5h@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77cd9bcc-4187-4a3c-077c-08da47b8c118
x-ms-traffictypediagnostic: TYCPR01MB9893:EE_
x-microsoft-antispam-prvs: <TYCPR01MB9893800155B9C436EA40E13986A29@TYCPR01MB9893.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hCzju4zFvV9lujujXfQHRz5GpXEz23EA3qYBKdIt/x4qW3eTC1MYDuTi375SJESmk9fT8yZQ3OT1eLRMrTK9mn83PJVdQnuzuRmoN2v6Wnph2zGRCj9NDy37K5LYCvo0pNSdJYekylx+I22RbZhJqlJa/ay16/iELdtOiVu7IkKC6HxC8OISyybpDAtjYxyJR971Lko6eFnU9jh9TP1gfy2z/mzPpFWyuW5pycMfGSkd+Hs0PO1NRRfBqP02qms84iRbsVd5e34vCgX7z2SlfodulIHcyH/pyGbv7Zsi+pLw0c4m2UAh8PJ2V9L1ZIoPm3EZMslDB2eznR4mlpLoHOXQydyWp4eNeORdDyyR8h97unsbuF2WImCz0kplIXk8yXQjkY/8mShgqgj9zgP7xQu/Qs+7b4ZlH661yr1Odws/lkZ7BhvvdcRJKYrUqKf0f5jrkUp0wZEPZ+hz0/glNvIBg08vhHe6NMXqQG0VfL2wJp6PGz/HlWKKezphqG89qGsB0xmA7/o3t32yMAF1l8TrmAcb4NuncOUnF6HiPl0wvdOpeqO05Dm742TBoqEJcSAjOwACyKOjpze2VLFgpsJZtGIzFHvP3lR01pEO6T/y0iN+x0bQCBA2+ESE1qaDUXG33srBlYnkLVevMYoSTxrgaonui/ojzE6FWzK3hn3IMrcsKidWdqrMr5HheL9z0i+P28Rm4liMIivYYFOnbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(8676002)(38100700002)(64756008)(66556008)(66476007)(66446008)(4326008)(71200400001)(66946007)(2906002)(6916009)(76116006)(508600001)(5660300002)(122000001)(38070700005)(8936002)(26005)(52536014)(55016003)(33656002)(316002)(83380400001)(6506007)(7696005)(9686003)(86362001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1rP/p9eDDlXNQcm5iw2CTO0UlL2/DU1SqtpWWZgKmDcU73ZHEZ0sNQY4fz?=
 =?iso-8859-1?Q?LyejBzFwP+b6ZJaVCsgJObEM2RQ272HnkhPTuQKfMzIosadpmrOH6MOpdk?=
 =?iso-8859-1?Q?DnqRgvxW9D4l5q3UvzRLIN2OZYrfm0NXU+hgvu6zlO/oXuLNS+pNLPfm4m?=
 =?iso-8859-1?Q?4lheXqIxsqLCU1Acs5g5fjyPjF9gHOh+tEqwLtW3t41jLdZJ93lbRM9UN0?=
 =?iso-8859-1?Q?005cd5YzsQuov5k3nnfo6yGq192H2sjkQIHH1qeZ+fFIW/jbKAZB6KxWBW?=
 =?iso-8859-1?Q?x6e6pmVSfr/kdv04XqQer1Fpad/Ee0rzDWulcRX/VWLpVX4bCGXS384nbD?=
 =?iso-8859-1?Q?AkjPqs8cQl+NvucjcBmjAjFFTEjI4n3z7eaxhKCFYeqPrj92+Jjj3EDj6j?=
 =?iso-8859-1?Q?ocf18HvREN474uY+TBZUoNV3JP4vLRTooeYaCHqiYHhuSzoHyEaYV9HrUe?=
 =?iso-8859-1?Q?Xf73rSA2p261BAoziCeB7W+iEVpS7G4aE2ZyhTlliMhneQ5cGxyivBUgeL?=
 =?iso-8859-1?Q?YWTCiB097KGbZ5TgYJtBhBPDmStMLDMvamqUqBM4cDY1KHKpasgAHWtRaN?=
 =?iso-8859-1?Q?YOorvbTQYyYE4JyBcbj9iRa1ZR4LCkLdH1Q1TVH08lIX8H/aRwT1wjVjDQ?=
 =?iso-8859-1?Q?6T2hc1G4vOROMQEmY/dL8UUBaeTgEJ3Kax0w+1lyhL6BLO1UrG85jYLkR4?=
 =?iso-8859-1?Q?GpMV6m3CHHolQIkaJGp8VyR2pFPrTW38Spol86Bdaar5YkvZ08tf5U+h/q?=
 =?iso-8859-1?Q?sV3YCLfv7Ntn135TlRx7hwUajNZGB9Kt1WTui33DFeYgUBbJNqWAx/sr4C?=
 =?iso-8859-1?Q?dm1n5Gmk/Ppt4fo9Y4MEqPw36b836TGC3v+wp91C5QedLatBZ6BPeRi79g?=
 =?iso-8859-1?Q?tF1wm9YMjdrnVOcmX37AEaepVBTZsUgG3Dsin6Zc5tslsa5hA8bOPinFVs?=
 =?iso-8859-1?Q?OMgg+oQTAWJS3DiirqyjBb/4YWp1M1bWjRV0sYFedOK7Pk9Yb4/WIL/RpD?=
 =?iso-8859-1?Q?jMYtxt3Mj9+jKM0lSxqmNKETOEMK9ph0tjbTd22JHF2fLcH+2WYXwTcxWT?=
 =?iso-8859-1?Q?NEx7C47wxwQqLLw0CH/Hemx/iWAnWVM9P9eeb07ujHVJ9FvQ5bGtLA4KGU?=
 =?iso-8859-1?Q?b0mAkkZWSU0eeu2HfFNLqNH9qkpLLAwXqsDAU+8x9GAU8UaQhUdRO5tiok?=
 =?iso-8859-1?Q?G5TPDrQXdNPEMb4xmfNGSWmCZt3+CecJT2gLImb3Xo7TU4k6+BaCAVIrkj?=
 =?iso-8859-1?Q?8RyFR5S2LRkRdkRnAheY4yFkr3y7QxNcYHYck3oaCOZsP+3t4L+cVamPcr?=
 =?iso-8859-1?Q?9GW3p+lztKxnTYQL+3ScnXWnoyha3rBQZuZFXHK5SVw5naObohwC+HPDK4?=
 =?iso-8859-1?Q?iruohgmH6qJVYez1ktljpSJyUXZY4oahfRxQ8J88fwUCqxvmb1RWwHUiYI?=
 =?iso-8859-1?Q?Ar6tuJEuqJ+rbxbvvkfQ4iKeA/cC/leHNdn53d7vAd5xh2OZuGetC/34wO?=
 =?iso-8859-1?Q?w4yZrxCiUQQ8FpzGmx1CKpp2YlEbiGTUsJXzmvEnky4Z2JVX0ZwduSX9lz?=
 =?iso-8859-1?Q?GWr3x77oGzDQXw9JLzBvnaplLQPL+SvSFpRapFAqtalAapG2wFXDnA1b1V?=
 =?iso-8859-1?Q?kqn7P+nqtlfNzxY2k5zjsvRa6Zp0BtThwq4Gblj3uMx1kktZQrlbeRfiGj?=
 =?iso-8859-1?Q?gP8N63KDvE0q4B75iuAhuQxnsi1bW6iSigtp6yxpqrZ4gWrOpSXHTSm4f3?=
 =?iso-8859-1?Q?OAlJyNNeECIi7pCRwFtRMZ1hlkhnLq+n6iOVTU7ibgo7Dj+kie/pmRMnGA?=
 =?iso-8859-1?Q?VPA2nLuA5pG6ZSDdoCp7F2936Kt6cPY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cd9bcc-4187-4a3c-077c-08da47b8c118
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 12:33:26.5010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rdamS2PFk5b5L256aXPjwOwPCKKYNvfbysaShkYoIBF1ipWQ0LujjZ1GvSLmVY/sUnhuR+Ak6PEmlnp24pdYhja6skbGg//oGRgxbu1ipH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9893
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for the feedback.

> Subject: Re: [PATCH 2/2] pwm: Add support for RZ/G2L GPT
>=20
> Hello,
>=20
> On Wed, Jun 01, 2022 at 07:25:28PM +0000, Biju Das wrote:
> > > On Tue, May 10, 2022 at 03:42:59PM +0100, Biju Das wrote:
> > > > +	clk_rate =3D clk_get_rate(pc->clk);
> > > > +	c =3D clk_rate * period_ns;
> > >
> > > This might overflow (once you keep period_ns as u64).
> > OK, the logic is changed like below to avoid overflow.
> >
> > 	freq =3D div_u64(clk_get_rate(pc->clk), 1000000);
> > 	period_cycles =3D div_u64(freq * period_ns, 1000);
>=20
> This might still overflow for big period_ns and freq > 1.
>=20
> Better use mul_u64_u64_div_u64 and limit clkrate to prevent an overflow.
> This yields a higher precision without overflow. Something like:
>=20
> 	rate =3D clk_get_rate(pc->clk);
>=20
> 	/*
> 	 * Refuse clk rates > 1 GHz to prevent overflowing the following
> 	 * calculation.
> 	 */
> 	if (rate > NSEC_PER_SEC)
> 		return -EINVAL;
>=20
> 	period_cycles =3D mul_u64_u64_div_u64(rate, period_ns, NSEC_PER_SEC);

OK. Will use this logic.

>=20
> > > > +	period_cycles =3D div_u64(c, NANO);
> > >
> > > Please use NSEC_PER_SEC here.
> > >
> > > > +
> > > > +	if (period_cycles < 1)
> > > > +		period_cycles =3D 1;
> > > > +
> > > > +	prescale =3D -1;
> > > > +	/* prescale 1, 4, 16, 64, 256 and 1024 */
> > > > +	for (i =3D 0, prod =3D 1; i < 6; i++) {
> > > > +		if ((period_cycles / GTPR_MAX_VALUE * prod) =3D=3D 0) {
> > > > +			prescale =3D i;
> > > > +			break;
> > > > +		}
> > > > +
> > > > +		prod *=3D 4;
> > > > +	}
> > >
> > > This would be better understandable if you used:
> > >
> > > 	for (i =3D 0; i < 6; i++) {
> > > 		prod =3D 1 << (2 * i);
> > > 		...
> > >
> > > 	}
> > >
> > > Have you tested this? The division by GTPR_MAX_VALUE (=3D 0xFFFFFFFF)
> > > looks suspicious. Unless I'm missing something
> > >
> > > 	if ((period_cycles / GTPR_MAX_VALUE * prod) =3D=3D 0)
> > >
> > > is equivalent to:
> > >
> > > 	if (period_cycles < GTPR_MAX_VALUE)
> > >
> > > . Is this really what you want here?
> >
> > On the next version, I have changed the logic to check this condition i=
n
> caller function.
> >
> > 	if (period_cycles > 1UL * GTPR_MAX_VALUE * GPT_MAX_PRESCALE_VAL) {
> > 		dev_warn(chip->dev, "ch=3D%d period exceed limit\n", pwm-
> >hwpwm);
> > 		return -EINVAL;
> > 	}
>=20
> Please always round down period, that is, if the request it's too big to
> implement, do the biggest period that is possible.
>=20

OK, will use round down.

> With GTPR_MAX_VALUE =3D 0xffffffff and unsigned long being 32 bit on some
> arch, this isn't a sensible test.

OK.

>=20
> > > > +	/* Set counting mode */
> > > > +	rzg2l_gpt_write(pc, GTUDDTYC, UP_COUNTING);
> > > > +	/* Set period */
> > > > +	rzg2l_gpt_write(pc, GTPR, pv);
> > > > +
> > > > +	/* Enable pin output */
> > > > +	rzg2l_gpt_modify(pc, GTIOR, pwm->ph->mask, pwm->ph->value);
> > > > +
> > > > +	/* Set duty cycle */
> > > > +	rzg2l_gpt_write(pc, pwm->ph->duty_reg_offset, dc);
> > > > +
> > > > +	/* Set initial value for counter */
> > > > +	rzg2l_gpt_write(pc, GTCNT, 0);
> > > > +	/* Set no buffer operation */
> > > > +	rzg2l_gpt_write(pc, GTBER, 0);
> > >
> > > How does the output behave on reprogramming? Does it complete the
> > > currently programmed period? Please document this behaviour as e.g.
> > > drivers/pwm/pwm-sl28cpld.c does.
> >
> > Mode and Prescalar must be set, only when the GTCNT is stopped.
> > This condition will document.
>=20
> Please document this at the top of the driver. Take e.g. pwm-sifive.c as =
a
> template. (And please stick to the format used there for easy greppabilit=
y,
> i.e. use "Limitations:" and a list of items with no empty line between
> them.)

OK. Agreed.

>=20
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int rzg2l_gpt_enable(struct rzg2l_gpt_chip *pc) {
> > > > +	/* Start count */
> > > > +	rzg2l_gpt_modify(pc, GTCR, GTCR_CST, GTCR_CST);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *pc) {
> > > > +	/* Stop count */
> > > > +	rzg2l_gpt_modify(pc, GTCR, GTCR_CST, 0);
> > >
> > > Same question here: How does the hardware behave? Does it complete
> > > the currently running period? How does the output behave? (Typical
> > > candidates
> > > are: freeze at the level where it is currently, constant 0,
> > > high-z.)
> >
> > It is set to output low during stop.
>=20
> OK, that should go to the Limitations section, too (even though it's not =
a
> limitation).

OK. Agreed.

>=20
> > > > +}
> > > > +
> > > > +static int rzg2l_gpt_apply(struct pwm_chip *chip, struct
> > > > +pwm_device
> > > *pwm,
> > > > +			   const struct pwm_state *state) {
> > > > +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> > > > +	int ret;
> > >
> > > As you don't support different polarities, there is the following
> > > missing:
> >
> > There is a plan to add polarity in later version.
> >
> > >
> > > 	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > > 		return -EINVAL;
> >
> > Agree, will add this check in initial version.
>=20
> Does it output low or inactive level on disable if inversed polarity is
> configured?

As output low on counter stop is controlled by GTIOR register(currently it =
is configured output low for Normal polarity on disable). We could make it =
to either output low or output high on disable for inversed polarity. I am =
planning to configure it as output low for inversed polarity, when we add t=
he support for same.

Setting GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH--> gives normal polarity
Setting GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH--> gives inverse polarity w=
hich is 180 degree out of phase.

Cheers,
Biju



