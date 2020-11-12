Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484712AFE5C
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 06:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgKLFhS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 00:37:18 -0500
Received: from mga01.intel.com ([192.55.52.88]:39945 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbgKLC7H (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 11 Nov 2020 21:59:07 -0500
IronPort-SDR: mZ8ctZu+Y9zc2llDSdCxk0P4MRrbsPPfMabFAzvKzL73QVyEpw5PG9xIPvhBIKs/bIdqkzyK94
 DN4tdYB7bpmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="188241480"
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="188241480"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 18:59:06 -0800
IronPort-SDR: C8X7eYjLXRnN+2774KIKXEsITHJHIR3GpfdU8cVRORfxRfsvGK+0qoZ0Qc733DQN1bcBuIyorV
 rN5bsbCTm/kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="530471966"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga006.fm.intel.com with ESMTP; 11 Nov 2020 18:59:05 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 11 Nov 2020 18:59:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 11 Nov 2020 18:59:05 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 11 Nov 2020 18:58:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZiijtA+a9lJHeeBhdzSLN02iOpNJh/Bis5NG81l2oA+M/JmltbTtiy0D/KO3rBWyaM2mN61kEeMbkCmAGWG+1LtnAmI76XtI0O2vf8tAapRb7S3QDc9zlTc2ldK3TundBQ9IDI373b8AGA/jmDtZUWv9fBltbJmKQVESQfD92EXtqfx0FzV5rbzfJprDwAiY9DIKoR3kKfM96KTddV/mm7McxJ3LfTArKyR4MWWieEjAIDH6F6hISjlKoWDhwxXiOUl62x/FF9yPjO5XKIFKt+TI1YN1I5+BoERfyZZsHvE9ZJrIqXz46vb7a/jxbCWjOr36AR/rM5ZNgkuah9Sgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okZbEkITqHBXgqEhlfNr7Nc2mxy3uAdCHszOD3CdPQA=;
 b=GQnci34GvJZsUjd+IsTu1fCvmXorjcn92NkNHv5XWlz4b+d78prG990P/VLFNcHzwVdGCoKhJXyKu135KC+20rMV58CAxwPTUsRXBCXPRx5nNYxV0LV7wbVl6CM4s6AqrcRTCzHRN88Y+Gmc/1zQNVCdIevZbu3hmW3sGp4fLKCwxRef7Fg1MNeBw95BwbS+d3P3d6PzL8nKmGpC6ZzonpngAlvgwWD2Y3nI8+0Y8elDKmjlVjD6+soixTRTSuuLfgwwhf81EQf52h5WskFxiwigR+464poSv3ta1TgzJkEbvTtJJP1O4GR5RxXc6fcTPIyMA4nhu2bDDS/yY2bntQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okZbEkITqHBXgqEhlfNr7Nc2mxy3uAdCHszOD3CdPQA=;
 b=Gu88jkKsOB8MboqpGOmjsIT2XNlv3qtwWzTakkG4MM47unc4oAToLYYj8Z8KJwIxvXjtwSBIsfkxPeJJRmpKEDltDoqea9c97vie51ZvTCnJtVib6DNoX8M7Z8qulRK7OyCwl+qo661kHE/ExIl52rnyu7EC1DcMA9W403+iXbw=
Received: from DM6PR11MB4250.namprd11.prod.outlook.com (2603:10b6:5:1df::18)
 by DM5PR1101MB2169.namprd11.prod.outlook.com (2603:10b6:4:51::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Thu, 12 Nov
 2020 02:58:56 +0000
Received: from DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::b90d:d053:9de6:e5ef]) by DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::b90d:d053:9de6:e5ef%4]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 02:58:56 +0000
From:   "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
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
Subject: RE: [PATCH v14 0/2] Add PWM support for Intel Keem Bay SoC
Thread-Topic: [PATCH v14 0/2] Add PWM support for Intel Keem Bay SoC
Thread-Index: AQHWqEHRgr8OjCFu0kqpA7xtcElo2KnDgCsAgABtJ/A=
Date:   Thu, 12 Nov 2020 02:58:56 +0000
Message-ID: <DM6PR11MB4250A872A2DDB8E7BBF28247FBE70@DM6PR11MB4250.namprd11.prod.outlook.com>
References: <cover.1603350036.git.vijayakannan.ayyathurai@intel.com>
 <20201111202214.GK6125@ulmo>
In-Reply-To: <20201111202214.GK6125@ulmo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.106.177.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 149a867e-1932-482c-54a3-08d886b6e56e
x-ms-traffictypediagnostic: DM5PR1101MB2169:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB2169C310F067B86822195DB3FBE70@DM5PR1101MB2169.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:142;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YtEialbVrTnLm5looYRrfQSEmyMy3ZhIhheZsUf2kvdLnegirTV5+o7oAqjW5IRVhGyWpnc0h0xR5ODjyIEsgJWPIO5r8JU8TSbs80I94nsmX9IzEKayXyqtVnzJ9O0gQLITfRtL0nlMHfcWxRyoJh5+sd2yJ5cKu+OquVR8QzHdmSuu1z3k4euDUKGzqfrx0RhD5vorBIbBHfA7+RQnlrvj1PV+IxaYKzvpamNrD/23qzw8Bg2a0X83tPH9oWKQq2NmhTKos8PJZFSJLI1grN/mk6XdUjk1lWSiqEOKfqn0YIGEBYmtl3Nu/ZKGcZNXSzEej3ybksV64sVqQ9lWiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4250.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(2906002)(478600001)(33656002)(66556008)(54906003)(53546011)(83380400001)(316002)(9686003)(55016002)(4326008)(66446008)(66946007)(71200400001)(8936002)(6916009)(5660300002)(7696005)(52536014)(26005)(76116006)(186003)(64756008)(8676002)(66476007)(86362001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: yVLCru5G47XT5/GlY31NDTC5Cswlao0Bq9xj8b2683NG6RerqPhu0r15yXe3VYlFhA59wljkS0vFF6wu+Nf7z3Nd/fE3Y5VEsp9UbNsR0ruXIyDNdidbGeDdN7EcYsatyO+2k8yWA8YgHwoiYqovTfWF0grM98DspZ/gac5XZ+29N/DZq2MAu7VocnnumrqtelCAO0uH45bSlYrlFjCS5grjwFd4DkivAa6iU9293Ps2Abhv97LNDh+rl06/I6axu0hq+DSVzPWSwP5b13hOngI3Nf5opblsrpZGFYquywyT2/9FHfc80H9ObXmmiGMmz9JKw9mTdQMISPJkRv0FlcmaoBavVGRTYddVqsHkkktFqAU+36APo+4WUDN7GYHzj2Qr7k/nBvJVgxL+5afGepbQcvDZjNo1gMnXhFfQ2OTIk5kkD+He/3PgAivRSbXiF1TDzHrlue+2PgyebYskHrkQdYEyMF85TLg1xaFjVJsh7qQf0XuwU6hvpOevZewUVbzzrtBw5t/cqoL1S3FG60Xyl7Kwxfx3t0cbnrgx3/szPCMyLhXI0s6+cZMExztMsVruvHRcfCocazSkrcgXDH7cF0rOX3RGmneJU9xY1I8pOqmlv1GID4gYG5DPBLTcmh3LqGh/K6Escc6et1gEFQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4250.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149a867e-1932-482c-54a3-08d886b6e56e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 02:58:56.2619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPOT+Cw0ny9HM50YalZHHa4TWrhIttvCr9S+j//sNBMzHaJtRg3ofgeFw3ehlfjP2cKdQEHorQJeWwH3G5JfKxnqM9KozQaUQsiMZB9ZaXFq7pSKGaxzfZKZJHDuk2S0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2169
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry,
Thanks for reviewing this patch.

> From: Thierry Reding <thierry.reding@gmail.com>
> Sent: Thursday, 12 November, 2020 4:22 AM
> To: Ayyathurai, Vijayakannan <vijayakannan.ayyathurai@intel.com>
> Cc: u.kleine-koenig@pengutronix.de; robh+dt@kernel.org; linux-
> pwm@vger.kernel.org; devicetree@vger.kernel.org; Wan Mohamad, Wan
> Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>;
> andriy.shevchenko@linux.intel.com; mgross@linux.intel.com; Raja
> Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>
> Subject: Re: [PATCH v14 0/2] Add PWM support for Intel Keem Bay SoC
>=20
> On Thu, Oct 22, 2020 at 03:14:45PM +0800,
> vijayakannan.ayyathurai@intel.com wrote:
> > From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> >
> > Hi,
> >
> > This patch set enables the support for PWM in the Intel Keem Bay SoC.
> > Keem Bay is an ARM based SoC, and the GPIO module allows
> > configuration of 6 PWM outputs.
> >
> > Patch 1 adds the PWM driver and Patch 2 is for the required
> > Device Tree bindings documentation.
> >
> > This driver was tested on the Keem Bay evaluation module board.
> >
> > Thank you.
> >
> > Regards,
> > Vijay
> >
> > Changes since v13:
> > - Fix indentation error in dt-binding.
> > - Add maintainer name in dt-binding.
> >
> > Changes since v12:
> > - Use devm_add_action_or_reset() as per Andy suggestion.
> > - Do the clk_prepare_enable() after all devm_ stuff as per Uwe suggesti=
on.
> > - Optimize keembay_pwm_remove function.
> > - Simplify the error handling for pwmchip_add.
> > - In Kconfig, Use depends on ARCH_KEEMBAY || (ARM64 &&
> COMPILE_TEST)
> > - Fix indentation error in dt-binding.
> > - Add Uwe's Reviewed-by tag and Vijay's Co-developed-by tag.
> >
> > Changes since v11:
> > - Minor variable name change to match the api needs.
> > - Setup polarity as PWM_POLARITY_NORMAL.
> > - Add comment for LEADIN register usage.
> >
> > Changes since v10:
> > - Update low time calculation formula as per Uwe.
> > - During distruct remove pwmchip first then disable the clock.
> >
> > Changes since v9:
> > - Remove Reported-by tag from the commit log.
> >
> > Changes since v8:
> > - Fix the compilation error reported by kernel test robot.
> > - Add the tag Reported-by: kernel test robot <lkp@intel.com>
> > - Minor correction in the pwm low time calculation formula.
> > - Rebase with 5.9-rc7
> >
> > Changes since v7:
> > - Change the dependency as ARCH_KEEMBAY instead of ARM64 in Kconfig.
> > - Use DIV_ROUND_DOWN_ULL instead of DIV_ROUND_CLOSEST_ULL.
> > - Update the right formula as per Uwe.
> > - List the tags in chronological order.
> > - Add clk_disable_unprepare in the error paths.
> >
> > Changes since v6:
> > - Add reviewed-by tag
> >
> > Changes since v5:
> > - Reorder symbols/Kconfig in drivers/pwm/Kconfig and
> drivers/pwm/Makefile
> > - Use "Limitations" for consistency
> > - Add clk_prepare_enable()
> > - Reorder keembay_pwm_get_state() function call
> > - Rework if conditional for channel disablement in .apply()
> > - Remove channel disabling from .probe(), and clear LEADIN register bit=
s
> >   in .apply instead
> > - Update commit message for Patch 1
> >
> > Changes since v4:
> > - Add co-developed-by tag
> > - Include mod_devicetable.h and remove of.h
> > - Update comment with correct calulation for high/low time
> > - Fix missing return from dev_err_probe
> >
> > Changes since v3:
> > - Removed variable for address and calculate in place instead
> > - Utilized u32_replace_bits() when updating KMB_PWM_LEADIN_OFFSET
> > - Utilized dev_err_probe() for error reporting
> > - Updated comments to use physical units
> > - Updated error check for pwmchip_add()
> >
> > Changes since v2:
> > - Include documentation about HW limitation/behaviour
> > - Use hex values for KMB_PWM_COUNT_MAX
> > - Redefine register macros
> > - Utilize FIELD_GET/FIELD_PREP for calculating pwm_l/h_count and
> >   pwm_count
> > - Round up duty cycle/period values
> > - Get current hardware state in .apply instead of cached values
> > - Do a polarity check before .enabled
> > - Round high time/low time to closest value
> > - Set enable bit in KMB_PWM_LEADIN_OFFSET to 0 in probe
> > - Correct the naming for MODULE_ALIAS
> > - Add additionalProperties: false in DT bindings
> >
> > Changes since v1:
> > - Updated licensing info, "clocks" property and example in DT bindings
> > - Updated name of DT bindings document to match compatible string
> > - Removed 1 patch for addition of new sysfs attribute "count"
> > - Added support for COMPILE_TEST in Kconfig
> > - Updated naming of defines and regmap attribute
> > - Updated calculation of waveform high time and low time
> > - Added range checking for waveform high/low time
> > - Implemented .get_state
> > - Removed register writes for lead-in and count values (left to default=
)
> > - Updated register access to single-access
> > - Folded keembay_pwm_enable/disable_channel,
> >   keembay_pwm_config_period/duty_cycle,
> >   and keembay_pwm_config into keembay_pwm_apply
> > - Updated error messages/error codes
> > - Removed pwm_disable from keembay_pwm_remove
> > - Removed clk_prepare/clk_enable/clk_disable from driver
> >
> > Lai, Poey Seng (1):
> >   pwm: Add PWM driver for Intel Keem Bay
> >
> > Vineetha G. Jaya Kumaran (1):
> >   dt-bindings: pwm: keembay: Add bindings for Intel Keem Bay PWM
> >
> >  .../bindings/pwm/intel,keembay-pwm.yaml       |  47 ++++
> >  drivers/pwm/Kconfig                           |   9 +
> >  drivers/pwm/Makefile                          |   1 +
> >  drivers/pwm/pwm-keembay.c                     | 240 ++++++++++++++++++
> >  4 files changed, 297 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
> >  create mode 100644 drivers/pwm/pwm-keembay.c
>=20
> Both patches applied, though I did change the ordering so that
> checkpatch doesn't complain about the compatible string not being
> defined. I also changed the -ENOSYS error code to -EINVAL for the
> unsupported polarity case because checkpatch doesn't like it when
> we use -ENOSYS other than for system calls.
>=20
> I'm also going to follow up with a patch that makes the return value
> more consistent for these cases in other drivers.

Thank you for your valuable time in fixing that.

>=20
> Thierry

Thanks,
Vijay
