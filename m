Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C258B1DB0A7
	for <lists+linux-pwm@lfdr.de>; Wed, 20 May 2020 12:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgETKwe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 May 2020 06:52:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:18851 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgETKwd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 20 May 2020 06:52:33 -0400
IronPort-SDR: wj+oWQbMQxTMYfGAwoQ/c+fUjtlckJFyauCnGT7kMkcX78kSkTAF/F+TsCvnOzuW8c7PpeAyZn
 7G6EZSWqP+kA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 03:52:33 -0700
IronPort-SDR: 9kaPVcUPbu8ABkdEi+0SKP9yMuKswYaMW9Iml+uy7PvawdNjsMkEX5cd9/51CtUji+yqjHWPbZ
 PuQb45KQjJDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,413,1583222400"; 
   d="scan'208";a="466343472"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga005.fm.intel.com with ESMTP; 20 May 2020 03:52:33 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 20 May 2020 03:52:32 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.53) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 20 May 2020 03:52:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCs0rJKEmtiBfNt1JAVbvcd9jbOc562ZpyPJXvwlTtTHiD3wFDLkm8xkYGq2IjQ+kk2jk3XKoT4riShHEwmBvZg76jMlnQVeFQiciNGBe8O8B4qduyJm/3stCkWjE65HwCKTHcBWkfrYxOXABE9o1XXGSSQ3F1yqPRHE/vpgB3G/GNVaOUqBzJrlwSHQSwfjBrQzgi8zT0bWLpr+bOXCf2Fdqui4QzRDFqFxPDhOKPVVsjFLVuxJbRDZnXpLOZKqQbJPMGg/+PFtbLBthdcgq7A4O7b20La9lxLYVgmW9hrPjx00HshCXcJlF8TW0+p/tlLRpmVbTZMORtWa7PlxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFG2dDyoxZ+VsUGw4ZH2dW4zc9t6G00MDOscJjoIlis=;
 b=cSN9XNz9MN86pX9iB6PIHN5L/L0ITvexTTMRrWrhRzrV/C9k3FsBb9uIl8MC3afT5o7dc1nOfrK4T2XBFXubZHQaSQtSREO5dr/O7G9sp+eDzD7BmNB/HlzjI19P2NegNsZvYoQQ0P65G7N/W21Zh9BmCMZ7erah53QeDTIqSvpXhMcIsawnS73OIeJQWm7r19bcfXigiqQ/JL0f3JHcYS6giGW7Ry8F17vvGMRi3sHa/ZV35r/XHPBBJ+k/6PhMRJ6U3M58nPxOhVSsZu34SNijsXfYmbEC12NtrH+IRxj2TuO/IzJGLjZ7XUWImfd4BL5DOTgsWUn8tloM3uh2hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFG2dDyoxZ+VsUGw4ZH2dW4zc9t6G00MDOscJjoIlis=;
 b=r7enZsxNxHCToXRT2egOlNpYC5jUHkP7a11/9lJmOyoeYeZ8MnMi8flOJT+LjoCF+Bluu8x2zLNEVPJQqS2E/DhSUd8PX1hVhXkkGbWG7aVald0nK3eulTvhjHDfbcwilAS6tsc5Rar4qg13NBhHSzizTRkP9HQWhlhEJS4XgnI=
Received: from SN6PR11MB2575.namprd11.prod.outlook.com (2603:10b6:805:57::20)
 by SN6PR11MB3149.namprd11.prod.outlook.com (2603:10b6:805:d5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 20 May
 2020 10:52:29 +0000
Received: from SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::24f3:9231:b6e0:a13d]) by SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::24f3:9231:b6e0:a13d%4]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 10:52:29 +0000
From:   "G Jaya Kumaran, Vineetha" <vineetha.g.jaya.kumaran@intel.com>
To:     Rob Herring <robh@kernel.org>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: RE: [PATCH 3/3] dt-bindings: pwm: keembay: Add bindings for Intel
 Keem Bay PWM
Thread-Topic: [PATCH 3/3] dt-bindings: pwm: keembay: Add bindings for Intel
 Keem Bay PWM
Thread-Index: AQHWLFMWxOs5K3yRNUahZDevv1/7rqit5qiAgALpcpA=
Date:   Wed, 20 May 2020 10:52:29 +0000
Message-ID: <SN6PR11MB25752EA2FF75768D84C14360F6B60@SN6PR11MB2575.namprd11.prod.outlook.com>
References: <1589723560-5734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1589723560-5734-4-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <20200518142143.GB3594@bogus>
In-Reply-To: <20200518142143.GB3594@bogus>
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
x-ms-office365-filtering-correlation-id: 9d3d81b3-afc5-4ec7-c12b-08d7fcabe46b
x-ms-traffictypediagnostic: SN6PR11MB3149:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB314926B93E7AC39BB7B80EC5F6B60@SN6PR11MB3149.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UGeDNBSpqpKaJL2FOoyD7wpuGKGRZQlihjJSaBIhE4AYdgQLmvnnLnY/Sq55c17D3zkguiEp4HL1aJy15K5S9hX1LwqHBNhDXBR1VkXOeDTBwYKGVUXcadJLjjhz9WmsytVfznd4v6f9Usy2hjxVGBhY+VNafen+8TFEljdWerzr/5L+aXPGnKlj5NRV2T0dWt35NZNuz32pzUeTjOP9l3tyua35JsyDIEtrp6qagBDMSZY6twwJ1u4ys4YuhGuJDpljSCKty/WpUPvAtb7LhgJNbvTR44pOQA4y+E034+qhkM68oJiKnNVIZkQQivORk4oEB1T7njivvabn5qCLhcXRrL+UpVLfelXYzQWVXuN9+PGuiH40fSW71Zd8JI0pfbzjpmZ+MgbSxzJvFDUyFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2575.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(346002)(396003)(366004)(376002)(6506007)(107886003)(53546011)(5660300002)(71200400001)(6916009)(966005)(4326008)(478600001)(26005)(9686003)(7696005)(86362001)(186003)(316002)(52536014)(55016002)(33656002)(54906003)(66446008)(8936002)(2906002)(76116006)(64756008)(66556008)(66476007)(66946007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: iLrVZh4RyWp6wGlD1vGNp7lCxBPdhnujaZS6YnExY+ZiHn/Q3WRkeiMHR4EBuwaKAq5p0HzFdUn8tSDkvycgi96lSyeRhBV0QFwC64/k45DVlGbBkf7lop+3YVgwCq8/kE0ox9yksawfLVcf/5VIQY3i+pRy7JCzWKEF3piZaZWU/dwi7E/Afxiv/VY84QD3QqUSUobPbUqsorqx/LPtB71h9Gki8KCMmuxv4RBBu13K37cPwELyR4hGcvEusn7shR2VAo2c8JKczFDm0jKphOo7ii/YBP77JVOAYZIneGPEYbYwQHBUzJ/qiooZBSvzK1fyKOsYLOaa+ONuM3ZV42q0BYLuOovqcsQEPDTM3NbVluOEm7u2DXdbtPgHoovsnOiIE96DF/Zy+90LHEEVnnw7gStx5hzwwP51d9VUXcwupyaipcCJ5/wc8b2saE98vA2lo6Epv56cHC70HbTI7PPApOpXLwmXvw4+1ffdXXRGAPjALz2TqyEbqYyMCqf9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3d81b3-afc5-4ec7-c12b-08d7fcabe46b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 10:52:29.6179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUGZPhvbzsSOGVQS4wTUZ+IBAaNeCPpc/8gu6T8LV1Gjdu02xfH2RFdhDVCnEgyScTAoLDMWoBo1Ql7tXp0vSZ8YtiNr4P2ehkQxk47MgK99+4UB0tGknBg5e7byLoAN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3149
X-OriginatorOrg: intel.com
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Monday, May 18, 2020 10:22 PM
> To: G Jaya Kumaran, Vineetha <vineetha.g.jaya.kumaran@intel.com>
> Cc: thierry.reding@gmail.com; u.kleine-koenig@pengutronix.de; linux-
> pwm@vger.kernel.org; devicetree@vger.kernel.org; Wan Mohamad, Wan
> Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>; Shevchenko,
> Andriy <andriy.shevchenko@intel.com>
> Subject: Re: [PATCH 3/3] dt-bindings: pwm: keembay: Add bindings for Inte=
l
> Keem Bay PWM
>=20
> On Sun, May 17, 2020 at 09:52:40PM +0800,
> vineetha.g.jaya.kumaran@intel.com wrote:
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
>=20
> Use compatible string for filename: intel,keembay-pwn.yaml
>=20

Will fix the filename in v2.

> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-keembay.yaml
> > b/Documentation/devicetree/bindings/pwm/pwm-keembay.yaml
> > new file mode 100644
> > index 0000000..00968d7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-keembay.yaml
> > @@ -0,0 +1,39 @@
> > +# SPDX-License-Identifier: GPL-2.0
>=20
> Dual license new bindings:
>=20
> (GPL-2.0-only OR BSD-2-Clause)
>=20

OK, will update the licensing info.

> > +# Copyright (C) 2020 Intel Corporation %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/pwm-keembay.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Intel Keem Bay PWM Device Tree Bindings
> > +
> > +maintainers:
> > +  - Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> > +
> > +allOf:
> > +  - $ref: pwm.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - intel,keembay-pwm
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description:
> > +        phandle to the reference clock.
>=20
> How many clocks? (maxItems: 1?)
>=20
> You can drop the description.
>=20

1 clock is needed for this case, will add in maxItems and drop the descript=
ion.

> > +
> > +required:
> > + - compatible
> > + - reg
> > + - clocks
> > +
> > +examples:
> > +  - |
> > +    pwm@203200a0 {
> > +      compatible =3D "intel,keembay-pwm";
> > +      reg =3D <0x0 0x203200a0 0x0 0xe8>;
> > +      clocks =3D <&scmi_clk KEEM_BAY_A53_GPIO>;
> > +    };
> > --
> > 1.9.1
> >
