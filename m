Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE6C7B7337
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Oct 2023 23:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbjJCVTz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Oct 2023 17:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241233AbjJCVTx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Oct 2023 17:19:53 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2113.outbound.protection.outlook.com [40.107.113.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A311EB4;
        Tue,  3 Oct 2023 14:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyMMt2KFE01zoACcHocoslZsdErOVH37odfzKqvjO9YrwtDNdQPsqYGMyMs4ZhrwFLra/SSquCgif747rPE2cKg3uFp5E2m9IyO4MK2KWK/sajKdp0kTEY4BCDZdbKhnC/5GHm5CGXnqYYJm7bUaHLBDOBEV/cDqRKQIqTcJZOY5kTMoHVg2eQ2CBGZ/ptL0IQmy/xaLtoy1PrPnGe/J7x0NYLDns5hwsll5bZhNRJlwQFqbMj118LqvZ3gT9cdYM5m8rUJUXz3vRTEkEaPEgu+Bs/3yh2S6EGzRTDLseFcYBizSzcguJrHSZN/Oc9FFJNZpPLO9HPo4SEz4x/2eJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xz+/z/nZnX73mcHeh6CqdgqfqXHVKyLprCg43QN4JZc=;
 b=QN+YCLv/zgkF6PWXvW+GufGeIUk1PR+1BzN05fp6Awl4JXOPVEjWKk+ralJolz5i+lNTpxv3cdnaiyNEI3gge7ZqHVuIM2JlbGhxUAiM1vAKvkll/zaPu+Sli8vXYTgMSHqNcAg5Gh0lSpGbNhvHDLxqhSlhfpM3sESJGK187xUSNtS4raFM+xdzS9mdgbkStS4vJc5UhDXboDz/XVmM88nPZ6uBhL85ZlQVKAVAUzof1i598jGq+6ung8VavrraKwU/fs8lwxt3yH183jNZTGvj3l+HtpPWhdYR/0DW1mwLoOX9F3mLIOvIsGf0ajQJnUEKHXrePgnNqzZdSKEdcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xz+/z/nZnX73mcHeh6CqdgqfqXHVKyLprCg43QN4JZc=;
 b=BgVnDSzh6ujPT3CNfHP273N9tpGIXcOU2Ul3N9/gOemIJOu9oD/Xu+wSvPtj1P+1CRDLvFC9XfclOIcHxEXNixZBnVKNAvuZPJ8gwwPUnPmBwdCr8vqNz8GyXbNXk5Ty//CGyUMei3KrjtNr3YVvMxJshMWqA5LquBhYrlUuxUE=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by OS3PR01MB10358.jpnprd01.prod.outlook.com (2603:1096:604:1fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Tue, 3 Oct
 2023 21:19:43 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::600a:9708:18f:2528]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::600a:9708:18f:2528%3]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:19:41 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v5 2/4] pwm: Add support for RZ/V2M PWM driver
Thread-Topic: [PATCH v5 2/4] pwm: Add support for RZ/V2M PWM driver
Thread-Index: AQHZq0en02LE3ecYd0yq1gsz8PdTabAeD4gAgBsOtCA=
Date:   Tue, 3 Oct 2023 21:19:41 +0000
Message-ID: <TYWPR01MB8775150932FD1F0A346029B7C2C4A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230630114003.320641-1-biju.das.jz@bp.renesas.com>
 <20230630114003.320641-3-biju.das.jz@bp.renesas.com>
 <20230916153248.27k7erg7i7ruf76w@pengutronix.de>
In-Reply-To: <20230916153248.27k7erg7i7ruf76w@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|OS3PR01MB10358:EE_
x-ms-office365-filtering-correlation-id: ad3b95b0-4b12-4a17-f98c-08dbc4567533
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N8ntS7/E28N9EvSbu3GJCn7EGS/L75QkA5jJVY6RJN6LYMISnrFmbZRWSwcgNOjEXbFe/Zq2NEInL5Wf+6g/ftxCRmHZqCAF8q95Ia5BVJQfOpGSfrBz7Lxc1t5NByfMEMtzYZoopblZxXHhDR37ypAUaU9hOw9YsqVOkUa+Kf7EqOY04smpuI2TZgvJc5alHv061YZyCDTWSRFBTrF0rMWfrtArAuWGdJ/Mi5WhUr56hVYURUUoDT5qjQBEusdARrx4E9xQIcwPxJdWlysj1KSxbL7OZMs2KW6S4SBhk9M4BVjuQPsC28ZPVG/zJOlxxUL6dzqV69fLvOIQXniY1smfJ2bPPCegpkeHRpAALDiWEF2cbVxnz5H1FHunNe1nrILKkqBFxWCJLigELSx+J40lnEhZjbajPDK6FsxX/DzIroK985LjNqQ9zOMToz2B/++0z9XiEqzX62n68O8c7Nayd3o58Lp5CkkE3+RYvLFrRrbq5a9hqMzBuX8Do9lHrfEEIs2WROZuexsAwOvTC9GB6k/0cNlEXKUq53TWinVb+DuXiOWy2d0LC83dlSddfe7J/6L2K7QdjnE0+MqNqMlGWaK4AYdT1pRfaZnwOkk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(83380400001)(66574015)(5660300002)(2906002)(55016003)(38100700002)(71200400001)(9686003)(122000001)(7696005)(6506007)(478600001)(86362001)(33656002)(966005)(26005)(38070700005)(52536014)(8676002)(8936002)(4326008)(76116006)(64756008)(66446008)(66476007)(110136005)(66946007)(66556008)(316002)(54906003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TtACBH4ulR8eyTp5lyXY6QA/WZKSpmAdLPG+/x1uvKFvQnEomPfFSn5iMY?=
 =?iso-8859-1?Q?bKUvQ0Ld2VI2h73U/2vCjN2Tp/3PTqq98o4cpuEHfBrj4JsbSp/49PNU+A?=
 =?iso-8859-1?Q?NRvucje+U9zTRoYt5530t+9VB9WWUGaG4snvd/kAEcJSuYLwbtRtcRWdZF?=
 =?iso-8859-1?Q?xte3voKY8eiPGURE1gReaI9ZZgD98RMRCxNfTw7xip9r81tG8A7WigJZXT?=
 =?iso-8859-1?Q?tLu2YGTKHhOmomntjVd9jqwyZGSUORwOpJuAxrxeediWxU9JVBKuAzkN4t?=
 =?iso-8859-1?Q?8abB3ERzGNdNYXQvbtxDCL7Z7tarAu3jfNJN3y2TivSj+qGrTlh4IU4zVU?=
 =?iso-8859-1?Q?CtkSy/tD29EkXPZopXvBlnYi/cQVCcUwDeIEgJo0nqNssrdjla8MgyfLYd?=
 =?iso-8859-1?Q?iuPVtOkemhEkiVzUX8hfTskKbUVKayBSwqgdLCEOQbUXE9oe3wxRe+MtIv?=
 =?iso-8859-1?Q?01z45DKW/xdektgUr5UZM8CcH7VdMCetHmAsTrjOyP20rnz88fv1IieKb8?=
 =?iso-8859-1?Q?xYi37jjktUsAO9RDCFN2dfsnfqz14xnUuyMwErg3pzUKPVbH8Vy67ntiWR?=
 =?iso-8859-1?Q?5T7dQEhNGfcgYC7fCKMkVBwjgyysMc30fPTact2RATdPMJ3zUqaBFw49MO?=
 =?iso-8859-1?Q?whlBhf1zBZWKQd3yFUNOkCeWdC11E2OHOzx9vOvGHx+WSe9dnWIea/OCMK?=
 =?iso-8859-1?Q?kfKDtWP/CK+QWB4WuHWUkDCsJhGAQ/qO0//BEh5cvEVUTRiJS5vh6lv8fc?=
 =?iso-8859-1?Q?G+qbOmUooX1UA35w4e7A2sJ47e9w4oUfS7UNUr0GRr2fQhaJRuw6gr1vZi?=
 =?iso-8859-1?Q?n/tcv1q+4NDL1GAP8P9b45cntzhhA6VQl7mIpmdIX9oVJiTgqDMLm45aH4?=
 =?iso-8859-1?Q?sVtJncguujpCzT7i3j5WBW6wemSZYVuNTHrVAvCCupb282J6i/GjiYsxiN?=
 =?iso-8859-1?Q?AM+6xVFCozl2TbyPWjXWtlisA5Y+boE5K8HszuUJkLo02h/VjPXh8fu4+p?=
 =?iso-8859-1?Q?llyo3it6lrJs69mnyry0MRcmrhHiWAx/OG9vZNM8EjpFZxtSe/BnMlnFqF?=
 =?iso-8859-1?Q?VZzN3B9hH+IA1Yem4bEpGc+0ROTD9DcN78FPnUQ9aABWfs5pdWscRtfNjr?=
 =?iso-8859-1?Q?42TpdshKq2pEXA6SiU0nzCgltosy3pgIb6aR3Eodkue6RJzxOOa45oB2ih?=
 =?iso-8859-1?Q?IP/N7s6YcSlIrxNild2s05B0zOFm0NlJfHG5lV0y/tPEhF5GXwjD8ZqlPy?=
 =?iso-8859-1?Q?0ENqohyE38m7v18xY4F7hT64f6Lf3bPN2aYh2Fb58QrVwIve9hk/NIxgkj?=
 =?iso-8859-1?Q?EBJc7UPN4FwkURyIwTRq6Ziu6mdGLcPoQDg8QylWC3u1RruFd6BaCRNKDo?=
 =?iso-8859-1?Q?URqCoTVCl4KyZPvHAkvv6fVFkpn3gvorbDw7QANu4D0egs3sXmL1zm20H1?=
 =?iso-8859-1?Q?TkZoqkbSialbgqvBK2pQntwS1gdAUSvxzYurlzwTCvqzz3Q1I1qbFrW1cA?=
 =?iso-8859-1?Q?DHLuHwXhZChcg8wcs72xWPY1Sc7CJLqUOtK5MWvEY5bdJ57xnQzSZdKdBQ?=
 =?iso-8859-1?Q?i/tGrUpW4tJ9PcRxiGKk7bYBw82pFLhUlIXPOayd3ifWQmS0Jql2BDF9CB?=
 =?iso-8859-1?Q?cBPzY9jqNPWnUjoon6LvJLn/Odth+gx5mhrIVypNRfIyxfAHBTnGCx1A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3b95b0-4b12-4a17-f98c-08dbc4567533
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 21:19:41.5412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7Xr1vruMNyrHwvAN3E0N4BHJgKdEvXg5FHggzZovf6u78Pxj42WZ3zFU9PLgnsFCNFCvnnWmmdJ6PJSgLbO2vadBTT0UDI669A7ZBenYoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10358
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for your reply!

> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Subject: Re: [PATCH v5 2/4] pwm: Add support for RZ/V2M PWM driver
>=20

[..]

> > +	if (low > period) /* 0% duty cycle */
> > +		val =3D 0;
> > +	else if (!low) /* 100% duty cycle */
> > +		val =3D period;
> > +	else
> > +		val =3D period - low;
>=20
> This could be simplified to:
>=20
> 	if (low > period) /* 0% duty cycle */
> 		val =3D 0;
> 	else
> 		val =3D period - low;

Agreed. And also, I believe there is a tidier way of addressing this.
I'll rework this for v6.

>=20
> Maybe it makes sense add another variable "duty_cycle" here and use
> that
> for improved clarity? And then maybe rename "val" to "ctr"?

Agreed.

>=20
> > +	if (period)
> > +		period +=3D 1;
>=20
> This looks bogus, why don't you add 1 if RZV2M_PWMCYC is 0?

Agreed. We should always add 1.

>=20
> Also it suggests that the hardware cannot do a 100% relative duty
> cycle?

It does support 100% duty cycle.
PWMCYC =3D 0 actually means 1 clock cycle, that's why the faff with
increment and decrement operations, and that's why the confusion.

> If I didn't miss anything here, please add that to the list of
> Limitations above.

Thankfully not a limitation.

>=20
> > +	state->period =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC * (u64)period << (4
> * prescale),
> > +					 rzv2m_pwm->rate);
>=20
> The multiplication can overflow. I see no easy way to prevent this
> without introducing a mul_u64_u64_div_roundup helper. Maybe I miss
> something?

It does overflow, good catch!
I think we could split this in three operations for now, and maybe
improve it later on:
period =3D NSEC_PER_SEC * (cyc + 1);
period =3D DIV64_U64_ROUND_UP(period, rzv2m_pwm->rate);
period <<=3D rzv2m_pwm_prescale_to_shift(prescale);

with rzv2m_pwm_prescale_to_shift as below:
static inline int rzv2m_pwm_prescale_to_shift(u8 prescale)
{
    return prescale =3D=3D 3 ? 11 : prescale * 4;
}

As it turns out "<< (4 * prescale)" and ">> (4 * prescale)" are not
correct for prescale =3D=3D 3.
As per manual: PWMPS =3D 3 means a frequency division by 2048, and not
4096.
I'll address this in v6.

>=20
> > +	state->duty_cycle =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC * (u64)val <<
> (4 * prescale),
> > +					     rzv2m_pwm->rate);
> > +	pm_runtime_put(chip->dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rzv2m_pwm_config(struct pwm_chip *chip, struct
> pwm_device *pwm,
> > +			    const struct pwm_state *state)
> > +{
> > +	struct rzv2m_pwm_chip *rzv2m_pwm =3D to_rzv2m_pwm_chip(chip);
> > +	unsigned long pwm_cyc, pwm_low;
> > +	u8 prescale;
> > +	u32 pwm_ctr;
> > +	u64 pc, dc;
> > +
> > +	/*
> > +	 * Refuse clk rates > 1 GHz to prevent overflowing the following
> > +	 * calculation.
> > +	 */
> > +	if (rzv2m_pwm->rate > NSEC_PER_SEC)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Formula for calculating PWM Cycle Setting Register
> > +	 * PWM cycle =3D (PWM period(ns) / (PWM_CLK period(ns) =D7 Div
> ratio)) - 1
> > +	 */
> > +	pc =3D mul_u64_u32_div(state->period, rzv2m_pwm->rate,
> NSEC_PER_SEC);
>=20
> rzv2m_pwm->rate is an unsigned long. So mul_u64_u32_div is the wrong
> function (at least on archs where sizeof(long) > 4).

Indeed. I think mul_u64_u64_div_u64 is more appropriate.

>=20
> > +	dc =3D mul_u64_u32_div(state->duty_cycle, rzv2m_pwm->rate,
> NSEC_PER_SEC);
> > +	prescale =3D rzv2m_pwm_calculate_prescale(rzv2m_pwm, pc);
> > +
> > +	pwm_cyc =3D pc >> (4 * prescale);
>=20
> The division above might have round down the result, so you're losing
> precision here?

Indeed. I think DIV_ROUND_UP will do better.

>=20
> > +	if (pwm_cyc)
> > +		pwm_cyc -=3D 1;
>=20
> If the requested period is too small, please refuse the request.

Agreed.

> PWM_DEBUG should catch that and emit a warning.
>=20
> > +	if (!FIELD_FIT(RZV2M_PWMCYC_PERIOD, pwm_cyc))
> > +		pwm_cyc =3D FIELD_MAX(RZV2M_PWMCYC_PERIOD);
> > +
> > +	/*
> > +	 * Formula for calculating PWMLOW register
> > +	 * PWMLOW register =3D PWM cycle * Low pulse width ratio (%)
> > +	 */
> > +	pwm_low =3D dc >> (4 * prescale);
> > +	if (!dc) /* 0% duty cycle */
> > +		pwm_low =3D pwm_cyc + 1;
>=20
> if pwm_cyc =3D=3D FIELD_MAX(RZV2M_PWMCYC_PERIOD) that + 1 isn't a good
> idea,
> is it?

Indeed, the final value should be tested. Perhaps we should refuse the
request if the value of PWMCYC doesn't fit, and we should probably do
the same thing with the value of PWMLOW (which is higher than PWMCYC
when duty cycle is 0%).

>=20
> > +	else if (pc =3D=3D dc) /* 100% duty cycle */
> > +		pwm_low =3D 0;
> > +	else
> > +		pwm_low =3D pwm_cyc - pwm_low;
> > +
> > +	/*
> > +	 * If the PWM channel is disabled, make sure to turn on the clock
> > +	 * before writing the register.
> > +	 */
> > +	if (!pwm->state.enabled)
> > +		pm_runtime_get_sync(rzv2m_pwm->chip.dev);
>=20
> Can it happen that this already makes the hardware emit a (probably
> wrong) signal?

It doesn't look like this can happen with v5.
PWME set to 1 basically enables operations, and that happens after the
PWM has been configured.

[..]

> > +
> > +static int rzv2m_pwm_pm_runtime_resume(struct device *dev)
> > +{
> > +	struct rzv2m_pwm_chip *rzv2m_pwm =3D dev_get_drvdata(dev);
> > +	int err;
> > +
> > +	err =3D clk_prepare_enable(rzv2m_pwm->apb_clk);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D clk_prepare_enable(rzv2m_pwm->pwm_clk);
> > +	if (err)
> > +		return err;
>=20
> It would be consequent here to disable apb_clk in the error case to
> prevent a clk enable imbalance.

Indeed.

Cheers,
Fab

>=20
> > +
> > +	return 0;
> > +}
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 |
> https://www.pengutronix.de/ |
