Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C769B2C7B56
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Nov 2020 22:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgK2VQC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Nov 2020 16:16:02 -0500
Received: from mail-mw2nam10on2067.outbound.protection.outlook.com ([40.107.94.67]:7925
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726293AbgK2VQB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 29 Nov 2020 16:16:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCPTW1Y7mygRx7R3e4/VhNj8dzvP9C/TLYBUgbQgUSHwQo39xaPm1nSrPWikKYDRVQ4CryRAFZyPuXegOnzLnzOYsTdmhs2H3o+qu8xDgt7dqezbhujY3Uuu42Q4pDgxzQaNB8zd1BljJIE6DsyRR9m7IJMrAPtir4li41waoivtvB4SNTRRPgZxFgyvIS2veHTXuL2r72Pv0rxrPvELC90diAwjKDxI51OqFSbsJtfmJAnoynM5S6RuyXnTeIYge27UAHXis91rMrYawaCmg+D9U3FZUBK7TQTqNC6oLe1QerMR+DgaSXlDARmThM2NduDbQAxzYvQ2KqVpHErjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1cbiVVd/NbJe9iYt6zkWzAxIDKczyrO+qh7Qe6l81E=;
 b=KOcvT1AI7rkNVQPYcoe2yRxrOrTQGQoUTAm80DOMFOMSG9mQT9zxpSuLVkneBRvuBMjPkFwpNl8cTiTE+D4Rzq+uaUZ4/VKBmb7tGxiZsGXtUA0CkMt40R1rsCk3YGPypnLW4nRpd1o/0waQa6CZ1izshnlTSBd5e3YrNtA59wdMq8RQM24KoVwxePj2c+GM1WiF0RlPsHXCx/tBfeeu0xLImQcF2CEsEoA17SJ6jp9EjSjZ9JJvsQtnttjR6xYp3N0dGOT/2OMAIkVF+IPL0SWshgM4D3dEVLNbc4vmTWVpKgCXf+x2+XOhGIR4P68oZRqnJB0ENTSj9Q5/D42KWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1cbiVVd/NbJe9iYt6zkWzAxIDKczyrO+qh7Qe6l81E=;
 b=TV4CPS1g9OZvbX2n98g7Wn8/GeFZjA5/xS2/hN9YP2zyY0U2NPhtHb5IrSpFWJbi0ICcs7pOSXHd85tcjCwPCXxOAShRMFo+plLuM9IcTNZeuCxLw7H0DQeS4OfkSvc9hH5P+5ctjHFh8dWPMkJmW/QGMJLr8/4rEndoecMt5tE=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=labundy.com;
Received: from SN6PR08MB5517.namprd08.prod.outlook.com (2603:10b6:805:fb::32)
 by SN6PR08MB4223.namprd08.prod.outlook.com (2603:10b6:805:2d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Sun, 29 Nov
 2020 21:15:08 +0000
Received: from SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::1c46:3d4c:10eb:1219]) by SN6PR08MB5517.namprd08.prod.outlook.com
 ([fe80::1c46:3d4c:10eb:1219%4]) with mapi id 15.20.3611.031; Sun, 29 Nov 2020
 21:15:07 +0000
Date:   Sun, 29 Nov 2020 15:15:00 -0600
From:   Jeff LaBundy <jeff@labundy.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de
Subject: Re: [PATCH v2] pwm: iqs620a: Fix overflow and optimize calculations
Message-ID: <20201129211500.GA4771@labundy.com>
References: <20201127201051.GA32257@labundy.com>
 <20201127203244.3439478-1-uwe@kleine-koenig.org>
 <20201128010040.GA9235@labundy.com>
 <20201129120318.gh2vv2x44amk3di2@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201129120318.gh2vv2x44amk3di2@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [136.49.227.119]
X-ClientProxiedBy: SN6PR2101CA0001.namprd21.prod.outlook.com
 (2603:10b6:805:106::11) To SN6PR08MB5517.namprd08.prod.outlook.com
 (2603:10b6:805:fb::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from labundy.com (136.49.227.119) by SN6PR2101CA0001.namprd21.prod.outlook.com (2603:10b6:805:106::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.2 via Frontend Transport; Sun, 29 Nov 2020 21:15:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1263a0f3-cb1c-4277-c091-08d894abd918
X-MS-TrafficTypeDiagnostic: SN6PR08MB4223:
X-Microsoft-Antispam-PRVS: <SN6PR08MB4223BB7FB357C1437A838CB9D3F60@SN6PR08MB4223.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJJ1LF9tM9BniIG4RYF/BqIRlC6wCcD2nEJH4zAUmJg3w42ypbh2pCICrT/AggtNWNNR2tbv082tYgirApSV0lXl/VtgnmM2pP/YK4+IxfMdYahauvNKSkM1EuT0BihxjYjBGWIunbdmtbSq50XGmiX0SOGqGsWZS/fcV5Ilgl+Tq/Tqg5bUspirRDbefAc1t64ezEIVOPLhEz80oJfhJrB+qSzuIZ69h6aURpoMP2+at0UgQ+PKvb3FA/1Kb6ZmNxtKia5cJDN2dQI853DR+Jj9eWkjYfuqpRpIt8aiosQ241Su879pSQV65ttiwVJuDe2l3cQsFPfJjTvYg8rSdcP5SdQ+7VryXFpRw+mtn+7iHg+q67oRq7gEfY1Bqm4o0PRp2PLQfYaBBJfRWedmuOZZ6lRdoesGxZ0Fizl+lYsvHmJKOtKs3z/+s7gEw2lqQVGuCSZIwEt2zZ6TRjO9Cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5517.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39830400003)(346002)(136003)(2616005)(956004)(8886007)(4326008)(86362001)(16526019)(8676002)(966005)(1076003)(55016002)(83080400002)(8936002)(6916009)(2906002)(6666004)(52116002)(7696005)(478600001)(26005)(316002)(5660300002)(36756003)(54906003)(83380400001)(66574015)(33656002)(66476007)(66556008)(66946007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?ebubYGlYVAO39WxrvExCLbkYAEMn3rtDw1DfSwdnKokeO4iMMPlD+PDk11?=
 =?iso-8859-1?Q?ahdtUhLRrdUJSeXKEkjOVdoVU8TogcRAtvy9VpkdhFt7HN6OCkjgE0yxKs?=
 =?iso-8859-1?Q?K4gRUoOpKvTr9WUuFzhwBEfXI0MAcMQNJusUB+cEzfK2VkH6v6X9pHFHnc?=
 =?iso-8859-1?Q?XIUvzBrabLscsRv2vNz+8/SgzttmrorMC9sd8TapkQ+llz/x2d8Jo4z4se?=
 =?iso-8859-1?Q?IH5/LUHee70N35+0ID+AX1dNA2QTaRyFZulH4+cqb22EIoqOBl30ECgX6R?=
 =?iso-8859-1?Q?7ARonSs8QaaBF8qQeBkZR1kNYAQhwAwQ4rOb5JVYrBQTx1cnnwdVbnOkAF?=
 =?iso-8859-1?Q?0Q1iZrz5gxv1GuHl8v4tvz7IH78CCA0skg5r73UlqeQBh7+NSI2L5GUH5T?=
 =?iso-8859-1?Q?d0ZhmrfmOPMI4KfoHK5SSjHqU3hL/U8C2UDzxKV8Jv0elXOFtJ0CV0Ecwe?=
 =?iso-8859-1?Q?k8HR8Eqxv5Lcq8nzxF+eIJb29JkYnTFWg4VE7NEtEu1V8hie6bOm1lXI0N?=
 =?iso-8859-1?Q?Ss3wu8gTQ5a1VC/hb0brwVjESJSNav9pP+5OkwM9JUvTfdij0GQMUfBUOx?=
 =?iso-8859-1?Q?5tiiC3wJdPEfHKHZcvgQ6Xp89552wksvgwrok1zMTlH94vd2xSPlmAxjZ0?=
 =?iso-8859-1?Q?Ls3Sl2yK4EbxP9ygB1V3l7wTiBTkCj3BnlPuAjV1nzn3a3AU7hqd5YHaFA?=
 =?iso-8859-1?Q?zeRJDWrvDK/YOIG4/jTEvPkEsv1vHAe/YNRizuOPlj3mRhh047OwtNQj31?=
 =?iso-8859-1?Q?+Dg993qoco/1tINlnNYv5zfa4ZOCsgLs3EGm9rtosK0nxKOAp0KnFKd936?=
 =?iso-8859-1?Q?SM/cITQVnpy9zo212jmYKVnVBGXF0pMB2TwTB9VmD5YIMLySdlzQ47H3Ml?=
 =?iso-8859-1?Q?3AHqdPLvua/V0emh/dBEqay8TbpFuO6MmmIbCfY8a3Jv39TvXsIz4jidjW?=
 =?iso-8859-1?Q?CE76ZmTRidQrgQ/srjxf3dVPJ94zjfLqyXNdlxPz+uFX/xELqqyNP3L3Yn?=
 =?iso-8859-1?Q?jN3T+griGbf6Xl01WCqJg8X2IVQBDUtYr5fWXD?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1263a0f3-cb1c-4277-c091-08d894abd918
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5517.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2020 21:15:07.7220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dCX53D7Erz47hy4Xcezyx2OsRmPOg4NxmnrzdshgFAAo0BsMrq4mgTVe24nDEQH2uoPHD3+WkvYvYXLX8FNYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4223
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Sun, Nov 29, 2020 at 01:03:18PM +0100, Uwe Kleine-König wrote:
> On Fri, Nov 27, 2020 at 07:00:40PM -0600, Jeff LaBundy wrote:
> > Hi Uwe,
> > 
> > Thank you for your work on this; a few comments below.
> > 
> > On Fri, Nov 27, 2020 at 09:32:44PM +0100, Uwe Kleine-König wrote:
> > > From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > 
> > > If state->duty_cycle is 0x100000000000000, the previous calculation of
> > > duty_scale overflows and yields a duty cycle ratio of 0% instead of
> > > 100%. Fix this by comparing the requested duty cycle against the maximal
> > > possible duty cycle first. This way it is possible to use a native
> > > integer division instead of a (depending on the architecture) more
> > > expensive 64bit division. Also duty_val cannot be bigger than 0xff which
> > > allows to simplify the code a bit further down.
> > > 
> > > Fixes: 6f0841a8197b ("pwm: Add support for Azoteq IQS620A PWM generator")
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Hello Jeff,
> > > 
> > > On Fri, Nov 27, 2020 at 02:10:51PM -0600, Jeff LaBundy wrote:
> > > > I tested this patch on actual hardware but the newly calculated register
> > > > values are incorrect. We used to get:
> > > >
> > > > [...]
> > > > >                     goto err_mutex;
> > > > >     }
> > > > >  
> > > > > -   if (duty_scale) {
> > > > > -           u8 duty_val = min_t(u64, duty_scale - 1, 0xff);
> > > > > -
> > > > > +   if (duty_val) {
> > > > 
> > > > This is part of the problem; the device's formula for duty cycle has a
> > > > plus one that is getting dropped now (see comments in iqs620_pwm_apply).
> > > 
> > > Good catch, I indeed missed that - 1.
> > > 
> > > This patch should be better in this regard.
> > > 
> > > Thanks for particular attention and testing,
> > > Uwe
> > > 
> > >  drivers/pwm/pwm-iqs620a.c | 18 ++++++++++--------
> > >  1 file changed, 10 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
> > > index 7d33e3646436..6789e117f123 100644
> > > --- a/drivers/pwm/pwm-iqs620a.c
> > > +++ b/drivers/pwm/pwm-iqs620a.c
> > > @@ -46,7 +46,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > >  {
> > >  	struct iqs620_pwm_private *iqs620_pwm;
> > >  	struct iqs62x_core *iqs62x;
> > > -	u64 duty_scale;
> > > +	u8 duty_val;
> > >  	int ret;
> > >  
> > >  	if (state->polarity != PWM_POLARITY_NORMAL)
> > > @@ -70,29 +70,31 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > >  	 * For lower duty cycles (e.g. 0), the PWM output is simply disabled to
> > >  	 * allow an external pull-down resistor to hold the GPIO3/LTX pin low.
> > >  	 */
> > > -	duty_scale = div_u64(state->duty_cycle * 256, IQS620_PWM_PERIOD_NS);
> > > +
> > > +	if (state->duty_cycle < IQS620_PWM_PERIOD_NS)
> > > +		duty_val = ((unsigned int)state->duty_cycle * 256) / IQS620_PWM_PERIOD_NS;
> > > +	else
> > > +		duty_val = 256;
> > 
> > The build gives a warning here since duty_val is a u8. Actually, I'm not
> > a fan of calling this 'duty_val' since it has a different meaning than
> > iqs620_pwm->duty_val (the cached version restored if the watchdog bites).
> 
> Argh, that's what you get if you want to just quickly get out a patch
> :-\ Thanks again for your attention.
> 
> > >  	mutex_lock(&iqs620_pwm->lock);
> > >  
> > > -	if (!state->enabled || !duty_scale) {
> > > +	if (!state->enabled || !duty_val) {
> > >  		ret = regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
> > >  					 IQS620_PWR_SETTINGS_PWM_OUT, 0);
> > >  		if (ret)
> > >  			goto err_mutex;
> > >  	}
> > >  
> > > -	if (duty_scale) {
> > > -		u8 duty_val = min_t(u64, duty_scale - 1, 0xff);
> > > -
> > > +	if (duty_val) {
> > >  		ret = regmap_write(iqs62x->regmap, IQS620_PWM_DUTY_CYCLE,
> > > -				   duty_val);
> > > +				   duty_val - 1);
> > >  		if (ret)
> > >  			goto err_mutex;
> > >  
> > >  		iqs620_pwm->duty_val = duty_val;
> > >  	}
> > 
> > This would need to change to iqs620_pwm->duty_val = duty_val - 1, otherwise
> > the wrong duty cycle will get restored in iqs620_pwm_notifier. However this
> > starts to look confusing.
> > 
> > >  
> > > -	if (state->enabled && duty_scale) {
> > > +	if (state->enabled && duty_val) {
> > >  		ret = regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
> > >  					 IQS620_PWR_SETTINGS_PWM_OUT, 0xff);
> > >  		if (ret)
> > > -- 
> > > 2.29.2
> > > 
> > 
> > How about the patch below instead? It solves the overflow problem you found,
> > is minimally invasive and preserves the original intent. We still avoid the
> > 64-bit division which is unnecessary anyway given this device's fixed period
> > of only 1 ms.
> > 
> > Kind regards,
> > Jeff LaBundy
> > 
> > diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
> > index 7d33e36..a15a2aa 100644
> > --- a/drivers/pwm/pwm-iqs620a.c
> > +++ b/drivers/pwm/pwm-iqs620a.c
> > @@ -46,7 +46,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  {
> >  	struct iqs620_pwm_private *iqs620_pwm;
> >  	struct iqs62x_core *iqs62x;
> > -	u64 duty_scale;
> > +	unsigned int duty_scale;
> >  	int ret;
> >  
> >  	if (state->polarity != PWM_POLARITY_NORMAL)
> > @@ -70,7 +70,9 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  	 * For lower duty cycles (e.g. 0), the PWM output is simply disabled to
> >  	 * allow an external pull-down resistor to hold the GPIO3/LTX pin low.
> >  	 */
> > -	duty_scale = div_u64(state->duty_cycle * 256, IQS620_PWM_PERIOD_NS);
> > +	duty_scale = (unsigned int)min_t(u64, state->duty_cycle,
> > +					 IQS620_PWM_PERIOD_NS) * 256 /
> > +					 IQS620_PWM_PERIOD_NS;
> 
> I had problems parsing this. I'd prefer:
> 
> 	if (state->duty_cycle < IQS620_PWM_PERIOD_NS) {
> 		unsigned int duty_cycle = state->duty_cycle;
> 		duty_scale = state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS;
> 	} else {
> 		duty_scale = 256;
> 	}
> 
> or maybe:
> 
> 	unsigned int duty_cycle = min_t(u64, state->duty_cycle, IQS620_PWM_PERIOD_NS);
> 	duty_scale = state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS;
> 
> (which depending on how clever the compiler is might be less effective
> than the first suggestion).

I prefer the second option because duty_scale is assigned only once. This
way the duty_scale = 256 case falls out of the equation naturally without
having to be hard-coded.

One minor correction: you will want to use the local (clamped) duty_cycle
rather than state->duty_cycle for the second option. It is not needed for
the first option.

> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |

Kind regards,
Jeff LaBundy
