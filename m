Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9387C292246
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Oct 2020 07:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgJSFoq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Oct 2020 01:44:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:4839 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgJSFop (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 19 Oct 2020 01:44:45 -0400
IronPort-SDR: W4nBwblEmsfnh1ohuvkbKXt0B1zU4IqwKQ5DeHyv9wZF8oA677VG7EzL2gacWT+IhJmF1MfUn4
 ppYQRJR3F0Rw==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="167047140"
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="167047140"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 22:44:40 -0700
IronPort-SDR: SgOjublpuWbz2QbwsT6AJkwSmAkwlWAGz4KgBKEPglrLMkqmzh/U5c7lx6jeQfFvj6VeSoNYrO
 NpIPkpRxY+zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="320152150"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 18 Oct 2020 22:44:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 18 Oct 2020 22:44:38 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 18 Oct 2020 22:44:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 18 Oct 2020 22:44:38 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.53) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 18 Oct 2020 22:44:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQWQOUzF+fmP7DoDc4rLD2hb4PCaZlOoEFXAhchya1OoZEFa5n7L1WLHgT7PIE7uneMVTFHG8FEimViMX33YLJBlFG2016ZxOw68kUyDjYoyl7cKh8Snd3wBLCOktQF5ybMSD2ziiEwvqE5I6gpY4NLDWTtobfsmgZ1p/GaJ3YTBfJ+UHjt0uV1/xlD+XyTAxuP/ROdx3BeUUmlVh9vpT9+fOlvn1nox0qqeTp6BXLPM3qOJthpKNgaW6IkDdOlVy84r2uPlnMk9lBTf8bbdCJsDrMmbpS25ef4EKHmPIv8h6yCj/mRayPrFycjDZqsmmzkSc/q36B0TPgusTGImEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHYE/SgqasB2koPYz2yxbiMoyf34o0cPTkJMdNK/xRM=;
 b=H5dbVwdzNq2Z9GAIuVdWodsByFjcmZ8nERv63eI7r+piniijBTsOer4tosHB/4SfP/az6fhVO71l3D7C82DIxqDergpEVvGzMThQrMq01/9d08WJ1/ShMlEsW5EddyddGZl8tE9ogXb2yHB0ot/dbucUDD1CFaLGduO9QOVErNOmNeKfX05iF1JwFd2y4ij5jcUQx+I+Vo1G9kGc86NseksRpuq14aAOx6Zf8pT5jlG3kZl+vZWFXJX0w5jcF1eKhdWhIby3+LCKP99Pcs1jxbxIPJNTS6JJKEhaXN67bv/qQL7pC/IPd/bap23SMt/Cz5XjNH82WrET+zLIGKUpIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHYE/SgqasB2koPYz2yxbiMoyf34o0cPTkJMdNK/xRM=;
 b=KviQCJZauqeEN/lZ/yy6YTiW8C/pw8fOaFrrlgTNqhjSXo3Wul4DhU2KkJsRMcE7iTOzuRwC1y3zcWBROF7RzRao2ZLghK8Z1XHHgI6ZWNj9zz48fY2cZfBbwvZnyEfrYGHEDUh6NwesPfvpXpHyTSe7fKRXEMZ5bqvpazUggog=
Received: from DM6PR11MB4250.namprd11.prod.outlook.com (2603:10b6:5:1df::18)
 by DM6PR11MB4514.namprd11.prod.outlook.com (2603:10b6:5:2a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Mon, 19 Oct
 2020 05:44:36 +0000
Received: from DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::7448:c067:e80d:3c09]) by DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::7448:c067:e80d:3c09%3]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 05:44:36 +0000
From:   "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: RE: [PATCH v12 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Topic: [PATCH v12 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Index: AQHWomCF+NkKYBj1fUCQimGsu2FSAKmYevKAgAENFDCAAFDFAIAElZ1A
Date:   Mon, 19 Oct 2020 05:44:36 +0000
Message-ID: <DM6PR11MB42503DE0B047D3EBBA3997C4FB1E0@DM6PR11MB4250.namprd11.prod.outlook.com>
References: <cover.1602703463.git.vijayakannan.ayyathurai@intel.com>
 <5fc6189f9c4cf382d54ae00e663f296baeb2c06e.1602703463.git.vijayakannan.ayyathurai@intel.com>
 <20201015104217.GR4077@smile.fi.intel.com>
 <DM6PR11MB425089996A0CC9A43CBC50C5FB030@DM6PR11MB4250.namprd11.prod.outlook.com>
 <20201016073426.vyjehbkyn3sxn7d5@pengutronix.de>
In-Reply-To: <20201016073426.vyjehbkyn3sxn7d5@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.111.145.158]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1becca5-37e1-40d6-1f08-08d873f2103d
x-ms-traffictypediagnostic: DM6PR11MB4514:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB451439369CCB4F708D9FF84AFB1E0@DM6PR11MB4514.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: INHSPAIGomimHm+TD2HoXQutMIls5paS/mafhgxFeXnDNEpxQae/5gxsDI3doo4twaaaYqp2Zj7Lb+0zQa+aRJB06U/3qcG0k8q7G710xJJVDrA22e/SCPlB0pWQrj0B+o7zqvt0PmeXF1qdTo3AwSamiGPNyxdi3QeYpe2J54y9zQkHRUrEME8pesCtVfgmGWpKmG9E4z1IvlbDf9q9yBcTmwmJRgdHz7nwV015SV+ks0LsowLEvn55+38/cil86HkVjDaGvDEGrLRxla8GrDUTbDmc5HwI8n20Z6yMHMRXdDzqcXOBmFSbUND50WdX5UVEZbVaggHd8q7w8ChbcAzIveU+nxaO1rJHOXK/ZH0R5StlaKwSBDrWtHGxICGo+5eNU6QfeuzMk1RBc7Yk5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4250.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(6916009)(4326008)(8936002)(8676002)(54906003)(55016002)(186003)(26005)(83380400001)(9686003)(478600001)(86362001)(66574015)(66556008)(6506007)(966005)(66476007)(64756008)(7696005)(66946007)(76116006)(66446008)(316002)(33656002)(53546011)(52536014)(5660300002)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ey7GUp9DemqDw8IIgdfGo3YefZ6ll9ii0jDqSoFGK0u8z5FUc10Lmv/uWGc1Qd2zlAjGOR/IfSxJcSqndg9iI1i3U5NDOlhvXV/C522S2rg4E4WN+G05jziHuKBm133q0+6h3eP0mtFq7H6Yf7xn4VKWo10Dsox5OXcf/P0fxZpNeTqde8WxrMr2+maBZlmm9Tx1myDGXkJdvD8BZQkk1qYiRpktqj5WCFqrGY6/XfmChTz7OCPkxd1cXgrB7Q26QI2914CLBbGgFLiLWZys9xkH44lQgidqZwxKPV6CISnkJfRLzskN/vZtoABU7QroMyITWK/B+Fr/DDKXMOmi4t4UcRYZ4QxeJ4+rIRAFtDZzQuR8VP3vehpPTpajljDc0AjB6hEoC2CvyNFWqybGvvb/Ege6We4BEAm+dcSoA3ZU8oFPv65pNlICXCzyvvvPA0nLL2iinzQGLri8vTtxpOQlgT42VUV4NBRcjwiCC2WDNX795YEB1NXyhf6giLWoZ1ZMBT7dgFlzC42BuJ6AYrRafXev7UeOCC78nu7Hfk7E38ndpiMVK549YChlfMYNfvkPHDKvM6h1QmGHwP7do/1eNwQIJSamJJ1BRtloK3zn/8QAhnql0ki7Vq8UvlPtuX2SoXzWsPUn8ymj2yVelw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4250.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1becca5-37e1-40d6-1f08-08d873f2103d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 05:44:36.3136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rbHVukMvuQQ8lhmCr7saDVxcGQMVhs7LjgWVFwAX4+PrEeQwLTPY5rzoNvcQ43eyvbJv3tofJwIa9ztNzNTd2Ci4AzVs9saZufkRf5CdN10PUeYGCyX/0nfUnkOd9w1S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4514
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Friday, 16 October, 2020 1:04 PM
> Subject: Re: [PATCH v12 1/2] pwm: Add PWM driver for Intel Keem Bay
>=20
> Hello Ayyathurai,
> Note that we're both (Andy and I) are right. You must not disable the clo=
cks
> before pwmchip_remove() (otherwise for a short time the PWM looks ready
> but isn't). And if you use devm-stuff to enable the clock it will be disa=
bled only
> after the remove callback completed and your .remove may look like:
>=20
> 	static int keembay_pwm_remove(struct platform_device *pdev)
> 	{
> 		struct keembay_pwm *priv =3D platform_get_drvdata(pdev);
>=20
> 		return pwmchip_remove(&priv->chip);
> 	}
>=20
> because you won't have to care for the clock explicitly.

Sure. I will incorporate the same in the next version.

Also, Is it fine not to care clock during pwmchip_add like below,

        ret =3D pwmchip_add(&priv->chip);
        if (ret)
                return dev_err_probe(dev, ret, "Failed to add PWM chip\n");

>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

Thanks,
Vijay
