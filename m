Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E39D22E51F
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 07:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgG0FOh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 01:14:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:49279 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgG0FOh (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 27 Jul 2020 01:14:37 -0400
IronPort-SDR: J8PSrQdwkLyZtxNztW0gJ37VQLkq7/emvL+qzN0PGwI/9Xy7eCreBg8DP6eGWi5tVu/zqZZpc8
 sdNzwjSvHz5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="169069352"
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="scan'208";a="169069352"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 22:14:35 -0700
IronPort-SDR: YmhIz0kdxL0fGzemq6Yskj9l+oADETJ6n4rrlOeQgDJM4S402rRVdXFl9s42Hm1Fdj8U8tiU0a
 yk76PfIsXeaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="scan'208";a="327901963"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jul 2020 22:14:35 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 26 Jul 2020 22:14:35 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 26 Jul 2020 22:14:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sun, 26 Jul 2020 22:14:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKwTU5TtZnbj0hiysuvWgv2QCfAky9PFa2gMAj/mbk+/G/KkGMI+gtUNgxcYsltMQ39+Pi1i9lubqlmw+wVzgbQHLe7JxH6Pd2dtB7OH4zPEUjQpvOljUomMRfeANnKDdiMbFSH7hh5A6aKX8taBuC6mTnOT0nLwoteMEWT8ux5xKfGv6Dwv9HuhY+f6PWfcfibPDpZvYVT017livWyM22VijyLPihZ989ssnXY/BRKIsjp+gpztGC/u1bE7g8CLvAjQnSufSgHoHmb5gKduEyShhwbCCNwwt2BLctWRH55J/qGqaT8SPCIdUsWlNiHE/McCTOhQyatUREXtiJjRyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EB02JPaLOaKnS8YkasV88eipd4b5yUHfWDoi3iP97G4=;
 b=SrpdACAJy3uMsJykGYzuz0dEdrMnsiCWvL2ZG8HtjESxXlKzOeIjmn8WBrZW0VCW6miEN2fJU2HmgbgNyShQIVN4fuH861rH76t9YJmPhB6weKgJpU97v1FkZREgTjfQhuVZKiAjLUrggwNqg77XkbHYBLGeiXDdJgt9ZillA0nQXERsjskD3vdE6PtusZJBovFoD5oZu9ILK251rZdEDGMfdR3KcP4CjdOlU6Jpo0+ZuAhdcH26J26EERV4Pv/0CGsY/slBQvmUHrGuxIcUBhiHKBWQfrcoa3xAOTxRu8XVi1Z9K23499vc3oHFN12lBmZ6Wz/T2g8LyeR4/I7+dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EB02JPaLOaKnS8YkasV88eipd4b5yUHfWDoi3iP97G4=;
 b=qfYfHkNfpC0Fd/hNawxD2KMyuv95GmTagb8OS7FNikSqMFzwCQStJllZfqTvmVgHqPbhd/taLrjehqF9l8BxGiblCOz9OY6OCmJPF7iPSTDleYCRbSBfYtnWEJIYD5HPj5991N+36oh2vuXl5/gZ+MaHsSayrVU75MgoPDRMGJ0=
Received: from SN6PR11MB2575.namprd11.prod.outlook.com (2603:10b6:805:57::20)
 by SN6PR11MB3391.namprd11.prod.outlook.com (2603:10b6:805:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Mon, 27 Jul
 2020 05:14:33 +0000
Received: from SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::cd49:6ea7:530c:95e0]) by SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::cd49:6ea7:530c:95e0%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 05:14:33 +0000
From:   "G Jaya Kumaran, Vineetha" <vineetha.g.jaya.kumaran@intel.com>
To:     Rob Herring <robh@kernel.org>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: RE: [PATCH v2 2/2] dt-bindings: pwm: keembay: Add bindings for Intel
 Keem Bay PWM
Thread-Topic: [PATCH v2 2/2] dt-bindings: pwm: keembay: Add bindings for Intel
 Keem Bay PWM
Thread-Index: AQHWXRK6rU+Xw8EsCkKh4s3bmFntnqkVeGSAgAV2juA=
Date:   Mon, 27 Jul 2020 05:14:32 +0000
Message-ID: <SN6PR11MB25755A006A1DA31727F2753EF6720@SN6PR11MB2575.namprd11.prod.outlook.com>
References: <1595083628-20734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1595083628-20734-3-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <20200723174701.GA584130@bogus>
In-Reply-To: <20200723174701.GA584130@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [202.190.91.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a78a2915-5f30-4f3f-b7b3-08d831ebf2b6
x-ms-traffictypediagnostic: SN6PR11MB3391:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3391655C11C81BC09F7571FBF6720@SN6PR11MB3391.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AjjbvtXhRtfAFnu+JOidfXBsa17Q/KQ+mEYjSlgV7YmtSvvn1tWN+QPfUelnZ6lzXN3iN4LHIN66DeCEK3ahZRc8cbhfGmHZH0ZlA1yq78zR+VQf+9cZ7mmCYTt/rXd54zDSiF7peXh/oxcWu4bXrp6/K6mx0neTjQeDY0iv2hKFrfaIZVhmQb7G5i/XnkB857D5AvO23PHwWc38loeK2a07nhc2OXSV7MHlPix82V8CzNaedCXykUEv+BeH+HVvZ6VnUiiTad7I2YUHbiYNRQMjleSTuMYtGBE/+QrkA2fwJ4jlMNe1Hm26cpb+XeQZ2lsBjUTAOTePWm840GA0e+oyKUuX1q40eOXsi955SaLBwJluzJYbDNCMhZUONjeeSlISUlrvsl/Wn9ubInnVjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2575.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(76116006)(4326008)(66946007)(66556008)(66446008)(7696005)(64756008)(6916009)(8936002)(33656002)(66476007)(71200400001)(9686003)(55016002)(2906002)(5660300002)(53546011)(52536014)(86362001)(966005)(478600001)(83380400001)(8676002)(186003)(54906003)(6506007)(26005)(316002)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: F6/jW7AkT8hKuxh3A9sobs9WJsXECCaJcscTXGKefglmdhNW71RLuJ28yCFNJ33Rs6dYTWjC0s3AFcP+PubLheYkkh5O1cbd1QRoGFlxX6uhfMMXKMksKIEIs8Vr2CYSMMTMdUFRnk/ld+ksOgiLE0B75Cmwy0KrIuLAo92lFbRoDsHUaZaauirmq6l9LmBa3op5NEULRdRFN9asfI7qAaVZzTROrmPF+B3hh/6EihI0HkpLX3qLTOx/rjtRxA3I5mOjHYJasXHnDZqBBvbeNLOI6ZkIkuxGC6sAbcxrnQfvhLsFFyJawlnKgRDFiOtbBPE0G2DTpUbr72mpczqHW9Zc8mVWBSIou32KAhzGNjw1wkEZa6uuBfs4X9J++g9P+GxmrcxILyLjxv6sHkcSZd0jOic4o9Cg7KIj6NvWFsGW92S1qT1T50ta/OOkM6wCCxMbjZroYEW9imaP/p+7jT1/PrRJz5XrXbVBIRssicrpjxFrAf+Z89ZsRCmPUNGz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2575.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78a2915-5f30-4f3f-b7b3-08d831ebf2b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 05:14:33.0162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qdpt5WO81NkgwvDUWw/5CJv9J18udpvXup+6+LSWHHYhdpaZYZvRatfaueIFT/hYSmliuzOImUDMwa0eIEnerHnPqjoYjwygOQIF+QyvR2hCSGmwnu5AmZWHakRTQha5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3391
X-OriginatorOrg: intel.com
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, July 24, 2020 1:47 AM
> To: G Jaya Kumaran, Vineetha <vineetha.g.jaya.kumaran@intel.com>
> Cc: thierry.reding@gmail.com; u.kleine-koenig@pengutronix.de; linux-
> pwm@vger.kernel.org; devicetree@vger.kernel.org; Wan Mohamad, Wan
> Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>; Shevchenko,
> Andriy <andriy.shevchenko@intel.com>
> Subject: Re: [PATCH v2 2/2] dt-bindings: pwm: keembay: Add bindings for
> Intel Keem Bay PWM
>=20
> On Sat, Jul 18, 2020 at 10:47:08PM +0800,
> vineetha.g.jaya.kumaran@intel.com wrote:
> > From: "Vineetha G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>
> >
> > Add PWM Device Tree bindings documentation for the Intel Keem Bay SoC.
> >
> > Signed-off-by: Vineetha G. Jaya Kumaran
> > <vineetha.g.jaya.kumaran@intel.com>
> > ---
> >  .../devicetree/bindings/pwm/intel,keembay-pwm.yaml | 45
> > ++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
> > b/Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
> > new file mode 100644
> > index 00000000..e9388a7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/intel,keembay-
> pwm.yaml
> > @@ -0,0 +1,45 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) # Copyright
> > +(C) 2020 Intel Corporation %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/intel,keembay-pwm.yaml#
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
> > +    maxItems: 1
> > +
> > +  "#pwm-cells":
> > +    const: 2
> > +
> > +required:
> > + - compatible
> > + - reg
> > + - clocks
> > + - '#pwm-cells'
>=20
> Add:
>=20
> additionalProperties: false
>=20
> With that,
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
>=20

Thank you for reviewing, I will add this in V3.

> > +
> > +examples:
> > +  - |
> > +    #define KEEM_BAY_A53_GPIO
> > +
> > +    pwm@203200a0 {
> > +      compatible =3D "intel,keembay-pwm";
> > +      reg =3D <0x203200a0 0xe8>;
> > +      clocks =3D <&scmi_clk KEEM_BAY_A53_GPIO>;
> > +      #pwm-cells =3D <2>;
> > +    };
> > --
> > 1.9.1
> >
