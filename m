Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E07459EABD
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Aug 2022 20:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiHWSOj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 23 Aug 2022 14:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiHWSOZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 23 Aug 2022 14:14:25 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2129.outbound.protection.outlook.com [40.107.114.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99942A1D0E;
        Tue, 23 Aug 2022 09:28:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWp2Fh2wamfrSXm9obl+EZIUGPqi71W0QSlcX/p0s7K9JYmzU9vvNz5T06U0FUDj2AJ2gXUfJLB2LBuLataA+fFbB20Hbe6s7rNyAiyZ2JIK2J8HA6XL6o6fvK9wMN6ndogpHA1H0f0aLsGAbhTu9WvCJgLRNah8cU3iVtTbQ3LnXUxo4krAsr2buSBONPARczVTZy38WvzmvzZsx6fwShb6vFQstGADVZWfzSQB8mQW33qRsQGq5edhTqMZ86LK3D4uOb4HqSOHEbPvLGoWUXRrkL+5zFF5ip5MGL1fJFeSad2+oaO8E1e+tQEQEwKQ3sFc6tctqlZH8905TxzVmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHFoL87Zf1WDwXkCawBsc6Be/+xyqxd4ZjKVxbZP2l8=;
 b=jcPildhZHAPusBsNrHb/PfdqGSbkO9k7z6sh2QHRUB3PP3i1jMST34ZXU8FKPRMbQtRC9ciB/btpo3d220YZkGu6fYde8UHLMGGrqjIzx7bU3FSkOyhv5xF4gFfYrmrFHp3pcGIu7YUMLK/yPiGx5LNaMgkpSyi3vVE1zQqcXHI87VZ1q0yuhTYJJmQteZtNsuZRDR/goPL/Fjj2HxrG9uJipxR091CYfahed1xPMiAcrNg6DPKfmucVJWk8BjTUEr++kHRtoTnIPhNCQzbTApKf3hlWtzjYO0WcRxOmLMgHO7BmRQoJOtbOVlRm8F7agTGNgUAwluMDfFFJrASCkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHFoL87Zf1WDwXkCawBsc6Be/+xyqxd4ZjKVxbZP2l8=;
 b=Jnvgxf6K4xNU7Ql3T/I329rna5OTpVqyq2RyMTY9BUXUS9FMWFtbq/sjUIFPr7Xx0vHWhKeAsRI+He2wz8dhlzsOdVe+snklCCir4UZt8CYYu2gVULAWrfX0yk5Cbbiahodn+BDkC1++KPlD7+4Y4mIJ945uHPm82i8HRjLaCuQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB8576.jpnprd01.prod.outlook.com (2603:1096:400:13e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 23 Aug
 2022 16:28:08 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::14d3:5079:9de1:ceaf]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::14d3:5079:9de1:ceaf%3]) with mapi id 15.20.5546.024; Tue, 23 Aug 2022
 16:28:07 +0000
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
Thread-Index: AQHYqNuq5rqiJTgOfk+nXQY7+fFusK2gzJUAgBvf0GA=
Date:   Tue, 23 Aug 2022 16:28:07 +0000
Message-ID: <OS0PR01MB59224594846E30D2D8D76F2E86709@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220805145704.951293-1-biju.das.jz@bp.renesas.com>
 <20220805145704.951293-3-biju.das.jz@bp.renesas.com>
 <20220805210554.czafwmpq46prlfx7@pengutronix.de>
In-Reply-To: <20220805210554.czafwmpq46prlfx7@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b1b65f9-c10f-4435-7633-08da85247621
x-ms-traffictypediagnostic: TYWPR01MB8576:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ps51nTIPNCJCLYfOLivwVdTd5zXZbJq9ohTCfAmMMQYLCa2zfn/hhPNiJQUjgRdxfcZyiTN7bBV+WWIBXWLTPGzyIg4S0Q6gbbZb47V8mYlTlkBchk2dtgganCE3Z4MMSHeMRTZlTN13jOIVFFyp0IWxDM2OSfhiqCGx24NbDOMYc4TZIBPJci4fwCH06Cx/VOBFf/h8Xbn2bKEylDi57W/GsLFRqPhnPeVG5BmwMx9ok2udCBUmWkJ8cIl1fCrgtGTBnklGfuddqxQikhWJmBDbIL5+0BaQOIlIb7PuQ3bI0C3QElo9Tyo5fJuy9OdREK5hQ9jV50YowKWnb1YZPc36/B20pq+1lP6HycG5jC7qK22Ox8o4ikAo+Jy9H6bg+qo6Gxej/ldKmMwLf5uJCnfssJLMG5huhNU6IszJkBCa1t6BNLhCnl6Y+qFKBsJFIbipIObdtJJgNm1YrCbYIJBRPrVCCkvhTs+N3zDM9cPC5MUeYl3ZagVTwtl2jUUpZV5jN/wepdraSDarpN+cz9Yhisc5SxFDgISe9XDMX8B5Tvu8in4LJUJG9NWwS5kdEfygTzBPtpizdngKaNTofodQa0DalOWzi10Oe75g2w1ShFz8CYm+BKUCZ8tyqNbuivDnUw1pJvI82kkMmPKxez6sGoJV/f5/3HBec8evPe0KXmAFee2cKmhIP7sBuSZCVDFSJWti+Vj0X07KE3qXJ24kJl9uSBia6TkhL9biOdd/O+TfzQO4tLsQwo22dTf1NkWcp/flHwCbiHTsiqoQHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(6506007)(7696005)(41300700001)(2906002)(30864003)(55016003)(33656002)(478600001)(86362001)(9686003)(26005)(54906003)(71200400001)(6916009)(316002)(122000001)(38100700002)(186003)(38070700005)(52536014)(5660300002)(8936002)(66476007)(4326008)(8676002)(64756008)(66446008)(66556008)(66946007)(76116006)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5YajZtI1CXuckdX8xJN/LXpV39kzWtweNTw3m/Zn/OKqFr8VnjH74R1loJ?=
 =?iso-8859-1?Q?tAsGQZGQSNwcXNEEA1gdvJo16pS3eDPU9EDML8RFYGOTeU5M1RZ5zJ7HE/?=
 =?iso-8859-1?Q?XTd2pmPUfc5l/IyqX0p+pex1XhHyliNTdChQvYEXExakyEwGCzZFGyAVSd?=
 =?iso-8859-1?Q?7Uf8osq4r1WpgQKqbe+6/dz1P4Jw+SEGd8dYqNULw4MeHTGoQ/nDlV3HdG?=
 =?iso-8859-1?Q?3f3Fi4kMbPP9gTbwpB/RO9bcL3OFW+Jsl85MsHlPOQDTpWctDex92bxYww?=
 =?iso-8859-1?Q?FhgTgymuJE+dNsJ1j/31921/q+2TJqtHv0d11WMz0zCdjqUiAmal6/jV7H?=
 =?iso-8859-1?Q?3XhPo6E4E/n8Jr2RNLps9bzZKiJ3z6dsKA1SnjhFVCNR/WS4bSdwVlrDpD?=
 =?iso-8859-1?Q?X167awFMeqsiatp3V6/xLDyKlNV3bnGpmF4YC/zXXLp7eBJ0DOtjvM3spB?=
 =?iso-8859-1?Q?22Saye8A/K0R6Am3PGshwgKrC62M6VjhTjohXTnKhz3WpklwozvvY2Xhy9?=
 =?iso-8859-1?Q?HahAK77pyZDAA+fqS3MzMPV5A8MkKsJIhD1jqhs89KVe4ltBjYdgcuoRNQ?=
 =?iso-8859-1?Q?p0nm3+E3lLqGoGGHclnsHZrvfVffv64Fy2kCBQ+ZdGJ3/GBVv0wlc7eDnn?=
 =?iso-8859-1?Q?EOMV+ggJP0nCu7xVJ4LDfd/L/k7iW0M4ipqbWocw9z94MfJqnnFsjfFAUf?=
 =?iso-8859-1?Q?H8ASkMG74Jp0/QC7hcCpQiuA+HMaRgxA9Sw8/VIJP7b/4Pu0UiEz1tC9Q4?=
 =?iso-8859-1?Q?u+d18n7ntsyHcZra9oDDgIEPVLaJdzv5kfLb7cixEH4AkNade8WEhWs12V?=
 =?iso-8859-1?Q?u8slExAdbaKxFaM8nYI70e/VHCcVTeN5KExsbd/aZlnjxyEn1O+GL2Bunx?=
 =?iso-8859-1?Q?k+/4vEdhBulyC/IMRhe2us8pXDWW6FcomyArdT9as5syOsCkWdw1laG8Lb?=
 =?iso-8859-1?Q?ibeEwpSstdJjOgj5g2psuvKjLvBw6SSDBeTHJVIvQBwltbkB3kfsyXyvzq?=
 =?iso-8859-1?Q?aOJh7qf5rEXL6SOKmMbVL+N9aqsqA+HsDMrRffggW8U08gHl6jjw7mTeFd?=
 =?iso-8859-1?Q?S885gvdY0pUk7EYXomr72GBKkxqaRM55RmDP2rnsgavnDgAUAW4uMRRfzL?=
 =?iso-8859-1?Q?ybv+Vsl49wrWeBJ7jDYCOQCuASwuzJlEf/iPWhYr/BhIA1bUGcdv/dikgM?=
 =?iso-8859-1?Q?EZuYlyVJHIQ+HcJNp7Gljhx9NuJ6M8N0CoSD8H0Yk1fCg8fBRwaWE+gtxC?=
 =?iso-8859-1?Q?9PthBX3aRsYzr2nU3+FWFfbKnUiIioIFP9zbMPoPm5/WrjKHVTklVXhJDo?=
 =?iso-8859-1?Q?vFoWV2yAbCIIipSHWZwRFL4jQywlbvWkifcvs6RKQSGzva9wPoB8UnbJ9P?=
 =?iso-8859-1?Q?GvJoguxcVoXIVxezun1TKqU5CdCnk61Bx3mUyoNJu8HxV4KNNmVcU84HgC?=
 =?iso-8859-1?Q?vd8mJA7Fi4vUr/ioZVQJ3mqqtXq59vgpKU0TJLH0lu8eIiYGXxnBZxybwY?=
 =?iso-8859-1?Q?rHbjIdJr0K7rVbUjBIf6Nq1nLk2mHZY+Y+MaPx/ixKPY05E3d4Odbb7Flo?=
 =?iso-8859-1?Q?UCleg6uCYxPiHTT8oXuoUzO10vJsMoNod9peg21WBjr/cm39ejbL0/8l/G?=
 =?iso-8859-1?Q?kbxxOLgMV055kc2ia19plSvgoOT53Uv6CcKKsTF2s6vDmgFZ9Q9QFayg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1b65f9-c10f-4435-7633-08da85247621
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 16:28:07.3255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PDvu/hf97AvhsylZuEoBxryGZqsm2ofvTqu2nO42sV1pAMCPJVVMKbKVtFL4vJ0SqHlEsh+UWVMuvuYd/qO/mbsnnYzSD6rrrswYsUC8Qeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8576
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

> Subject: Re: [PATCH v5 2/2] pwm: Add support for RZ/G2L GPT
>=20
> Hello,
>=20
> On Fri, Aug 05, 2022 at 03:57:04PM +0100, Biju Das wrote:
> > +#define RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH \
> > +	(RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE | RZG2L_GTIOR_OAE) #define
> > +RZG2L_GTIOR_GTIOA_OUT_LO_END_TOGGLE_CMP_MATCH \
> > +	(RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE | RZG2L_GTIOR_OAE) #define
> > +RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH \
> > +	((RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE << 16) | RZG2L_GTIOR_OBE)
>=20
> FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE)

We cannot use this macro for structure initialization,
I get below compilation errors for variable .value in struct rzg2l_gpt_phas=
e.=20
Not sure, Maybe we should use if statement with the "FIELD_PREP" macro and=
=20
drop the variable "value" from struct rzg2l_gpt_phase??

In file included from drivers/pwm/pwm-rzg2l-gpt.c:17:
./include/linux/bitfield.h:113:2: error: braced-group within expression all=
owed only inside a function
  113 |  ({        \
      |  ^
drivers/pwm/pwm-rzg2l-gpt.c:60:2: note: in expansion of macro 'FIELD_PREP'
   60 |  FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE)
      |  ^~~~~~~~~~
drivers/pwm/pwm-rzg2l-gpt.c:81:12: note: in expansion of macro 'RZG2L_GTIOR=
_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH'
   81 |   .value =3D RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH,
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

>=20
> > +#define RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH \
> > +	((RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE << 16) | RZG2L_GTIOR_OBE)
> > +
> > [...]
> > +static u8 rzg2l_calculate_prescale(struct rzg2l_gpt_chip *rzg2l_gpt,
> > +				   u64 period_cycles)
> > +{
> > +	u32 prescaled_period_cycles;
> > +	u8 prescale;
> > +
> > +	prescaled_period_cycles =3D period_cycles >> 32;
> > +
> > +	if (prescaled_period_cycles >=3D 256)
> > +		prescale =3D 5;
> > +	else
> > +		prescale =3D (roundup_pow_of_two(prescaled_period_cycles + 1)
> + 1) /
> > +2;
>=20
> I double checked, this looks correct to me.
>=20
> > +
> > +	return prescale;
> > +}
> > +
> > [...]
> > +static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > +			    const struct pwm_state *state) {
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +	struct rzg2l_gpt_pwm_device *gpt =3D &rzg2l_gpt->gpt[pwm->hwpwm];
> > +	unsigned long pv, dc;
> > +	u64 period_cycles;
> > +	u64 duty_cycles;
> > +	u8 prescale;
> > +
> > +	/*
> > +	 * Refuse clk rates > 1 GHz to prevent overflowing the following
> > +	 * calculation.
> > +	 */
> > +	if (rzg2l_gpt->rate > NSEC_PER_SEC)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * GPT counter is shared by multiple channels, so prescale and
> period
> > +	 * can NOT be modified when there are multiple channels in use
> with
> > +	 * different settings.
> > +	 */
> > +	if (state->period !=3D rzg2l_gpt->real_period && rzg2l_gpt-
> >user_count > 1)
> > +		return -EBUSY;
>=20
> Optional improvement here: If a period of (say) 100000 ns is requested
> the hardware might likely actually implement 99875 ns. As rzg2l_gpt-
> >real_period corresponds to the requested period (is that a
> misnomer?)

Yes, it is misnomer here. Actually, it is rzg2l_gpt->state_period,
Where we cache the first period value for both the channels with usage coun=
t
incremented.
Here 100000 ns means, we are caching 100000 ns.

>you could accept state->period =3D 99900.
>=20
> Accepting state->period >=3D rzg2l_gpt->real_period is fine.
>=20
> > +
> > +	period_cycles =3D mul_u64_u32_div(state->period, rzg2l_gpt->rate,
> NSEC_PER_SEC);
> > +	prescale =3D rzg2l_calculate_prescale(rzg2l_gpt, period_cycles);
> > +
> > +	pv =3D period_cycles >> (2 * prescale);
>=20
> If period_cycles is >=3D (1024 << 32), we get prescale =3D 5 and so
> period_cycles >> (2 * prescale) doesn't fit into 32 bits. This needs
> handling.

OK, will do the below change.

+       if (period_cycles >=3D (1024ULL << 32))
+               period_cycles =3D 1024ULL << 32;


>=20
> > +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle, rzg2l_gpt->rate,
> NSEC_PER_SEC);
> > +	dc =3D duty_cycles >> (2 * prescale);
> > +
> > +	/* Counter must be stopped before modifying Mode and Prescaler */
> > +	if (rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST)
> > +		rzg2l_gpt_disable(rzg2l_gpt);
>=20
> Does this affect the other channel? If yes, that's a bad thing and it
> might be worth to improve here.

Yes, it affects the other channels, please share any suggestions
for improvement??

>=20
> > +	/* GPT set operating mode (saw-wave up-counting) */
> > +	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR,
> > +			 RZG2L_GTCR_MD, RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
> > +
> > +	/* Set count direction */
> > +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTUDDTYC, RZG2L_UP_COUNTING);
> > +
> > +	rzg2l_gpt->real_period =3D state->period;
> > +	/* Select count clock */
> > +	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR, RZG2L_GTCR_TPCS,
> > +			 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
> > +
> > +	/* Set period */
> > +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR, pv);
> > +
> > +	/* Set duty cycle */
> > +	rzg2l_gpt_write(rzg2l_gpt, gpt->ph->duty_reg_offset, dc);
> > +
> > +	/* Set initial value for counter */
> > +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCNT, 0);
> > +
> > +	/* Set no buffer operation */
> > +	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTBER, 0);
> > +
> > +	/* Enable pin output */
> > +	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR, gpt->ph->mask,
> > +gpt->ph->value);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rzg2l_gpt_get_state(struct pwm_chip *chip, struct
> pwm_device *pwm,
> > +				struct pwm_state *state)
> > +{
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +	struct rzg2l_gpt_pwm_device *gpt =3D &rzg2l_gpt->gpt[pwm->hwpwm];
> > +	u8 prescale;
> > +	u64 tmp;
> > +	u32 val;
> > +
> > +	/* get period */
> > +	state->period =3D rzg2l_gpt->real_period;
> > +
> > +	pm_runtime_get_sync(chip->dev);
> > +	val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR);
> > +	state->enabled =3D val & RZG2L_GTCR_CST;
> > +	if (state->enabled) {
> > +		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);
> > +
> > +		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR);
> > +		tmp =3D NSEC_PER_SEC * val << (2 * prescale);
> > +		state->period =3D DIV_ROUND_UP_ULL(tmp, rzg2l_gpt->rate);
> > +
> > +		val =3D rzg2l_gpt_read(rzg2l_gpt, gpt->ph->duty_reg_offset);
>=20
> I still wonder if this is really better/more effective/easier to
> understand than just:
>=20
> /* These are actually called GTCCRA and GTCCRB */ #define RZG2L_GTCCR(i)
> (0x4c + 4 * (i))
>=20
> plus
>=20
> 	val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(pwm->hwpwm));

Agreed.

>=20
>=20
> > +		tmp =3D NSEC_PER_SEC * val << (2 * prescale);
> > +		state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, rzg2l_gpt->rate);
> > +		/*
> > +		 * Ordering is important, when we set a period for the
> second
> > +		 * channel, as pwm_request_from_chip() calling get_state()
> will
> > +		 * have an invalid duty cycle value as the register is not
> > +		 * initialized yet. So set duty_cycle to zero.
>=20
> I don't understand that issue. Can you just drop the check "rzg2l_gpt-
> >user_count > 1"?

No, I get a high duty cycle register value (Reset value) for the second cha=
nnel
as the Register is not initialized yet. I have enabled some debug for bette=
r understanding.
Please let me know still it s clear.

pr_info("## %s ch=3D%d enabled=3D%d, duty_cycle_reg=3D%x",__func__,pwm->hwp=
wm,state->enabled,rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(pwm->hwpwm)));

Please see the test code[1] and corresponding log[2].

The problematic condition is here.
[   36.751009] ## rzg2l_gpt_get_state ch=3D1 enabled=3D1, duty_cycle_reg=3D=
ffffffff

As you can see with pwm_debug enabled, the state->enable is 1, even though
duty cycle register is not initialized.

[1] Please see the test code with PWM_DEBUG enabled:

echo 0 > /sys/class/pwm/pwmchip0/export
echo 500000000 > /sys/class/pwm/pwmchip0/pwm0/period
echo 250000000 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle                  =
=20
echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable                               =
                                                                           =
=20

echo 1 > /sys/class/pwm/pwmchip0/export
echo 150000000 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle =20
echo 500000000 > /sys/class/pwm/pwmchip0/pwm1/period     =20
echo 1 > /sys/class/pwm/pwmchip0/pwm1/enable

echo 0 > /sys/class/pwm/pwmchip0/pwm0/enable
echo 0 > /sys/class/pwm/pwmchip0/pwm1/enable =20

echo 1 > /sys/class/pwm/pwmchip0/unexport
echo 0 > /sys/class/pwm/pwmchip0/unexport


[2]logs:-

root@smarc-rzg2l:~# /poeg_dual.sh
[   36.688776] ## rzg2l_gpt_get_state ch=3D0 enabled=3D0, duty_cycle_reg=3D=
ffffffff
[   36.698051] ## rzg2l_gpt_get_state ch=3D0 enabled=3D0, duty_cycle_reg=3D=
ffffffff
[   36.705625] ## rzg2l_gpt_get_state ch=3D0 enabled=3D0, duty_cycle_reg=3D=
ffffffff
[   36.718096] ## rzg2l_gpt_get_state ch=3D0 enabled=3D0, duty_cycle_reg=3D=
ffffffff
[   36.725717] ## rzg2l_gpt_get_state ch=3D0 enabled=3D0, duty_cycle_reg=3D=
ffffffff
[   36.735656] ## rzg2l_gpt_get_state ch=3D0 enabled=3D1, duty_cycle_reg=3D=
5f5e10
[   36.743156] ## rzg2l_gpt_get_state ch=3D0 enabled=3D1, duty_cycle_reg=3D=
5f5e10
[   36.751009] ## rzg2l_gpt_get_state ch=3D1 enabled=3D1, duty_cycle_reg=3D=
ffffffff
[   36.760968] ## rzg2l_gpt_get_state ch=3D1 enabled=3D1, duty_cycle_reg=3D=
393870
[   36.768136] ## rzg2l_gpt_get_state ch=3D1 enabled=3D1, duty_cycle_reg=3D=
393870
[   39.834765] ## rzg2l_gpt_get_state ch=3D0 enabled=3D0, duty_cycle_reg=3D=
5f5e10
[   39.841729] ## rzg2l_gpt_get_state ch=3D0 enabled=3D0, duty_cycle_reg=3D=
5f5e10
[   42.886686] ## rzg2l_gpt_get_state ch=3D1 enabled=3D0, duty_cycle_reg=3D=
393870

>=20
> If you configure channel #0 while channel #1 is still untouched (in
> software), does this modify the output of channel #1?


>=20
> > +		 */
> > +		if (state->duty_cycle > state->period &&
> > +		    rzg2l_gpt->user_count > 1)
> > +			state->duty_cycle =3D 0;
>=20
> Does this setting (i.e. GTCCR{A,B} > GTPR) correspond to a 100% relative
> duty cycle?

No. I am setting to a value of 0, Since register is not initialized as ment=
ioned above.

>=20
> > +	}
> > +
> > +	state->polarity =3D PWM_POLARITY_NORMAL;
> > +	pm_runtime_put(chip->dev);
> > +}
> > +
> > +static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > +			   const struct pwm_state *state)
> > +{
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +	int ret;
> > +
> > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > +		return -EINVAL;
> > +
> > +	pm_runtime_get_sync(chip->dev);
> > +	if (!state->enabled) {
> > +		rzg2l_gpt_disable(rzg2l_gpt);
> > +		ret =3D 0;
> > +		goto done;
> > +	}
> > +
> > +	mutex_lock(&rzg2l_gpt->lock);
> > +	ret =3D rzg2l_gpt_config(chip, pwm, state);
> > +	mutex_unlock(&rzg2l_gpt->lock);
> > +	if (ret)
> > +		goto done;
> > +
> > +	return rzg2l_gpt_enable(rzg2l_gpt);
> > +
> > +done:
> > +	pm_runtime_put(chip->dev);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct pwm_ops rzg2l_gpt_ops =3D {
> > +	.request =3D rzg2l_gpt_request,
> > +	.free =3D rzg2l_gpt_free,
> > +	.get_state =3D rzg2l_gpt_get_state,
> > +	.apply =3D rzg2l_gpt_apply,
> > +	.owner =3D THIS_MODULE,
> > +};
> > +
> > +static const struct of_device_id rzg2l_gpt_of_table[] =3D {
> > +	{ .compatible =3D "renesas,rzg2l-gpt", },
> > +	{ /* Sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
> > +
> > +static void rzg2l_gpt_reset_assert_pm_disable(void *data) {
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D data;
> > +
> > +	pm_runtime_disable(rzg2l_gpt->chip.dev);
> > +	reset_control_assert(rzg2l_gpt->rstc);
> > +}
> > +
> > +static int rzg2l_gpt_probe(struct platform_device *pdev) {
> > +	struct rzg2l_gpt_chip *rzg2l_gpt;
> > +	struct clk *clk;
> > +	int ret, i;
> > +
> > +	rzg2l_gpt =3D devm_kzalloc(&pdev->dev, sizeof(*rzg2l_gpt),
> GFP_KERNEL);
> > +	if (!rzg2l_gpt)
> > +		return -ENOMEM;
> > +
> > +	rzg2l_gpt->mmio =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(rzg2l_gpt->mmio))
> > +		return PTR_ERR(rzg2l_gpt->mmio);
> > +
> > +	rzg2l_gpt->rstc =3D devm_reset_control_get_shared(&pdev->dev, NULL);
> > +	if (IS_ERR(rzg2l_gpt->rstc))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->rstc),
> > +				     "get reset failed\n");
> > +
> > +	ret =3D reset_control_deassert(rzg2l_gpt->rstc);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "cannot deassert reset control\n");
> > +
> > +	pm_runtime_enable(&pdev->dev);
> > +	ret =3D devm_add_action_or_reset(&pdev->dev,
> > +				       rzg2l_gpt_reset_assert_pm_disable,
> > +				       rzg2l_gpt);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> > +	if (IS_ERR(clk))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
> > +				     "cannot get clock\n");
> > +
> > +	rzg2l_gpt->rate =3D clk_get_rate(clk);
> > +	/*
> > +	 *  We need to keep the clock on, in case the bootloader enabled
> PWM and
> > +	 *  is running during probe().
> > +	 */
> > +	if (!(rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST))
> > +		devm_clk_put(&pdev->dev, clk);
>=20
> I still think this looks wrong. Please at least comment about the idea
> here. ie. devm_clk_put disables the clk and holding a reference on the
> clk isn't needed because runtime-pm handles the needed enabling.

OK, will add the comment. Yes, the code should be improved

1) This code is OK for the case bootloader is not turning on PWM.

2) But if Bootloader turns on the PWM, then we need extra handling to call
  "devm_clk_put" when usage count becomes "0" after activation of PWM chann=
els.

  ie, use a private variable for tracking bootloader on case and call "devm=
_clk_put"
  during "rzg2l_gpt_free" and reset the private variable.

 After that there is no clock framework resources and PM handles the clocks
 exclusively.
  =20
>=20
> Is this really true? Does runtime-pm disable the clk if after the clk
> wasn't put here both PWMs are disabled?

No it need special handling, See point 2 above.

Cheers,
Biju

>=20
> > +	mutex_init(&rzg2l_gpt->lock);
> > +
> > +	rzg2l_gpt->chip.dev =3D &pdev->dev;
> > +	rzg2l_gpt->chip.ops =3D &rzg2l_gpt_ops;
> > +	rzg2l_gpt->chip.npwm =3D 2;
> > +	for (i =3D 0; i < rzg2l_gpt->chip.npwm; i++)
> > +		rzg2l_gpt->gpt[i].ph =3D &rzg2l_gpt_phase_params[i];
> > +
> > +	ret =3D devm_pwmchip_add(&pdev->dev, &rzg2l_gpt->chip);
> > +	if (ret)
> > +		dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static struct platform_driver rzg2l_gpt_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "pwm-rzg2l-gpt",
> > +		.of_match_table =3D of_match_ptr(rzg2l_gpt_of_table),
> > +	},
> > +	.probe =3D rzg2l_gpt_probe,
> > +};
> > +module_platform_driver(rzg2l_gpt_driver);
> > +
> > +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> > +MODULE_DESCRIPTION("Renesas RZ/G2L General PWM Timer (GPT) Driver");
> > +MODULE_LICENSE("GPL"); MODULE_ALIAS("platform:pwm-rzg2l-gpt");
> |
