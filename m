Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A535FFAE4
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Oct 2022 17:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJOPRN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 15 Oct 2022 11:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiJOPRM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 15 Oct 2022 11:17:12 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2093.outbound.protection.outlook.com [40.107.113.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB681C435;
        Sat, 15 Oct 2022 08:17:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djKAND9tWkfaPW42icyKTvHrChxi+cHMdbi1dtn1hzd+PHtEEB0060l5g0MEoH1Hx+OKZzAkGVdq3IQSVHv5Xw0lk6b3uoteZBnoNisDvHWCdEICh64Cd36xNrzxfgqSsD0McyUU1dJfpYYzErjp1AXy9TlP902hoixU9o2cyx2g0Ofwr4a3VtYdPK38LSKmb70GF1adxiagt4X1XFU19ge1f0bCtd2D2/HeHj0NUMAvv5JExeIb3dc/z+8WWVTtCR7EJuDe1ikpkeZTN4JxN87wn7DhgQIww53GWqg2ts8ktNVaKrNAEaWl8CAuweCwaBTWuPw53A6ld6mdxa4d/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4O4/r5niwZIgTKFpGDetuD2icgtDU3VFnYO4O/mYvE=;
 b=Rj8ppz8VDyCUFBNQad9RZHlsplYWoAjD0lRmPW9jBkR7uUWlVoYY4tuWer6z1c+k9oK9ShYoCup05WRYd09x4TbYK9kHdQGLgiiXNpPjKi4/BbtdG64ejnVUrxNTPpKtBgmO2qM1kiugjYfIJHHh87f7bZP+PF20W6/OY3RjOozHyV9JblzTOiimmhDgvQvVa6j8OeAr2qJzjVL7DBuYQSCXTcD4k0Un2SM61ve2OPImvtOzIBmxf+ITF2+V2U7kIzHULkaFfB1AW2F1xggnrt3X1ywQF1yGTriAApgTNLGVpVKLoNzzBmsqQJbd3CtTRbVitp+IuEwnRj7+CrtZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4O4/r5niwZIgTKFpGDetuD2icgtDU3VFnYO4O/mYvE=;
 b=l/X+2vWnAQ702FauZEe32s7n9BERJJzxu6H/dQC5HqfuveFSLbunnjJ2vgVzPoye6ShJbJve1nMv5AZbApuiz5pwfNfZHkcpgboROLR+ERmTRaX3Cp6awfrQzm07MRzaJaxap/FUEdeA3I+HawEFxfXSOxySj/YNaY6N96Zfe3c=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB5703.jpnprd01.prod.outlook.com (2603:1096:604:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Sat, 15 Oct
 2022 15:17:08 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%8]) with mapi id 15.20.5723.030; Sat, 15 Oct 2022
 15:17:07 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Thread-Topic: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Thread-Index: AQHY3LfvgCpXQRSGOUCqUs4Dd5zxEq4JRt6AgAAA/2CAAESYgIAABVgggAARxgCAAAEEsIAF5t+AgAAMLWA=
Date:   Sat, 15 Oct 2022 15:17:07 +0000
Message-ID: <OS0PR01MB5922399A6497B452016D536986279@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-2-biju.das.jz@bp.renesas.com>
 <8d6b8f0e-d9d7-0d77-aa99-379de768fd5d@linaro.org>
 <OS0PR01MB592232C831CCA84FC302212F86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ad2e4445-052b-d65a-bdba-5759c169aafd@linaro.org>
 <OS0PR01MB59228146DE05231586212FE886239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <17fc9f27-03ad-7663-db21-2f14c7ff4312@linaro.org>
 <OS0PR01MB5922152268684B5564AA170D86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Y0rDpaGosqox77SQ@fedora>
In-Reply-To: <Y0rDpaGosqox77SQ@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB5703:EE_
x-ms-office365-filtering-correlation-id: fbfbc09d-55dd-4172-12b0-08daaec05334
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rXbzCjcjXmAYEzd8QBpmwY69a9BW8xevNnxy2qi0DslM16rQqIN7gMMdaBpVYM/cIvzRN/uC3S2j43arugcw2Ex8qTjOTFl0Aa91vPc+uABb24cjR+A+mNdkvfQJutfM1QU4xuLtM2smXkxmHZayKELUIoRPcMqt45YKAQvo7Y8NhtnUBGeHuNx5W7YHSIcrswEme3OotuFVzb9vHZTji4amu1SDlPs+ZGEwSizNDHQGufUM9v2cSOSy5wVWbztWgyi/mIY0MKEcpzHEwu+6XXWNhYCv7af3/2WOSb25xUW/s0Y6UixftRO7VWYMTtJlRxrafcebqEhJRJFw2hl2DOoEppE2MMY4PtTbZrC2kJW+EOISIpsL0Uq2YV5KGUaynMX1yEcC+IjkJd62uBae+dOB7B2QEK1/XATen3sAiIP81rhcXyGEErlK2HaDRhtCTZegyIJPfceYkGaN9+scZ6vL09ejGHtmtkWlFM7vhuX+WtT45Dq1X8SfuoK5H3mfTccLcsauIrFaSbwD+BbnrvthQrEmonX62LQrf+7UiA2uZzU1Aca/0le5RFbyfh8BmLFGlF/5VI3KGeRkjz5yFLVZse9ZYIgSzFGrdNtzld7vjsQvEtuhIrhcXaa7ghi7g3JinUOMh6CxwjwCkKl87wOTnW4RyOcuLfxWvPjEOgvh7kvxswTPZxqbCGjFVQDCWFqUR/q2AD4a7k39v+uxOuuIftY4w1X4FblJeNT2Mtr9b2hCRZOYpo/ZMtr6zKy92dmMY1WHx80gmXp86bBIDeiUEAYcntCNi/63GdCE7qE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199015)(6916009)(5660300002)(54906003)(316002)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(4326008)(8676002)(7696005)(41300700001)(53546011)(9686003)(26005)(6506007)(8936002)(2906002)(7416002)(52536014)(71200400001)(186003)(83380400001)(38070700005)(122000001)(38100700002)(478600001)(86362001)(55016003)(33656002)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BQJMV4znBW3cq4EdRel71eh3dgVzX9O6wJUUJeg7LKCU345H/Yrt1P/bkV?=
 =?iso-8859-1?Q?+Mt2DSSNwd1xOHnURhFipMmjA4t5fZddHfdwV32il1s896TyUQqh+xV+5g?=
 =?iso-8859-1?Q?qAg/vIXz0LsZBXXTKjhRUbsL7LSHLLZ4+AJ7FmYYZBMfWCfNaqE+EkGulH?=
 =?iso-8859-1?Q?f98P0yByWzjxH1r3BnYwsp7rfatmRXoyA9ximSFuac5tfxGuE5AhiwO21p?=
 =?iso-8859-1?Q?dixQJqYr2abC3Orq6LLXejQ21OsgK++B9Qbu0wBKo/MggxJmyaF4R4GPW8?=
 =?iso-8859-1?Q?bPHbtNmPGvuruLcgixfT3r3WiF5jOoQLRedLp9mVNCv1kzMzOeGqoi+Vbv?=
 =?iso-8859-1?Q?oMqqTl88b8sSKElsERDntvN7q1lugpYnzc7kjLWsdhoWquTa2uvJGGV9s/?=
 =?iso-8859-1?Q?lGAwJ5IsxBW98++gH+/FMhSc2QUvRQwVsVgPlhfGoHfIgiYNkFIVSqq3IT?=
 =?iso-8859-1?Q?BQbK/hkfZ0oAV6CoAXn3YS+EnVB7VQZCVieLj/DpAESpwTiXPE+1csqpGa?=
 =?iso-8859-1?Q?OOEDapG0WpcndxKKyEshrLLpnedXyYMukWPzKw7GJZv5yr7smrkUtxGkAv?=
 =?iso-8859-1?Q?v0Cd06UY+a45XVMDR/GoWcIHJOcjtk1APgHIE2NwODuuRVDQFeFEga7YPy?=
 =?iso-8859-1?Q?dK/ErbRzBkyC1iTtnE8HWEw3eXDzMS+s34hd50UtRYRsS9rVbixSvNDn0O?=
 =?iso-8859-1?Q?Lrs4EaUuX5Y3AQ9iZw9FUgunViOpZVR54Gp+zDT66o4aVsnktT7FcsnNaa?=
 =?iso-8859-1?Q?dMnzuP7iDJCR2ngN2yNjzYGPwb0UeYbDhbsXK/QYVteHvpp5EJ2QgpzmWc?=
 =?iso-8859-1?Q?SFMfNMYgwMWvEud1ZuPFwhDEJKT4Yv061PvJmdoWEqq3Onwcvv2V9GXrFV?=
 =?iso-8859-1?Q?ezjUhdbTyP4tIuD2DObSkVd/RbwMJAfg/nn6PQlDBnMwmNLuty5cOhx0n4?=
 =?iso-8859-1?Q?v6OipkyXxV07cFlI0Znd8lolGxvfkWCGVfOY0WXkVNkBo8ip6Zb01gGfwk?=
 =?iso-8859-1?Q?+7p+YfuK1z6M2fR4Wrot0wN1x5yxPhVNsEMx8gNhZg4wonnr+Bh8Npjwa/?=
 =?iso-8859-1?Q?RVS02WOzUWDOKWQym5xBDfLOs2NOkgrAcSyf4+EVp90DEkP09xfsNNnlre?=
 =?iso-8859-1?Q?AKcrRk0IPa1hho2h3TVgJdPb4aelUxWBLkWI9LGMU4n07CafdWpHlAMJ2o?=
 =?iso-8859-1?Q?h+mu82DDUGyn9RoGmwDvBFBqoCP6t/TUgrDrQ7z/I0TxqwfENQBTzAhFoK?=
 =?iso-8859-1?Q?pEobkTvjeCaujdYJBiOA7RgKEwtvmqZQvzHqhWY0PvvAn62wLtecIKZrNw?=
 =?iso-8859-1?Q?TeUnFCqhnAwTT6C/Vc4Yohud18VG7jGIzi4fpUcph/kAfdGd46E/Qr22YS?=
 =?iso-8859-1?Q?mKrJj0rGl6Utqu596asXLGj4pw2bWxVHDDIljhbtLP8CyUkMzcca8k1IqW?=
 =?iso-8859-1?Q?pR5IujDY+arY6OjO5vn8fphr7vGMrOfKxEtrIgofutCwu79oUj14WVYLYQ?=
 =?iso-8859-1?Q?7JmjUguwBdKmZILzJvxsndayneOb9o12ScZ7EroYgyvmj7UMCshkwJxBsw?=
 =?iso-8859-1?Q?P0zpQnTPplApR2Y8JGgo8smTZENIV2rHg2dBDLqELKbkbCyZRXBshPCHha?=
 =?iso-8859-1?Q?tzw50FGFhsagNCmFBfMG1zijRafqzfoR9Y?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfbc09d-55dd-4172-12b0-08daaec05334
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2022 15:17:07.9065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOPFfdSuJNWirh2dTn0dlhPHhxBW67YjbVQVObWD/2oiYxg17l0LjsVbqOjU2ZAt//T5XogHFm0Nddgnx2kcN2mKKOWGfdDnOT4cROt1Cx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5703
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Hi William Breathitt Gray,

> Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a
> bindings
>=20
> On Tue, Oct 11, 2022 at 08:31:48PM +0000, Biju Das wrote:
> > > Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L
> MTU3a
> > > bindings
> > >
> > > On 11/10/2022 15:23, Biju Das wrote:
> > > >> Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L
> > > >> MTU3a bindings
> > > >>
> > > >> On 11/10/2022 10:55, Biju Das wrote:
> > > >>>
> > > >>>>>  .../bindings/mfd/renesas,rz-mtu3.yaml         | 305
> > > >>>> ++++++++++++++++++
> > > >>>>>  1 file changed, 305 insertions(+)  create mode 100644
> > > >>>>> Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> > > >>>>
> > > >>>> This should not be in MFD. Just because some device has few
> > > >> features,
> > > >>>> does not mean it should go to MFD... Choose either timer or
> pwm.
> > > >>>
> > > >>> MFD is for multifunction device. This IP supports multiple
> > > functions
> > > >>> like timer, pwm, clock source/events. That is the reason I
> have
> > > >> added
> > > >>> here. MFD is core which provides register access for client
> > > devices.
> > > >>>
> > > >>> For me moving it to pwm or counter is not a big problem.
> > > >>> Why do you think it cannot be MFD?
> > > >>
> > > >>
> > > >> Because it makes MFD a dump for everything where author did not
> > > want
> > > >> to think about real device aspects, but instead represented
> > > >> driver design (MFD driver).
> > > >
> > > > Core driver is MFD, just provides resources to child devices and
> > > > is not aware of any real device aspects.
> > > >
> > > >>
> > > >> MFDs are pretty often combining unrelated features, e.g. PMICs
> > > which
> > > >> have wakeup and system power control, regulator, 32 kHz clocks,
> > > >> RTC and some USB connector.
> > > >
> > > > Here also same right? pwm, counter and clock are 3 unrelated
> > > features.
> > > > That is the reason we have separate subsystems for these
> features.
> > >
> > > These are quite similar features of a similar piece of hardware.
> > > Sometimes called timer.
> > >
> > > >
> > > >>
> > > >> Just because you will have clocksource driver, PWM driver and
> > > >> timer driver does not make it a MFD.
> > > >
> > > > MFD is multi function device.
> > >
> > > No. MFD is a Linux subsystem name. Not a device type. The bindings
> > > are located in respective type.
> > >
> > > > So are are you agreeing Clock source, PWM and timer are
> different
> > > > functionalities or not? If not, why do we have 3 subsystems, if
> it
> > > is
> > > > same?
> > >
> > > Linux subsystems? We can have millions of them and it is not
> related
> > > to bindings.
> >
> > OK.
> >
> > >
> > >
> > > > Where do keep these bindings as there is only single "rz_mtu"
> > > bindings for these 3 different functionalities?
> > >
> > > Again, focus on hardware not on Linux drivers. Hardware is called
> > > MTU
> > > - Multi-Function TIMER Unit. Timer.
> >
> > OK
> > >
> > > > pwm or counter or mfd?
> > >
> > > Not MFD. I already proposed where to put it. Other
> Timer/PWM/Counter
> > > units are also in timer.
> > >
> >
> > I guess for counter/pwm maintainers, it is ok to model MTU3 as a
> > single binding "rz-mtu3" in timer that binds against counter and pwm
> > functionalities as well??
> >
> > Cheers,
> > Biju
>=20
> I'm okay with putting the MTU3 binding under timer; we already have
> Documentation/devicetree/bindings/timer/renesas,mtu2.yaml there so
> adding a new renesas,mtu3.yaml next to it seems reasonable.

OK.

>=20
> Just to reiterate Krzysztof's point, the subsystems in Linux serve as
> a way to group drivers together that utilize the same ABIs, whereas
> the devicetree is a structure for organizing physical hardware. The
> structure of physical hardware types don't necessarily match the
> organization of the ABIs we use to support them. This is why you may
> end up with differing heirarchies between the devicetree and driver
> subsystems.
>=20
> To illustrate the point, take for example a hypothetical digital-to-
> analog (DAC) device with a few GPIO lines. Those GPIO input signals
> could be tied to buttons used to indicate to the system that a user
> wants to reset or adjust the DAC output, while the GPIO output signals
> could be status lights or triggers indicating that the DAC is
> operating. The respective driver for this device may utilize the IIO
> subsystem to support the DAC and the GPIO subsystem to support those
> GPIO lines, but it would be incorrect to put this under MFD because
> the purpose of the GPIO lines is to assist in the operation of the
> DAC; in other words, this is primarily a DAC device with some
> auxiliary convenience functionalities, not a MFD with distinct
> unrelated separate components.

OK agreed. Thanks for the explanation.

Cheers,
Biju
