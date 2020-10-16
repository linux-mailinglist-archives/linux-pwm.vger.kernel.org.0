Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8BF28FFFD
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Oct 2020 10:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394581AbgJPIcK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Oct 2020 04:32:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:61978 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394465AbgJPIcJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 16 Oct 2020 04:32:09 -0400
IronPort-SDR: 5QW+WhprPClo64fWB/ga3P3irbvcgK7d8QoLFWlYPhN/U8RahZ2x9x8y/2ihEyKJdKLmLa6UPn
 H1h4kf5yivlA==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="145864581"
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="145864581"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 01:32:08 -0700
IronPort-SDR: dREwULERi7WUEwIZ3k0l3Pw1Z/4dIjBiSe8A81rP7//eZLy2A8igiqQgdQbpoP+VC+eZSBeHss
 6A7AX7WWVi5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="358017617"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga007.jf.intel.com with ESMTP; 16 Oct 2020 01:32:07 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 16 Oct 2020 01:32:07 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 16 Oct 2020 01:32:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 16 Oct 2020 01:32:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 16 Oct 2020 01:32:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1me2HzvgqLAJsswa5tu7Jg9GBtIsY84AbcW11o5HcoiTcdm0f/jymxkF7uR6OlHUWMzLpqLDnPp22bXYQpC9YGo9O0P/d47PwT86Sb2F0/k+J0CCfPJ1+ph3OSHEkXMVhD8wPK9QDvZWst81OwHOE8TyKiGftxOX3b6QAozy4a/bqPeqESEsU7zjs04JWVgNbx0YwcbJKmMg+xswYWMaMA2hGudEc+EJhaZQvYRiMZFtZOmjArVAtZWH4JeLzxoPukokjzbuRrafXAc6xn8C8fqxJqwYDdytdoZ6PY41jGG3FAT57YqkhmsX7IN/uk5sBiN6fveKLn78Fzf2LKWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/nPypaocoQ6LoYcYrtenBaAqB8IYOn3DKufsI6/UyU=;
 b=l3F6nF0yo1ZAGVY2iBXPxHzn+DVEcWmU+Vcvcrecz4g2Q5xcC8Xga8CAWSkG+cuPjjI8QWs+EQR50QcgMb0b/upTaeg4MSAgfy4OUF/b65oiwwFcvHUOV6+JXkHcCtZxiHPnKYDZQkJpPjuHLuTwzdG4vvD4bNfILsW+cgAYmN6obVUCqwm+2MKQphJ2ncAtbSfaZs1asNetID493a6A6EyXdARNXuw8WRzZMGKtV3UODfvIl8ZjPDcCxZPWph5Y+HwEnFr94Gj+bWTFuRu0hwylt43Hy51nBLnWGKzsBE2wcbj2Nk6Hf1vlrxFOj+sUWkRr9I9tr8BgJxsb3n5fLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/nPypaocoQ6LoYcYrtenBaAqB8IYOn3DKufsI6/UyU=;
 b=eI0f049CTlDDCLT4pdfOXCnjBx57nVwsjae2tvrs7KZrMlU5HQFdE+pPxg+HMN5FJBCZr4we1bzCyV0gfac08wiAs8pIKvRI2H1CAgi5CMb2QFSX4kotcdT5fT+/EqCuG3pVwCVvrtqr5aE7fAvTx0TdgzuyOr2NM83JHyEq5SU=
Received: from DM6PR11MB4250.namprd11.prod.outlook.com (2603:10b6:5:1df::18)
 by DM6PR11MB4531.namprd11.prod.outlook.com (2603:10b6:5:2a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Fri, 16 Oct
 2020 08:32:06 +0000
Received: from DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::7448:c067:e80d:3c09]) by DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::7448:c067:e80d:3c09%3]) with mapi id 15.20.3477.021; Fri, 16 Oct 2020
 08:32:06 +0000
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
Thread-Index: AQHWomCF+NkKYBj1fUCQimGsu2FSAKmYevKAgAENFDCAAFDFAIAADNpQ
Date:   Fri, 16 Oct 2020 08:32:05 +0000
Message-ID: <DM6PR11MB4250C00BB0FFB3CD97D5207CFB030@DM6PR11MB4250.namprd11.prod.outlook.com>
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
x-originating-ip: [42.111.145.160]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81038e56-efe0-4b9d-f2e2-08d871adf71d
x-ms-traffictypediagnostic: DM6PR11MB4531:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB453184D9B37DDAE3589E3E99FB030@DM6PR11MB4531.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BX8pI51ssX6K3VolH/uBmK2BQ2w6vXTTV/GPjwE5iTPkQuqnhgWPbCAmPiqQ6XsN/yc+Km0EN2mM3N3XauQ2K1A4ZDvMNZcHzIBiQxJzyzl8Ef2ua1ujcTaAbuGyxqg3jBtM30kkQmgwB3qMOA3fjga7DIerlcL/d2Pzk6K36cAL7zN4n6Ov9iWJjWVV1s42vxHLZYWHLHLhZDPqw7liaOUEBxpZ353P1PV4pp8cqBd0Ks+eeSMKfsI5l//O7WntGqAnOrL3yVTuWJmPcPbTIJ9pPaygg41RLzxSti+eH31Z9aK0qKgbB2Ucs/T0ax6evogN+7VupjeMWB93tEjdqhp029+CBB/YpG7xbN4hFIcAzyusRlWkPtCk6NGutYAqosjpn48Hz/+PXu+o+a/prA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4250.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(316002)(8936002)(66946007)(55016002)(54906003)(71200400001)(186003)(66574015)(83380400001)(52536014)(7696005)(8676002)(76116006)(4326008)(64756008)(66476007)(5660300002)(86362001)(53546011)(6916009)(478600001)(9686003)(66556008)(66446008)(966005)(2906002)(33656002)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Lo9c3inLAWx9jVjGN+FI7X5Es5WpSovDUKVVRAeXmvAzhk4XBR2c4SLcpdgdXfiF6EH3j3GoUcpV6rBqDToR71FXEL6dQwwAz03X/Oy1uGKlhe8EcF23JLq7Gmenx1Vs8mA4QmFx5INfQNZg9tsz7j3Z+7ziRkVViqcGFg4tQMcLIS1iATO8bAcvybJSWJQ7luOHPP0H8LczDe6e6/qIjqWZ4IT4e4QL2Nez9NBe09CXceZIZeRGGm13//Hkk08PGmT9sSXexZjk2enkO6LC8Z3aeLCdym1BD3mWfyeZ6g9jP4IUiQWIWBqr7yPDMB0A8O7ixRdI+upXtnH2A78RglXR+gjfH86y+/nx4/pYDYnPN3DOPloWqwaCHW4r6cKxv44RwwlDdx7CQ1pvlRPzfuOk9PZRdM2iX5bsQJrJBaDOV/nxLZ4yDUiH+9IbdPFYiuxMqno4bG8ziOqr5unJ8uwc7ne0LI3HNJo6tIjpvM2wW/AVKaujn5Xbq7fnYbkS03zeK+7Pb6bSZSncQ/EOnC9Qap88oA0DPUhSZX4AdssCHfGwhMHqKliJWqoD7ebXh2XdoZyiyLrbBt3qoSEP91Pwh3UrfXXet7lTdydEeQWfYHLNG9B51HgqpkVJxLeFvDcScKC8Vvo6aL/xWWCwKw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4250.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81038e56-efe0-4b9d-f2e2-08d871adf71d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2020 08:32:06.0981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PpjKhCjcJYB5PNMfszVUF/es9M7nsvd6sCDGpDYz2bg5ieZ7xPHndcHBE38cM2HcFUZEd+OZcC1PO2UODlwyRX+JcQ2vvEkTrQW3rdclJe9skVybw5LUgmRqCD45+UuE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4531
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

-----Original Message-----
From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>=20
Sent: Friday, 16 October, 2020 1:04 PM
To: Ayyathurai, Vijayakannan <vijayakannan.ayyathurai@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; thierry.reding@gma=
il.com; robh+dt@kernel.org; linux-pwm@vger.kernel.org; devicetree@vger.kern=
el.org; Wan Mohamad, Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.c=
om>; mgross@linux.intel.com; Raja Subramanian, Lakshmi Bai <lakshmi.bai.raj=
a.subramanian@intel.com>
Subject: Re: [PATCH v12 1/2] pwm: Add PWM driver for Intel Keem Bay

Hello Ayyathurai,

Can you please fix your MUA to properly quote when replying, this is really=
 annoying.

Sorry for that MUA (Made Up Acronym).=20

On Fri, Oct 16, 2020 at 03:18:08AM +0000, Ayyathurai, Vijayakannan wrote:
> > On Thu, Oct 15, 2020 at 03:36:09AM +0800, vijayakannan.ayyathurai@intel=
.com wrote:
> > > +static int keembay_pwm_remove(struct platform_device *pdev) {
> > > +	struct keembay_pwm *priv =3D platform_get_drvdata(pdev);
> > > +	int ret;
> > > +
> > > +	ret =3D pwmchip_remove(&priv->chip);
> > > +	clk_disable_unprepare(priv->clk);
> > > +
> > > +	return ret;
> >=20
> > ...and this will be simplified to
> >=20
> > 	return pwmchip_remove(&priv->chip);
>
> Until v10, It is as per your suggestion. But I have changed it in v11=20
> to overcome the issue mentioned by Uwe. I have kept the snip of v10=20
> FYR below.
>=20
> //Start snip from v10 review mailing list //> +static int=20
> keembay_pwm_remove(struct platform_device *pdev) {
> //> +	struct keembay_pwm *priv =3D platform_get_drvdata(pdev);
> //> +
> //> +	clk_disable_unprepare(priv->clk);
> //> +
> //> +	return pwmchip_remove(&priv->chip);
> //
> //You have to call pwmchip_remove first. Otherwise you're stopping the PW=
M while the framework still believes everything to be fine.
> //
> //> +}
> //End snip from v10 review mailing review

Note that we're both (Andy and I) are right. You must not disable the clock=
s before pwmchip_remove() (otherwise for a short time the PWM looks ready b=
ut isn't). And if you use devm-stuff to enable the clock it will be disable=
d only after the remove callback completed and your .remove may look like:

	static int keembay_pwm_remove(struct platform_device *pdev)
	{
		struct keembay_pwm *priv =3D platform_get_drvdata(pdev);

		return pwmchip_remove(&priv->chip);
	}

because you won't have to care for the clock explicitly.

OK. I will incorporate it in the next version.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            =
|
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

Thanks,
Vijay
