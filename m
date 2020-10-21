Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C5929480C
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Oct 2020 08:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408525AbgJUGNN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 21 Oct 2020 02:13:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:13201 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408517AbgJUGNN (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 21 Oct 2020 02:13:13 -0400
IronPort-SDR: EKXAWhK2pdpJPrsQwdcZfG82EAAFkEytN0pP9AqYqdGK4dtp/c+5OK3X3KH5n0tSIkpXxcAKIy
 9agtqg31a42g==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="166543325"
X-IronPort-AV: E=Sophos;i="5.77,400,1596524400"; 
   d="scan'208";a="166543325"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 23:13:13 -0700
IronPort-SDR: i5+2yFc6R/5reZGxYnyH0o7cNiRRwQrhifDhrjyGPP7xgFijLQty06b7gJF11OMz46ciOEh3SJ
 gyF8MdbmA2OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,400,1596524400"; 
   d="scan'208";a="316271408"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2020 23:13:12 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 20 Oct 2020 23:13:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 20 Oct 2020 23:13:12 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.52) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 20 Oct 2020 23:13:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhkaSLMmGVXPYRpEEZZj+W303WVE6eFA6bf6YMgFIdLuhEfcEUrTnmO6lDPHvipQplls2g8fpcRVwJ86WIMD19v2/BLTSyQXxRRLv+bw2Wuq04dblV2Yh5kRGnHMSZJXcD4aVBBclkdRMB9HYjFNVF1CnTKV/UfD1xgap77t4LgjvxhRXjWvVK6p1nhOZzy3zIeU2DkEjBwe5jQpQsmq/8Cf/k3Ka1JslnjdavsF+f2Gn1dBi9z6QCP/QMHmiuCyxJeze5JUdNBvA7VD77P9ZFyFSx/Gu+3miZV4RzaO/IlNqIztpUozbsgOIUh7pz/kLTGMGKYhaRr0hBdC13PrjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWvENyPOB10ieoSEWxAIEnpm0FS4zLzsm6jf+1Rlby8=;
 b=HBhJL2ran9hJ8N50hJcGJ/ZQTUeBL+45dxYKUQ/ZmLF5nwygGyY5/nMb2ApAsyqr4+DjWnkwQO9FyNWG2f85pxN60YiL/voqHZiVvY3WKzAFr7nqyQU9lHpR/8TW4gA+P3DVXKSmTxnalnlmlI+LmOWFPE+OypoQmABZpkcGAoVz6gq77nn11SiWBjX+murEiDNyLlNfuoGTmyKSiHGGs6v27lEAbFglCCVcffyXhzIhKDNse4AQa8sE8SrgoPldXwQsDycb0uTyHEXHCAAN87HuETbVju+c1YC+u5jorsvUyCU+4Rvi7J99Sy1GJJCWcYnI/4glVElN/MF06QwCAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWvENyPOB10ieoSEWxAIEnpm0FS4zLzsm6jf+1Rlby8=;
 b=RIBX7aw+4rH2lfrytqblaDKXps4CujwVrtczAHqWbwxcKXstncWfG1/t9tUkqGCrW6C4vKUR8j5UWzlzoJE5XOnk1rRP2+5YECNHXm+aqwImqSUhA36Wp192O5trmoyboNcM/lrL1cEbbnwNq0mouxetTOpQumPMUssDU+h4EyQ=
Received: from DM6PR11MB4250.namprd11.prod.outlook.com (2603:10b6:5:1df::18)
 by DM6PR11MB3226.namprd11.prod.outlook.com (2603:10b6:5:59::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 06:13:08 +0000
Received: from DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::7448:c067:e80d:3c09]) by DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::7448:c067:e80d:3c09%3]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 06:13:07 +0000
From:   "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
To:     Rob Herring <robh@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
Subject: RE: [PATCH v13 2/2] dt-bindings: pwm: keembay: Add bindings for Intel
 Keem Bay PWM
Thread-Topic: [PATCH v13 2/2] dt-bindings: pwm: keembay: Add bindings for
 Intel Keem Bay PWM
Thread-Index: AQHWpj3FMJeofmusy0SNTFw1Uv49Aamgna+AgADzZ5A=
Date:   Wed, 21 Oct 2020 06:13:07 +0000
Message-ID: <DM6PR11MB42501DE5DCFB16433F1E38ECFB1C0@DM6PR11MB4250.namprd11.prod.outlook.com>
References: <cover.1603127898.git.vijayakannan.ayyathurai@intel.com>
 <48f86a9a525701cfc61e3375d1d6f65ce38a9b26.1603127898.git.vijayakannan.ayyathurai@intel.com>
 <20201020152421.GA866676@bogus>
In-Reply-To: <20201020152421.GA866676@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.111.145.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a506f70-351e-4344-268d-08d87588611e
x-ms-traffictypediagnostic: DM6PR11MB3226:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3226E8AFA86368C61A883BE6FB1C0@DM6PR11MB3226.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aah3TMiWe8UF9FVZwkXP6GmWEFd3MczvQmjvZFOKhpK5vp+bRxywqlZ/y8V6qsO8VkUsMF9p7g1mfFY9VCWOclrPKUI7frUiAK+oYgjyfDNkoYxGPRAWCNqOO2bTQHq55gzjAEDOJdXGznvn2hYWd3bA2jMoYmY9kvRabdrDJsbLoYdFCSEK7YBEtVUBEzsMKmbAG8Z+VHRLAylA/NM/cflx8mG+LxGmdOkrKnjYHt9Lyv49KiIDjh219GfH20W2881dwBaBkwS+r5Bip88dyBrETLtnUJAXp271aAKT74lW/s8lkutsWVhxn7pbAHdZRchh3p1GUqNt+ed5XhhcVnCbyyk6YS1NrbxPMcenggHv3iFWBwTt2ECHF7bzEBXUuTdjbKMAk/v6ITa3/dbieA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4250.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(66556008)(66476007)(66946007)(64756008)(54906003)(76116006)(55016002)(5660300002)(86362001)(4326008)(316002)(52536014)(6916009)(478600001)(66446008)(83380400001)(9686003)(966005)(186003)(33656002)(8676002)(8936002)(53546011)(6506007)(7696005)(2906002)(71200400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7qsAjUFOxrwWrUyhmJEHP3YNBeTogxZB+JD3oVt1NVEzmvpaDyrdGjSVyFqx2o+cRxTh/dziQOcHWbfwH+xtXILZid9TUWgDNd5PKX2IVSLZkSGmzxESC58JOeXTbjzIA1s1dJmqE/AAjMC6atqHfFIYT8iHDQ8HXilAH/FT4JVKczYG5L+nTetXZOu1YU7ZqrwsAVZ8vxc57QQpvyhOh7zbAmfXLcXey8XLqtyXwNH34NR37INTZERXf+p1yviotoYk0BtS+7LiPJSuFfjcV6fA4gDsVRVVCVOYj/kFKL78K8HI+TD2nZljJfXHAqoqCkpd+nHgnwHC8JBBPIZdQDTiCSLnwvzZ+krsTSR+OzYvqWyz3HjJIklmr7lixE/F9oO97uYlSf5ZR88S+X/hA4jDyC8PlnL/U76WAAGNK8M8uIAF82Si53zo7H7pozpAMlhIZU54ZSP0NTUDCptrkknTYOsyePp8gMwityZZMjCdjWsHuOk4lGkH4gvblEnXtszxowEN5398pD/3vS9BijP5Uu0FD0aaR70qA1MTNE9Fvgxz5Y0p3cY1UJOgk+haVOV1+gM2vklLH5u6dY9KsHISLiZM7T6PESgFoZsg/Ha1tAgKM4ejCtTRSJvCfTRYL8r5KbZcWbAygJNYjtPEPQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4250.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a506f70-351e-4344-268d-08d87588611e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 06:13:07.5704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ++QD0UdFSgAUCaixfADswO8TsmV4rm6+kktEyCYJYphB0PJF6qEIdDXeln0VDpFdD16+ri/AqA87Kt0mbPqbKC6OZEbOw9s8t85EXEhURGeRNvhGUiN1Rzy/dEGSogaA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3226
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Rob,

> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, 20 October, 2020 8:54 PM
> Subject: Re: [PATCH v13 2/2] dt-bindings: pwm: keembay: Add bindings for
> Intel Keem Bay PWM

> > Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
> >
>=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> ./Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml:31:2:
> [warning] wrong indentation: expected 2 but found 1 (indentation)
>=20
>=20
> See https://patchwork.ozlabs.org/patch/1384452
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

I will fix this indentation problem in the next version. But I couldn't get=
 this error when I try using the upgraded dt schema.

Package Used:
Successfully installed attrs-20.2.0 dtschema-2020.8.2.dev4+g341f3e3 importl=
ib-metadata-2.0.0 jsonschema-3.2.0 pyrsistent-0.17.3 rfc3987-1.3.8 ruamel.y=
aml-0.16.12 ruamel.yaml.clib-0.2.2 setuptools-50.3.2 six-1.15.0 zipp-3.3.1

Command Used:
#make dt_binding_check DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/=
pwm/intel,keembay-pwm.yaml

Please let me know if I am missing any other option here.

Thanks,
Vijay
