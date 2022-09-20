Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CEA5BEB88
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Sep 2022 19:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiITRBG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Sep 2022 13:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiITRBF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Sep 2022 13:01:05 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2104.outbound.protection.outlook.com [40.107.114.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230F452448;
        Tue, 20 Sep 2022 10:01:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0ltmnYaR4z4Zn7JEfLAac0NS4zdPeFiJeE06hdaxrdiyLcVhNrIXQJNsKbu479Np+pnRriizf4QEEv9yLVKt/stBV7DuoyYumEwPWeNOK30zGqX0HnLmJ4XThq7Y9oqou/yC5JK38HiUTyadXfk0sK7K4qarCOJyvyOOWSpvAtzTVt4ADksG3AimCuJYhBHF2kK/j2XsnGL6pZScjbvC8Jj6LaBtvKGDsLbIvLaxYEotbNePYGBPuBZvEbz2RE0m/2aBfylRmyKfN36QewvOazO2YULUb8kvxHb8MgVcGsk5HBDDzmE4BNJZS/h7bPhEgM07KV8bOWuTVGuDUHxRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myZPPItXFOwyUBm8PIc0081ZJ8fSuRGaTUsn1k8bQOA=;
 b=oFgRAUGkjkXXcefZd9r4OpbO3So/zSnSS3W1IzcHbcgvujUiJmpMhBO5IkNou16T95Rn3o/v8BqEXYW/i+lIrCqyCuT7jebM2rgSpCborhnykfGBj4lwAFw+Y/NRevq7bFHGeLGBh6PT49uT0ojl8+rd1vktps/Y5TqHl8copx4n+iDR2sBOX+b2UkGAvaf/CZllsNJF12899E7ccS3jJ1FjJXR8yctzdie3WxtEuA1L2PmcD5EHhb/zar9wbopwkuUdLrw294hm+5N0SxosW8KVjniddTJchYPAxIibvJdyoedGh9wyM0OJB4qihYdbWTG4Rp1u2Ym2YyKe6PKLtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myZPPItXFOwyUBm8PIc0081ZJ8fSuRGaTUsn1k8bQOA=;
 b=qOx17aPZq29WPemmbqGk9CUB18TjxfZ2MkOZqaRrYtaC8ZcCe9hAqW1tzPxauCTl0g3ixYid1/faIzgCC8QYuZT3jgJJ0Bi59YGulMXLcKIOeXOcN2KUe4M0HwKa1N1jL6wIewcOqv8e+JdGduRBzjWwEhgFjAs6rBmXVnE6QEI=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB6182.jpnprd01.prod.outlook.com (2603:1096:604:d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Tue, 20 Sep
 2022 17:01:00 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f%3]) with mapi id 15.20.5654.015; Tue, 20 Sep 2022
 17:01:00 +0000
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
Thread-Index: AQHYwUrah2CK2PlWrU6yp9jjjlk8rK3meFWAgAIFOuCAABIAAIAADOWA
Date:   Tue, 20 Sep 2022 17:00:59 +0000
Message-ID: <OS0PR01MB5922A9B3314F2F2B32F6B0DE864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220905171328.991367-1-biju.das.jz@bp.renesas.com>
 <20220905171328.991367-3-biju.das.jz@bp.renesas.com>
 <20220919075727.rmph7jmopaqvyyri@pengutronix.de>
 <OS0PR01MB5922B87D4A05973F88B427A7864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220920155306.dvcz4324zvg72udm@pengutronix.de>
In-Reply-To: <20220920155306.dvcz4324zvg72udm@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB6182:EE_
x-ms-office365-filtering-correlation-id: 528869f3-6a17-4ed8-d29c-08da9b29b17d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6YES5cXKc2qGEkWuy91EUcfeulDlfXjccnQCrHJGC+fCIWoB6eUMFW1M/SzWcAPFaGRMuyFLSp37vAWAmYM1a1VuojS+1BF/Qp3SgtZfdBtp8eyfCBrr+0gc2cAAemUkIzZtPfNLdOC4/MGCT5tWuHw0bEBV803JGIP/Yx+kX+7+vtNzMpHvWj5fcwE+X+zZ+/f8cm069kqVj3YCnudImS7DP8QZ6zfY7r88PrfnKe5eAzupl52ekflqYyzskws+vZzpCTDMvfrz4bIQJ4HERMOGTry6Wb6JBGWfiD5t+6C43CpvpNi+52f/BTyyW140Vde4FAcRaj8bcW0vq8Acv7eYtBW6/LiO0231uW8avw/2S7WfsdTFZBM8B/UR3FvtVc3fV270jfkoDpV1tNSSfcZyvKmjxTMCN7nKmef6MiqUWgzc1zZDHNxe//YCOVGw/fe+r6HJHv71eqnMAOM/NoMsvr8DpmD5jctR3VVu+aTynh+vaWnsSpDw7hIs3kNfQyweExqZLG9B+bRD7e7y+AGWpOnRydUxOL7bwF0PpxCTkwkSaO2OCM9+K94LBpFthI57wlmqqNYU+wldscMoVgGCBq4oB5jpdFfPFtk5nKH8cKAT7CIqhZjsYsOkcNaU3Uf2EBcMRL8JudNzHkPhqrqJ70m8X9szmqoAdXhhyNJYjasio930WXB88MqD6Sr8p1CXWoc83LCBX1imtzEEHkQ9C1EcARe6oWTeQoR0qGLyrIX+kmW7NU+wqce3dLMVZenEByuf9TUxRMBCEUSc/ASyA0XGITEfjALoVf0hM2w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199015)(55016003)(2906002)(38100700002)(122000001)(86362001)(4326008)(8676002)(64756008)(66446008)(66946007)(76116006)(66476007)(66556008)(66574015)(8936002)(54906003)(52536014)(5660300002)(316002)(6916009)(33656002)(186003)(478600001)(38070700005)(9686003)(26005)(83380400001)(7696005)(6506007)(966005)(71200400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?E55WAq5KmQgRS8tmiuw9+8IJqOh7czpDalzdtDRAiYxpd6mwaQT2+LwSDE?=
 =?iso-8859-1?Q?kroXyITRSIWOMA3giH1orAan0Wb1bLjvfcKspBYtA5RbjDi/LNF7zMhNbc?=
 =?iso-8859-1?Q?ux9+395d12Jr6GqB66/aGRYsUHZuiJA8xgD5VyY4/DAuFKFrn661EXx6Dh?=
 =?iso-8859-1?Q?p+85E/z5GkiNJw+9y6Py3XLff9hSMYI7CghIH6zFb40pP9lJPxulpMcJwv?=
 =?iso-8859-1?Q?vT4xp5zYClmaVSMTfuBhVgB+WcsQVCjGHvUtKOA1773U2uONnQC473gzgD?=
 =?iso-8859-1?Q?w7gBEtu9cZT5QHaby49Z4YNLC06xacvLGoRDNlo60O9cNay0oCyu6vaJsZ?=
 =?iso-8859-1?Q?EE6qtnPDkY8uAjHVcfGdsqHePvN2lHyJMMPbTOwr1xsUVwR+HnNsYRMpKJ?=
 =?iso-8859-1?Q?ItCSBz4v7pZoMzGqc8Aqi5zusI3xvpKDezplTpUJB7j5A6LhjV73AWZSgS?=
 =?iso-8859-1?Q?w3VgjU1kC371XHYn49DG9f0FJp84yg2AOE4Q00JtVERk4/NxMXkpMckj4O?=
 =?iso-8859-1?Q?Lau7eSUwI8fCdh77y/8O42JxDDpsPWcOtULPJoFIAWHKpAthpe4jvX1hb8?=
 =?iso-8859-1?Q?fpopZov1ffWKwqdhQIqYWX+hknxtfmoUu/xxfnx1D5EC3DyRoDzkRI9VkS?=
 =?iso-8859-1?Q?CpMSXnBPxvGigdp5rXQauFSoIjS8oP89E855BnKfIf2GDe9L7w496oa4KS?=
 =?iso-8859-1?Q?vSYTM60dcDC4OoGb3F7UbsweIGFOhHmbBdNoFAW/u/vkbkdY6OFPIQk6BY?=
 =?iso-8859-1?Q?YMslFREcslqinxxe/rCgfaiPOxOi5HEwEzqrUpZNfcFe0XbBpmvAo53J+4?=
 =?iso-8859-1?Q?m0CWbKCVA9zB0h3GbuU85bvCpODEdhCpTbl8z6UEdQwQplsrM+ClUBOaQt?=
 =?iso-8859-1?Q?QEBt7pHN5CMYGnHCklialENsva7RuvbAwe9/Q1aU3VHtiQxjwwE1DUIsSQ?=
 =?iso-8859-1?Q?m4ahy9w1oXicMtGvZ05XSXwdXyp83FLVh7fr/zRmGkarjuHiDB8PP6kd8X?=
 =?iso-8859-1?Q?qC0t/aalRiCFY4P6TaWv9G2Y8u9LQ8wzuUTua8NcIaqmzxJIn7o9NzbRFE?=
 =?iso-8859-1?Q?Lnw/DeJJ34mYUCoItRna26ATDA8UWG7EvbdwrO9lLfQ37dReS6l0Lkj2uw?=
 =?iso-8859-1?Q?6bSbzWsD0mEZWMxbFWJO+lPNlZftI0OeFEklgboOJaqe787EN0JV+CJCQE?=
 =?iso-8859-1?Q?b3bsQgGgaBycKGf1Ah1XcfT8bvfe3U91Uz5z0uXwqUyIFq5CLdB0LcDFax?=
 =?iso-8859-1?Q?PDOlxzxU/he/iXcVI7n+VBDZe7ZWfrpsbH6pPYggYxP5lC7a8QfwP/oZBe?=
 =?iso-8859-1?Q?RN3VmuJFOKYoKoj1ECvWMEFQ+e8E8RLf8QkUKTm40X3r7gbp9tm/dJ2YEr?=
 =?iso-8859-1?Q?xZNMf6LPzLl7kok5nwTPg0iWXkyCQW/ra6YslN3y3YT6vUJsf9lVpGsfJ1?=
 =?iso-8859-1?Q?id2QRlopFyrXRaBP4i4sh59GCQjhEBn965ahYacgnqgq7lbdCEfIhT7EoD?=
 =?iso-8859-1?Q?GITDt4kW4DgaNrzgSMGNjYm1gvB0bbH4R2JpJdOLf5zjxirl2JSfGBZG8t?=
 =?iso-8859-1?Q?Oh7D3qbHgbhDURJZxNEINF5trXmnzP/nvA3N5k+2LuV759bG82FHRzwpqf?=
 =?iso-8859-1?Q?gGVdT1MM1fPPtaxrTBgSw3eGaoA0JQDJlB+PxJ/rNOx4VuT7hAZVjjbw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 528869f3-6a17-4ed8-d29c-08da9b29b17d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 17:00:59.9807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cpBn0AYKNvbCykEtU8/NwfQ9qoWZZcQbDgfrnS6Q3yxN5miAcDhtaYqxcA185P8znXQTuKazmHLKabLhV2PIfKuXcaq1kFz3dsjibAVrPQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6182
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

> Subject: Re: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
>=20
> Hello,
>=20
> On Tue, Sep 20, 2022 at 03:31:16PM +0000, Biju Das wrote:
> > > On Mon, Sep 05, 2022 at 06:13:28PM +0100, Biju Das wrote:
> > > > +	if (period_cycles >=3D (1024ULL << 32))
> > > > +		pv =3D U32_MAX;
> > > > +	else
> > > > +		pv =3D period_cycles >> (2 * prescale);
> > >
> > > You're assuming that pv <=3D U32_MAX after this block, right? Then
> > > maybe
> > Yes, That is correct.
> >
> > >
> > > 	if (period_cycles >> (2 * prescale) <=3D U32_MAX)
> > >
> > > is the more intuitive check?
> >
> > Ok will add like below, so we support up to (U32_MAX * 1024); Is it
> ok
> > for you?
> >
> >   if (!(period_cycles >> (2 * prescale) <=3D U32_MAX))
> > +               return -EINVAL;
> > +
> > +       pv =3D period_cycles >> (2 * prescale);
>=20
> Not -EINVAL, using pv =3D U32_MAX is correct.

OK.

>=20
> > Same case for duty cycle.
> > >
> > > > +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle,
> > > > +rzg2l_gpt->rate, NSEC_PER_SEC);
> > > > +
> > > > +	if (duty_cycles >=3D (1024ULL << 32))
> > > > +		dc =3D U32_MAX;
> > > > +	else
> > > > +		dc =3D duty_cycles >> (2 * prescale);
> > > > +
> > > > +	/* Counter must be stopped before modifying Mode and
> Prescaler */
> > > > +	if (rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST)
> > > > +		rzg2l_gpt_disable(rzg2l_gpt);
> > >
> > > For v5 I asked if this affects other channels, you said yes and in
> > > the follow up I failed to reply how to improve this.
> > >
> > > I wonder how this affects other channels. Does it restart a period
> > > afterwards, or is the effect only that the currently running
> period
> > > is a bit stretched?
> >
> > If we stops the counter, it resets to starting count position.
>=20
> So if I update pwm#1, pwm#0 doesn't only freeze for a moment, but
> starts a new period. Hui.
>=20
> > >At least point that this stops the global counter and  so affects
> the
> > >other PWMs provided by this chip.
> >
> > We should not allow Counter to stop if it is running.
> > We should allow changing mode and prescalar only for the first
> enabled
> > channel in Linux.
> >
> > Also as per the HW manual, we should not change RZG2L_GTCNT,
> > RZG2L_GTBER while Counter is running.
> >
> > Will add bool is_counter_running to take care of this conditions.
> >
> > Is it ok with you?
>=20
> I'm torn here. Resetting the period for the other counter is quite
> disturbing. If you cannot prevent that, please document that in the
> Limitations section above.

I think, we should be able to prevent resetting the counter value
By not stopping it for the second channel. For second channel
We just update duty cycle and GTIO pins.

>=20
> > > > +	pm_runtime_get_sync(chip->dev);
> > > > +	val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR);
> > > > +	state->enabled =3D val & RZG2L_GTCR_CST;
> > > > +	if (state->enabled) {
> > > > +		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);
> > > > +
> > > > +		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR);
> > > > +		tmp =3D NSEC_PER_SEC * val << (2 * prescale);
> > >
> > > This can overflow.
> >
> > OK will use inverse calculation to avoid overflow.
> > mul_u64_u32_div(val << (2 * prescale), NSEC_PER_SEC, rzg2l_gpt-
> >rate);
> >
> > Is it ok?
>=20
> It uses the wrong rounding direction :-\ Using
>=20
> 	tmp =3D NSEC_PER_SEC * (u64)val << (2 * prescale);
>=20
> should be enough to fix the problem I pointed out.

OK, Thanks for the pointer.

Cheers,
Biju

>=20
> > > > +		state->period =3D DIV_ROUND_UP_ULL(tmp, rzg2l_gpt-
> >rate);
> > > > +
> > > > +		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(pwm-
> >hwpwm));
> > > > +		tmp =3D NSEC_PER_SEC * val << (2 * prescale);
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 |
> https://www.pengutronix.de/ |
