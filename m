Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7BA290C55
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Oct 2020 21:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411084AbgJPTev (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Oct 2020 15:34:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:44172 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404154AbgJPTev (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 16 Oct 2020 15:34:51 -0400
IronPort-SDR: RJlNfLosXyKnlazZiOrlkXrsi3aGLmE4hCtrucIMoY7Hw3udASqryp2D0OWvwDenElAdp9l3M8
 biFQ4KI0qUfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9776"; a="184255182"
X-IronPort-AV: E=Sophos;i="5.77,383,1596524400"; 
   d="scan'208";a="184255182"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 12:34:49 -0700
IronPort-SDR: 80bhafxcWp51x+rPStdAP+/6mhMdjNSLNfN56PA7lP/dtt1jGEMnRodr7+awRLtG6bBOxeZXyZ
 Uuz9Qun4zWLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,383,1596524400"; 
   d="scan'208";a="347310878"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 16 Oct 2020 12:34:48 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 16 Oct 2020 12:34:48 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 16 Oct 2020 12:34:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 16 Oct 2020 12:34:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 16 Oct 2020 12:34:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTXGPzQxd6EWFndjgIPAl9D+dg56fs04CM9gfKJN81sphyrYEx/5qbP9KBHzrfjgZiS6dLbE3JHzGJGQdhirTsdW+84EgS3zaDZWx7eR9cV3R3Lb835QsSUtyul342SUNWtIp7wpfczCQF8gBmRC3mMONsnu3RHfsPvXUS1zz6e6qzv0oN3GkA8QUEFk0b+CWQnXgAUMksCuHDn1bZY2pg0cZHDduejLSkh6m6l5bgUau5Z11xRHuUQwWEsesi65Yd89bxgEKiAQ9QfoizsJOkSSsMZC1gtxvI2Yd5Dz7Del+YKidqb6BDKxMTh6meJe0b16YSPcXz2VDjD2zR7oIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12nvQExtr50pOaTGi/DAIbLGO10do3DOCHYOhFg+m9E=;
 b=ZHGGIEvE4PijAyiYAyAOzY/R1Vhq7yF6ZU25K9Lxp/OiyMf4VLGmgIZzeiuHL2iRGlwMn1wlSRN26wJTIta511LgXHjVW7QCKGuw3ntWxR/fqnvRmELe7qt8uoykmy8a0Pk+t40XA5q8JpIMsxGQ//TMGeuDabu8+ukg5kNFnEDOQTRM9j2Iy5xKyKmclBLTDkv30Q4SpcYQkX1ECbju/NG494Ou4b7Bu671vZQkfkmPMlCQKNi/0u3uq8Ny2LLUswyIZzJ0n9a4Ao6KKY06XLhWdmmhBzK1y+i9zheC6FEuwt4Mjt4atedxK9EZ2PwbDhJCUhTnxXDaMjVH5fTdGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12nvQExtr50pOaTGi/DAIbLGO10do3DOCHYOhFg+m9E=;
 b=vgusvKWJd2Gv+/4wnlqHK3Bh2dolwWgHy0m6zERFTfSvNa6Gkhi9v4sEXgoAgztTtCCWZoEvzTMx7mDpOgCVaG4brKhYIywBe5eYthAI2+gmf4CuKWcprg3n6cth34Kscv6JkapG9TfMLq1Pb4FXM5VCG7GWeb7nDIuOHk5oTXI=
Received: from DM6PR11MB4250.namprd11.prod.outlook.com (2603:10b6:5:1df::18)
 by DM5PR11MB1529.namprd11.prod.outlook.com (2603:10b6:4:b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20; Fri, 16 Oct 2020 19:34:45 +0000
Received: from DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::7448:c067:e80d:3c09]) by DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::7448:c067:e80d:3c09%3]) with mapi id 15.20.3477.021; Fri, 16 Oct 2020
 19:34:45 +0000
From:   "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
To:     Rob Herring <robh@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: RE: [PATCH v12 2/2] dt-bindings: pwm: keembay: Add bindings for Intel
 Keem Bay PWM
Thread-Topic: [PATCH v12 2/2] dt-bindings: pwm: keembay: Add bindings for
 Intel Keem Bay PWM
Thread-Index: AQHWomCA7sFNiWVj5kmPMUKML01ry6maZzWAgAA5LmA=
Date:   Fri, 16 Oct 2020 19:34:45 +0000
Message-ID: <DM6PR11MB425044445E9997B8F8F3A5F2FB030@DM6PR11MB4250.namprd11.prod.outlook.com>
References: <cover.1602703463.git.vijayakannan.ayyathurai@intel.com>
 <9cff78f955eb7b1f243380c79cdd48aa6d2ddc81.1602703463.git.vijayakannan.ayyathurai@intel.com>
 <20201016160409.GA1494813@bogus>
In-Reply-To: <20201016160409.GA1494813@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.111.145.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4dfb493-de67-454f-54e7-08d8720a89bb
x-ms-traffictypediagnostic: DM5PR11MB1529:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1529CE5B487F4923D30DA9F3FB030@DM5PR11MB1529.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sA8H1kenvIBrNtT0KWrKjAZvl6rbsf81pH7ch9aLDMqEp3uJeyUQ/WADFhoBzvX+cQRDh4ZwnY9q0Ts8tj3l7JfQEbK6KQc8+L1PwYbp9+YLTqydayly5sfEzheNnho9imRxqMNKl7xQZ2D43SD2MXLRI/5Ya7hbGySJh3T/Cgek2HFRMmhysQzQ672s5ZImY1jFErAn0UaBHd29Ro53xPeOCm/BCdcUhn2SIPahFvg+C7zTBlfhLPp4Ohc8JyAEYPXG12RR5Pyqlqve9v+SBhcAV9maII98jrtEnXDExPYxy0PE6uOr+Kw/HeVxsIy9ZV9WujJsCWbr+n77W40nSIjBsZwHKKTtTE+pg1PEDsN+BCnzGC5AhvMex0Jt/y+bJIijWO92hjNePjUSyXsfsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4250.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(66556008)(2906002)(55016002)(64756008)(54906003)(316002)(8676002)(86362001)(52536014)(33656002)(6916009)(4326008)(26005)(186003)(966005)(9686003)(478600001)(71200400001)(83380400001)(8936002)(7696005)(66476007)(66446008)(76116006)(5660300002)(4744005)(6506007)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 0tFvDqF5fI0CG1ksdmz4hfzpMmVIa36cMUDAsxtGAKTbxTpb79Fucm37og8x6AtXG2ei+5CImBTcsNbc/uIPAtBMq89pQiA560HAKhRH/o49knT7DLQ8/sbDhQHcSVhnCfzEVOxgHCigFKKpCUrMlguihonGglasZzZlpWneZf+ksyPyZpD0AY+jqHZOxh7ZRHWaMxPUCRsuhkkQVEYebaR4qkMDHTvZbj4gOLf5h8EO82VSSx+8kExctYbKhyG/L4WS1vPSTG3W8nADfklcm76fkQcHql+PP5uu7QfVnTf0nxXhs0zOTzs2o7p3AOxdk33GWFpsxJDGsZUnUFvYPjJqzMuAyk/d5d0DZOBAmrO/Y9P7/bqz3qLRNjS5G2OOlrIOo91Br3XkFnqsQSCslCkauqNPSCj8+FzVN8GQC/7pTHKBTmmhH/6beH/bR4lafeqTdH1/c9IEQ51yjPDspAt9bKWY74G9FHDkramTI6wly9TpBZptNjlADPGPJ3kHPrVFcvRi5WLDTAW+M+N6fx8us0k5nE5PC6PfxJVR96t4N9gmtnuIKb4zm7OLZETINSbNaAf75uKg+oH8dq3uYkIy7WKi2aqPXtWWaKBoqVtPXw5YYZLjkSyl1rnnbCqZCfOuzme26CZcus1DzUAAcQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4250.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dfb493-de67-454f-54e7-08d8720a89bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2020 19:34:45.5642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V1FlEKjICd0/aIc4xa3lVS992FxSF7ryVXaP1TCCZ0S70sYK73oU+vQDtbP54jnV+EtEQz01K+AqIc4/qughS5VscecT5IGn+F+mtrwW8XtYN45NQ51IkjjQTOEKNfdO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1529
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Rob,

> From: Rob Herring <robh@kernel.org>
> Sent: Friday, 16 October, 2020 9:34 PM
>=20
> My bot found errors running 'make dt_binding_check' on your patch:

Ok I will check again with upgraded schema and incorporate the fix in the n=
ext version.

>=20
> ./Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml:31:2:
> [warning] wrong indentation: expected 2 but found 1 (indentation)
>=20
>=20
> See https://patchwork.ozlabs.org/patch/1382326
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

Thanks,
Vijay

