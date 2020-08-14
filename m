Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853E82448C0
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Aug 2020 13:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgHNLUo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Aug 2020 07:20:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:37001 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgHNLUn (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 14 Aug 2020 07:20:43 -0400
IronPort-SDR: a3R+P6kdQVujkByhEcqIYxWz7X8ELOc17Ku1mRoA1ushN3VU+p2Io9j7i26ntDhtOtJSlFrFy8
 htJ4Z4EWRdAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="133909987"
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="133909987"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 04:20:42 -0700
IronPort-SDR: eE/AhXpNulkUDX6cUJ9PsYF9yWw/dw6Z8aeTexFQj0apDTQExJTLezjVFicTHzGJGYA+20Fx25
 YBKXcmuboQ2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="291708228"
Received: from unknown (HELO fmsmsx604.amr.corp.intel.com) ([10.18.84.214])
  by orsmga003.jf.intel.com with ESMTP; 14 Aug 2020 04:20:42 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Aug 2020 04:20:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Aug 2020 04:20:40 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 14 Aug 2020 04:20:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 14 Aug 2020 04:20:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzoV84+kM0nhZHIjVGseEMnOSJLTZ7EvzV4sxMjWs87jlb7+7lCZ9hZykFGLYQiDf0j/rXzwCdizW2YP2f0Ny6NV3g5/DHfIk3NUEIHrgTCe/BMWwz+i9mR5dfz7K3hYRGajuS8KjagMfCss+6b0FP57eRIgBiYEG2dyxpG2fqKiJRa8ntu+SBg7SVClYSTQl0UETmrAmqJNPcHvtwmDhQEc2oGu1EDDh27KvY/krJ7SOgMp3ojIVl2MCsgLNNjqUrGdq/0Q3aMyQS7/LxTOSHfgMIHkbfibvw+F6DQNlF0S0VEZUj5E3CY56d+t4gyO+JB0Ef+7pUCBX//VdpCe9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csIO+I5zGOzMj5hl/9CqE13a/opSIfTNrYlKq1YIM7Q=;
 b=XFV0dFJO6bBfyXFYfEgK1omaTKnDZ+WuDkb1wjZH/69ecckZosoZpxYB9hGd7cRveXNDzcqHxROHtrKtoF4HPnzO9IIAeTtNbJpyG8qVOAzAwZG2zcwQRnxbqsJr9YmDaSAk/2FRAVIjkP5GHPvNZ9EXkDB4m2R3dcb1Oejjg5cB9cMNaOTzRjBBLhhc+j9nqzjOnylL3XC7IAJj6fjLEBQdtXGRTUM6u5dlDt3+ZLDh0f6ZYLsNX4PGTG0wlHlZQ6uOSIONeqPd/pjvsmJuwg/74jme3oFozY1JQBDrAz72lSLRG8VP91djGOTHTvEW1h+W7EPlIb6sLGoOu6pYeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csIO+I5zGOzMj5hl/9CqE13a/opSIfTNrYlKq1YIM7Q=;
 b=i4a3//PTN5UrL98iHK+o/qwHlEzuJBhe9TQ3ApStPIuGLBNi4OV2Cgit7TyF4vCw2BtzZhjTMBBm9MX0HWzdC1r/zNYCzHRBOV5ZyS0xvw7AljYrwuhy6Tw+ITBbbAKU9eDwY2A624HkGkocTPx1VNeMG8/s2QWOGegxKJmMpNE=
Received: from SN6PR11MB2575.namprd11.prod.outlook.com (2603:10b6:805:57::20)
 by SN6PR11MB3392.namprd11.prod.outlook.com (2603:10b6:805:c5::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Fri, 14 Aug
 2020 11:20:36 +0000
Received: from SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::6407:40fd:19e3:e270]) by SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::6407:40fd:19e3:e270%7]) with mapi id 15.20.3283.022; Fri, 14 Aug 2020
 11:20:36 +0000
From:   "G Jaya Kumaran, Vineetha" <vineetha.g.jaya.kumaran@intel.com>
To:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: RE: [PATCH v3 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Topic: [PATCH v3 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Index: AQHWcYvu8z4TrnEMz0yqJFMb02nyQqk2a4IAgAD3V4A=
Date:   Fri, 14 Aug 2020 11:20:36 +0000
Message-ID: <SN6PR11MB2575707CEDC5688448F7896DF6400@SN6PR11MB2575.namprd11.prod.outlook.com>
References: <1597334646-21087-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1597334646-21087-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <20200813192402.GI1891694@smile.fi.intel.com>
In-Reply-To: <20200813192402.GI1891694@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [161.142.240.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 959e7791-9a22-4b2d-e052-08d840441177
x-ms-traffictypediagnostic: SN6PR11MB3392:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3392EFADC7AD66D48EA014EAF6400@SN6PR11MB3392.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dIvoDlZfqKHx/Xa6Nh01XQZryUsuMAM6YdcKaHDfeIulK55ajWfU1y1kMMsNRSdrWTHPoOHMdnZlKnkNI7G2+SzfN11oWVrQvkOOEzk1BobEywIzi5deHCH/UpgQkKSfK0aLLE3Gz964rdq/6PJ9Opx6Bc8DBnOt3mG87ynXOQwXzbMWB4PhO51xv8T0s3+LtWaTj6Cggqy7MewRL9EAwKx5gukPnCcHEpMHsax/2XUxqzqcbE8EzchFPLoDtMIDxJiFdAkQmeoVd+klccskReh1rZZz+tcNWWwVpVzzJ8VuTx7U54UqX1S7X0nKHDsGIvzAJqNNBaHT9XUrKAOZHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2575.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(52536014)(76116006)(64756008)(6862004)(66556008)(7696005)(83380400001)(8676002)(9686003)(26005)(66946007)(86362001)(66476007)(55016002)(6636002)(107886003)(478600001)(53546011)(5660300002)(6506007)(66446008)(8936002)(4326008)(71200400001)(54906003)(33656002)(186003)(316002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +j7TIbJVYV09ny5SsszMzuoOS1YVPa5juNIfL31f9iZj2SBMHDj4r285cVU8ZDHRfPlonE2hGNWKIlJpmnHKU1ikp8HKGeQVYY39vCReJGbMHr1H+FguJCh41ilBKYSYykdLcydFMBV63JGsq5EBQ4MRn858//u+LvMiiwRWzm6fSkItka7H9agMVHGVRUSnsYLmIGbFjmbRBXFFiGpF+SzeSKjHmSmSv329fdyqI6rtm+5T4Uy8gLSdh0S9tHVg8y9zxDFGQ6NOHfaBEkLXyKeYAv82J+rEbKYfp2Jin8JGpsSchuhAxaESvn5VN9pAvvs10GPLjeJ1fY7DvhOWRVUoBPahk7NSCNmVjEzPTGZQsI5uzTfsNiNEIN4qXq8eMQtb4KL0Wf/o/Inq2xiyQF9qw1y+9L5dVYDFKIrBZm86S0T7vpBN0/GPqE6aR9dlbL0JPIbdDff+8BgZfd7W2VufdgzhUSOJp+KyOksSZzF2o1MaEL9T1J1Tx9d7ipxDrq/4hfSYRqKONZ6DCXBkwgwLdcoRkP5Nn76Sd66vY9CCV2MLqz2C8zu3ilRbd3ZQaRY17oKMrOfiR2/czNe8vKNoGVv5oINsvQcuss3d6GbCSLuyIxlunRqWY6m/qBsWL4ENXMGPHn7EIO0cwP0sZg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2575.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 959e7791-9a22-4b2d-e052-08d840441177
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 11:20:36.5998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AFtq2tFsW+Y1qQPBuF65e+jUgx07RrbF+GYQFA904qImOC0BzdqZxk0tjuiLnKasQQ+WM/WlCP0bP7M9SKSNPLBaaSwVOz4pB+LBFrQhdCkb5W/fw4swevTrQ2xDmb9D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3392
X-OriginatorOrg: intel.com
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


> -----Original Message-----
> From: Shevchenko, Andriy <andriy.shevchenko@intel.com>
> Sent: Friday, August 14, 2020 3:24 AM
> To: G Jaya Kumaran, Vineetha <vineetha.g.jaya.kumaran@intel.com>
> Cc: thierry.reding@gmail.com; u.kleine-koenig@pengutronix.de;
> robh+dt@kernel.org; linux-pwm@vger.kernel.org;
> devicetree@vger.kernel.org; Wan Mohamad, Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>; Raja Subramanian, Lakshmi
> Bai <lakshmi.bai.raja.subramanian@intel.com>
> Subject: Re: [PATCH v3 1/2] pwm: Add PWM driver for Intel Keem Bay
>=20
> On Fri, Aug 14, 2020 at 12:04:05AM +0800,
> vineetha.g.jaya.kumaran@intel.com wrote:
> > From: "Lai, Poey Seng" <poey.seng.lai@intel.com>
> >
> > Enable PWM support for the Intel Keem Bay SoC.
>=20
> ...
>=20
> > +static inline void keembay_pwm_update_bits(struct keembay_pwm
> *priv, u32 mask,
> > +					   u32 val, u32 offset)
> > +{
> > +	u32 buff, tmp;
>=20
> > +	void __iomem *address;
>=20
> No need to have this. Just use calc in place.
>=20

OK, will remove this.

> > +	address =3D priv->base + offset;
>=20
> > +	buff =3D readl(address);
>=20
> > +	tmp =3D buff & ~mask;
> > +	tmp |=3D FIELD_PREP(mask, val);
>=20
> One line and one variable less:
>=20
> 	buff =3D (buff & ~mask) | FIELD_PREP(...);
>=20
> But shouldn't be u32_replace_bits() instead?
>=20

Thanks, I will try to switch to this instead.

> > +	writel(tmp, address);
> > +}
>=20
> ...
>=20
> > +	 * high time =3D clock rate * duty cycle / NSEC_PER_SEC
> > +	 * low time =3D  clock rate * (period - duty cycle) / NSEC_PER_SEC
>=20
> > +	 * e.g. For period 50000ns, duty cycle 30000ns, and clock rate 500MHz=
:
> > +	 * high time =3D (500000000 * 30000) / 1000000000 =3D 0x3A98
> > +	 * low time =3D (500000000 * 20000) / 1000000000 =3D 0x2710
>=20
> Please, replace all multipliers to physical units
> 	... 50us ... 30us ...
> 	... 500MHz * 30us =3D 0x3a98
> 	...and so on.
>=20

Noted, will fix this in V4.

> > +	 * Value written to KMB_PWM_HIGHLOW_OFFSET =3D 0x3A982710
>=20
> ...
>=20
> > +	priv->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(priv->clk)) {
>=20
> > +		if (PTR_ERR(priv->clk) !=3D -EPROBE_DEFER)
> > +			dev_err(dev, "Failed to get clock: %pe", priv->clk);
> > +
> > +		return PTR_ERR(priv->clk);
>=20
> return dev_err_probe(...);
>=20
> > +	}
>=20
> ...
>=20
> > +	ret =3D pwmchip_add(&priv->chip);
> > +	if (ret < 0) {
>=20
> ' < 0' makes any sense?
>=20

OK, will change this to just use 'if (ret)' instead.

> > +		dev_err(dev, "Failed to add PWM chip: %pe\n",
> ERR_PTR(ret));
> > +		return ret;
> > +	}
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

Thanks for the comments, Andy - will make the changes and resubmit for V4.
