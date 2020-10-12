Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D1A28C205
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Oct 2020 22:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgJLUEx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Oct 2020 16:04:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:53224 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgJLUEx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 12 Oct 2020 16:04:53 -0400
IronPort-SDR: tzvT8f/FMClJ/DrY0tELAkFdh7m+kT6uJYAer3KQ4iAQWjUkPo0okhuIJK5mmwguKJl+xdTHnj
 uRBspfrBUMIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165857222"
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="165857222"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 13:04:50 -0700
IronPort-SDR: tPS9AjO6MS7HjdrdW38zQ+mUyhlfL0SlIMP66AHNUMYI55QaVu3yxCmZaZ9V3GsG8WDgnDND3l
 m8U5NlKtSvkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="313558051"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 12 Oct 2020 13:04:50 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 12 Oct 2020 13:04:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 12 Oct 2020 13:04:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 12 Oct 2020 13:04:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nkw8NbvHudcHoi99w8AzHAqCqhzdfa+hrEDtUS1HxnMM/r94Z4VRXY4ZEuqzvmqEiWyTjaUwvcFOy9ooNMOtkIwPGAHorfgw812g7lNMh4cC3Kw/JkMWBxh7nufjroXo/qu9tfGp4m6AVh++nLI0iBxpaJF2esfVeZtgY1QtDbACu25BpdE4tT25Y9waR+VSpoOBTMUBtewR9gWIC7Ue4bkMldr8bFYwd2qF/SgzVNo/k5gdySeAQ/EYrjSgy8UmeaKoSylpfBLN8DR93iFqL0kQOQBxGiejzQ6StFb1Dper7KG/WeBevYtI97+nFlqO/me9i+YVXlo+QsRfySLU1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXz6iIcKo+ba/6xaWBMzRvg3tX6uGDy+RnXSUl9aOuY=;
 b=FvvnKfIUX0lADS2hNkk74Wg69FAKI5bnBJacyIaec/v9qRCjq7wRx0DS84XMQJ7NvRbIaNH4cH4A0khspVcUROIb0iY6KmDAcJgPjU1sZvjFEa3eJ/Dm4D2IZ/pWOwIq66BXXxe7SUt0KVJsqGAkX1pfnox28Lni9czC8XpUWIu6zbIh0ODYdLvDJot0i7yRDi0y3wF0Gse3g1OFeSKv5YQpsNs8bN7K2pt2U6AjUMNCZ8xC0Kb6dWAjUETOWlrYWlMKHD/UFccE1SucHirPo4vLfcjSOCbAC/SpW2jYdOyilA19of9DuXkBfTjidegYHW24x4z7RYOkJVppA3eI2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXz6iIcKo+ba/6xaWBMzRvg3tX6uGDy+RnXSUl9aOuY=;
 b=H6YssV++NS/YFoBwkKfyhSbRSW29XfeBDb3tchObhWZlWX5cv2mUZADyX0ZORQ335e9NxPfR1hBmJmvo9hvC1q38WqMmnzp0Hfl+LUqdtJFz9xF5hYRMcDo/3Wd2lr4CCN+p5u6x2Fw8wqNtWEqzhFXAZ7TYvPpgHN7YZORmLZU=
Received: from DM6PR11MB4250.namprd11.prod.outlook.com (2603:10b6:5:1df::18)
 by DM6PR11MB3577.namprd11.prod.outlook.com (2603:10b6:5:137::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Mon, 12 Oct
 2020 20:04:47 +0000
Received: from DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::7448:c067:e80d:3c09]) by DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::7448:c067:e80d:3c09%3]) with mapi id 15.20.3455.030; Mon, 12 Oct 2020
 20:04:47 +0000
From:   "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: RE: [PATCH v10 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Topic: [PATCH v10 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Index: AQHWnNpnAcsmnD9gzEyxRo255sUQh6mMn0AAgAe/gwA=
Date:   Mon, 12 Oct 2020 20:04:47 +0000
Message-ID: <DM6PR11MB42507C555C3F183ED6EB98ADFB070@DM6PR11MB4250.namprd11.prod.outlook.com>
References: <cover.1602090900.git.vijayakannan.ayyathurai@intel.com>
 <a8cb129092283cb6415e56b928293ef7121a851b.1602090900.git.vijayakannan.ayyathurai@intel.com>
 <20201007205734.vguookvp6wt3knuq@pengutronix.de>
In-Reply-To: <20201007205734.vguookvp6wt3knuq@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.111.146.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f857687-127a-4a2b-9265-08d86eea1221
x-ms-traffictypediagnostic: DM6PR11MB3577:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB357762F7F7B5CCF9267C2188FB070@DM6PR11MB3577.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PsrBHuWnExFk9zcwydvXlomEZDhwGym+Dvy7gV5nKasK1egV3CXyAtnFyeybvJxfE1HYb/y5M5ZO/NvMGZ5tg4KpXtKpzSz3isbJiTHxeCiUYP7y8+yQhhhCNhRPb+/LNXiC/ff0EFuDo8ceywgZPrrCfBP6AHN9zeaM025LHySWHoC7EzD+d+GmEah828TSn+hVhGQovuZP326Fvn0dUlcPIBBtHT0z6T/A3AyBiMm9sxr0Chq7Ofavhz6QlTdjfsjOWftTWj2Zf6wnpMm2Hkn3KXPkWPI9eBhUwdXOB50wxsdTZ3stDZvkkDrndgIRl23EQCAIYZXr+rXVW/b3oCFjrQhBcTqRdkp+CYVMOXE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4250.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(33656002)(5660300002)(66946007)(76116006)(64756008)(4326008)(86362001)(66574015)(83380400001)(66446008)(66556008)(66476007)(52536014)(478600001)(966005)(2906002)(316002)(6916009)(186003)(8936002)(26005)(55016002)(7696005)(8676002)(54906003)(53546011)(6506007)(9686003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: RQ7XuYUooCX+hdedvREC799g/AwyvaPjUsXrD+02CbG39wPgESInY0qQrMXhA9yaAdG8IucUnhQqPzaKy4GI4MNUlNZ29jPBq8H9/+1oZQA/mokb0naTAhuh8voIpNGXGoAtFoW2a1sBv9sWu7DQzf9kaZ9FbR4p1zJLY/uqYFMP6m+Aa0b6NUDoVho4L9Is+VQfuTt8ql2oU1HUgj/c7XJTN7MqePMaNibajwnekpty0nKYMOmeQnbh57tNOujoZO6e8QbJxWLMf1MZ7GVrpQQz7G/ONMiG2GOOEjtWiEgFntnz7Ot3cg5MXCL3F0I5bv7LAEBU43NOg9I+Ti+mI8gZGAAttAN1lRUsADDVu+OVzuKvmfR0gX66JDQJ8ECzsfs9c+4yY9fj0QNR2zsOK+RyvchshWYtO2wx6BUiLLKLxUwEggKPCBG8X9x9oSf3E3LOXPJ/OS4CfvHhxao9Z8kjEX2VP8PwdKjYWK2SQUzbX8WrPX4Q342e8q1lPKj1VH9MN394HXg4DiEDd1Q7FJTjLom7HzMqH4kshfJRIhNxX0QrQNHrPxJJsbBzq1tgewq1aRWjb4E5+DWM7qF96dlQGJ1b/0Fdff07pgyf6CW7hYpAWNaQgYRVtp/dY2vlMCuS/1eonyEsneZTU4SJxA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4250.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f857687-127a-4a2b-9265-08d86eea1221
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 20:04:47.5849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eangFgdp2bGnPYNAqIaC6NL8UqQ3zIB2wCvNORp8fq2WVSlH2bEVYJrN1Gvqa1SvcKagB6vjgY4gB72VMOsw8LAjRhrQXZyB0ors0gub/HpIK2tK9UuvKS4IocvMrHo3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3577
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,
Thank you for constructing example to explain the review comment.

-----Original Message-----
From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>=20
Sent: Thursday, 8 October, 2020 2:28 AM
Subject: Re: [PATCH v10 1/2] pwm: Add PWM driver for Intel Keem Bay

Hello,

On Thu, Oct 08, 2020 at 01:40:30AM +0800, vijayakannan.ayyathurai@intel.com=
 wrote:
> +static int keembay_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     const struct pwm_state *state) {
> +	struct keembay_pwm *priv =3D to_keembay_pwm_dev(chip);
> +	struct pwm_state current_state;
> +	u16 pwm_h_count, pwm_l_count;
> +	unsigned long long div;
> +	unsigned long clk_rate;
> +	u32 pwm_count =3D 0;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -ENOSYS;
> +
> +	keembay_pwm_update_bits(priv, KMB_PWM_LEADIN_MASK, 0,
> +				KMB_PWM_LEADIN_OFFSET(pwm->hwpwm));
> +
> +	keembay_pwm_get_state(chip, pwm, &current_state);
> +
> +	if (!state->enabled) {
> +		if (current_state.enabled)
> +			keembay_pwm_disable(priv, pwm->hwpwm);
> +		return 0;
> +	}
> +
> +	/*
> +	 * The upper 16 bits of the KMB_PWM_HIGHLOW_OFFSET register contain
> +	 * the high time of the waveform, while the last 16 bits contain
> +	 * the low time of the waveform, in terms of clock cycles.
> +	 *
> +	 * high time =3D clock rate * duty cycle
> +	 * low time =3D  clock rate * (period - duty cycle)
> +	 */
> +
> +	clk_rate =3D clk_get_rate(priv->clk);
> +	/* Configure waveform high time */
> +	div =3D clk_rate * state->duty_cycle;
> +	div =3D DIV_ROUND_DOWN_ULL(div, NSEC_PER_SEC);
> +	if (div > KMB_PWM_COUNT_MAX)
> +		return -ERANGE;
> +
> +	pwm_h_count =3D div;
> +	/* Configure waveform low time */
> +	div =3D clk_rate * (state->period - state->duty_cycle);
> +	div =3D DIV_ROUND_DOWN_ULL(div, NSEC_PER_SEC - pwm_h_count);

In reply to your v7 I suggested the example:

	clk_rate =3D 333334 [Hz]
	state.duty_cycle =3D 1000500 [ns]
	state.period =3D 2001000 [ns]

where the expected outcome is

	pwm_h_count =3D 333
	pwm_l_count =3D 334

. Please reread my feedback there. I tried to construct an example where th=
e value is more wrong, but with the constraint that pwm_h_count must be <=
=3D KMB_PWM_COUNT_MAX this isn't easy. The best I could come up with
is:

	clk_rate =3D 1000000000
	state.duty_cycle =3D 65535 [ns]
	state.period =3D 131070 [ns]

where the right value for pwm_l_count is 65535 while you calculate
65539 (and then quit with -ERANGE).

I have applied the formula mentioned in v7 and got different duty cycle res=
ult then what was expected.=20

Formula referred by Uwe at v7:
pwm_l_count =3D (clk_rate * state->period) / NSEC_PER_SEC - pwm_h_count

%	clk_rate	period		duty_cycle	NSEC_PER_SEC	pwm_h_count		pwm_l_count
50%	333334	2001000	1000500	1000000000		333			667
25%	500000000	20000		5000		1000000000		2500			10000
50%	100000000	131070	65535		1000000000		6553			13107


Whereas the below table is the result of minor modification from your formu=
la and getting the right result.
pwm_l_count =3D clk_rate * (state->period - state->duty_cycle) / NSEC_PER_S=
EC - pwm_h_count

%	clk_rate	period		duty_cycle	NSEC_PER_SEC	pwm_h_count		pwm_l_count
50%	333334	2001000	1000500	1000000000		333			333
25%	500000000	20000		5000		1000000000		2500			7500
50%	100000000	131070	65535		1000000000		6553			6553

Please review this and confirm.
=20
> +	if (div > KMB_PWM_COUNT_MAX)
> +		return -ERANGE;
> +
> +	pwm_l_count =3D div;
> +
> +	pwm_count =3D FIELD_PREP(KMB_PWM_HIGH_MASK, pwm_h_count) |
> +		    FIELD_PREP(KMB_PWM_LOW_MASK, pwm_l_count);
> +
> +	writel(pwm_count, priv->base + KMB_PWM_HIGHLOW_OFFSET(pwm->hwpwm));
> +
> +	if (state->enabled && !current_state.enabled)
> +		keembay_pwm_enable(priv, pwm->hwpwm);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops keembay_pwm_ops =3D {
> +	.owner =3D THIS_MODULE,
> +	.apply =3D keembay_pwm_apply,
> +	.get_state =3D keembay_pwm_get_state,
> +};
> +
> +static int keembay_pwm_probe(struct platform_device *pdev) {
> +	struct device *dev =3D &pdev->dev;
> +	struct keembay_pwm *priv;
> +	int ret;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to get=20
> +clock\n");
> +
> +	ret =3D clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base)) {
> +		clk_disable_unprepare(priv->clk);
> +		return PTR_ERR(priv->base);
> +	}
> +
> +	priv->chip.base =3D -1;
> +	priv->chip.dev =3D dev;
> +	priv->chip.ops =3D &keembay_pwm_ops;
> +	priv->chip.npwm =3D KMB_TOTAL_PWM_CHANNELS;
> +
> +	ret =3D pwmchip_add(&priv->chip);
> +	if (ret) {
> +		dev_err(dev, "Failed to add PWM chip: %pe\n", ERR_PTR(ret));
> +		clk_disable_unprepare(priv->clk);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}
> +
> +static int keembay_pwm_remove(struct platform_device *pdev) {
> +	struct keembay_pwm *priv =3D platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(priv->clk);
> +
> +	return pwmchip_remove(&priv->chip);

You have to call pwmchip_remove first. Otherwise you're stopping the PWM wh=
ile the framework still believes everything to be fine.

I will incorporate the change in next version.

> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            =
|
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
