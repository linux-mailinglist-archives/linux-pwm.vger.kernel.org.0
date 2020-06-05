Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661131EF997
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 15:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgFENtH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 09:49:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:43354 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgFENtG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 5 Jun 2020 09:49:06 -0400
IronPort-SDR: dj1Fqqvh0uxHFvjexo+hRKYVJGssAuxvT5L5t+Y8ebIpMSRit9BguUQENWPPMO3kNbNsUpIUpJ
 2pW6IBF1noGw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 06:49:05 -0700
IronPort-SDR: 8DDomgTBZ242f0sFIvOEXFj7cJDJBFhVLeOPBWS3Xxogs6AU01GhkzFdigllMmNLLV018ELpNk
 VXFMPcrGp/Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,476,1583222400"; 
   d="scan'208";a="294695736"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jun 2020 06:49:05 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 5 Jun 2020 06:49:05 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX157.amr.corp.intel.com (10.22.240.23) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 5 Jun 2020 06:49:04 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.55) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 5 Jun 2020 06:49:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+lrP59x/l1LCIW0IEkhc8MbYD2+jf2Uuxr0FhhtjNXC5VbFgwLiY0pjOhpjpxCsQB24tqJ4o+Hh+rgpzji49nTt6Zel6s5w/8sVrkto0sVZ33Yv5FjLjd+AOqIHCunK9QT5KqzLxKwmjNSKBY7qMZVK82xhM8V5DW/N+89iqEY8BaExT7V8bUMW5vy5trxF9XZjcwAtJFgASJP00ZelC+BicD8g8BRNz+w+2rf/OYA3hMcq5stMsDDe7lQXB2uRCTp2kuK4s3hPohCCbXasSu94N0t6YtTspp5InE1N9gC6KHz0G+Q3II14y9t564pZVEoFGXE/agyDrBD79xbw/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu/eMgqIKCwMcSCUYlCMzFRrVevxGn8YEyJubcAtx28=;
 b=Zhwv8Nyklwe4unFnH3kPoUeFfvEN5iYr7egIK1AoWxlzhOA8MfrCfi8WB/XEXnIxH+OdTh6L+vFkt20+g8T3odJMXIwUe852QextDiCafdpsFTOJM6k1wYeT1OAfNLTZVGRzPPictPX81YZRv9Ufr08UpOO9u5gdREhsUKvh+1trCLPSCAcVIPdyaFHX0EwdQOZdTZqnRy86F5b42ZnCH2QF5WPSD9iCmvKLNvVD60auehZl7vq1Q2pA1tZ+O0ohpXy+zVL8T8MvchOI5VCKUN85C1Hfn1C28fuujqVYYbhzOADLymcEBHjX4L8davTa3noRONdLatfYvjCLgUUW4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu/eMgqIKCwMcSCUYlCMzFRrVevxGn8YEyJubcAtx28=;
 b=Wst0X7lkL/PPOP0ux15PapT44am4JRllxgnWcVCNggrCxA/VxKX/NZsP4rOpeQWyeywsyPHpH4EYfEH2IOQx3uSEx1G8RlIvCIkr9fBVVAtvdFgtKRnyfxTO6iyl9ScPXT/flYBy10NfAYHyG3uM7JT58g2Iec4UzkrN20v/GBI=
Received: from SN6PR11MB2575.namprd11.prod.outlook.com (2603:10b6:805:57::20)
 by SN6PR11MB3197.namprd11.prod.outlook.com (2603:10b6:805:c5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 13:49:03 +0000
Received: from SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::24f3:9231:b6e0:a13d]) by SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::24f3:9231:b6e0:a13d%4]) with mapi id 15.20.3066.019; Fri, 5 Jun 2020
 13:49:03 +0000
From:   "G Jaya Kumaran, Vineetha" <vineetha.g.jaya.kumaran@intel.com>
To:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Subject: RE: [PATCH 1/3] pwm: Add count attribute in sysfs for Intel Keem Bay
Thread-Topic: [PATCH 1/3] pwm: Add count attribute in sysfs for Intel Keem Bay
Thread-Index: AQHWLFMz69MGEF4tMUSIKv62Av4Rmai2MxuAgBCecTA=
Date:   Fri, 5 Jun 2020 13:49:02 +0000
Message-ID: <SN6PR11MB257550F64750773C039956ECF6860@SN6PR11MB2575.namprd11.prod.outlook.com>
References: <1589723560-5734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1589723560-5734-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <20200523210525.5ciw3lyafbwr26qn@pengutronix.de>
In-Reply-To: <20200523210525.5ciw3lyafbwr26qn@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3d24b80-374f-461a-5757-08d809573528
x-ms-traffictypediagnostic: SN6PR11MB3197:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3197434263B6492760675C68F6860@SN6PR11MB3197.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0R+OnOmybzXcIEReAzzT8vorjLQajrmGhEGtTYoYBELaGVQfSDrOy9u+kmzGPOA26tXeRsi3HGHXss1Onzvl1Q645GFb+D6izf/wUzPky1DFL+ZOjawnBqvaHePdozBDYnya1l2R4Tb5yPj123Yh0GYq+Dfo4RKCKwzWocOr2TXPY9nD6yWWQbITDS3f1I6Vf5KTFjQTbzTvDRC1IW2truwJ4Psv1oLqsNYazVp7T8uijw1tnkGxLTrUugICByzaUvimwDL3crov+7msw9pN4Pn1iTG/bVpK4g06bco9Y6IaT31X7FP6noFu+JWsSkWFoU7sCoPM5WcnA382gk0GbVpTt94CsaUZ1YL2KPUlVXAx4oQ63p+eISeG3CdEiF9ob92xX9XKpdK/bX0nnfdeSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2575.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(376002)(346002)(396003)(136003)(8936002)(83380400001)(8676002)(316002)(76116006)(66946007)(71200400001)(478600001)(54906003)(66476007)(66446008)(4326008)(64756008)(66556008)(2906002)(966005)(55016002)(7696005)(186003)(86362001)(66574014)(26005)(33656002)(53546011)(83080400001)(9686003)(6506007)(5660300002)(6916009)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pExUh17mUKxPXm+Sgv7hb0NWYYFg5QqyX6AWUdz+5erepUj6rJ3/HaESfuXHaPiVbnQm8qVjw1QpcZVy+1jc25B4wTky8sbmQMNdoKm/0BU9jP2wr2rHAG9kqzHmSK3e8XDBsWNpip7wG9PCOsMGDZ8hPLoa004MBtf4ifp7dTzsSS/h5Zg6yECEAR8bHyAsPuEyH64XOAzoO86siBuOA3c7HWBSk8V5IDCBHi2gw8K+81f6UcbnW9qfayCW4n4O7K3P7fRt5+NFNvw+ds5m98UCpESlV25nNtflhx1btjhphQR9HD1DtrlonvjXQJ0h2o2aqjAKN6HPrVV1TNGnyMr6Mo+y7ITPLmN9zWCPNbNlYGFF5SbPQ8Z2JY67vhrLi8qthtu053rHzBZVQpC4oC4qldaThHd+p+hdHDByzq4qH+ptPw4fY+/RqqMulvDvvjDd4qyip2J61IA2L2ZYtY8DfmQrBcFWC5rDCUvARaT9fSj13R1klWPi4ymAatBD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d24b80-374f-461a-5757-08d809573528
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 13:49:02.9787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0cZIt0o0H1HW6a8V8KDKLQxKMisFBPQ1qVr5B0lQvv4Gyf2NWMsq4lk4EG9/oocChm6qwKq+5ONWKJLh6MYnZtOdeIdyTqmHBYPxzeaMyeyPxBIiBHPyJBFi6t8hFDlY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3197
X-OriginatorOrg: intel.com
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


> -----Original Message-----
> From: linux-pwm-owner@vger.kernel.org <linux-pwm-owner@vger.kernel.org>
> On Behalf Of Uwe Kleine-K=F6nig
> Sent: Sunday, May 24, 2020 5:05 AM
> To: G Jaya Kumaran, Vineetha <vineetha.g.jaya.kumaran@intel.com>
> Cc: thierry.reding@gmail.com; robh+dt@kernel.org; linux-
> pwm@vger.kernel.org; devicetree@vger.kernel.org; Wan Mohamad, Wan
> Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>; Shevchenko,
> Andriy <andriy.shevchenko@intel.com>
> Subject: Re: [PATCH 1/3] pwm: Add count attribute in sysfs for Intel Keem=
 Bay
>=20
> On Sun, May 17, 2020 at 09:52:38PM +0800,
> vineetha.g.jaya.kumaran@intel.com wrote:
> > From: "Lai, Poey Seng" <poey.seng.lai@intel.com>
> >
> > In Keem Bay, the number of repetitions for the period/waveform can be
> > configured from userspace. This requires addition of a sysfs attribute
> > to get/set the repetition count. Setting this value to 0 will result
> > in continuous repetition of the waveform until the channel is disabled
> > or reconfigured.
>=20
> There is nothing specific for Keem Bay in this patch, the only special th=
ing here is
> that this driver is the first implementor.
>=20
> IMHO all drivers that don't support count should be changed to fail if a =
count > 0
> is passed and introducing support in the sysfs interface should be a sepa=
rate
> change.
>=20
> Having said that I'm not convinced this is a good idea given that only ve=
ry few
> driver can support this interface. Also this needs documentation, e.g. wh=
at is
> expected from .get_state().
>=20
> You should also motivate what this functionality is used for in the commi=
t log
> and I'd prefer to see an in-tree user (apart from sysfs which I don't cou=
nt as
> such).
>=20

Agreed, the wording used here is not accurate as this is not specific for K=
eem Bay.
Before submitting v2, I will cross-check about the use-case for this functi=
onality, and if it=20
can be implemented in some other less intrusive way to the framework (perha=
ps via a DT property?)

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
