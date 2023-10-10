Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37ED7BF8FB
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Oct 2023 12:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjJJKs2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Oct 2023 06:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJJKs1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Oct 2023 06:48:27 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2115.outbound.protection.outlook.com [40.107.114.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6589E;
        Tue, 10 Oct 2023 03:48:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auGXtKERcJNPA0Iw1Zw3YzYzDExk4r63pj06aUY4dNFndt3272mIcDjbhsq4oTFpY/NC9Ovs12iLzzMfh/rDoGABsRSFmOCwTQSHm+MT8ZqPDZR9zMEw3/FOs+a9MiZLtL+n2eqQiRmrlVutkjat3ABWWkzoHk4UdfM5uXIswo6BE/rwXbSCTVnoXP2FWh/2ZOYv+xL3pJzh5HUKKn7WEGlxc6XOPfMP7vgGPLYxFpX4mQM7NNfDu7WsCQXeL7vozYJMdnV50+1etJk/puOWZRwHECpa7WfoD3YhwJ7uw3dRgkbVQs+rIGkSeTUNYu+8STknEJdP9t+/GNXQid/ynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSE0LCzU613H7ijGI7yjv2j23MqME7iE3sRnr4EApCk=;
 b=HtbUC+z1mLIFo+XMYcrDABqmZE5pOR9XXgwKZVBhy99NOIMb43N/bGAAGde0dgroDr40WEAiqlandH75p+mH8IFxcMkboRQ9nl0Ig/JjjeGb7w8kHz+ul3WUe04Fodai+BHDr5s9RVU2uwkdumI5SPZpUaSWLx+4HowtykbM/UhS6OkY7/m9wlP5WJJ26kCkrv+IcU2Wq5S69IwTrphse1yWto9eHzK4bkRJV091f4d7ktqfJpUWri6OUI1bkYq1zCHSATMLZQcyKZJ0ITza+krFYKZKYoN73EcHLAOFsMC98V3MTehcImiL4deUs5fEFB57jXTSyMGCl/QG91S57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSE0LCzU613H7ijGI7yjv2j23MqME7iE3sRnr4EApCk=;
 b=aUZOoiBkadGjMDUsdx5H2vaWv2jLu28VnUuLrGUmxuEW22VjE/SvqBkpGcBv2BtSEomdrm1Cuz58Qs0y9Ub5sNP8DGWTF+Zyg+8Lip/as9tloEYQpb4fJOK4LDrasvA5Rc7Gd30CvfNMkHwAV2RfTrO7G16DOB8cCn8dw2DoUIo=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by OS0PR01MB6130.jpnprd01.prod.outlook.com (2603:1096:604:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 10:48:19 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::88bd:e235:9b23:438f]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::88bd:e235:9b23:438f%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 10:48:19 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Biju Das <biju.das.jz@bp.renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v5 2/4] pwm: Add support for RZ/V2M PWM driver
Thread-Topic: [PATCH v5 2/4] pwm: Add support for RZ/V2M PWM driver
Thread-Index: AQHZq0en02LE3ecYd0yq1gsz8PdTabAeD4gAgBsOtCCAASWfgIAJMOBw
Date:   Tue, 10 Oct 2023 10:48:19 +0000
Message-ID: <TYWPR01MB8775EBB5A3A6D446D3B6F811C2CDA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230630114003.320641-1-biju.das.jz@bp.renesas.com>
 <20230630114003.320641-3-biju.das.jz@bp.renesas.com>
 <20230916153248.27k7erg7i7ruf76w@pengutronix.de>
 <TYWPR01MB8775150932FD1F0A346029B7C2C4A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <20231004141521.rgm74pepirnvzrwm@pengutronix.de>
In-Reply-To: <20231004141521.rgm74pepirnvzrwm@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|OS0PR01MB6130:EE_
x-ms-office365-filtering-correlation-id: d29293f9-57b4-4875-dddf-08dbc97e6a74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cURSkBs0YGZUBVsdYaCwPm17CW8b1y1qqdARC8RV2pFl5t054+bfSZqTVJHCTPdTJWQNAVUcdN5F9iYcubjwNoxBLRM6nY1sgoPVDLa30IO0u/B3QLQhmip+asP7Ef1XzRjgZn/B/OqOYUiGvOr6rLdvHpnLRbZ/A3rvzXByXgxdrI5RWDP1SV30L2lNS4pirMsEUnVWq/KqdSFLiWJ2ZOKCXIgTup111QjQdkGB4Y1a3oceBq8CRvvptUftdg4h+2nnS99eCDNfEfHoJKdbdXv7a2WKrOUEtzY8iWHtL1Fjk4MMskIchu7bK/OEe3XWd4suVVZdTYPdaOJVj66snrGDjiCh832iLBrAkugwayeedL7maLQmep90eC2sY27ebdlb0WWM1zPx1mrhMvT2+2JLvMmXl9UnZHx+8kKvc3/7cqGw5EP47f0urb32X0bMFT15tGrg9xaYb4/uE87oABxVt43l/aCPUjhF/vZ7PhaU93HE/AGaCCsDxnlSUYnB312XsZVhKW0EUrZjVp2pO1mlx9mxXneczhZda8d1XA3WS+LTSXFsR6uTR8c79Z5JmLmRLQVWgaUsYLhgJTORVfFc9DMpYD7lN2NYxBaqLOM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(33656002)(9686003)(53546011)(6506007)(7696005)(478600001)(966005)(71200400001)(26005)(66574015)(83380400001)(2906002)(5660300002)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(8676002)(8936002)(6916009)(4326008)(52536014)(316002)(41300700001)(55016003)(122000001)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jWXysw0J7jtchG04TGwGIOp91DWLuthrn+ePWiCPUThtHjWLdBxBUqT3qO?=
 =?iso-8859-1?Q?zHbio4SZR5IcXfb010StP1S02MF0bewliaCoooB03AawmkmZ5gTvIxCinK?=
 =?iso-8859-1?Q?neZ7ihR5Z38ZjcGDKpgGLFgnSDEopCnzEhm20147370fUW7tr6uNwk9RMR?=
 =?iso-8859-1?Q?3MQTQHS8x3IalCCuASLIY1BjXU4ryqg7wqIOnNxIFT2qiSwmPMK0Qk6Y02?=
 =?iso-8859-1?Q?Q39doqjtcbcVnO6EEc7Hn+b68b+H/qIRmMW9RMIEiwnwVpHafNPL4Pbviw?=
 =?iso-8859-1?Q?oBeyH/IKPeGdCyrk5NVqXNwlomZPtCFuRjspp47JJztA5V0hSQDihjCD+K?=
 =?iso-8859-1?Q?LuBjG+pkE4P4PGrWROz90KZNZnfhRxQFJdb/r3laC4Thdd0W+2hBWDD3Me?=
 =?iso-8859-1?Q?PNi/+47vOLAaHPdgT1O/V4wX9fbeFn3dUjEWjaaHRRA5QETi3rQ8v+yCBG?=
 =?iso-8859-1?Q?MsHQk6KdNsf6bZ6T4GElK5GwCAUvsmc974vTAtrHBNESl2r6/70YACD9bz?=
 =?iso-8859-1?Q?BMmtX/XH1steJcABuETgSQX9md6jRGPjxzbBCZUoAxWvBL58VFQJAJkA0e?=
 =?iso-8859-1?Q?Yu2fJ43dq2O3jvYmzndrIa+XsAU+CyOnH0wydtUt9/h8tFZMYgedAwTxa4?=
 =?iso-8859-1?Q?M6Lts2WEgGD8oJrjP2ZRiUIfiDU9A6QUCGR7As7I6bF37Cu/dXJfmMrrYz?=
 =?iso-8859-1?Q?AI7dbis3lDBORDOqKPW1sErqDTWP6/vA1XwhIi+HISYQSJ4D1U7xpecXJC?=
 =?iso-8859-1?Q?0lbFgAwfxvYka52FNaAttI4qlmwJ/IniHJdEQkH69MfGBLpqdbOXDrq2iG?=
 =?iso-8859-1?Q?vetcVbQL0+ZA6STjYKNJh/LKkJThHU6ZnX80CnsSm3P9j/iITjRLTQWa12?=
 =?iso-8859-1?Q?mGkBRcTwfkKeWVfEQrepNj+Vo4VsWmtuhtHiiTczMwTS6ot8bw4Jy+NoPr?=
 =?iso-8859-1?Q?Vj0hLpjuh9jRk+62SxlV79TvCl7PkaRP22bSaNAXss3+DnUiMcQeh9CtSd?=
 =?iso-8859-1?Q?DjICZa98o5nQiPfzstY5fRMwl/HRebRPIMXs42Ny3Jf/IqXwbJY65mtDzg?=
 =?iso-8859-1?Q?2r8581FTKc2iKF+IHVQD9xsi6CJ8MECoGYnLvLQelpDZlwiOXs1AYxYLZQ?=
 =?iso-8859-1?Q?j4J9IvYUdatmQJkALXKrNspJcd4KvCWTqmHXLxV62UvbWL3ge6MsmVfAIc?=
 =?iso-8859-1?Q?oczClsoQwn08QQMUhPgc3XOFyfaroUhrueCaP8naFS7jX/ZpvhvP3gPmgT?=
 =?iso-8859-1?Q?tF5SMpFskBZFARhyMxTtDC1cTWeqrX/M8JyRTVT1/nUkJwGSQn9fb4LnXX?=
 =?iso-8859-1?Q?TRrTVb4Uf4uoSsW0r2rjkuxhXUzYsd1BElvt7eUbn1P0D4nHRurqEtUKdX?=
 =?iso-8859-1?Q?5vmzTdmYXpoTSSnxY8f2iMFkPhiAR/UeJ/Uk3HKJ+pLH+QcI9kwVWaF3sk?=
 =?iso-8859-1?Q?9R0Ex45XLHZObbvAkoDNGpNSg4iELjNuCxEIbj2R772d5+akkAVbR3bOXY?=
 =?iso-8859-1?Q?bfnT7H5ygUM5pnOvlVCO8CkM8nbWwR/QAgtFJvWqK/lBXqptg4TpQ/Bwuo?=
 =?iso-8859-1?Q?RPy3fldzMcLK2WANo1cIkUp7va8AEuZQzciuJgU0Hf7osMEMagsdsLX3m8?=
 =?iso-8859-1?Q?Mwbsnty28ZcPBaNUO57KOoKXd0NdRh/u43hqYxDAyHGBNNTcKjV4twSQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d29293f9-57b4-4875-dddf-08dbc97e6a74
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 10:48:19.1794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O2UOYrLrwktSqHelc7er8h5b2tASK3LFSXmOMQoZbRPwxaYl6TH5YRbOIsXtlU/PKFEc34x+tH6VanznSrnH6Tb5GEpE8yXsqmMvaBWOJzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6130
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for your reply!

> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Wednesday, October 4, 2023 3:15 PM
> Subject: Re: [PATCH v5 2/4] pwm: Add support for RZ/V2M PWM driver
>=20
> Hello Fabrizio,
>=20
> On Tue, Oct 03, 2023 at 09:19:41PM +0000, Fabrizio Castro wrote:
> > > > +	if (period)
> > > > +		period +=3D 1;
> > >
> > > This looks bogus, why don't you add 1 if RZV2M_PWMCYC is 0?
> >
> > Agreed. We should always add 1.
> >
> > > Also it suggests that the hardware cannot do a 100% relative duty
> > > cycle?
> >
> > It does support 100% duty cycle.
> > PWMCYC =3D 0 actually means 1 clock cycle, that's why the faff with
> > increment and decrement operations, and that's why the confusion.
>=20
> So it doesn't support a 0% relative duty cycle?

It does support 0% duty cycle.

>=20
> > > If I didn't miss anything here, please add that to the list of
> > > Limitations above.
> >
> > Thankfully not a limitation.
> >
> > >
> > > > +	state->period =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC * (u64)period
> << (4
> > > * prescale),
> > > > +					 rzv2m_pwm->rate);
> > >
> > > The multiplication can overflow. I see no easy way to prevent this
> > > without introducing a mul_u64_u64_div_roundup helper. Maybe I miss
> > > something?
> >
> > It does overflow, good catch!
> > I think we could split this in three operations for now, and maybe
> > improve it later on:
> > period =3D NSEC_PER_SEC * (cyc + 1);
> > period =3D DIV64_U64_ROUND_UP(period, rzv2m_pwm->rate);
> > period <<=3D rzv2m_pwm_prescale_to_shift(prescale);
>=20
> You're loosing precision here though. With /^ =3D div_round_up:
>=20
> 	1000000000 * 5 /^ 3 << 2 =3D=3D 6666666668
> 	1000000000 * 5 << 2 /^ 3 =3D=3D 6666666667

Yep.

>=20
> So I correct my statement to: I see no easy and exact way to prevent
> an
> overflow without introducing a mul_u64_u64_div_roundup helper. :-)

Indeed. In my mind, the best way to tackle this problem is for such an
API to use an internal representation of 128-bit, so that it can calculate
(a*b + c - 1)/c accurately, and return both the high and low part of the
128-bit result (and maybe keeping the high part result optional?).
Something like
u64 mul_u64_u64_div_u64_roundup(u64 a, u64 b, u64 c, u64 *res_high);
or
void mul_u64_u64_div_u64_roundup(u64 a, u64 b, u64 c, u64 *res_high, u64 *r=
es_low);

Needless to say, the API may take quite some time to perform the calculatio=
ns,
but if precision/accuracy is what we need, there is probably no better
way of addressing this, unless you have a better idea?

Looking around, my understanding is that other drivers may benefit from
this sort of accurate rounded up result when a, b, and c are 64-bit, is tha=
t
why you think it has come the time to address this, or do you think this
is the first instance of such need?

Thanks,
Fab

>=20
> > with rzv2m_pwm_prescale_to_shift as below:
> > static inline int rzv2m_pwm_prescale_to_shift(u8 prescale)
> > {
> >     return prescale =3D=3D 3 ? 11 : prescale * 4;
> > }
> >
> > As it turns out "<< (4 * prescale)" and ">> (4 * prescale)" are not
> > correct for prescale =3D=3D 3.
> > As per manual: PWMPS =3D 3 means a frequency division by 2048, and not
> > 4096.
>=20
> funny hardware.
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 |
> https://www.pengutronix.de/ |
