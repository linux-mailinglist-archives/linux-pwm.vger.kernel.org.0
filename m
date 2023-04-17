Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D186E460B
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Apr 2023 13:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjDQLJi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 Apr 2023 07:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjDQLJh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Apr 2023 07:09:37 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on20705.outbound.protection.outlook.com [IPv6:2a01:111:f403:7010::705])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEBF5259;
        Mon, 17 Apr 2023 04:08:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2zVyd6ssfQnNOzbbxXQKet6AZh2jrH6wBoGgrNkOVqEaZOOaWiPI3Pi5xZhlOANrSRQfmT1Ip4cDnW7Xkm1r9R7nxOEs6gdr63UTwvgpGwm+aONaEUKPlnhZI3dw/trRMLbKq1qQNK2GZDKtLsX6TNmUqoJ1xYVLXrZfXLVj0fFYEAAnqpIdPJUi5WlEE2LX+pRcN2pcRdMXUGrkGOb9ts55Tjvs8t3Yi+C9gO8UQ2NHjyJQyIedEInP1+vorFNcJzn+341qmyPjYkPHF5NC6l/RnfENOAHP8cmO8239FJliird1fqlYeCJitk71Eaeqx6uZBBE5019SEnPKi6daA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2sGOa2jH6uHhLsQruCKFwRTLWd/GVG2iq5TSWoCOwQ=;
 b=bfi/vnHif+yYDDq2ZZcnrQJeJXGtbOiS9+x4BH/SamZv3vV4fGZ+xwyJNKF95c9NJ0fRIEqQyW4SVbXkloinjdEovOlYKoFuwzxTR11Fg+bkMiDmmVnLdDDubyoexUX0S9rOD7sUCJFa2xAq/wt75ywlkHCROm7LgMN+7d6yYrHDvo0hj4+6cXeB6yWFzzeAnkq5XDLmG6JmG7LvMXjn9NotCeIz4ZHESVZ2UPkdlabESlhn8kmkyXmHYNCqziLBcw8Ci7Z6gK1ZdEUqsz2TMjGObaKgrWHdAILnl4DqV+JSzw7BWAoDi0fXAVMx7lxRgTrombaizNoHI11TWUkqYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2sGOa2jH6uHhLsQruCKFwRTLWd/GVG2iq5TSWoCOwQ=;
 b=FiGEJ15CsMfQzfXOikIz8tVZoEmSBhcG0hLBNbDVUe22AQrfAjoShndPoGuCpDho+kg1xeddNxY45iytbR2dCXrUJFEinnu/CGNsU5e+z+kBQuQEmwK1Faic5S63w1x0egLJbbVcZGAsCdjcAFpDR9rNKdTy/0hU/0BKSjnM5vc=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB9975.jpnprd01.prod.outlook.com (2603:1096:400:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 11:06:59 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%5]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 11:06:59 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Lee Jones <lee@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        William Breathitt Gray <william.gray@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v15 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Topic: [PATCH v15 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Index: AQHZYvkq1tObMCxvvECDvU/oy9wfC68qbjSAgAA3iDCAAHg0AIAEVEYA
Date:   Mon, 17 Apr 2023 11:06:59 +0000
Message-ID: <OS0PR01MB592260E8E4F583704C2844B0869C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230330111632.169434-1-biju.das.jz@bp.renesas.com>
 <20230330111632.169434-7-biju.das.jz@bp.renesas.com>
 <20230414062641.76no7jz7uluixwdg@pengutronix.de>
 <OS0PR01MB5922824F09E1BC9FB9CECC9586999@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20230414165540.bfquriyo6crnxj5q@pengutronix.de>
In-Reply-To: <20230414165540.bfquriyo6crnxj5q@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB9975:EE_
x-ms-office365-filtering-correlation-id: 7aefd901-1e67-4274-21f2-08db3f33dd4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mX0uuNyk5ApJZs962HCmZk/ayObx0hSYGZz/06xXgChc72UwJvknKuobTs1ZBXWcNjgfy4pImKJJdXlFubzJ7jvJW9aFaRqOBWx1aud2zDul65AHnZrPCNDKT43cfzD7X9P3jy6tOA3FXDsDmvWrMORRRgIzb7cANcB/vYTU3rUl+5gf+NNk9iBc8k4MIhacyw1G7jMSIotW7Vi4OGON8BiyS1lfmTOLM8fhwaRaAa9UEJpTwGbP6hDqfbSKOJ1ZMRd435L3HzT9BtAyxXiHNg2wIgwA2D8opWvXJseNznEo8AEyyxOtq0zCptPNBshCgyF6hRM8UzNiaN2ODsEGkDeJMCifz1wm+hgKgOVxtbgD6y3wDNjzxFD5YfvkYeg9UMHBP28qXQC9wfVkGfUV3ZekTbV/wDJPkAs/oIqUGjCoxXhJs8i5NYHuYhzf73kiiy35xRkfwnY8TcA6lkWLYomdaKKoXSSj6ncS1IuRLvywweSKtxu65dAx+1k4vuKr3Kf0cwDHv+RJx/VTzNsQMDF7x4FStIGPYKTSUi7y+gu2MUqS83e8JTg1i2yrEYxQtw+EQ9Ujg13M4eNlHJLqGTfKumCS6412sVbprya8Cvxv/otpnny/6xWNF7aHzENwJlXjXBRUXFrfymLaFSES6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(52536014)(5660300002)(86362001)(83380400001)(186003)(26005)(6506007)(9686003)(122000001)(38100700002)(38070700005)(8676002)(8936002)(33656002)(54906003)(478600001)(71200400001)(7696005)(316002)(41300700001)(55016003)(76116006)(64756008)(66446008)(66476007)(66556008)(4326008)(6916009)(66946007)(2906002)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kfNaF/gZFvglHIuJCJoVp2TbG4HcAE1Vz0FhkqJIXp4tgD9+pna0KXhOX1?=
 =?iso-8859-1?Q?FrqrIR4qrdgZindLxGNQt0tfoYvV3wYySFoDRXDckPY0r1fAwqXQPnqoxv?=
 =?iso-8859-1?Q?1uINapFeAAsgHscxPiWTGep07BPsVeQIhRUSOfZ5j3SU18rv00Tc22ZpYW?=
 =?iso-8859-1?Q?oHnHAaN0D9jWG+G1cQDHG5R9XcZG76e1rlkBu+iTs7Rq4Bi56jdRc7+KZy?=
 =?iso-8859-1?Q?MuuE/WNiEMAA78Pyuowd/eHAm0YKHHsWVnZkjIccYj54KOZKopGT0DHpgO?=
 =?iso-8859-1?Q?wFxt0UnCNIj0X5wNov/Z8KX1MecBf5x3aObVMA81U5xQiCDrYpd7LBFxG4?=
 =?iso-8859-1?Q?f1WZGTGnMqd1xKv/G5U2IWVNiSB8hO0RcBKfa5o/2PxGIRZ9s0qfL+9aHo?=
 =?iso-8859-1?Q?Tb1Np1vocAuZJ/chllCsKx/KcMjZm/dbpFi/pKSXnOVstn89GyVaYzY2ED?=
 =?iso-8859-1?Q?VFVs9SxrhbLpxXtWWZ/P3UvdIqdVeKbN1UXMS1XNJBrMJMjNxdOKeOnCkv?=
 =?iso-8859-1?Q?eayEtr7vItsggqL12vYR/dv31RHuHaPcnICfAKV4fQuT7clp4wSbIF+cCt?=
 =?iso-8859-1?Q?qg3ezmaOWoS5DWkEfOHRwMsAB5Yf2gad14INbvvOU3K7XCtOcmxOxpTHAR?=
 =?iso-8859-1?Q?gJBbs3SOfdeITrDPF3c4JzZcyG4+hPtkqUUkmP6TDvduKH/07ayZQVNZmc?=
 =?iso-8859-1?Q?JznBVil9zTaZu5Yv7hflchkU7mMjU4r5Kn3IwdUdYdurL1VbMQi1HxK3uR?=
 =?iso-8859-1?Q?3E5CKkGHo+LRKFuKx4g6LTGpjXAD6UdanRpr9e3rgMZJBLEIlaRepIbc15?=
 =?iso-8859-1?Q?x1FU0S4VDXKlJMo04Z2of32i5Q2Z3M4CO1ETougMriTInuuwPBdJREqQXT?=
 =?iso-8859-1?Q?iQzjPTMStfcknc67g+IJOvpfYzIgYG+O2pD+OWBoWua8JStx6Bj0cxVeDR?=
 =?iso-8859-1?Q?PLi+tZH9W0IhbDGfwr8NoOrELFWunQ7G8dXNRSM0+YKmekYKywYrs1IyxN?=
 =?iso-8859-1?Q?sRC8i6Lx/WgBFIqMgQGFxxYl2dhnfgDIuZn+olDkz3JW+/V1jAExA2diNn?=
 =?iso-8859-1?Q?Ih2Lf/6C8Zl0CkSTunp5ryvdr2yjxaMI8W2G/Yr2SNtqBI4GwZyQinoxUX?=
 =?iso-8859-1?Q?CVVD5ZgQLJ2ay59TcYQTQy6aOYSUYNh4RBaNvIXhIj7U7z4ly/Sob+Wrbk?=
 =?iso-8859-1?Q?pplIY018ZQkljGOzDFFK0m6pjRVT16nMxYa7vy0WCBxhVaJovlbL2NFL0G?=
 =?iso-8859-1?Q?WqiUtwJJ6HQyq4lguttjmwS1i3yk9dYfqMXiy9oBorM5K/n2h4cdHkymlh?=
 =?iso-8859-1?Q?lZheA4QTXdJCaUDc1VbTZ+BBxrTKaYBCoayEbDl1RyHY6yCtBmQDsAyh+u?=
 =?iso-8859-1?Q?9r2r5MT+6wNPf/1CGruH2CxJiArHUfxSqefP80NVPuK+ZasYJLjQh5YUvp?=
 =?iso-8859-1?Q?j6s7mCnwIpl7vmKNFedkWC8HKDCsBMUk2S1qL9tGp7V4kOEHTzWBa8882e?=
 =?iso-8859-1?Q?ESdA39mnQprIEghaCqrMTDHcaHxrUx6p8bxRdxa7fdRHa8TZI4upnkfurl?=
 =?iso-8859-1?Q?HNLcUpw7zCS3rRr2WWPCXufPjxp1o6PpPLXNGd5xYdyV8tC9yjswBojO+O?=
 =?iso-8859-1?Q?mJh1efwDqAoo7YwAGArCWVJNhSQgnGXqJ5?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aefd901-1e67-4274-21f2-08db3f33dd4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 11:06:59.1233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n80RY9JSHTeHPOqrre8gG5M3n9oYgxgf6BlDbr2V0iM8npbM88yV0IbI+L3dz9TkaoaRPjnYKSwrLMxe2SfelTiv2DXfnPVmhbj049RXH6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9975
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for the feedback.

> Subject: Re: [PATCH v15 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
>=20
> Hello,
>=20
> On Fri, Apr 14, 2023 at 09:53:09AM +0000, Biju Das wrote:
> > > On Thu, Mar 30, 2023 at 12:16:32PM +0100, Biju Das wrote:
> > > > +	val =3D RZ_MTU3_TCR_CKEG_RISING | prescale;
> > > > +	if (priv->map->channel =3D=3D pwm->hwpwm) {
> > > > +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR,
> > > > +				      RZ_MTU3_TCR_CCLR_TGRA | val);
> > >
> > > If the sibling PWM on the same channel is on, you're overwriting its
> > > prescale value here, are you not?
> >
> > Yes, you are correct. Will cache prescale and add the below code in
> > rz_mtu3_pwm_config(). Is it ok?
> >
> > +        * Prescalar is shared by multiple channels, so prescale can
> > +        * NOT be modified when there are multiple channels in use with
> > +        * different settings.
> > +        */
> > +       if (prescale !=3D rz_mtu3_pwm->prescale[ch] && rz_mtu3_pwm-
> >user_count[ch] > 1)
> > +               return -EBUSY;
>=20
> If the other PWM is off, you can (and should) change the prescale value.
> Also if the current prescale value is less than the one you want to set, =
you
> can handle that.
>=20

You mean like below??

static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm=
,
			      const struct pwm_state *state)
{
	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
	struct rz_mtu3_pwm_channel *priv;
	u64 period_cycles;
	u64 duty_cycles;
	u8 prescale;
	u16 pv, dc;
	u8 val;
	u32 ch;

	priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
	ch =3D priv - rz_mtu3_pwm->channel_data;

	period_cycles =3D mul_u64_u32_div(state->period, rz_mtu3_pwm->rate,
					NSEC_PER_SEC);
	prescale =3D rz_mtu3_pwm_calculate_prescale(rz_mtu3_pwm, period_cycles);

	/*
	 * Prescalar is shared by multiple channels, so prescale can
	 * NOT be modified when there are multiple channels in use with
	 * different settings. Modify prescalar if other PWM is off or current
	 * prescale value is less than the one we want to set.
	 */
	if (rz_mtu3_pwm->enable_count[ch] > 1 &&
	    rz_mtu3_pwm->prescale[ch] > prescale)
		return -EBUSY;

	pv =3D rz_mtu3_pwm_calculate_pv_or_dc(period_cycles, prescale);

	duty_cycles =3D mul_u64_u32_div(state->duty_cycle, rz_mtu3_pwm->rate,
				      NSEC_PER_SEC);
	dc =3D rz_mtu3_pwm_calculate_pv_or_dc(duty_cycles, prescale);

	/*
	 * If the PWM channel is disabled, make sure to turn on the clock
	 * before writing the register.
	 */
	if (!pwm->state.enabled)
		pm_runtime_get_sync(chip->dev);

	val =3D RZ_MTU3_TCR_CKEG_RISING | prescale;

	/* Counter must be stopped while updating TCR register */
	if (rz_mtu3_pwm->prescale[ch] !=3D prescale && rz_mtu3_pwm->enable_count[c=
h])
		rz_mtu3_disable(priv->mtu);

	if (priv->map->base_pwm_number =3D=3D pwm->hwpwm) {
		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR,
				      RZ_MTU3_TCR_CCLR_TGRA | val);

		rz_mtu3_pwm_write_tgr_registers(priv, RZ_MTU3_TGRA, pv,
						RZ_MTU3_TGRB, dc);

		/* Update pv and dc of other PWM based on new prescalar */
		if (rz_mtu3_pwm->prescale[ch] !=3D prescale &&
		    rz_mtu3_pwm->enable_count[ch] > 1) {
			rz_mtu3_pwm_read_tgr_registers(priv, RZ_MTU3_TGRC, &pv,
						       RZ_MTU3_TGRD, &dc);
			rz_mtu3_pwm_calculate_new_pv_dc(rz_mtu3_pwm->rate, &pv,
							&dc, prescale);
			rz_mtu3_pwm_write_tgr_registers(priv, RZ_MTU3_TGRC,
							pv, RZ_MTU3_TGRD, dc);
		}
	} else {
		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR,
				      RZ_MTU3_TCR_CCLR_TGRC | val);

		rz_mtu3_pwm_write_tgr_registers(priv, RZ_MTU3_TGRC, pv,
						RZ_MTU3_TGRD, dc);

		/* Update pv and dc of other PWM based on new prescalar */
		if (rz_mtu3_pwm->prescale[ch] !=3D prescale &&
		    rz_mtu3_pwm->enable_count[ch] > 1) {
			rz_mtu3_pwm_read_tgr_registers(priv, RZ_MTU3_TGRA, &pv,
						       RZ_MTU3_TGRB, &dc);
			rz_mtu3_pwm_calculate_new_pv_dc(rz_mtu3_pwm->rate, &pv,
							&dc, prescale);
			rz_mtu3_pwm_write_tgr_registers(priv, RZ_MTU3_TGRA, pv,
							RZ_MTU3_TGRB, dc);
		}
	}

	if (rz_mtu3_pwm->prescale[ch] !=3D prescale) {
		/*
		 * Prescalar is shared by multiple channels, we cache the
		 * prescalar value and use the same value for both channels.
		 */
		rz_mtu3_pwm->prescale[ch] =3D prescale;

		if (rz_mtu3_pwm->enable_count[ch])
			rz_mtu3_enable(priv->mtu);
	}

	/* If the PWM is not enabled, turn the clock off again to save power. */
	if (!pwm->state.enabled)
		pm_runtime_put(chip->dev);

	return 0;
}

Helper functions:
static void rz_mtu3_pwm_read_tgr_registers(struct rz_mtu3_pwm_channel *priv=
,
					   u16 reg_pv_offset, u16 *pv_val,
					   u16 reg_dc_offset, u16 *dc_val)
{
	*pv_val =3D rz_mtu3_16bit_ch_read(priv->mtu, reg_pv_offset);
	*dc_val =3D rz_mtu3_16bit_ch_read(priv->mtu, reg_dc_offset);
}

static void rz_mtu3_pwm_write_tgr_registers(struct rz_mtu3_pwm_channel *pri=
v,
					    u16 reg_pv_offset, u16 pv_val,
					    u16 reg_dc_offset, u16 dc_val)
{
	rz_mtu3_16bit_ch_write(priv->mtu, reg_pv_offset, pv_val);
	rz_mtu3_16bit_ch_write(priv->mtu, reg_dc_offset, dc_val);
}

static u64 rz_mtu3_pwm_get_period_or_duty_cycle(unsigned long pwm_rate,
						u16 val, u8 prescale)
{
	u64 tmp;

	/* With prescale <=3D 7 and pv <=3D 0xffff this doesn't overflow. */
	tmp =3D NSEC_PER_SEC * (u64)val << (2 * prescale);

	return DIV_ROUND_UP_ULL(tmp, pwm_rate);
}

static u16 rz_mtu3_pwm_calculate_pv_or_dc(u64 period_or_duty_cycle, u8 pres=
cale)
{
	return (period_or_duty_cycle >> (2 * prescale)) <=3D U16_MAX ?
		period_or_duty_cycle >> (2 * prescale) : U16_MAX;
}

static void rz_mtu3_pwm_calculate_new_pv_dc(unsigned long pwm_rate,
					    u16 *pv, u16 *dc, u8 prescale)
{
	u64 tmp;

	tmp =3D rz_mtu3_pwm_get_period_or_duty_cycle(pwm_rate, *pv, prescale);
	tmp =3D mul_u64_u32_div(tmp, pwm_rate, NSEC_PER_SEC);
	*pv =3D rz_mtu3_pwm_calculate_pv_or_dc(tmp, prescale);

	tmp =3D rz_mtu3_pwm_get_period_or_duty_cycle(pwm_rate, *dc, prescale);
	tmp =3D mul_u64_u32_div(tmp, pwm_rate, NSEC_PER_SEC);
	*dc =3D rz_mtu3_pwm_calculate_pv_or_dc(tmp, prescale);
}

And in apply, add lock around config()

	mutex_lock(&rz_mtu3_pwm->lock);
	ret =3D rz_mtu3_pwm_config(chip, pwm, state);
	mutex_unlock(&rz_mtu3_pwm->lock);

Cheers,
Biju
