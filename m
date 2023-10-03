Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7677B6BE7
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Oct 2023 16:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbjJCOlx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Oct 2023 10:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjJCOlw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Oct 2023 10:41:52 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2122.outbound.protection.outlook.com [40.107.114.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E4EA7;
        Tue,  3 Oct 2023 07:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+1a1Hzm2/Qeruq0MDHnTID1s1siCWixNUIX7Ur+aHJecOWJZdN6aYBjY3U60h+4mqEMxwYYgEVteeuuZ/UuhTFhgx1PBAwjPh3Y6G2MlA+uH3PARRqAdhScxkC5jJ+hwQ6GDC5Ghqg7P8y7pQ2TCnrxIcPLCRYdUt7MgSSPiqQja1VO7VnuTwnfBAQPy5Jo7fcKHvHmjL1gRBDgU+e3zXQJbl8w1YLb64mAytAYM3kHk3YQYEeGKB1aajyI98qxaZlNSfJEObxhp5hhagcAVXCsnR5+RB48eh1JQAtVvT9zkSxQPW0t5Zj281M3lU0+MXwfYT0m4+MkUTJDnEF0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqZf39MNVb7g+9WVcH6rnMQQMaHp20Z/DutChQapdu0=;
 b=ms7W0FRUa7CuV/kZspEU2xM0uzNEQ2trq5if7uPmDTpxGPsml5E3lRhpaWSKQVCxMKdlytcjBBIsaav4fCtX78Z843Q4Fb8/ZqDD5ihYf8NRwLwYGXFxkutfqVWsHo364EX6DWUnyyEvcytD4sP0oESnVLysHiCjnZrbONit+c9yzUE0vBWg1//LsxsiYzcKmQO3vE8to4XbUFIHXsGxOEzulOSRtiVRY2loZs25b9Cccbv5iz1kV2LyLlRj6TO4uG1UbM4lrepG83leZWUZaYvCvLXWwsS13PEkS4zXVShTOwR48IMDlZ0az1yxbwaDwDM6NfZQAPGRDCKHzdYFzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqZf39MNVb7g+9WVcH6rnMQQMaHp20Z/DutChQapdu0=;
 b=IVVaarXn4WQgSun1Bsy9n+haiOetNyIeEy1nwlZ83mtOeKCpVfD81XYndBKSYd5HpioSGf+QXFHUoYC9QtidiqeFiX0ur7jlkB69y7v+6//VdyZStBNLAfviY79+DDINbZdYHfSelpVOC+SGaIbR684YOssUsp7g7nArPw6EcsQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB5594.jpnprd01.prod.outlook.com (2603:1096:404:8058::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Tue, 3 Oct
 2023 14:41:45 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629%7]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 14:41:41 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v15 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v15 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHZu5nYvPKIcoC7Z02I2+/+LQbM2bAklzgAgBP7U+A=
Date:   Tue, 3 Oct 2023 14:41:41 +0000
Message-ID: <OS0PR01MB59224E641DCA436793A106B186C4A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230721060840.8546-1-biju.das.jz@bp.renesas.com>
 <20230721060840.8546-4-biju.das.jz@bp.renesas.com>
 <20230920211250.ifzt7vlpl5phjhpu@pengutronix.de>
In-Reply-To: <20230920211250.ifzt7vlpl5phjhpu@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB5594:EE_
x-ms-office365-filtering-correlation-id: ccd51f65-8881-4884-446b-08dbc41edbd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IbEePSncVNau7RwsWmSPt5i+paMRGBzRGtDdEe+P1xCleCKw6BX6owyDjO4L4oIcLKvYTsrbkfSJhNw5s16Pzrovp7GXFVAk7sH0MZDlV1ISc67ltAi2XFPEZMcSehz3xK2VZ2sEr97tmPUfO4XSQE4LRFeISv8C60898Wof/LUmsvEpU3louwmj9qiKd3cNeEoiuvugKLyshxmZUBjOcgor99Efg+HUp6n2hbyuacHagMZ+dgZsiOSRwhMVvGjV7aZSROnD6HHYNTv8tXKt0lj9fl64X6x+r6nb0oxnT0tmtPXxngYQrs5U3Stgn0UbOu7hubShxk+B/9sIqTTPWuqScommSgYAzDaqQ0EQjDIhrxY/V7q2a5Jzm04DP/pb6UzFuCjLLOQDqILlzK5T9UHjF++yQX7CZ1Tr/JYRTjw3tkq6TjBgDNR8VMBUIImJcVqTu9FMzkPOZeFxH7W+AfhH4ujRVwkmZfdy2z7hSV6qvp2ui5BKtAvlIUzRGYYaUnKZtjg7pUrMaix0yNkmzre9EzozGxwQXu8ob8AF58PN9lrGBDH0Cs1ZrX9Lp0/BKJ4SUq4dmxiIIFri0P1iEzaOTDDF3FFUIbNt8WeE6GU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(55016003)(26005)(9686003)(122000001)(66574015)(107886003)(76116006)(8936002)(54906003)(66946007)(41300700001)(64756008)(38070700005)(71200400001)(6916009)(66446008)(66556008)(66476007)(966005)(478600001)(7696005)(6506007)(38100700002)(83380400001)(316002)(8676002)(86362001)(2906002)(33656002)(5660300002)(4326008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3cTqN0V1hufPrph9x6q2hZMT0lv73h0M6CSX6WzT0HKUUwDm9IV5pA4Z/L?=
 =?iso-8859-1?Q?QfJFQrsdSw4kEXBsxDeamqcyiLEtJuwnpH/T2w3/yGH3a/Cq3NOes1+y/l?=
 =?iso-8859-1?Q?J2lrVUi33tbWbwWpMBwybmzHArNQXE7ZdoEVLfZJMbIdnjqraxz3Ttojr3?=
 =?iso-8859-1?Q?bCcIurC+9mRlrVvjps/RQ7Oj+sGwVqMbPLEYTYj4N5Ba47fU8QUxFenKs8?=
 =?iso-8859-1?Q?+cd0urIhRIQLCdRu0u0p2VzcqSybPI9AWz3sW208HBo7L3tVI/FDJCoq5X?=
 =?iso-8859-1?Q?Z4DQ6bu1IU13doVyF4Qzf39FSMXdij0mW2o4BoBPQM6mvo43wmLtoBpjDY?=
 =?iso-8859-1?Q?B5dpv9crLnnQrGVq6GKJ/lVbkfncJIa1tBkbziZM/CslWBGp6kuWT0Ab8f?=
 =?iso-8859-1?Q?R4Erjwk4QLVR14FA+Zu/FHP/m2y60Vwhst5zfkDwKPPEhiEoglDzn7Ufsw?=
 =?iso-8859-1?Q?Q6ZLw9DSiPxH50GbgaajwCGfd2s8yeT5USQBoC0WIdBJ31UYzYX+wFUZhH?=
 =?iso-8859-1?Q?faGZAZ0IQ1MlgIlU2w+XO5gmF1t4d/2afxwIBi6BQnDr/mFLwLnw8xWmZx?=
 =?iso-8859-1?Q?XZC/QlgziaxsXMf4iqigzhcZVOqg/dmJdlNo3pSK7aMpK/SSTUfKr1Wx9q?=
 =?iso-8859-1?Q?GN+cg7RJoNqL4g4/EgSIC+0Kxu5STMbyTDKkkeawFT3lEzyijK4iCl2UQj?=
 =?iso-8859-1?Q?WjuninjuIAdWjDht5FvSonuR9zb2yrcH6HQlwN89piJAb6Jn5yTL+KP0Ng?=
 =?iso-8859-1?Q?D9hQAjb48KZg3+77MIY+koazmS1gjXrpyE07QPlV9ah8+V+NA6F/nlb+FJ?=
 =?iso-8859-1?Q?iqENV/JKT4Ryy4PixQnvUHvasTxWvyWuPedT6RicHgmDc4iEv3OIl4Jhb7?=
 =?iso-8859-1?Q?WHXg2DLVBuRD1M4rfWsPUCvj4MYSpYbc0pZd7y0mD5crKBDm8PUjDLbpxR?=
 =?iso-8859-1?Q?myI5C0ZU0UQn7Ts0X261HvoT6uRi3Bdwkp08e25WV7TKgwQ6FLDMcwReqb?=
 =?iso-8859-1?Q?hDRgkQ5OL612AL9YzLK3vVHjQqM9vfvURNAosAp6K/pNAWjFXIRK36Co68?=
 =?iso-8859-1?Q?5Nx8O+w6bgTSkJS4+FL3X2ZAKuOcYVlsWtf+3RJ90XUFSDf9nXteKxfvPl?=
 =?iso-8859-1?Q?BwcY/8+brXWrMoGsEr69r72X6zT5EZ2Ex2vdjcA5+z/jh3ZJ4eoWybrGAp?=
 =?iso-8859-1?Q?ZsH23bYTvzy3sm6vfw84yMo5LWO4/jp0zqvoxlI9KztC/gkQZY11Up5ZJT?=
 =?iso-8859-1?Q?/Z3cXlet/dv3Zwii0k2j/gppDQwkRXAHj2SmzlVjjHm0RFeM27UvwhvN/3?=
 =?iso-8859-1?Q?09yekhjZjyXAlOG1TY+sNuFJtJzFMljyNzrsPHfrzkJHo4FaHTHXjU7z20?=
 =?iso-8859-1?Q?LUqNqeVb7dGC+68Nxyx+QVWbGoJwKY8wdman7cnzrgzE+SasPJ8j8cM32n?=
 =?iso-8859-1?Q?rpdgi4JCcS8DSDSURsRHAx79noVz1PxDH8op9jpw8k9fvCDpPcmKZwlubJ?=
 =?iso-8859-1?Q?5acvUA+Fm889a1sdxt9BZTz3iDUtSyX5LY3tSBj7vEo3GToDaj+D9Lux4Y?=
 =?iso-8859-1?Q?hRhv/75m2A3E+x19QjuEfkTFUg5EYcX5yrzCYzRz+AOXCsAIRSBMyBejqD?=
 =?iso-8859-1?Q?VMgO2CRZleihwn2/1BFieC1sRvcX1Gp/m82xveEzNw+AfEkIMifdEsJw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd51f65-8881-4884-446b-08dbc41edbd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 14:41:41.8526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0rKB6KqViCPSmJZ44n+93usUXSvQ/ZiArGUKN1qTI/z1HgPR91OZ5kiXaem/T4dexcBV3qp5tHMZsmn4aKo4DTIdd4y2HEzE3BxMqWx+K6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5594
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe Kleine-K=F6nig,

Thanks for the feedback.

> On Fri, Jul 21, 2023 at 07:08:39AM +0100, Biju Das wrote:
> > [...]
> > +static int rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_devic=
e
> *pwm,
> > +			       struct pwm_state *state)
> > +{
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +	int rc;
> > +
> > +	rc =3D pm_runtime_resume_and_get(chip->dev);
> > +	if (rc)
> > +		return rc;
> > +
> > +	state->enabled =3D rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm);
> > +	if (state->enabled) {
> > +		u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> > +		u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> > +		u8 prescale;
> > +		u64 tmp;
> > +		u32 val;
> > +
> > +		val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTCR);
> > +		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);
> > +
> > +		val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTPR);
> > +		tmp =3D NSEC_PER_SEC * (u64)val;
> > +		state->period =3D DIV_ROUND_UP_ULL(tmp, rzg2l_gpt->rate) << (2 *
> > +prescale);
>=20
> You're loosing precision here. If for example we have: GTPR =3D 0xf, TPCS=
 =3D 5
> and rzg2l_gpt->rate =3D 26000000, the output wave's period is:
>=20
> 	period =3D 0xf * 1000000000 / 26000000 << 10
>=20
> The exact value is 590769.2307692308, so the right value to return is
> 590770. However your calculation yields 590848.
>=20
> The problem is that the rounded value is further processed. Maybe we need=
 a
> function mul_u64_u64_div_u64_roundup(), or do you see a clever alternativ=
e?

I think DIV64_U64_ROUND_UP() will do as it is giving right
value 590770 where as DIV64_U64_ROUND_CLOSEST() is giving=20
590669.

>=20
> > +		val =3D rzg2l_gpt_read(rzg2l_gpt,
> > +				     offs + RZG2L_GTCCR(RZG2L_IS_IOB(pwm-
> >hwpwm)));
> > +
> > +		tmp =3D NSEC_PER_SEC * (u64)val;
> > +		state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, rzg2l_gpt->rate) <<
> (2 *
> > +prescale);
> > +
> > +		if (state->duty_cycle > state->period)
> > +			state->duty_cycle =3D state->period;
> > +	}
> > +
> > +	state->polarity =3D PWM_POLARITY_NORMAL;
> > +	pm_runtime_put(chip->dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8
> > +prescale) {
> > +	return min(period_or_duty_cycle >> (2 * prescale), (u64)U32_MAX); }
> > +
>=20
> Maybe mention in a comment here that rzg2l_gpt_config() is only called
> holding the lock?

Agreed. OK will add the comment

/* Caller holds the lock while calling rzg2l_gpt_config() */

>=20
> > +static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > +			    const struct pwm_state *state) {
> > +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> > +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> > +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> > +	unsigned long pv, dc;
> > +	u64 period_cycles;
> > +	u64 duty_cycles;
> > +	u8 prescale;
> > +
> > +	/*
> > +	 * GPT counter is shared by multiple channels, so prescale and period
> > +	 * can NOT be modified when there are multiple channels in use with
> > +	 * different settings.
> > +	 */
> > +	if (state->period !=3D rzg2l_gpt->state_period[ch] && rzg2l_gpt-
> >user_count[ch] > 1)
> > +		return -EBUSY;
>=20
> this is stricter than necessary, but if you don't want to spend additiona=
l
> brain cycles (we're at v15 already), that's ok. Can be addressed later if
> the need arises.

Agreed. Will address it later based on the need.

>=20
> > +	period_cycles =3D mul_u64_u32_div(state->period, rzg2l_gpt->rate,
> NSEC_PER_SEC);
> > +	prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_cycles);
> > +
> > +	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_cycles, prescale);
> > +
> > +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle, rzg2l_gpt->rate,
> NSEC_PER_SEC);
> > +	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_cycles, prescale);
> > +
> > +	/*
> > +	 * GPT counter is shared by multiple channels, we cache the period
> value
> > +	 * from the first enabled channel and use the same value for both
> > +	 * channels.
> > +	 */
> > +	rzg2l_gpt->state_period[ch] =3D state->period;
> > +
> > +	/*
> > +	 * If the PWM channel is disabled, make sure to turn on the clock
> > +	 * before writing the register.
> > +	 */
> > +	if (!pwm->state.enabled) {
> > +		int rc;
> > +
> > +		rc =3D pm_runtime_resume_and_get(chip->dev);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> > +	/*
> > +	 * Counter must be stopped before modifying mode, prescaler, timer
> > +	 * counter and buffer enable registers. These registers are shared
> > +	 * between both channels. So allow updating these registers only for
> the
> > +	 * first enabled channel.
> > +	 */
> > +	if (rzg2l_gpt->enable_count[ch] > 1)
> > +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_CST,
> 0);
>=20
> It's already late here, but I wonder if the condition is wrong here?!
> s/>/<=3D/ ?

Agreed. Will fix.

>=20
> > +	/* GPT set operating mode (saw-wave up-counting) */
> > +	rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_MD,
> > +			 RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
> > +
> > +	/* Set count direction */
> > +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTUDDTYC, RZG2L_UP_COUNTING);
> > +	/* Select count clock */
> > +	rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_TPCS,
> > +			 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
> > +
> > +	/* Set period */
> > +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTPR, pv);
> > +
> > +	/* Set duty cycle */
> > +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTCCR(RZG2L_IS_IOB(pwm-
> >hwpwm)),
> > +			dc);
> > +
> > +	/* Set initial value for counter */
> > +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTCNT, 0);
> > +
> > +	/* Set no buffer operation */
> > +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTBER, 0);
> > +
> > +	/* Restart the counter after updating the registers */
> > +	if (rzg2l_gpt->enable_count[ch] > 1)
> > +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR,
> > +				 RZG2L_GTCR_CST, RZG2L_GTCR_CST);
> > +
> > +	/* If the PWM is not enabled, turn the clock off again to save power.
> */
> > +	if (!pwm->state.enabled)
> > +		pm_runtime_put(chip->dev);
>=20
> rzg2l_gpt_config() is only called if state->enabled is true, i.e. the
> hardware is about to be enabled. I think it's not sensible in this case t=
o
> call pm_runtime_put().

OK will drop it.

Cheers,
Biju

>=20
> > +	return 0;
> > +}
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
