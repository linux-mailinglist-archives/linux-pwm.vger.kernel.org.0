Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301442848E0
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Oct 2020 10:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgJFI62 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Oct 2020 04:58:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:38346 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJFI62 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 6 Oct 2020 04:58:28 -0400
IronPort-SDR: VfX6lBpPdxbxDSP/q6axiU5beG73LSHc00F3krHTH32A5pLKa3ixEum0xd0od9FBgjkgwS5u4X
 mDQyHqzhPgjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="228552299"
X-IronPort-AV: E=Sophos;i="5.77,342,1596524400"; 
   d="scan'208";a="228552299"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 01:58:26 -0700
IronPort-SDR: 4+rdhvDsCqGBQ6cPuaW258DC+HESF8WOqnUadj0eUZzRKTzggS8K4U+ADXPyRyLXehFswtp8m4
 cgkTQRQkFPPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,342,1596524400"; 
   d="scan'208";a="348375630"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 06 Oct 2020 01:58:26 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 6 Oct 2020 01:58:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 6 Oct 2020 01:58:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 6 Oct 2020 01:58:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nw8h+mdzGz8AJmhd3jXh/veis4bYUsIGwACmxytKVmyZaZERTEHrVvgqkzUuBSA9e8fa2dJUM5ILfmmGFR5CspqIyLiBRgUhkv292IuIBkLYaAnMHpaB6nYm+0NPUC6Lois54PgGyWXI+dp74ReB81w4N9xcrHzr2QZLKuYyn+Ye7zx1qNS1RARj1EfQKn28jWzPYPKIFRovlOEEcbEqVGEuB0a0yNxqdpVfhvm7z7OzcjJtXZjfwYk6W/3H6mqndgQbIIPvIzf+TXPefHKqTcGSLMryf5TH5KDvMuYPHRhVojIqPc6XPhfJFDduomWQPt+az1ClxUX2ek8CTusjrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=id2eORmQq3WuCCUclwJSYwELx4r8McUBGDlQxPW4xzg=;
 b=elmU3KEZX77rGzXfwUhBclfOtbGe5fr9VX6gqlHKNIbNInNYvh9205KlsV4GmPiKMVUuPUggWtgoeLbsnJDfAjqUClIOU4cvIikWH2g8VHHceN5WspMrmyLUwN3DFvbUGfuEkXvNdFoU3Zt+LyjdlkoGYTHc+F8Bf9kkboNdjtGphXwpXATHwTzZWfp1ZDVu8R+Ghc5h0PKU7JvIoYTccTRXnpt2h/avnVX04QZZPcTd9fZM98umaXjU2IV0DSTP/2eeDsmwu9rgYvhmdIDPJOgqqZgjYuopyTKDQ5Lp+LSOkZWl/g/9ck/tj1oQs5FSyReaGffuJGSaPYANeZnDGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=id2eORmQq3WuCCUclwJSYwELx4r8McUBGDlQxPW4xzg=;
 b=S4GEHvBBQqXjepsHCAgcob+9liOYTr7eTFiIDzhEr9bDbuW1wt7wh0O4UgP+gOUDgaKF1A4SNwIHK5Di4q9eMjF96xIf000CmX+Anhtsh2zimy74zmwYaKAFqi4zyX/L7E8CjmSvm8EW3rGCakl1/IY4hUFzYh+7avMTmLjXEPI=
Received: from DM6PR11MB4250.namprd11.prod.outlook.com (2603:10b6:5:1df::18)
 by DM6PR11MB2732.namprd11.prod.outlook.com (2603:10b6:5:be::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.43; Tue, 6 Oct
 2020 08:58:23 +0000
Received: from DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::7448:c067:e80d:3c09]) by DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::7448:c067:e80d:3c09%3]) with mapi id 15.20.3433.045; Tue, 6 Oct 2020
 08:58:23 +0000
From:   "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
Subject: RE: [PATCH v9 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Topic: [PATCH v9 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Index: AQHWl7Vf+0cewMeXH0CpZx9T41JpCqmChbWAgAfF+vA=
Date:   Tue, 6 Oct 2020 08:58:22 +0000
Message-ID: <DM6PR11MB4250F66DD7EEF69CECDB9198FB0D0@DM6PR11MB4250.namprd11.prod.outlook.com>
References: <20201001053751.10405-1-vijayakannan.ayyathurai@intel.com>
 <20201001053751.10405-2-vijayakannan.ayyathurai@intel.com>
 <20201001100643.GA3956970@smile.fi.intel.com>
In-Reply-To: <20201001100643.GA3956970@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.111.138.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60908414-26c4-4883-f4ba-08d869d5faf0
x-ms-traffictypediagnostic: DM6PR11MB2732:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB273288BECC5AF99D4B37071DFB0D0@DM6PR11MB2732.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2aJksWD/1nO7wrxOBTZidWWDcCE0Q7iqyd9pWGExq0dbDNhRKV2/a+0Og7V8HKI73pIQNhvLr/gvMuWVNfVf3YKft3cSeFCn4jGnz9n13eMeCM1VtWybT4ifKlyyP84RPnlKDHdfHxQnRoBhRE/RkraYBssA7hNfZ+3+RF1jtksqFQMxNvnBvbD2KTK1nsNTOMr+eUmGCp03gGGIOA34Oc3a5rO2rOpKbmQV8R7EC3XkbgtyiI4+/uJhGWyVoGdGblwcUh9GmNZ9sTm5U0bzkFIOQSPePOKuP2HOQnh1GPRyHdEs3C/Vql6DFR4ixa5NrgyNOcEhCLiOqdKjinrcgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4250.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(33656002)(66476007)(66946007)(64756008)(66556008)(66446008)(4326008)(186003)(8936002)(83380400001)(316002)(478600001)(26005)(76116006)(55016002)(9686003)(52536014)(5660300002)(8676002)(54906003)(86362001)(110136005)(7696005)(2906002)(53546011)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: sk1HI7f9m/F5EwLu+qABWVdDJnnf91RL4eBvt4Lxb3wvO3GWtukfVoipVKci8gA1CTscMl6gLlE90MB6CbUk60m5CAycTokk+Q1ZmDPeoftVPL5jJCLmySXX0HEI4KbbOd+C1GUYR1ZVKo8nkSuGttWi9M4cvPRj7pkYa989gI6OluG/1BD3ArpHzp+6/FPB2D9sokKLJ2Qox3tW3iU+9MGUlsVqCz4NrlZqXdFUb/0IqypJRMwPSyBZ/eSqIrfHKeiYTijHA0dRH5mNfdzm4Tp+l7wTgFMXVwxQuqc9yvQovph+JqSp6nUJEnPDooEHVo4RwyekFm0SZSh88dWbhnjWLji1QubMbRY2TrbU35n1ck57SHfBJUD9D0GDMWEw+wUJ/0zRJEn2IwTtuncENZKATaiNXtfm/Lu1ps5nx6wNPOpNVJS/azYBarM67F+rzEw9VN3pNCBPS5vnm66ngM+6kiLOdfdAPhEPIZ1IwFqPBB/30qs9YD7Xl5A8zEgg4OkxPkb5L9WefGo0EscgrynLI9trdYStfOHmuGQe9x/XTezL3eX/WTAw8E8SWV2/FlJp0zReeNRfzj1feUmIdxLe+T9MNiPpGT8KbhJ0HKK9AfMuSAfpgaf/ni8htrd/txvrJqEsrKkpIFK9/ZmhZg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4250.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60908414-26c4-4883-f4ba-08d869d5faf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 08:58:22.8682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y5QOZ2hz+x3Y8y8P5Op3xXnHHNMPfSA8AG+gIoWk18Kro4yw1GmWkXT2Z0UFbFQlTqrsIrDI+7AgjIUlETUSVU8J5MSTX6APcs9EV5GLFkU5JsfTfvTuGu1Qhd1Fe9jO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2732
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Andy and Uwe,

-----Original Message-----
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=20
Sent: Thursday, 1 October, 2020 3:37 PM
To: Ayyathurai, Vijayakannan <vijayakannan.ayyathurai@intel.com>
Cc: thierry.reding@gmail.com; u.kleine-koenig@pengutronix.de; robh+dt@kerne=
l.org; linux-pwm@vger.kernel.org; devicetree@vger.kernel.org; Wan Mohamad, =
Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>; mgross@linux.int=
el.com; Raja Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.c=
om>
Subject: Re: [PATCH v9 1/2] pwm: Add PWM driver for Intel Keem Bay

On Thu, Oct 01, 2020 at 01:37:50PM +0800, vijayakannan.ayyathurai@intel.com=
 wrote:
> From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
>=20
> The Intel Keem Bay SoC requires PWM support.
> Add the pwm-keembay driver to enable this.
>=20
> Signed-off-by: Lai, Poey Seng <poey.seng.lai@intel.com>
> Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.co=
m>
> Co-developed-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.=
com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com=
>

> Reported-by: kernel test robot <lkp@intel.com>

No, the absence of the driver is not what was reported.
If you wish to give a credit to LKP, use changelog for that.

Sure. Let me keep the tag only in the changelog.=20
Also kindly let me know if there is further feedback related to this patch =
before I push the next version.

--=20
With Best Regards,
Andy Shevchenko

Thanks,
Vijay

