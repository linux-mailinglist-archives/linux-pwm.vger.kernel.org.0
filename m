Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1BF28E4C9
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Oct 2020 18:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbgJNQtk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Oct 2020 12:49:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:25378 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731282AbgJNQtj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 14 Oct 2020 12:49:39 -0400
IronPort-SDR: mSdHdKAzT5esxifFww1F8SB13m1Oe0cCFFylQNga5SrGfDz+NWLNubfwlDebCmPFepyyn3KkXZ
 3ixX4Y1jDmUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="162678383"
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="162678383"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 09:49:39 -0700
IronPort-SDR: iw94lrDLDx+ewl10a7EEQX7Hd6C3u7EW9z6iixt+FUzOVDJAc7g+v4YXj82mtMFHo/jVHCIPy5
 B2A0K7KFNEgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="390707088"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 14 Oct 2020 09:49:38 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 14 Oct 2020 09:49:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 14 Oct 2020 09:49:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 14 Oct 2020 09:49:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apmfqWIUtB6t+6eYKYT1dBX6fe/VHARdPR0DRn0AcPQBR76Qa2KAdaTqKPtHLTh4OdFfZOY+FXfunZ8tmZF+G5mXzOgG/Ixl3oemDvYW7bVgvDyJuriZoRb/7covIgEaYZicUv9TjwN+iwOE7N5EQvNgJgVSZRl9IC/A1IB99zN8XrUaNZm1FCBAYSdCpQnNnWP37rqP84iW5BA39J7yckUNARfT4hYdAeCcbG49EpxAEE+bHNjjC31cfM8WhKjt6Wj2O90bJZr8oOOVvyAVAwr+rsyO71kJW2xhR4vdhloJjIL2VchbQuJdSrPO0ApSupfuHTTFEx56C49763zorA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HieW1Qo7+mstb562zAzzeXJq+2LRUTc9NtvaIqW4od8=;
 b=O7MJ4ZQisEHqHa27MGvfZvGForXkR2FYOuNWm9SKk/4VVsezoqRi7YP0EXLzWDIy1Nq5I1T841S/CDu5lXHrqs4IdqO2St3Dcij4dKQ2youSBkMA5vdJG5pxsqXL83hxR54n19Qt8Spi13wmrG6A4p3JaCLDiQr6f1sJvRSFlm0HGahKn6pHHGrjS/4lOm23z4mabcSdT6gL4LsUgoIO0xeg8EmHq6MdYBkGN3yFdnXLY2dcNpqirsJ/0WF06rKIw3XtOYo8vrR3tP1zFbAWCT0vcYG/q+NbTZZYW5cjCtVWhw1zcj+XGWLXK2OQFzbb1GGVkfcLvaIoB0HabzAFpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HieW1Qo7+mstb562zAzzeXJq+2LRUTc9NtvaIqW4od8=;
 b=zsYjI27Ejg3bg4/OFdjI2DmxQzeztZ64GcNJqsvP2xrEXuLp6jSDsSklT9jUJk9xrAugI8nMAsyRSdOAEhtGhOqV4hrVmw/C/O8QR57ckAHKTiEI7O6v3YaFaNd9L7JYwwHPZG5BpZdqdh7vpCW4tf4lBjm8VzOr6g/ITLE8Vio=
Received: from DM6PR11MB4250.namprd11.prod.outlook.com (2603:10b6:5:1df::18)
 by DM5PR11MB0010.namprd11.prod.outlook.com (2603:10b6:4:6c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.30; Wed, 14 Oct
 2020 16:49:30 +0000
Received: from DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::7448:c067:e80d:3c09]) by DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::7448:c067:e80d:3c09%3]) with mapi id 15.20.3477.021; Wed, 14 Oct 2020
 16:49:30 +0000
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
Subject: RE: [PATCH v11 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Topic: [PATCH v11 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Index: AQHWoYyOsz9QcQnhdUi5sFIQXN0z8qmWqSMAgACcFbA=
Date:   Wed, 14 Oct 2020 16:49:29 +0000
Message-ID: <DM6PR11MB42504B4935CF36B0A63D6418FB050@DM6PR11MB4250.namprd11.prod.outlook.com>
References: <cover.1602612067.git.vijayakannan.ayyathurai@intel.com>
 <d5312c9bef22f4439deb27a00d0bf51d7a2b92c6.1602612067.git.vijayakannan.ayyathurai@intel.com>
 <20201014064910.jwb664re6frsqd5a@pengutronix.de>
In-Reply-To: <20201014064910.jwb664re6frsqd5a@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.111.147.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f134da25-1837-4bf1-e940-08d870611eab
x-ms-traffictypediagnostic: DM5PR11MB0010:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB0010CD61D14FF294489B39CCFB050@DM5PR11MB0010.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fXjWxAqm1tpxPrQT2CXC4QLaLwBEQ2geeuY+Kr31CmM2dfwgEWHNDi70hCCAV+RT6bXu+uXF+SOLbHgHKmwVeCc9EYqIRAU6GN0E9GbriY/LGywJ2z5Js0n20ha6nl/kp3OiDik/mrC1M8zpG/YjKNjXovo18jLjmLxD5P3Dz+o28Rs+Oymv05LY8A1uxBLoiwTx7Gnnre2FfzbrUf6YU9LEl3Jby4jh8IjC0g7mnjM+dsD1qO07lrVjTUJOXeO201rSUwNCIrH9v/+Q9qO66nnZnA1budVqmLuSJ8QPvPIFmlir082EZimFfyjXT7VtB4l1wCxZGkTOXabNaJ8KWaOP8en6u5t1v2BmRYtZiSF5EhQgcCYK7BJORlJtq34II2es5fbh74AUF80kw0w3vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4250.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(66946007)(53546011)(26005)(55016002)(478600001)(8936002)(64756008)(83080400001)(186003)(76116006)(4326008)(54906003)(86362001)(66556008)(66476007)(6916009)(66574015)(52536014)(71200400001)(66446008)(6506007)(7696005)(9686003)(83380400001)(5660300002)(2906002)(8676002)(33656002)(966005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: NXfN3Sg23wv1jWximPP0NyRRP6wzFnGRkfN5RfBftUAHkVn3Adn8JNv7Rle9UQC6YgfAIu8d101CuYva5ue6VXH4YxfjujBd/aOtb1s+t34f9Z9iMU3Y8fl3Kde/3Ur59YYPm+EB0NjHGp1JhMvidnMd0eUeVdlPfZSqOLf0dHc4yseNTDN8N7qasFTufABDSzEEjMSszRZkFn9LpfftbaoDOyeH0QCsqeNFzCuqq6B/lzEwcxcHp/8oXdmo/HQRdoquCE2ZLoC8lv7IM0WuotK9mYIDMW3FqOys23HSxCwpoMnxJG0ZcQ5/wIPkOtciyoh9HH5koXcuF8s/bliTeOJeQjmDk/03qwlNX1SgPwgY9s7WhQ7IVPHZadXbQWmFI+ZTUPgzNN0QUrdKXcoho6O2FccLwq6Ujswqe8WXW1tSM2ZWEpP0CT23VHgEnolwIHXxexFwJkCwUmAqxppKtzpnHQ3K/jXEpWHZHL1ihCjISB6YiF2zYHAaQD+VP8PW4cl0BfksXndc1kepgck1bVLHVsvt2m9WNo4I8/sKdP7UAEoCSaIixBxZ+TeLegYQQ4OSf0QdcxbntlhjpzvUjlawJ01B4K6W8uk8gq0oYjdSdsHUUKM31qlazKeirSJoVwBBWoCH8B7E0d9j/TQlQg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4250.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f134da25-1837-4bf1-e940-08d870611eab
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 16:49:29.9198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kxTGjmeaYbu+eT6Izfxjry8S4Badir7sG+c0q73dP08pKAwSHvZuIU6g5sS6amwoAw3zM5FMi8JrdZjDd6MF3WIB6hE6N1FBu3LvMXiwHXz/Q6gSSl659mrDvr0G9LFp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0010
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,
Thanks for reviewing this patch.

-----Original Message-----
From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>=20
Sent: Wednesday, 14 October, 2020 12:19 PM
To: Ayyathurai, Vijayakannan <vijayakannan.ayyathurai@intel.com>
Cc: thierry.reding@gmail.com; robh+dt@kernel.org; linux-pwm@vger.kernel.org=
; devicetree@vger.kernel.org; Wan Mohamad, Wan Ahmad Zainie <wan.ahmad.zain=
ie.wan.mohamad@intel.com>; andriy.shevchenko@linux.intel.com; mgross@linux.=
intel.com; Raja Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@inte=
l.com>
Subject: Re: [PATCH v11 1/2] pwm: Add PWM driver for Intel Keem Bay

Hello,

sorry, I still found a problem that I want to have addressed. I'll point ou=
t a few minor things en passant.

But after that I really have a good feeling and like the driver now.

On Wed, Oct 14, 2020 at 02:14:12AM +0800, vijayakannan.ayyathurai@intel.com=
 wrote:
> +static void keembay_pwm_get_state(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> +				  struct pwm_state *state)
> +{
> +	struct keembay_pwm *priv =3D to_keembay_pwm_dev(chip);
> +	unsigned long long pwm_h_count, pwm_l_count;
> +	unsigned long clk_rate;
> +	u32 buff;
> +
> +	clk_rate =3D clk_get_rate(priv->clk);
> +
> +	/* Read channel enabled status */
> +	buff =3D readl(priv->base + KMB_PWM_LEADIN_OFFSET(pwm->hwpwm));
> +	if (buff & KMB_PWM_EN_BIT)
> +		state->enabled =3D true;
> +	else
> +		state->enabled =3D false;
> +
> +	/* Read period and duty cycle */
> +	buff =3D readl(priv->base + KMB_PWM_HIGHLOW_OFFSET(pwm->hwpwm));
> +	pwm_l_count =3D FIELD_GET(KMB_PWM_LOW_MASK, buff) * NSEC_PER_SEC;
> +	pwm_h_count =3D FIELD_GET(KMB_PWM_HIGH_MASK, buff) * NSEC_PER_SEC;

<minor nit>: The variable names are not optimal. I'd use "highlow"
instead of "buff". pwm_l_count would be appropriate for FIELD_GET(KMB_PWM_L=
OW_MASK, buff); when multiplied with NSEC_PER_SEC it's not really matching.=
 Maybe just use "low"?! (and "high" instead of
pwm_h_count)

Yes. I have also thought of it. So it will look like below in the next vers=
ion.

	highlow =3D readl(priv->base + KMB_PWM_HIGHLOW_OFFSET(pwm->hwpwm));
	low =3D FIELD_GET(KMB_PWM_LOW_MASK, buff) * NSEC_PER_SEC;
	high =3D FIELD_GET(KMB_PWM_HIGH_MASK, buff) * NSEC_PER_SEC;

Also in other places of it as well.

> +	state->duty_cycle =3D DIV_ROUND_UP_ULL(pwm_h_count, clk_rate);
> +	state->period =3D DIV_ROUND_UP_ULL(pwm_h_count + pwm_l_count,=20
> +clk_rate);

state->polarity =3D PWM_POLARITY_NORMAL; (That's the important bit here.)

Ok. I will incorporate in next version.

> +}
> +
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

A comment describing the effect of this register would be great.

This register is for setting up the number of repetition and leadin low tim=
e for that particular channel. I will update it accordingly in the next ver=
sion.

> +	keembay_pwm_get_state(chip, pwm, &current_state);
> +
> +	if (!state->enabled) {
> +		if (current_state.enabled)
> +			keembay_pwm_disable(priv, pwm->hwpwm);
> +		return 0;
> +	}
> +
> [...]

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            =
|
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

Thanks,
Vijay
