Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F4E251383
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Aug 2020 09:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgHYHqr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Aug 2020 03:46:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:7987 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgHYHqq (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 25 Aug 2020 03:46:46 -0400
IronPort-SDR: uEqmwbz+9LojJMvRggajQdp957xj7Haayt09j5TtnrJeodEGDteuERoVGicTjQqjFD6eSYkyKS
 utWlzpNCP45A==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="156058451"
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="156058451"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 00:46:44 -0700
IronPort-SDR: LJaXywChxPd6k4tqvuJ4xFUN7OHgzFHZsLUSUbJ5jDlzI5aPd97bhp3tgnsUhYsQ9GoYsnBwi2
 a4TiYzNM+Zlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="443542002"
Received: from orsmsx601-2.jf.intel.com (HELO ORSMSX601.amr.corp.intel.com) ([10.22.229.81])
  by orsmga004.jf.intel.com with ESMTP; 25 Aug 2020 00:46:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 25 Aug 2020 00:46:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 25 Aug 2020 00:46:43 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.50) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 25 Aug 2020 00:46:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T46nqw7Bx2KAyVLfHum9ifB7PnUEyWc2KRc4pmgyMaKOH9+4A/UQvuin+acyOBUApmhHKkJUn6IGBEj6pA9MGpSa3FiNFp2TC11EBsA5A7yd9g8zSNxk63el7qWipn4nMxKdHAwLQhOZ92y23Bs+h44aK9pJkqCDv6GEL9rTzeyVdIPfog4kJCYd636JRJx/YWpWsQCE/w6W7p7xTgGibWHLpO2V9cGav6znQyR/8LLwnAn5req8nERi79Ja0G/yT73CCrs80ubkgs8J1OlzzH1pOmaFwWEnFOKOWTPAK4LTy3pDVCqx2fj9SLn0K9MCfc43rC60GNO94R6PcbkWPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFrCFRgbKELb64Uc+pLB2s8pf5CrkTFwGSzcd+mSWXk=;
 b=JnYQ7iXRBT3V3ZNHsqnhWVQMluDDHipL4tygIlG5UuEy6jAf/DN+524aRhBLx0VkUYOOkhDHLZoXAa+2I2sKlakQATYjYcTq3Du0XuHE583U7cShM+igTzW69da4UtnlQiihrmQ30D2n/C3Fq2ewOnhTHa3LfdnKLvQ756NHUdxXLEGr5iLOhTaQo9+HIYhHwHacj+PI8ptZLWh24Dgu3apqp7c0VOvcmjRbYFFTFmOWF9LlKTTxysJxrQOd7fK03rUIDsWDz1Ufksec4j+1icpax+7HHj4HBETY43MlBg9ktK849ws2/xIXsLATq79QFXk62WwODZqGp4Xwy2gMwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFrCFRgbKELb64Uc+pLB2s8pf5CrkTFwGSzcd+mSWXk=;
 b=OZKFsb8LEjhblAkmLUuBhqFLMv/4czHxWepso9DiXUxrCx4y8OlOkY7hmS3SXpDanrbd1ABs9wHHGrzlSEOs7hLkdE121Kr8z1e091hlkRa75kY1YF7nj/9X50E+BNmZOAv0I5VzNLHaOvC1tM4Ah3NJhQf/97IgGgMcI+nBu0w=
Received: from SN6PR11MB2575.namprd11.prod.outlook.com (2603:10b6:805:57::20)
 by SN6PR11MB2829.namprd11.prod.outlook.com (2603:10b6:805:62::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 25 Aug
 2020 07:46:41 +0000
Received: from SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::6407:40fd:19e3:e270]) by SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::6407:40fd:19e3:e270%7]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 07:46:41 +0000
From:   "G Jaya Kumaran, Vineetha" <vineetha.g.jaya.kumaran@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: RE: [PATCH v4 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Topic: [PATCH v4 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Index: AQHWeJEW5nX/PDGTyUqcgDnOs9O82KlG5fkAgAFzlxA=
Date:   Tue, 25 Aug 2020 07:46:41 +0000
Message-ID: <SN6PR11MB25756879B956FD79276ED4A9F6570@SN6PR11MB2575.namprd11.prod.outlook.com>
References: <1598106646-16595-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1598106646-16595-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <20200824075246.GZ1891694@smile.fi.intel.com>
In-Reply-To: <20200824075246.GZ1891694@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [161.142.240.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09cd8d5d-937e-49de-3e4f-08d848cb01db
x-ms-traffictypediagnostic: SN6PR11MB2829:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB28290A91F428C39B09934887F6570@SN6PR11MB2829.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Emf4DGfLtYWzN4EYE1bBckIzfNJ+59aXsygzXC5TKDjslwxsCHFRChJ5fdRUTcFgfmOsMbAxOw1oaDU8DapCekkksJ3MC1PWqTamhZwmz5j1UMf7dOtXC+vff94/TDidnO3O3lSz/o/PbRjzszyP/x17lWLc7XBWaEAemlzPCZZU9zDnctwPYY1zaHsP4gzRrJKHmuej6/J787e9I9ZDS4xKc6aZzXMV7ILQ811jm2bcGXhnsDXzxnDiNjiAarBcc7mWAcD7+8iHaxuWYu3ChY0BRlc8fGiMUn/bhYq+Fz0ZnyARmm8jHEudaDaBbGdoih4/lqOjBELAbpdqzj5oQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2575.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(2906002)(71200400001)(76116006)(9686003)(86362001)(478600001)(6506007)(66446008)(54906003)(4326008)(186003)(55016002)(64756008)(5660300002)(7696005)(8676002)(83380400001)(26005)(66556008)(6916009)(66476007)(53546011)(33656002)(52536014)(66946007)(316002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 0n4ds24cMOYMuIj5qJhjN9UBy91jwxHszCjd+F+ngyeYQOnh8Bh73hhRFqj9PAJErWqgi7csmn8vfgCGgVb6xyyz5aHBDuwv31gdLEiuNQGlx7Q1XGnLjRpIboy8W0Pc7eaCkBmr8UPVrQhqTr4jUKarmEtFYtBN1/TEHws1OQDysPqHtMzXpFYMGr5VNrtFkRmip0cgbMmD1DtX3x6jStNkbdwqZ5W9kC+uSbcmh7ghU/5CfkTqWKap9h+YoqUJ7OP+f06dGbEwTC5A/zdf9NQeKyGemgCq11Wovxj6ftw5yJAPh3BySzc6+sKwtTcDz7bwak2rfmjTz5etu16r5HlMVPgsTu+fdydocxhMpi6T9kdnHInREQVQUqLjw5Ie46JdD07zbGjjJwTZXasFmFMiO2otetdyeUkjHm2Zrc2U4H05pTw0JYrYhBD6TrUuzak625JVvheArpcnT99E4jL9sOZ5dQuDJvBzSGNxobcUfkb8KdpOGcW3Wj0jiOscsTU1TvvsQbE4tBUTv9mSyaaUO06KhMWqWPDEDQWncu3ebe7QkFE6UI06vFyitZcPZuYSyxiNRiQw8sBAVMD5fpDoyyYi/BcVOBce7eXZTa/5aWZ6saKBm0TPp9KSffc6hGrAr2lU63kMBDqMM1XGkA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2575.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cd8d5d-937e-49de-3e4f-08d848cb01db
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 07:46:41.8262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hPozfZCasaiaDhFJcu7EhABMdiAiKMe+OHhIcUgy/Y8Al5QUykxZ2xTRdxOmuBdRDY68s+u6jDREBvFVjX+WuDc2cnsdqdKOyfFqJwdQrbUaWgG61PBc0UBpuDNVuyhR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2829
X-OriginatorOrg: intel.com
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


> -----Original Message-----
> From: linux-pwm-owner@vger.kernel.org <linux-pwm-
> owner@vger.kernel.org> On Behalf Of Andy Shevchenko
> Sent: Monday, August 24, 2020 3:53 PM
> To: G Jaya Kumaran, Vineetha <vineetha.g.jaya.kumaran@intel.com>
> Cc: thierry.reding@gmail.com; u.kleine-koenig@pengutronix.de;
> robh+dt@kernel.org; linux-pwm@vger.kernel.org;
> devicetree@vger.kernel.org; Wan Mohamad, Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>; Raja Subramanian, Lakshmi
> Bai <lakshmi.bai.raja.subramanian@intel.com>
> Subject: Re: [PATCH v4 1/2] pwm: Add PWM driver for Intel Keem Bay
>=20
> On Sat, Aug 22, 2020 at 10:30:45PM +0800,
> vineetha.g.jaya.kumaran@intel.com wrote:
> > From: "Lai, Poey Seng" <poey.seng.lai@intel.com>
> >
>=20
> Side note, please use my @linux.intel.com address in the Cc list.
>=20
> > Enable PWM support for the Intel Keem Bay SoC.
>=20
> ...
>=20
> > + * Authors: Lai Poey Seng <poey.seng.lai@intel.com>
> > + *          Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.co=
m>
>=20
> Seems you missed Co-developed-by in the tag block of commit message.
>=20

OK, I will add this in.

> ...
>=20
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
>=20
> > +#include <linux/of.h>
>=20
> There is no user of this header. But mod_devicetable.h is missing.
>=20

OK, will remove this, and add in mod_devicetable.h

> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
>=20
> ...
>=20
> > +	/*
> > +	 * The upper 16 bits of the KMB_PWM_HIGHLOW_OFFSET register
> contain
> > +	 * the high time of the waveform, while the last 16 bits contain
> > +	 * the low time of the waveform, in terms of clock cycles.
> > +	 *
> > +	 * high time =3D clock rate * duty cycle / NSEC_PER_SEC
> > +	 * low time =3D  clock rate * (period - duty cycle) / NSEC_PER_SEC
> > +	 *
> > +	 * e.g. For period 50us, duty cycle 30us, and clock rate 500MHz:
>=20
> > +	 * high time =3D (500MHz * 30us) / 1000000000 =3D 0x3A98
>=20
> 10^9 divisor now is redundant. It's school physics about units.
>=20
> > +	 * low time =3D (500MHz * 20us) / 1000000000 =3D 0x2710
>=20
> Ditto.
>=20

Thank you for pointing this out - will fix this.

> > +	 * Value written to KMB_PWM_HIGHLOW_OFFSET =3D 0x3A982710
> > +	 */
>=20
> Note, in the code you are operating different units.
>=20
> ...
>=20
> > +	div =3D clk_rate * state->duty_cycle;
> > +	div =3D DIV_ROUND_CLOSEST_ULL(div, NSEC_PER_SEC);
>=20
> For example, here you have clock rate in Hz, duty cycle in ns, that's why=
 you
> need to use NSEC_PER_SEC divisor here.
>=20
> ...
>=20
> > +	div =3D clk_rate * (state->period - state->duty_cycle);
> > +	div =3D DIV_ROUND_CLOSEST_ULL(div, NSEC_PER_SEC);
>=20
> Same here.
>=20
> (Just to be clear, code is okay!)
>=20
> ...
>=20
> > +	priv->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(priv->clk))
> > +		dev_err_probe(dev, PTR_ERR(priv->clk),
> > +			     "Failed to get clock\n");
>=20
> First of all, it can be one line, second, it misses something...
>=20

Missed the return - sorry, will fix it.

Thanks for the feedback, Andy. Will make the changes and resubmit.

> --
> With Best Regards,
> Andy Shevchenko
>=20

