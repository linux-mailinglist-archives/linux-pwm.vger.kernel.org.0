Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F5D1DB08D
	for <lists+linux-pwm@lfdr.de>; Wed, 20 May 2020 12:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgETKtW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 May 2020 06:49:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:55375 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETKtW (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 20 May 2020 06:49:22 -0400
IronPort-SDR: 8iEyiKKM39zKG04CHSxWfZVgD0xdU012E2Wo6PxL5DJ9/RRtrh8ub4fPV6All/8oe23rouFd00
 An+YRlma7g0g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 03:49:20 -0700
IronPort-SDR: JActtUApvA7UmT7BVe4rRepFVQG2qTjoOsafAMC7cKyH5JnxLFySk01RjfMDqGsDl8dDXYlr1C
 Ih3a4k1A5vHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,413,1583222400"; 
   d="scan'208";a="466342654"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga005.fm.intel.com with ESMTP; 20 May 2020 03:49:20 -0700
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 20 May 2020 03:49:20 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 20 May 2020 03:49:19 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.50) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 20 May 2020 03:49:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPKT4J0hU47BneqZ8knEThuP8N1rLhJ0hHDdKbixUvGvqwigTCuIiksig3ajrO8xL3KPC1xu84Dgi8FJU/fkltDtomJzF/KHlTWBYJUU07DRgwfjey2KjmrWUrK46mZ/XgK4zzRyYMIrtcn1euiyUU19tctTwpgnMxu8sLxzVx1cLgqZYoEX8apBxlttNAUPAnFWgLj/jmu130LhNNsJCACd0ekgPD6cz8Peudngs05SVLIDn5yvX/UDsV6lbvzQ7r79YFspzGHMS3EUCh48dx2G2mG6Hy2yQIJewuh0YF8oOuUV9X/JOdXorq0mAqnpBp2DTOyVLoeS/SlaKkIj4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kh8xt61nqZzbCq7DNI8ZwvvYFSJoTWe601CSUhb/C8U=;
 b=J65VQVIcrwSDsQLdtWSqbl9qGKxEZUc5pHX4Hm6st43zeVsKYgRN0gkMfRM57LsMQHJdnyezn5Su0/la0rx25ZylWYd+tKQrncVdzeC74fBhcQ0VhBREM1rT7o4s9UZX6DzDMMno/cAv/HAJkHaWdMH/3t5dNhJLdHnsz96Inpe5MaCbWdKzuIV0Vx7a/jvdT8heiwFL4f3ehlz4mUJN6gfLsF4tRTRGc51Ijat4JvFARlZ6odeLh7sIICg2lV7ewyZAUFP5DqGzbSJ4CwOp8UBEiJQukvcmubCCARqGNJFpR4/Kn2+5sIdxrWxm8KuzQ6TlonylXkLJTXlXy9rXww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kh8xt61nqZzbCq7DNI8ZwvvYFSJoTWe601CSUhb/C8U=;
 b=rhZY4QdywC8Y0xMrLsO56U7C966IUSScR2vkO7wmOiqq8iNtX1Xl8AWyYpAdcP2Xv7ATSC49U5h5XuAhnJESgDjTrreA3BUVB49n+E/aQufYABqjEhnhsevffkG3TSfHVUovz8pqvqqr0dMFQ6Sg4kl4p3dbkxmjjyicwVbtG4Y=
Received: from SN6PR11MB2575.namprd11.prod.outlook.com (2603:10b6:805:57::20)
 by SN6PR11MB3149.namprd11.prod.outlook.com (2603:10b6:805:d5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 20 May
 2020 10:49:17 +0000
Received: from SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::24f3:9231:b6e0:a13d]) by SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::24f3:9231:b6e0:a13d%4]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 10:49:17 +0000
From:   "G Jaya Kumaran, Vineetha" <vineetha.g.jaya.kumaran@intel.com>
To:     Rob Herring <robh@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Subject: RE: [PATCH 3/3] dt-bindings: pwm: keembay: Add bindings for Intel
 Keem Bay PWM
Thread-Topic: [PATCH 3/3] dt-bindings: pwm: keembay: Add bindings for Intel
 Keem Bay PWM
Thread-Index: AQHWLFMWxOs5K3yRNUahZDevv1/7rqit5dAAgALpj9A=
Date:   Wed, 20 May 2020 10:49:17 +0000
Message-ID: <SN6PR11MB257539FDB99C0CA5A9668A84F6B60@SN6PR11MB2575.namprd11.prod.outlook.com>
References: <1589723560-5734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1589723560-5734-4-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <20200518141842.GA3594@bogus>
In-Reply-To: <20200518141842.GA3594@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 716cc3bd-3fac-4041-af5e-08d7fcab71d9
x-ms-traffictypediagnostic: SN6PR11MB3149:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3149BC8657350C6BEDB7E330F6B60@SN6PR11MB3149.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pxcuxr+iP4nGSGt0hfOpYjpw06XBsetD2tzGwuQcmkpykcDKMqiu/2SrgXUgkoGYRoMnBagCWFqGuFaPMRir1hFoyjB2qe86J1xaZCi9RrAa8mtcOwuShYGqXXjei9E4fsYGs3yRZkNJTwGMNGgrWdeuwLtpA2cp8VGaIlGZGDuVJA35ei7t8lNVeaF9VMgCDCaT1Gs4A50fUXEWBBYoyTXqLmqHRGgIFgYmwzOP1qqXnD7f2YTY5EaQlx4440MDTS1BGixZxHwJ1/JAUywiO9E7IBPzBHcLJrcDmfh68rdULAMRRUOEFnBt462ROFYBX54LMejFgqHANeUuAnKCCwyv8eosr2WlXmBTiBrWOGNi2E3W63aTXXoFQqnYQEfcpDjq4wYl5JHrl2ghrTSP5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2575.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(346002)(396003)(366004)(376002)(6506007)(53546011)(5660300002)(71200400001)(6916009)(966005)(4326008)(478600001)(26005)(9686003)(7696005)(86362001)(186003)(316002)(52536014)(55016002)(33656002)(54906003)(66446008)(8936002)(2906002)(76116006)(64756008)(66556008)(66476007)(66946007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 3DNGysPf+e8xxyCV5AwICQ+RltFJVAHE3WfMeGH7FOKM6C1xhISz4hsF58qzEcOIzTqxM4LfPvxFCdXsY1yXBVR852nXFuuiWyl9Ai4x7MMcPTTtJ54GcWC7zBv5y7d1XWAQIOsY/+Lw5zAx23rles9qfX3n+Bak3sUcNSI/w87cpsZa7/9qkeb5t9QbopOV3+0ZWOrLSJt72DGHPq+hG72q/L0DJTCBxNHCBu9U1UCMdtPBnIUAZqkxLRacnKXQx+xf8/gM8G8iWGVKcl6mhnhuaCnUzNbgGx3TeTTQ/Lo1y044GembFlwKW4+6LQhwcwmz6l2bXzTu43LinZ1UGk7qxZMXawPN91FMAqlDUgPwaWY3d4vHwbF3ZF/ZlCQmBWweylpxAEbhlcUVEfuGoTDuzVO8JF9UaPFFYfTxiN6g6AMTOqaQ39lQqbAE5W4hYTIGgJoxKfZ2qYJ7HkpGk3eDiYF9yGmMVkAablp74A0W7vDriZpuD83QZeDztdH+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 716cc3bd-3fac-4041-af5e-08d7fcab71d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 10:49:17.4793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VYpZzGKPDHTMWkmPnAxf0iohKnePWxemb/tXQ3fYbEvGpTs6IV2eU2r35W7bqVur9loPZmC7EyOu8WDFIWKB1g421LKlUwUwnqTTlC2SB5mYmJKqqYJo5ifTRQMhhZeO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3149
X-OriginatorOrg: intel.com
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Monday, May 18, 2020 10:19 PM
> To: G Jaya Kumaran, Vineetha <vineetha.g.jaya.kumaran@intel.com>
> Cc: devicetree@vger.kernel.org; u.kleine-koenig@pengutronix.de; Wan
> Mohamad, Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>;
> robh+dt@kernel.org; linux-pwm@vger.kernel.org; Shevchenko, Andriy
> <andriy.shevchenko@intel.com>; thierry.reding@gmail.com
> Subject: Re: [PATCH 3/3] dt-bindings: pwm: keembay: Add bindings for Inte=
l
> Keem Bay PWM
>=20
> On Sun, 17 May 2020 21:52:40 +0800,  wrote:
> > From: "Vineetha G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>
> >
> > Add PWM Device Tree bindings documentation for the Intel Keem Bay SoC.
> >
> > Signed-off-by: Vineetha G. Jaya Kumaran
> > <vineetha.g.jaya.kumaran@intel.com>
> > ---
> >  .../devicetree/bindings/pwm/pwm-keembay.yaml       | 39
> ++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/pwm/pwm-keembay.yaml
> >
>=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> Error: Documentation/devicetree/bindings/pwm/pwm-
> keembay.example.dts:22.31-32 syntax error FATAL ERROR: Unable to parse
> input tree
> scripts/Makefile.lib:312: recipe for target
> 'Documentation/devicetree/bindings/pwm/pwm-keembay.example.dt.yaml'
> failed
> make[1]: *** [Documentation/devicetree/bindings/pwm/pwm-
> keembay.example.dt.yaml] Error 1
> Makefile:1300: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
>=20
> See https://patchwork.ozlabs.org/patch/1292157
>=20
> If you already ran 'make dt_binding_check' and didn't see the above error=
(s),
> then make sure dt-schema is up to date:
>=20
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master -=
-
> upgrade
>=20
> Please check and re-submit.

Thank you for reviewing. Will check this again and make sure it passes befo=
re submitting v2.
