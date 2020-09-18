Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B779026F64D
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Sep 2020 08:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgIRGtS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 18 Sep 2020 02:49:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:41598 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIRGtR (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 18 Sep 2020 02:49:17 -0400
IronPort-SDR: 2neD4BOhGjq7nqQV/8lK9JhY5BWzN+jfzojhY1pKs574HhxTkczL+l6B8dKkMdlO6JKEcfqI0F
 p+d1Xy9Iwx7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="159928514"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="159928514"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 23:49:15 -0700
IronPort-SDR: k2gK2acwbQJMYPTHLYVqEjB7XTp0fNOqEUcpovNjMGU78+Hsn5l8sDK2DXr9GstvJrcJHsJdHw
 zbhBxZS/ONmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="339702383"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga002.fm.intel.com with ESMTP; 17 Sep 2020 23:49:15 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Sep 2020 23:49:15 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Sep 2020 23:49:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 17 Sep 2020 23:49:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 17 Sep 2020 23:49:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0xImQBTWen8xxGfEucj07ICPqFyOdpawEIRCm4NBINV0mLN6SPorBGUsiQ97B6gFA8OWJ+1cMfnn7dEbLjf78I3Fa/Rn8O/vi/dWy383tg83PdWKKw77MBNN4eSuGjPGXTTY4OfNmZqP25K1asm8vujj3cMrV4AICxjqhGs5HPAydFz6BPHFGskGAuX2ExEcE7VbPDw2Q5Ug9W5aYVuiBRCC/W0hR3RmCMIYvWQgKIfuCjCosL0UBQ8PrGwDu+pUbFuNXMhVDiyI8MkxlhOj2WTT5wS6wR6z+5WqkRhUIkaxsTahh/WZonREXlwAmgbX4ZVaupJ6rb8fDdlHES+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps6bzA9eK3+bxMAo5J3bewQxc0W8e8GHACu+2nga/T8=;
 b=nWBGypplGq3Mp7YZikFwJnJUkZDrfl0EsSVj5fpQmmv0sbp7y2sgfnXjnJeCaksTqPEmbH/GpHWK7m3iMclDFUBuX1A51FpjXet6i9M8gIWNXwBHwEW+cFIbeSDPlH1arXWMwhn8cmkK3PSY4gqfsR83Gv7cTMY5Cw9CSr3/vIQ5KopbtVxwyt2HOT8qMMxIWyjkQ77lUN5kLZYfj4+ZD4aPivOJQsSqsly+WaIxHrfKPynhGgOAubEnRgm0/PuAjZHy80fuauOtpiAU1fDDdMWJNZFMlThdudEhO0lV30n3Ul9ja9rPWaSFgboLXb7KM+jhZpfBKefL9bvt4rnTVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps6bzA9eK3+bxMAo5J3bewQxc0W8e8GHACu+2nga/T8=;
 b=S2jF9+FL7YrhlQgn9QCL3Rq2I0x+YwoXGZfdt9i4tUp7Kmrj54uk8ZInvUzE+OF3fwwDOhmJ3CdCFyeKbp3e8x+kD5eY0vQTQweerMd7lHkGff+ycMIhGBn83KLBfzZLQsQnZDOZZ6NasSvhP1mRLBydhLcaqEsD5WCTOQ9uDro=
Received: from DM6PR11MB4250.namprd11.prod.outlook.com (2603:10b6:5:1df::18)
 by DM6PR11MB4300.namprd11.prod.outlook.com (2603:10b6:5:1dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13; Fri, 18 Sep
 2020 06:49:13 +0000
Received: from DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::7448:c067:e80d:3c09]) by DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::7448:c067:e80d:3c09%3]) with mapi id 15.20.3391.015; Fri, 18 Sep 2020
 06:49:13 +0000
From:   "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
To:     "mgross@linux.intel.com" <mgross@linux.intel.com>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: RE: [PATCH v7 0/2] Add PWM support for Intel Keem Bay SoC
Thread-Topic: [PATCH v7 0/2] Add PWM support for Intel Keem Bay SoC
Thread-Index: AQHWjTV9TLiZaO2qqEyeArSN+HjUI6lt8vpg
Date:   Fri, 18 Sep 2020 06:49:13 +0000
Message-ID: <DM6PR11MB4250D2357EF1ABFDF5D8B0F6FB3F0@DM6PR11MB4250.namprd11.prod.outlook.com>
References: <20200909162719.7585-1-vijayakannan.ayyathurai@intel.com>
 <20200917205942.GE4535@mtg-dev.jf.intel.com>
In-Reply-To: <20200917205942.GE4535@mtg-dev.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.111.145.14]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85cd6205-ee4c-41bb-b0bf-08d85b9ef490
x-ms-traffictypediagnostic: DM6PR11MB4300:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB430005A0C86CD36BBD5D2C7FFB3F0@DM6PR11MB4300.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:207;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4MzmJ+q4L3iPcCHtKULT/SwVjUm8+Bp1Sa7gAe55li4gyIJk/KY+J+CbWXSnd+TPMwvT87fL3OhMBIWNi1uIF/w0lyWGT0zjh+0PDQpPWbwkRkEENk2T5CKpcQD6mUwzEYraf62AChm97vldMey1uSmbXxg/fHXuluUcLAOi3O1DbtL5CBQGa581jaQU3mcBn+nocKEAXT3vcnhZiYSq2TxJ+ZTXChb/70d5BOPY1PU1T4NXrCLAAU0xoZvEpCH1sUqiqE0A4GulnmNBSYDKPaL2NHs89zTkxID1QXuKWwewAwa8ffXK0Y9CO/yN7RTVck7GdSu/fZP0R0XGYIopCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4250.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(66446008)(64756008)(4326008)(7696005)(186003)(8676002)(33656002)(9686003)(86362001)(316002)(6916009)(478600001)(26005)(6506007)(71200400001)(5660300002)(53546011)(54906003)(66556008)(55016002)(66476007)(66946007)(52536014)(8936002)(83380400001)(2906002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: rzMJPge9yyCSCzCfdAfl+q/8HXnWO7adL9jy3oak8W8X6v/lmduTSFvuzICMREwHaTZwNdBPA07hKOCDIHRLv7LMjCZjPPhuiYIN9MSQ+4Nj3X9ydJO2+bZDLdnJcC5jC5gZ8GfDDtTcY8EOKV/O0fFvRwmA9e+tAEDBKGVFPkbA44b5bj++TIzbLkG7FjfqlSOiRRgJMGyMGVfDkCZySgL91vmKot37O++qPxMGrhCp2vzgGaC+SXI1J+8hyW40x/EsI9djOMH3F+kQrj/k8ljv7KzUhAk9T4zBLLz/y6nCUqV7T3aieOFUFRgy2UqGNv2xorR2BTb/ZXsfm8/yVeqiY952Yoc780MN6MLC+6BJd47wEVa+aU3Ql7Anqm+fvdcCSRbSIm86fUypY5f4hNL6utcSwo30ggIDUKVXoQNQBVo7oOF59jFeC+PrDm8jpdgweukCTWU0+Jq/yXkyDIbI+KbnwFCqcLKlgoCOrne77R+bHMpi6GT7NK4DvrihIJr5liB3FDAvaZN0GSJ23O2dp3J8B9c0nY0k+Bs4UcczkT+6AyAVdSOhAllTKitUyLkdvscbF/SrFpogRcNf/Cuinj5hkqrNzjQ5Bqp8ta5L/hEv6VyusTxjMrSUb0F/chV8q676V5MTlojg9RumVQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4250.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cd6205-ee4c-41bb-b0bf-08d85b9ef490
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 06:49:13.6680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4K06WG2iX44gXZV4UlX5E6vB5FEKiXhROiwHQwNzSzp3i9jXV5tQ5caDBd175LvYVUgiZyDGXcRcrbMHiTJBguBJshfWkQmOaykn0BaGlc2PSonSSkFZwgZt3Zsg5riE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4300
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Mark,
It is an ongoing patch handled by Vineetha(earlier PWM developer with IOTG)=
. I am filling the rest of the review comments after she has gone for her h=
igher Studies.=20

If required, let me push another thread internally for your review.
=20
Thanks,
Vijay=20
-----Original Message-----
From: mark gross <mgross@linux.intel.com>=20
Sent: Friday, 18 September, 2020 5:00 AM
To: Ayyathurai, Vijayakannan <vijayakannan.ayyathurai@intel.com>
Cc: thierry.reding@gmail.com; u.kleine-koenig@pengutronix.de; robh+dt@kerne=
l.org; linux-pwm@vger.kernel.org; devicetree@vger.kernel.org; Wan Mohamad, =
Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>; andriy.shevchenk=
o@linux.intel.com; Raja Subramanian, Lakshmi Bai <lakshmi.bai.raja.subraman=
ian@intel.com>
Subject: Re: [PATCH v7 0/2] Add PWM support for Intel Keem Bay SoC

Have I reviewed this yet?
are you waiting on feedback?
--mark

On Thu, Sep 10, 2020 at 12:27:17AM +0800, vijayakannan.ayyathurai@intel.com=
 wrote:
> From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
>=20
> Hi,
>=20
> This patch set enables support for PWM on the Intel Keem Bay SoC.
> Keem Bay is an ARM based SoC, and the GPIO module allows configuration=20
> of 6 PWM outputs.
>=20
> Patch 1 adds the PWM driver and Patch 2 is for the required Device=20
> Tree bindings documentation.
>=20
> This driver was tested on the Keem Bay evaluation module board.
>=20
> Thank you.
>=20
> Regards,
> Vijay
>=20
> Changes since v6:
> - Add reviewed-by tag
>=20
> Changes since v5:
> -Reorder symbols/Kconfig in drivers/pwm/Kconfig and=20
> drivers/pwm/Makefile -Use "Limitations" for consistency -Add=20
> clk_prepare_enable() -Reorder keembay_pwm_get_state() function call=20
> -Rework if conditional for channel disablement in .apply() -Remove=20
> channel disabling from .probe(), and clear LEADIN register bits in=20
> .apply instead -Update commit message for Patch 1
>=20
> Changes since v4:
> -Add co-developed-by tag
> -Include mod_devicetable.h and remove of.h -Update comment with=20
> correct calulation for high/low time -Fix missing return from=20
> dev_err_probe
>=20
> Changes since v3:
> -Removed variable for address and calculate in place instead -Utilized=20
> u32_replace_bits() when updating KMB_PWM_LEADIN_OFFSET -Utilized=20
> dev_err_probe() for error reporting -Updated comments to use physical=20
> units -Updated error check for pwmchip_add()
>=20
> Changes since v2:
> -Include documentation about HW limitation/behaviour -Use hex values=20
> for KMB_PWM_COUNT_MAX -Redefine register macros -Utilize=20
> FIELD_GET/FIELD_PREP for calculating pwm_l/h_count and pwm_count=20
> -Round up duty cycle/period values -Get current hardware state in=20
> .apply instead of cached values -Do a polarity check before .enabled=20
> -Round high time/low time to closest value -Set enable bit in=20
> KMB_PWM_LEADIN_OFFSET to 0 in probe -Correct the naming for=20
> MODULE_ALIAS -Add additionalProperties: false in DT bindings
>=20
> Changes since v1:
> -Updated licensing info, "clocks" property and example in DT bindings=20
> -Updated name of DT bindings document to match compatible string=20
> -Removed 1 patch for addition of new sysfs attribute "count"
> -Added support for COMPILE_TEST in Kconfig -Updated naming of defines=20
> and regmap attribute -Updated calculation of waveform high time and=20
> low time -Added range checking for waveform high/low time -Implemented=20
> .get_state -Removed register writes for lead-in and count values (left=20
> to default) -Updated register access to single-access -Folded=20
> keembay_pwm_enable/disable_channel,
> keembay_pwm_config_period/duty_cycle,
>  and keembay_pwm_config into keembay_pwm_apply -Updated error=20
> messages/error codes -Removed pwm_disable from keembay_pwm_remove=20
> -Removed clk_prepare/clk_enable/clk_disable from driver
>=20
> Lai, Poey Seng (1):
>   pwm: Add PWM driver for Intel Keem Bay
>=20
> Vineetha G. Jaya Kumaran (1):
>   dt-bindings: pwm: keembay: Add bindings for Intel Keem Bay PWM
>=20
> .../bindings/pwm/intel,keembay-pwm.yaml       |  47 ++++
>  drivers/pwm/Kconfig                           |   9 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-keembay.c                     | 232 ++++++++++++++++++
>  4 files changed, 289 insertions(+)
>  create mode 100644=20
> Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
>  create mode 100644 drivers/pwm/pwm-keembay.c
>=20
> --
> 2.17.1
>=20
