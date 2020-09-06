Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1F525ED7B
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Sep 2020 11:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgIFJWQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 6 Sep 2020 05:22:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:31326 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgIFJWO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 6 Sep 2020 05:22:14 -0400
IronPort-SDR: /wYJs3ZxXNw35PRnrwnvqcqapgwNhSWjtvVaOjnE9C8i8CydGxmPasAHfOYR7R7GdQjN+Kx/Uw
 6tw6vykAS9/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9735"; a="155303638"
X-IronPort-AV: E=Sophos;i="5.76,397,1592895600"; 
   d="scan'208";a="155303638"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2020 02:22:13 -0700
IronPort-SDR: SkAZIVl2BGwFu37A7u8zfLcl2Bh01qpVN6snoGThCbUWG06tcvpBHoA0bnQVRFRvDX+MfirM9W
 N6zd7yxNtC3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,397,1592895600"; 
   d="scan'208";a="316499121"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 06 Sep 2020 02:22:13 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 6 Sep 2020 02:22:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 6 Sep 2020 02:22:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.59) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 6 Sep 2020 02:22:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrzBwX/ZOA4h/OwrHuftoIzwqrhVY6QDkVlNw1R+5rh9kubS2fl4SDjhNOlkibsRk62Od/rycCK4Pawb7TxCtrL3N7yLZi2qsceRgKhBqnmNlCX7hW81V3+IA1IpW0TT4JwWj13pkO/055VHl3Axzat5eDiT8FtZ+RBxncclZMPN3zRoNLl891NoXQwauQ4Wiy6xTbl7I1HtXi3x7I/3zw95dBvqLKXSUOTi0rmCuCCmqqMGG1cOkQu2liISjiI0rS/9aAtNxu5YQBcDJNBNFA0m1BKxnC6TtAi7HGPE7Ajrat7q6EuSBpB8brWe1jOy0pzuQ7xyjXIRus3ExkP9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypBbkeqMtmZsydrWV8HuTaH4jYlLCsBfNTylTkANo1k=;
 b=BRwlC8UHtxHgqRrVUHfUHzHyrDo6rjeAPcEfeeOZV0Z0hlJKHXLgyLCVyXN108FJThb8O+jbujuAyBL6TCPBtml0NB0CZqroolH8ylqVNxyIK5/OUS1AeDc9e2z75nXe1kAz0JyHdZmAIXXHXbootW9j3j8dAma9ICj6ZLTWr7vZK6IGViolB03T8maVUiIgIEg0xrpC1tbI0Un9BadsUDgJ+OlNhtVPxRKpW5gXhuAw8TJtSdeV/ajRkgcnpvTHRWvoK/Jg0XUmWGGN/VQthMW7GM08FsIPttnn9huIZpb8ts7KSWhkyfiLGZysk+h9TtRbUN2gADPmwBukjYvJig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypBbkeqMtmZsydrWV8HuTaH4jYlLCsBfNTylTkANo1k=;
 b=E+x4jpM78Is5pF00x4Ez7thc41byNM3P+67Lji/Cy6cYsfkupPFUhDPJVIU+TAL/lOtlioJjkyH/3/UIxMhMOp397ZmtiSIQ3MOaLL6GHzHaz1rDH3bCiYLqbsqvRfdxVMpDLcILO3dpqrtBEOCIVFO9J89My2O3Uo26B0isegg=
Received: from SN6PR11MB2575.namprd11.prod.outlook.com (2603:10b6:805:57::20)
 by SN6PR11MB2880.namprd11.prod.outlook.com (2603:10b6:805:58::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Sun, 6 Sep
 2020 09:22:09 +0000
Received: from SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::6407:40fd:19e3:e270]) by SN6PR11MB2575.namprd11.prod.outlook.com
 ([fe80::6407:40fd:19e3:e270%7]) with mapi id 15.20.3326.025; Sun, 6 Sep 2020
 09:22:08 +0000
From:   "G Jaya Kumaran, Vineetha" <vineetha.g.jaya.kumaran@intel.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
Subject: RE: [PATCH v5 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Topic: [PATCH v5 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Index: AQHWe5OG7Z7IhOoQU0eHxYJS7P1m0qlU7J6AgALcMRCAATNTAIAA91WA
Date:   Sun, 6 Sep 2020 09:22:08 +0000
Message-ID: <SN6PR11MB25753C0C4D98914DC5249709F62B0@SN6PR11MB2575.namprd11.prod.outlook.com>
References: <1598437559-25828-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1598437559-25828-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <20200902062543.hf5resp6yci2zojc@pengutronix.de>
 <SN6PR11MB257504DDA3FA499D6740FD0FF62D0@SN6PR11MB2575.namprd11.prod.outlook.com>
 <20200904202618.m72jkoco75zunabi@pengutronix.de>
In-Reply-To: <20200904202618.m72jkoco75zunabi@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [161.142.240.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ee21d30-60f3-4c47-3b9d-08d852465461
x-ms-traffictypediagnostic: SN6PR11MB2880:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB28806A4838BED27E7564FE7DF62B0@SN6PR11MB2880.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +T2mqGMglLGvE88Kc0F7pRM9HIlavDCfiH7nC3QECDQBi9/u88NHRDfLNSiH6k9JYnmj5VEbP93VhngDL0Ud5UiP78UQDGGUZ9vSFLslSXNtgmtTLsCtach+amxKKdDvQnTbknvMbBoEUkHDJ4w4q5/ajsMFusKctzjmdKjHfwUdNjU1Hl+wn3CGk7bIGgUkOBVhf6h7aPB7oAKOSmnZwDCyLAXi5NcimG2dxwIhDlmOQ2QJFmBMcjB3Sc2Pi3Vq4TC5hd+esPR1/jUOWj7xiG5FnF7YTq6PzbKohWlBYZeQuEtv8ad+dHGuDb179SqEm8WHCmbXbhCZAV0DDQER6DGwV8FOODp+5li0xyPtEGyKmmGREOEpVXvogG+J6EUCcspyCznTWW2w0KKvW9YvzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2575.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(4326008)(54906003)(83380400001)(66446008)(66946007)(66556008)(66476007)(64756008)(76116006)(52536014)(8936002)(83080400001)(2906002)(26005)(6506007)(9686003)(66574015)(53546011)(6916009)(186003)(316002)(5660300002)(7696005)(86362001)(55016002)(33656002)(8676002)(71200400001)(478600001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: IGBcrSwmUafumD1rfLCCJCyjEAYjKqgjhaIFD+DQ8wiJAPQul7WIDZbplkhoEERGWWZJ6lvSKbR/1v0F+xFUEAUmU7HbhoE4mMZoDppRbB+ZXXmaOcS2EKIR1/M9JFjjkQhRmpFnmm/A/Ag0SQGSebyhZigm0W2rEamfOHAlkBDKqB5gj9Kf5IZqr3NxoLPesLs7v/GbVWxU033+fQpHomDbjbCXTOwor271lS2pHJrloiuEelsUsrvosfb6epXo600iN4UMUBe1e9Azec9YCZ2sRF+aNC/BwQb7LQZxh/q/8SQK7ypTqNMe6cs+4A/xfES19VZaPMq3Uj0YhykGQtQige8VCrasuvA+gEkwqcRAQqM2B4lDluaWmzaCSj0qqepZwBHiX97nRBVsUQU6tS1prdeEgfncSr9r8IAcFQbQsrUF17XTfSj45VV2nlRWgZKQ+wZNnnkGTxYWvA+nJx7KoZMhA6fHeOFVK9jF93E1WmRbWVZ5TKa8Mk7fiLbOyFBDuYU8HpilGHJH/WSwzAUabeal6bCrqaLGrR6wDLUyvN/u3dl1jIkwOowuRJOR/X35GdQV/c5i2DNFHcJ4ziaRvuDzlNBzAK/ZvEL4UCSUXMDzXUOn6XBaETsZXRvLbt5BDVML9ukWjrJjGojebA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2575.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee21d30-60f3-4c47-3b9d-08d852465461
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2020 09:22:08.7463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EtAN8xqRECdZbibvauhJl7LA4+Fwv66q/Xhm1ZrosLLdvUM1A/5Vub4G0rYHfc2DEFCFsLRQFujy5CHd9N0kjaNWSFHvXr/MRTZ6jaJUYFYTBpXL2rFLDjZ2fDw0bzyQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2880
X-OriginatorOrg: intel.com
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> -----Original Message-----
> From: linux-pwm-owner@vger.kernel.org <linux-pwm-
> owner@vger.kernel.org> On Behalf Of Uwe Kleine-K=F6nig
> Sent: Saturday, September 5, 2020 4:26 AM
> To: G Jaya Kumaran, Vineetha <vineetha.g.jaya.kumaran@intel.com>
> Cc: thierry.reding@gmail.com; robh+dt@kernel.org; linux-
> pwm@vger.kernel.org; devicetree@vger.kernel.org; Wan Mohamad, Wan
> Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>;
> andriy.shevchenko@linux.intel.com; Raja Subramanian, Lakshmi Bai
> <lakshmi.bai.raja.subramanian@intel.com>; mgross@linux.intel.com;
> Ayyathurai, Vijayakannan <vijayakannan.ayyathurai@intel.com>
> Subject: Re: [PATCH v5 1/2] pwm: Add PWM driver for Intel Keem Bay
>=20
> Hello,
>=20
> On Fri, Sep 04, 2020 at 09:42:37AM +0000, G Jaya Kumaran, Vineetha wrote:
> > > > +	clk_rate =3D clk_get_rate(priv->clk);
> > >
> > > clk_get_rate() must only be called when the clock is enabled. Unless
> > > I miss something this isn't ensured here.
> >
> > My understanding is this would not be a problem, as according to
> > databook, the GPIO block clock is auto-enabled, and also we are not
> > doing any disabling in the driver for it.
>=20
> It might not be a problem on your hardware today. But this is an API
> requirement.
>=20

OK, will add clock enablement before using clk_get_rate().

> > > > +	 * The upper 16 bits of the KMB_PWM_HIGHLOW_OFFSET register
> contain
> > > > +	 * the high time of the waveform, while the last 16 bits contain
> > > > +	 * the low time of the waveform, in terms of clock cycles.
> > > > +	 *
> > > > +	 * high time =3D clock rate * duty cycle
> > > > +	 * low time =3D  clock rate * (period - duty cycle)
> > > > +	 *
> > > > +	 * e.g. For period 50us, duty cycle 30us, and clock rate 500MHz:
> > > > +	 * high time =3D 500MHz * 30us =3D 0x3A98
> > > > +	 * low time =3D 500MHz * 20us =3D 0x2710
> > > > +	 * Value written to KMB_PWM_HIGHLOW_OFFSET =3D 0x3A982710
> > > > +	 */
> > > > +
> > > > +	clk_rate =3D clk_get_rate(priv->clk);
> > > > +
> > > > +	/* Configure waveform high time */
> > > > +	div =3D clk_rate * state->duty_cycle;
> > >
> > > Since v5.9-rc1 (commit a9d887dc1c60ed67f2271d66560cdcf864c4a578)
> > > state->duty_cycle is a 64 bit type. So div being unsigned long isn't
> > > big enough on some platforms.
> >
> > div is 64-bit here, so I guess I can keep it as is?
>=20
> unsigned long isn't 64 bits wide on all platforms.
>=20

Sorry, I meant I would keep it as is since div is an unsigned long long her=
e, not an unsigned long.

> > > > +	/* Ensure enable bit for each channel is cleared at boot */
> > > > +	for (ch =3D 0; ch < KMB_TOTAL_PWM_CHANNELS; ch++)
> > > > +		keembay_pwm_disable(priv, ch);
> > >
> > > .probe() is not supposed to change the state of the PWM.
> > >
> >
> > Sorry, I think misunderstood one of your comments in V2 and added this.
> > The reset value of the enable bit (and all other bits) in the LEADIN re=
gister
> is 0, so this may not be needed.
> > If it's ok, I'll remove it.
>=20
> I think the right approach is to set the LEADIN register to 0 in .apply()=
.
>=20

Okay, will do this.

> Best regards
> Uwe
>=20

Thank you,
Vineetha

> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
