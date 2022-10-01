Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCBD5F1DD3
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Oct 2022 18:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiJAQqt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 1 Oct 2022 12:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiJAQqY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 1 Oct 2022 12:46:24 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2130.outbound.protection.outlook.com [40.107.114.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FA92F002;
        Sat,  1 Oct 2022 09:45:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfzElTcYZKmib7o/c8pWmb5yTpuic8trKat/IiciUWH2NlFcHYhravnJy0AUWbEw/nZkTqGFDKGKHql7da9+peDsC8BoCn4rWNErYu8S8KwIWygCcu5VL90MxItZsduoYLLvNrwe882LigzNmnH2828/nP2v0MkICz4CnOKd2rcz8p4wGcHz4CIXDYtF1l9SoslgxHGj1ZZnTa/QlM1GApmLEp92kaYOY6Vt5ljeCb7oBWo+kD6PafIprSPsQFNqqyhtoyWIUXtQLVSwkb3v+4iMHUAdfPJAOkdL1jUoX/SAh6ElD5/0a2/uxlltysC1Ryd+13tOpPB5hotLoibTZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7UtZ00YMyZvWnrEMicowNLLp+emcUIjhsZ/wRMJOHI=;
 b=iohQHzRzYX6u0w/cZeDc93RUou5LZFfqObXzDlOViE5MxSjI0hDgHwJT1Ukqv82T8QM4zICrhzaOSNKw/EL+lkt/B4vslMfSUWuMcGYgiPb8eBZ/GNKGR/9XW6vaTCThPsCh62ewliGpnJuhw23Yf8C/shnZLSGti8DgifU6DftInR2IvcV+ivDkfIEWlgA5hW0/jfpAAOcp+/kJM1cBj/gsJudBT1Db63z5MvteKbzV4/4dcd8k5ENBMC0kLEPVduasjHBpz+j5UyOTPhGQPSgemllhDwV8d4QkzFMhY/q7BRMZMTofaDws6065h3c1+2vY+6dXzNbSi6DZqhD08Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7UtZ00YMyZvWnrEMicowNLLp+emcUIjhsZ/wRMJOHI=;
 b=noY3usekDzszIXrXwV9FOoPD1tiF4AY7MWU7pcuQO4EysXDJM3Cz6Orr16azsXmKQ8C7IykyJynSDs/9fjnodfHYkFOQ1kiwwzptUMS1JLNXw/4SCBeuLKQGguGbCZ5u5SokNw4c6VTfh7l8hcR+hpxQlvmkB4bDJJ80QAI2BxI=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY1PR01MB10642.jpnprd01.prod.outlook.com (2603:1096:400:325::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sat, 1 Oct
 2022 16:45:55 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%7]) with mapi id 15.20.5676.026; Sat, 1 Oct 2022
 16:45:55 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <wbg@kernel.org>
CC:     William Breathitt Gray <william.gray@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee@kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter driver
Thread-Topic: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter driver
Thread-Index: AQHY0arfC6iQwXKfcEeqoNkH1bZYIq3z1zkAgACGWoCABD8nAIABKKwQ
Date:   Sat, 1 Oct 2022 16:45:55 +0000
Message-ID: <OS0PR01MB59225B1CA8935C958BBA8AA186599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220926132114.60396-1-biju.das.jz@bp.renesas.com>
 <YzNztKSYQPQrnV7k@fedora>
 <OS0PR01MB59228FA93ED4D6DB8D9B799D86549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Yzd0YAWG/W9RNLQA@ishi>
In-Reply-To: <Yzd0YAWG/W9RNLQA@ishi>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY1PR01MB10642:EE_
x-ms-office365-filtering-correlation-id: 88ceaf2a-f2d1-4a15-2772-08daa3cc68fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AdpzImMkol1jqJdgBW2aOPcsOn1lXQK8Lomjdrrvb4/A1JtyIe/g6h0C+j/ehtgB3OqUX95aEPPvtUVlw4tLjWLD1TBNemQ46RjxNlGBcM+JrOnvdmEkISEq3aQr3j106CVWG3uuIVA6RZDS1DdOSsq3j69ssZMEBJeAox3xWy31UZNQJAe3IrRWmg3D/ItqytTa8XrwksBg9+ZpdmSDjtCeRv6v0EZ/DpiCxo7XiTw+OQtF9tzWFfkP9MJ9XMSl+dHkfOMFVTEU1xqXeomRcV9+3ghUapc1wuW2zbnbz/SwNicdp2m4uRLt9lHTXLKJPueyRDPj63/j/DFcfYCaza5qjgvwLAxrulGeLMemwOOYtwVH0w5dp0CzwNWHRQKf3cJNDmI2fnSKXGqkgx9fkbO/ChjCxADvV4vKTlOL7s57WjuCohgyB5fNGtoez2FFyQsN2lavKX0Fs5oBxdfBJBoQ0X3u7IZFEAfqQ4n31pe+bw1xhF0SEjXZEaAH1N2mtVuAQD7nPHMLVx898rnTdQCGs3GtCtqiGhkGOZ+jKXQXrNfp1og7vUy9pxPT6svCSE+AeCLfaOkCxHnpAH8pAsVsebn4XUWMCnGS7QqSlYEZZLYC8v8bxslH/NJOX0Wl8+JKo97bfJ+HvZfFeUan1JqyGzdaDbYFCg8lXpehvBTw+h8twF3JjpMK8F5nmqqdujGbqb3trXjoB4wGATlCSYyUnsRFkYFFrxfsmN1AnmntdvWbd8mMpPf/Y3mgCI4olmIYCnXSC3dq9eZlVtFhI1fNPR576f1ZS1akG3vist8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199015)(7416002)(26005)(8936002)(55016003)(5660300002)(6506007)(52536014)(7696005)(9686003)(186003)(2906002)(122000001)(83380400001)(316002)(54906003)(6916009)(71200400001)(41300700001)(66556008)(38070700005)(478600001)(86362001)(66446008)(66476007)(64756008)(8676002)(4326008)(33656002)(66946007)(76116006)(38100700002)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rfw6ptAUpIIGuuzlE3uk7zTt1MrIKQu3hk/JzoYLCeQ6zVm/n0Ryrw2JNW?=
 =?iso-8859-1?Q?I06fnHPKc++Eoe44WCFDGf9oUGhqHbSwX7w2Os8Gofwo3D7wsjvIoMtt1j?=
 =?iso-8859-1?Q?qfkpuCKT/7shGewds5F37s/fq34Rl7Yy4HsFRZSxUyQpHmJLCxnHh0pPMs?=
 =?iso-8859-1?Q?Rd7bTNK4lrQ+ZeIM0Tq882lk4nO5YY629XG9puy4XirYuR/ce1EtR4f/v2?=
 =?iso-8859-1?Q?7LhCetyN623YAMFGlZx2PUf62LFRO+nqRO8IlWN/q8wmBQ/yBQgIDzLQuJ?=
 =?iso-8859-1?Q?Pdo9mZrdc/c1y3JLc7gdOgSZKo6SEoWT0iewQIfaQuVeR3exZyGtsKHAQ1?=
 =?iso-8859-1?Q?2EyP2/hl1FsqqOIOeY1AYV1VI407/CZVw/WIVAsJAg+bcS6/3NyzKhDrio?=
 =?iso-8859-1?Q?LuD9cSYuUpR9mbXULWgGRO+ibHsnJwycm0bZMZbWghO7ML5XLHvXW69b/N?=
 =?iso-8859-1?Q?MsAkqEYnAqRyzfCFuXUA6J+UafjStFVCzk4XJwIHI0MLTn5jWt3WvAaFMZ?=
 =?iso-8859-1?Q?O7gxQtLzoqmkhYGmMEsAdICIIJXuGXm+sSCc5XGxfb2rw0KBe1alFlmx77?=
 =?iso-8859-1?Q?0DDX8QAJgxDXwevJxrCHUSiF9mEBLoGgWPI9tH5ahtE8kOJL021dk0GbKm?=
 =?iso-8859-1?Q?1lQV94Jlyx5fBP0rOZorYh8BWP1OnoZKT3oWp33JwHEipcicRYoCfs0ruA?=
 =?iso-8859-1?Q?3igs5k5AUona4P42E196dACe8+F0KbS1yHuw+Dmt4to1Odoh+5WyvYxQH3?=
 =?iso-8859-1?Q?CWLwqItofW+inkdxTwO65/n839KgfeiUjQI4Cnd/KG6y+g3f1LxqSv0lfX?=
 =?iso-8859-1?Q?gFjFtZ+ehP06ZByZZhDFYB1KcYs4TEE7HfAgUukyo2yjk/6kmfV5k5oE0U?=
 =?iso-8859-1?Q?PfA1fWN25PQ8EwbF+Y8wSrgreO7Y/8nhSaUbtdi9DQDwOC+b033f7VFwmm?=
 =?iso-8859-1?Q?3dYGEAT8mQh7Z+cVOvjbst5WuRjvOzZV3uMkmnlK+ijc6MdkMlEvXWhP7S?=
 =?iso-8859-1?Q?AUum2fMPdwYy8RV13WuP2qX3KIT4TKy3zq3KariNs11oWN3qqD19MulnP2?=
 =?iso-8859-1?Q?jzSd9aR1mypDxt2DwQCah2NXkjPn8fmFoXwu48G4MwAWc5kq5bripN3ky6?=
 =?iso-8859-1?Q?HMKm1jHTNJu+0iEVeE4DtL1SqWL5Pa7tn3LYWERICWQN2XGa0xr+ef5loY?=
 =?iso-8859-1?Q?T/GRUVRMi4Nczar7L0CInX5skvCECVhZDsNMsWY+A9mdp75H2L4Q/IDgmg?=
 =?iso-8859-1?Q?Eybp4pTaObewpwZzpWvCS6Hfpjf++rQ9Zvwq0r3qdeRkDRgSKjGTdvVQkd?=
 =?iso-8859-1?Q?QMiXEI98ch97GQ3fmCRsrT4K5vp0o4TZ1XA0FibziN+RgIoPTw1F7+8/ex?=
 =?iso-8859-1?Q?mx0VsakdD1OGiPJpr35ySr/jYQaDBbudSF24meLr/7A2BhmbhWo+G+3ZWD?=
 =?iso-8859-1?Q?8EPxC0mqqPq3uA3rirjhIFmTCsd1RXiuhUQ5SusZwUkTdWVJ8X4tVBHDcl?=
 =?iso-8859-1?Q?9z08/dYKaZlhDJUoVe+XmSvmXJIJ4m+ElOn5C1JcMC+h9X1tbZE+ERCdju?=
 =?iso-8859-1?Q?mXoMf1IHolk1OTnRTAwvhAii/3+QqV5oXBv+dKTxTbyiLo/kAzP4q8ZbqH?=
 =?iso-8859-1?Q?BzoyEsg0RaqxvWwEX+NiZnEY4bVIsbILmF?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ceaf2a-f2d1-4a15-2772-08daa3cc68fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2022 16:45:55.6070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JAAU0zuPzoHLIbzQ2h5YIyKAIwZW+66AdYrOKrAfkMvrErgYxLFwtWuV3VfTaezfzhQTXt1Vy0l1VJDfjhWsljlUZNcfTirIAIUvK9KngSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10642
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi William Breathitt Gray,

Thanks for the feedback.

> Subject: Re: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter driver
>=20
> On Wed, Sep 28, 2022 at 06:14:57AM +0000, Biju Das wrote:
> > Hi William Breathitt Gray,
> >
> > Thanks for the feedback.
> >
> > > Subject: Re: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter
> driver
> > >
> > > On Mon, Sep 26, 2022 at 02:21:06PM +0100, Biju Das wrote:
> > > > The RZ/G2L multi-function timer pulse unit 3 (MTU3a) is embedded
> > > > in the Renesas RZ/G2L family SoC's. It consists of eight 16-bit
> > > > timer channels and one 32-bit timer channel. It supports the
> > > > following functions
> > > >  - Counter
> > > >  - Timer
> > > >  - PWM
> > > >
> > > > This patch series aim to add MFD and counter driver for MTU3a.
> > > > Subsequent patch seies will add TImer and PWM driver support
> also
> > > > enhancements to counter driver.
> > >
> > > Hello Biju,
> > >
> > > I see this device consists of several channels, but only one Count
> > > is defined in the counter patch ("Channel 1 Count"). Do all
> channels
> > > support counting, or is it limited to just one channel?
> >
> > It is like this
> > MTU1 channel :- 1 16-bit phase counter MTU2-Channel :- 1 16-bit
> phase
> > counter
> > MTU1 + MTU2 channel combined:- 1 32-bit phase counter Other channels
> > are not supporting phase counting.
> >
> > Each counter device will have 1 channel. Currently it supports 16-
> bit
> > phase counting.
> >
> > Please see my test program. Am I missing something here?
> >
> > My test program:-
> >
> > echo 1 > /sys/bus/counter/devices/counter0/count0/enable
> > echo 50 > /sys/bus/counter/devices/counter0/count0/ceiling
> > devmem2 0x10001391 b 0x00 # Enable phase clock selection A for MTU2.
> > echo 1 > /sys/bus/counter/devices/counter1/count0/enable
> > echo 50 > /sys/bus/counter/devices/counter1/count0/ceiling
> >
> > for i in {1..5};
> > do cat /sys/bus/counter/devices/counter0/count0/count ; cat
> > /sys/bus/counter/devices/counter0/count0/direction;
> > cat /sys/bus/counter/devices/counter1/count0/count;
> > cat /sys/bus/counter/devices/counter1/count0/direction;
> > done
> >
> > Cheers,
> > Biju
>=20
> I'm not familiar with this hardware, but it looks like MTU1 and MTU2
> are on the same device. I think a more natural way to expose this
> functionality in the Counter subsystem would be to define a Count for
> each count value you can support; so something like this (all under
> /sys/bus/counter/devices/counter0):
>=20
> * count0 :- MTU1
> * count1 :- MTU2
> * count3 :- MTU1 + MTU2

OK, sounds good. so count3 :- 32 bit phase counting
count 0 or count1 or both then 16 bit phase counting

>=20
> You can then control the phase selection using a top-level Counter
> device extension (e.g. /sys/bus/counter/devices/counter0/phase) that
> configures whether you're in 16-bit phase or 32-phase counting mode.

So I need to introduce a new sysfs called phase. Use that one for
Selecting the external clock pin for phase counting mode.
Please correct me if I am wrong??

Hardware supports 4 pins for phase counting mode,

MTCLKA Input External clock A input pin (MTU1/MTU2 phase counting mode A ph=
ase input)
MTCLKB Input External clock B input pin (MTU1/MTU2 phase counting mode B ph=
ase input)
MTCLKC Input External clock C input pin (MTU2 phase counting mode A phase i=
nput)
MTCLKD Input External clock D input pin (MTU2 phase counting mode B phase i=
nput)

For MTU1, it is fixed MTCLKA and MTCLKB.
But for MTU2, it can be either 0-{ MTCLKA, MTCLKB} or 1 - { MTCLKC , MTCLKD=
}
On reset it is set to { MTCLKC , MTCLKD}.

Cheers,
Biju

