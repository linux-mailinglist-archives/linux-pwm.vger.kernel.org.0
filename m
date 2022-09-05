Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2E55AD82A
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Sep 2022 19:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiIERMn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Sep 2022 13:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiIERMg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Sep 2022 13:12:36 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2117.outbound.protection.outlook.com [40.107.113.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175702C123;
        Mon,  5 Sep 2022 10:12:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Risen06wUgbGxY+PCIgsLVMvc7plQmGiiQPT3qKxFJ2tukPI4vGR7duMhjHP3WgZeA0mKJ3cxxfvOkai4JGnzbsa9GiNzxMY/5w2wECyJjYNecltlxOfUNhOSN72h3BBIfLbjO1yJtStEmyqfaGKSYfMjX4aPu7Qve3GyF/+1o7gCOqjfIcFqZz1RJ39HekvyT7DmDOIyfQhBbb5uMTCPFSJc0XeO5py9eLc/ykYtATCT/4ofZSpb07iIxbNYUfn1XdM2yNG2j8glw0mG3jaqW0/5QHCn4QI0Mh9BtN2Yeww2tNGYF/DpgPGcTVQ3NRpuaU4CeVx/7igGjBjxDXSSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkxgiyi4YURYP10r9uGuUnmxw8Ey3SJr1BSWkiEJZ6k=;
 b=PDPNKWJKHwKZJz3SWNa88em0MbtIJWr0oUoqEE3tWijeguq+wVXBHl3o4G43Lp6lN9z5q0yJ282T/k0rQqIQ9pj7pXfJ6YHFMSPcU7XO84SvEbE3SRgHC8LZnt98gd8sqkVlGTGHBL0n8q+PsUky7Jd6pKChFtS1/ugLcOtCm+E3dw54ZUnFlCd1CtebJ1dmqPKFAIbz9aw/w0kDFi+2RLi+uQmi/hmDfLEemrWi70A1tADu2Nt0gAg/CBJ/aunDFtsKiIr8HyQwno0H5SGtF685azKTFnwRfeuhabGf442ljfrJQqTfwx42LxG/FakPimDtFXKL8fOTVpvLoTNczA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkxgiyi4YURYP10r9uGuUnmxw8Ey3SJr1BSWkiEJZ6k=;
 b=TO3UMj+Oxx6o/asciLqgKjHcTzIqqBX7AfVT/qR7K1gisBvaZn98ddemt2/t3PvijcWEnpwO8BAx2/8S12gte67cTkKPzbv/XI7qO+TtEeU9oXFsd/wbLGSfV9+R6EdjBYWOrnFD9FJHt/9DOUGzo+qBhBYMLkYa+SPX2uIY5gY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB8589.jpnprd01.prod.outlook.com (2603:1096:400:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 17:12:31 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::14d3:5079:9de1:ceaf]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::14d3:5079:9de1:ceaf%4]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 17:12:31 +0000
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
Subject: RE: [PATCH v5 2/2] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v5 2/2] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHYqNuq5rqiJTgOfk+nXQY7+fFusK2gzJUAgBvf0GCAFJXY8A==
Date:   Mon, 5 Sep 2022 17:12:31 +0000
Message-ID: <OS0PR01MB59224E5DE2F09340D3F23E0E867F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220805145704.951293-1-biju.das.jz@bp.renesas.com>
 <20220805145704.951293-3-biju.das.jz@bp.renesas.com>
 <20220805210554.czafwmpq46prlfx7@pengutronix.de>
 <OS0PR01MB59224594846E30D2D8D76F2E86709@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59224594846E30D2D8D76F2E86709@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05ccac4c-6d0f-49ce-22f5-08da8f61d165
x-ms-traffictypediagnostic: TYWPR01MB8589:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4PVbObjHho0RY0XyUtJNMTcexCVQliZ3BHULYpavtYiLw9ybfOQNRcLIAw21NU1r/RUPNUD+YKNZy/6j0ar9O5tAV47jGfP/HnDSUUT6N3J0EWTtcO3hBK1YPhpNktkiW6ePr6UULFD8yZyu45vgCbLB0iDfnoF/W7sDf3nOFxed1YwEbzy+EOpDtvlDb5j5ouX28jzWOn/fhr40/zT3ITQatmVql+ZXKAGgORzSQ4NRrcfa0ZXzBdBmgdRUGICtVyK8+tyHeZzrxr8mt2Xo4yBAcEjOzlrZvIRyIw8+b/IDSnb4Lh44SHbyNjeDjziURnl0UhDUx3hP4bffi99D16B0mnKn9fpu+RRafcKgnTQdOidFtiHXwzUiKsF/MDUWJTfheOG8jgPFPkzyX0+jK2IW4GvDcLfcUePFBd54WnfWk4PMkBFN/Enrto5BZm4IeCRAkThA1fJfqmDnVB06vp/NC7AEevx3TLe/4qDcm/2n0nzfTjFTq/TymSXxIsuW1SKTlapm1gTYeeb8RWqM5dzj6WB6TNQjtDvQSvnTvmhc6+4jL2riNSf+pDjZQTPwJvxEiHg8TqPxlZIY/KR8UiTK2ReHV0vw8nubdMs/gI2jn3odYaCVQYy8SY3NXlf+d15Yc9IYhwCG3T3YH4KzSd5hTwgQXl3sU8/ZjhPetRzIyhIDBfJkmg2Zc7Unol9fzl8rhqpUN+XP0wEO65mhUchQTdWAlKG3ASWA1zKOeizdNeOv5fHroicfhmNz7F3u75AuhawrR42SGuMxGUAx3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(38070700005)(8936002)(52536014)(86362001)(54906003)(6916009)(316002)(33656002)(76116006)(478600001)(66946007)(66476007)(4326008)(8676002)(66446008)(66556008)(64756008)(83380400001)(6506007)(7696005)(9686003)(26005)(5660300002)(2906002)(186003)(122000001)(41300700001)(38100700002)(55016003)(30864003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?j6PB4F+2AdCH/gpykVEFlw3kiojzWlCI0HEM1kyxYhul9A0h9VngG1HI6A?=
 =?iso-8859-1?Q?HwVLVY5Ra64O33MOkg1IRhi3uLdiokruobD0qCgyVa1+jyUSHoYsslp6Sr?=
 =?iso-8859-1?Q?3yGrTgTsKMV3TjvfYDd2YitMNDiX7bVjIgrtwY9uWatoCzJ32GNfAHIo3u?=
 =?iso-8859-1?Q?zY96RRhsobrAVj/76pT0EhYsK4g/3TNeUS+tY/ZYZ1LRcMHh8rYQh+NeSF?=
 =?iso-8859-1?Q?vcppOodclbP0NHnOgxz0cNHqEsMvYM649nrSW7pPCxe2slZ9clAU3/ivFE?=
 =?iso-8859-1?Q?KZzacaUGuW+TxYLMoJim8VQ0ixk8Sr+0gf6O2qdVM7mdb87DXDq7Jheywq?=
 =?iso-8859-1?Q?wRKBB1gyXwNg7W4/2mBRzogmQreU9XQYFivhLt1Vy9DhPV0Vm9mDtpxaJV?=
 =?iso-8859-1?Q?0TAOd4DzxZGgjDA6Q6NNXz1uAnlcCXZ2lm0NRigRXrdjkeU1M8hBg8qN5M?=
 =?iso-8859-1?Q?TvFlAkGX320aAT4dqgkJv7XAi8iNxkn9/aMlx9GfzC/MOD51RJniTn/b9J?=
 =?iso-8859-1?Q?3HghWO2w2qaSae5Rcg8JgOQ9DMzX7OIhegrFjy7GbvLfIy4jBP2fGeD+wV?=
 =?iso-8859-1?Q?oU+GcILTOuU1Y4/fVt72MfoUk1S5zxyUuddDMJv41LIczeKPYf7c/X4KGl?=
 =?iso-8859-1?Q?61hMhlzWIvWJm0EEMVqq/MtFBJzSD463gc8S1icBvwvX2CrWHwQSPUjzzG?=
 =?iso-8859-1?Q?+9R0rR2e/qrOjUiQOgGPiM/g4tZL8tY96izJTv0ZjmkconSw1B6uQfPIfa?=
 =?iso-8859-1?Q?oWvF7mUwLW49+LP0WOlHaUzxV0SYs4H585z7BkAp6zAMB8LZp9KSaQ025Q?=
 =?iso-8859-1?Q?YVyTvErRSvF2ZiPJ8GSgevI03T/dZNRn/cg2T0OHvhgtIIUrco2NQ0Q584?=
 =?iso-8859-1?Q?u662hs7eJ+batO6i9r8hsEctima/14Ocv8c7Usy8V9Ewivtz2Baq9Q7pRr?=
 =?iso-8859-1?Q?jqW5hVwzgHOHmfmWRJTZrjbP3jLI690VFeCixWZB7l62qnVDH0HZx8BO5T?=
 =?iso-8859-1?Q?gKOkXaJmz8eEKaS4GL81J8noy+wEXVEsg+SFf2U0tDfTiETtTTaq+g7PRT?=
 =?iso-8859-1?Q?yMeYESDs+ki4dGDL2aB9215VDfjHTrinIZS4LMLnA+HWVqS28f24wBoTlM?=
 =?iso-8859-1?Q?PP0+fCytFdo6OgCmiuU7Yebt43zFwryLEaW4fS0djBbD57waS9TAdzTRRT?=
 =?iso-8859-1?Q?7f30gXdgZOhRw0DsivV7TlS6xD5I111qzzfPuZA8mySOFjProfsTNgZj2D?=
 =?iso-8859-1?Q?4b4uos9D0ckBUvgYhM39nJ9PvdEdhVCeGx5Z5TLYhHcLfLEeK0l/6w1Du9?=
 =?iso-8859-1?Q?ojoWsRdgpeOCG49KP8EMOwOehFr4xef3RF37Q9wBtq2KLn8tdHNBQn6mc7?=
 =?iso-8859-1?Q?k5gmwZePMbp70RGRyYPkjEVlps42IFfA85BnCRbxV09feS8T6TmIckR3Dz?=
 =?iso-8859-1?Q?9OV3A0dj/RV+oT9OURtO8kGqzhDm0XgHde3D/87n3dpTVBFWpqf4oZGf0h?=
 =?iso-8859-1?Q?sFVy1NuG6O1adaV+b/+Rvu2ZuNWmqZbf7Gh1wquzFq8EPEZRwwMeD/F9oN?=
 =?iso-8859-1?Q?bo90WiiSboFc1FD+aT+q6on6SP+D3uBXel2H2HFbWo8b48pk2vCIMrdfJe?=
 =?iso-8859-1?Q?4H9ZFRli6XLxiu1MqRu3KHUSNDjJwJw/i2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ccac4c-6d0f-49ce-22f5-08da8f61d165
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 17:12:31.3544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mK000VQiiWBH8DNtSu3hlwA1yhNlV/Xpm1WM+pummXQky+n2AmmlGKC1ue141u5LYOTIGioJpGL/tz+jbn8U0BvcSCx3wMzMjLAIypEbXsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8589
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

> Subject: RE: [PATCH v5 2/2] pwm: Add support for RZ/G2L GPT
>=20
> Hi Uwe,
>=20
> Thanks for the feedback.
>=20
> > Subject: Re: [PATCH v5 2/2] pwm: Add support for RZ/G2L GPT
> >
> > Hello,
> >
> > On Fri, Aug 05, 2022 at 03:57:04PM +0100, Biju Das wrote:
> > > +#define RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH \
> > > +	(RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE | RZG2L_GTIOR_OAE) #define
> > > +RZG2L_GTIOR_GTIOA_OUT_LO_END_TOGGLE_CMP_MATCH \
> > > +	(RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE | RZG2L_GTIOR_OAE) #define
> > > +RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH \
> > > +	((RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE << 16) | RZG2L_GTIOR_OBE)
> >
> > FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE)
>=20
> We cannot use this macro for structure initialization, I get below
> compilation errors for variable .value in struct rzg2l_gpt_phase.
> Not sure, Maybe we should use if statement with the "FIELD_PREP" macro
> and drop the variable "value" from struct rzg2l_gpt_phase??
>=20
> In file included from drivers/pwm/pwm-rzg2l-gpt.c:17:
> ./include/linux/bitfield.h:113:2: error: braced-group within expression
> allowed only inside a function
>   113 |  ({        \
>       |  ^
> drivers/pwm/pwm-rzg2l-gpt.c:60:2: note: in expansion of macro
> 'FIELD_PREP'
>    60 |  FIELD_PREP(RZG2L_GTIOR_GTIOB,
> RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE)
>       |  ^~~~~~~~~~
> drivers/pwm/pwm-rzg2l-gpt.c:81:12: note: in expansion of macro
> 'RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH'
>    81 |   .value =3D RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH,
>       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> >
> > > +#define RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH \
> > > +	((RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE << 16) | RZG2L_GTIOR_OBE)
> > > +
> > > [...]
> > > +static u8 rzg2l_calculate_prescale(struct rzg2l_gpt_chip *rzg2l_gpt,
> > > +				   u64 period_cycles)
> > > +{
> > > +	u32 prescaled_period_cycles;
> > > +	u8 prescale;
> > > +
> > > +	prescaled_period_cycles =3D period_cycles >> 32;
> > > +
> > > +	if (prescaled_period_cycles >=3D 256)
> > > +		prescale =3D 5;
> > > +	else
> > > +		prescale =3D (roundup_pow_of_two(prescaled_period_cycles + 1)
> > + 1) /
> > > +2;
> >
> > I double checked, this looks correct to me.
> >
> > > +
> > > +	return prescale;
> > > +}
> > > +
> > > [...]
> > > +static int rzg2l_gpt_config(struct pwm_chip *chip, struct
> > > +pwm_device
> > *pwm,
> > > +			    const struct pwm_state *state) {
> > > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > > +	struct rzg2l_gpt_pwm_device *gpt =3D &rzg2l_gpt->gpt[pwm->hwpwm];
> > > +	unsigned long pv, dc;
> > > +	u64 period_cycles;
> > > +	u64 duty_cycles;
> > > +	u8 prescale;
> > > +
> > > +	/*
> > > +	 * Refuse clk rates > 1 GHz to prevent overflowing the following
> > > +	 * calculation.
> > > +	 */
> > > +	if (rzg2l_gpt->rate > NSEC_PER_SEC)
> > > +		return -EINVAL;
> > > +
> > > +	/*
> > > +	 * GPT counter is shared by multiple channels, so prescale and
> > period
> > > +	 * can NOT be modified when there are multiple channels in use
> > with
> > > +	 * different settings.
> > > +	 */
> > > +	if (state->period !=3D rzg2l_gpt->real_period && rzg2l_gpt-
> > >user_count > 1)
> > > +		return -EBUSY;
> >
> > Optional improvement here: If a period of (say) 100000 ns is requested
> > the hardware might likely actually implement 99875 ns. As rzg2l_gpt-
> > >real_period corresponds to the requested period (is that a
> > misnomer?)
>=20
> Yes, it is misnomer here. Actually, it is rzg2l_gpt->state_period, Where
> we cache the first period value for both the channels with usage count
> incremented.
> Here 100000 ns means, we are caching 100000 ns.
>=20
> >you could accept state->period =3D 99900.
> >
> > Accepting state->period >=3D rzg2l_gpt->real_period is fine.
> >
> > > +
> > > +	period_cycles =3D mul_u64_u32_div(state->period, rzg2l_gpt->rate,
> > NSEC_PER_SEC);
> > > +	prescale =3D rzg2l_calculate_prescale(rzg2l_gpt, period_cycles);
> > > +
> > > +	pv =3D period_cycles >> (2 * prescale);
> >
> > If period_cycles is >=3D (1024 << 32), we get prescale =3D 5 and so
> > period_cycles >> (2 * prescale) doesn't fit into 32 bits. This needs
> > handling.
>=20
> OK, will do the below change.
>=20
> +       if (period_cycles >=3D (1024ULL << 32))
> +               period_cycles =3D 1024ULL << 32;
>=20
>=20
> >
> > > +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle, rzg2l_gpt->rate,
> > NSEC_PER_SEC);
> > > +	dc =3D duty_cycles >> (2 * prescale);
> > > +
> > > +	/* Counter must be stopped before modifying Mode and Prescaler */
> > > +	if (rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST)
> > > +		rzg2l_gpt_disable(rzg2l_gpt);
> >
> > Does this affect the other channel? If yes, that's a bad thing and it
> > might be worth to improve here.
>=20
> Yes, it affects the other channels, please share any suggestions for
> improvement??
>=20
> >
> > > +	/* GPT set operating mode (saw-wave up-counting) */
> > > +	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR,
> > > +			 RZG2L_GTCR_MD, RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
> > > +
> > > +	/* Set count direction */
> > > +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTUDDTYC, RZG2L_UP_COUNTING);
> > > +
> > > +	rzg2l_gpt->real_period =3D state->period;
> > > +	/* Select count clock */
> > > +	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR, RZG2L_GTCR_TPCS,
> > > +			 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
> > > +
> > > +	/* Set period */
> > > +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR, pv);
> > > +
> > > +	/* Set duty cycle */
> > > +	rzg2l_gpt_write(rzg2l_gpt, gpt->ph->duty_reg_offset, dc);
> > > +
> > > +	/* Set initial value for counter */
> > > +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCNT, 0);
> > > +
> > > +	/* Set no buffer operation */
> > > +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTBER, 0);
> > > +
> > > +	/* Enable pin output */
> > > +	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR, gpt->ph->mask,
> > > +gpt->ph->value);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void rzg2l_gpt_get_state(struct pwm_chip *chip, struct
> > pwm_device *pwm,
> > > +				struct pwm_state *state)
> > > +{
> > > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > > +	struct rzg2l_gpt_pwm_device *gpt =3D &rzg2l_gpt->gpt[pwm->hwpwm];
> > > +	u8 prescale;
> > > +	u64 tmp;
> > > +	u32 val;
> > > +
> > > +	/* get period */
> > > +	state->period =3D rzg2l_gpt->real_period;
> > > +
> > > +	pm_runtime_get_sync(chip->dev);
> > > +	val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR);
> > > +	state->enabled =3D val & RZG2L_GTCR_CST;
> > > +	if (state->enabled) {
> > > +		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);
> > > +
> > > +		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR);
> > > +		tmp =3D NSEC_PER_SEC * val << (2 * prescale);
> > > +		state->period =3D DIV_ROUND_UP_ULL(tmp, rzg2l_gpt->rate);
> > > +
> > > +		val =3D rzg2l_gpt_read(rzg2l_gpt, gpt->ph->duty_reg_offset);
> >
> > I still wonder if this is really better/more effective/easier to
> > understand than just:
> >
> > /* These are actually called GTCCRA and GTCCRB */ #define
> > RZG2L_GTCCR(i) (0x4c + 4 * (i))
> >
> > plus
> >
> > 	val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(pwm->hwpwm));
>=20
> Agreed.
>=20
> >
> >
> > > +		tmp =3D NSEC_PER_SEC * val << (2 * prescale);
> > > +		state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, rzg2l_gpt->rate);
> > > +		/*
> > > +		 * Ordering is important, when we set a period for the
> > second
> > > +		 * channel, as pwm_request_from_chip() calling get_state()
> > will
> > > +		 * have an invalid duty cycle value as the register is not
> > > +		 * initialized yet. So set duty_cycle to zero.
> >
> > I don't understand that issue. Can you just drop the check "rzg2l_gpt-
> > >user_count > 1"?
>=20
> No, I get a high duty cycle register value (Reset value) for the second
> channel as the Register is not initialized yet. I have enabled some debug
> for better understanding.
> Please let me know still it s clear.
>=20
> pr_info("## %s ch=3D%d enabled=3D%d, duty_cycle_reg=3D%x",__func__,pwm-
> >hwpwm,state->enabled,rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(pwm-
> >hwpwm)));
>=20
> Please see the test code[1] and corresponding log[2].
>=20
> The problematic condition is here.
> [   36.751009] ## rzg2l_gpt_get_state ch=3D1 enabled=3D1,
> duty_cycle_reg=3Dffffffff
>=20
> As you can see with pwm_debug enabled, the state->enable is 1, even
> though duty cycle register is not initialized.
>=20
> [1] Please see the test code with PWM_DEBUG enabled:
>=20
> echo 0 > /sys/class/pwm/pwmchip0/export
> echo 500000000 > /sys/class/pwm/pwmchip0/pwm0/period
> echo 250000000 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
> echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable
>=20
> echo 1 > /sys/class/pwm/pwmchip0/export
> echo 150000000 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
> echo 500000000 > /sys/class/pwm/pwmchip0/pwm1/period
> echo 1 > /sys/class/pwm/pwmchip0/pwm1/enable
>=20
> echo 0 > /sys/class/pwm/pwmchip0/pwm0/enable
> echo 0 > /sys/class/pwm/pwmchip0/pwm1/enable
>=20
> echo 1 > /sys/class/pwm/pwmchip0/unexport echo 0 >
> /sys/class/pwm/pwmchip0/unexport
>=20
>=20
> [2]logs:-
>=20
> root@smarc-rzg2l:~# /poeg_dual.sh
> [   36.688776] ## rzg2l_gpt_get_state ch=3D0 enabled=3D0,
> duty_cycle_reg=3Dffffffff
> [   36.698051] ## rzg2l_gpt_get_state ch=3D0 enabled=3D0,
> duty_cycle_reg=3Dffffffff
> [   36.705625] ## rzg2l_gpt_get_state ch=3D0 enabled=3D0,
> duty_cycle_reg=3Dffffffff
> [   36.718096] ## rzg2l_gpt_get_state ch=3D0 enabled=3D0,
> duty_cycle_reg=3Dffffffff
> [   36.725717] ## rzg2l_gpt_get_state ch=3D0 enabled=3D0,
> duty_cycle_reg=3Dffffffff
> [   36.735656] ## rzg2l_gpt_get_state ch=3D0 enabled=3D1,
> duty_cycle_reg=3D5f5e10
> [   36.743156] ## rzg2l_gpt_get_state ch=3D0 enabled=3D1,
> duty_cycle_reg=3D5f5e10
> [   36.751009] ## rzg2l_gpt_get_state ch=3D1 enabled=3D1,
> duty_cycle_reg=3Dffffffff
> [   36.760968] ## rzg2l_gpt_get_state ch=3D1 enabled=3D1,
> duty_cycle_reg=3D393870
> [   36.768136] ## rzg2l_gpt_get_state ch=3D1 enabled=3D1,
> duty_cycle_reg=3D393870
> [   39.834765] ## rzg2l_gpt_get_state ch=3D0 enabled=3D0,
> duty_cycle_reg=3D5f5e10
> [   39.841729] ## rzg2l_gpt_get_state ch=3D0 enabled=3D0,
> duty_cycle_reg=3D5f5e10
> [   42.886686] ## rzg2l_gpt_get_state ch=3D1 enabled=3D0,
> duty_cycle_reg=3D393870
>=20
> >
> > If you configure channel #0 while channel #1 is still untouched (in
> > software), does this modify the output of channel #1?
>=20
>=20
> >
> > > +		 */
> > > +		if (state->duty_cycle > state->period &&
> > > +		    rzg2l_gpt->user_count > 1)
> > > +			state->duty_cycle =3D 0;
> >
> > Does this setting (i.e. GTCCR{A,B} > GTPR) correspond to a 100%
> > relative duty cycle?
>=20
> No. I am setting to a value of 0, Since register is not initialized as
> mentioned above.
>=20
> >
> > > +	}
> > > +
> > > +	state->polarity =3D PWM_POLARITY_NORMAL;
> > > +	pm_runtime_put(chip->dev);
> > > +}
> > > +
> > > +static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device
> > *pwm,
> > > +			   const struct pwm_state *state) {
> > > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > > +	int ret;
> > > +
> > > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > > +		return -EINVAL;
> > > +
> > > +	pm_runtime_get_sync(chip->dev);
> > > +	if (!state->enabled) {
> > > +		rzg2l_gpt_disable(rzg2l_gpt);
> > > +		ret =3D 0;
> > > +		goto done;
> > > +	}
> > > +
> > > +	mutex_lock(&rzg2l_gpt->lock);
> > > +	ret =3D rzg2l_gpt_config(chip, pwm, state);
> > > +	mutex_unlock(&rzg2l_gpt->lock);
> > > +	if (ret)
> > > +		goto done;
> > > +
> > > +	return rzg2l_gpt_enable(rzg2l_gpt);
> > > +
> > > +done:
> > > +	pm_runtime_put(chip->dev);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static const struct pwm_ops rzg2l_gpt_ops =3D {
> > > +	.request =3D rzg2l_gpt_request,
> > > +	.free =3D rzg2l_gpt_free,
> > > +	.get_state =3D rzg2l_gpt_get_state,
> > > +	.apply =3D rzg2l_gpt_apply,
> > > +	.owner =3D THIS_MODULE,
> > > +};
> > > +
> > > +static const struct of_device_id rzg2l_gpt_of_table[] =3D {
> > > +	{ .compatible =3D "renesas,rzg2l-gpt", },
> > > +	{ /* Sentinel */ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
> > > +
> > > +static void rzg2l_gpt_reset_assert_pm_disable(void *data) {
> > > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D data;
> > > +
> > > +	pm_runtime_disable(rzg2l_gpt->chip.dev);
> > > +	reset_control_assert(rzg2l_gpt->rstc);
> > > +}
> > > +
> > > +static int rzg2l_gpt_probe(struct platform_device *pdev) {
> > > +	struct rzg2l_gpt_chip *rzg2l_gpt;
> > > +	struct clk *clk;
> > > +	int ret, i;
> > > +
> > > +	rzg2l_gpt =3D devm_kzalloc(&pdev->dev, sizeof(*rzg2l_gpt),
> > GFP_KERNEL);
> > > +	if (!rzg2l_gpt)
> > > +		return -ENOMEM;
> > > +
> > > +	rzg2l_gpt->mmio =3D devm_platform_ioremap_resource(pdev, 0);
> > > +	if (IS_ERR(rzg2l_gpt->mmio))
> > > +		return PTR_ERR(rzg2l_gpt->mmio);
> > > +
> > > +	rzg2l_gpt->rstc =3D devm_reset_control_get_shared(&pdev->dev, NULL)=
;
> > > +	if (IS_ERR(rzg2l_gpt->rstc))
> > > +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->rstc),
> > > +				     "get reset failed\n");
> > > +
> > > +	ret =3D reset_control_deassert(rzg2l_gpt->rstc);
> > > +	if (ret)
> > > +		return dev_err_probe(&pdev->dev, ret,
> > > +				     "cannot deassert reset control\n");
> > > +
> > > +	pm_runtime_enable(&pdev->dev);
> > > +	ret =3D devm_add_action_or_reset(&pdev->dev,
> > > +				       rzg2l_gpt_reset_assert_pm_disable,
> > > +				       rzg2l_gpt);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> > > +	if (IS_ERR(clk))
> > > +		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
> > > +				     "cannot get clock\n");
> > > +
> > > +	rzg2l_gpt->rate =3D clk_get_rate(clk);
> > > +	/*
> > > +	 *  We need to keep the clock on, in case the bootloader enabled
> > PWM and
> > > +	 *  is running during probe().
> > > +	 */
> > > +	if (!(rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST))
> > > +		devm_clk_put(&pdev->dev, clk);
> >
> > I still think this looks wrong. Please at least comment about the idea
> > here. ie. devm_clk_put disables the clk and holding a reference on the
> > clk isn't needed because runtime-pm handles the needed enabling.
>=20
> OK, will add the comment. Yes, the code should be improved
>=20
> 1) This code is OK for the case bootloader is not turning on PWM.
>=20
> 2) But if Bootloader turns on the PWM, then we need extra handling to
> call
>   "devm_clk_put" when usage count becomes "0" after activation of PWM
> channels.
>=20
>   ie, use a private variable for tracking bootloader on case and call
> "devm_clk_put"
>   during "rzg2l_gpt_free" and reset the private variable.
>=20
>  After that there is no clock framework resources and PM handles the
> clocks  exclusively.
>=20
> >
> > Is this really true? Does runtime-pm disable the clk if after the clk
> > wasn't put here both PWMs are disabled?
>=20
> No it need special handling, See point 2 above.
>=20

I have created v6 incorporating the comments above
and also updated handling of bootloader enabling/disabling pwm.

Please provide feedback, if any.

Cheers,
Biju

>=20
> >
> > > +	mutex_init(&rzg2l_gpt->lock);
> > > +
> > > +	rzg2l_gpt->chip.dev =3D &pdev->dev;
> > > +	rzg2l_gpt->chip.ops =3D &rzg2l_gpt_ops;
> > > +	rzg2l_gpt->chip.npwm =3D 2;
> > > +	for (i =3D 0; i < rzg2l_gpt->chip.npwm; i++)
> > > +		rzg2l_gpt->gpt[i].ph =3D &rzg2l_gpt_phase_params[i];
> > > +
> > > +	ret =3D devm_pwmchip_add(&pdev->dev, &rzg2l_gpt->chip);
> > > +	if (ret)
> > > +		dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static struct platform_driver rzg2l_gpt_driver =3D {
> > > +	.driver =3D {
> > > +		.name =3D "pwm-rzg2l-gpt",
> > > +		.of_match_table =3D of_match_ptr(rzg2l_gpt_of_table),
> > > +	},
> > > +	.probe =3D rzg2l_gpt_probe,
> > > +};
> > > +module_platform_driver(rzg2l_gpt_driver);
> > > +
> > > +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> > > +MODULE_DESCRIPTION("Renesas RZ/G2L General PWM Timer (GPT)
> > > +Driver"); MODULE_LICENSE("GPL");
> > > +MODULE_ALIAS("platform:pwm-rzg2l-gpt");
> > |
